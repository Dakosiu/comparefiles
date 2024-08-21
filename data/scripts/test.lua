local talk = TalkAction("/points", "!points")

function talk.onSay(player, words, param)
    -- --DAILY_SYSTEM:addProgress(player, "Weekly")
	DAILY_SYSTEM:addComboProgress(player, 2)
	-- DAILY_SYSTEM:sendProgress(player)
	
	for i = 1, 15 do
	    DAILY_SYSTEM:addProgress(player, "Daily")
	end
	DAILY_SYSTEM:sendProgress(player)
	
	print("Combo Progress1: " .. DAILY_SYSTEM:getComboProgress(player, 1))
	print("Combo Progress2: " .. DAILY_SYSTEM:getComboProgress(player, 2))
	print("Combo Progress3: " .. DAILY_SYSTEM:getComboProgress(player, 3))
	--local t = POINTS_SYSTEM.earnPoints["Kokao Warrior"]
	--POINTS_SYSTEM:generatePoints(player, 25, t)
	--POINTS_SYSTEM:generatePoints(player, 100000, t)
	--POINTS_SYSTEM:generateRewards(player, 750, storeIndex[1].offers[1])
	
	return false
end

talk:separator(" ")
talk:register()
