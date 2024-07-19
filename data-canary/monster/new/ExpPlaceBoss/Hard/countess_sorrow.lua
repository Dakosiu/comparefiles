local mType = Game.createMonsterType("Countess Sorrow")
local monster = {}

monster.description = "Countess Sorrow"
monster.experience = 130000
monster.outfit = {
	lookType = 241,
	lookHead = 20,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.health = 65000
monster.maxHealth = 65000
monster.race = "undead"
monster.corpse = 6344
monster.speed = 600
monster.manaCost = 0
monster.maxSummons = 3

monster.changeTarget = {
	interval = 60000,
	chance = 35
}

monster.strategiesTarget = {
	nearest = 70,
	health = 10,
	damage = 10,
	random = 10,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = false,
	illusionable = true,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 540,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
	pet = false
}

monster.light = {
	level = 0,
	color = 0
}

monster.summons = {
	{name = "Phantasm", chance = 7, interval = 2000, max = 3},
	{name = "Phantasm summon", chance = 7, interval = 2000, max = 3}
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{text = "I'm so sorry ... for youuu!", yell = false},
	{text = "You won't rest in peace! Never ever!", yell = false},
	{text = "Sleep ... for eternity!", yell = false},
	{text = "Dreams can come true. As my dream of killing you.", yell = false}
}

monster.loot = {
	{id = 6536, chance = 100000}, -- countess sorrow's frozen tear
	{id = 6499, chance = 20590}, -- demonic essence
	{id = 5944, chance = 85290}, -- soul orb
	{id = 3567, chance = 32350}, -- blue robe
	{id = 3312, chance = 4210}, -- silver mace
	{id = 3557, chance = 8820}, -- plate legs
	{id = 3084, chance = 23530}, -- protection amulet
	{id = 3049, chance = 5880}, -- stealth ring
	{id = 3043, chance = 81000, maxCount = 20 },
	{id = 33983, chance = 72000, minCount = 5, maxCount = 12}, --- weapons
	{id = 33985, chance = 45000, minCount = 5, maxCount = 12}, --- armors
	{id = 33984, chance = 36000, minCount = 5, maxCount = 12}, --- jewelry
    --{id = 37606, chance = 27000, minCount = 4, maxCount = 6} --- zakaria coin
}


monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, skill = 156, attack = 400, condition = {type = CONDITION_POISON, totalDamage = 920, interval = 4000}},
	{name ="combat", interval = 2000, chance = 20, type = COMBAT_LIFEDRAIN, minDamage = -1420, maxDamage = -3380, range = 7, radius = 1, shootEffect = CONST_ANI_POISON, effect = CONST_ME_HITBYPOISON, target = true},
	{name ="combat", interval = 2000, chance = 22, type = COMBAT_MANADRAIN, minDamage = -1145, maxDamage = -1551, radius = 3, effect = CONST_ME_YELLOW_RINGS, target = true},
	{name ="phantasm drown", interval = 2000, chance = 20, target = true},
	{name ="drunk", interval = 2000, chance = 15, range = 7, radius = 6, effect = CONST_ME_MAGIC_RED, target = false, duration = 10000}
}

monster.defenses = {
	defense = 20,
	armor = 25,
	{name ="combat", interval = 2000, chance = 26, type = COMBAT_HEALING, minDamage = 1415, maxDamage = -2625, effect = CONST_ME_MAGIC_BLUE, target = false},
	{name ="invisible", interval = 2000, chance = 15, effect = CONST_ME_POFF},
	{name ="speed", interval = 2000, chance = 11, speedChange = 736, effect = CONST_ME_MAGIC_RED, target = false, duration = 6000}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 30},
	{type = COMBAT_ENERGYDAMAGE, percent = 30},
	{type = COMBAT_EARTHDAMAGE, percent = 30},
	{type = COMBAT_FIREDAMAGE, percent = 30},
	{type = COMBAT_LIFEDRAIN, percent = 30},
	{type = COMBAT_MANADRAIN, percent = 30},
	{type = COMBAT_DROWNDAMAGE, percent = 30},
	{type = COMBAT_ICEDAMAGE, percent = 30},
	{type = COMBAT_HOLYDAMAGE , percent = 30},
	{type = COMBAT_DEATHDAMAGE , percent = 30}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = true},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType.onThink = function(monster, interval)
	expPlaceBoss.onThink(monster.uid)
end

mType.onDisappear = function(monster, creature)
	expPlaceBoss.onDisappear(monster.uid)
end

mType:register(monster)
