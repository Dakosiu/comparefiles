local bossLevers = Action()
local AID = 21400

local config = {
    [1] = {
        Daily = true, -- ! Set the cooldown for 24 hours
        Cooldown = false, -- ! Use this to configure a more detailed time cooldown
        Boss = false, -- !Set to true if you want some boss to be created when push the lever ("Will also create a portal when this boss is kiled")
        SpawnCreatures = true, -- ! If the creatures will be spawned through the script
        LimitIP = 3, -- !Limit amount of Characters per IP (leave on 0 to disable)
        CheckPlayersInside = true, -- ! Leave it disabled if you want players be able to go while theres more people in there (It will spawn more creatures)
        Level = 100, -- ! Minimum level
        Days = 0, -- ! For cooldown, Days, Hours and Minutes
        Hours = 0,
        Minutes = 1,
        KickTime = 3, -- ! In minutes, time to be kicked from room
        DeterminedPositions = true, -- ! Use this to teleport in order like anihi
        ConfigurationForAdvancedPlayersinArea = {
            fromPos = { 60, 2224, 12 },
            toPos = { 71, 2229, 12 }
        },
        Configuration = {
            PlayerPositions = { -- ! Position of the Tiles
                [1] = { 75, 2233, 12 },
                [2] = { 75, 2232, 12 },
                [3] = { 75, 2231, 12 }
            },
            PlayerTeleportTo = {
                [1] = { 69, 2227, 12 },
                [2] = { 70, 2227, 12 },
                [3] = { 71, 2227, 12 }
            },
            MonsterPositions = { -- !Position that monsters will be spawned
                [1] = { Name = "Ogre Shaman", Pos = { 67, 2225, 12 } },
                [2] = { Name = "Ogre Shaman", Pos = { 69, 2225, 12 } },
                [3] = { Name = "Ogre Shaman", Pos = { 71, 2225, 12 } },
                [4] = { Name = "Ogre Shaman", Pos = { 67, 2229, 12 } },
                [5] = { Name = "Ogre Shaman", Pos = { 69, 2229, 12 } },
                [6] = { Name = "Ogre Shaman", Pos = { 71, 2229, 12 } },
                [7] = { Name = "Ogre Brute", Pos = { 68, 2227, 12 } },
                [8] = { Name = "Ogre Brute", Pos = { 67, 2227, 12 } }
            },
            TeleportTo = { 70, 2227, 12 },
            LeverPosition = { 75, 2234, 12 }, -- * Important part, will define where player will Click to be teleported
            LeverID = 1945, -- ! This will be created, just leave it in 0 if you already created the item in the Position ID
            BossName = "Dragon Lord", -- ! Boss Name, its important to use correct name to create portal when it dies
            BossPosition = { 68, 2227, 12 }, -- ! Position Boss will Spawn (when push lever)
            PortalPosition = { 62, 2228, 12 }, -- ! This only executes if boss exists ("Will execute when boss dies")
            PortalDestination = { 75, 2227, 12 } -- ! Destination for the portal
        }
    },
    [2] = {
        Daily = false, -- ! Set the cooldown for 24 hours
        Cooldown = true, -- ! Use this to configure a more detailed time cooldown
        Boss = true, -- !Set to true if you want some boss to be created when push the lever ("Will also create a portal when this boss is kiled")
        LimitIP = 0, -- !Limit amount of Characters per IP (leave on 0 to disable)
        SpawnCreatures = false, -- ! If the creatures will be spawned through the script
        Level = 20, -- ! Minimum level
        Days = 0, -- ! For cooldown, Days, Hours and Minutes
        Hours = 0,
        Minutes = 1,
        CheckPlayersInside = true, -- ! Leave it disabled if you want players be able to go while theres more people in there (It will spawn more creatures)
        KickTime = 10, -- ! In minutes, time to be kicked from room
        DeterminedPositions = false, -- ! Use this to teleport in order like anihi, if not it will just teleport players randomly to the TeleportTo position
        ConfigurationForAdvancedPlayersinArea = {
            fromPos = { 846, 874, 5 },
            toPos = { 849, 879, 5 }
        },
        Configuration = {
            PlayerPositions = { -- ! Position of the Tiles
                [1] = { 812, 872, 3 },
                [2] = { 811, 873, 3 },
                [3] = { 813, 873, 3 }
            },
            TeleportTo = { 846, 876, 5 },
            LeverPosition = { 812, 871, 3 }, -- * Important part, will define where player will Click to be teleported
            LeverID = 0, -- ! This will be created, just leave it in 0 if you already created the item in the Position ID
            BossName = "Troll", -- ! Boss Name, its important to use correct name to create portal when it dies
            BossPosition = { 846, 881, 5 }, -- ! Position Boss will Spawn (when push lever)
            PortalPosition = { 846, 878, 5 }, -- ! This only executes if boss exists ("Will execute when boss dies")
            PortalDestination = { 812, 869, 3 } -- ! Destination for the portal
        }
    },
	[3] = {
	       -- North of evotronus city near mutated rats 
        Daily = false, -- ! Set the cooldown for 24 hours
        Cooldown = true, -- ! Use this to configure a more detailed time cooldown
        Boss = true, -- !Set to true if you want some boss to be created when push the lever ("Will also create a portal when this boss is kiled")
        SpawnCreatures = true, -- ! If the creatures will be spawned through the script
        LimitIP = 0, -- !Limit amount of Characters per IP (leave on 0 to disable)
        CheckPlayersInside = true, -- ! Leave it disabled if you want players be able to go while theres more people in there (It will spawn more creatures)
        Level = 75, -- ! Minimum level
        Days = 0, -- ! For cooldown, Days, Hours and Minutes
        Hours = 0,
        Minutes = 1,
        KickTime = 15, -- ! In minutes, time to be kicked from room
        DeterminedPositions = true, -- ! Use this to teleport in order like anihi
        ConfigurationForAdvancedPlayersinArea = {
            fromPos = { 241, 7751, 7 },
            toPos = { 280, 7775, 7 }
        },
        Configuration = {
            PlayerPositions = { -- ! Position of the Tiles
                [1] = { 890, 825, 5 },
                [2] = { 893, 824, 5 },
				[3] = { 887, 824, 5 },
                [4] = { 890, 830, 5 }
            },
            PlayerTeleportTo = {
                [1] = { 269, 7761, 7 },
                [2] = { 270, 7761, 7 },
				[3] = { 271, 7761, 7 },
                [4] = { 272, 7761, 7 }
            },
            MonsterPositions = { -- !Position that monsters will be spawned
                [1] = { Name = "Hydra", Pos = { 246, 7759, 7 } },
                [2] = { Name = "Hydra", Pos = { 246, 7762, 7 } },
                [3] = { Name = "Hydra", Pos = { 248, 7764, 7 } },
                [4] = { Name = "Hydra", Pos = { 248, 7759, 7 } },
                [5] = { Name = "Hydra", Pos = { 250, 7760, 7 } },
                [6] = { Name = "Hydra", Pos = { 252, 7761, 7 } },
                [7] = { Name = "Hydra", Pos = { 256, 7759, 7 } },
                [8] = { Name = "Hydra", Pos = { 256, 7764, 7 } }
            },
            TeleportTo = { 232, 7753, 7 },
            LeverPosition = { 890, 824, 5 }, -- * Important part, will define where player will Click to be teleported
            LeverID = 0, -- ! This will be created, just leave it in 0 if you already created the item in the Position ID
            BossName = "Massacre", -- ! Boss Name, its important to use correct name to create portal when it dies
            BossPosition = { 259, 7761, 7 }, -- ! Position Boss will Spawn (when push lever)
            PortalPosition = { 255, 7761, 7 }, -- ! This only executes if boss exists ("Will execute when boss dies")
            PortalDestination = { 253, 7761, 7 } -- ! Destination for the portal
        }
    },
	[4] = {
	      -- ! 3x arenas place east from stamina treiners
        Daily = true, -- ! Set the cooldown for 24 hours
        Cooldown = false, -- ! Use this to configure a more detailed time cooldown
        Boss = true, -- !Set to true if you want some boss to be created when push the lever ("Will also create a portal when this boss is kiled")
        SpawnCreatures = true, -- ! If the creatures will be spawned through the script
        LimitIP = 0, -- !Limit amount of Characters per IP (leave on 0 to disable)
        CheckPlayersInside = true, -- ! Leave it disabled if you want players be able to go while theres more people in there (It will spawn more creatures)
        Level = 50, -- ! Minimum level
        Days = 0, -- ! For cooldown, Days, Hours and Minutes
        Hours = 0,
        Minutes = 1,
        KickTime = 5, -- ! In minutes, time to be kicked from room
        DeterminedPositions = true, -- ! Use this to teleport in order like anihi
        ConfigurationForAdvancedPlayersinArea = {
            fromPos = { 1002, 868, 3 },
            toPos = { 1029, 886, 3 }
        },
        Configuration = {
            PlayerPositions = { -- ! Position of the Tiles
                [1] = { 1021, 871, 4 },
                [2] = { 1022, 871, 4 }
            },
            PlayerTeleportTo = {
                [1] = { 1027, 875, 3 },
                [2] = { 1028, 875, 3 }
            },
            MonsterPositions = { -- !Position that monsters will be spawned
                [1] = { Name = "Earth Elemental", Pos = { 1025, 875, 3 } },
                [2] = { Name = "Earth Elemental", Pos = { 1023, 876, 3 } },
                [3] = { Name = "Earth Elemental", Pos = { 1020, 878, 3 } },
                [4] = { Name = "Earth Elemental", Pos = { 1018, 880, 3 } },
                [5] = { Name = "Earth Elemental", Pos = { 1017, 882, 3 } },
				[6] = { Name = "Earth Elemental", Pos = { 1013, 880, 3 } },
				[7] = { Name = "Earth Elemental", Pos = { 1016, 877, 3 } },
				[8] = { Name = "Earth Elemental", Pos = { 1016, 870, 3 } },
				[9] = { Name = "Earth Elemental", Pos = { 1012, 871, 3 } },
				[10] = { Name = "Earth Elemental", Pos = { 1011, 875, 3 } },
                [11] = { Name = "Earth Elemental", Pos = { 1009, 873, 3 } },
                [12] = { Name = "Earth Elemental", Pos = { 1007, 875, 3 } },
                [13] = { Name = "Earth Elemental", Pos = { 1007, 877, 3 } }
            },
            TeleportTo = { 1022, 870, 4 },
            LeverPosition = { 1020, 872, 4 }, -- * Important part, will define where player will Click to be teleported
            LeverID = 0, -- ! This will be created, just leave it in 0 if you already created the item in the Position ID
            BossName = "Tanjis", -- ! Boss Name, its important to use correct name to create portal when it dies
            BossPosition = { 1005, 875, 3 }, -- ! Position Boss will Spawn (when push lever)
            PortalPosition = { 1016, 869, 3 }, -- ! This only executes if boss exists ("Will execute when boss dies")
            PortalDestination = { 1022, 870, 4 } -- ! Destination for the portal
        }
    },
	[5] = {
        Daily = true, -- ! Set the cooldown for 24 hours
        Cooldown = false, -- ! Use this to configure a more detailed time cooldown
        Boss = true, -- !Set to true if you want some boss to be created when push the lever ("Will also create a portal when this boss is kiled")
        SpawnCreatures = true, -- ! If the creatures will be spawned through the script
        LimitIP = 0, -- !Limit amount of Characters per IP (leave on 0 to disable)
        CheckPlayersInside = true, -- ! Leave it disabled if you want players be able to go while theres more people in there (It will spawn more creatures)
        Level = 110, -- ! Minimum level
        Days = 0, -- ! For cooldown, Days, Hours and Minutes
        Hours = 0,
        Minutes = 1,
        KickTime = 5, -- ! In minutes, time to be kicked from room
        DeterminedPositions = true, -- ! Use this to teleport in order like anihi
        ConfigurationForAdvancedPlayersinArea = {
            fromPos = { 1013, 850, 3 },
            toPos = { 1044, 870, 3 }
        },
        Configuration = {
            PlayerPositions = { -- ! Position of the Tiles
                [1] = { 1026, 862, 4 },
                [2] = { 1026, 863, 4 }
            },
            PlayerTeleportTo = {
                [1] = { 1041, 861, 3 },
                [2] = { 1042, 861, 3 }
            },
            MonsterPositions = { -- !Position that monsters will be spawned
                [1] = { Name = "Hydra", Pos = { 1037, 859, 3 } },
                [2] = { Name = "Hydra", Pos = { 1037, 861, 3 } },
                [3] = { Name = "Hydra", Pos = { 1037, 863, 3 } },
                [4] = { Name = "Hydra", Pos = { 1037, 866, 3 } },
                [5] = { Name = "Hydra", Pos = { 1026, 859, 3 } },
                [6] = { Name = "Hydra", Pos = { 1025, 855, 3 } },
                [7] = { Name = "Hydra", Pos = { 1028, 852, 3 } },
                [8] = { Name = "Hydra", Pos = { 1021, 853, 3 } }
            },
            TeleportTo = { 1024, 863, 4 },
            LeverPosition = { 1025, 861, 4 }, -- * Important part, will define where player will Click to be teleported
            LeverID = 0, -- ! This will be created, just leave it in 0 if you already created the item in the Position ID
            BossName = "Obujos", -- ! Boss Name, its important to use correct name to create portal when it dies
            BossPosition = { 1017, 858, 3 }, -- ! Position Boss will Spawn (when push lever)
            PortalPosition = { 1021, 861, 3 }, -- ! This only executes if boss exists ("Will execute when boss dies")
            PortalDestination = { 1024, 863, 4 } -- ! Destination for the portal
        }
    },
	[6] = {
        Daily = true, -- ! Set the cooldown for 24 hours
        Cooldown = false, -- ! Use this to configure a more detailed time cooldown
        Boss = true, -- !Set to true if you want some boss to be created when push the lever ("Will also create a portal when this boss is kiled")
        SpawnCreatures = true, -- ! If the creatures will be spawned through the script
        LimitIP = 0, -- !Limit amount of Characters per IP (leave on 0 to disable)
        CheckPlayersInside = true, -- ! Leave it disabled if you want players be able to go while theres more people in there (It will spawn more creatures)
        Level = 165, -- ! Minimum level
        Days = 0, -- ! For cooldown, Days, Hours and Minutes
        Hours = 0,
        Minutes = 1,
        KickTime = 5, -- ! In minutes, time to be kicked from room
        DeterminedPositions = true, -- ! Use this to teleport in order like anihi
        ConfigurationForAdvancedPlayersinArea = {
            fromPos = { 993, 851, 3 },
            toPos = { 1015, 868, 3 }
        },
        Configuration = {
            PlayerPositions = { -- ! Position of the Tiles
                [1] = { 1007, 863, 4 },
                [2] = { 1008, 863, 4 },
				[3] = { 1007, 864, 4 },
                [4] = { 1008, 864, 4 }
            },
            PlayerTeleportTo = {
                [1] = { 994, 855, 3 },
                [2] = { 995, 854, 3 },
				[3] = { 995, 853, 3 },
                [4] = { 994, 853, 3 }
            },
            MonsterPositions = { -- !Position that monsters will be spawned
                [1] = { Name = "Hand of Cursed Fate", Pos = { 996, 857, 3 } },
                [2] = { Name = "Hand of Cursed Fate", Pos = { 1000, 853, 3 } },
                [3] = { Name = "Hand of Cursed Fate", Pos = { 1000, 857, 3 } },
                [4] = { Name = "Hand of Cursed Fate", Pos = { 999, 861, 3 } },
                [5] = { Name = "Hand of Cursed Fate", Pos = { 1003, 865, 3 } },
                [6] = { Name = "Hand of Cursed Fate", Pos = { 1005, 860, 3 } },
                [7] = { Name = "Hand of Cursed Fate", Pos = { 1008, 857, 3 } },
                [8] = { Name = "Hand of Cursed Fate", Pos = { 1009, 860, 3 } }
            },
            TeleportTo = { 1011, 864, 4 },
            LeverPosition = { 1006, 862, 4 }, -- * Important part, will define where player will Click to be teleported
            LeverID = 0, -- ! This will be created, just leave it in 0 if you already created the item in the Position ID
            BossName = "Jaul", -- ! Boss Name, its important to use correct name to create portal when it dies
            BossPosition = { 1010, 857, 3 }, -- ! Position Boss will Spawn (when push lever)
            PortalPosition = { 1008, 861, 3 }, -- ! This only executes if boss exists ("Will execute when boss dies")
            PortalDestination = { 1011, 864, 4 } -- ! Destination for the portal
        }
    },
	[7] = {
        Daily = false, -- ! Set the cooldown for 24 hours
        Cooldown = true, -- ! Use this to configure a more detailed time cooldown
        Boss = true, -- !Set to true if you want some boss to be created when push the lever ("Will also create a portal when this boss is kiled")
        SpawnCreatures = true, -- ! If the creatures will be spawned through the script
        LimitIP = 0, -- !Limit amount of Characters per IP (leave on 0 to disable)
        CheckPlayersInside = true, -- ! Leave it disabled if you want players be able to go while theres more people in there (It will spawn more creatures)
        Level = 220, -- ! Minimum level
        Days = 0, -- ! For cooldown, Days, Hours and Minutes
        Hours = 1,
        Minutes = 1,
        KickTime = 300, -- ! In minutes, time to be kicked from room
        DeterminedPositions = true, -- ! Use this to teleport in order like anihi
        ConfigurationForAdvancedPlayersinArea = {
            fromPos = { 206, 2248, 10 },
            toPos = { 268, 2304, 10 }
        },
        Configuration = {
            PlayerPositions = { -- ! Position of the Tiles
                [1] = { 199, 2255, 10 },
                [2] = { 198, 2256, 10 },
				[3] = { 197, 2256, 10 },
				[4] = { 198, 2254, 10 },
				[5] = { 197, 2254, 10 },
                [6] = { 196, 2255, 10 }
            },
            PlayerTeleportTo = {
                [1] = { 210, 2253, 10 },
                [2] = { 210, 2257, 10 },
				[3] = { 209, 2256, 10 },
				[4] = { 209, 2255, 10 },
				[5] = { 209, 2254, 10 },
                [6] = { 208, 2255, 10 }
            },
            MonsterPositions = { -- !Position that monsters will be spawned
                [1] = { Name = "Dragon Lord Deluxe", Pos = { 208, 2252, 10 } },
                [2] = { Name = "Dragon Lord Deluxe", Pos = { 210, 2250, 10 } },
                [3] = { Name = "Dragon Lord Deluxe", Pos = { 212, 2250, 10 } },
                [4] = { Name = "Dragon Lord Deluxe", Pos = { 214, 2250, 10 } },
                [5] = { Name = "Dragon Lord Deluxe", Pos = { 211, 2252, 10 } },
                [6] = { Name = "Dragon Lord Deluxe", Pos = { 211, 2255, 10 } },
				[7] = { Name = "Dragon Lord Deluxe", Pos = { 212, 2255, 10 } },
                [8] = { Name = "Dragon Lord Deluxe", Pos = { 215, 2255, 10 } },
                [9] = { Name = "Dragon Lord Deluxe", Pos = { 208, 2258, 10 } },
                [10] = { Name = "Dragon Lord Deluxe", Pos = { 211, 2258, 10 } },
				[11] = { Name = "Dragon Lord Deluxe", Pos = { 215, 2258, 10 } },
                [12] = { Name = "Dragon Lord Deluxe", Pos = { 211, 2260, 10 } },
                [13] = { Name = "Dragon Lord Deluxe", Pos = { 213, 2260, 10 } },
                [14] = { Name = "Dragon Lord Deluxe", Pos = { 215, 2260, 10 } }
            },
            TeleportTo = { 194, 2255, 10 },
            LeverPosition = { 198, 2255, 10 }, -- * Important part, will define where player will Click to be teleported
            LeverID = 0, -- ! This will be created, just leave it in 0 if you already created the item in the Position ID
            BossName = "Demon Deluxe", -- ! Boss Name, its important to use correct name to create portal when it dies
            BossPosition = { 222, 2253, 10 }, -- ! Position Boss will Spawn (when push lever)
            PortalPosition = { 222, 2252, 10 }, -- ! This only executes if boss exists ("Will execute when boss dies")
            PortalDestination = { 242, 2284, 10 } -- ! Destination for the portal
        }
    },
	[8] = {
        Daily = false, -- ! Set the cooldown for 24 hours
        Cooldown = false, -- ! Use this to configure a more detailed time cooldown
        Boss = true, -- !Set to true if you want some boss to be created when push the lever ("Will also create a portal when this boss is kiled")
        SpawnCreatures = true, -- ! If the creatures will be spawned through the script
        LimitIP = 0, -- !Limit amount of Characters per IP (leave on 0 to disable)
        CheckPlayersInside = true, -- ! Leave it disabled if you want players be able to go while theres more people in there (It will spawn more creatures)
        Level = 220, -- ! Minimum level
        Days = 0, -- ! For cooldown, Days, Hours and Minutes
        Hours = 0,
        Minutes = 1,
        KickTime = 300, -- ! In minutes, time to be kicked from room
        DeterminedPositions = true, -- ! Use this to teleport in order like anihi
        ConfigurationForAdvancedPlayersinArea = {
            fromPos = { 63, 2257, 11 },
            toPos = { 147, 2316, 11 }
        },
        Configuration = {
            PlayerPositions = { -- ! Position of the Tiles
                [1] = { 239, 2283, 10 },
                [2] = { 240, 2283, 10 },
				[3] = { 241, 2283, 10 },
                [4] = { 242, 2283, 10 }
            },
            PlayerTeleportTo = {
                [1] = { 244, 2283, 10 },
                [2] = { 249, 2293, 10 },
				[3] = { 261, 2283, 10 },
                [4] = { 248, 2275, 10 }
            },
            MonsterPositions = { -- !Position that monsters will be spawned
                [1] = { Name = "Destroyer Deluxe", Pos = { 259, 2283, 10 } },
                [2] = { Name = "Destroyer Deluxe", Pos = { 249, 2290, 10 } },
                [3] = { Name = "Destroyer Deluxe", Pos = { 255, 2287, 10 } },
                [4] = { Name = "Destroyer Deluxe", Pos = { 249, 2283, 10 } },
                [5] = { Name = "Destroyer Deluxe", Pos = { 253, 2279, 10 } },
                [6] = { Name = "Destroyer Deluxe", Pos = { 250, 2277, 10 } },
                [7] = { Name = "Destroyer Deluxe", Pos = { 246, 2277, 10 } },
                [8] = { Name = "Destroyer Deluxe", Pos = { 243, 2286, 10 } }
            },
            TeleportTo = { 194, 2255, 10 },
            LeverPosition = { 238, 2283, 10 }, -- * Important part, will define where player will Click to be teleported
            LeverID = 0, -- ! This will be created, just leave it in 0 if you already created the item in the Position ID
            BossName = "Dark Torturer Deluxe", -- ! Boss Name, its important to use correct name to create portal when it dies
            BossPosition = { 247, 2283, 10 }, -- ! Position Boss will Spawn (when push lever)
            PortalPosition = { 251, 2283, 10 }, -- ! This only executes if boss exists ("Will execute when boss dies")
            PortalDestination = { 128, 2303, 11 } -- ! Destination for the portal
        }
    },
	[9] = {
        Daily = false, -- ! Set the cooldown for 24 hours
        Cooldown = true, -- ! Use this to configure a more detailed time cooldown
        Boss = false, -- !Set to true if you want some boss to be created when push the lever ("Will also create a portal when this boss is kiled")
        SpawnCreatures = true, -- ! If the creatures will be spawned through the script
        LimitIP = 0, -- !Limit amount of Characters per IP (leave on 0 to disable)
        CheckPlayersInside = true, -- ! Leave it disabled if you want players be able to go while theres more people in there (It will spawn more creatures)
        Level = 150, -- ! Minimum level
        Days = 0, -- ! For cooldown, Days, Hours and Minutes
        Hours = 0,
        Minutes = 1,
        KickTime = 10, -- ! In minutes, time to be kicked from room
        DeterminedPositions = true, -- ! Use this to teleport in order like anihi
        ConfigurationForAdvancedPlayersinArea = {
            fromPos = { 218, 2220, 10 },
            toPos = { 225, 2228, 10 }
        },
        Configuration = {
            PlayerPositions = { -- ! Position of the Tiles
                [1] = { 200, 2224, 10 },
                [2] = { 199, 2224, 10 },
				[3] = { 198, 2224, 10 },
                [4] = { 197, 2224, 10 }
            },
            PlayerTeleportTo = {
                [1] = { 223, 2224, 10 },
                [2] = { 222, 2224, 10 },
				[3] = { 221, 2224, 10 },
                [4] = { 220, 2224, 10 }
            },
            MonsterPositions = { -- !Position that monsters will be spawned
                [1] = { Name = "Lava Golem", Pos = { 225, 2224, 10 } },
                [2] = { Name = "Lava Golem", Pos = { 224, 2224, 10 } },
                [3] = { Name = "Lava Golem", Pos = { 222, 2222, 10 } },
                [4] = { Name = "Lava Golem", Pos = { 220, 2222, 10 } },
                [5] = { Name = "Lava Golem", Pos = { 221, 2226, 10 } },
                [6] = { Name = "Lava Golem", Pos = { 223, 2226, 10 } }
            },
            TeleportTo = { 185, 2224, 10 },
            LeverPosition = { 201, 2224, 10 }, -- * Important part, will define where player will Click to be teleported
            LeverID = 1945, -- ! This will be created, just leave it in 0 if you already created the item in the Position ID
            BossName = "Lava Golem", -- ! Boss Name, its important to use correct name to create portal when it dies
            BossPosition = { 241, 2224, 10 }, -- ! Position Boss will Spawn (when push lever)
            PortalPosition = { 240, 2225, 10 }, -- ! This only executes if boss exists ("Will execute when boss dies")
            PortalDestination = { 185, 2224, 10 } -- ! Destination for the portal
        }
	},
    [10] = {
        Daily = true, -- ! Set the cooldown for 24 hours
        Cooldown = true, -- ! Use this to configure a more detailed time cooldown
        Boss = true, -- !Set to true if you want some boss to be created when push the lever ("Will also create a portal when this boss is kiled")
        LimitIP = 0, -- !Limit amount of Characters per IP (leave on 0 to disable)
        SpawnCreatures = false, -- ! If the creatures will be spawned through the script
        Level = 55, -- ! Minimum level
        Days = 0, -- ! For cooldown, Days, Hours and Minutes
        Hours = 0,
        Minutes = 0,
        CheckPlayersInside = true, -- ! Leave it disabled if you want players be able to go while theres more people in there (It will spawn more creatures)
        KickTime = 15, -- ! In minutes, time to be kicked from room
        DeterminedPositions = false, -- ! Use this to teleport in order like anihi, if not it will just teleport players randomly to the TeleportTo position
        ConfigurationForAdvancedPlayersinArea = {
            fromPos = { 45, 1586, 9 },
            toPos = { 62, 1607, 9 }
        },
        Configuration = {
            PlayerPositions = { -- ! Position of the Tiles
                [1] = { 37, 1596, 9 }
            },
            TeleportTo = { 46, 1597, 9 },
            LeverPosition = { 36, 1596, 9 }, -- * Important part, will define where player will Click to be teleported
            LeverID = 0, -- ! This will be created, just leave it in 0 if you already created the item in the Position ID
            BossName = "Draganir", -- ! Boss Name, its important to use correct name to create portal when it dies
            BossPosition = { 59, 1587, 9 }, -- ! Position Boss will Spawn (when push lever)
            PortalPosition = { 47, 1603, 9 }, -- ! This only executes if boss exists ("Will execute when boss dies")
            PortalDestination = { 53, 1585, 9 } -- ! Destination for the portal
        }
	},
    [11] = {
        Daily = true, -- ! Set the cooldown for 24 hours
        Cooldown = true, -- ! Use this to configure a more detailed time cooldown
        Boss = true, -- !Set to true if you want some boss to be created when push the lever ("Will also create a portal when this boss is kiled")
        LimitIP = 0, -- !Limit amount of Characters per IP (leave on 0 to disable)
        SpawnCreatures = false, -- ! If the creatures will be spawned through the script
        Level = 55, -- ! Minimum level
        Days = 0, -- ! For cooldown, Days, Hours and Minutes
        Hours = 0,
        Minutes = 0,
        CheckPlayersInside = true, -- ! Leave it disabled if you want players be able to go while theres more people in there (It will spawn more creatures)
        KickTime = 15, -- ! In minutes, time to be kicked from room
        DeterminedPositions = false, -- ! Use this to teleport in order like anihi, if not it will just teleport players randomly to the TeleportTo position
        ConfigurationForAdvancedPlayersinArea = {
            fromPos = { 93, 1586, 9 },
            toPos = { 110, 1607, 9 }
        },
        Configuration = {
            PlayerPositions = { -- ! Position of the Tiles
                [1] = { 85, 1596, 9 }
            },
            TeleportTo = { 94, 1597, 9 },
            LeverPosition = { 84, 1596, 9 }, -- * Important part, will define where player will Click to be teleported
            LeverID = 0, -- ! This will be created, just leave it in 0 if you already created the item in the Position ID
            BossName = "Drahhu", -- ! Boss Name, its important to use correct name to create portal when it dies
            BossPosition = { 107, 1587, 9 }, -- ! Position Boss will Spawn (when push lever)
            PortalPosition = { 95, 1602, 9 }, -- ! This only executes if boss exists ("Will execute when boss dies")
            PortalDestination = { 101, 1585, 9 } -- ! Destination for the portal
        }
	},
    [12] = {
        Daily = true, -- ! Set the cooldown for 24 hours
        Cooldown = true, -- ! Use this to configure a more detailed time cooldown
        Boss = true, -- !Set to true if you want some boss to be created when push the lever ("Will also create a portal when this boss is kiled")
        LimitIP = 0, -- !Limit amount of Characters per IP (leave on 0 to disable)
        SpawnCreatures = false, -- ! If the creatures will be spawned through the script
        Level = 110, -- ! Minimum level
        Days = 0, -- ! For cooldown, Days, Hours and Minutes
        Hours = 0,
        Minutes = 0,
        CheckPlayersInside = true, -- ! Leave it disabled if you want players be able to go while theres more people in there (It will spawn more creatures)
        KickTime = 15, -- ! In minutes, time to be kicked from room
        DeterminedPositions = false, -- ! Use this to teleport in order like anihi, if not it will just teleport players randomly to the TeleportTo position
        ConfigurationForAdvancedPlayersinArea = {
            fromPos = { 141, 1586, 9 },
            toPos = { 158, 1607, 9 }
        },
        Configuration = {
            PlayerPositions = { -- ! Position of the Tiles
                [1] = { 133, 1596, 9 }
            },
            TeleportTo = { 142, 1597, 9 },
            LeverPosition = { 132, 1596, 9 }, -- * Important part, will define where player will Click to be teleported
            LeverID = 0, -- ! This will be created, just leave it in 0 if you already created the item in the Position ID
            BossName = "Mighty Mino", -- ! Boss Name, its important to use correct name to create portal when it dies
            BossPosition = { 155, 1587, 9 }, -- ! Position Boss will Spawn (when push lever)
            PortalPosition = { 143, 1603, 9 }, -- ! This only executes if boss exists ("Will execute when boss dies")
            PortalDestination = { 149, 1585, 9 } -- ! Destination for the portal
        }
	},
    [13] = {
        Daily = true, -- ! Set the cooldown for 24 hours
        Cooldown = true, -- ! Use this to configure a more detailed time cooldown
        Boss = true, -- !Set to true if you want some boss to be created when push the lever ("Will also create a portal when this boss is kiled")
        LimitIP = 0, -- !Limit amount of Characters per IP (leave on 0 to disable)
        SpawnCreatures = false, -- ! If the creatures will be spawned through the script
        Level = 110, -- ! Minimum level
        Days = 0, -- ! For cooldown, Days, Hours and Minutes
        Hours = 17,
        Minutes = 15,
        CheckPlayersInside = true, -- ! Leave it disabled if you want players be able to go while theres more people in there (It will spawn more creatures)
        KickTime = 10, -- ! In minutes, time to be kicked from room
        DeterminedPositions = false, -- ! Use this to teleport in order like anihi, if not it will just teleport players randomly to the TeleportTo position
        ConfigurationForAdvancedPlayersinArea = {
            fromPos = { 189, 1586, 9 },
            toPos = { 206, 1607, 9 }
        },
        Configuration = {
            PlayerPositions = { -- ! Position of the Tiles
                [1] = { 181, 1596, 9 }
            },
            TeleportTo = { 190, 1597, 9 },
            LeverPosition = { 180, 1596, 9 }, -- * Important part, will define where player will Click to be teleported
            LeverID = 0, -- ! This will be created, just leave it in 0 if you already created the item in the Position ID
            BossName = "Skullhasher", -- ! Boss Name, its important to use correct name to create portal when it dies
            BossPosition = { 203, 1587, 9 }, -- ! Position Boss will Spawn (when push lever)
            PortalPosition = { 191, 1603, 9 }, -- ! This only executes if boss exists ("Will execute when boss dies")
            PortalDestination = { 197, 1585, 9 } -- ! Destination for the portal
        }
	},
    [14] = {
        Daily = true, -- ! Set the cooldown for 24 hours
        Cooldown = true, -- ! Use this to configure a more detailed time cooldown
        Boss = true, -- !Set to true if you want some boss to be created when push the lever ("Will also create a portal when this boss is kiled")
        LimitIP = 0, -- !Limit amount of Characters per IP (leave on 0 to disable)
        SpawnCreatures = false, -- ! If the creatures will be spawned through the script
        Level = 220, -- ! Minimum level
        Days = 0, -- ! For cooldown, Days, Hours and Minutes
        Hours = 17,
        Minutes = 30,
        CheckPlayersInside = true, -- ! Leave it disabled if you want players be able to go while theres more people in there (It will spawn more creatures)
        KickTime = 15, -- ! In minutes, time to be kicked from room
        DeterminedPositions = false, -- ! Use this to teleport in order like anihi, if not it will just teleport players randomly to the TeleportTo position
        ConfigurationForAdvancedPlayersinArea = {
            fromPos = { 237, 1586, 9 },
            toPos = { 254, 1607, 9 }
        },
        Configuration = {
            PlayerPositions = { -- ! Position of the Tiles
                [1] = { 229, 1596, 9 }
            },
            TeleportTo = { 238, 1597, 9 },
            LeverPosition = { 228, 1596, 9 }, -- * Important part, will define where player will Click to be teleported
            LeverID = 0, -- ! This will be created, just leave it in 0 if you already created the item in the Position ID
            BossName = "Durianus", -- ! Boss Name, its important to use correct name to create portal when it dies
            BossPosition = { 251, 1587, 9 }, -- ! Position Boss will Spawn (when push lever)
            PortalPosition = { 239, 1603, 9 }, -- ! This only executes if boss exists ("Will execute when boss dies")
            PortalDestination = { 245, 1585, 9 } -- ! Destination for the portal
        }
	},
    [15] = {
        Daily = true, -- ! Set the cooldown for 24 hours
        Cooldown = true, -- ! Use this to configure a more detailed time cooldown
        Boss = true, -- !Set to true if you want some boss to be created when push the lever ("Will also create a portal when this boss is kiled")
        LimitIP = 0, -- !Limit amount of Characters per IP (leave on 0 to disable)
        SpawnCreatures = false, -- ! If the creatures will be spawned through the script
        Level = 220, -- ! Minimum level
        Days = 0, -- ! For cooldown, Days, Hours and Minutes
        Hours = 17,
        Minutes = 30,
        CheckPlayersInside = true, -- ! Leave it disabled if you want players be able to go while theres more people in there (It will spawn more creatures)
        KickTime = 15, -- ! In minutes, time to be kicked from room
        DeterminedPositions = false, -- ! Use this to teleport in order like anihi, if not it will just teleport players randomly to the TeleportTo position
        ConfigurationForAdvancedPlayersinArea = {
            fromPos = { 285, 1586, 9 },
            toPos = { 302, 1607, 9 }
        },
        Configuration = {
            PlayerPositions = { -- ! Position of the Tiles
                [1] = { 277, 1596, 9 }
            },
            TeleportTo = { 286, 1597, 9 },
            LeverPosition = { 276, 1596, 9 }, -- * Important part, will define where player will Click to be teleported
            LeverID = 0, -- ! This will be created, just leave it in 0 if you already created the item in the Position ID
            BossName = "Nighthaven Kraken", -- ! Boss Name, its important to use correct name to create portal when it dies
            BossPosition = { 299, 1587, 9 }, -- ! Position Boss will Spawn (when push lever)
            PortalPosition = { 287, 1603, 9 }, -- ! This only executes if boss exists ("Will execute when boss dies")
            PortalDestination = { 293, 1585, 9 } -- ! Destination for the portal
        }
	},
    [16] = {
        Daily = true, -- ! Set the cooldown for 24 hours
        Cooldown = true, -- ! Use this to configure a more detailed time cooldown
        Boss = true, -- !Set to true if you want some boss to be created when push the lever ("Will also create a portal when this boss is kiled")
        LimitIP = 0, -- !Limit amount of Characters per IP (leave on 0 to disable)
        SpawnCreatures = false, -- ! If the creatures will be spawned through the script
        Level = 330, -- ! Minimum level
        Days = 0, -- ! For cooldown, Days, Hours and Minutes
        Hours = 17,
        Minutes = 30,
        CheckPlayersInside = true, -- ! Leave it disabled if you want players be able to go while theres more people in there (It will spawn more creatures)
        KickTime = 15, -- ! In minutes, time to be kicked from room
        DeterminedPositions = false, -- ! Use this to teleport in order like anihi, if not it will just teleport players randomly to the TeleportTo position
        ConfigurationForAdvancedPlayersinArea = {
            fromPos = { 93, 1633, 9 },
            toPos = { 110, 1654, 9 }
        },
        Configuration = {
            PlayerPositions = { -- ! Position of the Tiles
                [1] = { 85, 1643, 9 }
            },
            TeleportTo = { 94, 1644, 9 },
            LeverPosition = { 84, 1643, 9 }, -- * Important part, will define where player will Click to be teleported
            LeverID = 0, -- ! This will be created, just leave it in 0 if you already created the item in the Position ID
            BossName = "Ursabeast", -- ! Boss Name, its important to use correct name to create portal when it dies
            BossPosition = { 107, 1634, 9 }, -- ! Position Boss will Spawn (when push lever)
            PortalPosition = { 95, 1650, 9 }, -- ! This only executes if boss exists ("Will execute when boss dies")
            PortalDestination = { 101, 1632, 9 } -- ! Destination for the portal
        }
	},
    [17] = {
        Daily = true, -- ! Set the cooldown for 24 hours
        Cooldown = true, -- ! Use this to configure a more detailed time cooldown
        Boss = true, -- !Set to true if you want some boss to be created when push the lever ("Will also create a portal when this boss is kiled")
        LimitIP = 0, -- !Limit amount of Characters per IP (leave on 0 to disable)
        SpawnCreatures = false, -- ! If the creatures will be spawned through the script
        Level = 330, -- ! Minimum level
        Days = 0, -- ! For cooldown, Days, Hours and Minutes
        Hours = 17,
        Minutes = 30,
        CheckPlayersInside = true, -- ! Leave it disabled if you want players be able to go while theres more people in there (It will spawn more creatures)
        KickTime = 15, -- ! In minutes, time to be kicked from room
        DeterminedPositions = false, -- ! Use this to teleport in order like anihi, if not it will just teleport players randomly to the TeleportTo position
        ConfigurationForAdvancedPlayersinArea = {
            fromPos = { 45, 1633, 9 },
            toPos = { 62, 1654, 9 }
        },
        Configuration = {
            PlayerPositions = { -- ! Position of the Tiles
                [1] = { 37, 1643, 9 }
            },
            TeleportTo = { 46, 1644, 9 },
            LeverPosition = { 36, 1643, 9 }, -- * Important part, will define where player will Click to be teleported
            LeverID = 0, -- ! This will be created, just leave it in 0 if you already created the item in the Position ID
            BossName = "Professor Maxxen", -- ! Boss Name, its important to use correct name to create portal when it dies
            BossPosition = { 59, 1634, 9 }, -- ! Position Boss will Spawn (when push lever)
            PortalPosition = { 47, 1650, 9 }, -- ! This only executes if boss exists ("Will execute when boss dies")
            PortalDestination = { 53, 1632, 9 } -- ! Destination for the portal
        }
	},
	[18] = {
	       -- 230 lvl quiver quest
        Daily = false, -- ! Set the cooldown for 24 hours
        Cooldown = true, -- ! Use this to configure a more detailed time cooldown
        Boss = true, -- !Set to true if you want some boss to be created when push the lever ("Will also create a portal when this boss is kiled")
        SpawnCreatures = true, -- ! If the creatures will be spawned through the script
        LimitIP = 0, -- !Limit amount of Characters per IP (leave on 0 to disable)
        CheckPlayersInside = true, -- ! Leave it disabled if you want players be able to go while theres more people in there (It will spawn more creatures)
        Level = 230, -- ! Minimum level
        Days = 0, -- ! For cooldown, Days, Hours and Minutes
        Hours = 0,
        Minutes = 20,
        KickTime = 90, -- ! In minutes, time to be kicked from room
        DeterminedPositions = true, -- ! Use this to teleport in order like anihi
        ConfigurationForAdvancedPlayersinArea = {
            fromPos = { 331, 4299, 10 },
            toPos = { 372, 4394, 10 }
        },
        Configuration = {
            PlayerPositions = { -- ! Position of the Tiles
                [1] = { 385, 4307, 10 },
                [2] = { 384, 4307, 10 }
            },
            PlayerTeleportTo = {
                [1] = { 376, 4305, 10 },
                [2] = { 377, 4305, 10 }
            },
            MonsterPositions = { -- !Position that monsters will be spawned
                [1] = { Name = "Hellhound", Pos = { 415, 4337, 10 } },
                [2] = { Name = "Hellhound", Pos = { 350, 4340, 10 } },
                [3] = { Name = "Grim Reaper", Pos = { 351, 4325, 10 } },
                [4] = { Name = "Grim Reaper", Pos = { 427, 4345, 10 } },
                [5] = { Name = "Feverish Citizen", Pos = { 437, 4342, 10 } },
                [6] = { Name = "Feverish Citizen", Pos = { 342, 4326, 10 } },
                [7] = { Name = "Mad Mage", Pos = { 384, 4373, 10 } },
				[8] = { Name = "Mad Mage", Pos = { 382, 4374, 10 } }
            },
            TeleportTo = { 381, 4350, 11 },
            LeverPosition = { 386, 4307, 10 }, -- * Important part, will define where player will Click to be teleported
            LeverID = 0, -- ! This will be created, just leave it in 0 if you already created the item in the Position ID
            BossName = "Demon Deluxe", -- ! Boss Name, its important to use correct name to create portal when it dies
            BossPosition = { 385, 4303, 11 }, -- ! Position Boss will Spawn (when push lever)
            PortalPosition = { 380, 4302, 11 }, -- ! This only executes if boss exists ("Will execute when boss dies")
            PortalDestination = { 381, 4350, 11 } -- ! Destination for the portal
        }
	},
	[19] = {
	       -- books backpack quest
        Daily = false, -- ! Set the cooldown for 24 hours
        Cooldown = true, -- ! Use this to configure a more detailed time cooldown
        Boss = true, -- !Set to true if you want some boss to be created when push the lever ("Will also create a portal when this boss is kiled")
        SpawnCreatures = true, -- ! If the creatures will be spawned through the script
        LimitIP = 0, -- !Limit amount of Characters per IP (leave on 0 to disable)
        CheckPlayersInside = true, -- ! Leave it disabled if you want players be able to go while theres more people in there (It will spawn more creatures)
        Level = 95, -- ! Minimum level
        Days = 0, -- ! For cooldown, Days, Hours and Minutes
        Hours = 0,
        Minutes = 20,
        KickTime = 15, -- ! In minutes, time to be kicked from room
        DeterminedPositions = true, -- ! Use this to teleport in order like anihi
        ConfigurationForAdvancedPlayersinArea = {
            fromPos = { 512, 3241, 7 },
            toPos = { 535, 3260, 7 }
        },
        Configuration = {
            PlayerPositions = { -- ! Position of the Tiles
                [1] = { 524, 3239, 7 },
                [2] = { 524, 3238, 7 }
            },
            PlayerTeleportTo = {
                [1] = { 520, 3250, 7 },
                [2] = { 526, 3250, 7 }
            },
            MonsterPositions = { -- !Position that monsters will be spawned
                [1] = { Name = "Warlock", Pos = { 524, 3242, 7 } },
                [2] = { Name = "Warlock", Pos = { 515, 3252, 7 } },
                [3] = { Name = "Warlock", Pos = { 532, 3252, 7 } },
				[4] = { Name = "Warlock", Pos = { 522, 3258, 7 } },
                [5] = { Name = "Warlock", Pos = { 525, 3258, 7 } }
            },
            TeleportTo = { 523, 3239, 7 },
            LeverPosition = { 524, 3240, 7 }, -- * Important part, will define where player will Click to be teleported
            LeverID = 0, -- ! This will be created, just leave it in 0 if you already created the item in the Position ID
            BossName = "Mad Mage", -- ! Boss Name, its important to use correct name to create portal when it dies
            BossPosition = { 523, 3258, 7 }, -- ! Position Boss will Spawn (when push lever)
            PortalPosition = { 523, 3254, 7 }, -- ! This only executes if boss exists ("Will execute when boss dies")
            PortalDestination = { 524, 3265, 7 } -- ! Destination for the portal
        }
    }
}

DebugMode = false

function bossLevers.onUse(player, item, fromPosition, target, toPosition,
                          isHotkey)
    local aid = item.actionid
    local a = aid - AID
    local b = config[a]
    local cooldown = 0

    if b then
        local Days = b.Hours * 24 * 3600
        local Hours = b.Hours * 3600
        local Minutes = b.Minutes * 60
        local Daily = (24 * 3600)
        -- ! Verify the cooldown of this boss
        if b.Daily then
            cooldown = Daily
        elseif b.Cooldown then
            cooldown = Days + Hours + Minutes
        else
            cooldown = 0
        end
        cooldown = cooldown + os.time()
        -- ! Set the Cooldown to Players
        local y = 0
        if b.CheckPlayersInside then
            for x = b.ConfigurationForAdvancedPlayersinArea.fromPos[1], b.ConfigurationForAdvancedPlayersinArea
                .toPos[1] do
                for y = b.ConfigurationForAdvancedPlayersinArea.fromPos[2], b.ConfigurationForAdvancedPlayersinArea
                    .toPos[2] do
                    for z = b.ConfigurationForAdvancedPlayersinArea.fromPos[3], b.ConfigurationForAdvancedPlayersinArea
                        .toPos[3] do
                        local tmpPos = { x = x, y = y, z = z };
                        local t = Tile(tmpPos)
                        if t ~= nil then
                            if t:getTopCreature() and
                                t:getTopCreature():isPlayer() then
                                player:sendTextMessage(MESSAGE_EVENT_ADVANCE,
                                    "Someone is already inside.")
                                y = 1
                                return false
                            end
                        end
                    end
                end
            end
        end
        -- ! Check SameIP
        if b.LimitIP > 0 then
            local duplicateIps = {}
            local ip = player:getIp()
            local tempPos = b.Configuration.PlayerPositions
            for i in pairs(b.Configuration.PlayerPositions) do
                local temp = b.Configuration.PlayerPositions[i]
                local pos = Position(temp[1], temp[2], temp[3])
                local tile = Tile(pos)
                local participant = tile:getTopVisibleCreature(player)
                if b.LimitIP > 0 and ip == 0 or (duplicateIps[ip] or 0) >=
                    b.LimitIP then
                    player:sendTextMessage(MESSAGE_EVENT_ADVANCE,
                        "The max amount of IPs in this boss is " ..
                        b.LimitIP .. ".")
                    return false
                end
                duplicateIps[ip] = duplicateIps[ip] and duplicateIps[ip] + 1 or
                    1
            end
        end
        -- ! Check Levels
        if b.Level >= 0 then
            for i in pairs(b.Configuration.PlayerPositions) do
                local temp = b.Configuration.PlayerPositions[i]
                local pos = Position(temp[1], temp[2], temp[3])
                local tile = Tile(pos)
                local participant = tile:getTopVisibleCreature(player)
                if not participant then
                    player:sendTextMessage(MESSAGE_EVENT_ADVANCE,
                        "Not enough participants.")
                    return false
                end
                if participant and participant:isPlayer() then
                    if participant:getLevel() < b.Level then
                        player:sendTextMessage(MESSAGE_EVENT_ADVANCE,
                            participant:getName() ..
                            " need level " .. b.Level ..
                            " to enter this quest")
                        y = 1
                        return false
                    end
                    if participant:getStorageValue(aid) > os.time() or
                        player:getStorageValue(aid) > os.time() then
                        local criture = participant or player
                        player:sendTextMessage(MESSAGE_EVENT_ADVANCE,
                            criture:getName() ..
                            " still need to wait: " ..
                            timeLeft(
                                criture:getStorageValue(
                                    aid) - os.time(),
                                true) .. ".")
                        y = 1
                        return false
                    end
                end
            end
        end
        if y == 1 then return false end

        local function kickPlayers(cid)
            local player = Player(cid)
            if player then
                for x = b.ConfigurationForAdvancedPlayersinArea.fromPos[1], b.ConfigurationForAdvancedPlayersinArea
                    .toPos[1] do
                    for y = b.ConfigurationForAdvancedPlayersinArea.fromPos[2], b.ConfigurationForAdvancedPlayersinArea
                        .toPos[2] do
                        for z = b.ConfigurationForAdvancedPlayersinArea.fromPos[3], b.ConfigurationForAdvancedPlayersinArea
                            .toPos[3] do
                            local temporary = { x = x, y = y, z = z };
                            local position = player:getPosition()
                            if position.x == temporary.x and position.y ==
                                temporary.y and position.z == temporary.z then
                                player:teleportTo(player:getTown()
                                    :getTemplePosition())
                                player:sendTextMessage(MESSAGE_EVENT_ADVANCE,
                                    "You have been teleported to temple, your time has ended!")
                            end
                        end
                    end
                end
            end
        end

        for i in pairs(b.Configuration.PlayerPositions) do
            local temp = b.Configuration.PlayerPositions[i]
            local pos = Position(temp[1], temp[2], temp[3])
            local tile = Tile(pos)
            local participant = tile:getTopVisibleCreature(player)

            -- ! Teleport Players
            if not b.DeterminedPositions and y == 0 then
                local there = b.Configuration.TeleportTo
                participant:teleportTo(Position(there[1], there[2], there[3]),
                    false)
                participant:setStorageValue(aid, cooldown)
            elseif b.DeterminedPositions and y == 0 then
                local tempo = b.Configuration.PlayerTeleportTo[i]
                participant:teleportTo(Position(tempo[1], tempo[2], tempo[3]),
                    false)
                participant:setStorageValue(aid, cooldown)
            end
            participant:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have " ..
                b.KickTime ..
                " minutes to complete your task!")
            addEvent(kickPlayers, b.KickTime * 60 * 1000, participant:getId())
        end
        -- ! Spawn Creatures
        for x = b.ConfigurationForAdvancedPlayersinArea.fromPos[1], b.ConfigurationForAdvancedPlayersinArea
            .toPos[1] do
            for y = b.ConfigurationForAdvancedPlayersinArea.fromPos[2], b.ConfigurationForAdvancedPlayersinArea
                .toPos[2] do
                for z = b.ConfigurationForAdvancedPlayersinArea.fromPos[3], b.ConfigurationForAdvancedPlayersinArea
                    .toPos[3] do
                    local tmpPos = { x = x, y = y, z = z };
                    local t = Tile(tmpPos)
                    if t ~= nil then
                        if t:getTopCreature() and
                            not t:getTopCreature():isPlayer() then
                            t:getTopCreature():getPosition():sendMagicEffect(
                                CONST_ME_POFF)
                            t:getTopCreature():remove()
                        end
                    end
                end
            end
        end
        if b.SpawnCreatures and y == 0 then
            for i in pairs(b.Configuration.MonsterPositions) do
                local monsterPos = b.Configuration.MonsterPositions[i].Pos
                local Creature = Game.createMonster(b.Configuration
                    .MonsterPositions[i]
                    .Name, Position(
                        monsterPos[1],
                        monsterPos[2],
                        monsterPos[3]), false,
                    false)
            end
        end

        -- ! Spawn boss if Boss is true
        if b.Boss and y == 0 then
            local bp = b.Configuration.BossPosition
            local boss = Game.createMonster(b.Configuration.BossName,
                Position(bp[1], bp[2], bp[3]),
                false, false)
            if boss then
                boss:setSkull(SKULL_BLACK)
                local creatureEvent = CreatureEvent(b.Configuration.BossName)
                function creatureEvent.onDeath()
                    local createPos = Position(
                        b.Configuration.PortalPosition[1],
                        b.Configuration.PortalPosition[2],
                        b.Configuration.PortalPosition[3])
                    local teleport = Game.createItem(1387, 1, createPos)
                    if teleport then
                        local d = b.Configuration.PortalDestination
                        e = Position(d[1], d[2], d[3])
                        teleport:setDestination(e)
                        addTimer(90, 215, createPos)
                        addEvent(function()
                            local tile = Tile(createPos)
                            if tile then
                                local teleport = tile:getItemById(1387)
                                if teleport then
                                    teleport:remove()
                                    createPos:sendMagicEffect(CONST_ME_POFF)
                                end
                            end
                        end, 90 * 1000)
                    end
                    return true
                end

                creatureEvent:register()
                boss:registerEvent(b.Configuration.BossName)
            end
        end
    end
end

for v in pairs(config) do bossLevers:aid(AID + v) end
bossLevers:register()

local globalevent = GlobalEvent("load_bossLevers")
function globalevent.onStartup()
    for i in pairs(config) do
        local a = config[i].Configuration.LeverPosition
        local b = config[i].Configuration.LeverID
        local tile = Tile(Position(a[1], a[2], a[3]))
        if tile then
            if b > 0 then
                local item = Game.createItem(b, 1, Position(a[1], a[2], a[3]))
            end
            local thing = tile:getTopVisibleThing()
            if thing or item then
                thing:setAttribute(ITEM_ATTRIBUTE_ACTIONID, AID + i)
            end
        end
    end
end

globalevent:register()
