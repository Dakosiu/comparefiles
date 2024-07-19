local combat1 = Combat()
combat1:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat1:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
combat1:setParameter(COMBAT_PARAM_USECHARGES, 1)

local combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat2:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
combat2:setParameter(COMBAT_PARAM_USECHARGES, 1)

function onGetFormulaValues1(player, skill, attack, factor)
	local level = player:getLevel()
	
	local min = (level / 5) + (skill + attack) * 1
	local max = (level / 5) + (skill + attack) * 1.5

	return -min * 1.1, -max * 1.1 -- TODO : Use New Real Formula instead of an %
end

combat1:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues1")

function onGetFormulaValues2(player, skill, attack, factor)
	local level = player:getLevel()
	
	local min = (level / 5) + (skill + attack) * 1
	local max = (level / 5) + (skill + attack) * 1.5
	local level = player:getWheelOfDestinyRevelationLevel(WheelOfDestiny.Revelation.Executioners_Throw.SIDE)
	if level then
		local data = WheelOfDestiny.Revelation.Executioners_Throw[level]
		min = min * data.amplification
		max = max * data.amplification
	end

	return -min * 1.1, -max * 1.1 -- TODO : Use New Real Formula instead of an %
end

combat2:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues2")

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYISCALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_DRAWBLOOD)
combat:setParameter(COMBAT_PARAM_MAXCHAINRANGE, 3)

function onTargetCreature(player, target)
	if target:getHealth()/target:getMaxHealth() <= 0.3 then
		combat2:execute(player, Variant(target:getId()))
	else
		combat1:execute(player, Variant(target:getId()))
	end
	return true
end

combat:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

local spell = Spell("instant")

function spell.onCastSpell(player, var, isHotkey)
	local target = Creature(var:getNumber())
	if target then
		local level = player:getWheelOfDestinyRevelationLevel(WheelOfDestiny.Revelation.Executioners_Throw.SIDE)
		if level then
			local data = WheelOfDestiny.Revelation.Executioners_Throw[level]
			local targetPos = target:getPosition()
			combat:setParameter(COMBAT_PARAM_MAXTARGETS, data.targets)
			return combat:execute(player, var)
		end
	end
	return false
end

function getCooldown(player)
	local cooldown = WheelOfDestiny.Revelation.Executioners_Throw.FIRST_LEVEL.cooldown
	local level = player:getWheelOfDestinyRevelationLevel(WheelOfDestiny.Revelation.Executioners_Throw.SIDE)
	if level then
		cooldown = WheelOfDestiny.Revelation.Executioners_Throw[level].cooldown
	end
	return cooldown
end

spell:group("attack")
spell:id(WheelOfDestiny.Revelation.Executioners_Throw.ID)
spell:name(WheelOfDestiny.Revelation.Executioners_Throw.SPELL)
spell:words(WheelOfDestiny.Revelation.Executioners_Throw.WORDS)
spell:level(300)
spell:mana(225)
spell:range(3)
spell:needTarget(true)
spell:blockWalls(true)
spell:needWeapon(true)
spell:cooldown(WheelOfDestiny.Revelation.Executioners_Throw.FIRST_LEVEL.cooldown)
spell:setCallback(CALLBACK_SPELL_COOLDOWN, "getCooldown")
spell:groupCooldown(2 * 1000)
spell:vocation("knight;true", "elite knight;true")
spell:needLearn(true)
spell:register()