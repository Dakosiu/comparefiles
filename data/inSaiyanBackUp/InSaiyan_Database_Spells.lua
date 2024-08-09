 --[[ Spell Config Guide
[STR] = {                           spellName
    spellSV = INT,                  0 >= means spell is learned?| also holds spell cooldown
	goldCost = INT					spell master shop price in gold bars
    dontDeleteItem = false			if you want to keep the item then use true
	func = STR,                     Function used when cast requirements are met
    word = STR,                     Words to cast the spell | make sure its same word in talkactions
    manaCost = INT/STR or 0         Amount of mana that the spell costs (INT for amount, STRING for % of max mana) 
    healthCost = INT/STR or 0       Amount of health that the spell costs (INT for amount, STRING for % of max health) 
    cooldown = INT or 1             How many seconds player has to wait before he can cast the spell again
    targetRequired = false          If true then player has to choose target
    range = INT or 7           		maximum distance between target
	
    min_L = INT or 0                minimum player level required to cast a spell
    min_mL = INT or 0               minimum magic level required to cast a spell
    min_dL = INT or 0               minimum distance level required to cast a spell
    min_sL = INT or 0               minimum shielding level required to cast a spell
    min_swL = INT or 0              minimum sword level required to cast a spell
    min_aL = INT or 0               minimum axe level required to cast a spell
    min_cL = INT or 0               minimum club level required to cast a spell
    min_fL = INT or 0               minimum fistfighting level required to cast a spell
    
    shareCD = {INT or STR}          Puts same cooldown on other specfied spells | STR = spellName, INT = spellSV
    vocation = {STR} or "all"       Vocations which can cast the spell | STR = vocation name

    slot = {                            
        [INT] = {                   INT = what is the number of slot it checks
            items = {INT, {INT}},   INT = itemID | can put table of items inside items
            count = INT or 1        How many items has to be in that slot
            failText = STR,         Text what appears if condition is not met | DEFAULT = "you are missing item"
            remove = false,         Items are removed?
        },
    },

    bagItems = {{
        itemID = INT,               
        count = INT or 1            How many items has to be in that slot
        failText = STR,             Text what appears if condition is not met | DEFAULT = "you are missing item"
        remove = false,             Items are removed?
    }}

    other = {}                      in here write you can add as many custom keywords you need. used for detail spell configurations

    formula = {                     function spellcast_calculateFormula(player, spellT)
        [INT/STR] = {               returnValue position/key | {[INT/STR] = calucaltedAmount}
            min = STR        
            max = STR or min   
        },
    },                              
                                    bonus modifiers for formulas:
                                    L = player level
                                    mL = magic level
                                    sL = shielding level
                                    dL = distance level
                                    swL = sword level
                                    aL = axe level
                                    cL = club level
                                    fL = fist fighting level
                                    atk = weapon attack
                                    def_w = weapon defence
                                    def_s = shield defence
                                    def = def_w + def_s
                                    armor = total armor of player
                                    armor_head = helmet armor
                                    armor_legs =
                                    armor_feet =
                                    armor_body = 
                                    
                                    EXAMPLES:
                                    "L*10 + mL*10 + 50 / sL*2*dL"
                                    "atk*10 + (aL*10 - 50*def)"
                                    "(5 + sL*3) - (L*0.5 - dL)"
    -- AUTOMATIC
    spellName = STR                 same with table key
									
		conditionVariables = {
		["kill"] = {},
		["cast"] = {},
		["passive"] = {name="passive",immune=30},
		["timeDuration"] = {name="timeDuration",duration=5,immune=30},
		["dmgDuration"] = {},
		["basicAttackDuration"] = {},
		["onHit"] = {name="onHit",count=3,repetitive=50,origin={ORIGIN_RANGED},hitEffect=48},
		["chance"] = {},
		["health"] = {},
		["ki"] = {},
		},
		bonusAttributes = {
		[1] = {"Cooldown"},
		[2] = {"Damage"},
		[3] = {"useReduce"},
		[4] = {"conditionBuff"},
		[4] = {"Regeneration"},
		[5] = {"Area Change","x5"},
		[6] = {"Stun"},
		[7] = {"Silence", target=true,damage=false,mute=false, duration=5 },
		[8] = {"Push"},
		[9] = {"movementSpeed"},
		[10] = {"Spawn"},
		[11] = {"Mark"},
		[12] = {"Provocation", range=6, limit=0, useTime=10, resistance=60},
		[13] = {"Absorb"},
		[14] = {attr="Ghost", shader="", duration=5},
		[15] = {"Jump"},
		[16] = {"Teleport"},
		[17] = {"Cleanse"},
		[18] = {"Chain"},
		[19] = {"Dodge"},
		[20] = {"Passive"},
		},
}
]]

Wikipedia = {}
Wikipedia.storageTable = {
    ["IntegerIndicator"] = 30000,--dont remove
	
    ["Giant T Sword"] = 30001,
    ["Teleport"] = 30002,
    ["Summoned Ancestral Swords"] = 30003,
    ["Dash"] = 30004,
    ["Goat Push"] = 30005,
    ["Gravity Artifact"] = 30006,
	
}

Wikipedia.Spells = {
	--TESTING--
	["Fire Storm"] = {
        func = "spell_aoe",
        word = "fire storm",
		vocation = {"sorcerer", "master sorcerer","knight"},
		cooldown = 5,
		manaCost = 1,
		-- aggressive = true,
		aggressive = false,
		-- targetRequired = true,
		targetRequired = false,
		min_L = 1,
		spellGroup = 1,
		groupCooldown = 2,
		areaVariables = {
		["Default0"] = { {timeZones={1},effect={0,0,11},dmg="dmg",attr={1}},{timeZones={4,300},effect={0,48},dmg="1"} },
		["1"] = { effect={7}}

		},
		areas = {
		-- ["Default"] = {{0}}
			["Default"] = {
				{"2","x","x","x","x","1","x","x","x","x","8"},
				{"x","2","x","x","x","1","x","x","x","8","x"},
				{"x","x","2","x","x","1","x","x","8","x","x"},
				{"x","x","x","2","x","1","x","8","x","x","x"},
				{"x","x","x","x","2","1","8","x","x","x","x"},
				{"3","3","3","3","3", 0 ,"7","7","7","7","7"},
				{"x","x","x","x","4","5","6","x","x","x","x"},
				{"x","x","x","4","x","5","x","6","x","x","x"},
				{"x","x","4","x","x","5","x","x","6","x","x"},
				{"x","4","x","x","x","5","x","x","x","6","x"},
				{"4","x","x","x","x","5","x","x","x","x","6"},
			}
		},
        formula = {
            ["1"] = {min = "1", max = "1"},
            ["dmg"] = {min = "(100 + L*1)*(1+(mL/100))", max = "(133 + L*2)*(1+(mL/100))"},
        },
		bonusAttributes = {
		[1] = {attr="playerMark", condition={name="timeDuration",duration=15}, meleeValue=-5, ammount=1, maxAmmount=5, meleePercent=110, spellValue=-5, spellPercent=110},
		}
	},
	["Fire Stormer"] = {
        func = "spell_aoe",
        word = "fire stormer",
		vocation = {"sorcerer", "master sorcerer","knight"},
		cooldown = 5,
		manaCost = 1,
		-- aggressive = true,
		aggressive = false,
		min_L = 1,
		spellGroup = 1,
		groupCooldown = 2,
		areaVariables = {
		["Default0"] = { {timeZones={1},cast="staticDirection",effect={},dmg="dmg",attr={"2"}}},
		["1"] = { {timeZones={20},cast="staticDirection",effect={48},dmg="dmg",attr={"1"}}},
		["2"] = { {timeZones={20},cast="staticDirection",effect={48},dmg="dmg",attr={"1"}}},
		["3"] = { {timeZones={20},cast="staticDirection",effect={48},dmg="dmg",attr={"1"}}},
		["4"] = { {timeZones={20},cast="staticDirection",effect={48},dmg="dmg",attr={"1"}}},
		["5"] = { {timeZones={20},cast="staticDirection",effect={48},dmg="dmg",attr={"1"}}},
		["6"] = { {timeZones={20},cast="staticDirection",effect={48},dmg="dmg",attr={"1"}}},
		["7"] = { {timeZones={20},cast="staticDirection",effect={48},dmg="dmg",attr={"1"}}},
		["8"] = { {timeZones={20},cast="staticDirection",effect={48},dmg="dmg",attr={"1"}}}
		},
		areas = {
		["Default"] = {
			{"2","x","x","x","x","1","x","x","x","x","8"},
			{"x","2","x","x","x","1","x","x","x","8","x"},
			{"x","x","2","x","x","1","x","x","8","x","x"},
			{"x","x","x","2","x","1","x","8","x","x","x"},
			{"x","x","x","x","2","1","8","x","x","x","x"},
			{"3","3","3","3","3", 0 ,"7","7","7","7","7"},
			{"x","x","x","x","4","5","6","x","x","x","x"},
			{"x","x","x","4","x","5","x","6","x","x","x"},
			{"x","x","4","x","x","5","x","x","6","x","x"},
			{"x","4","x","x","x","5","x","x","x","6","x"},
			{"4","x","x","x","x","5","x","x","x","x","6"},
		}
		},
        formula = {
            ["1"] = {min = "1", max = "1"},
            ["dmg"] = {min = "(100 + L*1)*(1+(mL/100))", max = "(133 + L*2)*(1+(mL/100))"},
        },
		bonusAttributes = {
		["1"] = {attr="playerMark", condition={name="timeDuration",duration=15}, meleeValue=-5, ammount=1, maxAmmount=5, meleePercent=110, spellValue=-5, spellPercent=110},
		["2"] = {attr="spell_indicator", condition={name="timeDuration",duration=2}},
		}
	},
	["Fire mouser"] = {
        func = "spell_aoe",
        word = "fire mouser",
		vocation = {"sorcerer", "master sorcerer","knight"},
		cooldown = 1,
		manaCost = 1,
		aggressive = true,
		min_L = 1,
		spellGroup = 1,
		groupCooldown = 2,
		areaVariables = {
		["Default0"] = { {timeZones={1},cast="staticDirection",effect={},attr={"2"}}},
		["Target0"] = { {timeZones={1},cast="adapt",effect={48,48,11,11},dmg="dmg",attr={"3"}}},
		["1"] = { {timeZones={1,20},cast="staticDirection",effect={},attr={"2"}}},
		["2"] = { {timeZones={1,20},cast="staticDirection",effect={},attr={"2"}}},
		["3"] = { {timeZones={1,20},cast="staticDirection",effect={},attr={"2"}}},
		["4"] = { {timeZones={1,20},cast="staticDirection",effect={},attr={"2"}}},
		["5"] = { {timeZones={1,20},cast="staticDirection",effect={},attr={"2"}}},
		["6"] = { {timeZones={1,20},cast="staticDirection",effect={},attr={"2"}}},
		["7"] = { {timeZones={1,20},cast="staticDirection",effect={},attr={"2"}}},
		["8"] = { {timeZones={1,20},cast="staticDirection",effect={},attr={"2"}}}
		},
		areas = {
		["Default"] = {
			{"2","x","x","x","x","1","x","x","x","x","8"},
			{"x","2","x","x","x","1","x","x","x","8","x"},
			{"x","x","2","x","x","1","x","x","8","x","x"},
			{"x","x","x","2","x","1","x","8","x","x","x"},
			{"x","x","x","x","2","1","8","x","x","x","x"},
			{"3","3","3","3","3", 0 ,"7","7","7","7","7"},
			{"x","x","x","x","4","5","6","x","x","x","x"},
			{"x","x","x","4","x","5","x","6","x","x","x"},
			{"x","x","4","x","x","5","x","x","6","x","x"},
			{"x","4","x","x","x","5","x","x","x","6","x"},
			{"4","x","x","x","x","5","x","x","x","x","6"},
		},

		["Target"] = {{0}}
		},
        formula = {
            ["1"] = {min = "1", max = "1"},
            ["dmg"] = {min = "(100 + L*1)*(1+(mL/100))", max = "(133 + L*2)*(1+(mL/100))"},
        },
		bonusAttributes = {
		["1"] = {attr="spell_casting", condition={name="timeDuration",duration=2}},
		["2"] = {attr="spell_mouseInteraction", condition={name="timeDuration",duration=2},areaSpawn="Target",onlyCaster=true},
		["3"] = {attr="teleport", condition={name="creatureAction",repeatValue=1,repeatTime=0},emptyTargetCast=true},
		}
	},
	["Fire tracker"] = {
        func = "spell_aoe",
        word = "fire tracker",
		vocation = {"sorcerer", "master sorcerer","knight"},
		cooldown = 5,
		manaCost = 1,
		aggressive = true,
		min_L = 1,
		spellGroup = 1,
		groupCooldown = 2,
		areaVariables = {
		["Default0"] = { {timeZones={1},cast="staticDirection",effect={},attr={"2","5"}}},
		["Target0"] = { {timeZones={1},cast="adapt",effect={48,48,11,11},dmg="dmg",attr={"4"}}},
		["1"] = { {timeZones={1,51},cast="staticDirection",effect={},attr={"2"}}},
		["2"] = { {timeZones={1,51},cast="staticDirection",effect={},attr={"2"}}},
		["3"] = { {timeZones={1,51},cast="staticDirection",effect={},attr={"2"}}},
		["4"] = { {timeZones={1,51},cast="staticDirection",effect={},attr={"2"}}},
		["5"] = { {timeZones={1,51},cast="staticDirection",effect={},attr={"2"}}},
		["6"] = { {timeZones={1,51},cast="staticDirection",effect={},attr={"2"}}},
		["7"] = { {timeZones={1,51},cast="staticDirection",effect={},attr={"2"}}},
		["8"] = { {timeZones={1,51},cast="staticDirection",effect={},attr={"2"}}}
		},
	areas = {
		["Default"] = {
			{"2","x","x","x","x","1","x","x","x","x","8"},
			{"x","2","x","x","x","1","x","x","x","8","x"},
			{"x","x","2","x","x","1","x","x","8","x","x"},
			{"x","x","x","2","x","1","x","8","x","x","x"},
			{"x","x","x","x","2","1","8","x","x","x","x"},
			{"3","3","3","3","3", 0 ,"7","7","7","7","7"},
			{"x","x","x","x","4","5","6","x","x","x","x"},
			{"x","x","x","4","x","5","x","6","x","x","x"},
			{"x","x","4","x","x","5","x","x","6","x","x"},
			{"x","4","x","x","x","5","x","x","x","6","x"},
			{"4","x","x","x","x","5","x","x","x","x","6"},
		},
		["Target"] = {{0}}
		},
        formula = {
            ["1"] = {min = "1", max = "1"},
            ["dmg"] = {min = "(100 + L*1)*(1+(mL/100))", max = "(133 + L*2)*(1+(mL/100))"},
        },
		bonusAttributes = {
		["2"] = {attr="spell_mouseTracking", condition={name="timeDuration",duration=5},areaSpawn="Target",onlyCaster=true},--walk importance 0=idle/1=walk/2=push/3=useItem/4=teleport
		["3"] = {attr="teleport", condition={name="creatureAction",importance=2,repeatValue=0,repeatTime=0,repeatChance=0,actionDelay=0},emptyTargetCast=true},--animation importance 0=idle/1=walk/2=push/3=useItem/4=teleport/5=spell
		["4"] = {attr="push", condition={name="creatureAction",importance=99},hitBlockedTile="Stun"},--hitBlockedTile="Stop"/ "Stun"/"Ghost"/"passDMGbehindCreatureWithMultiplierStacks"/"areaCast"/"grab"/""
		["5"] = {attr="creature_animation", condition={name="creatureAction",importance=99}, looktype={54,55,56,57}, animationDuration=1000},
		}
	},


	
	
	--MAGE--
	["Giant T Sword"] = {
        func = "spell_aoe",
        word = "giant t sword",
		vocation = {"mage", "master mage","sorcerer","knight"},
		cooldown = 5,
		manaCost = 1,
		aggressive = true,
		min_L = 1,
		spellGroup = 1,
		groupCooldown = 2,
		areaVariables = {
		-- ["Default0"] = { {timeZones={1},effect={35},attr={"1","animation"}}},
		["Default0"] = { {timeZones={1},effect={35}}},
		["n"] = { {timeZones={1},cast="adapt",castDirections={0},effect={5}}},--trigger sword effect
		["e"] = { {timeZones={1},cast="adapt",castDirections={1},effect={8}}},--trigger sword effect
		["s"] = { },--trigger sword effect
		["1s"] = { {timeZones={1},cast="adapt",effect={},dmg="dmg"}, {timeZones={1},cast="adapt",castDirections={2},effect={6}} },--invisible dmg
		["w"] = { {timeZones={1},cast="adapt",castDirections={3},effect={7}}},--trigger sword effect
		-- ["1"] = { {timeZones={1},cast="adapt",effect={38},dmg="dmg"}},--invisible dmg
		["2"] = { {timeZones={6},cast="adapt"},{timeZones={6},cast="adapt",dmg="+30%"}}--explosion
		},
	areas = {
		["Default"] = {
			{"x","x","x","x","x","x","x","x","x","x","x"},
			{"x","x","x","x","x","x","x","x","x","x","x"},
			{"x","x","x","x","x","x","x","x","x","x","x"},
			{"x","x","x","x","x","2","x","x","x","x","x"},
			{"x","x","x","2","2","2","2","2","x","x","x"},
			{"x","x","x","x","x","1","x","x","x","x","x"},
			{"x","x","x","x","x","1","x","x","x","x","x"},
			{"x","x","x","x","x","1","x","x","x","x","x"},
			{"x","x","x","x","w","1s","n","x","x","x","x"},
			{"x","x","x","x","x", 0 ,"x","x","x","x","x"},
			{"x","x","x","x","x","x","x","x","x","x","x"},
			{"x","x","x","x","x","x","x","x","x","x","x"},
		},
		},
        formula = {
            ["1"] = {min = "1", max = "1"},
            ["dmg"] = {min = "(100 + L*1)*(1+(mL/100))", max = "(133 + L*2)*(1+(mL/100))"},
            ["+30%"] = {min = "(130 + L*1)*(1+(mL/130))", max = "(175 + L*2)*(1+(mL/175))"},
        },
		bonusAttributes = {
		["1"] = {attr="spell_indicator", condition={name="timeDuration",duration=5},onlyCaster=true},
		-- ["animation"] = {attr="creature_animation", condition={name="creatureAction",importance=99}, looktype={5,5,5,5}, animationDuration=1000},
	
	}
	},
	["Teleport"] = {
        func = "spell_aoe",
        word = "teleport",
		vocation = {"sorcerer","knight","mage", "master mage"},
		cooldown = 5,
		manaCost = 1,
		aggressive = true,
		min_L = 1,
		spellGroup = 1,
		groupCooldown = 2,
		areaVariables = {
		["Default0"] = { {timeZones={1},effect={13},attr={"1"}}},
		["e"] = { {timeZones={1},cast="staticDirection"}},
		["t"] = { {timeZones={1,30},attr={"1"}}},--throw sword indicator
		["Target0"] = { {timeZones={1},cast="caster",attr={"2"}},{timeZones={1,31},cast="static",effect={18}},{timeZones={31},cast="static",effect={0,0,11,11},attr={"3"}}}, -- throwed sword 3s duration effect
		},
	areas = {
		["Default"] = {
			{"t","t","t","t","t","t","t","t", "t" ,"t","t","t","t","t","t","t","t"},
			{"t","t","t","t","t","t","t","t", "t" ,"t","t","t","t","t","t","t","t"},
			{"t","t","t","t","t","t","t","t", "t" ,"t","t","t","t","t","t","t","t"},
			{"t","t","t","t","t","t","t","t", "t" ,"t","t","t","t","t","t","t","t"},
			{"t","t","t","t","t","t","t","t", "t" ,"t","t","t","t","t","t","t","t"},
			{"t","t","t","t","t","t","t","t", "t" ,"t","t","t","t","t","t","t","t"},
			{"t","t","t","t","t","t","t","t",  0  ,"t","t","t","t","t","t","t","t"},
			{"t","t","t","t","t","t","t","t", "t" ,"t","t","t","t","t","t","t","t"},
			{"t","t","t","t","t","t","t","t", "t" ,"t","t","t","t","t","t","t","t"},
			{"t","t","t","t","t","t","t","t", "t" ,"t","t","t","t","t","t","t","t"},
			{"t","t","t","t","t","t","t","t", "t" ,"t","t","t","t","t","t","t","t"},
			{"t","t","t","t","t","t","t","t", "t" ,"t","t","t","t","t","t","t","t"},
			{"t","t","t","t","t","t","t","t", "t" ,"t","t","t","t","t","t","t","t"},
		},
		["Target"] = {{0}}
		},
        formula = {
            ["1"] = {min = "1", max = "1"},
            ["dmg"] = {min = "(100 + L*1)*(1+(mL/100))", max = "(133 + L*2)*(1+(mL/100))"},
            ["+30%"] = {min = "(130 + L*1)*(1+(mL/130))", max = "(175 + L*2)*(1+(mL/175))"},
        },
		bonusAttributes = {
		["1"] = {attr="spell_mouseInteraction", condition={name="timeDuration",duration=3},areaSpawn="Target",onlyCaster=true},
		["3"] = {attr="teleport", condition={name="creatureAction",importance=2,repeatValue=0,repeatTime=0,repeatChance=0,actionDelay=0},emptyTargetCast=true},
		["2"] = {attr="Silence", damage=true, condition={name="timeDuration",duration=3}},
	}
	},
	["Summoned Ancestral Swords"] = {
        func = "spell_aoe",
        word = "summoned ancestral swords",
		vocation = {"mage", "master mage","sorcerer","knight"},
		cooldown = 5,
		manaCost = 1,
		aggressive = true,
		min_L = 1,
		spellGroup = 1,
		groupCooldown = 2,
		areaVariables = {
		["1"] = { {timeZones={1},cast="adapt",dmg="dmg"}},--invisible dmg
		["2"] = { {timeZones={1},cast="adapt",dmg="+30%"}},--explosion
		["3"] = { {timeZones={1},cast="adapt",dmg="+30%",effect={{21,19,22,20}}}},--explosion
		},
	areas = {
		["Default"] = {
			{"x","x", "2" ,"x","x"},
			{"x","x", "1" ,"x","x"},
			{"x","x", "3" ,"x","x"},
			{"x","x",  0  ,"x","x"},
		},
		},
        formula = {
            ["1"] = {min = "1", max = "1"},
            ["dmg"] = {min = "(100 + L*1)*(1+(mL/100))", max = "(133 + L*2)*(1+(mL/100))"},
            ["+30%"] = {min = "(130 + L*1)*(1+(mL/130))", max = "(175 + L*2)*(1+(mL/175))"},
        },
		bonusAttributes = {
	}
	},
	
	
	
	--ARCHER--
	["Dash"] = {
        func = "spell_aoe",
        word = "dash",
		vocation = {"archer","knight","eagle eye"},
		cooldown = 5,
		manaCost = 1,
		aggressive = true,
		min_L = 1,
		spellGroup = 1,
		groupCooldown = 2,
		areaVariables = {["Default0"] = { {timeZones={1},cast="adapt",attr={"1"}} }},
		areas = { ["Default"] = {{0}} },
        formula = { ["dmg"] = {min = "(100 + L*1)*(1+(mL/100))", max = "(133 + L*2)*(1+(mL/100))"} },
		bonusAttributes = { ["1"] = {attr="Jump", condition={name="onHit",count=1,repetitive=3,origin={ORIGIN_RANGED},hitEffect={14,17,15,16}}} }
	},
	["Goat Push"] = {
        func = "spell_aoe",
        word = "goat push",
		vocation = {"archer", "knight","eagle eye"},
		cooldown = 1,
		manaCost = 1,
		aggressive = true,
		min_L = 1,
		spellGroup = 1,
		groupCooldown = 2,
		areaVariables = {
		["e"] = { {timeZones={1},cast="staticDirection",effect={11}}},
		["10"] = { {timeZones={1},cast="staticDirection",dmg="dmg",attr={"e"}}},
		["10"] = { {timeZones={3},cast="staticDirection",dmg="dmg",attr={"e"}}},
		["11"] = { {timeZones={5},cast="staticDirection",dmg="dmg",attr={"e"}}},
		["12"] = { {timeZones={7},cast="staticDirection",dmg="dmg",attr={"e"}}},
		["13"] = { {timeZones={9},cast="staticDirection",dmg="dmg",attr={"e"}}},
		["w"] = { {timeZones={1},cast="staticDirection",dmg="dmg",effect={12},attr={"w"}}},
		["2"] = { {timeZones={3},cast="staticDirection",dmg="dmg",attr={"w"}}},
		["3"] = { {timeZones={5},cast="staticDirection",dmg="dmg",attr={"w"}}},
		["4"] = { {timeZones={7},cast="staticDirection",dmg="dmg",attr={"w"}}},
		["5"] = { {timeZones={9},cast="staticDirection",dmg="dmg",attr={"w"}}},
		
		["n"] = { {timeZones={1},cast="staticDirection",dmg="dmg",effect={9},attr={"n"}}},
		["14"] = { {timeZones={3},cast="staticDirection",dmg="dmg",attr={"n"}}},
		["15"] = { {timeZones={5},cast="staticDirection",dmg="dmg",attr={"n"}}},
		["16"] = { {timeZones={7},cast="staticDirection",dmg="dmg",attr={"n"}}},
		["17"] = { {timeZones={9},cast="staticDirection",dmg="dmg",attr={"n"}}},
		-- ["n"] = { {timeZones={1},cast="staticDirection",dmg="dmg",effect={},attr={"1"}}},
		["s"] = { {timeZones={1},cast="staticDirection",effect={10}}},
		["66"] = { {timeZones={1},cast="staticDirection",dmg="dmg",attr={"s"}}},
		["6"] = { {timeZones={3},cast="staticDirection",dmg="dmg",attr={"s"}}},
		["7"] = { {timeZones={5},cast="staticDirection",dmg="dmg",attr={"s"}}},
		["8"] = { {timeZones={7},cast="staticDirection",dmg="dmg",attr={"s"}}},
		["9"] = { {timeZones={9},cast="staticDirection",dmg="dmg",attr={"s"}}},
		},
	areas = {
		["Default"] = {
			{"x","x","x","x","x","17","x","x","x","x","x"},
			{"x","x","x","x","x","16","x","x","x","x","x"},
			{"x","x","x","x","x","15","x","x","x","x","x"},
			{"x","x","x","x","x","14","x","x","x","x","x"},
			{"x","x","x","x","x","n","x","e","x","x","x"},
			{"5","4","3","2","w", 0 ,"100","10","11","12","13"},
			{"x","x","x","x","x","66","x","x","x","x","x"},
			{"x","x","x","x","s","6","x","x","x","x","x"},
			{"x","x","x","x","x","7","x","x","x","x","x"},
			{"x","x","x","x","x","8","x","x","x","x","x"},
			{"x","x","x","x","x","9","x","x","x","x","x"},
		},
		},
        formula = {
            ["dmg"] = {min = "(100 + L*1)*(1+(mL/100))", max = "(133 + L*2)*(1+(mL/100))"},
        },
		bonusAttributes = {
		["n"] = {attr="push", condition={name="creatureAction",importance=99},pushDirections={0},pushDistance=1},
		["e"] = {attr="push", condition={name="creatureAction",importance=99},pushDirections={1},pushDistance=1},
		["s"] = {attr="push", condition={name="creatureAction",importance=99},pushDirections={2},pushDistance=1},
		["w"] = {attr="push", condition={name="creatureAction",importance=99},pushDirections={3},pushDistance=1},
		["final"] = {attr="push", condition={name="creatureAction",importance=99},hitBlockedTile="Stun",pushDirections={1,3}},
		-- ["n"] = {looktype={54,55,56,57}},
		-- ["n"] = {looktype={57,57,57,56}},
	
	}
	},
	["Gravity Artifact"] = {
        func = "spell_aoe",
        word = "gravity artifact",
		vocation = {"mage","knight", "master mage"},
		cooldown = 5,
		manaCost = 1,
		aggressive = true,
		min_L = 1,
				spellGroup = 1,
		groupCooldown = 2,
		areaVariables = {
		["Default0"] = { {timeZones={1},cast="adapt",attr={"1"}}},
		["t"] = { {timeZones={1,30},cast="adapt",attr={"1"}}},

		["1"] = { 
		{timeZones={1},cast="static",dmg="dmg",effect={23}},
		{timeZones={5},cast="static",dmg="dmg",effect={23}},
		{timeZones={9},cast="static",dmg="dmg",effect={23}},
		{timeZones={13},cast="static",dmg="dmg",effect={23}},
		{timeZones={17},cast="static",dmg="dmg",effect={23}},
		{timeZones={1,21},cast="static",attr={"4"}},--instant slow
		},
		["Target0"] = { 
		{timeZones={1},cast="static",dmg="dmg",effect={23}},
		{timeZones={5},cast="static",dmg="dmg",effect={23}},
		{timeZones={9},cast="static",dmg="dmg",effect={23}},
		{timeZones={13},cast="static",dmg="dmg",effect={23}},
		{timeZones={17},cast="static",dmg="dmg",effect={23}},
		{timeZones={1,21},cast="static",attr={"4"}},--instant slow
		}
		},
	areas = {
		["Default"] = {
			{"t","t","t","t","t","t","t","t", "t" ,"t","t","t","t","t","t","t","t"},
			{"t","t","t","t","t","t","t","t", "t" ,"t","t","t","t","t","t","t","t"},
			{"t","t","t","t","t","t","t","t", "t" ,"t","t","t","t","t","t","t","t"},
			{"t","t","t","t","t","t","t","t", "t" ,"t","t","t","t","t","t","t","t"},
			{"t","t","t","t","t","t","t","t", "t" ,"t","t","t","t","t","t","t","t"},
			{"t","t","t","t","t","t","t","t", "t" ,"t","t","t","t","t","t","t","t"},
			{"t","t","t","t","t","t","t","t",  0  ,"t","t","t","t","t","t","t","t"},
			{"t","t","t","t","t","t","t","t", "t" ,"t","t","t","t","t","t","t","t"},
			{"t","t","t","t","t","t","t","t", "t" ,"t","t","t","t","t","t","t","t"},
			{"t","t","t","t","t","t","t","t", "t" ,"t","t","t","t","t","t","t","t"},
			{"t","t","t","t","t","t","t","t", "t" ,"t","t","t","t","t","t","t","t"},
			{"t","t","t","t","t","t","t","t", "t" ,"t","t","t","t","t","t","t","t"},
			{"t","t","t","t","t","t","t","t", "t" ,"t","t","t","t","t","t","t","t"},
		},
		["Target"] = {
			{"1", "1" ,"1"},
			{"1",  0  ,"1"},
			{"1", "1" ,"1"},
		}
		},
        formula = {
            ["1"] = {min = "1", max = "1"},
            ["dmg"] = {min = "(100 + L*1)*(1+(mL/100))", max = "(133 + L*2)*(1+(mL/100))"},
            ["+30%"] = {min = "(130 + L*1)*(1+(mL/130))", max = "(175 + L*2)*(1+(mL/175))"},
        },
		bonusAttributes = {
		["1"] = {attr="spell_mouseInteraction", condition={name="timeDuration",duration=3},areaSpawn="Target",onlyCaster=true},
		["3"] = {attr="teleport", condition={name="creatureAction",importance=2,repeatValue=0,repeatTime=0,repeatChance=0,actionDelay=0},emptyTargetCast=true},
		["2"] = {attr="Silence", damage=true, condition={name="timeDuration",duration=3}},
		["4"] = {attr="movementSpeed", percent=60, condition={name="timeDuration",duration=4}},
	}
	},
	["Giant T Sword MINE"] = {
        func = "spell_aoe",
        word = "giant t sword MINE",
		vocation = {"mage", "master mage","sorcerer","knight"},
		cooldown = 1,
		manaCost = 1,
		aggressive = true,
		min_L = 1,
		spellGroup = 1,
		groupCooldown = 2,
		areaVariables = {
		["Default0"] = { {timeZones={1},cast="staticDirection",effect={},attr={"1"}}},
		-- ["3"] = { {timeZones={1},cast="adapt",effect={1},attr={"3"}}},--trigger sword effect
		["3"] = { {timeZones={1},cast="adapt",effect={},attr={"3"}}},--trigger sword effect
		-- ["3"] = { {timeZones={1},cast="adapt",effect={1,2,3,4}}},--trigger sword effect
		
		-- ["1"] = { {timeZones={1},cast="adapt",effect={38},dmg="dmg"}},--invisible dmg
		["1"] = { {timeZones={1},cast="adapt",effect={},dmg="dmg"}, attr={"2"}},--invisible dmg
		["2"] = { {timeZones={1,6},cast="adapt",attr={"1"}},{timeZones={6},cast="adapt",dmg="+30%",effect={48,48}}}--explosion
		},
	areas = {
		["Default"] = {
			{"x","x","x","x","x","x","x","x","x","x","x"},
			{"x","x","x","x","x","x","x","x","x","x","x"},
			{"x","x","x","x","x","x","x","x","x","x","x"},
			{"x","x","x","x","x","2","x","x","x","x","x"},
			{"x","x","x","2","2","1","2","2","x","x","x"},
			{"x","x","x","x","x","1","x","x","x","x","x"},
			{"x","x","x","x","x","3","x","x","x","x","x"},
			{"x","x","x","x","x", 0 ,"x","x","x","x","x"}
		},
		},
        formula = {
            ["1"] = {min = "1", max = "1"},
            ["dmg"] = {min = "(100 + L*1)*(1+(mL/100))", max = "(133 + L*2)*(1+(mL/100))"},
            ["+30%"] = {min = "(130 + L*1)*(1+(mL/130))", max = "(175 + L*2)*(1+(mL/175))"},
        },
		bonusAttributes = {
			["1"] = {attr="spell_indicator", condition={name="timeDuration",duration=5},onlyCaster=true},
			["2"] = {attr="spell_indicator", looktype={8,9,10,11}},
			-- ["3"] = {attr="creature_animation", looktype={1,2,3,4}},
			-- ["3"] = {attr="creature_animation", condition={name="creatureAction",importance=99}, looktype={54,55,56,57}}
			["3"] = {attr="creature_animation", condition={name="creatureAction",importance=99}, looktype={1,2,3,4}}
		}
	},
	["Gravity Artifact MINE"] = {
        func = "spell_aoe",
        word = "gravity artifact MINE",
		vocation = {"mage","knight", "master mage"},
		cooldown = 1,
		manaCost = 1,
		aggressive = true,
		min_L = 1,
		spellGroup = 1,
		groupCooldown = 2,
		areaVariables = {
		["Default0"] = { {timeZones={1},cast="adapt",attr={"1"}}},
		["t"] = { {timeZones={1,30},cast="adapt",attr={"1"}}},

		["1"] = { 
		{timeZones={1},cast="static",effect={0,0,8,8}},
		{timeZones={11},cast="static",effect={0,0,8,8}},
		{timeZones={21},cast="static",effect={0,0,8,8}},
		{timeZones={31},cast="static",effect={0,0,8,8}},
		{timeZones={41},cast="static",effect={0,0,8,8}},
		{timeZones={1,41},cast="static",effect={8,8},attr={"4"}},--instant slow
		},
		["Target0"] = { 
		{timeZones={1},cast="static",effect={0,0,8,8}},
		{timeZones={11},cast="static",effect={0,0,8,8}},
		{timeZones={21},cast="static",effect={0,0,8,8}},
		{timeZones={31},cast="static",effect={0,0,8,8}},
		{timeZones={41},cast="static",effect={0,0,8,8}},
		{timeZones={1,41},cast="static",effect={8,8},attr={"4"}},--instant slow
		}
		},
	areas = {
		["Default"] = {
			{"t","t","t","t","t","t","t","t", "t" ,"t","t","t","t","t","t","t","t"},
			{"t","t","t","t","t","t","t","t", "t" ,"t","t","t","t","t","t","t","t"},
			{"t","t","t","t","t","t","t","t", "t" ,"t","t","t","t","t","t","t","t"},
			{"t","t","t","t","t","t","t","t", "t" ,"t","t","t","t","t","t","t","t"},
			{"t","t","t","t","t","t","t","t", "t" ,"t","t","t","t","t","t","t","t"},
			{"t","t","t","t","t","t","t","t", "t" ,"t","t","t","t","t","t","t","t"},
			{"t","t","t","t","t","t","t","t",  0  ,"t","t","t","t","t","t","t","t"},
			{"t","t","t","t","t","t","t","t", "t" ,"t","t","t","t","t","t","t","t"},
			{"t","t","t","t","t","t","t","t", "t" ,"t","t","t","t","t","t","t","t"},
			{"t","t","t","t","t","t","t","t", "t" ,"t","t","t","t","t","t","t","t"},
			{"t","t","t","t","t","t","t","t", "t" ,"t","t","t","t","t","t","t","t"},
			{"t","t","t","t","t","t","t","t", "t" ,"t","t","t","t","t","t","t","t"},
			{"t","t","t","t","t","t","t","t", "t" ,"t","t","t","t","t","t","t","t"},
		},
		["Target"] = {
			{"1", "1" ,"1"},
			{"1",  0  ,"1"},
			{"1", "1" ,"1"},
		}
		},
        formula = {
            ["1"] = {min = "1", max = "1"},
            ["dmg"] = {min = "(100 + L*1)*(1+(mL/100))", max = "(133 + L*2)*(1+(mL/100))"},
            ["+30%"] = {min = "(130 + L*1)*(1+(mL/130))", max = "(175 + L*2)*(1+(mL/175))"},
        },
		bonusAttributes = {
		["1"] = {attr="spell_mouseInteraction", condition={name="timeDuration",duration=3},areaSpawn="Target",onlyCaster=true},
		["3"] = {attr="teleport", condition={name="creatureAction",importance=2,repeatValue=0,repeatTime=0,repeatChance=0,actionDelay=0},emptyTargetCast=true},
		["2"] = {attr="Silence", damage=true, condition={name="timeDuration",duration=3}},
		["4"] = {attr="movementSpeed", percent=60, condition={name="timeDuration",duration=4}},
	}
	},
	["Goat Push MINE"] = {
        func = "spell_aoe",
        word = "goat push MINE",
		vocation = {"archer", "knight","eagle eye"},
		cooldown = 1,
		manaCost = 1,
		aggressive = true,
		min_L = 1,
		spellGroup = 1,
		groupCooldown = 2,
		areaVariables = {
		["e"] = { {timeZones={1},cast="staticDirection",dmg="dmg",effect={},attr={"2"}}},
		["w"] = { {timeZones={1},cast="staticDirection",dmg="dmg",effect={},attr={"2"}}},
		["2"] = { {timeZones={3},cast="staticDirection",dmg="dmg",effect={},attr={"2"}}},
		["3"] = { {timeZones={5},cast="staticDirection",dmg="dmg",effect={},attr={"2"}}},
		["4"] = { {timeZones={7},cast="staticDirection",dmg="dmg",effect={},attr={"2"}}},
		["5"] = { {timeZones={9},cast="staticDirection",dmg="dmg",effect={},attr={"2"}}},
		
		["n"] = { {timeZones={1},cast="staticDirection",dmg="dmg",effect={6},attr={"1"}}},
		["s"] = { {timeZones={1},cast="staticDirection",dmg="dmg",effect={5},attr={"1"}}},
		["6"] = { {timeZones={3},cast="staticDirection",dmg="dmg",effect={},attr={"1"}}},
		["7"] = { {timeZones={5},cast="staticDirection",dmg="dmg",effect={},attr={"1"}}},
		["8"] = { {timeZones={7},cast="staticDirection",dmg="dmg",effect={},attr={"1"}}},
		["9"] = { {timeZones={9},cast="staticDirection",dmg="dmg",effect={},attr={"1"}}},
		},
	areas = {
		["Default"] = {
			{"x","x","x","x","x","9","x","x","x","x","x"},
			{"x","x","x","x","x","8","x","x","x","x","x"},
			{"x","x","x","x","x","7","x","x","x","x","x"},
			{"x","x","x","x","x","6","x","x","x","x","x"},
			{"x","x","x","x","x","n","x","x","x","x","x"},
			{"5","4","3","2","w", 0 ,"e","2","3","4","5"},
			{"x","x","x","x","x","s","x","x","x","x","x"},
			{"x","x","x","x","x","6","x","x","x","x","x"},
			{"x","x","x","x","x","7","x","x","x","x","x"},
			{"x","x","x","x","x","8","x","x","x","x","x"},
			{"x","x","x","x","x","9","x","x","x","x","x"},
		},
		},
        formula = {
            ["dmg"] = {min = "(100 + L*1)*(1+(mL/100))", max = "(133 + L*2)*(1+(mL/100))"},
        },
		bonusAttributes = {
		["1"] = {attr="push", condition={name="creatureAction",importance=99},pushDirections={1,3},pushDistance=1},
		["2"] = {attr="push", condition={name="creatureAction",importance=99},pushDirections={0,2},pushDistance=1},
		["final"] = {attr="push", condition={name="creatureAction",importance=99},hitBlockedTile="Stun",pushDirections={1,3}},
		-- ["n"] = {looktype={54,55,56,57}},
		-- ["n"] = {looktype={57,57,57,56}},
	
	}
	},
	["Teleport MINE"] = {
        func = "spell_aoe",
        word = "teleport MINE",
		vocation = {"sorcerer","knight","mage", "master mage"},
		cooldown = 5,
		manaCost = 1,
		aggressive = true,
		min_L = 1,
		spellGroup = 1,
		groupCooldown = 2,
		areaVariables = {
		["Default0"] = { {timeZones={1},cast="staticDirection",attr={"1","4"}}},
		["t"] = { {timeZones={1,30},cast="adapt",attr={"1"}}},--throw sword indicator
		["Target0"] = { {timeZones={1},cast="caster",attr={"2","4"}},{timeZones={1},cast="adapt",effect={14}},{timeZones={31},cast="adapt",effect={14},attr={"3"}}}, -- throwed sword 3s duration effect
		["1"] = { {timeZones={1},cast="adapt",dmg="dmg"}},--invisible dmg
		-- ["2"] = { {timeZones={6},cast="adapt",dmg="+30%",effect={48,48,11,11}}}--explosion
		["2"] = { {timeZones={6},cast="adapt",dmg="+30%",effect={14}}}--explosion
		},
	areas = {
		["Default"] = {
			{"t","t","t","t","t","t","t","t", "t" ,"t","t","t","t","t","t","t","t"},
			{"t","t","t","t","t","t","t","t", "t" ,"t","t","t","t","t","t","t","t"},
			{"t","t","t","t","t","t","t","t", "t" ,"t","t","t","t","t","t","t","t"},
			{"t","t","t","t","t","t","t","t", "t" ,"t","t","t","t","t","t","t","t"},
			{"t","t","t","t","t","t","t","t", "t" ,"t","t","t","t","t","t","t","t"},
			{"t","t","t","t","t","t","t","t", "t" ,"t","t","t","t","t","t","t","t"},
			{"t","t","t","t","t","t","t","t",  0  ,"t","t","t","t","t","t","t","t"},
			{"t","t","t","t","t","t","t","t", "t" ,"t","t","t","t","t","t","t","t"},
			{"t","t","t","t","t","t","t","t", "t" ,"t","t","t","t","t","t","t","t"},
			{"t","t","t","t","t","t","t","t", "t" ,"t","t","t","t","t","t","t","t"},
			{"t","t","t","t","t","t","t","t", "t" ,"t","t","t","t","t","t","t","t"},
			{"t","t","t","t","t","t","t","t", "t" ,"t","t","t","t","t","t","t","t"},
			{"t","t","t","t","t","t","t","t", "t" ,"t","t","t","t","t","t","t","t"},
		},
		["Target"] = {{0}}
		},
        formula = {
            ["1"] = {min = "1", max = "1"},
            ["dmg"] = {min = "(100 + L*1)*(1+(mL/100))", max = "(133 + L*2)*(1+(mL/100))"},
            ["+30%"] = {min = "(130 + L*1)*(1+(mL/130))", max = "(175 + L*2)*(1+(mL/175))"},
        },
		bonusAttributes = {
		["1"] = {attr="spell_mouseInteraction", condition={name="timeDuration",duration=3},areaSpawn="Target",onlyCaster=true},
		["3"] = {attr="teleport", condition={name="creatureAction",importance=2,repeatValue=0,repeatTime=0,repeatChance=0,actionDelay=0},emptyTargetCast=true},
		["2"] = {attr="Silence", damage=true, condition={name="timeDuration",duration=3}},
		["4"] = {attr="movementSpeed", percent=0, condition={name="timeDuration",duration=3}},
	}
	},
	
}


local emptyInt = 1
for i,child in pairs(Wikipedia.Spells) do
if Wikipedia.storageTable[i] then
Wikipedia.Spells[i].spellSV = Wikipedia.storageTable[i]
else
Wikipedia.Spells[i].spellSV = Wikipedia.storageTable["IntegerIndicator"]-emptyInt
emptyInt = emptyInt + 1
end
end