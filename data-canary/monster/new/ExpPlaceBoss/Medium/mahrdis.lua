local mType = Game.createMonsterType("Mahrdis")
local monster = {}

monster.description = "Mahrdis"
monster.experience = 13050
monster.outfit = {
	lookType = 90,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.health = 27900
monster.maxHealth = 27900
monster.race = "undead"
monster.corpse = 6025
monster.speed = 340
monster.manaCost = 0
monster.maxSummons = 0

monster.changeTarget = {
	interval = 5000,
	chance = 28
}

monster.strategiesTarget = {
	nearest = 80,
	health = 10,
	damage = 10,
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
	{text = "Ashes to ashes!", yell = false},
	{text = "Fire, Fire!", yell = false},
	{text = "The eternal flame demands its due!", yell = false},
	{text = "This is why I'm hot.", yell = false},
	{text = "May my flames engulf you!", yell = false},
	{text = "Burnnnnnnnnn!", yell = false}
}

monster.loot = {
	{name = "holy falcon", chance = 500},
	{name = "burning heart", chance = 100000},
	{name = "fire axe", chance = 750},
	{name = "phoenix shield", chance = 300},
	{id = 3043, chance = 81000, maxCount = 10},
	{id = 29345, chance = 72000, minCount = 3, maxCount = 7}, --- weapons
	{id = 29347, chance = 45000, minCount = 3, maxCount = 7}, --- armors
	{id = 29346, chance = 36000, minCount = 3, maxCount = 7}, --- jewelry
    --{id = 37606, chance = 27000, minCount = 3, maxCount = 5} --- zakaria coin
}



monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -400, condition = {type = CONDITION_POISON, totalDamage = 65, interval = 4000}},
	{name ="combat", interval = 1600, chance = 7, type = COMBAT_PHYSICALDAMAGE, minDamage = -610, maxDamage = -1600, range = 5, effect = CONST_ME_MAGIC_RED, target = true},
	{name ="combat", interval = 1000, chance = 7, type = COMBAT_FIREDAMAGE, minDamage = -160, maxDamage = -1600, range = 7, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREAREA, target = true},
	{name ="speed", interval = 2000, chance = 13, speedChange = -850, range = 7, effect = CONST_ME_MAGIC_RED, target = true, duration = 50000},
	{name ="combat", interval = 2000, chance = 34, type = COMBAT_FIREDAMAGE, minDamage = -580, maxDamage = -800, radius = 3, effect = CONST_ME_EXPLOSIONAREA, target = false},
	{name ="firefield", interval = 1000, chance = 12, radius = 4, effect = CONST_ME_BLOCKHIT, target = false},
	-- fire
	{name ="condition", type = CONDITION_FIRE, interval = 2000, chance = 13, minDamage = -50, maxDamage = -500, length = 8, spread = 3, effect = CONST_ME_EXPLOSIONHIT, target = false}
}

monster.defenses = {
	defense = 30,
	armor = 20,
	{name ="combat", interval = 1000, chance = 20, type = COMBAT_HEALING, minDamage = 920, maxDamage = 1800, effect = CONST_ME_MAGIC_BLUE, target = false}
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
	{type = "paralyze", condition = false},
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
