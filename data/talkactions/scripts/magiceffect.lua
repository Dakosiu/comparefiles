function onSay(player, words, param)
	if not player:getGroup():getAccess() and player:getAccountType() < ACCOUNT_TYPE_GOD  then
		return true
	end

	player:getPosition():sendMagicEffect(tonumber(param))
	return false
end
