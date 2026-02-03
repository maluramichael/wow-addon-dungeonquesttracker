local addonName, addon = ...
local DungeonQuestTracker = addon

local AceGUI = LibStub("AceGUI-3.0")

local mainFrame = nil
local currentTab = "tbc1"

-- Status icons
local STATUS_ICONS = {
    completed   = "|cff00ff00[x]|r",
    in_progress = "|cffffff00[~]|r",
    not_started = "|cffff4444[ ]|r",
}

function DungeonQuestTracker:ToggleUI()
    if mainFrame and mainFrame:IsShown() then
        mainFrame:Hide()
    else
        self:ShowUI()
    end
end

function DungeonQuestTracker:ShowUI()
    if mainFrame then
        self:InvalidateCache()
        self:RefreshUI()
        mainFrame:Show()
        return
    end

    mainFrame = AceGUI:Create("Frame")
    mainFrame:SetTitle("DungeonQuestTracker")
    mainFrame:SetStatusText("Track dungeon quest completion")
    mainFrame:SetLayout("Fill")
    mainFrame:SetWidth(650)
    mainFrame:SetHeight(550)
    mainFrame:SetCallback("OnClose", function(widget)
        widget:Hide()
    end)

    -- Build tab list from TAB_DEFINITIONS
    local tabs = {}
    for _, tabDef in ipairs(self.TAB_DEFINITIONS) do
        table.insert(tabs, { text = tabDef.text, value = tabDef.value })
    end

    local tabGroup = AceGUI:Create("TabGroup")
    tabGroup:SetLayout("Fill")
    tabGroup:SetTabs(tabs)
    tabGroup:SetCallback("OnGroupSelected", function(container, event, group)
        currentTab = group
        self.db.profile.lastTab = group
        self:RefreshTabContent(container, group)
    end)

    mainFrame:AddChild(tabGroup)

    -- Restore last tab or default
    local lastTab = self.db.profile.lastTab or "tbc1"
    currentTab = lastTab
    tabGroup:SelectTab(lastTab)

    self.tabGroup = tabGroup
end

function DungeonQuestTracker:RefreshUI()
    if self.tabGroup then
        self:RefreshTabContent(self.tabGroup, currentTab)
    end
end

function DungeonQuestTracker:RefreshTabContent(container, tab)
    container:ReleaseChildren()

    local scroll = AceGUI:Create("ScrollFrame")
    scroll:SetLayout("Flow")
    scroll:SetFullWidth(true)
    scroll:SetFullHeight(true)
    container:AddChild(scroll)

    if tab == "summary" then
        self:DrawSummaryTab(scroll)
        return
    end

    -- Find the tab definition
    local tabDef = nil
    for _, def in ipairs(self.TAB_DEFINITIONS) do
        if def.value == tab then
            tabDef = def
            break
        end
    end

    if not tabDef then return end

    -- Draw dungeons for each complex in this tab
    for _, complexName in ipairs(tabDef.complexes) do
        for _, complex in ipairs(self.DUNGEON_DATA) do
            if complex.complex == complexName then
                self:DrawComplex(scroll, complex)
            end
        end
    end
end

function DungeonQuestTracker:DrawComplex(container, complex)
    for _, dungeon in ipairs(complex.dungeons) do
        local total, completed, inProgress = self:GetDungeonStats(dungeon)

        -- Skip fully completed dungeons if option is off
        if total == 0 then
            -- No visible quests for this dungeon, skip
        elseif completed == total and not self.db.profile.showCompletedDungeons then
            -- Skip completed dungeon
        else
            self:DrawDungeon(container, dungeon, total, completed, inProgress)
        end
    end
end

function DungeonQuestTracker:DrawDungeon(container, dungeon, total, completed, inProgress)
    -- Color the completion count
    local color
    if completed == total then
        color = "00ff00"
    elseif completed > 0 or inProgress > 0 then
        color = "ffff00"
    else
        color = "ff4444"
    end

    local title = string.format("%s |cff%s(%d/%d)|r", dungeon.name, color, completed, total)

    local group = AceGUI:Create("InlineGroup")
    group:SetTitle(title)
    group:SetFullWidth(true)
    group:SetLayout("List")
    container:AddChild(group)

    for _, quest in ipairs(dungeon.quests) do
        if self:ShouldShowQuest(quest) then
            self:DrawQuestRow(group, quest, false)

            -- Draw prerequisites indented
            if self.db.profile.showPrerequisites and quest.prerequisites and #quest.prerequisites > 0 then
                for _, prereq in ipairs(quest.prerequisites) do
                    self:DrawPrereqRow(group, prereq)
                end
            end
        end
    end
end

function DungeonQuestTracker:DrawQuestRow(container, quest, isPrereq)
    local status = self:GetQuestStatus(quest.questId)
    local icon = STATUS_ICONS[status] or STATUS_ICONS.not_started

    local heroicTag = ""
    if quest.heroic then
        heroicTag = " |cffff8800[Heroic]|r"
    end

    local factionTag = ""
    if not self.db.profile.showOnlyCurrentFaction and quest.faction ~= "Both" then
        if quest.faction == "Alliance" then
            factionTag = " |cff0070dd[A]|r"
        else
            factionTag = " |cffff2020[H]|r"
        end
    end

    -- Quest name color based on status
    local nameColor
    if status == "completed" then
        nameColor = "888888"
    elseif status == "in_progress" then
        nameColor = "ffffff"
    else
        nameColor = "ffffff"
    end

    local text = string.format("%s |cff%s%s|r%s%s",
        icon, nameColor, quest.name, heroicTag, factionTag)

    -- Create interactive label with link button
    local row = AceGUI:Create("InteractiveLabel")
    row:SetText(text)
    row:SetFullWidth(true)
    row:SetCallback("OnClick", function()
        self:ShowWowheadLink(quest.questId, quest.name)
    end)
    row:SetCallback("OnEnter", function(widget)
        GameTooltip:SetOwner(widget.frame, "ANCHOR_TOPRIGHT")
        GameTooltip:AddLine(quest.name)
        GameTooltip:AddLine(string.format("Quest ID: %d", quest.questId), 1, 1, 1)
        if quest.heroic then
            GameTooltip:AddLine("Requires Heroic difficulty", 1, 0.5, 0)
        end
        if quest.faction ~= "Both" then
            GameTooltip:AddLine(string.format("Faction: %s", quest.faction), 1, 1, 1)
        end
        GameTooltip:AddLine(" ")
        GameTooltip:AddLine("|cff00ff00Click|r to copy Wowhead link", 0.5, 0.5, 0.5)
        GameTooltip:Show()
    end)
    row:SetCallback("OnLeave", function()
        GameTooltip:Hide()
    end)

    container:AddChild(row)
end

function DungeonQuestTracker:DrawPrereqRow(container, prereq)
    local status = self:GetQuestStatus(prereq.questId)
    local icon = STATUS_ICONS[status] or STATUS_ICONS.not_started

    local nameColor = status == "completed" and "888888" or "cccccc"

    local text = string.format("     %s |cff%sPre: %s|r", icon, nameColor, prereq.name)

    local row = AceGUI:Create("InteractiveLabel")
    row:SetText(text)
    row:SetFullWidth(true)
    row:SetCallback("OnClick", function()
        self:ShowWowheadLink(prereq.questId, prereq.name)
    end)
    row:SetCallback("OnEnter", function(widget)
        GameTooltip:SetOwner(widget.frame, "ANCHOR_TOPRIGHT")
        GameTooltip:AddLine(prereq.name)
        GameTooltip:AddLine("Prerequisite quest", 1, 0.82, 0)
        GameTooltip:AddLine(string.format("Quest ID: %d", prereq.questId), 1, 1, 1)
        GameTooltip:AddLine(" ")
        GameTooltip:AddLine("|cff00ff00Click|r to copy Wowhead link", 0.5, 0.5, 0.5)
        GameTooltip:Show()
    end)
    row:SetCallback("OnLeave", function()
        GameTooltip:Hide()
    end)

    container:AddChild(row)
end

function DungeonQuestTracker:ShowWowheadLink(questId, questName)
    local url = string.format("https://www.wowhead.com/tbc/quest=%d", questId)

    -- Create a popup with a copyable link
    if not self.linkFrame then
        local frame = CreateFrame("Frame", "DQTLinkFrame", UIParent, "BasicFrameTemplateWithInset")
        frame:SetSize(450, 100)
        frame:SetPoint("CENTER")
        frame:SetMovable(true)
        frame:EnableMouse(true)
        frame:RegisterForDrag("LeftButton")
        frame:SetScript("OnDragStart", frame.StartMoving)
        frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
        frame:SetFrameStrata("DIALOG")

        frame.title = frame:CreateFontString(nil, "OVERLAY")
        frame.title:SetFontObject("GameFontHighlight")
        frame.title:SetPoint("LEFT", frame.TitleBg, "LEFT", 5, 0)

        local editBox = CreateFrame("EditBox", nil, frame)
        editBox:SetPoint("TOPLEFT", 15, -35)
        editBox:SetPoint("BOTTOMRIGHT", -15, 15)
        editBox:SetFontObject("ChatFontNormal")
        editBox:SetAutoFocus(true)
        editBox:SetScript("OnEscapePressed", function() frame:Hide() end)
        editBox:SetScript("OnEnterPressed", function() frame:Hide() end)

        frame.editBox = editBox
        self.linkFrame = frame
    end

    self.linkFrame.title:SetText(questName .. " - Press Ctrl+C to copy")
    self.linkFrame.editBox:SetText(url)
    self.linkFrame.editBox:HighlightText()
    self.linkFrame:Show()
    self.linkFrame.editBox:SetFocus()
end

-- Summary Tab
function DungeonQuestTracker:DrawSummaryTab(container)
    -- Overall stats
    local totalQuests, totalCompleted, totalInProgress = self:GetOverallStats()
    local pct = totalQuests > 0 and math.floor((totalCompleted / totalQuests) * 100) or 0

    local overviewGroup = AceGUI:Create("InlineGroup")
    overviewGroup:SetTitle("Overall Progress")
    overviewGroup:SetFullWidth(true)
    overviewGroup:SetLayout("List")
    container:AddChild(overviewGroup)

    local overallLabel = AceGUI:Create("Label")
    overallLabel:SetText(string.format(
        "|cffffd700Total Progress:|r |cff00ff00%d|r / %d quests completed (|cff%s%d%%|r)",
        totalCompleted, totalQuests,
        pct == 100 and "00ff00" or (pct > 50 and "ffff00" or "ff4444"),
        pct
    ))
    overallLabel:SetFullWidth(true)
    overviewGroup:AddChild(overallLabel)

    if totalInProgress > 0 then
        local progressLabel = AceGUI:Create("Label")
        progressLabel:SetText(string.format("|cffffd700In Progress:|r |cffffff00%d|r quests", totalInProgress))
        progressLabel:SetFullWidth(true)
        overviewGroup:AddChild(progressLabel)
    end

    -- Progress bar as text
    local barWidth = 40
    local filledWidth = math.floor((pct / 100) * barWidth)
    local emptyWidth = barWidth - filledWidth
    local barText = "|cff00ff00" .. string.rep("|", filledWidth) .. "|r" ..
                    "|cff444444" .. string.rep("|", emptyWidth) .. "|r"
    local barLabel = AceGUI:Create("Label")
    barLabel:SetText(barText)
    barLabel:SetFullWidth(true)
    overviewGroup:AddChild(barLabel)

    -- Spacer
    local spacer = AceGUI:Create("Label")
    spacer:SetText(" ")
    spacer:SetFullWidth(true)
    container:AddChild(spacer)

    -- Per-dungeon breakdown
    local detailsGroup = AceGUI:Create("InlineGroup")
    detailsGroup:SetTitle("Dungeon Breakdown")
    detailsGroup:SetFullWidth(true)
    detailsGroup:SetLayout("List")
    container:AddChild(detailsGroup)

    for _, complex in ipairs(self.DUNGEON_DATA) do
        -- Complex header
        local hasVisibleDungeons = false
        for _, dungeon in ipairs(complex.dungeons) do
            local t = self:GetDungeonStats(dungeon)
            if t > 0 then
                hasVisibleDungeons = true
                break
            end
        end

        if hasVisibleDungeons then
            local complexLabel = AceGUI:Create("Label")
            complexLabel:SetText(string.format("\n|cffffd700%s|r", complex.complex))
            complexLabel:SetFullWidth(true)
            detailsGroup:AddChild(complexLabel)

            for _, dungeon in ipairs(complex.dungeons) do
                local t, c = self:GetDungeonStats(dungeon)
                if t > 0 then
                    local dungeonPct = math.floor((c / t) * 100)
                    local color
                    if c == t then
                        color = "00ff00"
                    elseif c > 0 then
                        color = "ffff00"
                    else
                        color = "ff4444"
                    end

                    -- Mini progress bar
                    local miniBarWidth = 20
                    local miniFilled = math.floor((dungeonPct / 100) * miniBarWidth)
                    local miniEmpty = miniBarWidth - miniFilled
                    local miniBar = "|cff" .. color .. string.rep("|", miniFilled) .. "|r" ..
                                    "|cff444444" .. string.rep("|", miniEmpty) .. "|r"

                    local dungeonLabel = AceGUI:Create("Label")
                    dungeonLabel:SetText(string.format(
                        "  |cff%s%s|r  %s  %d/%d (%d%%)",
                        color, dungeon.name, miniBar, c, t, dungeonPct
                    ))
                    dungeonLabel:SetFullWidth(true)
                    detailsGroup:AddChild(dungeonLabel)
                end
            end
        end
    end
end
