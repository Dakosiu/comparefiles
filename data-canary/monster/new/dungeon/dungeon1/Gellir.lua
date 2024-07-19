local mType = Game.createMonsterType("gellir")
local monster = {}

monster.description = "a gellir"
monster.experience = 8000
monster.outfit = {
	lookType = 1316,
	lookHead = 115,
	lookBody = 76,
	lookLegs = 97,
	lookFeet = 97,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 1974


monster.health = 4500
monster.maxHealth = 4500
monster.race = "blood"
monster.corpse = 34184
monster.speed = 150
monster.summonCost = 0
monster.maxSummons = 0

monster.faction = FACTION_LIONUSURPERS
monster.enemyFactions = {FACTION_LION, FACTION_PLAYER}

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
	staticAttackChance = 70,
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
}

monster.loot = {
    {id = 7642, chance = 14400, minCount = 10, maxCount = 30},
	{id = 23374, chance = 14400, minCount = 10, maxCount = 30},
	{id = 23374, chance = 14400, minCount = 10, maxCount = 30},
	{id = 238, chance = 14400, minCount = 10, maxCount = 30},
	{id = 23373, chance = 14400, minCount = 10, maxCount = 30},
	{id = 7643, chance = 14400, minCount = 10, maxCount = 30},
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 100, maxDamage = -250, effect = CONST_ME_DRAWBLOOD},
	{name ="singledeathchain", interval = 3000, chance = 55, minDamage = -250, maxDamage = -530, range = 5, effect = CONST_ME_MORTAREA, target = true},
	{name ="singleicechain", interval = 2000, chance = 50, minDamage = -150, maxDamage = -450, range = 5, effect = CONST_ME_ICEATTACK, target = true},
	{name ="combat", interval = 2000, chance = 120, type = COMBAT_ICEDAMAGE, minDamage = -200, maxDamage = -450, radius = 4, shootEffect = CONST_ANI_ICE, effect = CONST_ME_ICEATTACK, target = true} -- avalanche
}

monster.defenses = {
	defense = 50,
	armor = 82
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
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)
