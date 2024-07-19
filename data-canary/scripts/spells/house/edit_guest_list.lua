local spell = Spell("instant")

function spell.onCastSpell(player, variant)
	local house = player:getTile():getHouse()
	if not house then
		return false
	end

	if house:canEditAccessList(GUEST_LIST, player) then
	   print(GUEST_LIST)
	   
		player:setEditHouse(house, GUEST_LIST)
		player:sendHouseWindow(house, GUEST_LIST)
		print("Access List: " .. house:getAccessList(GUEST_LIST))
	else
		player:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
	end
	return true
end

spell:name("House Guest List")
spell:words("aleta sio")
spell:isAggressive(false)
spell:register()
