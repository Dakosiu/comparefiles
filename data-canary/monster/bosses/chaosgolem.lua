local mType = Game.createMonsterType("Chaosgolem")
local monster = {}

monster.description = "Chaosgolem"
monster.experience = 100000
monster.outfit = {
	lookType = 1062,
	lookHead = 22,
	lookBody = 57,
	lookLegs = 79,
	lookFeet = 77,
	lookAddons = 0,
	lookMount = 0
}

monster.health = 100000
monster.maxHealth = 100000
monster.race = "blood"
monster.corpse = 7893
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

monster.summon = {
	maxSummons = 5,
	summons = {
		{name = "demon blood", chance = 10, interval = 2000, count = 5}
	}
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
	{name = "platinum coin", chance = 90000, maxCount = 63},
	{name = "crystal coin", chance = 70000, maxCount = 4},
	{name = "great mana potion", chance = 70000, maxCount = 18},
	{name = "great spirit potion", chance = 70000, maxCount = 18},
	{name = "ultimate mana potion", chance = 70000, maxCount = 12},
	{name = "ultimate health potion", chance = 70000, maxCount = 18},
	{name = "mastermind potion", chance = 70000, maxCount = 2},
	{name = "onyx chip", chance = 70000, maxCount = 12},
	{name = "small emerald", chance = 70000, maxCount = 12},
	{name = "small amethyst", chance = 70000, maxCount = 12},
	{name = "small diamond", chance = 70000, maxCount = 12},
	{name = "small ruby", chance = 70000, maxCount = 12},
	{name = "blue gem", chance = 70000},
	{name = "demon horn", chance = 70000},
	{name = "demonic essence", chance = 70000},
	{id = 281, chance = 70000}, -- giant shimmering pearl (green)
	{name = "green gem", chance = 70000},
	{name = "magic sulphur", chance = 70000},
	{name = "silver token", chance = 30000, maxCount = 4},
	{name = "blue robe", chance = 30000},
	{name = "dreaded cleaver", chance = 30000},
	{id = 8900, chance = 30000}, -- heavily rusted shield
	{name = "wand of inferno", chance = 30000},
	{id = 28341, chance = 1000}, -- tessellated wall
	{name = "sturdy book", chance = 1000}
}

monster.attacks = {
    {name ="melee", interval = 2000, chance = 100, minDamage = -1000, maxDamage = -1500 },
	{name ="Groundshaker", interval = 2000, chance = 16, minDamage = -1600, maxDamage = -1900},
	{name ="Whirlwind Throw", interval = 2000, chance = 36, minDamage = -1700, maxDamage = -2000},
	{name ="Inflict Wound", interval = 2000, chance = 50, minDamage = -200, maxDamage = -300},
}

monster.defenses = {
	defense = 40,
	armor = 40
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = -10},
	{type = COMBAT_ENERGYDAMAGE, percent = 0},
	{type = COMBAT_EARTHDAMAGE, percent = 0},
	{type = COMBAT_FIREDAMAGE, percent = 0},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 0},
	{type = COMBAT_HOLYDAMAGE , percent = 0},
	{type = COMBAT_DEATHDAMAGE , percent = -10}
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