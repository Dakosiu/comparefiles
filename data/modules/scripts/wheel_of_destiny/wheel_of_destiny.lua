WheelOfDestiny = {}

WheelOfDestiny.Client_Packets = {
	OpenWheel = 0x61,
	ModifyWheel = 0x62
}

WheelOfDestiny.Server_Packets = {
	SendWheel = 0x5F,
	
}

WheelOfDestiny.Sides = {
	TOP_LEFT = 37,
	TOP_RIGHT = 38,
	BOTTOM_RIGHT = 39,
	BOTTOM_LEFT = 40,
}

WheelOfDestiny.Perks_Level = {
	TOP = 200,
	MIDDLE_TOP = 150,
	MIDDLE = 100,
	MIDDLE_BOTTOM = 75,
	BOTTOM = 50,
}

WheelOfDestiny.RevelationLevels = {
	FIRST_LEVEL = 250,
	SECOND_LEVEL = 500,
	THIRD_LEVEL = 1000,
}

WheelOfDestiny.RevelationBonus = {
	FIRST_LEVEL = {bonusHealing = 4, bonusDamage = 4},
	SECOND_LEVEL = {bonusHealing = 9, bonusDamage = 9},
	THIRD_LEVEL = {bonusHealing = 20, bonusDamage = 20}
}

WheelOfDestiny.Revelation = {
	Gift_Of_Life = {	
		FIRST_LEVEL = {cooldown = 30 * 60 * 60 * 1000, overkill = 0.2, healing = 0.2},
		SECOND_LEVEL = {cooldown = 20 * 60 * 60 * 1000, overkill = 0.25, healing = 0.25},
		THIRD_LEVEL = {cooldown = 10 * 60 * 60 * 1000, overkill = 0.3, healing = 0.3},
		SIDE = WheelOfDestiny.Sides.TOP_LEFT,
		EFFECT = CONST_ME_GIFT_OF_LIFE,
		MESSAGE = "That was close! Fortunately, you were saved by the Gift of Life.",
		SUBID = 255,
		EVENT = "wheelOfDestinyGiftOfLife",
	},
	Avatar_Of_Light = {
		FIRST_LEVEL = {cooldown = 120 * 60 * 1000, damageReduction = 95, criticalChance = 100, criticalDamage = 5, duration = 15 * 1000},
		SECOND_LEVEL = {cooldown = 90 * 60 * 1000, damageReduction = 90, criticalChance = 100, criticalDamage = 10, duration = 15 * 1000},
		THIRD_LEVEL = {cooldown = 60 * 60 * 1000, damageReduction = 85, criticalChance = 100, criticalDamage = 15, duration = 15 * 1000},
		VOCATION = VOCATION.BASE_ID.PALADIN,
		MANA = 1500,
		SPELLID = 265,
		VOCATIONS = {"paladin;true", "royal paladin;true"},
		WORDS = "uteta res sac",
		OUTFIT = {lookType = 1594},
		EFFECT = CONST_ME_AVATAR,
		SIDE = WheelOfDestiny.Sides.BOTTOM_RIGHT,
		SPELL = "Avatar of Light",
	},
	Avatar_Of_Steel = {
		FIRST_LEVEL = {cooldown = 120 * 60 * 1000, damageReduction = 95, criticalChance = 100, criticalDamage = 5, duration = 15 * 1000},
		SECOND_LEVEL = {cooldown = 90 * 60 * 1000, damageReduction = 90, criticalChance = 100, criticalDamage = 10, duration = 15 * 1000},
		THIRD_LEVEL = {cooldown = 60 * 60 * 1000, damageReduction = 85, criticalChance = 100, criticalDamage = 15, duration = 15 * 1000},
		VOCATION = VOCATION.BASE_ID.KNIGHT,
		MANA = 800,
		SPELLID = 264,
		VOCATIONS = {"knight;true", "elite knight;true"},
		WORDS = "uteta res eq",
		OUTFIT = {lookType = 1593},
		EFFECT = CONST_ME_AVATAR,
		SIDE = WheelOfDestiny.Sides.BOTTOM_RIGHT,
		SPELL = "Avatar of Steel",
	},
	Avatar_Of_Nature = {
		FIRST_LEVEL = {cooldown = 120 * 60 * 1000, damageReduction = 95, criticalChance = 100, criticalDamage = 5, duration = 15 * 1000},
		SECOND_LEVEL = {cooldown = 90 * 60 * 1000, damageReduction = 90, criticalChance = 100, criticalDamage = 10, duration = 15 * 1000},
		THIRD_LEVEL = {cooldown = 60 * 60 * 1000, damageReduction = 85, criticalChance = 100, criticalDamage = 15, duration = 15 * 1000},
		VOCATION = VOCATION.BASE_ID.DRUID,
		MANA = 2200,
		SPELLID = 267,
		VOCATIONS = {"druid;true", "elder druid;true"},
		WORDS = "uteta res dru",
		OUTFIT = {lookType = 1596},
		EFFECT = CONST_ME_AVATAR,
		SIDE = WheelOfDestiny.Sides.BOTTOM_RIGHT,
		SPELL = "Avatar of Nature",
	},
	Avatar_Of_Storm = {
		FIRST_LEVEL = {cooldown = 120 * 60 * 1000, damageReduction = 95, criticalChance = 100, criticalDamage = 5, duration = 15 * 1000},
		SECOND_LEVEL = {cooldown = 90 * 60 * 1000, damageReduction = 90, criticalChance = 100, criticalDamage = 10, duration = 15 * 1000},
		THIRD_LEVEL = {cooldown = 60 * 60 * 1000, damageReduction = 85, criticalChance = 100, criticalDamage = 15, duration = 15 * 1000},
		VOCATION = VOCATION.BASE_ID.SORCERER,
		MANA = 2200,
		SPELLID = 266,
		VOCATIONS = {"sorcerer;true", "master sorcerer;true"},
		WORDS = "uteta res ven",
		OUTFIT = {lookType = 1595},
		EFFECT = CONST_ME_AVATAR,
		SIDE = WheelOfDestiny.Sides.BOTTOM_RIGHT,
		SPELL = "Avatar of Storm",
	},
	Great_Death_Beam = {
		FIRST_LEVEL = {area = AREA_BEAM7, diagonalArea = AREADIAGONAL_BEAM7, amplification = 1, cooldown = 10 * 1000},
		SECOND_LEVEL = {area = AREA_BEAM8, diagonalArea = AREADIAGONAL_BEAM8, amplification = 1.2, cooldown = 8 * 1000},
		THIRD_LEVEL = {area = AREA_BEAM9, diagonalArea = AREADIAGONAL_BEAM9, amplification = 1.4, cooldown = 6 * 1000},
		VOCATION = VOCATION.BASE_ID.SORCERER,
		GROUPCOOLDOWN = 6 * 1000,
		SIDE = WheelOfDestiny.Sides.TOP_RIGHT,
		MANA = 140,
		SPELLID = 260,
		SPELL = "Great Death Beam",
	},
	Drain_Body = {
		FIRST_LEVEL = {manaLeech = 100, lifeLeech = 300},
		SECOND_LEVEL = {manaLeech = 200, lifeLeech = 400},
		THIRD_LEVEL = {manaLeech = 300, lifeLeech = 500},
		SIDE = WheelOfDestiny.Sides.BOTTOM_LEFT,
		VOCATION = VOCATION.BASE_ID.SORCERER,
	},
	Blessing_Of_The_Grove = {
		FIRST_LEVEL = {{minHp = 0.30, amplification = 1.12}, {minHp = 0.60, amplification = 1.06}},
		SECOND_LEVEL = {{minHp = 0.30, amplification = 1.18}, {minHp = 0.60, amplification = 1.09}},
		THIRD_LEVEL = {{minHp = 0.30, amplification = 1.24}, {minHp = 0.60, amplification = 1.12}},
		SIDE = WheelOfDestiny.Sides.TOP_RIGHT,
		VOCATION = VOCATION.BASE_ID.DRUID,
	},
	Ice_Burst = {
		FIRST_LEVEL = {minHp = 0.6, amplification = 1.2, cooldown = 22 * 1000},
		SECOND_LEVEL = {minHp = 0.6, amplification = 1.4, cooldown = 18 * 1000},
		THIRD_LEVEL = {minHp = 0.6, amplification = 1.6, cooldown = 14 * 1000},
		SPELL = "Ice Burst",
		WORDS = "exevo ulus frigo",
		ID = 263,
		EFFECT = CONST_ME_ICEATTACK,
		TYPE = COMBAT_ICEDAMAGE,
		SIDE = WheelOfDestiny.Sides.BOTTOM_LEFT,
		VOCATION = VOCATION.BASE_ID.DRUID,
	},
	Terra_Burst = {
		FIRST_LEVEL = {minHp = 0.6, amplification = 1.2, cooldown = 22 * 1000},
		SECOND_LEVEL = {minHp = 0.6, amplification = 1.4, cooldown = 18 * 1000},
		THIRD_LEVEL = {minHp = 0.6, amplification = 1.6, cooldown = 14 * 1000},
		SPELL = "Terra Burst",
		ID = 262,
		WORDS = "exevo ulus tera",
		EFFECT = CONST_ME_SMALLPLANTS,
		TYPE = COMBAT_EARTHDAMAGE,
		SIDE = WheelOfDestiny.Sides.BOTTOM_LEFT,
		VOCATION = VOCATION.BASE_ID.DRUID,
	},
	Divine_Empowerment = {
		FIRST_LEVEL = {amplification = 1.08, cooldown = 32 * 1000},
		SECOND_LEVEL = {amplification = 1.1, cooldown = 28 * 1000},
		THIRD_LEVEL = {amplification = 1.12, cooldown = 24 * 1000},
		SPELL = "Divine Empowerment",
		WORDS = "utevo grav san",
		ID = 268,
		EFFECT = CONST_ME_DIVINE_EMPOWERMENT,
		VOCATION = VOCATION.BASE_ID.PALADIN,
		SIDE = WheelOfDestiny.Sides.BOTTOM_LEFT,
		DURATION = 5 * 1000,
		PLAYERS = {}, -- keep empty
	},
	Divine_Grenade = {
		FIRST_LEVEL = {amplification = 1, cooldown = 26 * 1000},
		SECOND_LEVEL = {amplification = 1.2, cooldown = 20 * 1000},
		THIRD_LEVEL = {amplification = 1.4, cooldown = 14 * 1000},
		VOCATION = VOCATION.BASE_ID.PALADIN,
		EFFECT = CONST_ME_HOLYDAMAGE,
		SPELL = "Divine Grenade",
		WORDS = "exevo tempo mas san",
		ID = 258,
		DELAY = 3 * 1000,
		SIDE = WheelOfDestiny.Sides.TOP_RIGHT,
	},
	-- Knight Revelation on Source
	Executioners_Throw = {
		FIRST_LEVEL = {amplification = 2, cooldown = 18 * 1000, targets = 2},
		SECOND_LEVEL = {amplification = 2.25, cooldown = 14 * 1000, targets = 3},
		THIRD_LEVEL = {amplification = 2.5, cooldown = 10 * 1000, targets = 4},
		VOCATION = VOCATION.BASE_ID.KNIGHT,
		EFFECT = CONST_ME_DRAWBLOOD,
		SPELL = "Executioner's Throw",
		WORDS = "exori amp kor",
		ID = 261,
		SIDE = WheelOfDestiny.Sides.TOP_RIGHT,
	},
}


WheelOfDestiny.SpecialConviction = {
	[VOCATION.BASE_ID.SORCERER] = {
		Runic_Mastery = {
			Perks = {1},
			Chance = 25000,
			Magic_Level = {
				Own = 1.2,
				Others = 1.1
			}
		},
		Augmented_Focus_Spells = {
			Perks = {21, 6},
			Amplification = 1.1,
			CooldownReduction = 4000,
		},
		Focus_Mastery = {
			Perks = {36},
			Time_Storage = 300020300,
			Duration = 12,
			Amplification = 1.35,
		},
		Augmented_Great_Fire_Wave = {
			Perks = {16, 31},
			Crit_Damage = 15,
			Amplification = 1.05,
		},
		Augmented_Sap_Strength = {
			Perks = {26, 11},
			Area = AREA_CIRCLE5X5V2,
			Damage_Reduction = 89
		},
		Augmented_Magic_Shield = {
			Perks = {8, 24},
			Amplification = 1.5,
			CooldownReduction = 6000
		},
		Augmented_Energy_Wave = {
			Perks = {29, 13},
			Amplification = 1.1,
			Area = AREA_SQUAREWAVE5V2
		},
	},
	[VOCATION.BASE_ID.DRUID] = {
		Runic_Mastery = {
			Perks = {36},
			Chance = 25000,
			Magic_Level = {
				Own = 1.2,
				Others = 1.1
			}
		},
		Augmented_Strong_Ice_Wave = {
			Perks = {21, 6},
			Amplification = 1.1,
			ManaLeech = 300,
		},
		Augmented_Nature_Embrace = {
			Perks = {26, 11},
			Amplification = 1.1,
			CooldownReduction = 10000,
		},
		Augmented_Mass_Healing = {
			Perks = {24, 8},
			Amplification = 1.1,
			Area = AREA_CIRCLE5X5V2,
		},
		Augmented_Terra_Wave = {
			Perks = {13, 29},
			Amplification = 1.1,
			LifeLeech = 500,
		},
		Augmented_Heal_Friend = {
			Perks = {16, 31},
			Amplification = 1.1,
			ManaReduction = 10,
		},
		Healing_Link = {
			Perks = {1},
			HealingPercent = 0.1,
		}
	},
	[VOCATION.BASE_ID.PALADIN] = {
		Augmented_Divine_Caldera = {
			Perks = {16, 31},
			ManaReduction = 20,
			Amplification = 1.1,
		},
		Augmented_Sharpshooter = { 
			Perks = {21, 6},
			CooldownReduction = 6000,
			FocusReduction = 8000,
			NewSkill = 45,
		},
		Augmented_Divine_Dazzle = {
			Perks = {11, 26},
			ExtraTarget = 1,
			ExtraDuration = 4000,
			CooldownReduction = 4000,
		},
		Augmented_Ethereal_Spear = {
			Perks = {8, 24},
			CooldownReduction = 2000,
			Amplification = 1.2,
		},
		Augmented_Swift_Foot = {
			Perks = {29, 13},
			FocusReduction = 8000,
			ReducedDamage = 50,
			CooldownReduction = 6000,
		},
		--[[Ballistic_Mastery Handled on source]]
		--[[Positional_Tactics Handled on source]]
	},
	[VOCATION.BASE_ID.KNIGHT] = {
		Augmented_Fierce_Berserk = {
			Perks = {16, 31},
			ManaReduction = 30,
			Amplification = 1.1,
		},
		Augmented_Front_Sweep = {
			Perks = {21, 6},
			LifeLeech = 500,
			Amplification = 1.2,
		},
		Augmented_Intense_Wound_Cleansing = {
			Perks = {29, 13},
			Amplification = 1.2,
			CooldownReduction = 300000,
		},
		Augmented_Groundshaker = {
			Perks = {8, 24},
			Amplification = 1.1,
			CooldownReduction = 2000,
		},
		Augmented_Chivalrous_Challenge = {
			Perks = {11, 26},
			ManaReduction = 20,
			ExtraTarget = 1,
		},
		--[[Battle Instinct Handled on source]]
		Battle_Healing = {
			Perks = {36},
			HealingMin = function(hp, level, shielding)
				local value = (level * 0.1 + shielding * 0.3) + 12
				if hp <= 30 then
					value = value * 3
				elseif hp <= 60 then
					value = value * 2
				end
				return value
			end,
			HealingMax = function(hp, level, shielding)
				local value = (level * 0.1 + shielding * 0.5) + 20
				if hp <= 30 then
					value = value * 3
				elseif hp <= 60 then
					value = value * 2
				end
				return value
			end
		}
	},
}

WheelOfDestiny.Dedication = {
	HP_AND_MANA = {type = CONDITION_ATTRIBUTES, params = {{param = CONDITION_PARAM_STAT_MAXHITPOINTS, bonus = {1, 1, 2, 3}}, {param = CONDITION_PARAM_STAT_MAXMANAPOINTS, bonus = {6, 6, 3, 1}}}},
	HP = {type = CONDITION_ATTRIBUTES, params = {{param = CONDITION_PARAM_STAT_MAXHITPOINTS, bonus = {1, 1, 2, 3}}}},
	MANA = {type = CONDITION_ATTRIBUTES, params = {{param = CONDITION_PARAM_STAT_MAXMANAPOINTS, bonus = {6, 6, 3, 1}}}},
	DAMAGE_MITIGATION = {type = CONDITION_ATTRIBUTES, params = {{param = CONDITION_PARAM_STAT_DAMAGEMITIGATION, bonus = {3, 3, 3, 3}}}},
	CAPACITY = {type = CONDITION_ATTRIBUTES, params = {{param = CONDITION_PARAM_STAT_CAPACITY, bonus = {200, 200, 400, 500}}}},
}

WheelOfDestiny.Conviction = {
	MANA_LEECH = {type = CONDITION_ATTRIBUTES, params = {{param = CONDITION_PARAM_SKILL_MANA_LEECH_CHANCE, bonus = 100}, {param = CONDITION_PARAM_SKILL_MANA_LEECH_AMOUNT, bonus = 25}}},
	ICE_RESIST = {type = CONDITION_SPECIALATTRIBUTES, params = {{param = CONDITION_PARAM_ABSORB_ICEPERCENT, bonus = 2}}},
	LIFE_LEECH = {type = CONDITION_ATTRIBUTES, params = {{param = CONDITION_PARAM_SKILL_LIFE_LEECH_CHANCE, bonus = 100}, {param = CONDITION_PARAM_SKILL_LIFE_LEECH_AMOUNT, bonus = 75}}},
	SKILL = {type = CONDITION_ATTRIBUTES, vocations = {[VOCATION.BASE_ID.SORCERER] = {param = CONDITION_PARAM_STAT_MAGICPOINTS, bonus = 1}, [VOCATION.BASE_ID.DRUID] = {param = CONDITION_PARAM_STAT_MAGICPOINTS, bonus = 1}, [VOCATION.BASE_ID.PALADIN] = {param = CONDITION_PARAM_SKILL_DISTANCE, bonus = 1}, [VOCATION.BASE_ID.KNIGHT] = {param = CONDITION_PARAM_SKILL_MELEE, bonus = 1}}},
	HOLY_AND_DEATH_RESIST = {type = CONDITION_SPECIALATTRIBUTES, params = {{param = CONDITION_PARAM_ABSORB_HOLYPERCENT, bonus = 1}, {param = CONDITION_PARAM_ABSORB_DEATHPERCENT, bonus = 1}}},
	EARTH_RESIST = {type = CONDITION_SPECIALATTRIBUTES, params = {{param = CONDITION_PARAM_ABSORB_EARTHPERCENT, bonus = 2}}},
	FIRE_RESIST = {type = CONDITION_SPECIALATTRIBUTES, params = {{param = CONDITION_PARAM_ABSORB_FIREPERCENT, bonus = 2}}},
	ENERGY_RESIST = {type = CONDITION_SPECIALATTRIBUTES, params = {{param = CONDITION_PARAM_ABSORB_ENERGYPERCENT, bonus = 2}}},
}

WheelOfDestiny.Perks = {
	[1] = {dedicationBonus = WheelOfDestiny.Dedication.HP_AND_MANA, side = WheelOfDestiny.Sides.TOP_LEFT, perkLevel = WheelOfDestiny.Perks_Level.TOP, requisites = {7, 2}}, -- top top left
	[2] = {dedicationBonus = WheelOfDestiny.Dedication.DAMAGE_MITIGATION, convictionBonus = WheelOfDestiny.Conviction.ICE_RESIST, side = WheelOfDestiny.Sides.TOP_LEFT, perkLevel = WheelOfDestiny.Perks_Level.MIDDLE_TOP, requisites = {7, 8, 3}}, -- middle-top top left right
	[3] = {dedicationBonus = WheelOfDestiny.Dedication.HP, convictionBonus = WheelOfDestiny.Conviction.LIFE_LEECH, side = WheelOfDestiny.Sides.TOP_LEFT, perkLevel = WheelOfDestiny.Perks_Level.MIDDLE, requisites = {2, 8, 9, 4}}, -- middle top left right
	[4] = {dedicationBonus = WheelOfDestiny.Dedication.MANA, convictionBonus = WheelOfDestiny.Conviction.SKILL, side = WheelOfDestiny.Sides.TOP_RIGHT, perkLevel = WheelOfDestiny.Perks_Level.MIDDLE, requisites = {3, 10, 11, 5}}, -- middle top right left
	[5] = {dedicationBonus = WheelOfDestiny.Dedication.HP, convictionBonus = WheelOfDestiny.Conviction.MANA_LEECH, side = WheelOfDestiny.Sides.TOP_RIGHT, perkLevel = WheelOfDestiny.Perks_Level.MIDDLE_TOP, requisites = {4, 11, 12}}, -- middle-top top right left
	[6] = {dedicationBonus = WheelOfDestiny.Dedication.HP_AND_MANA, side = WheelOfDestiny.Sides.TOP_RIGHT, perkLevel = WheelOfDestiny.Perks_Level.TOP, requisites = {5, 12}}, -- top top right
	[7] = {dedicationBonus = WheelOfDestiny.Dedication.DAMAGE_MITIGATION, convictionBonus = WheelOfDestiny.Conviction.MANA_LEECH, side = WheelOfDestiny.Sides.TOP_LEFT, perkLevel = WheelOfDestiny.Perks_Level.MIDDLE_TOP, requisites = {2, 13, 8}}, -- middle-top top left left
	[8] = {dedicationBonus = WheelOfDestiny.Dedication.HP, side = WheelOfDestiny.Sides.TOP_LEFT, perkLevel = WheelOfDestiny.Perks_Level.MIDDLE, requisites = {14, 9, 3, 13}}, -- middle top left middle
	[9] = {dedicationBonus = WheelOfDestiny.Dedication.MANA, convictionBonus = WheelOfDestiny.Conviction.HOLY_AND_DEATH_RESIST, side = WheelOfDestiny.Sides.TOP_LEFT, perkLevel = WheelOfDestiny.Perks_Level.MIDDLE_BOTTOM, requisites = {15, 14, 10, 3, 8}}, -- middle-bottom top left right
	[10] = {dedicationBonus = WheelOfDestiny.Dedication.CAPACITY, convictionBonus = WheelOfDestiny.Conviction.ENERGY_RESIST, side = WheelOfDestiny.Sides.TOP_RIGHT, perkLevel = WheelOfDestiny.Perks_Level.MIDDLE_BOTTOM, requisites = {16, 4, 11, 17, 9}}, -- middle-bottom top right left
	[11] = {dedicationBonus = WheelOfDestiny.Dedication.MANA, side = WheelOfDestiny.Sides.TOP_RIGHT, perkLevel = WheelOfDestiny.Perks_Level.MIDDLE, requisites = {10, 17, 4, 18}}, -- middle top right middle
	[12] = {dedicationBonus = WheelOfDestiny.Dedication.HP, convictionBonus = WheelOfDestiny.Conviction.HOLY_AND_DEATH_RESIST, side = WheelOfDestiny.Sides.TOP_RIGHT, perkLevel = WheelOfDestiny.Perks_Level.MIDDLE_TOP, requisites = {11, 18, 5}}, -- middle-top top right right
	[13] = {dedicationBonus = WheelOfDestiny.Dedication.HP, side = WheelOfDestiny.Sides.TOP_LEFT, perkLevel = WheelOfDestiny.Perks_Level.MIDDLE, requisites = {7, 8, 14, 19}}, -- middle top left left
	[14] = {dedicationBonus = WheelOfDestiny.Dedication.MANA, convictionBonus = WheelOfDestiny.Conviction.SKILL, side = WheelOfDestiny.Sides.TOP_LEFT, perkLevel = WheelOfDestiny.Perks_Level.MIDDLE_BOTTOM, requisites = {8, 9, 13, 15, 20}}, -- middle-bottom top left left
	[15] = {dedicationBonus = WheelOfDestiny.Dedication.CAPACITY, convictionBonus = WheelOfDestiny.Conviction.EARTH_RESIST, side = WheelOfDestiny.Sides.TOP_LEFT, perkLevel = WheelOfDestiny.Perks_Level.BOTTOM}, -- bottom top left
	[16] = {dedicationBonus = WheelOfDestiny.Dedication.DAMAGE_MITIGATION, side = WheelOfDestiny.Sides.TOP_RIGHT, perkLevel = WheelOfDestiny.Perks_Level.BOTTOM}, -- bottom top right
	[17] = {dedicationBonus = WheelOfDestiny.Dedication.CAPACITY, convictionBonus = WheelOfDestiny.Conviction.LIFE_LEECH, side = WheelOfDestiny.Sides.TOP_RIGHT, perkLevel = WheelOfDestiny.Perks_Level.MIDDLE_BOTTOM, requisites = {16, 10, 11, 18, 23}}, -- middle-bottom top right right
	[18] = {dedicationBonus = WheelOfDestiny.Dedication.MANA, convictionBonus = WheelOfDestiny.Conviction.FIRE_RESIST, side = WheelOfDestiny.Sides.TOP_RIGHT, perkLevel = WheelOfDestiny.Perks_Level.MIDDLE, requisites = {17, 11, 12, 24}}, -- middle top right right
	[19] = {dedicationBonus = WheelOfDestiny.Dedication.DAMAGE_MITIGATION, convictionBonus = WheelOfDestiny.Conviction.ENERGY_RESIST, side = WheelOfDestiny.Sides.BOTTOM_LEFT, perkLevel = WheelOfDestiny.Perks_Level.MIDDLE, requisites = {13, 20, 26, 25}}, -- middle bottom left left
	[20] = {dedicationBonus = WheelOfDestiny.Dedication.HP, convictionBonus = WheelOfDestiny.Conviction.MANA_LEECH, side = WheelOfDestiny.Sides.BOTTOM_LEFT, perkLevel = WheelOfDestiny.Perks_Level.MIDDLE_BOTTOM, requisites = {21, 27, 26, 19, 14}}, -- middle-bottom bottom left left
	[21] = {dedicationBonus = WheelOfDestiny.Dedication.MANA, side = WheelOfDestiny.Sides.BOTTOM_LEFT, perkLevel = WheelOfDestiny.Perks_Level.BOTTOM}, -- bottom bottom left
	[22] = {dedicationBonus = WheelOfDestiny.Dedication.HP, convictionBonus = WheelOfDestiny.Conviction.ICE_RESIST, side = WheelOfDestiny.Sides.BOTTOM_RIGHT, perkLevel = WheelOfDestiny.Perks_Level.BOTTOM}, -- bottom bottom right
	[23] = {dedicationBonus = WheelOfDestiny.Dedication.DAMAGE_MITIGATION, convictionBonus = WheelOfDestiny.Conviction.SKILL, side = WheelOfDestiny.Sides.BOTTOM_RIGHT, perkLevel = WheelOfDestiny.Perks_Level.MIDDLE_BOTTOM, requisites = {22, 17, 24, 29, 28}}, -- middle-bottom bottom right right
	[24] = {dedicationBonus = WheelOfDestiny.Dedication.CAPACITY, side = WheelOfDestiny.Sides.BOTTOM_RIGHT, perkLevel = WheelOfDestiny.Perks_Level.MIDDLE, requisites = {23, 18, 30, 29}}, -- middle bottom right right
	[25] = {dedicationBonus = WheelOfDestiny.Dedication.CAPACITY, convictionBonus = WheelOfDestiny.Conviction.HOLY_AND_DEATH_RESIST, side = WheelOfDestiny.Sides.BOTTOM_LEFT, perkLevel = WheelOfDestiny.Perks_Level.MIDDLE_TOP, requisites = {19, 26, 32}}, -- middle-top bottom left left
	[26] = {dedicationBonus = WheelOfDestiny.Dedication.DAMAGE_MITIGATION, side = WheelOfDestiny.Sides.BOTTOM_LEFT, perkLevel = WheelOfDestiny.Perks_Level.MIDDLE, requisites = {20, 27, 19, 33}}, -- middle bottom left middle
	[27] = {dedicationBonus = WheelOfDestiny.Dedication.HP, convictionBonus = WheelOfDestiny.Conviction.FIRE_RESIST, side = WheelOfDestiny.Sides.BOTTOM_LEFT, perkLevel = WheelOfDestiny.Perks_Level.MIDDLE_BOTTOM, requisites = {21, 28, 33, 26, 20}}, -- middle-bottom bottom left right
	[28] = {dedicationBonus = WheelOfDestiny.Dedication.DAMAGE_MITIGATION, convictionBonus = WheelOfDestiny.Conviction.HOLY_AND_DEATH_RESIST, side = WheelOfDestiny.Sides.BOTTOM_RIGHT, perkLevel = WheelOfDestiny.Perks_Level.MIDDLE_BOTTOM, requisites = {22, 23, 29, 34, 27}}, -- middle-bottom bottom right left
	[29] = {dedicationBonus = WheelOfDestiny.Dedication.CAPACITY, side = WheelOfDestiny.Sides.BOTTOM_RIGHT, perkLevel = WheelOfDestiny.Perks_Level.MIDDLE, requisites = {28, 23, 24, 34}}, -- middle bottom right middle
	[30] = {dedicationBonus = WheelOfDestiny.Dedication.MANA, convictionBonus = WheelOfDestiny.Conviction.LIFE_LEECH, side = WheelOfDestiny.Sides.BOTTOM_RIGHT, perkLevel = WheelOfDestiny.Perks_Level.MIDDLE_TOP, requisites = {29, 24, 35}}, -- middle-top bottom right right
	[31] = {dedicationBonus = WheelOfDestiny.Dedication.HP_AND_MANA, side = WheelOfDestiny.Sides.BOTTOM_LEFT, perkLevel = WheelOfDestiny.Perks_Level.TOP, requisites = {25, 32}}, -- top bottom left
	[32] = {dedicationBonus = WheelOfDestiny.Dedication.CAPACITY, convictionBonus = WheelOfDestiny.Conviction.LIFE_LEECH, side = WheelOfDestiny.Sides.BOTTOM_LEFT, perkLevel = WheelOfDestiny.Perks_Level.MIDDLE_TOP, requisites = {26, 33, 25}}, -- middle-top bottom left right
	[33] = {dedicationBonus = WheelOfDestiny.Dedication.DAMAGE_MITIGATION, convictionBonus = WheelOfDestiny.Conviction.SKILL, side = WheelOfDestiny.Sides.BOTTOM_LEFT, perkLevel = WheelOfDestiny.Perks_Level.MIDDLE, requisites = {27, 34, 32, 26}}, -- middle bottom left right
	[34] = {dedicationBonus = WheelOfDestiny.Dedication.CAPACITY, convictionBonus = WheelOfDestiny.Conviction.MANA_LEECH, side = WheelOfDestiny.Sides.BOTTOM_RIGHT, perkLevel = WheelOfDestiny.Perks_Level.MIDDLE, requisites = {28, 29, 35, 33}}, -- middle bottom right left
	[35] = {dedicationBonus = WheelOfDestiny.Dedication.MANA, convictionBonus = WheelOfDestiny.Conviction.EARTH_RESIST, side = WheelOfDestiny.Sides.BOTTOM_RIGHT, perkLevel = WheelOfDestiny.Perks_Level.MIDDLE_TOP, requisites = {34, 29, 30}}, -- middle-top bottom right left
	[36] = {dedicationBonus = WheelOfDestiny.Dedication.HP_AND_MANA, side = WheelOfDestiny.Sides.BOTTOM_RIGHT, perkLevel = WheelOfDestiny.Perks_Level.TOP, requisites = {35, 30}}, -- top bottom right
}

function Player.getWheelOfDestinyPerksFlag(player, data)
	if not data or not data.Perks then return 0 end
	local flag = 0
	for _, perk in pairs(data.Perks) do
		if player:getWheelOfDestinyPerk(perk) == WheelOfDestiny.Perks[perk].perkLevel then
			flag = flag + 1
		end
	end
	return flag
end

function getRevelationLevelByPoints(points)
	local highestLevel = false
	for key, value in pairs(WheelOfDestiny.RevelationLevels) do
		if (not highestLevel or (highestLevel and WheelOfDestiny.RevelationLevels[highestLevel] < value)) and points >= value then
			highestLevel = key
		end
	end
	return highestLevel
end

function Player.getWheelOfDestinyRevelationLevel(player, side)
	return getRevelationLevelByPoints(player:getWheelOfDestinyPerk(side))
end
	

function Player.updateWheelOfDestinyBuffs(player, wheel)
	local attributesData = {
		needCondition = false,
		data = {}
	}
	local specialAttributesData = {
		needCondition = false,
		data = {}
	}
	for _, data in pairs(WheelOfDestiny.Revelation) do
		if data.EVENT then
			player:unregisterEvent(data.EVENT)
		end
		if data.SPELL then
			player:forgetSpell(data.SPELL)
		end
	end
	for i = 1, 36 do
		if wheel[i] > 0 then
			local function updateTable(info, dedication)
				local toModify
				if info.type == CONDITION_ATTRIBUTES then
					toModify = attributesData.data
				else
					toModify = specialAttributesData.data
				end
				local function examineData(tData)
					if toModify[tData.param] == nil then
						toModify[tData.param] = 0
					end
					local eData
					
					if dedication then
						toModify[tData.param] = toModify[tData.param] + tData.bonus[player:getVocation():getBaseId()] * wheel[i]
					else
						toModify[tData.param] = toModify[tData.param] + tData.bonus
					end
				end
				if info.vocations then
					for voc, tInfo in pairs(info.vocations) do
						if player:getVocation():getBaseId() == voc then
							examineData(tInfo)
						end
					end
				elseif info.params then
					for _, tInfo in pairs(info.params) do
						examineData(tInfo)
					end
				end
			end
			updateTable(WheelOfDestiny.Perks[i].dedicationBonus, true)
			attributesData.needCondition = true
			if wheel[i] == WheelOfDestiny.Perks[i].perkLevel and WheelOfDestiny.Perks[i].convictionBonus then
				updateTable(WheelOfDestiny.Perks[i].convictionBonus, false)
				specialAttributesData.needCondition = true
			end
		end
	end
	player:removeCondition(CONDITION_ATTRIBUTES, CONDITIONID_COMBAT, 1068)
	player:removeCondition(CONDITION_SPECIALATTRIBUTES, CONDITIONID_COMBAT, 1068)
	local totalHealing = 0
	local totalDamage = 0
	for id, data in pairs(WheelOfDestiny.Sides) do
		local level = getRevelationLevelByPoints(wheel[data])
		if level then
			totalHealing = totalHealing + WheelOfDestiny.RevelationBonus[level].bonusHealing
			totalDamage = totalDamage + WheelOfDestiny.RevelationBonus[level].bonusDamage
		end
	end
	
	
	if totalDamage > 0 or totalHealing > 0 then
		attributesData.data[CONDITION_PARAM_STAT_EXTRADAMAGE] = totalDamage
		attributesData.data[CONDITION_PARAM_STAT_EXTRAHEALING] = totalHealing
		attributesData.needCondition = true
	end
			
	if attributesData.needCondition then
		local condition = Condition(CONDITION_ATTRIBUTES)
		condition:setParameter(CONDITION_PARAM_SUBID, 1068)
		--condition:setParameter(CONDITION_PARAM_PERSISTENT_ON_DEATH, true)
		for key, value in pairs(attributesData.data) do
			condition:setParameter(key, value)
		end
		condition:setParameter(CONDITION_PARAM_TICKS, -1)
		condition:setParameter(CONDITION_PARAM_FORCEUPDATE, true)
		player:addCondition(condition)
	end
	if specialAttributesData.needCondition then
		local condition = Condition(CONDITION_SPECIALATTRIBUTES)
		condition:setParameter(CONDITION_PARAM_SUBID, 1068)
		--condition:setParameter(CONDITION_PARAM_PERSISTENT_ON_DEATH, true)
		for key, value in pairs(specialAttributesData.data) do
			condition:setParameter(key, value)
		end
		condition:setParameter(CONDITION_PARAM_TICKS, -1)
		condition:setParameter(CONDITION_PARAM_FORCEUPDATE, true)
		player:addCondition(condition)
	end
	for key, data in pairs(WheelOfDestiny.Revelation) do
		if wheel[data.SIDE] and wheel[data.SIDE] > 0 then
			if not data.VOCATION or player:getVocation():getBaseId() == data.VOCATION then
				local level = getRevelationLevelByPoints(wheel[data.SIDE])
				if level then
					if data.EVENT then
						player:registerEvent(data.EVENT)
					end
					if data.SPELL then
						player:learnSpell(data.SPELL)
					end
				end
			end
		end
	end
end

function onRecvbyte(player, msg, byte)
	if byte == WheelOfDestiny.Client_Packets.OpenWheel then
		player:parseOpenWheelOfDestiny(msg)
	elseif byte == WheelOfDestiny.Client_Packets.ModifyWheel then
		player:parseModifyWheel(msg)
	end
end

function Player.parseModifyWheel(player, msg)
	local totalPoints = 0
	local newWheel = {}
	for i=1, 36 do
		newWheel[i] = msg:getU16()
		if newWheel[i] > WheelOfDestiny.Perks[i].perkLevel then
			return
		end
		totalPoints = totalPoints + newWheel[i]
	end
	if totalPoints > player:getLevel()-50 then
		return
	end
	local sides = {
		[WheelOfDestiny.Sides.TOP_LEFT] = 0,
		[WheelOfDestiny.Sides.TOP_RIGHT] = 0,
		[WheelOfDestiny.Sides.BOTTOM_RIGHT] = 0,
		[WheelOfDestiny.Sides.BOTTOM_LEFT] = 0,
	}
	for i=1, 36 do
		if newWheel[i] > 0 then
			local data = WheelOfDestiny.Perks[i]
			if data.requisites then
				local atLeastOne = false
				for _, d in pairs(data.requisites) do
					if newWheel[d] >= WheelOfDestiny.Perks[d].perkLevel then
						atLeastOne = true
					end
				end
				if atLeastOne == false then
					return
				end
			end
			sides[data.side] = sides[data.side] + newWheel[i]
		end
	end
	for i=1, 36 do
		player:setWheelOfDestinyPerk(i, newWheel[i])
	end
	newWheel[WheelOfDestiny.Sides.TOP_LEFT] = sides[WheelOfDestiny.Sides.TOP_LEFT]
	player:setWheelOfDestinyPerk(WheelOfDestiny.Sides.TOP_LEFT, sides[WheelOfDestiny.Sides.TOP_LEFT])
	newWheel[WheelOfDestiny.Sides.TOP_RIGHT] = sides[WheelOfDestiny.Sides.TOP_RIGHT]
	player:setWheelOfDestinyPerk(WheelOfDestiny.Sides.TOP_RIGHT, sides[WheelOfDestiny.Sides.TOP_RIGHT])
	newWheel[WheelOfDestiny.Sides.BOTTOM_RIGHT] = sides[WheelOfDestiny.Sides.BOTTOM_RIGHT]
	player:setWheelOfDestinyPerk(WheelOfDestiny.Sides.BOTTOM_RIGHT, sides[WheelOfDestiny.Sides.BOTTOM_RIGHT])
	newWheel[WheelOfDestiny.Sides.BOTTOM_LEFT] = sides[WheelOfDestiny.Sides.BOTTOM_LEFT]
	player:setWheelOfDestinyPerk(WheelOfDestiny.Sides.BOTTOM_LEFT, sides[WheelOfDestiny.Sides.BOTTOM_LEFT])
	player:updateWheelOfDestinyBuffs(newWheel)
end

function Player.openWheel(player)
	local msg = NetworkMessage()
	msg:addByte(WheelOfDestiny.Server_Packets.SendWheel)
	msg:addU32(player:getId())
	msg:addByte(1)
	local result = 0
	local tile = player:getTile()
	if tile and tile:hasFlag(TILESTATE_PROTECTIONZONE) then
		-- if player:getPosition():isInArea(Position(32357, 32230, 6), Position(32381, 32249, 7)) then
			
		-- else
			-- result = 2
		-- end
		result = 1
	end
	msg:addByte(result)
	msg:addByte(Vocation(player:getVocation():getBaseId()):getClientId())
	msg:addU16(player:getLevel() - 50)
	local wheel = player:getWheelOfDestiny()
	for id = 1, 36 do
		msg:addU16(wheel[id])
	end
	msg:sendToPlayer(player)
end

function Player.parseOpenWheelOfDestiny(player, msg)
	local playerId = msg:getU32()
	player:openWheel()
end