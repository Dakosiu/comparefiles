local mType = Game.createMonsterType("Man In The Cave")
local monster = {}

monster.description = "man in the cave"
monster.experience = 6500
monster.outfit = {
	lookType = 128,
	lookHead = 77,
	lookBody = 59,
	lookLegs = 20,
	lookFeet = 116,
	lookAddons = 1,
	lookMount = 0
}

monster.health = 8000
monster.maxHealth = 8000
monster.race = "blood"
monster.corpse = 18165
monster.speed = 350
monster.manaCost = 0
monster.maxSummons = 0

monster.changeTarget = {
	interval = 5000,
	chance = 20
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
	canPushCreatures = false,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 50,
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


monster.voices = {
	interval = 5000,
	chance = 10,
	{text = "THE MONKS ARE MINE!", yell = true},
	{text = "I will rope you up! All of you!", yell = false},
	{text = "You have been roped up!", yell = false},
	{text = "A MIC to rule them all!", yell = false}
}

monster.loot = {
	{id = 7458, chance = 38000},
	{id = 7386, chance = 30000},
	{id = 7290, chance = 30000, maxCount = 2},
	{id = 7463, chance = 15000},
	{name = "crystal coin", chance = 82920, maxCount = 3},
	{id = 29345, chance = 72000, minCount = 1, maxCount = 3}, --- weapons
	{id = 29347, chance = 45000, minCount = 1, maxCount = 3}, --- armors
	{id = 29346, chance = 36000, minCount = 1, maxCount = 3}, --- jewelry
    --{id = 37606, chance = 27000, minCount = 1, maxCount = 3} --- zakaria coin
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 150, maxDamage = -350},
	{name ="combat", interval = 2000, chance = 45, type = COMBAT_PHYSICALDAMAGE, minDamage = 150, maxDamage = -350, range = 7, shootEffect = CONST_ANI_SMALLSTONE, target = true}
}

monster.defenses = {
	defense = 15,
	armor = 15,
	{name ="speed", interval = 2000, chance = 12, speedChange = 250, effect = CONST_ME_MAGIC_RED, target = false, duration = 4000},
	{name ="combat", interval = 2000, chance = 40, type = COMBAT_HEALING, minDamage = 300, maxDamage = 400, effect = CONST_ME_MAGIC_BLUE, target = true}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 15},
	{type = COMBAT_ENERGYDAMAGE, percent = 15},
	{type = COMBAT_EARTHDAMAGE, percent = 15},
	{type = COMBAT_FIREDAMAGE, percent = 15},
	{type = COMBAT_LIFEDRAIN, percent = 15},
	{type = COMBAT_MANADRAIN, percent = 15},
	{type = COMBAT_DROWNDAMAGE, percent = 15},
	{type = COMBAT_ICEDAMAGE, percent = 15},
	{type = COMBAT_HOLYDAMAGE , percent = 15},
	{type = COMBAT_DEATHDAMAGE , percent = 15}
}

monster.immunities = {
	{type = "paralyze", condition = false},
	{type = "outfit", condition = false},
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
