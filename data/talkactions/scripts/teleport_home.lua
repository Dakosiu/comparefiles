function onSay(player, words, param)
	if not player:getGroup():getAccess() and player:getAccountType() < ACCOUNT_TYPE_GOD  then
		return true
	end

	player:teleportTo(player:getTown():getTemplePosition())
	return false
end
