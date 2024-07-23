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
                                    Lev = player level
                                    mL = magic level
                                    sL = shielding level
                                    dL = distance level
                                    swL = sword level
                                    aL = axe level
                                    cL = club level
                                    fL = fist fighting level
                                    atk = weapon attack
                                    wS = weapon skill
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
		["health"] = {}, --boost attributes value with // make fast map without recalculating every call + client based support / client creature setCustomAttribute(setAnimationWidget) support for source interaction without callEvents
		["ki"] = {},
			["obstacle"] = {},
			["skill"] = {},
			["level"] = {},
			["storage"] = {},
			["storage"] = {},
			
		["stepIn"] = {},
		["repeat"] = {},
		
		},--
		bonusAttributes = {
		[1] = {"Cooldown"},
		[2] = {"Damage" Damage_shader},
		[3] = {"useReduce"},
		[4] = {"conditionBuff"},
		[4] = {"Regeneration"},
		[5] = {"Area Change","x5"},
		[6] = {"Stun"},
		[7] = {"Silence", target=true,damage=false,mute=false, duration=5 }, "movement","rotation","casting","deactivate"
		[8] = {"Push", Push_direction, Push_distance},
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
		[21] = {"castSpell"},
		
		[21] = {"castSpell"},
		[21] = {"spawnArea"},
		[21] = {"spawnMonster"},
		[21] = {"spawnItem"},
		[21] = {"removeItem"},
		
		--force rounding rendering every 100ms range // cleanup creature action list if needed before render // limit spell generation events to single timezone each active one 
		--preset throwing
		--creatureInteract - party
		--mapInteract - differentFloor interaction / autouse shovel
		--spellDeflect 
		--spellCombine
		--spellBlock
		--replaceeffect
		--spawnEffect
		--spawnEffect
		},
}
]]

Wikipedia = {}
VocationTable = {}
Wikipedia.ALLOW_ATTACK_ONLY_TARGET = false

Wikipedia.storageTable = {
    ["IntegerIndicator"] = 30000,--dont remove

    ["Giant T Sword"] = 30001,
    ["Summoned Ancestral Swords"] = 30003,
    ["Dash"] = 30004,
	["Basic Attack"] = 30007,
	["Punches"] = 30008,
	["Instant Teleport"] = 30009,
	["Explosion"] = 30010,
    ["Weapon Dash"] = 30011,
	
    ["Maza"] = 30012,
    ["Colobri’s Twist"] = 30019,
    ["Ancestral Fury"] = 30018,
	
    ["Slimy Feet"] = 30017,
    ["Cobra's Fang"] = 30016,
    ["Summon Bamboo Healer"] = 30015,
	
    ["Call of the Wild"] = 30005,
    ["Goat's Hop"] = 30005,
    ["Gravity Artifact"] = 30006,
	
    ["Kaer’s pinky finger"] = 30014,
    ["Kaer’s Breeze"] = 30002,
    ["Kaer's Wrath"] = 30013,
	--30020
    ["Chest"] = 30024,
    ["Chest2"] = 30025,
    ["Chest3"] = 30026,
}

Wikipedia.Quests = {}
growingEventHolder = {}

--VariableOBJ={name="", valueOBJ/conditionOBJs/successOBJ
--areaVariables
--formulaVariables
--attributesVariables
Wikipedia.creatureAnimations = {--global bonusAttributes configs
--canCastSpells/deactivate


-- animation combination half top attacking + half bottom walking / animation trigger combo effects 
--/animation randomizer with loop sequence time modifications and outfit(aura) swaps
--\\\\\\singleton with spellSV
--useItem/moveCreature getPathTo limitation with client based autowalk // limit right use walk recalculation samePosition+timer 
--generated rooms map + dynamic blockable things list + position view filter for spectators->pathfind
--block casting spell on area after droping there items
--stack prevent limits?
--skip refresh check / remove expired by castTime event
--/motion pack either based on c++ timer 
--creature actions importance based on bonusAttributes /render always/indicator/heal/1=teleport/2=push/0=getting+sending dmg/3=spells/4=/5=useItem/6=walk/7=idle
-- cancel teleport with push / verification of expired actions / cleanup remove calls
-- instant refresh //low refresh time == more accurate spell reaction to environment // high refresh time == combo/counter casting system integration + getspectators limitation
--\\\\\ AI movement/newRandom spells from time seed/health dmg/pathfinding recreatable client side   
-- trackable object rooms instead of spectators recalculating / walk refresh only new tiles from same floor /  

--//
--+ lua based frames duration list with motion modification + multi outfits number return -> animationWidgets ["lookType"][1 frame] = getId(duration)
--newRandom for synchronizing rendering animation client based recreated from spellCast time and range 0.1-100
--action system integration with addEvents from spells
--forceWait/speedUp based on given end time/forceSkip    /// "forceWait", "autoSpeedup", "durationLeft", "forceSkip"
--checkWalk client side callevent
--turnOn/turnOff indicator client side

	["Dash"] = {
			["Shepherd of Aureh"] = {outfit={lookType=1}, importance=99, prevent={"movement","rotation","casting"}, playerBarOffset={16,16}, skip={"forceWait"}, sequence={[1] = {duration=2000, skip={"forceWait"}, motion="pingPong", remove="sequence"},[2] = {duration=2000, motion="pingPong", remove="animation"}} },--nw reversed
		},
	["Tornado"] = {
	--tornado rotate texture
	--lookShader
	--
	},
	["Sprint"] = {
			["Kokao Warrior"] = {outfit={lookType=2}, playerBarOffset={16,16}, sequence={
					{duration=2000, motion="speedUp", chance=50, outfit={lookWings=1}}, -- speed up dust
					{duration=1000, motion="easeOut", chance=50, bonusAttributes={}},--caster modification 
					{duration=500 , motion="easeOut", chance=100},--forced break with stun
					{duration=5000, motion="original", chance=50},--normal walk
					{duration=1000, motion="easeOut", chance=50},--react to environment / trip out by steping out from item on map
					{chance=25, remove="animation"},--spell casting
				}
			},
		},


	["Based"] = {
		["Kokao Warrior"] = {outfit={lookType=18,lookWings=0,lookAura=0,lookShader=0}},
		["Kaer Disciple"] = {outfit={lookType=19,lookWings=0,lookAura=0,lookShader=0}},
		["Jade Mystic"] = {outfit={lookType=16,lookWings=0,lookAura=0,lookShader=0}},
		["Shepherd of Aureh"] = {outfit={lookType=15,lookWings=0,lookAura=0,lookShader=0}},
		["Gladiator Fisherman"] = {outfit={lookType=7,lookWings=0,lookAura=0,lookShader=0}},
		["Bully Gladiator"] = {outfit={lookType=1,lookWings=0,lookAura=0,lookShader=0}},
		["Drunken Gladiator"] = {outfit={lookType=6,lookWings=0,lookAura=0,lookShader=0}},
		["Helmet Gladiator"] = {outfit={lookType=39,lookWings=0,lookAura=0,lookShader=0}},
	},
	["Basic Attack"] = {
		["Kokao Warrior"] = {outfit={lookType=21}, animationDuration=500}, --dmg delay
		["Kaer Disciple"] = {outfit={lookType=31}, animationDuration=500},
		["Jade Mystic"] = {outfit={lookType=32}, animationDuration=900},
		["Shepherd of Aureh"] = {outfit={lookType=33}, animationDuration=600},
		["Gladiator Fisherman"] = {outfit={lookType=35}, animationDuration=600},
		["Bully Gladiator"] = {outfit={lookType=36}, animationDuration=400},
		["Drunken Gladiator"] = {outfit={lookType=37}, animationDuration=400},
		["Helmet Gladiator"] = {outfit={lookType=38}, animationDuration=400},
	},
}


Wikipedia.Spells = {
	
 ["All Passive"] = {
        
        func = "spell_login",
        word = "qazwsxmeleepassiveqazwsx",
		vocation = {},
		cooldown = 1,
		manaCost = 0,
		aggressive = true,
		min_L = 1,
		
		spellGroup = 1,
		groupCooldown = 2,
		areaVariables = {
		["Default0"] = {{timeZones={1},effect={0,0,11,11}, attr={1}}},
		},
		areas = {
		["Default"] = {{0}}
		},
		bonusAttributes = {
		[1] = {attr="Passive", shader="", condition={name="onHit",count=1,repetitive=0}, meleeValue=-50, meleePercent=100, spellValue=-1, spellPercent=100}, -- value object
		},
        formula = {
            ["Melee Damage"] = {variables = {
						{name="|dmg|", value = "0"},--replaced with formula function
						
						{name="|dmg2|", value = "|dmg|", condition={{name="spellActive", spellName="Goat's Hop", value = "math.random(((|level| / 5) + |weaponSkill| * 0.7),((|level| / 5) + |weaponSkill| + 5.0))"}}},--pvp system
					},
				min = "|dmg2| ", max = "|dmg2| "},
             ["Melee Damage Secondary"] = {variables = { 
					{name="|dmg|", value = "0"},--replaced with formula function
					{name="|trueValueDmgBuff|", value = "0"},
					{name="|truePercentDmgBuff|", value = "0"},
					{name="|targetHp|", value = "0"},
					{name="|rabbit|", value = "0.0", condition={{name="customVariable", variable="|targetHp|",range={1555555535,15555555559}, value = "|targetHp|"},{name="customVariable", variable="|ki_defL|",range={155,999}}} },--pvp system
				
					}, min = "(|trueValueDmgBuff| + (|dmg| * (|truePercentDmgBuff|/100))) + |rabbit|",
  					   max = "(|trueValueDmgBuff| + (|dmg| * (|truePercentDmgBuff|/100))) + |rabbit|"},--in pairs(value object + condition object)
            ["Melee Defense"] = {variables = {
						{name="|dmg|", value = "0"},--replaced with formula function
					},
					min = "|dmg|", max = "|dmg|"},
			
			
			
            ["Spell Damage"] = {variables = {
					{name="|dmg|", value = "0"},--replaced with formula function
					{name="|valueDmgBuff|", value = "0"}, 
					{name="|percentDmgBuff|", value = "0"},
					{name="|targetHp|", value = "0"},
					{name="|targetPercentHp|", value = "0"},
					{name="|dmg2|", value = "(|dmg|+|valueDmgBuff|) * ((100 + |percentDmgBuff|)/100)"},
				
				
				},  
				min = " |dmg2|", 
				max = " |dmg2|"},
            ["Spell Damage Secondary"] = {variables = { 
					{name="|dmg|", value = "0"},--replaced with formula function
					{name="|trueValueDmgBuff|", value = "0"},
					{name="|truePercentDmgBuff|", value = "0"},
					{name="|creatureStacks|", value = "0"},
					{name="|targetHp|", value = "0"},
					{name="|rabbit|", value = "0.0", condition={{name="customVariable", variable="|targetHp|",range={1555555535,15555555559}, value = "|targetHp|"},{name="customVariable", variable="|ki_defL|",range={155,999}}} },--pvp system
				
					}, min = "(((|trueValueDmgBuff| + (|dmg| * (|truePercentDmgBuff|/100))) ) * |creatureStacks| )+ |rabbit|",
  					   max = "(((|trueValueDmgBuff| + (|dmg| * (|truePercentDmgBuff|/100))) ) * |creatureStacks| )+ |rabbit|"},--in pairs(value object + condition object)
            ["Spell Defense"] = {variables = { 
					{name="|dmg|", value = "0"},
					{name="|valueDefBuff|", value = "0"}, 
					{name="|percentDefBuff|", value = "0"},
					{name="|attackers|", value = "0"},
					{name="|level|", value = "0"},--pvp system
					{name="|targetLevel|", value = "0"},--pvp system
					
					{name="|dmg2|", value = "( (|dmg|-|valueDefBuff|) * ((100 - |percentDefBuff|)/100) )"},--cleaning var
					
				},
				min = " |dmg2|", 
				max = " |dmg2|"},
        }
	},


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
		["Default0"] = { {timeZones={1},effect={0,0,11},dmg="dmg",attr={1}},{timeZones={4,300},effect={0,48},dmg="1"} }, -- name=i/value=attributes/condition={timezone/ignoreList/direction}/success=rotation
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
            ["dmg"] = {min = "(100 + |level|*1)*(1+(|mLevel|/100))", max = "(133 + |level|*2)*(1+(|mLevel|/100))"},
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
            ["dmg"] = {min = "(100 + |level|*1)*(1+(|mLevel|/100))", max = "(133 + |level|*2)*(1+(|mLevel|/100))"},
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
            ["dmg"] = {min = "(100 + |level|*1)*(1+(|mLevel|/100))", max = "(133 + |level|*2)*(1+(|mLevel|/100))"},
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
            ["dmg"] = {min = "(100 + |level|*1)*(1+(|mLevel|/100))", max = "(133 + |level|*2)*(1+(|mLevel|/100))"},
        },
		bonusAttributes = {
		["2"] = {attr="spell_mouseTracking", condition={name="timeDuration",duration=5},areaSpawn="Target",onlyCaster=true},--walk importance 0=idle/1=walk/2=push/3=useItem/4=teleport
		["3"] = {attr="teleport", condition={name="creatureAction",importance=2,repeatValue=0,repeatTime=0,repeatChance=0,actionDelay=0},emptyTargetCast=true},--animation importance 0=idle/1=walk/2=push/3=useItem/4=teleport/5=spell
		["4"] = {attr="push", condition={name="creatureAction",importance=99},hitBlockedTile="Stun"},--hitBlockedTile="Stop"/ "Stun"/"Ghost"/"passDMGbehindCreatureWithMultiplierStacks"/"areaCast"/"grab"/""
		["5"] = {attr="creature_animation", condition={name="creatureAction",importance=99}, outfit={54,55,56,57}, animationDuration=1000},
		}
	},


	--recreate effects on client side with spell name + duration // make most outfit animations client based with spell database + damage protocol sending
	--scan rooms with loaded map
	--checkbox with dps view on tfs side for optimization 
	
	--render every spell effect on players position with offset based on area
	--motion offset modifications
	--importance pick from activated animations table
	--local orderTable = {
	--"Ground",
	--"TallEnvironment",
	--"BottomEffects",
	--"Creatures",
	--"Missiles",
	--"TopEffects",
	--}

	--KNIGHT--
	
	["Maza"] = {
        func = "spell_aoe",
        word = "maza",
		vocation = {"Kokao Warrior"},
		cooldown = 30,
		activation = {0,"TurnOff"},
		manaCost = 50,
		aggressive = true,
		min_L = 1,
		spellGroup = 1,
		groupCooldown = 2,
		areaVariables = {
			["Default0"] = { 
				{timeZones={1},attr={"1"}},
			},
			["1"] = { 
				{timeZones={8},cast="static", ignoreList={"caster"}, attr={"silence","stun"}, dmg="dmg"}, --,"enemy","ally","target"
				},
			["33"] = {
				{timeZones={8},cast="static", ignoreList={"caster"},dmg="dmg",effect={46,0,0,0}, attr={"silence","stun"}},
			},
			["t"] = { {timeZones={1,30},cast="staticDirection",attr={"1"}}},--throw sword indicator
			["Target0"] = { 
				{timeZones={1},cast="caster",attr={"animation","stun", "castSilence"}},
				{timeZones={7},cast="static",attr={"3"}}}, -- throwed sword 3s duration effect
	
			["TurnOff0"] = { 
				{timeZones={1},cast="caster",attr={"animation"}},
				{timeZones={1},cast="caster",castDirections={0},effect={0,0,0,0}},
				{timeZones={1},cast="caster",castDirections={1},effect={50,0,0,0}},
				{timeZones={1},cast="caster",castDirections={2},effect={45,0,0,0}},
				{timeZones={1},cast="caster",castDirections={3},effect={0,0,0,0}},
				{timeZones={1,14},cast="static",attr={},effect={0,0,0,0}},
				{timeZones={15},cast="static",effect={0,0,0,0}},
				{timeZones={16},cast="static",attr={"3"},effect={0,0,0,0}}}, -- throwed sword 3s duration effect
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
			{"1", "1" ,"1", "1", "1" , "1", "1", "1" ,"1"},
			{"1", "1" ,"1", "1", "1" , "1", "1", "1" ,"1"},
			{"1", "1" ,"1", "1", "1" , "1", "1", "1" ,"1"},
			{"1", "1" ,"1", "1", "1" , "1", "1", "1" ,"1"},
			{"1", "1" ,"1", "1",  0  , "1", "1", "1" ,"1"},
			{"1", "1" ,"1", "1", "1" , "1", "1", "1" ,"1"},
			{"1", "1" ,"1", "1", "1" , "1", "33", "1" ,"1"},
			{"1", "1" ,"1", "1", "1" , "1", "1", "1" ,"1"},
			{"1", "1" ,"1", "1", "1" , "1", "1", "1" ,"1"},
		},
		["TurnOff"] = {{0}},
		},
        formula = {
            ["dmg"] = {min = "(|level| / 5) + (|weaponSkill| * |atk| * 0.03) + 7", max = "(|level| / 5) + (|weaponSkill| * |atk| * 0.05) + 11"},
        },
		bonusAttributes = {
			["1"] = {attr="spell_mouseInteraction", condition={name="timeDuration",duration=2000},areaSpawn="Target", infinite = true,onlyCaster=true,distanceEffect={4}},
			["3"] = {attr="teleport", condition={name="creatureAction",importance=2,repeatValue=0,repeatTime=0,repeatChance=0,actionDelay=0}, force=true,emptyTargetCast=true,distanceEffect={4}},
			["silence"] = {attr="Silence", target=false,damage=false,mute=true, condition={name="timeDuration",duration=1000}},
			["stun"] = {attr="movementSpeed", percent=0, value=0, condition={name="timeDuration",duration=1000}},
			["castSilence"] = {attr="Silence", target=false,damage=false,mute=true, condition={name="timeDuration",duration=1000}},
			["animation"] = {attr="creature_animation", condition={name="creatureAction",importance=99, animation="Transform"}, outfit={lookType=22}, looktype={22,22,22,22}, animationDuration=1000},
		}
	},
	["Colobri’s Twist"] = {
        func = "spell_aoe",
        word = "colobris twist",
		vocation = {"Kokao Warrior"},
		cooldown = 10,
		manaCost = 25,
		aggressive = true,
		min_L = 1,
		spellGroup = 1,
		groupCooldown = 2,
		areaVariables = {
			["Default0"] = {{timeZones={1},attr={"outfitTransform", "castSilence"}}},
			["1"] = { 
				{timeZones={1},cast="staticDirection"},
				{timeZones={6},cast="staticDirection",dmg="dmg"},
				{timeZones={11},cast="staticDirection",dmg="dmg"},
				{timeZones={16},cast="staticDirection",dmg="dmg"},
				},
			["11"] = { --instant detect creatures around
				{timeZones={1,16},cast="staticDirection", attr="instantDmg"},
				},
		},
	areas = {
		["Default"] = {
			{"1","1", "1"},
			{"1", 0 , "1"},
			{"1","1", "1"},
		},
		},
        formula = {
            ["dmg"] = {min = "(|level| / 6) + (|weaponSkill| * |atk| * 0.02) + 4", max = "(|level| / 6) + (|weaponSkill| * |atk| * 0.045) + 11"},
        },
		bonusAttributes = {
		-- ["n"] = {attr="push", condition={name="creatureAction",importance=99},pushDirections={0},pushDistance=1},
		-- ["e"] = {attr="push", condition={name="creatureAction",importance=99},pushDirections={1},pushDistance=1},
		-- ["s"] = {attr="push", condition={name="creatureAction",importance=99},pushDirections={2},pushDistance=1},
		-- ["w"] = {attr="push", condition={name="creatureAction",importance=99},pushDirections={3},pushDistance=1},
		-- ["final"] = {attr="push", condition={name="creatureAction",importance=99},hitBlockedTile="Stun",pushDirections={1,3}},
		-- ["n"] = {outfit={54,55,56,57}},
		-- ["n"] = {outfit={57,57,57,56}},
			["castSilence"] = {attr="Silence", target=false,damage=false,mute=true, condition={name="timeDuration",duration=1000}},
		["instantDmg"] = {attr="damage", value="dmg", condition={name="timeDuration",duration=500, immune=500}},--+ stepin event without scanning // cancel spell and remove all attributes on callbacks
		["outfitTransform"] = {attr="creature_animation", condition={name="creatureAction",importance=99, animation="Transform"}, outfit={lookType=30}, animationDuration=1200},
	
	}
	},
	["Ancestral Fury"] = {
        func = "spell_aoe",
        word = "ancestral fury",
		vocation = {"Kokao Warrior"},
		cooldown = 20,
		activeTime = 10,
		manaCost = 75,
		aggressive = true,
		min_L = 1,
		spellGroup = 1,
		groupCooldown = 2,
		areaVariables = {
			["Default0"] = {
				{timeZones={1},cast="staticDirection", attr={"castStun", "castSilence", "auraStart","ghostStart","outfitTransform","dmgBuff","asBuff","vampBuff"}},
				{timeZones={6},cast="staticDirection", attr={"auraMiddle","ghostMiddle"}},
				{timeZones={97},cast="staticDirection", attr={"auraEnd"}},
				{timeZones={33},cast="staticDirection", attr={"ghostEnd"}},
				},
			["1"] = { 
				},
			["TurnOff0"] = { 
				{timeZones={1},cast="caster", attr={"auraEnd","ghostEnd","dmgBuffEnd","asBuffEnd","vampBuffEnd"}},
				},
		},
	areas = {
		["Default"] = {
			{"x","x", "x"},
			{"x", 0 , "x"},
			{"x","x", "1"},
		},
		["TurnOff"] = { {0} },
		
		},
        formula = {
            ["dmg"] = {min = "(|level| / 5) + (|weaponSkill| * |atk| * 0.03) + 7", max = "(|level| / 5) + (|weaponSkill| * |atk| * 0.05) + 11"},
        },
		bonusAttributes = {
		-- ["n"] = {attr="push", condition={name="creatureAction",importance=99},pushDirections={0},pushDistance=1},
		-- ["e"] = {attr="push", condition={name="creatureAction",importance=99},pushDirections={1},pushDistance=1},
		-- ["s"] = {attr="push", condition={name="creatureAction",importance=99},pushDirections={2},pushDistance=1},
		-- ["w"] = {attr="push", condition={name="creatureAction",importance=99},pushDirections={3},pushDistance=1},
		-- ["final"] = {attr="push", condition={name="creatureAction",importance=99},hitBlockedTile="Stun",pushDirections={1,3}},
		-- ["n"] = {outfit={54,55,56,57}},
		-- ["n"] = {outfit={57,57,57,56}},
		["castStun"] = {attr="movementSpeed", percent=0, value=0, condition={name="timeDuration",duration=1000}},
		["castSilence"] = {attr="Silence", target=false,damage=false,mute=true, condition={name="timeDuration",duration=1000}},
		["dmgBuff"] = {attr="customBuff", customName="baseDamage", value = 1.0, condition={{name="timeDuration",duration=10000},{name="health",range={0,14}, value = 1.3},{name="health",range={15,49}, value = 0.7},{name="health",range={50,79}, value = 1.2},{name="health",range={80,100}, value = 5.5}}},--
		["asBuff"] = {attr="customBuff", customName="attackSpeed", value = 1.0, condition={{name="timeDuration",duration=10000},{name="health",range={0,14}, value = 1.3},{name="health",range={15,49}, value = 0.7},{name="health",range={50,79}, value = 1.2},{name="health",range={80,100}, value = 5.5}}},--
		["vampBuff"] = {attr="customBuff", customName="healthVamp", value = 1.0, condition={{name="timeDuration",duration=10000},{name="health",range={0,14}, value = 50.0},{name="health",range={15,49}, value = 25.0},{name="health",range={50,79}, value = 15.0},{name="health",range={80,100}, value = 70.0}}},--

		["outfitTransform"] = {attr="creature_animation", condition={name="creatureAction",importance=99, animation="Transform"}, outfit={lookType=23}, looktype={23,23,23,23}, animationDuration=1000},
		["auraStart"] = {attr="creature_animation", condition={name="creatureAction",importance=99, outfit={lookAura=24}}, outfit={lookAura=24}, animationDuration=500, control={skip="forceWait", uniqueId=0, uniqueCaster="all",}},
		["auraMiddle"] = {attr="creature_animation", condition={name="creatureAction",importance=99, sequence={
					{duration=2000, motion="speedUp", chance=50, outfit={lookWings=1}}, -- speed up dust
					{duration=1000, motion="easeOut", chance=50, bonusAttributes={}},--caster modification 
					}}, outfit={lookAura=25}, outfit={lookAura=25}, animationDuration=9100},
		["auraEnd"] = {attr="creature_animation", outfit={lookAura=26}, condition={name="creatureAction",importance=99}, outfit={lookAura=26}, animationDuration=400},
		["ghostStart"] = {attr="creature_animation", outfit={lookWings=27}, condition={name="creatureAction",importance=99}, outfit={lookWings=27}, animationDuration=500},
		["ghostMiddle"] = {attr="creature_animation", outfit={lookWings=28}, condition={name="creatureAction",importance=99, sequence={
					{duration=2000, motion="speedUp", chance=50, outfit={lookWings=1}}, -- speed up dust
					{duration=1000, motion="easeOut", chance=50, bonusAttributes={}},--caster modification 
					}}, outfit={lookWings=28}, animationDuration=2700},
		["ghostEnd"] = {attr="creature_animation", outfit={lookWings=29}, animationDuration=600, condition={name="creatureAction",importance=99, outfit={lookWings=29}, animation=""} },
		["dmgBuffEnd"] = {attr="customBuff", customName="baseDamage", value = 1.0, condition={{name="timeDuration",duration=1}}},
		["asBuffEnd"] = {attr="customBuff", customName="attackSpeed", value = 1.0, condition={{name="timeDuration",duration=1}}},
		["vampBuffEnd"] = {attr="customBuff", customName="healthVamp", value = 1.0, condition={{name="timeDuration",duration=1}}},--

	}
	},
	
	--MAGE--
	["Kaer’s pinky finger"] = {
        func = "spell_aoe",
        word = "kaers pinky finger",
		vocation = {"Kaer Disciple"},
		cooldown = 5,
		manaCost = 250,
		aggressive = true,
		min_L = 1,
		spellGroup = 1,
		groupCooldown = 2,
		areaVariables = {
		["Default0"] = { {timeZones={1},attr={"1","animation","castStun","castSilence"}}},
		-- ["Default0"] = { {timeZones={1},effect={35},attr={"1","animation"}}},
		-- ["n"] = { {timeZones={1},cast="adapt",castDirections={0},effect={38}}},--trigger sword effect
		--["e"] = { {timeZones={1},cast="adapt",castDirections={1},effect={41}}},--trigger sword effect
		-- ["w"] = { {timeZones={1},cast="adapt",castDirections={3},effect={40}}},--trigger sword effect
		["n"] = { 
			{timeZones={1},cast="adapt",castDirections={0},effect={38}}, 
		},--invisible dmg
		["s"] = { 
			{timeZones={1},cast="adapt",castDirections={2},effect={39}},
		},--invisible dmg
		["e"] = { 
			{timeZones={1},cast="adapt",castDirections={1},effect={41}}, 
		},--invisible dmg
		["w"] = { 
			{timeZones={1},cast="adapt",castDirections={3},effect={40}},
		},--invisible dmg
	    ["1"] = { {timeZones={1},cast="adapt",dmg="dmg"}},--invisible dmg
		},
	areas = {
		["Default"] = {
			{"s","x","1","x","e"},
			{"x","1","1","1","x"},
			{"x","x","1","x","x"},
			{"x","x","1","x","x"},
			{"w","x", 0 ,"x","n"},
		},
		},
        formula = {
            ["dmg"] = {min = "(|level| / 5) + (|mLevel| * 1.8) + 12", max = "(|level| / 5) + (|mLevel| * 2.5) + 25"},
        },
		bonusAttributes = {
		["1"] = {attr="spell_indicator", condition={name="timeDuration",duration=5},onlyCaster=true},
		-- ["animation"] = {attr="creature_animation", condition={name="creatureAction",importance=99}, outfit={5,5,5,5}, animationDuration=1000},
		["animation"] = {attr="creature_animation", condition={name="creatureAction",importance=99}, outfit={lookType=10}, animationDuration=200},
		["castStun"] = {attr="movementSpeed", percent=0, value=0, condition={name="timeDuration",duration=1000}},
		["castSilence"] = {attr="Silence", target=false,damage=false,mute=true, condition={name="timeDuration",duration=1000}},
	
	}
	},
	["Kaer’s Breeze"] = {
        func = "spell_aoe",
        word = "kaers breeze",
		vocation = {"Kaer Disciple"},
		cooldown = 30,
		manaCost = 150,
		aggressive = true,
		min_L = 1,
		spellGroup = 1,
		groupCooldown = 2,
		areaVariables = {
			["Default0"] = { {timeZones={1},effect={},attr={"1"},effect={0,0,0,0}}},
			["e"] = { {timeZones={1},cast="staticDirection",effect={0,0,0,0}}},
			["t"] = { {timeZones={1,30},attr={"1"},effect={0,0,0,0}}},--throw sword indicator
			["Target0"] = { 
				{cast="adapt",effect={0,0,4,4}},
				{timeZones={1},effect={0,0,4,4}},
				{timeZones={1},cast="caster",attr={"2"},effect={0,0,0,0}},
				{timeZones={1},cast="static",effect={14,14,0,0}},
				{timeZones={1,15},cast="static"},
				{timeZones={16},cast="static",attr={"3"},effect={0,0,0,0}}}, -- throwed sword 3s duration effect
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
        formula = {},
		bonusAttributes = {
		["1"] = {attr="spell_mouseInteraction", condition={name="timeDuration",duration=2},areaSpawn="Target",onlyCaster=true,distanceEffect={4}},
		["3"] = {attr="teleport", condition={name="creatureAction",importance=2,repeatValue=0,repeatTime=0,repeatChance=0,actionDelay=0},emptyTargetCast=true,distanceEffect={4}},
		["2"] = {attr="Silence", damage=true, condition={name="timeDuration",duration=3},distanceEffect={4}},
	}
	},
	["Kaer's Wrath"] = {
        func = "spell_aoe",
        word = "kaers wrath",
		vocation = {"Kaer Disciple"},
		cooldown = 15,
		manaCost = 250,
		aggressive = true,
		min_L = 1,
		spellGroup = 1,
		groupCooldown = 2,
		
		_autoSendMissile = { enabled = true, delay = 800 }, -- delay in miliseconds.
		_sendEffectOnTile = { enabled = true, id = 34 },
		areaVariables = {
		["Default0"] = { 
						{timeZones={1},attr={"2", "auraStart"}},
						{timeZones={13},attr={"idleStart"}}
					},
		["Target0"] = { {timeZones={1},cast="adapt",effect={0,56,5,5},dmg="dmg"}},
		["t"] = { {timeZones={1,51},cast="staticDirection",attr={"2"}}},
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
            ["dmg"] = {min = "(|level| / 5)+(|mLevel|  * 0.8) + 8", max = "(|level| / 5)+(|mLevel|  * 1.2) + 14"},
        },
		bonusAttributes = {
		["2"] = {attr="spell_mouseTracking", condition={name="timeDuration",duration=5},areaSpawn="Target",onlyCaster=true,limitUse=6}, --- client sided, -walk importance 0=idle/1=walk/2=push/3=useItem/4=teleport
		["3"] = {attr="teleport", condition={name="creatureAction",importance=2,repeatValue=0,repeatTime=0,repeatChance=0,actionDelay=0},emptyTargetCast=true},--animation importance 0=idle/1=walk/2=push/3=useItem/4=teleport/5=spell
		["4"] = {attr="push", condition={name="creatureAction",importance=99},hitBlockedTile="Stun"},--hitBlockedTile="Stop"/ "Stun"/"Ghost"/"passDMGbehindCreatureWithMultiplierStacks"/"areaCast"/"grab"/""
		["5"] = {attr="creature_animation", condition={name="creatureAction",importance=99}, outfit={54,55,56,57}, animationDuration=1000},
		["auraStart"] = {attr="creature_animation", outfit={lookAura=40}, condition={name="creatureAction",importance=99}, outfit={lookAura=40}, animationDuration=1200},
		["idleStart"] = {attr="creature_animation", outfit={lookWings=11}, condition={name="creatureAction",importance=99}, outfit={lookWings=11}, animationDuration=3000},
		["6"] = {attr="missile_animation", condition={name="creatureAction",order = 99,importance=99}, dashDuration = 100, motionEffect="instant", offset={1,2}},
		}
	},
	
	-- Paladin
	["Goat Push"] = {
        func = "spell_aoe",
        word = "goat push",
		vocation = {"Shepherd of Aureh"},
		cooldown = 10,
		manaCost = 250,
		aggressive = true,
		min_L = 1,
		spellGroup = 1,
		groupCooldown = 2,
		areaVariables = {
		--["e"] = { {timeZones={1},cast="staticDirection",effect={7}}},
		["100"] = { {timeZones={1},cast="staticDirection",dmg="dmg",attr={"e"}}},
		["10"] = { {timeZones={3},cast="staticDirection",dmg="dmg",attr={"e"}}},
		["11"] = { {timeZones={1},cast="staticDirection",effect={7}}, {timeZones={5},cast="staticDirection",dmg="dmg",attr={"e"}}},
		["12"] = { {timeZones={7},cast="staticDirection",dmg="dmgx2",attr={"e", "final", "stun", "silence"}}},
		["w"] = { {timeZones={1},cast="staticDirection",dmg="dmg",effect={8},attr={"w"}}},
		["2"] = { {timeZones={3},cast="staticDirection",dmg="dmg",attr={"w"}}},
		["3"] = { {timeZones={5},cast="staticDirection",dmg="dmg",attr={"w"}}},
		["4"] = { {timeZones={7},cast="staticDirection",dmg="dmgx2",attr={"w", "final", "stun", "silence"}}},
		
		["n"] = { {timeZones={1},cast="staticDirection",dmg="dmg",effect={5},attr={"n"}}},
		["14"] = { {timeZones={3},cast="staticDirection",dmg="dmg",attr={"n"}}},
		["15"] = { {timeZones={5},cast="staticDirection",dmg="dmg",attr={"n"}}},
		["16"] = { {timeZones={7},cast="staticDirection",dmg="dmgx2",attr={"n", "final", "stun", "silence"}}},
		-- ["n"] = { {timeZones={1},cast="staticDirection",dmg="dmg",effect={},attr={"1"}}},
		--["s"] = { {timeZones={1},cast="staticDirection",effect={6}}},
		["66"] = { {timeZones={1},cast="staticDirection",dmg="dmg",attr={"s"}}},
		["6"] = { {timeZones={3},cast="staticDirection",dmg="dmg",attr={"s"}}},
		["7"] = { {timeZones={1},cast="staticDirection",effect={6}}, {timeZones={5},cast="staticDirection",dmg="dmg",attr={"s"}}},
		["8"] = { {timeZones={7},cast="staticDirection",dmg="dmgx2",attr={"s", "final", "stun", "silence"}}},
		},
	areas = {
		["Default"] = {
			{"x","x","x","x","x","x","x","x","x","x","x"},
			{"x","x","x","x","x","16","x","x","x","x","x"},
			{"x","x","x","x","x","15","x","x","x","x","x"},
			{"x","x","x","x","x","14","x","x","x","x","x"},
			{"x","x","x","x","x","n","x","x","x","x","x"},
			{"x","4","3","2","w", 0 ,"100","10","11","12","x"},
			{"x","x","x","x","x","66","x","x","x","x","x"},
			{"x","x","x","x","x","6","x","x","x","x","x"},
			{"x","x","x","x","x","7","x","x","x","x","x"},
			{"x","x","x","x","x","8","x","x","x","x","x"},
			{"x","x","x","x","x","x","x","x","x","x","x"},
		},
		},
        formula = {
            ["dmg"] = {min = "((|level| / 5) + |distanceL| * 0.15) * 2", max = "((|level| / 5) + |distanceL| + 0.3) * 1"},
            ["dmgx2"] = {min = "((|level| / 5) + |distanceL| * 0.15) * 4", max = "((|level| / 5) + |distanceL| + 0.3) * 0.1"},
            ["dmgx3"] = {min = "((|level| / 5) + |distanceL| * 0.15) * 6", max = "((|level| / 5) + |distanceL| + 0.3) * 0.1"},
        },
		bonusAttributes = {
		["n"] = {attr="push", condition={name="timeDuration",duration=1000,immune=1000}, pushDirections={0},pushDistance=1, obstacleDmg="dmgx3"},--custom attributes skip + spell generator preproccess dmg / global spell settings with dynamic ignoreList save / combine multiple conditions
		["e"] = {attr="push", condition={name="timeDuration",duration=1000,immune=1000}, pushDirections={1},pushDistance=1, obstacleDmg="dmgx3"},
		["s"] = {attr="push", condition={name="timeDuration",duration=1000,immune=1000}, pushDirections={2},pushDistance=1, obstacleDmg="dmgx3"},
		["w"] = {attr="push", condition={name="timeDuration",duration=1000,immune=1000}, pushDirections={3},pushDistance=1, obstacleDmg="dmgx3"},
		["final"] = {attr="push", condition={name="timeDuration",duration=1000,immune=1000},hitBlockedTile="Stun",pushDirections={1,3}, obstacleDmg="dmgx3"},
		["stun"] = {attr="movementSpeed", percent=0, value=0, condition={name="timeDuration",duration=1000}},
		["silence"] = {attr="Silence", target=false,damage=false,mute=true, condition={name="timeDuration",duration=1000}},
		-- ["n"] = {outfit={54,55,56,57}},
		-- ["n"] = {outfit={57,57,57,56}},
	
	}
	},
	["Gravity Artifact"] = {
		spellSV = 3251,
        func = "spell_aoe",
        word = "gravity artifact",
		vocation = {"Shepherd of Aureh"},
		cooldown = 10,
		manaCost = 75,
		aggressive = true,
		removeAttributes = true, --store affected enemy list
		min_L = 1,
		spellGroup = 1,
		groupCooldown = 2,
		areaVariables = {
		["Default0"] = { {timeZones={1},cast="adapt",attr={"1"}}},
		["t"] = { {timeZones={1,30},cast="adapt",attr={"1"}}}, -- tile onStep/ 

		["1"] = { 
			{timeZones={11},cast="static", ignoreList={"caster"},dmg="dmg"},
			{timeZones={21},cast="static", ignoreList={"caster"},dmg="dmg"},
			{timeZones={1,21},cast="static", ignoreList={"caster"},attr={"4"}},--instant slow
		},
		["3"] = { 
			{timeZones={11},cast="static"},
			{timeZones={21},cast="static"},
			{timeZones={1},cast="static",effect={42,42,0,0}},
		},
		["Target0"] = { 
			{timeZones={1},cast="static",effect={0,0,8,8}},
			{timeZones={11},cast="static", ignoreList={"caster"},dmg="dmg"},
			{timeZones={21},cast="static", ignoreList={"caster"},dmg="dmg"},
			{timeZones={1,21},cast="static", ignoreList={"caster"},attr={"4"}},--instant slow
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
		-- ["Target"] = {
		-- 	{"1", "1" ,"1"},
		-- 	{"1",  0  ,"1"},
		-- 	{"1", "1" ,"1"},
		-- },
		["Target"] = {
			{"x", "x" ,"1", "1" ,"x"},
			{"x", "1" ,"1", "1" ,"1"},
			{"1", "1",  0  ,"1", "1"},
			{"1", "1" ,"1", "1" ,"x"},
			{"x", "1" ,"1", "x", "3"},
		}
		},
        formula = {
            ["dmg"] = {min = "(|level| / 5) + |weaponSkill| * 0.3", max = "(|level| / 5) + |weaponSkill| + 2.5"},
        },
		bonusAttributes = {
		["1"] = {attr="spell_mouseInteraction", condition={name="timeDuration",duration=3},areaSpawn="Target",onlyCaster=true},
		["4"] = {attr="movementSpeed", percent=80, condition={name="timeDuration",duration=2000}},
	}
	},

	-- DRUID
	["Slimy Feet"] = {
        func = "spell_aoe",
        word = "slimy feet",
		vocation = {"Jade Mystic"},
		cooldown = 20,
		manaCost = 150,
		aggressive = true,
		min_L = 1,
		spellGroup = 1,
		groupCooldown = 2,
		areaVariables = {
		["Default0"] = { {timeZones={1}, attr={"walk"} } },
		["s"] = { 
				  {timeZones={1},cast="adapt",effect={49,49}, ignoreList={"caster"}, attr={"poison","move"}},
				  {timeZones={2,41},cast="adapt", ignoreList={"caster"}, attr={"poison","move"}}
				},
		["moveArea0"] = { 
				  {timeZones={1},cast="adapt",effect={49,49}, ignoreList={"caster"}, attr={"poison","move"}},
				  {timeZones={2,41},cast="adapt", ignoreList={"caster"}, attr={"poison","move"}}
				},
				
		},
	areas = {
		["Default"] = {
				{ 0 },
				{"s"},
			},
		["moveArea"] = {
				{ 0 },
			},
		},
        formula = {
            ["corrosion"] = {min = "(100 + |level|*1)*(1+(|mLevel|/100))", max = "(133 + |level|*2)*(1+(|mLevel|/100))"},
        },
		bonusAttributes = {
		["move"] = {attr="movementSpeed", percent=50, value=0, condition={name="timeDuration",duration=2000}},
		["poison"] = {attr="damage", value=25, condition={name="timeDuration",duration=6000, immune=2000, repetition=3}},
		["walk"] = {attr="spawnArea", areaSpawn="moveArea", condition={{name="timeDuration",duration=5000},{name="creatureMove",repetition=7}}},
	}
	},
	["Cobra's Fang"] = {
        func = "spell_aoe",
        word = "cobras fang",
		vocation = {"Jade Mystic"},
		cooldown = 10,
		manaCost = 300,
		aggressive = true,
		min_L = 1,
		spellGroup = 1,
		groupCooldown = 2,
		areaVariables = {
		["Default0"] = { {timeZones={1}, attr={"moveCaster"}} },
		["m"] = { 
				  {timeZones={11},cast="static",dmg="dmg"},
				  {timeZones={21,51},cast="static", attr={"move","poison"}}
				},
		["m2"] = { 
				  {timeZones={11},cast="static",dmg="dmg"},
				  {timeZones={21,71},cast="static", attr={"move","poison"}}
				},
		["m3"] = { 
				  {timeZones={11},cast="static",dmg="dmg"},
				  {timeZones={21,91},cast="static", attr={"move","poison"}}
				},
		["n"] = { 
				  {timeZones={1},cast="static", castDirections={0},effect={69}},
				  {timeZones={11},cast="static",dmg="dmg"},
				  {timeZones={16},cast="static", castDirections={0},effect={70}},
		},--invisible dmg
		["s"] = { 
				  {timeZones={1},cast="static", castDirections={2},effect={67}},
				  {timeZones={11},cast="static",dmg="dmg"},
				  {timeZones={16},cast="static", castDirections={2},effect={68}},
		},--invisible dmg
		["e"] = { 
				  {timeZones={1},cast="static", castDirections={1},effect={73}},
				  {timeZones={11},cast="static",dmg="dmg"},
				  {timeZones={16},cast="static", castDirections={1},effect={74}},
		},--invisible dmg
		["w"] = { 
				  {timeZones={1},cast="static", castDirections={3},effect={71}},
				  {timeZones={11},cast="static",dmg="dmg"},
				  {timeZones={16},cast="static", castDirections={3}, effect={72}},
		}
		},
	areas = {
		["Default"] = {
				{"x","x","x","x","e"},
				{"x","s","m","x","x"},
				{"x","m2","m2","m2","x"},
				{"x","m2","m3","m2","x"},
				{"x","x","m","x","x"},
				{"x","w", 0 ,"x","n"},
			},
		},
        formula = {
            ["dmg"] = {min = "(|level| / 5) + (|mLevel| * 2.5) + 15", max = "(|level| / 5) + (|mLevel| * 3.6) + 40"},
        },
		bonusAttributes = {
		["moveCaster"] = {attr="movementSpeed", percent=0, value=0, condition={name="timeDuration",duration=500}},
		["move"] = {attr="movementSpeed", percent=50, value=0, condition={name="timeDuration",duration=2000}},
		["poison"] = {attr="damage", percent=0, value=25, condition={name="timeDuration",duration=6000, immune=2050, repetition=3}},
	}
	},
	["Summon Bamboo Healer"] = {
        func = "spell_aoe",
        word = "summon bamboo healer",
		vocation = {"Jade Mystic"},
		cooldown = 5,
		manaCost = 150,
		aggressive = true,
		min_L = 1,
		spellGroup = 1,
		maxSummons = 2,
		groupCooldown = 2,
		areaVariables = {
			["Default0"] = { {timeZones={1},attr={"1"}}},
			["t"] = { {timeZones={1,30},attr={"1"}}},--throw sword indicator
			["Target0"] = { 
				{timeZones={1},cast="static",attr={"2"},effect={0,0,7,7}},
				{timeZones={12},cast="static",attr={"bamboo"}}
				
				}, -- throwed sword 3s duration effect
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
        formula = {},
		bonusAttributes = {
		["1"] = {attr="spell_mouseInteraction", condition={name="timeDuration",duration=2},areaSpawn="Target",onlyCaster=true,distanceEffect={4}},
		["bamboo"] = {attr="spawnMonster", name="Bamboo Healer", maxSummons = 2, condition={name="creatureAction",importance=2,repeatValue=0,repeatTime=0,repeatChance=0,actionDelay=0},emptyTargetCast=true},
	}
	},
		
		
	--RUNES
	
	["Void Lotus"] = {
        func = "spell_target",
        word = "mspell16dgx voidlotus mspell16dgx",
		itemId = 861,
		vocation = {"Jade Mystic","Shepherd of Aureh","Kokao Warrior","Kaer Disciple"},
		cooldown = 1,
		manaCost = 0,
		aggressive = true,
		requiredSquareCreature = true,
		min_L = 1,
		
		spellGroup = 1,
		groupCooldown = 2,
		areaVariables = {
			["Default0"] = { {timeZones={1},effect={78,78,12},dmg="dmg"} },
			["e"] = { {timeZones={9},cast="static"} },
		},
		areas = {
			["Default"] = {
				{"e","e","e"},
				{"e", 0 ,"e"},
				{"e","e","e"},
			}
		},
        formula = {
            ["dmg"] = {min = "(|level| / 5) + (|mLevel| * 1.8) + 12", max = "(|level| / 5) + (|mLevel| * 3) + 17"},
        },
		bonusAttributes = {
		
		}
	},
	
	["Fireball Rune"] = {
        func = "spell_target",
        word = "mspell16dgx fireball mspell16dgx",
		vocation = {"Jade Mystic","Shepherd of Aureh","Kokao Warrior","Kaer Disciple"},
		itemId = 860,
		cooldown = 1,
		manaCost = 0,
		aggressive = true,
		--targetRequired = true,
		min_L = 1,
		
		spellGroup = 1,
		groupCooldown = 2,
		areaVariables = {
		["Default0"] = { {timeZones={1},effect={0,0,6},dmg="dmg"} },
		["f"] = { 
				  {timeZones={3},effect={35,35},dmg="dmg",cast="static"}
				},
		["e"] = { 
				  {timeZones={3},cast="static",dmg="dmg"}
				},
		},
		areas = {
		["Default"] = {
			{"e","e","e"},
			{"e", 0 ,"e"},
			{"e","e","f"},
		}
		},
        formula = {
            ["dmg"] = {min = "(|level| / 3) + (|mLevel| * 0.3) + 3", max = "(|level| / 3) + (|mLevel| * 0.5) + 6"},
        },
		bonusAttributes = {
		
		}
	},
	
	
	--MONSTERS
	
	
	["3x3 Heal"] = {
        func = "spell_aoe",
        word = "mspell16dgx 3x3 Heal mspell16dgx",
		vocation = {},
		cooldown = 10,
		manaCost = 1,
		aggressive = true,
		min_L = 1,
		spellGroup = 1,
		groupCooldown = 2,
		areaVariables = {
		["Default0"] = { {timeZones={1}, attr={"heal"}} },
		["h"] = { 
				  {timeZones={1},cast="adapt", attr={"heal"},effect={64,64}}
				},
		},
	areas = {
		["Default"] = {
				{"x","x","x","h","x","x","x"},
				{"x","x","h","h","h","x","x"},
				{"x","h","h","h","h","h","x"},
				{"x","h","h", 0 ,"h","h","x"},
				{"x","h","h","h","h","h","x"},
				{"x","x","h","h","h","x","x"},
				{"x","x","x","h","x","x","x"},
			},
		},
        formula = {
            ["dmg"] = {min = "(|level| / 5) + (|mLevel| * 1.8) + 11", max = "(|level| / 5) + (|mLevel| * 3) + 19"},
        },
		bonusAttributes = {
		["heal"] = {attr="heal", percent=5, value=50, condition={name="timeDuration",duration=1}},
	}
	},
	
	["Target Heal"] = {
        func = "spell_aoe",
        word = "mspell16dgx Target Heal mspell16dgx",
		vocation = {},
		cooldown = 10,
		manaCost = 1,
		aggressive = true,
		min_L = 1,
		spellGroup = 1,
		groupCooldown = 2,
		areaVariables = {
		["Default0"] = { {timeZones={1}, cast="caster", attr={"heal"}},
						{timeZones={1}, attr={"heal"}}
					},
		},
	areas = {
		["Default"] = {
				{ 0 },
			},
		},
        formula = {
        },
		bonusAttributes = {
		["heal"] = {attr="heal", percent=5, value=50, condition={name="timeDuration",duration=1}},
	}
	},
	
	["Throw Up"] = {
        func = "spell_aoe",
        word = "mspell16dgx throw up mspell16dgx",
		vocation = {},
		cooldown = 10,
		manaCost = 1,
		aggressive = true,
		min_L = 1,
		spellGroup = 1,
		groupCooldown = 2,
		areaVariables = {
		["Default0"] = { {timeZones={1}, attr={"moveCaster"}} },
		["s"] = { 
				  {timeZones={1},cast="adapt", castDirections={2}, dmg="dmg",effect={58}}
				},
		["n"] = { 
				  {timeZones={1},cast="adapt", castDirections={0},effect={59}}
				},
		["e"] = { 
				  {timeZones={1},cast="adapt", castDirections={1},effect={60}}
				},
		["w"] = { 
				  {timeZones={1},cast="adapt", castDirections={3},effect={57}}
				},
		["d"] = { 
				  {timeZones={6,18},cast="static", dmg="dmg", attr={"move"}}
				},
		},
	areas = {
		["Default"] = {
				{"s","d","d","d","e"},
				{"x","d","d","d","x"},
				{"x","d","d","d","x"},
				{"x","x","d","x","x"},
				{"w","x", 0 ,"x","n"},
			},
		},
        formula = {
            ["dmg"] = {min = "(|level| / 5) + (|mLevel| * 1.8) + 11", max = "(|level| / 5) + (|mLevel| * 3) + 19"},
        },
		bonusAttributes = {
		["moveCaster"] = {attr="movementSpeed", percent=0, value=0, condition={name="timeDuration",duration=500}},
		["move"] = {attr="movementSpeed", percent=70, value=0, condition={name="timeDuration",duration=2000}},
	}
	},
	
 ["Fireball"] = {
        func = "spell_target",
        word = "mspell16dgx fireball monster mspell16dgx",
		vocation = {},
		cooldown = 1,
		manaCost = 0,
		aggressive = true,
		targetRequired = true,
		min_L = 1,
		
		spellGroup = 1,
		groupCooldown = 2,
		areaVariables = {
		["Default0"] = { {timeZones={1},effect={0,0,6},dmg="dmg"} },
		["f"] = { 
				  {timeZones={3},effect={35,35},dmg="dmg",cast="static"}
				},
		["e"] = { 
				  {timeZones={3},cast="static",dmg="dmg"}
				},
		},
		areas = {
		["Default"] = {
			{"e","e","e"},
			{"e", 0 ,"e"},
			{"e","e","f"},
		}
		},
        formula = {
            ["dmg"] = {min = "(|level| / 5) + (|mLevel| * 1.8) + 12", max = "(|level| / 5) + (|mLevel| * 3) + 17"},
        },
		bonusAttributes = {
		
		}
	},
	
 ["Fishernet"] = {
        func = "spell_target",
        word = "mspell16dgx fishernet mspell16dgx",
		vocation = {},
		cooldown = 1,
		manaCost = 0,
		aggressive = true,
		targetRequired = true,
		min_L = 1,
		
		spellGroup = 1,
		groupCooldown = 2,
		areaVariables = {
		["Default0"] = { {timeZones={1},effect={20,20,2},dmg="dmg",attr={"silence","stun"}} }
		},
		areas = {
		["Default"] = {{0}}
		},
        formula = {
            ["dmg"] = {min = "(|level| / 5) + (|mLevel| * 1.8) + 12", max = "(|level| / 5) + (|mLevel| * 3) + 17"},
        },
		bonusAttributes = {
			["silence"] = {attr="Silence", target=false,damage=false,mute=true, condition={name="timeDuration",duration=1000,immune=5000}},
			["stun"] = {attr="movementSpeed", percent=0, value=0, condition={name="timeDuration",duration=1000}},
		}
	},
	
}

local unusedSpell = {

	
	
	
	
	--UNUSED
		["Instant Teleport"] = {
        func = "spell_aoe",
        word = "instant teleport",
		vocation = {"sorcerer","knight","mage", "master mage"},
		cooldown = 5,
		manaCost = 1,
		aggressive = true,
		min_L = 1,
		spellGroup = 1,
		groupCooldown = 2,
		areaVariables = {
			["Default0"] = { {timeZones={1},effect={},attr={"1"},effect={0,0,0,0}}},
			["e"] = { {timeZones={1},cast="staticDirection",effect={0,0,0,0}}},
			["t"] = { {timeZones={1},attr={"1"},effect={0,0,0,0}}},--throw sword indicator
			["Target0"] = { 
				{cast="adapt",effect={0,0,0,0}},
				-- {timeZones={1},cast="caster",attr={"2"},effect={14,0,4,4}},
				-- {timeZones={1,31},cast="static",effect={14,14,4,4}},
				{timeZones={1},cast="static",attr={"3"},effect={14,14,0,0}}}, -- throwed sword 3s duration effect
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
            ["dmg"] = {min = "(100 + |level|*1)*(1+(|mLevel|/100))", max = "(133 + |level|*2)*(1+(|mLevel|/100))"},
            ["+30%"] = {min = "(130 + |level|*1)*(1+(|mLevel|/130))", max = "(175 + |level|*2)*(1+(|mLevel|/175))"},
        },
		bonusAttributes = {
		["1"] = {attr="spell_mouseInteraction", condition={name="timeDuration",duration=2},areaSpawn="Target",onlyCaster=true,distanceEffect={4}},
		["3"] = {attr="teleport", condition={name="creatureAction",importance=2,repeatValue=0,repeatTime=0,repeatChance=0,actionDelay=0},emptyTargetCast=true,distanceEffect={4}},
		["2"] = {attr="Silence", damage=true, condition={name="timeDuration",duration=3},distanceEffect={4}},
	}
	},
	["Explosion"] = {
		spellSV = 3260,
        func = "spell_aoe",
        word = "explosion",
		vocation = {"mage","knight", "master mage"},
		cooldown = 2,
		manaCost = 1,
		aggressive = true,
		min_L = 1,
		spellGroup = 1,
		groupCooldown = 2,
		areaVariables = {
		["Default0"] = { {timeZones={1},cast="adapt",attr={"1"}}},
		["t"] = { {timeZones={1,30},cast="adapt",attr={"1"}}},

		["1"] = { 
		{timeZones={1},cast="static",dmg="dmg"},
		},
		["3"] = { 
			{timeZones={1},cast="static",effect={35,0,0,0}},
		},
		["Target0"] = { 
		{timeZones={1},cast="static",dmg="dmg"},
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
		-- ["Target"] = {
		-- 	{"1", "1" ,"1"},
		-- 	{"1",  0  ,"1"},
		-- 	{"1", "1" ,"1"},
		-- },
		["Target"] = {
			{"1", "1" ,"1"},
			{"1",  0  ,"1"},
			{"1", "1" ,"3"},
		}
		},
        formula = {
            ["1"] = {min = "1", max = "1"},
            ["dmg"] = {min = "(100 + |level|*1)*(1+(|mLevel|/100))", max = "(133 + |level|*2)*(1+(|mLevel|/100))"},
            ["+30%"] = {min = "(130 + |level|*1)*(1+(|mLevel|/130))", max = "(175 + |level|*2)*(1+(|mLevel|/175))"},
        },
		bonusAttributes = {
		["1"] = {attr="spell_mouseInteraction", condition={name="timeDuration",duration=3},areaSpawn="Target",onlyCaster=true},
		["3"] = {attr="teleport", condition={name="creatureAction",importance=2,repeatValue=0,repeatTime=0,repeatChance=0,actionDelay=0},emptyTargetCast=true},
		["2"] = {attr="Silence", damage=true, condition={name="timeDuration",duration=3}},
		["4"] = {attr="movementSpeed", percent=60, condition={name="timeDuration",duration=4}},
	}
	},
	["Circle"] = {
        func = "spell_aoe",
        word = "circle",
		vocation = {"archer", "knight","eagle eye"},
		cooldown = 1,
		manaCost = 1,
		aggressive = true,
		min_L = 1,
		spellGroup = 1,
		groupCooldown = 2,
		areaVariables = {
			["Default0"] = {},
			["1"] = { 
				{timeZones={1},cast="staticDirection",dmg="dmg"},
				{timeZones={5},cast="staticDirection",dmg="dmg"},
				{timeZones={9},cast="staticDirection",dmg="dmg"},
				{timeZones={13},cast="staticDirection",dmg="dmg"},
				{timeZones={17},cast="staticDirection",dmg="dmg"},
				},
			["3"] = { 
				{timeZones={1},cast="staticDirection",dmg="dmg",effect={43}},
				{timeZones={5},cast="staticDirection",dmg="dmg"},
				{timeZones={9},cast="staticDirection",dmg="dmg"},
				{timeZones={13},cast="staticDirection",dmg="dmg"},
				{timeZones={17},cast="staticDirection",dmg="dmg"},
				},
		},
	areas = {
		["Default"] = {
			{"1","1", "1"},
			{"1", 0 , "1"},
			{"1","1", "3"},
		},
		},
        formula = {
            ["dmg"] = {min = "(100 + |level|*1)*(1+(|mLevel|/100))", max = "(133 + |level|*2)*(1+(|mLevel|/100))"},
        },
		bonusAttributes = {
		-- ["n"] = {attr="push", condition={name="creatureAction",importance=99},pushDirections={0},pushDistance=1},
		-- ["e"] = {attr="push", condition={name="creatureAction",importance=99},pushDirections={1},pushDistance=1},
		-- ["s"] = {attr="push", condition={name="creatureAction",importance=99},pushDirections={2},pushDistance=1},
		-- ["w"] = {attr="push", condition={name="creatureAction",importance=99},pushDirections={3},pushDistance=1},
		-- ["final"] = {attr="push", condition={name="creatureAction",importance=99},hitBlockedTile="Stun",pushDirections={1,3}},
		-- ["n"] = {outfit={54,55,56,57}},
		-- ["n"] = {outfit={57,57,57,56}},
	
	}
	},
	["Circle_2"] = {
        func = "spell_aoe",
        word = "circle_2",
		vocation = {"mage","knight", "master mage"},
		cooldown = 2,
		manaCost = 1,
		aggressive = true,
		min_L = 1,
		spellGroup = 1,
		groupCooldown = 2,
		areaVariables = {
		["Default0"] = { {timeZones={1},cast="adapt",attr={"1"}}},
		["t"] = { {timeZones={1,30},cast="adapt",attr={"1"}}},

		["1"] = { 
		{timeZones={1},cast="static",dmg="dmg"},
		{timeZones={5},cast="static",dmg="dmg"},
		{timeZones={9},cast="static",dmg="dmg"},
		{timeZones={13},cast="static",dmg="dmg"},
		{timeZones={17},cast="static",dmg="dmg"},
		{timeZones={1,21},cast="static",attr={"4"}},--instant slow
		},
		["3"] = { 
			{timeZones={1},cast="static"},
		},
		["Target0"] = { 
		{timeZones={1},cast="static",dmg="dmg",effect={44,0,0,0}},
		{timeZones={5},cast="static",dmg="dmg"},
		{timeZones={9},cast="static",dmg="dmg"},
		{timeZones={13},cast="static",dmg="dmg"},
		{timeZones={17},cast="static",dmg="dmg"},
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
		-- ["Target"] = {
		-- 	{"1", "1" ,"1"},
		-- 	{"1",  0  ,"1"},
		-- 	{"1", "1" ,"1"},
		-- },
		["Target"] = {
			{"1", "1" ,"3"},
			{"1",  0  ,"1"},
			{"1", "1" ,"1"},
		}
		},
        formula = {
            ["1"] = {min = "1", max = "1"},
            ["dmg"] = {min = "(100 + |level|*1)*(1+(|mLevel|/100))", max = "(133 + |level|*2)*(1+(|mLevel|/100))"},
            ["+30%"] = {min = "(130 + |level|*1)*(1+(|mLevel|/130))", max = "(175 + |level|*2)*(1+(|mLevel|/175))"},
        },
		bonusAttributes = {
		["1"] = {attr="spell_mouseInteraction", condition={name="timeDuration",duration=3},areaSpawn="Target",onlyCaster=true},
		["3"] = {attr="teleport", condition={name="creatureAction",importance=2,repeatValue=0,repeatTime=0,repeatChance=0,actionDelay=0},emptyTargetCast=true},
		["2"] = {attr="Silence", damage=true, condition={name="timeDuration",duration=3}},
		["4"] = {attr="movementSpeed", percent=60, condition={name="timeDuration",duration=4}},
	}
	},
	["Flash"] = {
        func = "spell_aoe",
        word = "flash",
		vocation = {"mage", "master mage","sorcerer","knight"},
		cooldown = 2,
		manaCost = 1,
		aggressive = true,
		min_L = 1,
		spellGroup = 1,
		groupCooldown = 2,
		areaVariables = {
		["Default0"] = { {timeZones={1},attr={"1","animation"}}},
		-- ["Default0"] = { {timeZones={1},effect={35},attr={"1","animation"}}},
		["1es"] = { 
			{timeZones={1},cast="adapt",effect={},dmg="dmg"},
			-- {timeZones={1},cast="adapt",castDirections={0},effect={36}}, 
			-- {timeZones={1},cast="adapt",castDirections={3},effect={36}}, 
		},--invisible dmg
		["n"] = { 
			-- {timeZones={1},cast="adapt",castDirections={0},effect={36}}, 
		},
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
			{"x","x","x","x","n","1es","x","x","x","x","x"},
			{"x","x","x","x","x","1","x","x","x","x","x"},
			{"x","x","x","x","x", 0 ,"x","x","x","x","x"},
			{"x","x","x","x","x","s","x","x","x","x","x"},
			{"x","x","x","x","x","x","x","x","x","x","x"},
		},
		},
        formula = {
            ["1"] = {min = "1", max = "1"},
            ["dmg"] = {min = "(100 + |level|*1)*(1+(|mLevel|/100))", max = "(133 + |level|*2)*(1+(|mLevel|/100))"},
            ["+30%"] = {min = "(130 + |level|*1)*(1+(|mLevel|/130))", max = "(175 + |level|*2)*(1+(|mLevel|/175))"},
        },
		bonusAttributes = {
		["1"] = {attr="spell_indicator", condition={name="timeDuration",duration=5},onlyCaster=true},
		-- ["animation"] = {attr="creature_animation", condition={name="creatureAction",importance=99}, outfit={5,5,5,5}, animationDuration=1000},
		["animation"] = {attr="creature_animation", condition={name="creatureAction",importance=99}, outfit={100,100,100,100}, animationDuration=2000},
	
	}
	},
	["Basic Attack 2"] = {
        func = "spell_aoe",
        word = "basic attack 2",
		vocation = {"mage", "master mage","sorcerer","knight"},
		cooldown = 2,
		manaCost = 1,
		aggressive = true,
		min_L = 1,
		spellGroup = 1,
		groupCooldown = 2,
		areaVariables = {
		["Default0"] = { 
			{timeZones={1},cast="adapt",attr={"1","animation"}},
			{timeZones={1},cast="static",castDirections={0},effect={0,0,0,0}},
			{timeZones={1},cast="static",castDirections={1},effect={53,0,0,0}},
			{timeZones={1},cast="static",castDirections={2},effect={54,0,0,0}},
			{timeZones={1},cast="static",castDirections={3},effect={0,0,0,0}},
		},
		["3"] = { 
			
		},
		},
	areas = {
		["Default"] = {
			{"x","x","x","x","x","x","x","x","x","x","x"},
			{"x","x","x","x","x","x","x","x","x","x","x"},
			{"x","x","x","x","x","x","x","x","x","x","x"},
			{"x","x","x","x","x","x","x","x","x","x","x"},
			{"x","x","x","x","x","x","x","x","x","x","x"},
			{"x","x","x","x","x","x","x","x","x","x","x"},
			{"x","x","x","x","x","x","x","x","x","x","x"},
			{"x","x","x","x","x","x","x","x","x","x","x"},
			{"x","x","x","x","x","x","x","x","x","x","x"},
			{"x","x","x","x","x", 0 ,"x","x","x","x","x"},
			{"x","x","x","x","x","3","x","x","x","x","x"},
			{"x","x","x","x","x","x","x","x","x","x","x"},
		},
		},
        formula = {
            ["1"] = {min = "1", max = "1"},
            ["dmg"] = {min = "(100 + |level|*1)*(1+(|mLevel|/100))", max = "(133 + |level|*2)*(1+(|mLevel|/100))"},
            ["+30%"] = {min = "(130 + |level|*1)*(1+(|mLevel|/130))", max = "(175 + |level|*2)*(1+(|mLevel|/175))"},
        },
		bonusAttributes = {
		["1"] = {attr="spell_indicator", condition={name="timeDuration",duration=2},onlyCaster=true},
		["animation"] = {attr="creature_animation", condition={name="creatureAction",importance=99}, outfit={100,100,100,100}, animationDuration=500},
	
	}
	},

		["Instant Teleport"] = {
        func = "spell_aoe",
        word = "instant teleport",
		vocation = {"sorcerer","knight","mage", "master mage"},
		cooldown = 5,
		manaCost = 1,
		aggressive = true,
		min_L = 1,
		spellGroup = 1,
		groupCooldown = 2,
		areaVariables = {
			["Default0"] = { {timeZones={1},effect={},attr={"1"},effect={0,0,0,0}}},
			["e"] = { {timeZones={1},cast="staticDirection",effect={0,0,0,0}}},
			["t"] = { {timeZones={1},attr={"1"},effect={0,0,0,0}}},--throw sword indicator
			["Target0"] = { 
				{cast="adapt",effect={0,0,0,0}},
				-- {timeZones={1},cast="caster",attr={"2"},effect={14,0,4,4}},
				-- {timeZones={1,31},cast="static",effect={14,14,4,4}},
				{timeZones={1},cast="static",attr={"3"},effect={14,14,0,0}}}, -- throwed sword 3s duration effect
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
            ["dmg"] = {min = "(100 + |level|*1)*(1+(|mLevel|/100))", max = "(133 + |level|*2)*(1+(|mLevel|/100))"},
            ["+30%"] = {min = "(130 + |level|*1)*(1+(|mLevel|/130))", max = "(175 + |level|*2)*(1+(|mLevel|/175))"},
        },
		bonusAttributes = {
		["1"] = {attr="spell_mouseInteraction", condition={name="timeDuration",duration=2},areaSpawn="Target",onlyCaster=true,distanceEffect={4}},
		["3"] = {attr="teleport", condition={name="creatureAction",importance=2,repeatValue=0,repeatTime=0,repeatChance=0,actionDelay=0},emptyTargetCast=true,distanceEffect={4}},
		["2"] = {attr="Silence", damage=true, condition={name="timeDuration",duration=3},distanceEffect={4}},
	}
	},
	["Explosion"] = {
		spellSV = 3260,
        func = "spell_aoe",
        word = "explosion",
		vocation = {"mage","knight", "master mage"},
		cooldown = 2,
		manaCost = 1,
		aggressive = true,
		min_L = 1,
		spellGroup = 1,
		groupCooldown = 2,
		areaVariables = {
		["Default0"] = { {timeZones={1},cast="adapt",attr={"1"}}},
		["t"] = { {timeZones={1,30},cast="adapt",attr={"1"}}},

		["1"] = { 
		{timeZones={1},cast="static",dmg="dmg"},
		},
		["3"] = { 
			{timeZones={1},cast="static",effect={35,0,0,0}},
		},
		["Target0"] = { 
		{timeZones={1},cast="static",dmg="dmg"},
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
		-- ["Target"] = {
		-- 	{"1", "1" ,"1"},
		-- 	{"1",  0  ,"1"},
		-- 	{"1", "1" ,"1"},
		-- },
		["Target"] = {
			{"1", "1" ,"1"},
			{"1",  0  ,"1"},
			{"1", "1" ,"3"},
		}
		},
        formula = {
            ["1"] = {min = "1", max = "1"},
            ["dmg"] = {min = "(100 + |level|*1)*(1+(|mLevel|/100))", max = "(133 + |level|*2)*(1+(|mLevel|/100))"},
            ["+30%"] = {min = "(130 + |level|*1)*(1+(|mLevel|/130))", max = "(175 + |level|*2)*(1+(|mLevel|/175))"},
        },
		bonusAttributes = {
		["1"] = {attr="spell_mouseInteraction", condition={name="timeDuration",duration=3},areaSpawn="Target",onlyCaster=true},
		["3"] = {attr="teleport", condition={name="creatureAction",importance=2,repeatValue=0,repeatTime=0,repeatChance=0,actionDelay=0},emptyTargetCast=true},
		["2"] = {attr="Silence", damage=true, condition={name="timeDuration",duration=3}},
		["4"] = {attr="movementSpeed", percent=60, condition={name="timeDuration",duration=4}},
	}
	},
	["Circle"] = {
        func = "spell_aoe",
        word = "circle",
		vocation = {"archer", "knight","eagle eye"},
		cooldown = 1,
		manaCost = 1,
		aggressive = true,
		min_L = 1,
		spellGroup = 1,
		groupCooldown = 2,
		areaVariables = {
			["Default0"] = {},
			["1"] = { 
				{timeZones={1},cast="staticDirection",dmg="dmg"},
				{timeZones={5},cast="staticDirection",dmg="dmg"},
				{timeZones={9},cast="staticDirection",dmg="dmg"},
				{timeZones={13},cast="staticDirection",dmg="dmg"},
				{timeZones={17},cast="staticDirection",dmg="dmg"},
				},
			["3"] = { 
				{timeZones={1},cast="staticDirection",dmg="dmg",effect={43}},
				{timeZones={5},cast="staticDirection",dmg="dmg"},
				{timeZones={9},cast="staticDirection",dmg="dmg"},
				{timeZones={13},cast="staticDirection",dmg="dmg"},
				{timeZones={17},cast="staticDirection",dmg="dmg"},
				},
		},
	areas = {
		["Default"] = {
			{"1","1", "1"},
			{"1", 0 , "1"},
			{"1","1", "3"},
		},
		},
        formula = {
            ["dmg"] = {min = "(100 + |level|*1)*(1+(|mLevel|/100))", max = "(133 + |level|*2)*(1+(|mLevel|/100))"},
        },
		bonusAttributes = {
		-- ["n"] = {attr="push", condition={name="creatureAction",importance=99},pushDirections={0},pushDistance=1},
		-- ["e"] = {attr="push", condition={name="creatureAction",importance=99},pushDirections={1},pushDistance=1},
		-- ["s"] = {attr="push", condition={name="creatureAction",importance=99},pushDirections={2},pushDistance=1},
		-- ["w"] = {attr="push", condition={name="creatureAction",importance=99},pushDirections={3},pushDistance=1},
		-- ["final"] = {attr="push", condition={name="creatureAction",importance=99},hitBlockedTile="Stun",pushDirections={1,3}},
		-- ["n"] = {outfit={54,55,56,57}},
		-- ["n"] = {outfit={57,57,57,56}},
	
	}
	},
	["Circle_2"] = {
        func = "spell_aoe",
        word = "circle_2",
		vocation = {"mage","knight", "master mage"},
		cooldown = 2,
		manaCost = 1,
		aggressive = true,
		min_L = 1,
		spellGroup = 1,
		groupCooldown = 2,
		areaVariables = {
		["Default0"] = { {timeZones={1},cast="adapt",attr={"1"}}},
		["t"] = { {timeZones={1,30},cast="adapt",attr={"1"}}},

		["1"] = { 
		{timeZones={1},cast="static",dmg="dmg"},
		{timeZones={5},cast="static",dmg="dmg"},
		{timeZones={9},cast="static",dmg="dmg"},
		{timeZones={13},cast="static",dmg="dmg"},
		{timeZones={17},cast="static",dmg="dmg"},
		{timeZones={1,21},cast="static",attr={"4"}},--instant slow
		},
		["3"] = { 
			{timeZones={1},cast="static"},
		},
		["Target0"] = { 
		{timeZones={1},cast="static",dmg="dmg",effect={44,0,0,0}},
		{timeZones={5},cast="static",dmg="dmg"},
		{timeZones={9},cast="static",dmg="dmg"},
		{timeZones={13},cast="static",dmg="dmg"},
		{timeZones={17},cast="static",dmg="dmg"},
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
		-- ["Target"] = {
		-- 	{"1", "1" ,"1"},
		-- 	{"1",  0  ,"1"},
		-- 	{"1", "1" ,"1"},
		-- },
		["Target"] = {
			{"1", "1" ,"3"},
			{"1",  0  ,"1"},
			{"1", "1" ,"1"},
		}
		},
        formula = {
            ["1"] = {min = "1", max = "1"},
            ["dmg"] = {min = "(100 + |level|*1)*(1+(|mLevel|/100))", max = "(133 + |level|*2)*(1+(|mLevel|/100))"},
            ["+30%"] = {min = "(130 + |level|*1)*(1+(|mLevel|/130))", max = "(175 + |level|*2)*(1+(|mLevel|/175))"},
        },
		bonusAttributes = {
		["1"] = {attr="spell_mouseInteraction", condition={name="timeDuration",duration=3},areaSpawn="Target",onlyCaster=true},
		["3"] = {attr="teleport", condition={name="creatureAction",importance=2,repeatValue=0,repeatTime=0,repeatChance=0,actionDelay=0},emptyTargetCast=true},
		["2"] = {attr="Silence", damage=true, condition={name="timeDuration",duration=3}},
		["4"] = {attr="movementSpeed", percent=60, condition={name="timeDuration",duration=4}},
	}
	},
	["Flash"] = {
        func = "spell_aoe",
        word = "flash",
		vocation = {"mage", "master mage","sorcerer","knight"},
		cooldown = 2,
		manaCost = 1,
		aggressive = true,
		min_L = 1,
		spellGroup = 1,
		groupCooldown = 2,
		areaVariables = {
		["Default0"] = { {timeZones={1},attr={"1","animation"}}},
		-- ["Default0"] = { {timeZones={1},effect={35},attr={"1","animation"}}},
		["1es"] = { 
			{timeZones={1},cast="adapt",effect={},dmg="dmg"},
			-- {timeZones={1},cast="adapt",castDirections={0},effect={36}}, 
			-- {timeZones={1},cast="adapt",castDirections={3},effect={36}}, 
		},--invisible dmg
		["n"] = { 
			-- {timeZones={1},cast="adapt",castDirections={0},effect={36}}, 
		},
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
			{"x","x","x","x","n","1es","x","x","x","x","x"},
			{"x","x","x","x","x","1","x","x","x","x","x"},
			{"x","x","x","x","x", 0 ,"x","x","x","x","x"},
			{"x","x","x","x","x","s","x","x","x","x","x"},
			{"x","x","x","x","x","x","x","x","x","x","x"},
		},
		},
        formula = {
            ["1"] = {min = "1", max = "1"},
            ["dmg"] = {min = "(100 + |level|*1)*(1+(|mLevel|/100))", max = "(133 + |level|*2)*(1+(|mLevel|/100))"},
            ["+30%"] = {min = "(130 + |level|*1)*(1+(|mLevel|/130))", max = "(175 + |level|*2)*(1+(|mLevel|/175))"},
        },
		bonusAttributes = {
		["1"] = {attr="spell_indicator", condition={name="timeDuration",duration=5},onlyCaster=true},
		-- ["animation"] = {attr="creature_animation", condition={name="creatureAction",importance=99}, outfit={5,5,5,5}, animationDuration=1000},
		["animation"] = {attr="creature_animation", condition={name="creatureAction",importance=99}, outfit={100,100,100,100}, animationDuration=2000},
	
	}
	},
	["Basic Attack 2"] = {
        func = "spell_aoe",
        word = "basic attack 2",
		vocation = {"mage", "master mage","sorcerer","knight"},
		cooldown = 2,
		manaCost = 1,
		aggressive = true,
		min_L = 1,
		spellGroup = 1,
		groupCooldown = 2,
		areaVariables = {
		["Default0"] = { 
			{timeZones={1},cast="adapt",attr={"1","animation"}},
			{timeZones={1},cast="static",castDirections={0},effect={0,0,0,0}},
			{timeZones={1},cast="static",castDirections={1},effect={53,0,0,0}},
			{timeZones={1},cast="static",castDirections={2},effect={54,0,0,0}},
			{timeZones={1},cast="static",castDirections={3},effect={0,0,0,0}},
		},
		["3"] = { 
			
		},
		},
	areas = {
		["Default"] = {
			{"x","x","x","x","x","x","x","x","x","x","x"},
			{"x","x","x","x","x","x","x","x","x","x","x"},
			{"x","x","x","x","x","x","x","x","x","x","x"},
			{"x","x","x","x","x","x","x","x","x","x","x"},
			{"x","x","x","x","x","x","x","x","x","x","x"},
			{"x","x","x","x","x","x","x","x","x","x","x"},
			{"x","x","x","x","x","x","x","x","x","x","x"},
			{"x","x","x","x","x","x","x","x","x","x","x"},
			{"x","x","x","x","x","x","x","x","x","x","x"},
			{"x","x","x","x","x", 0 ,"x","x","x","x","x"},
			{"x","x","x","x","x","3","x","x","x","x","x"},
			{"x","x","x","x","x","x","x","x","x","x","x"},
		},
		},
        formula = {
            ["1"] = {min = "1", max = "1"},
            ["dmg"] = {min = "(100 + |level|*1)*(1+(|mLevel|/100))", max = "(133 + |level|*2)*(1+(|mLevel|/100))"},
            ["+30%"] = {min = "(130 + |level|*1)*(1+(|mLevel|/130))", max = "(175 + |level|*2)*(1+(|mLevel|/175))"},
        },
		bonusAttributes = {
		["1"] = {attr="spell_indicator", condition={name="timeDuration",duration=2},onlyCaster=true},
		["animation"] = {attr="creature_animation", condition={name="creatureAction",importance=99}, outfit={100,100,100,100}, animationDuration=500},
	
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
		["3"] = { {timeZones={1},cast="adapt",dmg="+30%",effect={{17,15,16,18}}}},--explosion
		},
	areas = {
		["Default"] = {
			{"x","x", "2" ,"x","x"},
			{"x","x", "1" ,"x","x"},
			{"x","x", "3" ,"x","x"},
			{"x","x",  0  ,"x","x"},
			{"x","x", "x"  ,"x","x"},
		},
		},
        formula = {
            ["1"] = {min = "1", max = "1"},
            ["dmg"] = {min = "(100 + |level|*1)*(1+(|mLevel|/100))", max = "(133 + |level|*2)*(1+(|mLevel|/100))"},
            ["+30%"] = {min = "(130 + |level|*1)*(1+(|mLevel|/130))", max = "(175 + |level|*2)*(1+(|mLevel|/175))"},
        },
		bonusAttributes = {
	}
	},
	["Basic Attack"] = {
        func = "spell_aoe",
        word = "basic attack",
		vocation = {"mage", "master mage","sorcerer","knight"},
		cooldown = 2,
		manaCost = 1,
		aggressive = true,
		min_L = 1,
		spellGroup = 1,
		groupCooldown = 2,
		areaVariables = {
		["Default0"] = { {timeZones={1},attr={"1","animation"}}},
		},
	areas = {
		["Default"] = {
			{"x","x","x","x","x","x","x","x","x","x","x"},
			{"x","x","x","x","x","x","x","x","x","x","x"},
			{"x","x","x","x","x","x","x","x","x","x","x"},
			{"x","x","x","x","x","x","x","x","x","x","x"},
			{"x","x","x","x","x","x","x","x","x","x","x"},
			{"x","x","x","x","x","x","x","x","x","x","x"},
			{"x","x","x","x","x","x","x","x","x","x","x"},
			{"x","x","x","x","x","x","x","x","x","x","x"},
			{"x","x","x","x","x","x","x","x","x","x","x"},
			{"x","x","x","x","x", 0 ,"x","x","x","x","x"},
			{"x","x","x","x","x","x","x","x","x","x","x"},
			{"x","x","x","x","x","x","x","x","x","x","x"},
		},
		},
        formula = {
            ["1"] = {min = "1", max = "1"},
            ["dmg"] = {min = "(100 + |level|*1)*(1+(|mLevel|/100))", max = "(133 + |level|*2)*(1+(|mLevel|/100))"},
            ["+30%"] = {min = "(130 + |level|*1)*(1+(|mLevel|/130))", max = "(175 + |level|*2)*(1+(|mLevel|/175))"},
        },
		bonusAttributes = {
		["1"] = {attr="spell_indicator", condition={name="timeDuration",duration=2},onlyCaster=true},
		["animation"] = {attr="creature_animation", condition={name="creatureAction",importance=99}, outfit={10,10,10,10}, animationDuration=200},
	
	}
	},
	["Punches"] = {
        func = "spell_aoe",
        word = "punches",
		vocation = {"mage", "master mage","sorcerer","knight"},
		cooldown = 2,
		manaCost = 1,
		aggressive = true,
		min_L = 1,
		spellGroup = 1,
		groupCooldown = 2,
		areaVariables = {
		["Default0"] = { {timeZones={1},attr={"1","animation"}}},
		-- ["Default0"] = { {timeZones={1},effect={35},attr={"1","animation"}}},
		["n"] = { {timeZones={1},cast="adapt",castDirections={0},effect={15}}},--trigger sword effect
		["1"] = { {timeZones={1},cast="adapt",effect={},dmg="dmg"}},--trigger sword effect
		["w"] = { {timeZones={1},cast="adapt",castDirections={3},effect={15}}},--trigger sword effect
		["1es"] = { {timeZones={1},cast="adapt",effect={},dmg="dmg"},{timeZones={1},cast="adapt",castDirections={1},effect={4}}, {timeZones={1},cast="adapt",castDirections={2},effect={2}} },--invisible dmg
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
			{"x","x","x","x","x","1es","x","x","x","x","x"},
			{"x","x","x","x","w","1","n","x","x","x","x"},
			{"x","x","x","x","x", 0 ,"x","x","x","x","x"},
			{"x","x","x","x","x","x","x","x","x","x","x"},
			{"x","x","x","x","x","x","x","x","x","x","x"},
		},
		},
        formula = {
            ["1"] = {min = "1", max = "1"},
            ["dmg"] = {min = "(100 + |level|*1)*(1+(|mLevel|/100))", max = "(133 + |level|*2)*(1+(|mLevel|/100))"},
            ["+30%"] = {min = "(130 + |level|*1)*(1+(|mLevel|/130))", max = "(175 + |level|*2)*(1+(|mLevel|/175))"},
        },
		bonusAttributes = {
		["1"] = {attr="spell_indicator", condition={name="timeDuration",duration=2},onlyCaster=true},
		-- ["animation"] = {attr="creature_animation", condition={name="creatureAction",importance=99}, outfit={5,5,5,5}, animationDuration=1000},
		["animation"] = {attr="creature_animation", condition={name="creatureAction",importance=99}, outfit={10,10,10,10}, animationDuration=200},
	
	}
	},
	
	["Dash"] = {
        func = "spell_aoe",
        word = "dash",
		vocation = {"paladin"},
		cooldown = 10,
		manaCost = 1,
		aggressive = true,
		min_L = 1,
		spellGroup = 1,
		groupCooldown = 2,
		areaVariables = {
			["Default0"] = { {timeZones={1},effect={{21,24,22,23}},cast="adapt",attr={"2"}} },
			["t"] = { {timeZones={1},cast="adapt",attr={"1"}} },
		},
		-- areas = { ["Default"] = {{0}} },
		areas = { ["Default"] = {
			{"x","x", "x" ,"x","x"},
			{"x","x", "x" ,"x","x"},
			{"x","x", "x" ,"x","x"},
			{"x","x", "x" ,"x","x"},
			{"x","x", "t" ,"x","x"},
			{"x","x", "x" ,"x","x"},
			{"x","x", "x" ,"x","x"},
			{"x","x",  0  ,"x","x"},
			{"x","x", "x" ,"x","x"},
			{"x","x", "x" ,"x","x"},
			{"x","x", "x" ,"x","x"},
			},
		},
        formula = { },
		bonusAttributes = { 
			-- ["1"] = {attr="Jump", condition={name="onHit",count=1,repetitive=3,origin={ORIGIN_RANGED},hitEffect={10,13,11,12}}},
			-- ["1"] = {attr="Dash", condition={name="onHit",count=1,repetitive=3,origin={ORIGIN_RANGED},hitEffect={21,21,22,21}}},
			["1"] = {attr="teleport", condition={name="creatureAction",duration=5},emptyTargetCast=true, dashDuration=2025},
			["2"] = {attr="creature_animation", condition={name="creatureAction",importance=99}, animationDuration=1000},--, outfit="Dash"
		}
	},
	--ARCHER--
	["Jump"] = {
        func = "spell_aoe",
        word = "jump",
		vocation = {"archer","knight","eagle eye"},
		cooldown = 5,
		manaCost = 1,
		aggressive = true,
		min_L = 1,
		spellGroup = 1,
		groupCooldown = 2,
		areaVariables = {["Default0"] = { {timeZones={1},cast="adapt",attr={"1"}} }},
		areas = { ["Default"] = {{0}} },
        formula = { ["dmg"] = {min = "(100 + |level|*1)*(1+(|mLevel|/100))", max = "(133 + |level|*2)*(1+(|mLevel|/100))"} },
		bonusAttributes = { ["1"] = {attr="Jump", condition={name="onHit",count=1,repetitive=3,origin={ORIGIN_RANGED},hitEffect={10,13,11,12}}} }
	},

}

local emptyInt = 1
for i,child in pairs(Wikipedia.Spells) do
if Wikipedia.storageTable[i] then
Wikipedia.Spells[i].spellSV = Wikipedia.storageTable[i]
Wikipedia.Spells[i].spellName = i

else
Wikipedia.Spells[i].spellSV = Wikipedia.storageTable["IntegerIndicator"]-emptyInt
Wikipedia.Spells[i].spellName = i
emptyInt = emptyInt + 1
end
end

