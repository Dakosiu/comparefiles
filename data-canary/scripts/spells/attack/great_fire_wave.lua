local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITBYFIRE)

local area = createCombatArea(AREA_WAVE7, AREADIAGONAL_WAVE7)
combat:setArea(area)

local combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat2:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITBYFIRE)
combat2:setParameter(COMBAT_PARAM_CRITDAMAGE, WheelOfDestiny.SpecialConviction[VOCATION.BASE_ID.SORCERER].Augmented_Great_Fire_Wave.Crit_Damage)
combat2:setArea(area)

function onGetFormulaValues(player, level, maglevel)
	local min = (level / 5) + (maglevel * 2.8) + 16
	local max = (level / 5) + (maglevel * 4.4) + 28 -- TODO: Formulas (TibiaWiki says ~Strong Flame Strike but we need more acurracy)
	if table.contains({1}, player:getVocation():getBaseId()) and player:getStorageValue(WheelOfDestiny.SpecialConviction[player:getVocation():getBaseId()].Focus_Mastery.Time_Storage) + WheelOfDestiny.SpecialConviction[player:getVocation():getBaseId()].Focus_Mastery.Duration >= os.time() then
		min = min * WheelOfDestiny.SpecialConviction[player:getVocation():getBaseId()].Focus_Mastery.Amplification
		max = max * WheelOfDestiny.SpecialConviction[player:getVocation():getBaseId()].Focus_Mastery.Amplification
		player:setStorageValue(WheelOfDestiny.SpecialConviction[player:getVocation():getBaseId()].Focus_Mastery.Time_Storage, -1)
	end
	return -min, -max
end
function onGetFormulaValues2(player, level, maglevel)
	local min = (level / 5) + (maglevel * 2.8) + 16
	local max = (level / 5) + (maglevel * 4.4) + 28 -- TODO: Formulas (TibiaWiki says ~Strong Flame Strike but we need more acurracy)
	if table.contains({1}, player:getVocation():getBaseId()) and player:getStorageValue(WheelOfDestiny.SpecialConviction[player:getVocation():getBaseId()].Focus_Mastery.Time_Storage) + WheelOfDestiny.SpecialConviction[player:getVocation():getBaseId()].Focus_Mastery.Duration >= os.time() then
		min = min * WheelOfDestiny.SpecialConviction[player:getVocation():getBaseId()].Focus_Mastery.Amplification
		max = max * WheelOfDestiny.SpecialConviction[player:getVocation():getBaseId()].Focus_Mastery.Amplification
		player:setStorageValue(WheelOfDestiny.SpecialConviction[player:getVocation():getBaseId()].Focus_Mastery.Time_Storage, -1)
	end
	
	if player:getWheelOfDestinyPerksFlag(WheelOfDestiny.SpecialConviction[player:getVocation():getBaseId()].Augmented_Great_Fire_Wave) == 2 then
		min = min * WheelOfDestiny.SpecialConviction[player:getVocation():getBaseId()].Augmented_Great_Fire_Wave.Amplification
		max = max * WheelOfDestiny.SpecialConviction[player:getVocation():getBaseId()].Augmented_Great_Fire_Wave.Amplification
	end
	return -min, -max
end
combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")
combat2:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues2")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	if creature:isPlayer() and creature:getWheelOfDestinyPerksFlag(WheelOfDestiny.SpecialConviction[creature:getVocation():getBaseId()].Augmented_Great_Fire_Wave) >= 1 then
		return combat2:execute(creature, var)
	end
	return combat:execute(creature, var)
end

spell:group("attack")
spell:id(240)
spell:name("Great Fire Wave")
spell:words("exevo gran flam hur")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_GREAT_FIRE_WAVE)
spell:level(38)
spell:mana(120)
spell:isPremium(true)
spell:needDirection(true)
spell:cooldown(4 * 1000)
spell:groupCooldown(2 * 1000)
spell:needLearn(false)
spell:vocation("sorcerer;true", "master sorcerer;true")
spell:register()