local mType = Game.createMonsterType("Sir Valorcrest")
local monster = {}

monster.description = "Sir Valorcrest"
monster.experience = 10000
monster.outfit = {
	lookType = 287,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.health = 26000
monster.maxHealth = 26000
monster.race = "undead"
monster.corpse = 8109
monster.speed = 470
monster.manaCost = 0

monster.changeTarget = {
	interval = 5000,
	chance = 30
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
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = false
}

monster.light = {
	level = 0,
	color = 0
}


monster.voices = {
	interval = 5000,
	chance = 10,
	{text = "I challenge you!", yell = false},
	{text = "A battle makes the blood so hot and sweet.", yell = false}
}

monster.loot = {
	{id = 7427, chance = 250}, -- chaos mace
	{id = 8192, chance = 100000}, -- vampire lord token
	{id = 3434, chance = 6300}, -- vampire shield
	{id = 3043, chance = 81000, maxCount = 10},
	{id = 29345, chance = 72000, minCount = 3, maxCount = 7}, --- weapons
	{id = 29347, chance = 45000, minCount = 3, maxCount = 7}, --- armors
	{id = 29346, chance = 36000, minCount = 3, maxCount = 7}, --- jewelry
    --{id = 37606, chance = 27000, minCount = 3, maxCount = 5} --- zakaria coin
}


monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, skill = 70, attack = 545},
	{name ="combat", interval = 1000, chance = 52, type = COMBAT_DEATHDAMAGE, minDamage = 1800, maxDamage = -1900, radius = 8, shootEffect = CONST_ANI_SUDDENDEATH, effect = CONST_ME_MORTAREA, target = true}
}

monster.defenses = {
	defense = 35,
	armor = 38,
	{name ="combat", interval = 1000, chance = 12, type = COMBAT_HEALING, minDamage = 1000, maxDamage = 2350, effect = CONST_ME_MAGIC_BLUE, target = false},
	{name ="invisible", interval = 3000, chance = 25, effect = CONST_ME_MAGIC_BLUE}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 20},
	{type = COMBAT_ENERGYDAMAGE, percent = 20},
	{type = COMBAT_EARTHDAMAGE, percent = 20},
	{type = COMBAT_FIREDAMAGE, percent = 20},
	{type = COMBAT_LIFEDRAIN, percent = 20},
	{type = COMBAT_MANADRAIN, percent = 20},
	{type = COMBAT_DROWNDAMAGE, percent = 20},
	{type = COMBAT_ICEDAMAGE, percent = 20},
	{type = COMBAT_HOLYDAMAGE , percent = 20},
	{type = COMBAT_DEATHDAMAGE , percent = 20}
}

monster.immunities = {
	{type = "paralyze", condition = false},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)
