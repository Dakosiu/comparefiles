local mType = Game.createMonsterType("Irgix The Flimsy")
local monster = {}

monster.description = "Irgix The Flimsy"
monster.experience = 180000
monster.outfit = {
	lookType = 1268,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 1,
	lookMount = 0
}

monster.health = 45000
monster.maxHealth = 45000
monster.race = "undead"
monster.corpse = 37445
monster.speed = 285
monster.manaCost = 0
monster.maxSummons = 0

monster.changeTarget = {
	interval = 5000,
	chance = 38
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
	{name = "skull coin", chance = 66670},
	{name = "terra rod", chance = 16670},
	{name = "necklace of the deep", chance = 8330},
	{name = "pair of nightmare boots", chance = 330},
	{id = 3043, chance = 81000, maxCount = 20 },
	{id = 33983, chance = 72000, minCount = 5, maxCount = 12}, --- weapons
	{id = 33985, chance = 45000, minCount = 5, maxCount = 12}, --- armors
	{id = 33984, chance = 36000, minCount = 5, maxCount = 12}, --- jewelry
    --{id = 37606, chance = 27000, minCount = 4, maxCount = 6} --- zakaria coin
}


monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = -1000, maxDamage = -5000},
	{name ="combat", interval = 1500, chance = 15, type = COMBAT_EARTHDAMAGE, minDamage = -1000, maxDamage = -2000, radius = 3, shootEffect = CONST_ANI_ENVENOMEDARROW, target = true},
	{name ="combat", interval = 1500, chance = 25, type = COMBAT_ENERGYDAMAGE, minDamage = -1000, maxDamage = -2500, length = 4, spread = 3, effect = CONST_ME_ENERGYHIT, target = true},
	{name ="combat", interval = 1500, chance = 35, type = COMBAT_DEATHDAMAGE, minDamage = -2000, maxDamage = -2500, radius = 4, effect = CONST_ME_MORTAREA, target = true},
	{name ="combat", interval = 1500, chance = 20, type = COMBAT_ENERGYDAMAGE, minDamage = -1000, maxDamage = -2500, radius = 4, effect = CONST_ME_ENERGYAREA, target = false}
}

monster.defenses = {
	defense = 40,
	armor = 82,
	{name ="combat", interval = 2000, chance = 25, type = COMBAT_HEALING, minDamage = 1800, maxDamage = 3200, effect = CONST_ME_MAGIC_BLUE, target = false}
}

monster.elements = {
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
