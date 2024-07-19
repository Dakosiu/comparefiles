local mType = Game.createMonsterType("Power Statue")
local monster = {}
monster.description = "Power Statue"
monster.experience = 0
monster.outfit = {
	lookTypeEx = 11428
}

monster.health = 10000000
monster.maxHealth = monster.health
monster.race = "blood"
monster.corpse = 0
monster.speed = 0
monster.maxSummons = 0

monster.changeTarget = {
	interval = 1*1000,
	chance = 0
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	targetDistance = 1,
	staticAttackChance = 100,
}

monster.summons = {
}

monster.voices = {
	interval = 5000,
	chance = 15,
	{text = "But practice makes perfect, and I could do it now.", yell = false},
}

monster.loot = {
}

monster.attacks = {
	{name = "melee", attack = 130, interval = 2*1000, minDamage = -1, maxDamage = -2}
}

monster.defenses = {
	defense = 1,
	armor = 1,
	{name = "combat", type = COMBAT_HEALING, chance = 15, interval = 2*1000, minDamage = 0, maxDamage = 0, effect = CONST_ME_MAGIC_BLUE}
}

monster.elements = {
}

monster.immunities = {
}

mType:register(monster)