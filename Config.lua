local addonName, addon = ...
local DungeonQuestTracker = addon

function DungeonQuestTracker:GetOptionsTable()
    return {
        type = "group",
        name = "DungeonQuestTracker",
        args = {
            general = {
                type = "group",
                name = "General",
                order = 1,
                inline = true,
                args = {
                    desc = {
                        type = "description",
                        name = "Track dungeon quest completion across all Classic and TBC dungeons.\n",
                        order = 1,
                    },
                    showMinimap = {
                        type = "toggle",
                        name = "Show Minimap Button",
                        desc = "Show or hide the minimap button",
                        order = 2,
                        get = function()
                            return not self.db.profile.minimap.hide
                        end,
                        set = function(_, value)
                            self.db.profile.minimap.hide = not value
                            if value then
                                LibStub("LibDBIcon-1.0"):Show("DungeonQuestTracker")
                            else
                                LibStub("LibDBIcon-1.0"):Hide("DungeonQuestTracker")
                            end
                        end,
                    },
                },
            },
            display = {
                type = "group",
                name = "Display Options",
                order = 2,
                inline = true,
                args = {
                    showCompletedDungeons = {
                        type = "toggle",
                        name = "Show Completed Dungeons",
                        desc = "Show dungeons where all quests are completed",
                        order = 1,
                        width = "full",
                        get = function()
                            return self.db.profile.showCompletedDungeons
                        end,
                        set = function(_, value)
                            self.db.profile.showCompletedDungeons = value
                        end,
                    },
                    showPrerequisites = {
                        type = "toggle",
                        name = "Show Prerequisites",
                        desc = "Show prerequisite quests indented below their dependent quest",
                        order = 2,
                        width = "full",
                        get = function()
                            return self.db.profile.showPrerequisites
                        end,
                        set = function(_, value)
                            self.db.profile.showPrerequisites = value
                        end,
                    },
                    showOnlyCurrentFaction = {
                        type = "toggle",
                        name = "Show Only Current Faction",
                        desc = "Only show quests available to your current faction",
                        order = 3,
                        width = "full",
                        get = function()
                            return self.db.profile.showOnlyCurrentFaction
                        end,
                        set = function(_, value)
                            self.db.profile.showOnlyCurrentFaction = value
                        end,
                    },
                    showHeroicQuests = {
                        type = "toggle",
                        name = "Show Heroic Quests",
                        desc = "Show quests that require heroic dungeon difficulty",
                        order = 4,
                        width = "full",
                        get = function()
                            return self.db.profile.showHeroicQuests
                        end,
                        set = function(_, value)
                            self.db.profile.showHeroicQuests = value
                        end,
                    },
                },
            },
            commands = {
                type = "group",
                name = "Commands",
                order = 3,
                inline = true,
                args = {
                    cmdDesc = {
                        type = "description",
                        name = [[
|cffffd700/dqt|r - Toggle quest tracker window
|cffffd700/dqt config|r - Open this options panel
|cffffd700/dqt summary|r - Print completion summary to chat
]],
                        order = 1,
                    },
                },
            },
        },
    }
end

-- Keybinding support
BINDING_HEADER_DUNGEONQUESTTRACKER = "DungeonQuestTracker"
BINDING_NAME_DUNGEONQUESTTRACKER_TOGGLE = "Toggle Quest Tracker Window"
