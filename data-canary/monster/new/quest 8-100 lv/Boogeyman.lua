local mType = Game.createMonsterType("Boogeyman")
local monster = {}

monster.description = "a boogeyman"
monster.experience = 1
monster.outfit = {
	lookType = 323,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 521
monster.health = 6500
monster.maxHealth = 6500
monster.race = "blood"
monster.corpse = 9107
monster.speed = 454
monster.manaCost = 0
monster.maxSummons = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10
}

monster.strategiesTarget = {
	nearest = 100,
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
	runHealth = 0,
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
	{text = "Take that creature off my back!! I can feel it!", yell = false},
	{text = "You will regret interrupting my studies!", yell = false},
	{text = "You will be the next infected one... CRAAAHHH!", yell = false},
	{text = "Science... is a curse.", yell = false},
	{text = "Run as fast as you can.", yell = false},
	{text = "Oh by the gods! What is this... aaaaaargh!", yell = false}
}

monster.loot = {
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 330, maxDamage = -660, condition = {type = CONDITION_POISON, totalDamage = 60, interval = 4000}},
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_DEATHDAMAGE, minDamage = -50, maxDamage = -60, length = 3, spread = 1, effect = CONST_ME_POISONAREA, target = false},
	-- poison
	{name ="condition", type = CONDITION_POISON, interval = 2000, chance = 200, minDamage = -590, maxDamage = -680, effect = CONST_ME_HITBYPOISON, target = true},
	{name ="speed", interval = 2000, chance = 10, speedChange = -600, range = 7, effect = CONST_ME_STUN, target = true, duration = 30000}
}

monster.defenses = {
	defense = 15,
	armor = 15,
	{name ="speed", interval = 2000, chance = 15, speedChange = 220, effect = CONST_ME_GREEN_RINGS, target = false, duration = 5000}
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
	{type = COMBAT_HOLYDAMAGE , percent = -5},
	{type = COMBAT_DEATHDAMAGE , percent = 15}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)
