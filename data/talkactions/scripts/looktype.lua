function onSay(player, words, param)
	if not player:getGroup():getAccess() and player:getAccountType() < ACCOUNT_TYPE_GOD  then
		return true
	end

	local lookType = tonumber(param)
	if lookType <= 2200 then
		local playerOutfit = player:getOutfit()
		playerOutfit.lookType = lookType
		player:setOutfit(playerOutfit)
	else
		player:sendCancelMessage("A look type with that id does not exist.")
	end
	return false
end