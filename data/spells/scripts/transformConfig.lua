
local TransformTable = {
	["Saiyan"] = {
		[1] = {name = "Young", vocation = {before = 1, after = 1, revert = 1}, level = 1, shader = -1, revertKiPercent = 0,
		cost = {
		}, lookTypes = {
		[1] = {lookType = 33, name = "Young Goku"},
		[2] = {lookType = 44, name = "Young Saiyan from Vegeta"},
		[3] = {lookType = 55, name = "Young Oozaru"},
		[4] = {lookType = 66, name = "Young Saiyan"},
		[5] = {lookType = 77, name = "Young Saiyan2"},
		[6] = {lookType = 88, name = "Young Saiyan3"}
		}, stats = {
		}, transformEffects = {
		{pos = {x = 0, y = 0}, id = 78}
		}, revertEffects = {
		{pos = {x = 0, y = 0}, id = 78}
		}
		}, 
		[2] = {name = "Teen", vocation = {before = 1, after = 2, revert = 2}, level = 10, shader = -1, revertKiPercent = 0,
		cost = {
		}, lookTypes = {
		[1] = {lookType = 33, name = "Teen Goku"},
		[2] = {lookType = 44, name = "Teen Saiyan from Vegeta"},
		[3] = {lookType = 55, name = "Teen Oozaru"},
		[4] = {lookType = 66, name = "Teen Saiyan"},
		[5] = {lookType = 77, name = "Teen Saiyan2"},
		[6] = {lookType = 88, name = "Teen Saiyan3"}
		}, stats = {
		{permanentHp = 5000}, 
		{permanentSkill = SKILL_KI_DAMAGE, value = 10}, 
		{permanentKi = 5000}
		}, transformEffects = {
		{pos = {x = 0, y = 0}, id = 78}
		}, revertEffects = {
		{pos = {x = 0, y = 0}, id = 78}
		}
		}, 
		[3] = {name = "Adult", vocation = {before = 2, after = 3, revert = 3}, level = 12, shader = -1, revertKiPercent = 0,
		cost = {
		}, lookTypes = {
		[1] = {lookType = 33, name = "Adult Goku"},
		[2] = {lookType = 44, name = "Adult Saiyan from Vegeta"},
		[3] = {lookType = 55, name = "Adult Oozaru"},
		[4] = {lookType = 66, name = "Adult Saiyan"},
		[5] = {lookType = 77, name = "Adult Saiyan2"},
		[6] = {lookType = 88, name = "Adult Saiyan3"}
		}, stats = {
		{permanentHp = 5000}, 
		{permanentSkill = SKILL_MELEE, value = 10}, 
		{permanentKi = 5000}
		}, transformEffects = {
		{pos = {x = 0, y = 0}, id = 78}
		}, revertEffects = {
		{pos = {x = 0, y = 0}, id = 78}
		}
		}, 
		[4] = {name = "Super", vocation = {before = 3, after = 4, revert = 3}, level = 22, shader = -1, revertKiPercent = 0,
		cost = {
		transformUseHp = 100,
		transformUseKi = 100,
		transformUsePercentHp = 0.1,
		transformUsePercentKi = 1
		}, lookTypes = {
		[1] = {lookType = 32, name = "Super Goku"},
		[2] = {lookType = 43, name = "Super Saiyan from Vegeta"},
		[3] = {lookType = 54, name = "Super Oozaru"},
		[4] = {lookType = 65, name = "Super Saiyan"},
		[5] = {lookType = 76, name = "Super Saiyan2"},
		[6] = {lookType = 87, name = "Super Saiyan3"}
		}, stats = {
		{condition = CONDITION_PARAM_STAT_MAXHITPOINTS, value = 5000, subId = 101}, 
		{condition = CONDITION_PARAM_STAT_MAXMANAPOINTS, value = 5000, subId = 102}, 
		{condition = CONDITION_PARAM_SKILL_MELEE, value = 10, subId = 105}, 
		{condition = CONDITION_PARAM_SKILL_MELEE_DEFENSE, value = 10, subId = 106}, 
		{condition = CONDITION_PARAM_SKILL_ATTACK_SPEED, value = 10, subId = 107}, 
		{condition = CONDITION_PARAM_SKILL_MOVEMENT_SPEED, value = 10, subId = 108}, 
		{condition = CONDITION_PARAM_SKILL_KI_DAMAGE, value = 10, subId = 109}, 
		{condition = CONDITION_PARAM_SKILL_KI_DEFENSE, value = 10, subId = 110}
		}, transformEffects = {
		{pos = {x = 0, y = 0}, id = 78}
		}, revertEffects = {
		{pos = {x = 0, y = 0}, id = 78}
		}
		}, 
		[5] = {name = "God", vocation = {before = 4, after = 5, revert = 3}, level = 25, shader = -1, revertKiPercent = 25,
		cost = {
		transformUseHp = 100,
		transformUseKi = 100,
		transformUsePercentHp = 0.1,
		transformUsePercentKi = 1
		}, lookTypes = {
		[1] = {lookType = 31, name = "God Goku"},
		[2] = {lookType = 42, name = "God Saiyan from Vegeta"},
		[3] = {lookType = 53, name = "God Oozaru"},
		[4] = {lookType = 64, name = "God Saiyan"},
		[5] = {lookType = 75, name = "God Saiyan2"},
		[6] = {lookType = 86, name = "God Saiyan3"}
		}, stats = {
		{condition = CONDITION_PARAM_STAT_MAXHITPOINTS, value = 10000, subId = 101}, 
		{condition = CONDITION_PARAM_STAT_MAXMANAPOINTS, value = 10000, subId = 102}, 
		{condition = CONDITION_PARAM_STAT_MAXHITPOINTSPERCENT, value = 115, subId = 103}, 
		{condition = CONDITION_PARAM_STAT_MAXMANAPOINTSPERCENT, value = 115, subId = 104},
		{condition = CONDITION_PARAM_SKILL_MELEE, value = 20, subId = 105}, 
		{condition = CONDITION_PARAM_SKILL_MELEE_DEFENSE, value = 20, subId = 106}, 
		{condition = CONDITION_PARAM_SKILL_ATTACK_SPEED, value = 20, subId = 107}, 
		{condition = CONDITION_PARAM_SKILL_MOVEMENT_SPEED, value = 20, subId = 108}, 
		{condition = CONDITION_PARAM_SKILL_KI_DAMAGE, value = 20, subId = 109}, 
		{condition = CONDITION_PARAM_SKILL_KI_DEFENSE, value = 20, subId = 110}
		}, transformEffects = {
		{pos = {x = 0, y = 0}, id = 78}
		}, revertEffects = {
		{pos = {x = 0, y = 0}, id = 78}
		}
		} 
		},
	["Vegeta"] = {
	}
	}

