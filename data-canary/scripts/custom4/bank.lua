local exhaust_table = "PLAYERS_EXHAUST_BANK"
local exh = { type = "hour", value = 2 }



local bank = TalkAction("!bank")

function bank.onSay(player, words, param)

	if dakosLib:getExhaust(exhaust_table, player) then
	   player:sendCancelMessage("You are exhausted. You have to wait: " .. dakosLib:getExhaustString(exhaust_table, player))
	   return false
	end
	
	local params = param:lower():gsub(" ", ""):split(",")
	if table.contains({"deposit", "depositall", "deposit all"}, params[1]) then
		if table.contains({"deposit all", "depositall"}, params[1]) or params[2] == "all" then
			local money = player:getMoney()

			if money > 0 then
				player:removeMoney(money)
				player:setBankBalance(player:getBankBalance() + money)
				player:sendCancelMessage("You deposited " .. money .. " gold.")
				dakosLib:setExhaust(exhaust_table, player, exh.type, exh.value)
			else
				player:sendCancelMessage("You don't have that much gold.")
			end
		elseif type(tonumber(params[2])) == 'number' then
			local value = tonumber(params[2])
			if not player:removeMoney(value) then
				player:sendCancelMessage("You don't have that much gold.")
			else
				player:setBankBalance(player:getBankBalance() + value)
				player:sendCancelMessage("You deposited " .. value .. " gold.")
				dakosLib:setExhaust(exhaust_table, player, exh.type, exh.value)
			end
		else
			player:sendCancelMessage("Usage: !bank deposit, value | !bank deposit, all")
		end
	elseif table.contains({"withdraw", "withdrawall", "withdraw all"}, params[1]) then
		local money = player:getBankBalance()
		if table.contains({"withdraw all", "withdrawall"}, params[1]) or params[2] == "all" then
			player:setBankBalance(0)
			player:addMoney(money)
			dakosLib:setExhaust(exhaust_table, player, exh.type, exh.value)
			player:sendCancelMessage("You retrieved " .. money .. " gold.")
		elseif type(tonumber(params[2])) == 'number' then
			local value = tonumber(params[2])
			if money >= value then
				player:setBankBalance(money - value)
				player:addMoney(value)
				player:sendCancelMessage("You retrieved " .. value .." gold.")
				dakosLib:setExhaust(exhaust_table, player, exh.type, exh.value)
			else
				player:sendCancelMessage("You don't have enough balance.")
			end
		else
			player:sendCancelMessage("Usage: !bank withdraw, value | !bank withdraw, all")
		end
	else
		player:sendCancelMessage("Usage:\n!bank deposit, value | !bank deposit, all\n!bank withdraw, value | !bank withdraw, all")
	end
	return false
end

bank:separator(" ")
bank:register()