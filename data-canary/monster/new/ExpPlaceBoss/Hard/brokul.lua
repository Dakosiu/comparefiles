local mType = Game.createMonsterType("Brokul")
local monster = {}

monster.description = "Brokul"
monster.experience = 180000
monster.outfit = {
	lookType = 1076,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.health = 50000
monster.maxHealth = 50000
monster.race = "blood"
monster.corpse = 33376
monster.speed = 210
monster.manaCost = 0
monster.maxSummons = 0

monster.changeTarget = {
	interval = 1000,
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
	pushable = true,
	rewardBoss = false,
	illusionable = true,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 60,
	targetDistance = 1,
	runHealth = 60,
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
	{name = "small sapphire", chance = 2854, maxCount = 10},
	{name = "Gold Ingot", chance = 3448, maxCount = 10},
	{name = "Broccoli", chance = 2439, maxCount = 10},
	{name = "Small Diamond", chance = 498, maxCount = 10},
	{name = "Blue Gem", chance = 2500},
	{name = "Red Gem", chance = 2000},
	{name = "Deepling Ceremonial Dagger", chance = 200},
	{name = "Deepling Fork", chance = 200},
	{id = 3043, chance = 81000, maxCount = 20 },
	{id = 33983, chance = 72000, minCount = 5, maxCount = 12}, --- weapons
	{id = 33985, chance = 45000, minCount = 5, maxCount = 12}, --- armors
	{id = 33984, chance = 36000, minCount = 5, maxCount = 12}, --- jewelry
    --{id = 37606, chance = 27000, minCount = 4, maxCount = 6} --- zakaria coin
}


monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1500},
	{name ="combat", interval = 2000, chance = 14, type = COMBAT_HOLYDAMAGE, minDamage = -100, maxDamage = -1700, length = 8, spread = 3, effect = CONST_ME_MORTAREA, target = true},
	{name ="combat", interval = 2000, chance = 18, type = COMBAT_PHYSICALDAMAGE, minDamage = -300, maxDamage = -1700, radius = 4, effect = CONST_ME_EXPLOSIONAREA, target = true},
	{name ="combat", interval = 2000, chance = 14, type = COMBAT_FIREDAMAGE, minDamage = -1300, maxDamage = -1840, length = 8, spread = 3, effect = CONST_ME_HITBYFIRE, target = true},
	{name ="combat", interval = 2000, chance = 14, type = COMBAT_HOLYDAMAGE, minDamage = -1300, maxDamage = -1700, length = 8, spread = 3, effect = CONST_ME_HOLYAREA, target = true},
	{name ="combat", interval = 2000, chance = 29, type = COMBAT_ICEDAMAGE, minDamage = -1300, maxDamage = -1840, range = 7, radius = 4, effect = CONST_ME_FIREAREA, target = true}
}

monster.defenses = {
	defense = 60,
	armor = 86,
	{name ="combat", interval = 1000, chance = 20, type = COMBAT_HEALING, minDamage = 1200, maxDamage = 1500, effect = CONST_ME_MAGIC_BLUE, target = false}
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
