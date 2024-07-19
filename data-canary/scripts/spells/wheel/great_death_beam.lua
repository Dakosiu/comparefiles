local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
combat:setParameter(COMBAT_PARAM_ISBEAM, true)
combat:setArea(createCombatArea(WheelOfDestiny.Revelation.Great_Death_Beam.FIRST_LEVEL.area))

local combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combat2:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
combat2:setParameter(COMBAT_PARAM_ISBEAM, true)
combat2:setArea(createCombatArea(WheelOfDestiny.Revelation.Great_Death_Beam.SECOND_LEVEL.area))

local combat3 = Combat()
combat3:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combat3:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
combat3:setParameter(COMBAT_PARAM_ISBEAM, true)
combat3:setArea(createCombatArea(WheelOfDestiny.Revelation.Great_Death_Beam.THIRD_LEVEL.area))

function onGetFormulaValues(player, level, maglevel)
	local min = (level / 5) + (maglevel * 4)
	local max = (level / 5) + (maglevel * 7)
	if table.contains({1}, player:getVocation():getBaseId()) and player:getStorageValue(WheelOfDestiny.SpecialConviction[player:getVocation():getBaseId()].Focus_Mastery.Time_Storage) + WheelOfDestiny.SpecialConviction[player:getVocation():getBaseId()].Focus_Mastery.Duration >= os.time() then
		min = min * WheelOfDestiny.SpecialConviction[player:getVocation():getBaseId()].Focus_Mastery.Amplification
		max = max * WheelOfDestiny.SpecialConviction[player:getVocation():getBaseId()].Focus_Mastery.Amplification
		player:setStorageValue(WheelOfDestiny.SpecialConviction[player:getVocation():getBaseId()].Focus_Mastery.Time_Storage, -1)
	end
	min = min * WheelOfDestiny.Revelation.Great_Death_Beam.FIRST_LEVEL.amplification
	max = max * WheelOfDestiny.Revelation.Great_Death_Beam.FIRST_LEVEL.amplification
	return -min*1.2, -max*1.2
end
function onGetFormulaValues2(player, level, maglevel)
	local min = (level / 5) + (maglevel * 4)
	local max = (level / 5) + (maglevel * 7)
	if table.contains({1}, player:getVocation():getBaseId()) and player:getStorageValue(WheelOfDestiny.SpecialConviction[player:getVocation():getBaseId()].Focus_Mastery.Time_Storage) + WheelOfDestiny.SpecialConviction[player:getVocation():getBaseId()].Focus_Mastery.Duration >= os.time() then
		min = min * WheelOfDestiny.SpecialConviction[player:getVocation():getBaseId()].Focus_Mastery.Amplification
		max = max * WheelOfDestiny.SpecialConviction[player:getVocation():getBaseId()].Focus_Mastery.Amplification
		player:setStorageValue(WheelOfDestiny.SpecialConviction[player:getVocation():getBaseId()].Focus_Mastery.Time_Storage, -1)
	end
	min = min * WheelOfDestiny.Revelation.Great_Death_Beam.SECOND_LEVEL.amplification
	max = max * WheelOfDestiny.Revelation.Great_Death_Beam.SECOND_LEVEL.amplification
	return -min*1.2, -max*1.2
end
function onGetFormulaValues3(player, level, maglevel)
	local min = (level / 5) + (maglevel * 4)
	local max = (level / 5) + (maglevel * 7)
	if table.contains({1}, player:getVocation():getBaseId()) and player:getStorageValue(WheelOfDestiny.SpecialConviction[player:getVocation():getBaseId()].Focus_Mastery.Time_Storage) + WheelOfDestiny.SpecialConviction[player:getVocation():getBaseId()].Focus_Mastery.Duration >= os.time() then
		min = min * WheelOfDestiny.SpecialConviction[player:getVocation():getBaseId()].Focus_Mastery.Amplification
		max = max * WheelOfDestiny.SpecialConviction[player:getVocation():getBaseId()].Focus_Mastery.Amplification
		player:setStorageValue(WheelOfDestiny.SpecialConviction[player:getVocation():getBaseId()].Focus_Mastery.Time_Storage, -1)
	end
	min = min * WheelOfDestiny.Revelation.Great_Death_Beam.THIRD_LEVEL.amplification
	max = max * WheelOfDestiny.Revelation.Great_Death_Beam.THIRD_LEVEL.amplification
	return -min*1.2, -max*1.2
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")
combat2:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues2")
combat3:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues3")

function getCooldown(player)
	local cooldown = WheelOfDestiny.Revelation.Great_Death_Beam.FIRST_LEVEL.cooldown
	local level = player:getWheelOfDestinyRevelationLevel(WheelOfDestiny.Revelation.Great_Death_Beam.SIDE)
	if level then
		return WheelOfDestiny.Revelation.Great_Death_Beam[level].cooldown
	end
	return cooldown
end

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local level = creature:getWheelOfDestinyRevelationLevel(WheelOfDestiny.Revelation.Great_Death_Beam.SIDE)
	if level then
		if level == "THIRD_LEVEL" then
			return combat3:execute(creature, var)
		elseif level == "SECOND_LEVEL" then
			return combat2:execute(creature, var)
		elseif level == "FIRST_LEVEL" then
			return combat:execute(creature, var)
		end
	end
	return false
end

spell:group("attack", "greatbeams")
spell:id(WheelOfDestiny.Revelation.Great_Death_Beam.SPELLID)
spell:name(WheelOfDestiny.Revelation.Great_Death_Beam.SPELL)
spell:words("exevo max mort")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_GREAT_ENERGY_BEAM)
spell:level(300)
spell:mana(WheelOfDestiny.Revelation.Great_Death_Beam.MANA)
spell:isPremium(false)
spell:needDirection(true)
spell:blockWalls(true)
spell:cooldown(WheelOfDestiny.Revelation.Great_Death_Beam.FIRST_LEVEL.cooldown)
spell:setCallback(CALLBACK_SPELL_COOLDOWN, "getCooldown")
spell:groupCooldown(2 * 1000, WheelOfDestiny.Revelation.Great_Death_Beam.GROUPCOOLDOWN)
spell:needLearn(false)
spell:vocation("sorcerer;true", "master sorcerer;true")
spell:register()
