local mType = Game.createMonsterType("Peggy One Leg")
local monster = {}

monster.description = "Peggy One Leg"
monster.experience = 50000
monster.outfit = {
	lookType = 1377,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 70000
monster.maxHealth = 70000
monster.race = "blood"
monster.corpse = 35846
monster.speed = 115
monster.manaCost = 0


monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.bosstiary = {
	bossRaceId = 2006,
	bossRace = RARITY_ARCHFOE,
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
}

monster.light = {
	level = 0,
	color = 0,
}

monster.summon = {
	maxSummons = 1,
	summons = {
		{ name = "elite pirat", chance = 30, interval = 1000 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
	{name = "zakaria stone", chance = 100000, minCount = 4, maxCount = 11},
    {id = 27846, chance = 1400, maxCount = 1},
    {id = 21947, chance = 2100, maxCount = 1},
    {id = 21804, chance = 2400, maxCount = 1},
	{id = 21805, chance = 1400, maxCount = 1},
	{id = 36724, chance = 2400, maxCount = 1},
	{id = 36726, chance = 2400, maxCount = 1},
	{id = 36728, chance = 2400, maxCount = 1},
	{id = 23488, chance = 2400, maxCount = 1},
	{id = 32226, chance = 14400, maxCount = 1},
	{id = 42368, chance = 3400, maxCount = 1},
	{id = 3048, chance = 25400, maxCount = 1},
	{id = 3081, chance = 15400, maxCount = 1},
	{id = 651, chance = 15400, maxCount = 1},
	{id = 36724, chance = 2400, maxCount = 1},
	{name = "berserk potion", chance = 17988, maxCount = 3},
	{name = "mastermind potion", chance = 17771, maxCount = 3},
	{name = "crystal coin", chance = 35241, minCount = 25, maxCount = 40},
	{ id = 35613, chance = 8000 }, -- ratmiral's hat
	{ id = 35571, chance = 7140 }, -- small treasure chest
	{ id = 35578, chance = 6250 }, -- tiara
	{ id = 35579, chance = 3570 }, -- golden dustbin
	{ id = 32626, chance = 2680 }, -- amber
	{ id = 35581, chance = 2680 }, -- golden cheese wedge
	{ id = 35595, chance = 2680 }, -- soap
	{ id = 35695, chance = 1790 }, -- scrubbing brush
	{ id = 35614, chance = 890 }, -- cheesy membership card
	{ id = 35523, chance = 890 }, -- exotic amulet
	{ id = 35515, chance = 890 }, -- throwing axe
	{ id = 35517, chance = 890 }, -- bast legs
	{ id = 35516, chance = 890 }, -- exotic legs
	{ id = 35518, chance = 890 }, -- jungle bow
	{ id = 35524, chance = 890 }, -- jungle quiver
	{ id = 35514, chance = 890 }, -- jungle flail
	{ id = 35521, chance = 890 }, -- jungle rod
	{ id = 35522, chance = 890 }, -- jungle wand
	{ id = 35519, chance = 890 }, -- makeshift boots
	{ id = 35520, chance = 890 }, -- make-do boots
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -270, maxDamage = -500 },
	{ name = "combat", interval = 2000, chance = 40, type = COMBAT_PHYSICALDAMAGE, minDamage = -300, maxDamage = -600, range = 7, shootEffect = CONST_ANI_WHIRLWINDCLUB, target = true },
	{ name = "combat", interval = 2000, chance = 40, type = COMBAT_LIFEDRAIN, minDamage = -300, maxDamage = -600, radius = 4, effect = CONST_ME_MAGIC_RED, target = false },
	{ name = "combat", interval = 2000, chance = 30, type = COMBAT_LIFEDRAIN, minDamage = -600, maxDamage = -1000, length = 4, spread = 0, effect = CONST_ME_SOUND_PURPLE, target = false },
	{ name = "speed", interval = 2000, chance = 25, speedChange = -400, effect = CONST_ME_MAGIC_RED, target = true, duration = 4000 },
	{ name = "drunk", interval = 3000, chance = 40, range = 2, target = false, duration = 5000 },
	{ name = "condition", type = CONDITION_BLEEDING, interval = 2000, chance = 20, minDamage = -400, maxDamage = -600, radius = 2, target = false }
}

monster.defenses = {
	defense = 60,
	armor = 82,
	{name ="invisible", interval = 4000, chance = 30, effect = CONST_ME_MAGIC_BLUE}
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 30 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 30 },
	{ type = COMBAT_EARTHDAMAGE, percent = 30 },
	{ type = COMBAT_FIREDAMAGE, percent = 30 },
	{ type = COMBAT_LIFEDRAIN, percent = 30 },
	{ type = COMBAT_MANADRAIN, percent = 30 },
	{ type = COMBAT_DROWNDAMAGE, percent = 30 },
	{ type = COMBAT_ICEDAMAGE, percent = 30 },
	{ type = COMBAT_HOLYDAMAGE, percent = 30 },
	{ type = COMBAT_DEATHDAMAGE, percent = 30 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType.onAppear = function(monster, creature)
	if monster:getType():isRewardBoss() then
		monster:setReward(true)
	end
end

mType:register(monster)
