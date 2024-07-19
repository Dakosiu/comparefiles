local mType = Game.createMonsterType("The Pale Count")
local monster = {}

monster.description = "The Pale Count"
monster.experience = 10000
monster.outfit = {
	lookType = 557,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.health = 26000
monster.maxHealth = 26000
monster.race = "blood"
monster.corpse = 18953
monster.speed = 500
monster.manaCost = 0
monster.maxSummons = 4

monster.changeTarget = {
	interval = 5000,
	chance = 8
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
	{text = "Feel the hungry kiss of death!", yell = false},
	{text = "The monsters in the mirror will come eat your dreams.", yell = false},
	{text = "Your pitiful life has come to an end!", yell = false},
	{text = "I will squish you like a maggot and suck you dry!", yell = false},
	{text = "Yield to the inevitable!", yell = false},
	{text = "Some day I shall see my beautiful face in a mirror again.", yell = false}
}

monster.loot = {
	{id = 8192, chance = 100000}, -- vampire lord token
	{id = 18927, chance = 100000}, -- vampire's cape chain
	{id = 18936, chance = 5000}, -- vampire count's medal
	{id = 18935, chance = 5000}, -- vampire's signet ring
	{id = 11449, chance = 50000}, -- blood preservation
	{id = 9685, chance = 50000}, -- vampire teeth
	{id = 7427, chance = 5000}, -- chaos mace
	{id = 3326, chance = 10000}, -- epee
	{id = 7419, chance = 5000}, -- dreaded cleaver
	{id = 8075, chance = 5000}, -- spellbook of lost souls
	{id = 19373, chance = 5000}, -- haunted mirror piece
	{id = 3434, chance = 5000}, -- vampire shield
	{id = 19374, chance = 5000}, -- vampire silk slippers
	{id = 3043, chance = 81000, maxCount = 10},
	{id = 29345, chance = 72000, minCount = 3, maxCount = 7}, --- weapons
	{id = 29347, chance = 45000, minCount = 3, maxCount = 7}, --- armors
	{id = 29346, chance = 36000, minCount = 3, maxCount = 7}, --- jewelry
    --{id = 37606, chance = 27000, minCount = 3, maxCount = 5} --- zakaria coin
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, skill = 80, attack = 420},
	{name ="speed", interval = 1000, chance = 27, speedChange = -600, range = 7, radius = 4, target = true, duration = 1500},
	{name ="combat", interval = 2000, chance = 41, type = COMBAT_ICEDAMAGE, minDamage = -1330, maxDamage = -1650, range = 6, radius = 3, shootEffect = CONST_ANI_SMALLICE, effect = CONST_ME_GIANTICE, target = true},
	{name ="combat", interval = 2000, chance = 25, type = COMBAT_MANADRAIN, minDamage = -600, maxDamage = -620, range = 8, shootEffect = CONST_ANI_EARTH, effect = CONST_ME_CARNIPHILA, target = true}
}

monster.defenses = {
	defense = 75,
	armor = 75,
	{name ="combat", interval = 1000, chance = 12, type = COMBAT_HEALING, minDamage = 1000, maxDamage = 2350, effect = CONST_ME_MAGIC_BLUE, target = false},
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = 20},
	{type = COMBAT_EARTHDAMAGE, percent = 20},
	{type = COMBAT_FIREDAMAGE, percent = 0},
	{type = COMBAT_LIFEDRAIN, percent = 20},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 0},
	{type = COMBAT_HOLYDAMAGE , percent = 0},
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
