local mType = Game.createMonsterType("Ropen")
local monster = {}

monster.description = "a ropen"
monster.experience = 1
monster.outfit = {
	lookType = 307,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 509

monster.health = 6500
monster.maxHealth = 6500
monster.race = "blood"
monster.corpse = 9829
monster.speed = 486
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
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 300,
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
	{text = "Shriiiiiek", yell = false}
}

monster.loot = {
	{name = "black pearl", chance = 720, maxCount = 3},
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = -440, maxDamage = -468, condition = {type = CONDITION_POISON, totalDamage = 120, interval = 4000}},
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_EARTHDAMAGE, minDamage = -470, maxDamage = -480, range = 7, shootEffect = CONST_ANI_POISON, target = true},
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_DROWNDAMAGE, minDamage = -430, maxDamage = -490, radius = 6, effect = CONST_ME_SOUND_WHITE, target = true},
	{name ="mutated bat curse", interval = 2000, chance = 10, target = false},
	-- poison
	{name ="condition", type = CONDITION_POISON, interval = 2000, chance = 15, minDamage = -490, maxDamage = -540, length = 4, spread = 3, effect = CONST_ME_POISONAREA, target = true}
}

monster.defenses = {
	defense = 20,
	armor = 20,
	{name ="combat", interval = 2000, chance = 10, type = COMBAT_HEALING, minDamage = 480, maxDamage = 495, effect = CONST_ME_MAGIC_BLUE, target = true}
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
	{type = "paralyze", condition = false},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)
