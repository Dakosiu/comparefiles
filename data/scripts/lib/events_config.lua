SKILL_HEALTH = 10
SKILL_MANA = 11
SKILL_SOUL = 12
SKILL_CAP = 13
SKILL_SPEED = 14

EVENTS_MAPS = {
	["Social"] = {pos={x=88,y=251,z=7}, returnAfterEvents=true},
}

EVENTS_CONFIG = {

	startTimer = 10,
	skillStorage = 215000,
	chestActionId = 2500,
	dbs = {
		playersLog = "logs_players",
		eventsLog = "logs_events",
	},
	
	assistData = {
		points = 2, 
		duration = 15
	},
	
	killsCombo = {
		5, 11, 20, 35, 60, 90, 130, 180, 360
	},
	
	barrelData = {
		["monsters"] = {
			{type = 'Helmet Gladiator', probability = 0.35},
			{type = 'Drunken Gladiator', probability = 0.25},
			{type = 'Gladiator Fisherman', probability = 0.25},
			{type = 'Bully Gladiator', probability = 0.15}
		},
		["chests"] = {
			{type = 355, probability = 0.7},
			{type = 356, probability = 0.3}
		}
	},
	
	highscores = {
		refreshLimit = 60, --seconds
		showOutfit = true,
		data = {
		    -- ["GENERAL"] = {
				-- showId = 1, 
				-- showIcon = "icon", 
				-- showLimit = 250, 
				-- dbTable = "logs_players", 
				-- dbSort = "points", 
				-- dbCollect = {"player_id"}, 
				-- dbCheck = {
					-- {"event_name", "Survival"}, 
					-- {"event_name", "x4 All vs All"}, 
					-- {"event_name", "1 vs 1"},
					-- {"event_name", "Rival"},
					-- {"event_name", "Racing"},
				-- }, 
				-- dbReturn = {"player_id","event_name"}
			-- },
			["SURVIVAL"] = {
				showId = 2, 
				showIcon = "icon", 
				showLimit = 250, 
				dbTable = "logs_players", 
				dbSort = "points", 
				dbCollect = {"player_id"}, 
				dbCheck = {
					{"event_name", "Survival"}, 
					{"event_name", "x4 All vs All"}, 
					{"event_name", "1 vs 1"}
				}, 
				dbReturn = {"player_id","event_name"}
			},
			["KILLS"] = {
				showId = 3, 
				showIcon = "icon", 
				showLimit = 250, 
				dbTable = "logs_players", 
				dbSort = "kills_total", 
				dbCollect = {"player_id"}, 
				dbReturn = {"player_id","event_name"}
			},
			["COMBO KILLS"] = {
				showId = 4, 
				showIcon = "icon", 
				showLimit = 250, 
				dbTable = "logs_players", 
				dbSort = "kills_combo", 
				dbCollect = {"player_id", true}, 
				dbReturn = {"player_id", "event_name"}
			},
			["Rival"] = {
				showId = 5, 
				showIcon = "icon", 
				showLimit = 250,
				dbTable = "logs_players", 
				dbSort = "points", 
				dbCheck = {{"event_name", "Rival"}}, 
				dbReturn = {"player_id", "event_name"}
			},
			["RACING"] = {
				showId = 6, 
				showIcon = "icon", 
				showLimit = 250, 
				dbTable = "logs_players", 
				dbSort = "points", 
				dbCheck = {{"event_name", "Racing"}}, 
				dbReturn = {"player_id", "event_name"}
			},
		}
	},

	vocationData = {
		skillsEnabled = true,
		eqEnabled = true,
		data = {
			["Kokao Warrior"] = {
				skills = {
					[SKILL_LEVEL] = 50,
					[SKILL_CLUB] = 50,
					[SKILL_SWORD] = 50,
					[SKILL_AXE] = 50,
					[SKILL_DISTANCE] = 50,
					[SKILL_SHIELD] = 88,
					[SKILL_FISHING] = 50,
					[SKILL_FIST] = 35,
					[SKILL_MAGLEVEL] = 3,
					[SKILL_HEALTH] = "recalculate",
					[SKILL_MANA] = "recalculate",
					[SKILL_SOUL] = 100,
					[SKILL_CAP] = 9000,
					[SKILL_SPEED] = 220,
					--[SKILL_MAX_INVENTORY] = 20,
				},
				eq = {
					[CONST_SLOT_BACKPACK] = {864, 1},
					[CONST_SLOT_LEFT] = {530, 1},
					[CONST_SLOT_RIGHT] = {490, 1},
				}
			},
			["Kaer Disciple"] = {
				skills = {
					[SKILL_LEVEL] = 50,
					[SKILL_CLUB] = 50,
					[SKILL_SWORD] = 50,
					[SKILL_AXE] = 50,
					[SKILL_DISTANCE] = 50,
					[SKILL_SHIELD] = 50,
					[SKILL_FISHING] = 50,
					[SKILL_FIST] = 50,
					[SKILL_MAGLEVEL] = 42,
					[SKILL_HEALTH] = "recalculate",
					[SKILL_MANA] = "recalculate",
					[SKILL_SOUL] = 100,
					[SKILL_CAP] = 9000,
					[SKILL_SPEED] = 220,
					--[SKILL_MAX_INVENTORY] = 20,
				},
				eq = {
					[CONST_SLOT_BACKPACK] = {864, 1},
					[CONST_SLOT_LEFT] = {486, 1},
				}
			},
			["Jade Mystic"] = {
				skills = {
					[SKILL_LEVEL] = 50,
					[SKILL_CLUB] = 50,
					[SKILL_SWORD] = 50,
					[SKILL_AXE] = 50,
					[SKILL_DISTANCE] = 50,
					[SKILL_SHIELD] = 45,
					[SKILL_FISHING] = 75,
					[SKILL_FIST] = 50,
					[SKILL_MAGLEVEL] = 42,
					[SKILL_HEALTH] = "recalculate",
					[SKILL_MANA] = "recalculate",
					[SKILL_SOUL] = 100,
					[SKILL_CAP] = 9000,
					[SKILL_SPEED] = 220,
					--[SKILL_MAX_INVENTORY] = 20,
				},
				eq = {
					[CONST_SLOT_BACKPACK] = {864, 1},
					[CONST_SLOT_LEFT] = {534, 1},
				},
			},
			["Shepherd of Aureh"] = {
				skills = {
					[SKILL_LEVEL] = 50,
					[SKILL_CLUB] = 50,
					[SKILL_SWORD] = 50,
					[SKILL_AXE] = 50,
					[SKILL_DISTANCE] = 45,
					[SKILL_SHIELD] = 62,
					[SKILL_FISHING] = 50,
					[SKILL_FIST] = 50,
					[SKILL_MAGLEVEL] = 9,
					[SKILL_HEALTH] = "recalculate",
					[SKILL_MANA] = "recalculate",
					[SKILL_SOUL] = 100,
					[SKILL_CAP] = 9000,
					[SKILL_SPEED] = 220,
					--[SKILL_MAX_INVENTORY] = 20,
				},
				eq = {
					[CONST_SLOT_BACKPACK] = {864, 1},
					[CONST_SLOT_LEFT] = {167, 1},
					[CONST_SLOT_AMMO] = {168, 1},
				}
			},
		},
	},
	
	rooms = {

		--[[]--------------------------------------------------------------------------------------------------------------------------------------------
		-------------------------------------------------------------------------------------------------------------------------------------------------
		SURVIVAL
		-------------------------------------------------------------------------------------------------------------------------------------------------
		--]]---------------------------------------------------------------------------------------------------------------------------------------------

		[1] = { 
			name="Survival", 
			eventStartTimer = 10,
			chests = {
				[1] =  {
					reward = {
						{id=862, stack={2,4}},
						{id=863, stack={2,4}},
						{id=860, stack={2,4}},
						{id=861, stack={2,4}}
					},
					pos = {x = 496, y = 561, z = 7}
				},
				[2] =  {reward={{id=862, stack={1,3}},{id=863, stack={1,3}},{id=860, stack={1,3}},{id=861, stack={1,3}}}, pos={x = 503, y = 563, z = 7}},
				[3] =  {reward={{id=862, stack={1,3}},{id=863, stack={1,3}},{id=860, stack={1,3}},{id=861, stack={1,3}}}, pos={x = 516, y = 563, z = 7}},
				[4] =  {reward={{id=862, stack={1,3}},{id=863, stack={1,3}},{id=860, stack={1,3}},{id=861, stack={1,3}}}, pos={x = 526, y = 563, z = 7}},
				[5] =  {reward={{id=862, stack={1,3}},{id=863, stack={1,3}},{id=860, stack={1,3}},{id=861, stack={1,3}}}, pos={x = 538, y = 563, z = 7}},
				[6] =  {reward={{id=862, stack={2,4}},{id=863, stack={2,4}},{id=860, stack={2,4}},{id=861, stack={2,4}}}, pos={x = 546, y = 561, z = 7}},
				[7] =  {reward={{id=862, stack={1,3}},{id=863, stack={1,3}},{id=860, stack={1,3}},{id=861, stack={1,3}}}, pos={x = 544, y = 568, z = 7}},
				[8] =  {reward={{id=862, stack={1,3}},{id=863, stack={1,3}},{id=860, stack={1,3}},{id=861, stack={1,3}}}, pos={x = 546, y = 580, z = 7}},
				[9] =  {reward={{id=862, stack={1,3}},{id=863, stack={1,3}},{id=860, stack={1,3}},{id=861, stack={1,3}}}, pos={x = 547, y = 592, z = 7}},
				[10] = {reward={{id=862, stack={2,4}},{id=863, stack={2,4}},{id=860, stack={2,4}},{id=861, stack={2,4}}}, pos={x = 548, y = 599, z = 7}},
				[11] = {reward={{id=862, stack={1,3}},{id=863, stack={1,3}},{id=860, stack={1,3}},{id=861, stack={1,3}}}, pos={x = 537, y = 599, z = 7}},
				[12] = {reward={{id=862, stack={1,3}},{id=863, stack={1,3}},{id=860, stack={1,3}},{id=861, stack={1,3}}}, pos={x = 530, y = 599, z = 7}},
				[13] = {reward={{id=862, stack={1,3}},{id=863, stack={1,3}},{id=860, stack={1,3}},{id=861, stack={1,3}}}, pos={x = 517, y = 599, z = 7}},
				[14] = {reward={{id=862, stack={1,3}},{id=863, stack={1,3}},{id=860, stack={1,3}},{id=861, stack={1,3}}}, pos={x = 501, y = 599, z = 7}},
				[15] = {reward={{id=862, stack={2,4}},{id=863, stack={2,4}},{id=860, stack={2,4}},{id=861, stack={2,4}}}, pos={x = 495, y = 599, z = 7}},
				[16] = {reward={{id=862, stack={1,3}},{id=863, stack={1,3}},{id=860, stack={1,3}},{id=861, stack={1,3}}}, pos={x = 497, y = 592, z = 7}},
				[17] = {reward={{id=862, stack={1,3}},{id=863, stack={1,3}},{id=860, stack={1,3}},{id=861, stack={1,3}}}, pos={x = 498, y = 580, z = 7}},
				[18] = {reward={{id=862, stack={1,3}},{id=863, stack={1,3}},{id=860, stack={1,3}},{id=861, stack={1,3}}}, pos={x = 496, y = 568, z = 7}},
				[19] = {reward={{id=862, stack={2,4}},{id=863, stack={2,4}},{id=860, stack={2,4}},{id=861, stack={2,4}}}, pos={x = 520, y = 581, z = 7}},
				[20] = {reward={{id=862, stack={2,4}},{id=863, stack={2,4}},{id=860, stack={2,4}},{id=861, stack={2,4}}}, pos={x = 523, y = 581, z = 7}},
				[21] = {reward={{id=862, stack={2,4}},{id=863, stack={2,4}},{id=860, stack={2,4}},{id=861, stack={2,4}}}, pos={x = 520, y = 584, z = 7}},
				[22] = {reward={{id=862, stack={2,4}},{id=863, stack={2,4}},{id=860, stack={2,4}},{id=861, stack={2,4}}}, pos={x = 523, y = 584, z = 7}},
			}, 
			monsters = {
				[1] =  {monster={name="Gladiator Fisherman",	spawnBonus={"spell wave","fire buff"}}, pos={x = 495, y = 565, z = 7}},
				[2] =  {monster={name="Drunken Gladiator",		spawnBonus={"spell wave","fire buff"}}, pos={x = 505, y = 564, z = 7}},
				[3] =  {monster={name="Drunken Gladiator",		spawnBonus={"spell wave","fire buff"}}, pos={x = 514, y = 564, z = 7}},
				[4] =  {monster={name="Gladiator Fisherman",	spawnBonus={"spell wave","fire buff"}}, pos={x = 528, y = 564, z = 7}},
				[5] =  {monster={name="Gladiator Fisherman",	spawnBonus={"spell wave","fire buff"}}, pos={x = 539, y = 565, z = 7}},
				[6] =  {monster={name="Drunken Gladiator",		spawnBonus={"spell wave","fire buff"}}, pos={x = 545, y = 564, z = 7}},
				[7] =  {monster={name="Drunken Gladiator",		spawnBonus={"spell wave","fire buff"}}, pos={x = 547, y = 570, z = 7}},
				[8] =  {monster={name="Gladiator Fisherman",	spawnBonus={"spell wave","fire buff"}}, pos={x = 545, y = 584, z = 7}},
				[9] =  {monster={name="Drunken Gladiator",		spawnBonus={"spell wave","fire buff"}}, pos={x = 546, y = 593, z = 7}},
				[10] = {monster={name="Helmet Gladiator",		spawnBonus={"spell wave","fire buff"}}, pos={x = 547, y = 601, z = 7}},
				[11] = {monster={name="Drunken Gladiator",		spawnBonus={"spell wave","fire buff"}}, pos={x = 541, y = 601, z = 7}},
				[12] = {monster={name="Gladiator Fisherman",	spawnBonus={"spell wave","fire buff"}}, pos={x = 528, y = 602, z = 7}},
				[13] = {monster={name="Drunken Gladiator",		spawnBonus={"spell wave","fire buff"}}, pos={x = 517, y = 601, z = 7}},
				[14] = {monster={name="Gladiator Fisherman",	spawnBonus={"spell wave","fire buff"}}, pos={x = 503, y = 601, z = 7}},
				[15] = {monster={name="Drunken Gladiator",		spawnBonus={"spell wave","fire buff"}}, pos={x = 495, y = 601, z = 7}},
				[16] = {monster={name="Gladiator Fisherman",	spawnBonus={"spell wave","fire buff"}}, pos={x = 497, y = 595, z = 7}},
				[17] = {monster={name="Drunken Gladiator",		spawnBonus={"spell wave","fire buff"}}, pos={x = 496, y = 582, z = 7}},
				[18] = {monster={name="Gladiator Fisherman",	spawnBonus={"spell wave","fire buff"}}, pos={x = 496, y = 572, z = 7}},
				[19] = {monster={name="Helmet Gladiator",		spawnBonus={"spell wave","fire buff"}}, pos={x = 517, y = 570, z = 7}},
				[20] = {monster={name="Helmet Gladiator",		spawnBonus={"spell wave","fire buff"}}, pos={x = 528, y = 570, z = 7}},
				[21] = {monster={name="Gladiator Fisherman",	spawnBonus={"spell wave","fire buff"}}, pos={x = 535, y = 574, z = 7}},
				[22] = {monster={name="Helmet Gladiator",		spawnBonus={"spell wave","fire buff"}}, pos={x = 536, y = 576, z = 7}},
				[23] = {monster={name="Helmet Gladiator",		spawnBonus={"spell wave","fire buff"}}, pos={x = 540, y = 583, z = 7}},
				[24] = {monster={name="Drunken Gladiator",		spawnBonus={"spell wave","fire buff"}}, pos={x = 537, y = 590, z = 7}},
				[25] = {monster={name="Helmet Gladiator",		spawnBonus={"spell wave","fire buff"}}, pos={x = 535, y = 591, z = 7}},
				[26] = {monster={name="Helmet Gladiator",		spawnBonus={"spell wave","fire buff"}}, pos={x = 526, y = 595, z = 7}},
				[27] = {monster={name="Helmet Gladiator",		spawnBonus={"spell wave","fire buff"}}, pos={x = 514, y = 595, z = 7}},
				[28] = {monster={name="Helmet Gladiator",		spawnBonus={"spell wave","fire buff"}}, pos={x = 508, y = 590, z = 7}},
				[29] = {monster={name="Drunken Gladiator",		spawnBonus={"spell wave","fire buff"}}, pos={x = 503, y = 583, z = 7}},
				[30] = {monster={name="Drunken Gladiator",		spawnBonus={"spell wave","fire buff"}}, pos={x = 508, y = 573, z = 7}},
				[31] = {monster={name="Helmet Gladiator",		spawnBonus={"spell wave","fire buff"}}, pos={x = 548, y = 563, z = 7}},
				[32] = {monster={name="Helmet Gladiator",		spawnBonus={"spell wave","fire buff"}}, pos={x = 497, y = 602, z = 7}},
				[33] =  {monster={name="Helmet Gladiator",		spawnBonus={"spell wave","fire buff"}}, pos={x = 498, y = 565, z = 7}},
				[34] =  {monster={name="Helmet Gladiator",		spawnBonus={"spell wave","fire buff"}}, pos={x = 547, y = 556, z = 7}},
				[35] =  {monster={name="Bully Gladiator",		spawnBonus={"spell wave","fire buff"}}, pos={x = 520, y = 582, z = 7}},
				[36] =  {monster={name="Bully Gladiator",		spawnBonus={"spell wave","fire buff"}}, pos={x = 523, y = 582, z = 7}},
				[37] =  {monster={name="Gladiator Fisherman",	spawnBonus={"spell wave","fire buff"}}, pos={x = 522, y = 582, z = 7}},
				[38] =  {monster={name="Gladiator Fisherman",	spawnBonus={"spell wave","fire buff"}}, pos={x = 521, y = 583, z = 7}},
				[39] =  {monster={name="Drunken Gladiator",		spawnBonus={"spell wave","fire buff"}}, pos={x = 521, y = 581, z = 7}},
				[40] =  {monster={name="Drunken Gladiator",		spawnBonus={"spell wave","fire buff"}}, pos={x = 522, y = 584, z = 7}},
				[41] =  {monster={name="Helmet Gladiator",		spawnBonus={"spell wave","fire buff"}}, pos={x = 521, y = 587, z = 7}},
				[42] =  {monster={name="Helmet Gladiator",		spawnBonus={"spell wave","fire buff"}}, pos={x = 522, y = 587, z = 7}},
				[43] =  {monster={name="Helmet Gladiator",		spawnBonus={"spell wave","fire buff"}}, pos={x = 526, y = 582, z = 7}},
				[44] =  {monster={name="Helmet Gladiator",		spawnBonus={"spell wave","fire buff"}}, pos={x = 526, y = 583, z = 7}},
				[45] =  {monster={name="Helmet Gladiator",		spawnBonus={"spell wave","fire buff"}}, pos={x = 521, y = 578, z = 7}},
				[46] =  {monster={name="Helmet Gladiator",		spawnBonus={"spell wave","fire buff"}}, pos={x = 522, y = 578, z = 7}},
				[47] =  {monster={name="Helmet Gladiator",		spawnBonus={"spell wave","fire buff"}}, pos={x = 516, y = 582, z = 7}},
				[48] =  {monster={name="Helmet Gladiator",		spawnBonus={"spell wave","fire buff"}}, pos={x = 516, y = 583, z = 7}},
			}, 
			players = {
				[1] = {pos={x = 509, y = 564, z = 7},points=50, alphaPoints = 120},
				[2] = {pos={x = 521, y = 564, z = 7},points=40, alphaPoints = 60},
				-- [3] = {pos={x = 623, y = 564, z = 7},points=30, alphaPoints = 4},
				-- [4] = {pos={x = 636, y = 577, z = 7},points=0, alphaPoints = 2},
				-- [5] = {pos={x = 636, y = 589, z = 7},points=0, alphaPoints = 1},
				-- [6] = {pos={x = 624, y = 601, z = 7},points=0, alphaPoints = 0},
				-- [7] = {pos={x = 612, y = 601, z = 7},points=0, alphaPoints = 0},
				-- [8] = {pos={x = 600, y = 601, z = 7},points=0, alphaPoints = 0},
				-- [9] = {pos={x = 587, y = 588, z = 7},points=0, alphaPoints = 0},
				-- [10] = {pos={x = 587, y = 576, z = 7},points=0, alphaPoints = 0}
			},
			playerEvents = {"event_zone_damage"},
			doors = {
				[1] = {pos={x = 509, y = 567, z = 7}},
				[2] = {pos={x = 522, y = 567, z = 7}},
				[3] = {pos={x = 533, y = 567, z = 7}},
				[4] = {pos={x = 543, y = 576, z = 7}},
				[5] = {pos={x = 543, y = 589, z = 7}},
				[6] = {pos={x = 534, y = 598, z = 7}},
				[7] = {pos={x = 522, y = 598, z = 7}},
				[8] = {pos={x = 509, y = 598, z = 7}},
				[9] = {pos={x = 500, y = 589, z = 7}},
				[10] = {pos={x = 500, y = 577, z = 7}},
			}, 
			level = {1,100}, 
			roomFrom = {x = 493, y = 560, z = 7}, 
			roomTo = {x = 550, y = 605, z = 7},
			stage = 1,
			stages = {
				{
					duration = 120,
				},
				{
					hpDamagePerTick = 50,
					duration = 120,
					zones = {
						{from = {x = 501, y = 568, z = 7}, to = {x = 542, y = 597, z = 7}}
					},
				}, 
				{
					hpDamagePerTick = 75,
					duration = 120,
					zones = {
						{from = {x = 506, y = 579, z = 7}, to = {x = 511, y = 586, z = 7}},
						{from = {x = 512, y = 573, z = 7}, to = {x = 531, y = 592, z = 7}},
						{from = {x = 532, y = 579, z = 7}, to = {x = 537, y = 586, z = 7}}
					},
				},
				{
					hpDamagePerTick = 100,
					zones = "all",
				},
			},
		},

		[2] = { offset={90,0}, copyId=1 },
		[3] = { offset={180,0}, copyId=1 },
		[4] = { offset={270,0}, copyId=1 },
		[5] = { offset={360,0}, copyId=1 },
		[6] = { offset={-90,0}, copyId=1 },
		[7] = { offset={-180,0}, copyId=1 },
		[8] = { offset={-270,0}, copyId=1 },
		[9] = { offset={-360,0}, copyId=1 },	
		[10] = { offset={90,-70}, copyId=1 },
		[11] = { offset={180,-70}, copyId=1 },
		[12] = { offset={270,-70}, copyId=1 },
		[13] = { offset={360,-70}, copyId=1 },
		[14] = { offset={-90,-70}, copyId=1 },
		[15] = { offset={-180,-70}, copyId=1 },
		[16] = { offset={-270,-70}, copyId=1 },
		[17] = { offset={-360,-70}, copyId=1 },
		
		--[[]--------------------------------------------------------------------------------------------------------------------------------------------
		-------------------------------------------------------------------------------------------------------------------------------------------------
		x4 All vs All
		-------------------------------------------------------------------------------------------------------------------------------------------------
		--]]---------------------------------------------------------------------------------------------------------------------------------------------
		
		[18] = { 
			name="x4 All vs All", 
			eventStartTimer = 10,
			chests = {
				[1] = {reward={{id=862, stack={2,4}},{id=863, stack={2,4}}}, pos={x = 251, y = 675, z = 7}},
				[2] = {reward={{id=862, stack={2,4}},{id=863, stack={2,4}}}, pos={x = 252, y = 675, z = 7}},
				[3] = {reward={{id=862, stack={2,4}},{id=863, stack={2,4}}}, pos={x = 288, y = 675, z = 7}},
				[4] = {reward={{id=862, stack={2,4}},{id=863, stack={2,4}}}, pos={x = 289, y = 675, z = 7}},
				[5] = {reward={{id=862, stack={2,4}},{id=863, stack={2,4}}}, pos={x = 269, y = 656, z = 7}},
				[6] = {reward={{id=862, stack={2,4}},{id=863, stack={2,4}}}, pos={x = 269, y = 657, z = 7}},
				[7] = {reward={{id=862, stack={2,4}},{id=863, stack={2,4}}}, pos={x = 269, y = 694, z = 7}},
				[8] = {reward={{id=862, stack={2,4}},{id=863, stack={2,4}}}, pos={x = 269, y = 695, z = 7}},
				[9] = {reward={{id=862, stack={2,4}},{id=863, stack={2,4}}}, pos={x = 269, y = 675, z = 7}},
				[10] = {reward={{id=862, stack={2,4}},{id=863, stack={2,4}}}, pos={x = 272, y = 678, z = 7}},
			}, 
			monsters = {
				[1] = {monster={name="Gladiator Fisherman",spawnBonus={"spell wave","fire buff"}}, pos={x = 251, y = 676, z = 7}},
				[2] = {monster={name="Gladiator Fisherman",spawnBonus={"spell wave","fire buff"}}, pos={x = 289, y = 676, z = 7}},
				[3] = {monster={name="Gladiator Fisherman",spawnBonus={"spell wave","fire buff"}}, pos={x = 270, y = 695, z = 7}},
				[4] = {monster={name="Gladiator Fisherman",spawnBonus={"spell wave","fire buff"}}, pos={x = 270, y = 657, z = 7}},
			}, 
			players = {
				[1] = {pos={x = 241, y = 676, z = 7}, points = 50, alphaPoints = 40},
				[2] = {pos={x = 270, y = 704, z = 7}, points = 40, alphaPoints = 20},
				[3] = {pos={x = 300, y = 676, z = 7}, points = 30, alphaPoints = 10},
				[4] = {pos={x = 270, y = 647, z = 7}, points = 20, alphaPoints = 0},
			}, 
			playerEvents = {"event_zone_damage"},
			doors = {
				[1] = {pos={x = 243, y = 677, z = 7}},
				[2] = {pos={x = 271, y = 703, z = 7}},
				[3] = {pos={x = 298, y = 677, z = 7}},
				[4] = {pos={x = 271, y = 649, z = 7}},
			}, 
			level = {1,100}, 
			roomFrom = {x = 238, y = 644, z = 7}, 
			roomTo = {x = 304, y = 708, z = 7},
			stage = 1,
			stages = {
				{
					duration = 30,
				},
				{
					hpDamagePerTick = 50,
					duration = 150,
					zones = {
						{from = {x = 261, y = 667, z = 7}, to = {x = 280, y = 686, z = 7}}
					},
				}, 
				{
					hpDamagePerTick = 100,
					zones = "all",
				},
			},
		},
			
		[19] = { offset={90,0}, copyId=18 },
		[20] = { offset={180,0}, copyId=18 },
		[21] = { offset={270,0}, copyId=18 },
		[22] = { offset={360,0}, copyId=18 },
		[23] = { offset={450,0}, copyId=18 },
		[24] = { offset={540,0}, copyId=18 },
		[25] = { offset={630,0}, copyId=18 },
		[26] = { offset={90,80}, copyId=18 },
		[27] = { offset={180,80}, copyId=18 },
		[28] = { offset={270,80}, copyId=18 },
		[29] = { offset={360,80}, copyId=18 },
		[30] = { offset={450,80}, copyId=18 },
		[31] = { offset={540,80}, copyId=18 },
		[32] = { offset={630,80}, copyId=18 },
		
		--[[]--------------------------------------------------------------------------------------------------------------------------------------------
		-------------------------------------------------------------------------------------------------------------------------------------------------
		1 vs 1
		-------------------------------------------------------------------------------------------------------------------------------------------------
		--]]---------------------------------------------------------------------------------------------------------------------------------------------
		
		[33] = { 
			name="1 vs 1", 
			eventStartTimer = 10,
			chests = {
				[1] = {reward={{id=862, stack={1,3}},{id=863, stack={1,3}},{id=860, stack={1,3}},{id=861, stack={1,3}}}, pos={x = 259, y = 820, z = 7}},
				[2] = {reward={{id=862, stack={2,4}},{id=863, stack={2,4}},{id=860, stack={2,4}},{id=861, stack={2,4}}}, pos={x = 269, y = 820, z = 7}},
				[3] = {reward={{id=862, stack={2,4}},{id=863, stack={2,4}},{id=860, stack={2,4}},{id=861, stack={2,4}}}, pos={x = 307, y = 820, z = 7}},
				[4] = {reward={{id=862, stack={1,3}},{id=863, stack={1,3}},{id=860, stack={1,3}},{id=861, stack={1,3}}}, pos={x = 319, y = 820, z = 7}},
			}, 
			monsters = {
				[1] = {monster={name="Helmet Gladiator",spawnBonus={"spell wave","fire buff"}}, pos={x = 259, y = 821, z = 7}},
				[2] = {monster={name="Helmet Gladiator",spawnBonus={"spell wave","fire buff"}}, pos={x = 319, y = 821, z = 7}},
			}, 
			players = {
				[1] = {pos={x = 330, y = 821, z = 7}, points = 50, alphaPoints = 20},
				[2] = {pos={x = 249, y = 821, z = 7}, points = 25, alphaPoints = 0},
			}, 
			doors = {
				[1] = {pos={x = 251, y = 822, z = 7}},
				[2] = {pos={x = 328, y = 822, z = 7}},
			}, 
			level = {1,100}, 
			roomFrom = {x = 246, y = 809, z = 7}, 
			roomTo = {x = 334, y = 834, z = 7},
			
			rewards = {
			             --[1] = { type = "alpha points", count = 100 },
				         -- [2] = { type = "item", id = 875, count = 7 },
						 -- [3] = { type = "item", id = 874, count = 20 },
						 -- [4] = { type = "item", id = 873, count = 30 },
					  }
		},
			
		[34] = { offset={110,0}, copyId=33},
		[35] = { offset={220,0}, copyId=33 },
		[36] = { offset={330,0}, copyId=33 },
		[37] = { offset={440,0}, copyId=33 },
		[38] = { offset={550,0}, copyId=33 },
		[39] = { offset={660,0}, copyId=33 },
		[40] = { offset={110,50}, copyId=33 },
		[41] = { offset={220,50}, copyId=33 },
		[42] = { offset={330,50}, copyId=33 },
		[43] = { offset={440,50}, copyId=33 },
		[44] = { offset={550,50}, copyId=33 },
		[45] = { offset={660,50} , copyId=33 },
		
		--[[]--------------------------------------------------------------------------------------------------------------------------------------------
		-------------------------------------------------------------------------------------------------------------------------------------------------
		Rival
		-------------------------------------------------------------------------------------------------------------------------------------------------
		--]]---------------------------------------------------------------------------------------------------------------------------------------------
		
		[46] = { 
			name="Rival", 
			eventStartTimer = 10,
			players = {
				[1] = {pos={x = 249, y = 1015, z = 7}, points = 50, alphaPoints = 0},
                [2] = {pos={x = 273, y = 1014, z = 7}, points = 25, alphaPoints = 0},
			}, 
			rewards = {
					  },
			doors = {
				[1] = {pos={x = 252, y = 1015, z = 7}},
				[2] = {pos={x = 270, y = 1014, z = 7}},
			},
			barrels = {
				[1] = {pos={x = 255, y = 1011, z = 7}},
				[2] = {pos={x = 255, y = 1018, z = 7}},
				[3] = {pos={x = 258, y = 1012, z = 7}},
				[4] = {pos={x = 258, y = 1017, z = 7}},
				[5] = {pos={x = 261, y = 1009, z = 7}},
				[6] = {pos={x = 261, y = 1020, z = 7}},
				[7] = {pos={x = 264, y = 1012, z = 7}},
				[8] = {pos={x = 264, y = 1017, z = 7}},
				[9] = {pos={x = 267, y = 1011, z = 7}},
				[10] = {pos={x = 267, y = 1018, z = 7}},
			},
			level = {1,100}, 
			roomFrom = {x = 246, y = 1004, z = 7}, 
			roomTo = {x = 276, y = 1024, z = 7},
			spontaneousChests = {},
			spontaneousChestRewards = {
				860, 861, 862, 863
			},
		},
		
		[47] = { offset={40,0}, copyId=46},
		[48] = { offset={80,0}, copyId=46},
		[49] = { offset={120,0}, copyId=46},
		[50] = { offset={160,0}, copyId=46},
		[51] = { offset={200,0}, copyId=46},
		[52] = { offset={240,0}, copyId=46},
		[53] = { offset={280,0}, copyId=46},
		[54] = { offset={320,0}, copyId=46},
		[55] = { offset={360,0}, copyId=46},
		[56] = { offset={400,0}, copyId=46},
		[57] = { offset={440,0}, copyId=46},
		[58] = { offset={480,0}, copyId=46},
		[59] = { offset={520,0}, copyId=46},
		[60] = { offset={560,0}, copyId=46},
		[61] = { offset={600,0}, copyId=46},
		[62] = { offset={640,0}, copyId=46},
		[63] = { offset={680,0}, copyId=46},
		
		--[[]--------------------------------------------------------------------------------------------------------------------------------------------
		-------------------------------------------------------------------------------------------------------------------------------------------------
		Racing
		-------------------------------------------------------------------------------------------------------------------------------------------------
		--]]---------------------------------------------------------------------------------------------------------------------------------------------
		
		[64] = { 
			name="Racing", 
			eventStartTimer = 15,
			players = {
				[1] = {pos={x = 260, y = 1227, z = 7}, points=30, skipRoomScan = true},
				[2] = {pos={x = 262, y = 1227, z = 7}, points=20, skipRoomScan = true},
			}, 
			stepIn = {
				[1] = {pos={x = 259, y = 1225, z = 7}},
				[2] = {pos={x = 260, y = 1225, z = 7}},
				[3] = {pos={x = 261, y = 1225, z = 7}},
				[4] = {pos={x = 262, y = 1225, z = 7}},
				[5] = {pos={x = 263, y = 1225, z = 7}},
			}, 
			stepOut = {
				[1] = {pos={x = 508, y = 1065, z = 7}},
				[2] = {pos={x = 508, y = 1066, z = 7}},
				[3] = {pos={x = 508, y = 1067, z = 7}},
				[4] = {pos={x = 508, y = 1068, z = 7}},
				[5] = {pos={x = 508, y = 1069, z = 7}},
			}, 
			level = {1,100}, 
			roomFrom = {x = 250, y = 1053, z = 7}, 
			roomTo = {x = 525, y = 1237, z = 7}
		},
		
	},
}