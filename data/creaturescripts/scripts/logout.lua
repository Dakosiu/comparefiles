function onLogout(player)
	if player:getStorageValue(85489) > os.time() and not player:getGroup():getAccess() then
		player:sendTextMessage(MESSAGE_STATUS_WARNING, "You need to wait 3 seconds before logout")
		return false
	end

	local playerId = player:getId()
	if nextUseStaminaTime[playerId] then
		nextUseStaminaTime[playerId] = nil
	end
	return true
end
