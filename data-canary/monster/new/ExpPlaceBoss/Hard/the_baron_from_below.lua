local mType = Game.createMonsterType("The Baron From Below")
local monster = {}

monster.description = "The Baron From Below"
monster.experience = 40000
monster.outfit = {
	lookType = 1045,
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
monster.corpse = 27633
monster.speed = 440
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10
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
	canWalkOnPoison = true
}

monster.light = {
	level = 0,
	color = 0
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{text = "Krrrk!", yell = false}
}

monster.loot = {
	{name = "Platinum Coin", chance = 10000, maxCount = 58},
	{name = "crystal coin", chance = 10000, maxCount = 2},
	{name = "gold ingot", chance = 10000, maxCount = 2},
	{name = "great mana potion", chance = 10000, maxCount = 10},
	{name = "great spirit potion", chance = 10000, maxCount = 18},
	{name = "mastermind potion", chance = 10000, maxCount = 2},
	{name = "small diamond", chance = 10000, maxCount = 12},
	{name = "small emerald", chance = 10000, maxCount = 12},
	{name = "small ruby", chance = 10000, maxCount = 12},
	{name = "small topaz", chance = 10000, maxCount = 12},
	{name = "ultimate health potion", chance = 10000, maxCount = 8},
	{name = "violet crystal shard", chance = 10000, maxCount = 3},
	{name = "badger boots", chance = 10000},
	{name = "blue gem", chance = 10000},
	{name = "Calopteryx Cape", chance = 10000},
	{id = 27622, chance = 10000},
	{name = "Crystal Mace", chance = 10000},
	{name = "Fire Sword", chance = 10000},
	{name = "Green Gem", chance = 10000},
	{name = "Huge Chunk of Crude Iron", chance = 10000, maxCount = 2},
	{name = "Huge Shell", chance = 10000},
	{name = "Longing Eyes", chance = 10000},
	{name = "Luminous Orb", chance = 10000},
	{name = "Magic Sulphur", chance = 10000, maxCount = 2},
	{name = "Magma Coat", chance = 10000},
	{id= 3039, chance = 10000},
	{id = 8906, chance = 10000},
	{id = 8900, chance = 10000},
	{name = "Slimy Leg", chance = 10000},
	{name = "Violet Gem", chance = 10000},
	{name = "Wand of Inferno", chance = 10000},
	{name = "Yellow Gem", chance = 10000},
	{name = "Mallet Head", chance = 1000},
	{name = "Gnome Shield", chance = 1000},
	{name = "Gnome Sword", chance = 1000},
	{name = "plan for a makeshift armour", chance = 500},
	{name = "Gnome Armor", chance = 500},
	{id = 3043, chance = 81000, maxCount = 20 },
	{id = 33983, chance = 72000, minCount = 5, maxCount = 12}, --- weapons
	{id = 33985, chance = 45000, minCount = 5, maxCount = 12}, --- armors
	{id = 33984, chance = 36000, minCount = 5, maxCount = 12}, --- jewelry
    --{id = 37606, chance = 27000, minCount = 4, maxCount = 6} --- zakaria coin
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 1110, maxDamage = -2550},
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_PHYSICALDAMAGE, minDamage = 1500, maxDamage = -2600, radius = 9, effect = CONST_ME_HITAREA, target = true},
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_EARTHDAMAGE, minDamage = 1500, maxDamage = -2000, length = 8, spread = 5, effect = CONST_ME_YELLOW_RINGS, target = true},
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_EARTHDAMAGE, minDamage = 1000, maxDamage = -2900, length = 8, spread = 9, effect = CONST_ME_POFF, target = true},
	{name ="combat", interval = 2000, chance = 100, type = COMBAT_DEATHDAMAGE, minDamage = 1000, maxDamage = -2500, radius = 4, effect = CONST_ME_MORTAREA, target = true},
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_EARTHDAMAGE, minDamage = 1000, maxDamage = -2800, radius = 6, effect = CONST_ME_SMALLPLANTS, target = true}
}

monster.defenses = {
	defense = 30,
	armor = 30,
	{name ="combat", interval = 2000, chance = 35, type = COMBAT_HEALING, minDamage = 1800, maxDamage = 2200, effect = CONST_ME_MAGIC_BLUE, target = false}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 60},
	{type = COMBAT_ENERGYDAMAGE, percent = 60},
	{type = COMBAT_EARTHDAMAGE, percent = 60},
	{type = COMBAT_FIREDAMAGE, percent = 100},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 60},
	{type = COMBAT_HOLYDAMAGE , percent = 60},
	{type = COMBAT_DEATHDAMAGE , percent = 60}
}

monster.heals = {
	{type = COMBAT_FIREDAMAGE, percent = 100},
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

mType.onDisappear = function(monster, creature)
	expPlaceBoss.onDisappear(monster.uid)
end

mType:register(monster)