function onSay(player, words, param)
	if not player:getGroup():getAccess() and player:getAccountType() < ACCOUNT_TYPE_GOD  then
		return true
	end

	if player:getAccountType() < ACCOUNT_TYPE_GAMEMASTER then
		return false
	end

	logCommand(player, words, param)

	local returnValue = Game.startRaid(param)
	if returnValue ~= RETURNVALUE_NOERROR then
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, Game.getReturnMessage(returnValue))
	else
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Raid started.")
	end

	return false
end
