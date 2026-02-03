local addonName, addon = ...

local DungeonQuestTracker = LibStub("AceAddon-3.0"):NewAddon(addon, addonName,
    "AceEvent-3.0", "AceConsole-3.0")

-- Expose globally for keybinding
_G["DungeonQuestTracker"] = DungeonQuestTracker

-- Quest status cache
local questStatusCache = {}
local cacheDirty = true
local playerFaction = nil

-- Helper to open options
local function OpenOptions()
    if Settings and Settings.OpenToCategory then
        Settings.OpenToCategory("DungeonQuestTracker")
    elseif InterfaceOptionsFrame_OpenToCategory then
        InterfaceOptionsFrame_OpenToCategory("DungeonQuestTracker")
        InterfaceOptionsFrame_OpenToCategory("DungeonQuestTracker")
    end
end

function DungeonQuestTracker:GetDefaults()
    return {
        profile = {
            minimap = { hide = false },
            showCompletedDungeons = true,
            showPrerequisites = true,
            showOnlyCurrentFaction = true,
            showHeroicQuests = true,
            lastTab = "summary",
        },
    }
end

function DungeonQuestTracker:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New("DungeonQuestTrackerDB", self:GetDefaults(), true)

    -- Register slash commands
    self:RegisterChatCommand("dqt", "SlashCommand")
    self:RegisterChatCommand("dungeonquesttracker", "SlashCommand")

    -- Register options
    LibStub("AceConfig-3.0"):RegisterOptionsTable(addonName, self:GetOptionsTable())
    LibStub("AceConfigDialog-3.0"):AddToBlizOptions(addonName, "DungeonQuestTracker")

    -- Setup minimap button
    self:SetupMinimapButton()

    -- Cache player faction
    playerFaction = UnitFactionGroup("player")
end

function DungeonQuestTracker:OnEnable()
    self:RegisterEvent("QUEST_TURNED_IN", "InvalidateCache")
    self:RegisterEvent("QUEST_LOG_UPDATE", "InvalidateCache")
    self:RegisterEvent("QUEST_ACCEPTED", "InvalidateCache")

    self:Print("DungeonQuestTracker loaded. Use /dqt to open.")
end

function DungeonQuestTracker:OnDisable()
    self:UnregisterAllEvents()
end

function DungeonQuestTracker:SlashCommand(input)
    local cmd = input and input:trim():lower() or ""

    if cmd == "" or cmd == "show" then
        self:ToggleUI()
    elseif cmd == "config" or cmd == "options" then
        OpenOptions()
    elseif cmd == "summary" then
        self:PrintSummary()
    else
        self:Print("DungeonQuestTracker commands:")
        self:Print("  /dqt - Toggle quest tracker window")
        self:Print("  /dqt config - Open options")
        self:Print("  /dqt summary - Print completion summary to chat")
    end
end

function DungeonQuestTracker:Toggle()
    self:ToggleUI()
end

-- Quest Status API
function DungeonQuestTracker:InvalidateCache()
    cacheDirty = true
    questStatusCache = {}
end

-- TBC Classic compatible: scan quest log for a quest ID
local function IsQuestInLog(questId)
    local numEntries = GetNumQuestLogEntries()
    for i = 1, numEntries do
        local _, _, _, isHeader, _, _, _, qid = GetQuestLogTitle(i)
        if not isHeader and qid == questId then
            return true
        end
    end
    return false
end

function DungeonQuestTracker:GetQuestStatus(questId)
    if not cacheDirty and questStatusCache[questId] then
        return questStatusCache[questId]
    end

    local status
    if C_QuestLog.IsQuestFlaggedCompleted(questId) then
        status = "completed"
    elseif IsQuestInLog(questId) then
        status = "in_progress"
    else
        status = "not_started"
    end

    questStatusCache[questId] = status
    return status
end

function DungeonQuestTracker:GetDungeonStats(dungeon)
    local total = 0
    local completed = 0
    local inProgress = 0

    for _, quest in ipairs(dungeon.quests) do
        -- Filter by faction
        if self:ShouldShowQuest(quest) then
            total = total + 1
            local status = self:GetQuestStatus(quest.questId)
            if status == "completed" then
                completed = completed + 1
            elseif status == "in_progress" then
                inProgress = inProgress + 1
            end
        end
    end

    cacheDirty = false
    return total, completed, inProgress
end

function DungeonQuestTracker:ShouldShowQuest(quest)
    local db = self.db.profile

    -- Filter heroic quests
    if quest.heroic and not db.showHeroicQuests then
        return false
    end

    -- Filter by faction
    if db.showOnlyCurrentFaction and quest.faction ~= "Both" then
        if quest.faction ~= playerFaction then
            return false
        end
    end

    return true
end

function DungeonQuestTracker:GetPlayerFaction()
    return playerFaction
end

function DungeonQuestTracker:GetOverallStats()
    local totalQuests = 0
    local totalCompleted = 0
    local totalInProgress = 0

    for _, complex in ipairs(self.DUNGEON_DATA) do
        for _, dungeon in ipairs(complex.dungeons) do
            local t, c, p = self:GetDungeonStats(dungeon)
            totalQuests = totalQuests + t
            totalCompleted = totalCompleted + c
            totalInProgress = totalInProgress + p
        end
    end

    return totalQuests, totalCompleted, totalInProgress
end

function DungeonQuestTracker:PrintSummary()
    local totalQuests, totalCompleted, totalInProgress = self:GetOverallStats()
    local pct = totalQuests > 0 and math.floor((totalCompleted / totalQuests) * 100) or 0

    self:Print("=== Dungeon Quest Progress ===")
    self:Print(string.format("Overall: %d/%d completed (%d%%)", totalCompleted, totalQuests, pct))

    if totalInProgress > 0 then
        self:Print(string.format("In progress: %d", totalInProgress))
    end

    for _, complex in ipairs(self.DUNGEON_DATA) do
        for _, dungeon in ipairs(complex.dungeons) do
            local t, c = self:GetDungeonStats(dungeon)
            if t > 0 then
                local dungeonPct = math.floor((c / t) * 100)
                local color = c == t and "00ff00" or (c > 0 and "ffff00" or "ff4444")
                self:Print(string.format("  |cff%s%s|r: %d/%d (%d%%)", color, dungeon.name, c, t, dungeonPct))
            end
        end
    end
end

-- Minimap Button
function DungeonQuestTracker:SetupMinimapButton()
    local LDB = LibStub("LibDataBroker-1.1", true)
    local LDBIcon = LibStub("LibDBIcon-1.0", true)

    if not LDB or not LDBIcon then return end

    local dataObj = LDB:NewDataObject("DungeonQuestTracker", {
        type = "launcher",
        icon = "Interface\\Icons\\INV_Misc_Book_11",
        OnClick = function(_, button)
            if button == "LeftButton" then
                self:ToggleUI()
            elseif button == "RightButton" then
                OpenOptions()
            end
        end,
        OnTooltipShow = function(tooltip)
            tooltip:AddLine("DungeonQuestTracker")
            tooltip:AddLine("|cff00ff00Left-click|r to toggle quest tracker", 1, 1, 1)
            tooltip:AddLine("|cff00ff00Right-click|r for options", 1, 1, 1)

            local totalQuests, totalCompleted = self:GetOverallStats()
            if totalQuests > 0 then
                local pct = math.floor((totalCompleted / totalQuests) * 100)
                tooltip:AddLine(" ")
                tooltip:AddDoubleLine("Progress:", string.format("%d/%d (%d%%)", totalCompleted, totalQuests, pct), 1, 0.82, 0, 1, 1, 1)
            end
        end,
    })

    if not self.db.profile.minimap then
        self.db.profile.minimap = { hide = false }
    end

    LDBIcon:Register("DungeonQuestTracker", dataObj, self.db.profile.minimap)
end
