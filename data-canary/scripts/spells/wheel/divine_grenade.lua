local area = createCombatArea(AREA_CIRCLE2X2)

local spell = Spell("instant")

function spell.onCastSpell(player, var, isHotkey)
	local target = Creature(var:getNumber())
	if target then
		local level = player:getWheelOfDestinyRevelationLevel(WheelOfDestiny.Revelation.Divine_Grenade.SIDE)
		if level then
			local data = WheelOfDestiny.Revelation.Divine_Grenade[level]
			local targetPos = target:getPosition()
			player:getPosition():sendDistanceEffect(targetPos, CONST_ANI_SMALLHOLY)
			targetPos:sendMagicEffect(CONST_ME_DIVINE_GRENADE)
			addEvent(function(pid, min, max)
				targetPos:removeMagicEffect(CONST_ME_DIVINE_GRENADE)
				if Player(pid) then
					doAreaCombatHealth(Player(pid), COMBAT_HOLYDAMAGE, targetPos, area, min, max, WheelOfDestiny.Revelation.Divine_Grenade.EFFECT)
				end
			end, WheelOfDestiny.Revelation.Divine_Grenade.DELAY, player:getId(), -((player:getLevel() / 5 + player:getMagicLevel() * 6 + 60) * data.amplification), -((player:getLevel() / 5 + player:getMagicLevel() * 8 + 90) * data.amplification))
			return true
		end
	end
	return false
end

function getCooldown(player)
	local cooldown = WheelOfDestiny.Revelation.Divine_Grenade.FIRST_LEVEL.cooldown
	local level = player:getWheelOfDestinyRevelationLevel(WheelOfDestiny.Revelation.Divine_Grenade.SIDE)
	if level then
		cooldown = WheelOfDestiny.Revelation.Divine_Grenade[level].cooldown
	end
	return cooldown
end

spell:group("support")
spell:id(WheelOfDestiny.Revelation.Divine_Grenade.ID)
spell:name(WheelOfDestiny.Revelation.Divine_Grenade.SPELL)
spell:words(WheelOfDestiny.Revelation.Divine_Grenade.WORDS)
spell:level(300)
spell:mana(160)
spell:needTarget(true)
spell:blockWalls(true)
spell:cooldown(WheelOfDestiny.Revelation.Divine_Grenade.FIRST_LEVEL.cooldown)
spell:setCallback(CALLBACK_SPELL_COOLDOWN, "getCooldown")
spell:groupCooldown(2 * 1000)
spell:vocation("paladin;true", "royal paladin;true")
spell:needLearn(true)
spell:register()