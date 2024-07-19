    CUSTOM_ATTRIBUTE_BONUSES = "bonuses"
    STAT_HP                = "HP"
    STAT_MP                = "MP"
    STAT_MAGICLEVEL        = "Magic Level"
    STAT_MELEE             = "Melee"
    STAT_FIST              = "Fist"
    STAT_CLUB              = "Club"
    STAT_SWORD             = "Sword"
    STAT_AXE               = "Axe"
    STAT_DISTANCE          = "Distance"
    STAT_SHIELDING         = "Shielding"
    STAT_FISHING           = "Fishing"
    STAT_ALLSKILLS         = "Skills"
    STAT_CRIT              = "UNUSED"
    STAT_CRITCHANCE        = "Crit"
    --STAT_LIFELEECH         = "UNUSED"
    STAT_LIFELEECHCHANCE   = "Life Leech"
    --STAT_MANALEECH         = "UNUSED"
    STAT_MANALEECHCHANCE   = "Mana Leech"
	--STAT_PHYSICAL_RESIST   = "Physical Resist"
	STAT_FIRE_RESIST       = "Fire Resist"
	STAT_EARTH_RESIST      = "Earth Resist"
	STAT_ENERGY_RESIST     = "Energy Resist"
	STAT_ICE_RESIST        = "Ice Resist"
	STAT_HOLY_RESIST       = "Holy Resist"
	STAT_DEATH_RESIST      = "Death Resist"
    -- STAT_DROWN_RESIST = "Drown Resist"

	
    STAT_SYSTEM_STATTABLE = {
        STAT_HP, STAT_MP,
        STAT_MAGICLEVEL,
        STAT_MELEE, STAT_ALLSKILLS, STAT_FIST, STAT_CLUB, STAT_SWORD, STAT_AXE, STAT_DISTANCE, STAT_SHIELDING, STAT_FISHING,
        STAT_CRIT, STAT_CRITCHANCE,
        STAT_LIFELEECH, STAT_LIFELEECHCHANCE, -- hp leech
        STAT_MANALEECH, STAT_MANALEECHCHANCE, -- mana leech  
        STAT_PHYSICAL_RESIST, 
        STAT_FIRE_RESIST,
        STAT_EARTH_RESIST,
        STAT_ENERGY_RESIST,
        STAT_ICE_RESIST,
        STAT_HOLY_RESIST,
        STAT_DEATH_RESIST,
    }
	
	TABLE_STAT_SKILLS = {
		STAT_MAGICLEVEL,
		STAT_ALLSKILLS
    }
	
    TABLE_STAT_ELEMENTAL_RESIST = {
		--STAT_PHYSICAL_RESIST,
		STAT_FIRE_RESIST,
		STAT_EARTH_RESIST,
		STAT_ENERGY_RESIST,
		STAT_ICE_RESIST,
		STAT_HOLY_RESIST,
		STAT_DEATH_RESIST,
		--STAT_DROWN_RESIST
    }
    
        STAT_SYSTEM_CONDITIONTABLE = {
        -- regular stats
        [STAT_HP]          = { type = CONDITION_ATTRIBUTES,        flat = CONDITION_PARAM_STAT_MAXHITPOINTS,    percent = CONDITION_PARAM_STAT_MAXHITPOINTSPERCENT    },
        [STAT_MP]          = { type = CONDITION_ATTRIBUTES,        flat = CONDITION_PARAM_STAT_MAXMANAPOINTS,    percent = CONDITION_PARAM_STAT_MAXMANAPOINTSPERCENT    },
        [STAT_MAGICLEVEL]  = { type = CONDITION_ATTRIBUTES,        flat = CONDITION_PARAM_STAT_MAGICPOINTS,    percent = CONDITION_PARAM_STAT_MAGICPOINTSPERCENT    },
        [STAT_MELEE]       = { type = CONDITION_ATTRIBUTES,        flat = CONDITION_PARAM_SKILL_MELEE,            percent = CONDITION_PARAM_SKILL_MELEEPERCENT        },
        [STAT_FIST]        = { type = CONDITION_ATTRIBUTES,        flat = CONDITION_PARAM_SKILL_FIST,            percent = CONDITION_PARAM_SKILL_FISTPERCENT            },
        [STAT_CLUB]        = { type = CONDITION_ATTRIBUTES,        flat = CONDITION_PARAM_SKILL_CLUB,            percent = CONDITION_PARAM_SKILL_CLUBPERCENT            },
        [STAT_SWORD]       = { type = CONDITION_ATTRIBUTES,        flat = CONDITION_PARAM_SKILL_SWORD,            percent = CONDITION_PARAM_SKILL_SWORDPERCENT        },
        [STAT_AXE]         = { type = CONDITION_ATTRIBUTES,        flat = CONDITION_PARAM_SKILL_AXE,            percent = CONDITION_PARAM_SKILL_AXEPERCENT            },
        [STAT_DISTANCE]    = { type = CONDITION_ATTRIBUTES,        flat = CONDITION_PARAM_SKILL_DISTANCE,        percent = CONDITION_PARAM_SKILL_DISTANCEPERCENT        },
        [STAT_SHIELDING]   = { type = CONDITION_ATTRIBUTES,        flat = CONDITION_PARAM_SKILL_SHIELD,        percent = CONDITION_PARAM_SKILL_SHIELDPERCENT        },
        [STAT_FISHING]     = { type = CONDITION_ATTRIBUTES,        flat = CONDITION_PARAM_SKILL_FISHING,          percent = CONDITION_PARAM_SKILL_FISHINGPERCENT        },
		[STAT_ALLSKILLS]       = { type = CONDITION_ATTRIBUTES,    flat = CONDITION_PARAM_SKILL_ALL,            percent = CONDITION_PARAM_SKILL_ALLPERCENT        },
        

        [STAT_LIFELEECHCHANCE]    = { type = CONDITION_ATTRIBUTES,        flat = CONDITION_PARAM_SKILL_LIFE_LEECH_AMOUNT,    percent = CONDITION_PARAM_SKILL_LIFE_LEECH_AMOUNT,        specialPercent = true},
        [STAT_MANALEECHCHANCE]    = { type = CONDITION_ATTRIBUTES,        flat = CONDITION_PARAM_SKILL_MANA_LEECH_AMOUNT,    percent = CONDITION_PARAM_SKILL_MANA_LEECH_AMOUNT,        specialPercent = true},
        [STAT_CRITCHANCE]        = { type = CONDITION_ATTRIBUTES,        flat = CONDITION_PARAM_SKILL_CRITICAL_HIT_CHANCE,    percent = CONDITION_PARAM_SKILL_CRITICAL_HIT_CHANCE,    specialPercent = true},
		
		--        [STAT_CRIT]                = { type = CONDITION_ATTRIBUTES,        flat = CONDITION_PARAM_SPECIALSKILL_CRITICALHITAMOUNT,    percent = CONDITION_PARAM_SPECIALSKILL_CRITICALHITAMOUNT,    specialPercent = true},
		--        [STAT_MANALEECH]        = { type = CONDITION_ATTRIBUTES,        flat = CONDITION_PARAM_SPECIALSKILL_MANALEECHAMOUNT,    percent = CONDITION_PARAM_SPECIALSKILL_MANALEECHAMOUNT,        specialPercent = true},
		--        [STAT_LIFELEECH]        = { type = CONDITION_ATTRIBUTES,        flat = CONDITION_PARAM_SKILL_LIFE_LEECH_AMOUNT,    percent = CONDITION_PARAM_SKILL_LIFE_LEECH_AMOUNT,        specialPercent = true},
		
    }

if not PLAYERSTATS then
    PLAYERSTATS = {}
end    

function calculateBuffValue(player, buffType, buffValue, isFlat)
    local buffData = STAT_SYSTEM_CONDITIONTABLE[buffType]
    if buffData then
        if not isFlat then
            if not buffData.specialPercent then
                buffValue = buffValue + 100
            end
        end

        return buffValue
    end
end

function getConditionStatCode(stat, isFlat)
    local statIndex = table.find(STAT_SYSTEM_STATTABLE, stat)
    
    if statIndex then
        return 1 .. (isFlat and 1 or 0) .. (statIndex < 10 and "0" .. statIndex or statIndex)
    end
end

function getBonusesBuffParam(buffData, isFlat)
    if isFlat then
        return buffData.flat
    end
    
    return buffData.percent    
end



function tableHasKey(table,key)
    return table[key] ~= nil
end

-- tfs just doesn't have it lol
table.find = function(table, value)
    for i, v in pairs(table) do
        if v == value then
            return i
        end
    end
    return false
end





function compileItemBonuses(stats)
    return table.concat(stats, "`")
end

function string:verifyStatIntegrity()
    local word = self:match("[+-x]?%d+%.?%d*%%?") or ""
    local length = self:len()
    
    return word:len() == length
end



function string:getBonusesValues()
    local s = self:split(";")
    local out = {}
    
    if not s[2] then
        s[2] = ""
    end
    
    out = {{
        key = s[1],
        sign = s[2]:match("[+-x]?"),
        amount = s[2]:match("%d+%.?%d*"),
        flat = not s[2]:match("%%")
    }}
    
    return out
end
