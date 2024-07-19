local mType = Game.createMonsterType("Spectralpod")
local monster = {}

monster.description = "a Spectralpod"
monster.experience = 100000
monster.outfit = {
	lookType = 1062,
	lookHead = 85,
	lookBody = 7,
	lookLegs = 3,
	lookFeet = 15,
	lookAddons = 2,
	lookMount = 0
}

monster.health = 136000
monster.maxHealth = 136000
monster.race = "blood"
monster.corpse = 22495
monster.speed = 115
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 4
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
	staticAttackChance = 98,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = false
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
	{name = "platinum coin", chance = 90000, maxCount = 38},
	{name = "crystal coin", chance = 70000, maxCount = 5},
	{name = "ultimate mana potion", chance = 70000, maxCount = 8},
	{name = "ultimate spirit potion", chance = 70000, maxCount = 4},
	{name = "supreme health potion", chance = 70000, maxCount = 4},
	{name = "berserk potion", chance = 70000, maxCount = 2},
	{name = "mastermind potion", chance = 70000, maxCount = 2},
	{name = "onyx chip", chance = 70000, maxCount = 12},
	{name = "small emerald", chance = 70000, maxCount = 12},
	{name = "demon horn", chance = 70000},
	{name = "lightning boots", chance = 70000},
	{id= 3039, chance = 70000}, -- red gem
	{name = "violet gem", chance = 70000},
	{name = "wand of starstorm", chance = 70000},
	{name = "gold token", chance = 30000, maxCount = 4},
	{name = "assassin dagger", chance = 30000},
	{name = "crystalline armor", chance = 30000},
	{name = "dreaded cleaver", chance = 30000},
	{name = "frozen lightning", chance = 30000},
	{name = "sinister book", chance = 1000},
	{name = "wand of dimensions", chance = 10}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, skill = 90, attack = 80},
	{name ="Ice Strike", interval = 2000, chance = 36, minDamage = -2200, maxDamage = -2500},
	{name ="combat", interval = 2000, chance = 10, type = COMBAT_ICEDAMAGE, minDamage = -2400, maxDamage = -2600, length = 8, spread = 3, effect = CONST_ME_BUBBLES, target = false},
	{name ="speed", interval = 2000, chance = 25, speedChange = -800, range = 7, radius = 4, shootEffect = CONST_ANI_POISON, effect = CONST_ME_GREEN_RINGS, target = true, duration = 15000},


}

monster.defenses = {
	defense = 40,
	armor = 40
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = 0},
	{type = COMBAT_EARTHDAMAGE, percent = 0},
	{type = COMBAT_FIREDAMAGE, percent = -10},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 100},
	{type = COMBAT_ICEDAMAGE, percent = 100},
	{type = COMBAT_HOLYDAMAGE , percent = 0},
	{type = COMBAT_DEATHDAMAGE , percent = 0}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType.onThink = function(monster, interval)
end

mType.onAppear = function(monster, creature)
	if monster:getType():isRewardBoss() then
		monster:setReward(true)
	end
end

mType.onDisappear = function(monster, creature)
end

mType.onMove = function(monster, creature, fromPosition, toPosition)
end

mType.onSay = function(monster, creature, type, message)
end

mType:register(monster)
