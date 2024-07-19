local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_DIVINE_EMPOWERMENT)
combat:setArea(createCombatArea(AREA_SQUARE1X1))

local spell = Spell("instant")

function spell.onCastSpell(player, var, isHotkey)
	local pos = player:getPosition()
	for x = pos.x - 1, pos.x + 1 do
		for y = pos.y - 1, pos.y + 1 do
			addEvent(function(pos, effect)
				pos:removeMagicEffect(effect)
			end, WheelOfDestiny.Revelation.Divine_Empowerment.DURATION, Position(x, y, pos.z), CONST_ME_DIVINE_EMPOWERMENT)
		end
	end
	local level = player:getWheelOfDestinyRevelationLevel(WheelOfDestiny.Revelation.Divine_Empowerment.SIDE)
	if level then
		local data = WheelOfDestiny.Revelation.Divine_Empowerment[level]
		WheelOfDestiny.Revelation.Divine_Empowerment.PLAYERS[player:getId()] = {os.time() + WheelOfDestiny.Revelation.Divine_Empowerment.DURATION/1000, data.amplification, player:getPosition()}
		addEvent(function(pid)
			WheelOfDestiny.Revelation.Divine_Empowerment.PLAYERS[pid] = nil
		end, WheelOfDestiny.Revelation.Divine_Empowerment.DURATION, player:getId())
	end
	return combat:execute(player, var)
end

function getCooldown(player)
	local cooldown = WheelOfDestiny.Revelation.Divine_Empowerment.FIRST_LEVEL.cooldown
	local level = player:getWheelOfDestinyRevelationLevel(WheelOfDestiny.Revelation.Divine_Empowerment.SIDE)
	if level then
		cooldown = WheelOfDestiny.Revelation.Divine_Empowerment[level].cooldown
	end
	return cooldown
end

spell:group("support")
spell:id(WheelOfDestiny.Revelation.Divine_Empowerment.ID)
spell:name(WheelOfDestiny.Revelation.Divine_Empowerment.SPELL)
spell:words(WheelOfDestiny.Revelation.Divine_Empowerment.WORDS)
spell:level(300)
spell:mana(500)
spell:isSelfTarget(true)
spell:cooldown(WheelOfDestiny.Revelation.Divine_Empowerment.FIRST_LEVEL.cooldown)
spell:setCallback(CALLBACK_SPELL_COOLDOWN, "getCooldown")
spell:groupCooldown(2 * 1000)
spell:vocation("paladin;true", "royal paladin;true")
spell:needLearn(true)
spell:register()