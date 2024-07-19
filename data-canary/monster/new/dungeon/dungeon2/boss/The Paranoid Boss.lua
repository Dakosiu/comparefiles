local mType = Game.createMonsterType("The Paranoid Boss")
local monster = {}

monster.description = "a the Paranoid boss"
monster.experience = 65000
monster.outfit = {
	lookType = 1277,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 21

monster.health = 50000
monster.maxHealth = 50000
monster.race = "blood"
monster.corpse = 32741
monster.speed = 134
monster.manaCost = 200

monster.changeTarget = {
	interval = 4000,
	chance = 0
}

monster.strategiesTarget = {
	nearest = 100,
}

monster.flags = {
	summonable = true,
	attackable = true,
	hostile = true,
	convinceable = true,
	pushable = true,
	rewardBoss = true,
	illusionable = true,
	canPushItems = false,
	canPushCreatures = false,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 5,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = false,
	pet = false
}

monster.light = {
	level = 0,
	color = 0
}

monster.summon = {
	maxSummons = 2,
	summons = {
		{name = "Time Keeper", chance = 100, interval = 10000, count = 2}
	}
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{text = "Meep!", yell = false}
}

monster.loot = {
	{name = "zakaria stone", chance = 100000, minCount = 4, maxCount = 11},
    {id = 27846, chance = 1400, maxCount = 1},
    {id = 21947, chance = 2100, maxCount = 1},
    {id = 21804, chance = 2400, maxCount = 1},
	{id = 21805, chance = 1400, maxCount = 1},
	{id = 36724, chance = 2400, maxCount = 1},
	{id = 36726, chance = 2400, maxCount = 1},
	{id = 36728, chance = 2400, maxCount = 1},
	{id = 23488, chance = 2400, maxCount = 1},
	{id = 32226, chance = 14400, maxCount = 1},
	{id = 42368, chance = 3400, maxCount = 1},
	{id = 3048, chance = 25400, maxCount = 1},
	{id = 3081, chance = 15400, maxCount = 1},
	{id = 651, chance = 15400, maxCount = 1},
	{id = 36724, chance = 2400, maxCount = 1},
	{name = "berserk potion", chance = 17988, maxCount = 3},
	{name = "mastermind potion", chance = 17771, maxCount = 3},
	{name = "crystal coin", chance = 35241, minCount = 25, maxCount = 40}
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 600, maxDamage = -1050, condition = { type = CONDITION_POISON, totalDamage = 4, interval = 4000 } },
	{ name = "combat", interval = 2000, chance = 100, type = COMBAT_LIFEDRAIN, minDamage = -900, maxDamage = -1400, effect = CONST_ME_MAGIC_RED, target = true },
	{ name = "combat", interval = 1000, chance = 40, type = COMBAT_PHYSICALDAMAGE, minDamage = -1000, maxDamage = -1750, radius = 2, shootEffect = CONST_ANI_SMALLEARTH, target = false },
	{ name = "drunk", interval = 1000, chance = 70, range = 7, shootEffect = CONST_ANI_ENERGY, effect = CONST_ME_ENERGYAREA, target = false },
	{ name = "strength", interval = 1000, chance = 60, range = 7, shootEffect = CONST_ANI_LARGEROCK, effect = CONST_ME_ENERGYAREA, target = false },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_ENERGYDAMAGE, minDamage = 0, maxDamage = -900, length = 5, spread = 3, effect = CONST_ME_ENERGYHIT, target = false },
	{ name = "combat", interval = 1000, chance = 34, type = COMBAT_FIREDAMAGE, minDamage = -600, maxDamage = -1200, range = 7, radius = 7, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREAREA, target = true },
	{ name = "speed", interval = 3000, chance = 40, speedChange = -700, effect = CONST_ME_MAGIC_RED, target = true, duration = 20000 },
}

monster.defenses = {
	defense = 15,
	armor = 10,
	{ name = "the unwelcome bleeding", interval = 3000, chance = 100, target = false},
	{ name = "speed", interval = 10000, chance = 40, speedChange = 510, effect = CONST_ME_MAGIC_GREEN, target = false, duration = 20000 },
	{ name = "combat", interval = 5000, chance = 60, type = COMBAT_HEALING, minDamage = 1000, maxDamage = 2500, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = 0},
	{type = COMBAT_EARTHDAMAGE, percent = 25},
	{type = COMBAT_FIREDAMAGE, percent = 0},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = -10},
	{type = COMBAT_HOLYDAMAGE , percent = 20},
	{type = COMBAT_DEATHDAMAGE , percent = -10}
}

monster.immunities = {
	{type = "paralyze", condition = false},
	{type = "outfit", condition = false},
	{type = "invisible", condition = false},
	{type = "bleed", condition = false}
}

monster.events = {
	"TheUnwelcome"
}

mType:register(monster)