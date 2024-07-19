local mType = Game.createMonsterType("Mr. Punish")
local monster = {}

monster.description = "Mr. Punish"
monster.experience = 180000
monster.outfit = {
	lookType = 234,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.health = 45000
monster.maxHealth = 45000
monster.race = "undead"
monster.corpse = 6330
monster.speed = 470
monster.manaCost = 0
monster.maxSummons = 0

monster.changeTarget = {
	interval = 2000,
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
	illusionable = false,
	canPushItems = true,
	canPushCreatures = false,
	staticAttackChance = 50,
	targetDistance = 1,
	runHealth = 2000,
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
	{text = "I kept my axe sharp, especially for you!", yell = false},
	{text = "Time for a little torturing practice!", yell = false},
	{text = "Scream for me!", yell = false}
}

monster.loot = {
	{id = 6537, chance = 100000}, -- mr. punish's handcuffs
	{id = 3043, chance = 81000, maxCount = 20 },
	{id = 33983, chance = 72000, minCount = 5, maxCount = 12}, --- weapons
	{id = 33985, chance = 45000, minCount = 5, maxCount = 12}, --- armors
	{id = 33984, chance = 36000, minCount = 5, maxCount = 12}, --- jewelry
    --{id = 37606, chance = 27000, minCount = 4, maxCount = 6} --- zakaria coin
}


monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = -660, maxDamage = -1280},
	{name ="combat", interval = 2000, chance = 55, type = COMBAT_PHYSICALDAMAGE, minDamage = 550, maxDamage = -1500, radius = 8, effect = CONST_ME_HITAREA, target = false},
}

monster.defenses = {
	defense = 72,
	armor = 64,
	{name ="combat", interval = 1000, chance = 9, type = COMBAT_HEALING, minDamage = 1500, maxDamage = 2500, effect = CONST_ME_MAGIC_BLUE, target = false},
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
