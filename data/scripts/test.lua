local talk = TalkAction("/points", "!points")

function talk.onSay(player, words, param)
	
	--local t = POINTS_SYSTEM.earnPoints["Kokao Warrior"]
	--POINTS_SYSTEM:generatePoints(player, 25, t)
	POINTS_SYSTEM:generateRewards(player, 750, storeIndex[1].offers[1].materials)
	
	return false
end

talk:separator(" ")
talk:register()
