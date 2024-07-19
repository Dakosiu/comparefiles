local POINTS_REWARDS = {
	[1] = 100,
	[2] = 50,
	[3] = 25,
}
TOTAL_PLAYERS_REWARDED = 0

local STORAGE = 5512

local advancePoints = CreatureEvent("advancePoints")
function advancePoints.onAdvance(player, skill, oldLevel, newLevel)
	if skill ~= SKILL_LEVEL or newLevel <= oldLevel then
		return true
	end
	
	if TOTAL_PLAYERS_REWARDED >= 3 then return true end
	if newLevel >= 500 then
		TOTAL_PLAYERS_REWARDED = TOTAL_PLAYERS_REWARDED + 1
		if player:getStorageValue(STORAGE) < 1 then
		   player:addTibiaCoins(POINTS_REWARDS[TOTAL_PLAYERS_REWARDED])
		   player:setStorageValue(STORAGE, 1)
		   Game.broadcastMessage(player:getName() .. " is the player number " .. TOTAL_PLAYERS_REWARDED .. " to get to level 500! He got " .. POINTS_REWARDS[TOTAL_PLAYERS_REWARDED] .. " points!")
		end
	end
	
	return true
end
advancePoints:register()

local advancePointsStartup = GlobalEvent("advancePointsStartup")
function advancePointsStartup.onStartup()
	local query = db.storeQuery("SELECT COUNT(*) FROM players WHERE level >= 500")
	if query then
		TOTAL_PLAYERS_REWARDED = result.getNumber(query, "COUNT(*)")
	else
		TOTAL_PLAYERS_REWARDED = 0
	end
	return true
end
advancePointsStartup:register()