local mType = Game.createMonsterType("Jarl Bork")
local monster = {}

monster.description = "Jarl Bork"
monster.experience = 35000
monster.outfit = {
	lookType = 1317,
	lookHead = 115,
	lookBody = 76,
	lookLegs = 97,
	lookFeet = 97,
	lookAddons = 3,
	lookMount = 0
}

monster.health = 40000
monster.maxHealth = 40000
monster.race = "blood"
monster.corpse = 0
monster.speed = 760
monster.summonCost = 0
monster.maxSummons = 3

monster.faction = FACTION_LIONUSURPERS
monster.enemyFactions = {FACTION_LION, FACTION_PLAYER}

monster.summons = {
}

monster.changeTarget = {
	interval = 1000,
	chance = 50
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
	rewardBoss = true,
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
	level = 1,
	color = 3
}

monster.voices = {
	interval = 2000,
	chance = 20,
	{text = "You will never beat me", yell = true},
	{text = " I must kill you", yell = true}
}

monster.loot = {
	{name = "zakaria stone", chance = 100000, minCount = 4, maxCount = 11},
    {id = 27846, chance = 2000, maxCount = 1},
    {id = 21947, chance = 1400, maxCount = 1},
    {id = 21812, chance = 2400, maxCount = 1},
	{id = 36724, chance = 2400, maxCount = 1},
	{id = 36726, chance = 2400, maxCount = 1},
	{id = 36728, chance = 2400, maxCount = 1},
	{id = 23488, chance = 2400, maxCount = 1},
	{id = 32226, chance = 14400, maxCount = 1},
	{id = 23488, chance = 3400, maxCount = 1},
	{id = 3048, chance = 25400, maxCount = 1},
	{id = 3081, chance = 15400, maxCount = 1},
	{id = 651, chance = 15400, maxCount = 1},
	{id = 36724, chance = 2400, maxCount = 1},
	{name = "berserk potion", chance = 17988, maxCount = 3},
	{name = "mastermind potion", chance = 17771, maxCount = 3},
	{name = "crystal coin", chance = 35241, minCount = 25, maxCount = 40}
}

monster.attacks = {
	{name ="melee", interval = 1500, chance = 300, minDamage = 100, maxDamage = -200, effect = CONST_ME_DRAWBLOOD},
	{name ="combat", interval = 6000, chance = 45, type = COMBAT_HOLYDAMAGE, minDamage = -50, maxDamage = -800, length = 8, spread = 3, effect = CONST_ME_HOLYAREA, target = false},
	{name ="combat", interval = 2750, chance = 40, type = COMBAT_DEATHDAMAGE, minDamage = -40, maxDamage = -800, range = 7, shootEffect = CONST_ANI_SUDDENDEATH, effect = CONST_ME_MORTAREA, target = false},
	{name ="combat", interval = 4000, chance = 300, type = COMBAT_FIREDAMAGE, minDamage = -110, maxDamage = -1850, range = 35, radius = 88, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREAREA, target = true},
	{name ="combat", interval = 3300, chance = 44, type = COMBAT_ICEDAMAGE, minDamage = -40, maxDamage = -1000, length = 8, spread = 8, effect = CONST_ME_ICEATTACK, target = false},
	{name ="singlecloudchain", interval = 6000, chance = 44, minDamage = -80, maxDamage = -100, range = 4, effect = CONST_ME_ENERGYHIT, target = false},
	{name ="speed", interval = 2000, chance = 65, speedChange = -80, range = 7, effect = CONST_ME_MAGIC_RED, target = true, duration = 20000},
	{name ="drunk", interval = 1000, chance = 55, radius = 4, effect = CONST_ME_MAGIC_RED, target = false, duration = 6000}
}

monster.defenses = {
	defense = 70,
	armor = 82,
	{name ="defense shield", interval = 15000, chance = 100, target = false},
	{name ="combat", interval = 6000, chance = 40, type = COMBAT_HEALING, minDamage = 600, maxDamage = 1000, effect = CONST_ME_MAGIC_BLUE, target = true}
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

monster.events = {
	"DefenseShield"
}

mType.onAppear = function(monster, creature)
	if monster:getType():isRewardBoss() then
		monster:setReward(true)
	end
end

mType:register(monster)