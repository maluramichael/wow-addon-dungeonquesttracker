local addonName, addon = ...
local DungeonQuestTracker = addon

-- Quest data for all Classic and TBC dungeons
-- Structure: Complex > Dungeon > Quest
-- faction: "Alliance", "Horde", or "Both"
-- heroic: true if quest requires heroic mode
-- prerequisites: list of prerequisite quest IDs with names

DungeonQuestTracker.DUNGEON_DATA = {
    -- ========================================================================
    -- CLASSIC DUNGEONS
    -- ========================================================================

    -- Ragefire Chasm
    {
        complex = "Ragefire Chasm",
        dungeons = {
            {
                name = "Ragefire Chasm",
                levelRange = "13-18",
                quests = {
                    {
                        questId = 5722,
                        name = "The Power to Destroy...",
                        faction = "Horde",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 5723,
                        name = "Testing an Enemy's Strength",
                        faction = "Horde",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 5725,
                        name = "Slaying the Beast",
                        faction = "Horde",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 5726,
                        name = "Searching for the Lost Satchel",
                        faction = "Horde",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 5728,
                        name = "Returning the Lost Satchel",
                        faction = "Horde",
                        heroic = false,
                        prerequisites = {
                            { questId = 5726, name = "Searching for the Lost Satchel" },
                        },
                    },
                    {
                        questId = 5761,
                        name = "Hidden Enemies",
                        faction = "Horde",
                        heroic = false,
                        prerequisites = {},
                    },
                },
            },
        },
    },

    -- Wailing Caverns
    {
        complex = "Wailing Caverns",
        dungeons = {
            {
                name = "Wailing Caverns",
                levelRange = "17-24",
                quests = {
                    {
                        questId = 914,
                        name = "Deviate Hides",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 1486,
                        name = "Deviate Eradication",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 959,
                        name = "Trouble at the Docks",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 962,
                        name = "Serpentbloom",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 1487,
                        name = "Leaders of the Fang",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 3370,
                        name = "The Glowing Shard",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                },
            },
        },
    },

    -- The Deadmines
    {
        complex = "The Deadmines",
        dungeons = {
            {
                name = "The Deadmines",
                levelRange = "17-26",
                quests = {
                    {
                        questId = 166,
                        name = "The Defias Brotherhood",
                        faction = "Alliance",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 214,
                        name = "Red Silk Bandanas",
                        faction = "Alliance",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 168,
                        name = "Collecting Memories",
                        faction = "Alliance",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 167,
                        name = "Oh Brother...",
                        faction = "Alliance",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 2040,
                        name = "Underground Assault",
                        faction = "Alliance",
                        heroic = false,
                        prerequisites = {},
                    },
                },
            },
        },
    },

    -- Shadowfang Keep
    {
        complex = "Shadowfang Keep",
        dungeons = {
            {
                name = "Shadowfang Keep",
                levelRange = "22-30",
                quests = {
                    {
                        questId = 1014,
                        name = "Deathstalkers in Shadowfang",
                        faction = "Horde",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 1098,
                        name = "The Book of Ur",
                        faction = "Horde",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 1740,
                        name = "Arugal Must Die",
                        faction = "Horde",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 1013,
                        name = "The Orb of Soran'ruk",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                },
            },
        },
    },

    -- Blackfathom Deeps
    {
        complex = "Blackfathom Deeps",
        dungeons = {
            {
                name = "Blackfathom Deeps",
                levelRange = "24-32",
                quests = {
                    {
                        questId = 971,
                        name = "Researching the Corruption",
                        faction = "Alliance",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 1198,
                        name = "In Search of Thaelrid",
                        faction = "Alliance",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 1199,
                        name = "Blackfathom Villainy",
                        faction = "Alliance",
                        heroic = false,
                        prerequisites = {
                            { questId = 1198, name = "In Search of Thaelrid" },
                        },
                    },
                    {
                        questId = 6921,
                        name = "Allegiance to the Old Gods",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 6922,
                        name = "Allegiance to the Old Gods",
                        faction = "Horde",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 1275,
                        name = "The Essence of Aku'Mai",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                },
            },
        },
    },

    -- The Stockade
    {
        complex = "The Stockade",
        dungeons = {
            {
                name = "The Stockade",
                levelRange = "24-32",
                quests = {
                    {
                        questId = 387,
                        name = "Crime and Punishment",
                        faction = "Alliance",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 378,
                        name = "The Fury Runs Deep",
                        faction = "Alliance",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 386,
                        name = "Quell The Uprising",
                        faction = "Alliance",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 377,
                        name = "What Comes Around...",
                        faction = "Alliance",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 391,
                        name = "The Color of Blood",
                        faction = "Alliance",
                        heroic = false,
                        prerequisites = {},
                    },
                },
            },
        },
    },

    -- Gnomeregan
    {
        complex = "Gnomeregan",
        dungeons = {
            {
                name = "Gnomeregan",
                levelRange = "29-38",
                quests = {
                    {
                        questId = 2904,
                        name = "A Fine Mess",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 2922,
                        name = "Gnogaine",
                        faction = "Alliance",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 2928,
                        name = "The Only Cure is More Green Glow",
                        faction = "Horde",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 2929,
                        name = "Data Rescue",
                        faction = "Alliance",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 2930,
                        name = "Essential Artificials",
                        faction = "Alliance",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 2945,
                        name = "Gyrodrillmatic Excavationators",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                },
            },
        },
    },

    -- Scarlet Monastery
    {
        complex = "Scarlet Monastery",
        dungeons = {
            {
                name = "SM: Graveyard",
                levelRange = "28-38",
                quests = {
                    {
                        questId = 1049,
                        name = "Vorrel's Revenge",
                        faction = "Horde",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 1051,
                        name = "Hearts of Zeal",
                        faction = "Horde",
                        heroic = false,
                        prerequisites = {},
                    },
                },
            },
            {
                name = "SM: Library",
                levelRange = "29-39",
                quests = {
                    {
                        questId = 1050,
                        name = "Mythology of the Titans",
                        faction = "Horde",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 1160,
                        name = "In the Name of the Light",
                        faction = "Alliance",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 1048,
                        name = "Compendium of the Fallen",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 1053,
                        name = "Rituals of Power",
                        faction = "Horde",
                        heroic = false,
                        prerequisites = {},
                    },
                },
            },
            {
                name = "SM: Armory",
                levelRange = "32-42",
                quests = {
                    {
                        questId = 1160,
                        name = "In the Name of the Light",
                        faction = "Alliance",
                        heroic = false,
                        prerequisites = {},
                    },
                },
            },
            {
                name = "SM: Cathedral",
                levelRange = "35-45",
                quests = {
                    {
                        questId = 1160,
                        name = "In the Name of the Light",
                        faction = "Alliance",
                        heroic = false,
                        prerequisites = {},
                    },
                },
            },
        },
    },

    -- Razorfen Kraul
    {
        complex = "Razorfen Kraul",
        dungeons = {
            {
                name = "Razorfen Kraul",
                levelRange = "30-40",
                quests = {
                    {
                        questId = 1142,
                        name = "Blueleaf Tubers",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 1144,
                        name = "Willix the Importer",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 1221,
                        name = "The Crone of the Kraul",
                        faction = "Horde",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 1101,
                        name = "Mortality Wanes",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                },
            },
        },
    },

    -- Razorfen Downs
    {
        complex = "Razorfen Downs",
        dungeons = {
            {
                name = "Razorfen Downs",
                levelRange = "37-46",
                quests = {
                    {
                        questId = 3525,
                        name = "Bring the End",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 3636,
                        name = "Bring the Light",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 6626,
                        name = "A Host of Evil",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 3341,
                        name = "Scourge of the Downs",
                        faction = "Horde",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 6521,
                        name = "An Unholy Alliance",
                        faction = "Horde",
                        heroic = false,
                        prerequisites = {},
                    },
                },
            },
        },
    },

    -- Uldaman
    {
        complex = "Uldaman",
        dungeons = {
            {
                name = "Uldaman",
                levelRange = "41-51",
                quests = {
                    {
                        questId = 2198,
                        name = "The Lost Dwarves",
                        faction = "Alliance",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 2240,
                        name = "Power Stones",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 2418,
                        name = "Agmond's Fate",
                        faction = "Alliance",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 17,
                        name = "Uldaman Reagent Run",
                        faction = "Alliance",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 2278,
                        name = "The Platinum Discs",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 2283,
                        name = "The Shattered Necklace",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                },
            },
        },
    },

    -- Zul'Farrak
    {
        complex = "Zul'Farrak",
        dungeons = {
            {
                name = "Zul'Farrak",
                levelRange = "44-54",
                quests = {
                    {
                        questId = 3527,
                        name = "Divino-matic Rod",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 2936,
                        name = "Troll Temper",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 2768,
                        name = "Scarab Shells",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 2846,
                        name = "Tiara of the Deep",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 3042,
                        name = "Nekrum's Medallion",
                        faction = "Horde",
                        heroic = false,
                        prerequisites = {},
                    },
                },
            },
        },
    },

    -- Maraudon
    {
        complex = "Maraudon",
        dungeons = {
            {
                name = "Maraudon",
                levelRange = "46-55",
                quests = {
                    {
                        questId = 7044,
                        name = "Legends of Maraudon",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 7046,
                        name = "The Pariah's Instructions",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {
                            { questId = 7044, name = "Legends of Maraudon" },
                        },
                    },
                    {
                        questId = 7041,
                        name = "Twisted Evils",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 7028,
                        name = "Shadowshard Fragments",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 7029,
                        name = "Vyletongue Corruption",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                },
            },
        },
    },

    -- Temple of Atal'Hakkar (Sunken Temple)
    {
        complex = "Sunken Temple",
        dungeons = {
            {
                name = "Temple of Atal'Hakkar",
                levelRange = "50-60",
                quests = {
                    {
                        questId = 1446,
                        name = "The Temple of Atal'Hakkar",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 3528,
                        name = "Into the Depths",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 3446,
                        name = "The God Hakkar",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {
                            { questId = 3528, name = "Into the Depths" },
                        },
                    },
                    {
                        questId = 1475,
                        name = "The Prophecy of Mosh'aru",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 3447,
                        name = "The Ancient Egg",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 4143,
                        name = "Secret of the Circle",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                },
            },
        },
    },

    -- Blackrock Depths
    {
        complex = "Blackrock Mountain",
        dungeons = {
            {
                name = "Blackrock Depths",
                levelRange = "52-60",
                quests = {
                    {
                        questId = 4123,
                        name = "Marshal Windsor",
                        faction = "Alliance",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 4264,
                        name = "Abandoned Hope",
                        faction = "Alliance",
                        heroic = false,
                        prerequisites = {
                            { questId = 4123, name = "Marshal Windsor" },
                        },
                    },
                    {
                        questId = 4282,
                        name = "A Crumpled Up Note",
                        faction = "Alliance",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 4242,
                        name = "A Taste of Flame",
                        faction = "Alliance",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 4024,
                        name = "The Heart of the Mountain",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 4134,
                        name = "The Last Element",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 4001,
                        name = "Dark Iron Legacy",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 4083,
                        name = "Hurley Blackbreath",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 4126,
                        name = "Ribbly Screwspigot",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 4136,
                        name = "Overmaster Pyron",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 4201,
                        name = "The Spectral Chalice",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 7848,
                        name = "Attunement to the Core",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                },
            },

            -- Lower Blackrock Spire
            {
                name = "Lower Blackrock Spire",
                levelRange = "55-60",
                quests = {
                    {
                        questId = 4729,
                        name = "Kibler's Exotic Pets",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 4862,
                        name = "Urok Doomhowl",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 4867,
                        name = "Seal of Ascension",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 4768,
                        name = "Put Her Down",
                        faction = "Horde",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 4765,
                        name = "Maxwell's Mission",
                        faction = "Alliance",
                        heroic = false,
                        prerequisites = {},
                    },
                },
            },

            -- Upper Blackrock Spire
            {
                name = "Upper Blackrock Spire",
                levelRange = "55-60",
                quests = {
                    {
                        questId = 4735,
                        name = "General Drakkisath's Demise",
                        faction = "Alliance",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 4734,
                        name = "General Drakkisath's Command",
                        faction = "Horde",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 4903,
                        name = "Doomrigger's Clasp",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 5127,
                        name = "Drakefire Amulet",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                },
            },
        },
    },

    -- Dire Maul
    {
        complex = "Dire Maul",
        dungeons = {
            {
                name = "Dire Maul: East",
                levelRange = "55-60",
                quests = {
                    {
                        questId = 7441,
                        name = "Lethtendris's Web",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 7488,
                        name = "Pusillin and the Elder Azj'Tordin",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 7482,
                        name = "The Broken Trap",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 5526,
                        name = "A Dusty Tome",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                },
            },
            {
                name = "Dire Maul: West",
                levelRange = "55-60",
                quests = {
                    {
                        questId = 7461,
                        name = "The Madness Within",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 7462,
                        name = "The Treasure of the Shen'dralar",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {
                            { questId = 7461, name = "The Madness Within" },
                        },
                    },
                    {
                        questId = 7631,
                        name = "The Shen'dralar Ancient",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                },
            },
            {
                name = "Dire Maul: North",
                levelRange = "55-60",
                quests = {
                    {
                        questId = 5518,
                        name = "The Gordok Ogre Suit",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 5525,
                        name = "Free Knot!",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 7703,
                        name = "Unfinished Gordok Business",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 7481,
                        name = "King of the Gordok",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                },
            },
        },
    },

    -- Stratholme
    {
        complex = "Stratholme",
        dungeons = {
            {
                name = "Stratholme",
                levelRange = "58-60",
                quests = {
                    {
                        questId = 5214,
                        name = "Of Love and Family",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 5282,
                        name = "The Archivist",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 5263,
                        name = "The Medallion of Faith",
                        faction = "Alliance",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 5306,
                        name = "Houses of the Holy",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 5848,
                        name = "The Great Fras Siabi",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 5211,
                        name = "The Restless Souls",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                },
            },
        },
    },

    -- Scholomance
    {
        complex = "Scholomance",
        dungeons = {
            {
                name = "Scholomance",
                levelRange = "58-60",
                quests = {
                    {
                        questId = 5529,
                        name = "Doctor Theolen Krastinov, the Butcher",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 5382,
                        name = "Plagued Hatchlings",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 5341,
                        name = "Barov Family Fortune",
                        faction = "Alliance",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 5343,
                        name = "Barov Family Fortune",
                        faction = "Horde",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 5384,
                        name = "The Lich, Ras Frostwhisper",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 5531,
                        name = "Dawn's Gambit",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                },
            },
        },
    },

    -- ========================================================================
    -- TBC DUNGEONS
    -- ========================================================================

    -- Hellfire Citadel
    {
        complex = "Hellfire Citadel",
        dungeons = {
            {
                name = "Hellfire Ramparts",
                levelRange = "60-62",
                quests = {
                    {
                        questId = 9575,
                        name = "Weaken the Ramparts",
                        faction = "Alliance",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 9572,
                        name = "Weaken the Ramparts",
                        faction = "Horde",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 9587,
                        name = "Dark Tidings",
                        faction = "Alliance",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 9588,
                        name = "Dark Tidings",
                        faction = "Horde",
                        heroic = false,
                        prerequisites = {},
                    },
                },
            },
            {
                name = "The Blood Furnace",
                levelRange = "61-63",
                quests = {
                    {
                        questId = 9607,
                        name = "The Blood is Life",
                        faction = "Alliance",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 9608,
                        name = "The Blood is Life",
                        faction = "Horde",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 10057,
                        name = "Heart of Rage",
                        faction = "Alliance",
                        heroic = false,
                        prerequisites = {
                            { questId = 9575, name = "Weaken the Ramparts" },
                        },
                    },
                    {
                        questId = 10051,
                        name = "Heart of Rage",
                        faction = "Horde",
                        heroic = false,
                        prerequisites = {
                            { questId = 9572, name = "Weaken the Ramparts" },
                        },
                    },
                    {
                        questId = 9589,
                        name = "Pride of the Fel Horde",
                        faction = "Horde",
                        heroic = false,
                        prerequisites = {},
                    },
                },
            },
            {
                name = "The Shattered Halls",
                levelRange = "70",
                quests = {
                    {
                        questId = 10884,
                        name = "How to Break Into the Arcatraz",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 9524,
                        name = "Entry Into the Citadel",
                        faction = "Alliance",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 9525,
                        name = "Grand Master Dumphry",
                        faction = "Alliance",
                        heroic = false,
                        prerequisites = {
                            { questId = 9524, name = "Entry Into the Citadel" },
                        },
                    },
                    {
                        questId = 9491,
                        name = "Entry Into the Citadel",
                        faction = "Horde",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 9492,
                        name = "Grand Master Rohok",
                        faction = "Horde",
                        heroic = false,
                        prerequisites = {
                            { questId = 9491, name = "Entry Into the Citadel" },
                        },
                    },
                    {
                        questId = 10670,
                        name = "Pride of the Fel Horde",
                        faction = "Alliance",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 10067,
                        name = "Tear of the Earthmother",
                        faction = "Horde",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 11002,
                        name = "Trial of the Naaru: Mercy",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                },
            },
        },
    },

    -- Coilfang Reservoir
    {
        complex = "Coilfang Reservoir",
        dungeons = {
            {
                name = "The Slave Pens",
                levelRange = "62-64",
                quests = {
                    {
                        questId = 9738,
                        name = "Lost in Action",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 9735,
                        name = "The Heart of the Matter",
                        faction = "Alliance",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 9736,
                        name = "The Heart of the Matter",
                        faction = "Horde",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 11368,
                        name = "Ahune, the Frost Lord",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                },
            },
            {
                name = "The Underbog",
                levelRange = "63-65",
                quests = {
                    {
                        questId = 9747,
                        name = "Lost in Action",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 9719,
                        name = "Oh, It's On!",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 9726,
                        name = "Bring Me A Shrubbery!",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 9730,
                        name = "Stalk the Stalker",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 9732,
                        name = "Underbog Mushroom Cap",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                },
            },
            {
                name = "The Steamvault",
                levelRange = "70",
                quests = {
                    {
                        questId = 9764,
                        name = "Orders from Lady Vashj",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 10885,
                        name = "The Warlord's Hideout",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 11000,
                        name = "Trial of the Naaru: Strength",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 9763,
                        name = "A Humble Offering",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                },
            },
        },
    },

    -- Auchindoun
    {
        complex = "Auchindoun",
        dungeons = {
            {
                name = "Mana-Tombs",
                levelRange = "64-66",
                quests = {
                    {
                        questId = 10218,
                        name = "Safety Is Job One",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 10216,
                        name = "Undercutting the Competition",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 10977,
                        name = "Stasis Chambers of the Mana-Tombs",
                        faction = "Both",
                        heroic = true,
                        prerequisites = {},
                    },
                    {
                        questId = 10165,
                        name = "Wanted: Shaffar's Wondrous Pendant",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                },
            },
            {
                name = "Auchenai Crypts",
                levelRange = "65-67",
                quests = {
                    {
                        questId = 10164,
                        name = "Wanted: The Exarch's Soul Gem",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 10167,
                        name = "Everything Will Be Alright",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 10168,
                        name = "The End of the Exarch",
                        faction = "Horde",
                        heroic = false,
                        prerequisites = {},
                    },
                },
            },
            {
                name = "Sethekk Halls",
                levelRange = "67-69",
                quests = {
                    {
                        questId = 10097,
                        name = "Brother Against Brother",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 10098,
                        name = "Terokk's Legacy",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 11001,
                        name = "Kalithresh's Trident",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                },
            },
            {
                name = "Shadow Labyrinth",
                levelRange = "70",
                quests = {
                    {
                        questId = 10649,
                        name = "Into the Heart of the Labyrinth",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 10178,
                        name = "Find Spy To'gun",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 10098,
                        name = "The Soul Devices",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 10666,
                        name = "Entry Into Karazhan",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 10680,
                        name = "The Codex of Blood",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 11003,
                        name = "Trial of the Naaru: Tenacity",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                },
            },
        },
    },

    -- Tempest Keep
    {
        complex = "Tempest Keep",
        dungeons = {
            {
                name = "The Mechanar",
                levelRange = "69-70",
                quests = {
                    {
                        questId = 10886,
                        name = "How to Break Into the Arcatraz",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 10665,
                        name = "Fresh from the Mechanar",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                },
            },
            {
                name = "The Botanica",
                levelRange = "70",
                quests = {
                    {
                        questId = 10257,
                        name = "How to Break Into the Arcatraz",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 10704,
                        name = "Saving the Botanica",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                },
            },
            {
                name = "The Arcatraz",
                levelRange = "70",
                quests = {
                    {
                        questId = 10705,
                        name = "Harbinger of Doom",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 10706,
                        name = "Seer Udalo",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 11004,
                        name = "Trial of the Naaru: Magtheridon",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                },
            },
        },
    },

    -- Caverns of Time
    {
        complex = "Caverns of Time",
        dungeons = {
            {
                name = "Old Hillsbrad Foothills",
                levelRange = "66-68",
                quests = {
                    {
                        questId = 10282,
                        name = "Taretha's Diversion",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 10283,
                        name = "Escape from Durnholde",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {
                            { questId = 10282, name = "Taretha's Diversion" },
                        },
                    },
                    {
                        questId = 10284,
                        name = "Return to Andormu",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {
                            { questId = 10283, name = "Escape from Durnholde" },
                        },
                    },
                },
            },
            {
                name = "The Black Morass",
                levelRange = "70",
                quests = {
                    {
                        questId = 10297,
                        name = "The Opening of the Dark Portal",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {
                            { questId = 10284, name = "Return to Andormu" },
                        },
                    },
                    {
                        questId = 10298,
                        name = "Hero of the Brood",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {
                            { questId = 10297, name = "The Opening of the Dark Portal" },
                        },
                    },
                    {
                        questId = 10296,
                        name = "The Master's Touch",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                },
            },
        },
    },

    -- Magisters' Terrace
    {
        complex = "Magisters' Terrace",
        dungeons = {
            {
                name = "Magisters' Terrace",
                levelRange = "70",
                quests = {
                    {
                        questId = 11490,
                        name = "Magisters' Terrace",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 11492,
                        name = "The Scryer's Scryer",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {
                            { questId = 11490, name = "Magisters' Terrace" },
                        },
                    },
                    {
                        questId = 11493,
                        name = "Hard to Kill",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                    {
                        questId = 11500,
                        name = "Severed Communications",
                        faction = "Both",
                        heroic = false,
                        prerequisites = {},
                    },
                },
            },
        },
    },
}

-- Tab definitions: which complexes go in which tab
DungeonQuestTracker.TAB_DEFINITIONS = {
    {
        value = "classic1",
        text = "Classic 1",
        complexes = {
            "Ragefire Chasm", "Wailing Caverns", "The Deadmines",
            "Shadowfang Keep", "Blackfathom Deeps", "The Stockade", "Gnomeregan",
        },
    },
    {
        value = "classic2",
        text = "Classic 2",
        complexes = {
            "Scarlet Monastery", "Razorfen Kraul", "Razorfen Downs",
            "Uldaman", "Zul'Farrak", "Maraudon", "Sunken Temple",
        },
    },
    {
        value = "classic3",
        text = "Classic 3",
        complexes = {
            "Blackrock Mountain", "Dire Maul", "Stratholme", "Scholomance",
        },
    },
    {
        value = "tbc1",
        text = "Hellfire",
        complexes = { "Hellfire Citadel" },
    },
    {
        value = "tbc2",
        text = "Coilfang",
        complexes = { "Coilfang Reservoir" },
    },
    {
        value = "tbc3",
        text = "Auchindoun",
        complexes = { "Auchindoun" },
    },
    {
        value = "tbc4",
        text = "TK + CoT",
        complexes = { "Tempest Keep", "Caverns of Time", "Magisters' Terrace" },
    },
    {
        value = "summary",
        text = "Summary",
        complexes = {},
    },
}
