local berserk = Condition(CONDITION_ATTRIBUTES)
berserk:setParameter(CONDITION_PARAM_TICKS, 10 * 60 * 1000)
berserk:setParameter(CONDITION_PARAM_SKILL_MELEE, 5)
berserk:setParameter(CONDITION_PARAM_SKILL_SHIELD, -10)
berserk:setParameter(CONDITION_PARAM_BUFF_SPELL, true)

local mastermind = Condition(CONDITION_ATTRIBUTES)
mastermind:setParameter(CONDITION_PARAM_TICKS, 10 * 60 * 1000)
mastermind:setParameter(CONDITION_PARAM_STAT_MAGICPOINTS, 3)
mastermind:setParameter(CONDITION_PARAM_BUFF_SPELL, true)

local bullseye = Condition(CONDITION_ATTRIBUTES)
bullseye:setParameter(CONDITION_PARAM_TICKS, 10 * 60 * 1000)
bullseye:setParameter(CONDITION_PARAM_SKILL_DISTANCE, 5)
bullseye:setParameter(CONDITION_PARAM_SKILL_SHIELD, -10)
bullseye:setParameter(CONDITION_PARAM_BUFF_SPELL, true)

local potions = {
	[6558] = { -- concentrated demonic blood
		transform = {7588, 7589},
		effect = CONST_ME_DRAWBLOOD
	},
	[7439] = { -- berserk potion
		condition = berserk,
		vocations = {4, 8},
		effect = CONST_ME_MAGIC_RED,
		description = "Only knights may drink this potion.",
		text = "You feel stronger."
	},
	[7440] = { -- mastermind potion
		condition = mastermind,
		vocations = {1, 2, 5, 6},
		effect = CONST_ME_MAGIC_BLUE,
		description = "Only sorcerers and druids may drink this potion.",
		text = "You feel smarter."
		},
	[7443] = { -- bullseye potion
		condition = bullseye,
		vocations = {3, 7},
		effect = CONST_ME_MAGIC_GREEN,
		description = "Only paladins may drink this potion.",
		text = "You feel more accurate."
	},
	[7588] = { -- strong health potion
		health = {2000, 2800},
		vocations = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24},
		flask = 0,
		description = "Only knights and paladins of level 50 or above may drink this fluid."
	},
	[7589] = { -- strong mana potion
		mana = {920, 1480},
		vocations = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24},
		flask = 0,
		description = "Only sorcerers, druids and paladins of level 50 or above may drink this fluid."
	},
	[7590] = { -- great mana potion
		mana = {1200, 2000},
		vocations = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24},
		flask = 0,
		description = "Only druids and sorcerers of level 80 or above may drink this fluid."
	},
	[7591] = { -- great health potion
		health = {3400, 4600},
		vocations = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24},
		flask = 0,
		description = "Only knights of level 80 or above may drink this fluid."
	},
	[7618] = { -- health potion
		health = {1000, 1400},
		flask = 0
	},
	[7620] = { -- mana potion
		mana = {600, 1000},
		flask = 0
	},
	[8472] = { -- great spirit potion
		health = {2000, 2800},
		mana = {800, 1600},
		vocations = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24},
		flask = 0,
		description = "Only paladins of level 80 or above may drink this fluid."
	},
	[8473] = { -- ultimate health potion
		health = {5200, 6800},
		vocations = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24},
		flask = 0,
		description = "Only knights of level 130 or above may drink this fluid."
	},
	[8474] = { -- antidote potion
		antidote = true,
		flask = 0,
	},
	[8704] = { -- small health potion
		health = {120, 180},
		flask = 0,
	},
	[26029] = { -- ultimate mana potion
		mana = {3400, 4600},
		vocations = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24},
		flask = 0,
		description = "Only druids and sorcerers of level 130 or above may drink this fluid."
	},
	[26030] = { -- ultimate spirit potion
		health = {3360, 4640},
		mana = {1600, 2800},
		vocations = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24},
		flask = 0,
		description = "Only paladins of level 130 or above may drink this fluid."
	},
	[26031] = { -- supreme health potion
		health = {7000, 9000},
		vocations = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24},
		flask = 0,
		description = "heals health 7000-9000."
	}
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if type(target) == "userdata" and not target:isPlayer() then
		return false
	end

	local potion = potions[item:getId()]
	if potion.level and player:getLevel() < potion.level or potion.vocations and not table.contains(potion.vocations, player:getVocation():getId()) then
		player:say(potion.description, TALKTYPE_MONSTER_SAY)
		return true
	end

	if potion.condition then
		player:addCondition(potion.condition)
		player:say(potion.text, TALKTYPE_MONSTER_SAY)
		player:getPosition():sendMagicEffect(potion.effect)
	elseif potion.transform then
		local reward = potion.transform[math.random(#potion.transform)]
		if fromPosition.x == CONTAINER_POSITION then
			local targetContainer = Container(item:getParent().uid)
			targetContainer:addItem(reward, 1)
		else
			Game.createItem(reward, 1, fromPosition)
		end
		item:getPosition():sendMagicEffect(potion.effect)
		item:remove(1)
		return true
	else
		if potion.health then
			doTargetCombat(player, target, COMBAT_HEALING, potion.health[1], potion.health[2])
		end

		if player:getExtraHealing() then
			extraheal = player:getExtraHealing() / 100
			if potion.mana and player:getExtraHealing() >= 1 then
				doTargetCombat(player, target, COMBAT_MANADRAIN, potion.mana[1] * extraheal, potion.mana[2] * extraheal)
			end
		end

		if potion.mana then
			doTargetCombat(player, target, COMBAT_MANADRAIN, potion.mana[1], potion.mana[2])
		end

		if potion.antidote then
			target:removeCondition(CONDITION_POISON)
		end

		player:addAchievementProgress("Potion Addict", 100000)
		player:addItem(potion.flask)
		target:say("Aaaah...", TALKTYPE_MONSTER_SAY)
		target:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
	end

	if not configManager.getBoolean(configKeys.REMOVE_POTION_CHARGES) then
		return true
	end

	item:remove(1)
	return true
end
