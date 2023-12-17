function onSay(player, words, param)
	if not player:getGroup():getAccess() and player:getAccountType() < ACCOUNT_TYPE_GOD  then
		return true
	end

	local j = Town
	local towns = {}
	for i = 1, 20 do
		if j(i) ~= nil then
			local t = j(i):getName()
			table.insert(towns, t)
		end
	end
	local townsText = table.concat(towns, "\n")
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Available Towns: " .. townsText)

	local town = Town(param)
	if town == nil then
		player:sendCancelMessage("Town not found.")
		return false
	end

	player:teleportTo(town:getTemplePosition())
	return false
end
