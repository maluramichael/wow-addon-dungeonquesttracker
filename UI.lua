local addonName, addon = ...
local DungeonQuestTracker = addon

local AceGUI = LibStub("AceGUI-3.0")

local mainFrame = nil
local currentTab = "summary"

-- Status icons using WoW raid readycheck textures
local STATUS_ICONS = {
    completed   = "|TInterface\\RAIDFRAME\\ReadyCheck-Ready:0|t",
    in_progress = "|TInterface\\RAIDFRAME\\ReadyCheck-Waiting:0|t",
    not_started = "|TInterface\\RAIDFRAME\\ReadyCheck-NotReady:0|t",
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
    mainFrame:SetTitle("Dungeon Quest Tracker")
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

    -- Restore last tab or default to summary
    local lastTab = self.db.profile.lastTab or "summary"
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
    scroll:SetLayout("List")
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

        if total == 0 then
            -- No visible quests for this dungeon
        elseif completed == total and not self.db.profile.showCompletedDungeons then
            -- Skip completed dungeon
        else
            self:DrawDungeon(container, dungeon, total, completed, inProgress)
        end
    end
end

function DungeonQuestTracker:DrawDungeon(container, dungeon, total, completed, inProgress)
    -- Header icon based on completion
    local headerIcon
    if completed == total then
        headerIcon = STATUS_ICONS.completed .. " "
    elseif completed > 0 or inProgress > 0 then
        headerIcon = STATUS_ICONS.in_progress .. " "
    else
        headerIcon = ""
    end

    -- Color the completion count
    local countColor
    if completed == total then
        countColor = "00cc00"
    elseif completed > 0 or inProgress > 0 then
        countColor = "ffcc00"
    else
        countColor = "ff4444"
    end

    -- Level range display
    local levelStr = ""
    if dungeon.levelRange and dungeon.levelRange ~= "" then
        levelStr = string.format(" |cff888888(%s)|r", dungeon.levelRange)
    end

    local title = string.format("%s%s%s  |cff%s%d/%d|r",
        headerIcon, dungeon.name, levelStr, countColor, completed, total)

    local group = AceGUI:Create("InlineGroup")
    group:SetTitle(title)
    group:SetFullWidth(true)
    group:SetLayout("List")
    container:AddChild(group)

    -- Collect all prerequisite quest IDs to avoid drawing them twice
    local prereqIds = {}
    if self.db.profile.showPrerequisites then
        for _, quest in ipairs(dungeon.quests) do
            if self:ShouldShowQuest(quest) and quest.prerequisites then
                for _, prereq in ipairs(quest.prerequisites) do
                    prereqIds[prereq.questId] = true
                end
            end
        end
    end

    for _, quest in ipairs(dungeon.quests) do
        if self:ShouldShowQuest(quest) and not prereqIds[quest.questId] then
            -- Draw prerequisites first (at normal indent)
            local hasPrereqs = self.db.profile.showPrerequisites and quest.prerequisites and #quest.prerequisites > 0
            if hasPrereqs then
                for _, prereq in ipairs(quest.prerequisites) do
                    self:DrawPrereqRow(group, prereq)
                end
            end

            -- Draw main quest (indented if it has prerequisites)
            self:DrawQuestRow(group, quest, hasPrereqs)
        end
    end
end

function DungeonQuestTracker:DrawQuestRow(container, quest, indented)
    local status = self:GetQuestStatus(quest.questId)
    local icon = STATUS_ICONS[status] or STATUS_ICONS.not_started

    local heroicTag = ""
    if quest.heroic then
        heroicTag = " |cffff8800[Heroic]|r"
    end

    local factionTag = ""
    if not self.db.profile.showOnlyCurrentFaction and quest.faction ~= "Both" then
        if quest.faction == "Alliance" then
            factionTag = " |cff4488ff[A]|r"
        else
            factionTag = " |cffff2020[H]|r"
        end
    end

    -- Quest name color based on status
    local nameColor
    if status == "completed" then
        nameColor = "6a6a6a"
    elseif status == "in_progress" then
        nameColor = "ffff66"
    else
        nameColor = "eeeeee"
    end

    local indent = indented and "        " or "  "
    local text = string.format("%s%s  |cff%s%s|r%s%s",
        indent, icon, nameColor, quest.name, heroicTag, factionTag)

    local row = AceGUI:Create("InteractiveLabel")
    row:SetText(text)
    row:SetFullWidth(true)
    row:SetCallback("OnClick", function()
        self:ShowWowheadLink(quest.questId, quest.name)
    end)
    row:SetCallback("OnEnter", function(widget)
        GameTooltip:SetOwner(widget.frame, "ANCHOR_TOPRIGHT")
        GameTooltip:AddLine(quest.name, 1, 1, 1)
        if quest.description and quest.description ~= "" then
            GameTooltip:AddLine(quest.description, 0.8, 0.8, 0.8, true)
        end
        GameTooltip:AddLine(" ")
        if status == "completed" then
            GameTooltip:AddLine("Completed", 0, 0.8, 0)
        elseif status == "in_progress" then
            GameTooltip:AddLine("In Progress", 1, 1, 0)
        else
            GameTooltip:AddLine("Not Started", 0.6, 0.6, 0.6)
        end
        if quest.heroic then
            GameTooltip:AddLine("Requires Heroic difficulty", 1, 0.5, 0)
        end
        if quest.faction ~= "Both" then
            GameTooltip:AddLine(string.format("Faction: %s", quest.faction), 0.5, 0.5, 0.5)
        end
        GameTooltip:AddLine(" ")
        GameTooltip:AddLine("Click to copy Wowhead link", 0, 0.8, 0)
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

    local nameColor = status == "completed" and "6a6a6a" or "aa9977"

    -- Prerequisite shown at normal indent level, main quest indented below
    local text = string.format("  %s  |cff%s%s|r |cff666666[Pre]|r", icon, nameColor, prereq.name)

    local row = AceGUI:Create("InteractiveLabel")
    row:SetText(text)
    row:SetFullWidth(true)
    row:SetCallback("OnClick", function()
        self:ShowWowheadLink(prereq.questId, prereq.name)
    end)
    row:SetCallback("OnEnter", function(widget)
        GameTooltip:SetOwner(widget.frame, "ANCHOR_TOPRIGHT")
        GameTooltip:AddLine(prereq.name, 1, 1, 1)
        GameTooltip:AddLine("Prerequisite quest", 1, 0.82, 0)
        GameTooltip:AddLine(string.format("Quest ID: %d", prereq.questId), 0.5, 0.5, 0.5)
        GameTooltip:AddLine(" ")
        GameTooltip:AddLine("Click to copy Wowhead link", 0, 0.8, 0)
        GameTooltip:Show()
    end)
    row:SetCallback("OnLeave", function()
        GameTooltip:Hide()
    end)

    container:AddChild(row)
end

function DungeonQuestTracker:ShowWowheadLink(questId, questName)
    local url = string.format("https://www.wowhead.com/tbc/quest=%d", questId)

    if not self.linkFrame then
        local frame = CreateFrame("Frame", "DQTLinkFrame", UIParent, "BasicFrameTemplateWithInset")
        frame:SetSize(450, 100)
        frame:SetPoint("TOP", UIParent, "TOP", 0, -100)
        frame:SetMovable(true)
        frame:EnableMouse(true)
        frame:RegisterForDrag("LeftButton")
        frame:SetScript("OnDragStart", frame.StartMoving)
        frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
        frame:SetFrameStrata("TOOLTIP")
        frame:SetFrameLevel(100)

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
        -- Close after Ctrl+C: detect when text gets deselected (copy happened)
        editBox:SetScript("OnKeyUp", function(self, key)
            if key == "C" and IsControlKeyDown() then
                C_Timer.After(0.2, function() frame:Hide() end)
            end
        end)

        frame.editBox = editBox
        self.linkFrame = frame
    end

    self.linkFrame.title:SetText(questName .. " - Ctrl+C to copy")
    self.linkFrame.editBox:SetText(url)
    self.linkFrame.editBox:HighlightText()
    self.linkFrame:Show()
    self.linkFrame.editBox:SetFocus()
end

-- Summary Tab
function DungeonQuestTracker:DrawSummaryTab(container)
    local totalQuests, totalCompleted, totalInProgress = self:GetOverallStats()
    local pct = totalQuests > 0 and math.floor((totalCompleted / totalQuests) * 100) or 0

    local overviewGroup = AceGUI:Create("InlineGroup")
    overviewGroup:SetTitle("Overall Progress")
    overviewGroup:SetFullWidth(true)
    overviewGroup:SetLayout("List")
    container:AddChild(overviewGroup)

    local pctColor = pct == 100 and "00cc00" or (pct >= 50 and "ffcc00" or "ff6644")
    local overallLabel = AceGUI:Create("Label")
    overallLabel:SetText(string.format(
        "  |cffffd700Quests Completed:|r  |cff00cc00%d|r |cff999999/|r %d  |cff%s(%d%%)|r",
        totalCompleted, totalQuests, pctColor, pct
    ))
    overallLabel:SetFullWidth(true)
    overallLabel:SetFontObject(GameFontNormal)
    overviewGroup:AddChild(overallLabel)

    if totalInProgress > 0 then
        local progressLabel = AceGUI:Create("Label")
        progressLabel:SetText(string.format("  |cffffd700In Progress:|r  |cffffff00%d|r quests", totalInProgress))
        progressLabel:SetFullWidth(true)
        overviewGroup:AddChild(progressLabel)
    end

    -- Spacer
    local spacer = AceGUI:Create("Label")
    spacer:SetText(" ")
    spacer:SetFullWidth(true)
    container:AddChild(spacer)

    -- Per-complex breakdown
    for _, complex in ipairs(self.DUNGEON_DATA) do
        local hasVisibleDungeons = false
        local complexTotal, complexCompleted = 0, 0
        for _, dungeon in ipairs(complex.dungeons) do
            local t, c = self:GetDungeonStats(dungeon)
            if t > 0 then
                hasVisibleDungeons = true
                complexTotal = complexTotal + t
                complexCompleted = complexCompleted + c
            end
        end

        if hasVisibleDungeons then
            local complexColor = complexCompleted == complexTotal and "00cc00" or (complexCompleted > 0 and "ffcc00" or "ff4444")

            local complexGroup = AceGUI:Create("InlineGroup")
            complexGroup:SetTitle(string.format("%s  |cff%s%d/%d|r",
                complex.complex, complexColor, complexCompleted, complexTotal))
            complexGroup:SetFullWidth(true)
            complexGroup:SetLayout("List")
            container:AddChild(complexGroup)

            for _, dungeon in ipairs(complex.dungeons) do
                local t, c = self:GetDungeonStats(dungeon)
                if t > 0 then
                    local color
                    if c == t then
                        color = "00cc00"
                    elseif c > 0 then
                        color = "ffcc00"
                    else
                        color = "ff4444"
                    end

                    local statusIcon = c == t and STATUS_ICONS.completed or
                        (c > 0 and STATUS_ICONS.in_progress or STATUS_ICONS.not_started)

                    local dungeonLabel = AceGUI:Create("Label")
                    dungeonLabel:SetText(string.format(
                        "  %s  |cff%s%s|r  |cff%s%d/%d|r",
                        statusIcon, color, dungeon.name, color, c, t
                    ))
                    dungeonLabel:SetFullWidth(true)
                    complexGroup:AddChild(dungeonLabel)
                end
            end
        end
    end
end
