local mType = Game.createMonsterType("Lisa")
local monster = {}

monster.description = "Lisa"
monster.experience = 28000
monster.outfit = {
	lookType = 604,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.health = 35000
monster.maxHealth = 35000
monster.race = "venom"
monster.corpse = 20988
monster.speed = 200
monster.manaCost = 0
monster.maxSummons = 0

monster.changeTarget = {
	interval = 2000,
	chance = 3
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
	{name = "slimy leaf tentacle", chance = 22000, maxCount = 3},
	{name = "glooth club", chance = 10500},
	{name = "glooth spear", chance = 9900},
	{name = "glooth whip", chance = 9500},
	{name = "glooth amulet", chance = 9000},
	{name = "glooth axe", chance = 8000},
	{name = "glooth blade", chance = 7000},
	{name = "glooth cape", chance = 6000},
	{id = 3043, chance = 81000, maxCount = 10},
	{id = 29345, chance = 72000, minCount = 3, maxCount = 7}, --- weapons
	{id = 29347, chance = 45000, minCount = 3, maxCount = 7}, --- armors
	{id = 29346, chance = 36000, minCount = 3, maxCount = 7}, --- jewelry
    --{id = 37606, chance = 27000, minCount = 3, maxCount = 5} --- zakaria coin
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, skill = 150, attack = 400, condition = {type = CONDITION_POISON, totalDamage = 900, interval = 4000}},
	{name ="combat", interval = 2000, chance = 20, type = COMBAT_LIFEDRAIN, minDamage = -1200, maxDamage = -400, range = 7, radius = 1, shootEffect = CONST_ANI_GREENSTAR, effect = CONST_ME_MORTAREA, target = true},
	{name ="effect", interval = 2000, chance = 25, range = 7, radius = 6, shootEffect = CONST_ANI_SMALLEARTH, effect = CONST_ME_BIGPLANTS, target = true},
	{name ="effect", interval = 2000, chance = 25, range = 7, radius = 6, shootEffect = CONST_ANI_SMALLEARTH, effect = CONST_ME_PLANTATTACK, target = true},
	{name ="combat", interval = 2000, chance = 23, type = COMBAT_MANADRAIN, minDamage = -1100, maxDamage = -1200, radius = 8, effect = CONST_ME_POISONAREA, target = true},
	{name ="lisa paralyze", interval = 2000, chance = 12, target = true},
	{name ="lisa skill reducer", interval = 2000, chance = 15, target = true},
	{name ="lisa wave", interval = 2000, chance = 11, minDamage = -400, maxDamage = -900, target = false}
}

monster.defenses = {
	defense = 25,
	armor = 15,
	{name ="combat", interval = 2000, chance = 25, type = COMBAT_HEALING, minDamage = 800, maxDamage = 1900, effect = CONST_ME_MAGIC_BLUE, target = false}
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
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType.onThink = function(monster, interval)
	expPlaceBoss.onThink(monster.uid)
end

mType.onAppear = function(monster, creature)
	if monster:getType():isRewardBoss() then
		monster:setReward(true)
	end
end

mType.onDisappear = function(monster, creature)
	expPlaceBoss.onDisappear(monster.uid)
end

mType.onMove = function(monster, creature, fromPosition, toPosition)
end

mType.onSay = function(monster, creature, type, message)
end

mType:register(monster)
