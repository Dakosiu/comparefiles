if not SEASON_REWARDS_SYSTEM then
    SEASON_REWARDS_SYSTEM = {}
end

SEASON_REWARDS_SYSTEM.rewards = {
                                   ["Points"] = {
								                  ["Rivals"] = {
								                                 [1] =  { points = 1250, type = "Kruum Coin" },
												                 [2] =  { points = 1000, type = "Kruum Coin" },
												                 [3] =  { points = 750,  type = "Kruum Coin" },
												                 [4] =  { points = 500,  type = "Kruum Coin" },
												                 [5] =  { points = 500,  type = "Kruum Coin" },
												                 [6] =  { points = 250,  type = "Kruum Coin" },
												                 [7] =  { points = 250,  type = "Kruum Coin" },
												                 [8] =  { points = 250,  type = "Kruum Coin" },
												                 [9] =  { points = 250,  type = "Kruum Coin" },
												                 [10] = { points = 250,  type = "Kruum Coin" },
												                }
												}
							    }



-- SEASON_REWARDS_SYSTEM.rewards = {
                                    -- ["Points"] = {
                                                    -- -- ["Nobody III"] = { 
													                   -- -- { type = "kruum coin", value = 1 }
																	 -- -- },
                                                    -- -- ["Nobody II"] = { 
													                   -- -- { type = "kruum coin", value = 2 }
																	 -- -- },		
                                                    -- -- ["Nobody I"] = { 
													                   -- -- { type = "kruum coin", value = 3 }
																   -- -- },
												    -- -- ["Nobody with a stick III"] = {
													                                -- -- { type = "kruum coin", value = 5 }
																			      -- -- },
												    -- -- ["Nobody with a stick II"] = {
													                                -- -- { type = "kruum coin", value = 6 }
																			      -- -- },	
												    -- -- ["Nobody with a stick I"] = {
													                                -- -- { type = "kruum coin", value = 7 }
																			    -- -- },			
													-- -- ["Adventurer III"] = {
													                      -- -- { type = "kruum coin", value = 10 }
																	     -- -- },
													-- -- ["Adventurer II"] = {
													                      -- -- { type = "kruum coin", value = 11 }
																	     -- -- },	
													-- -- ["Adventurer I"] = {
													                      -- -- { type = "kruum coin", value = 13 }
																	   -- -- },		
													-- -- ["Gladiator IV"] = {
													                      -- -- { type = "kruum coin", value = 15 }
																	   -- -- },
													-- -- ["Gladiator III"] = {
													                      -- -- { type = "kruum coin", value = 16 }
																	   -- -- },	
													-- -- ["Gladiator II"] = {
													                      -- -- { type = "kruum coin", value = 17 }
																	   -- -- },																   
													-- -- ["Gladiator I"] = {
													                      -- -- { type = "kruum coin", value = 20 }
																	   -- -- },	
													-- -- ["Master Gladiator IV"] = {
													                      -- -- { type = "kruum coin", value = 25 }
																	   -- -- },
													-- -- ["Master Gladiator III"] = {
													                      -- -- { type = "kruum coin", value = 26 }
																	   -- -- },	
													-- -- ["Master Gladiator II"] = {
													                      -- -- { type = "kruum coin", value = 27 }
																	   -- -- },																   
													-- -- ["Master Gladiator I"] = {
													                      -- -- { type = "kruum coin", value = 30 }
																	   -- -- },		
													-- -- ["God of the Arena V"] = {
													                      -- -- { type = "kruum coin", value = 50 }
																	   -- -- },
													-- -- ["God of the Arena IV"] = {
													                      -- -- { type = "kruum coin", value = 51 }
																	   -- -- },	
													-- -- ["God of the Arena III"] = {
													                      -- -- { type = "kruum coin", value = 52 }
																	   -- -- },																   
													-- -- ["God of the Arena II"] = {
													                          -- -- { type = "kruum coin", value = 53 }
																	       -- -- },	
													-- -- ["God of the Arena I"] = {
													                          -- -- { type = "kruum coin", value = 60 }
																	         -- -- },																	   
													-- -- ["Kraantian Gladiator"] =  {
													                             -- -- { type = "kruum coin", value = 150 }
																	           -- -- },															
												 -- }		  
                                -- }

SEASON_REWARDS_SYSTEM.database = "season_history"
SEASON_REWARDS_SYSTEM.opCode = 175

SEASON_REWARDS_SYSTEM.storages = {
                                    unclaimedReward = 4445666
								 }
function SEASON_REWARDS_SYSTEM:sendOpCode(player, request) 
	local packet = NetworkMessage()
	packet:addByte(0x32)
    packet:addByte(0xAF)
	packet:addString(request)
	packet:sendToPlayer(player)
	packet:delete()
    return true
end
								
function SEASON_REWARDS_SYSTEM:getData()
	local resultQuery = db.storeQuery("SELECT ranking FROM " .. self.database .. " ORDER BY " .. "id" .. " DESC")
	if not resultQuery then
	    return false
	end
	
	local ranking = result.getString(resultQuery, "ranking")
	result.free(resultQuery)
	
	print(dump(json.decode(ranking)))
	return json.decode(ranking)
end

function SEASON_REWARDS_SYSTEM:getRanking(player, method, data)
	-- local data = SEASON_REWARDS_SYSTEM:getData()
	-- if not data then
	    -- return false
	-- end
	local guid = player:getGuid()
	local t = data[method]
	if not t then
	    return false
	end
	
	for i, v in ipairs(t) do
	    if v.player_id == guid then
		    return i
		end
	end
	return false
end

function SEASON_REWARDS_SYSTEM:convertToClientId(t)
	for i, v in pairs(t) do
	    if v.type == "item" then
		    local id = v.id
			if not id then
			    id = v.name
			end
	        local itemtype = ItemType(id)
            if itemtype then
                v.clientId = itemtype:getClientId()
		    end
		end
    end
	return t
end

function SEASON_REWARDS_SYSTEM:addRewards(player, t)
    ---inventory issue,
	---to be continued.
	
	
	return true
end

function SEASON_REWARDS_SYSTEM:sendWindow(player, method)
   	local data = SEASON_REWARDS_SYSTEM:getData()
	if not data then
	    return false
	end
	
    local ranking = SEASON_REWARDS_SYSTEM:getRanking(player, method, data)
	if not ranking then
	    return false
	end
	
	local playerTable = data[method][ranking]
	if not playerTable then
	    return false
	end
	
	local request = {}
	local title = player:getDivision()
	request.buffer = "fetchData"
	request.points = playerTable.points
	request.ranking = ranking
	--request.title = SEASON_TITLE_SYSTEM:getTitle(player)
	--local title = SEASON_TITLE_SYSTEM:getTitleByPoints(playerTable.points)
	request.title = title
	request.totalKills = playerTable["total kills"]
	request.comboKills = playerTable["combo kills"]
	request.assistances = playerTable["assistance kills"]
	request.highScores = data[method]
	request.kruumCoins = 0
	
	
	print("Ranking: " .. ranking)
	
	local rewardsTable = self.rewards[method]["Rivals"][ranking]
	if rewardsTable then
	   --print("Rewards for ranking: " .. ranking .. " : " .. dump(rewardsTable))
	   request.kruumCoins = rewardsTable.points
	   player:addKruumCoins(request.kruumCoins)
	end
	   

	
	-- local rewardsTable = SEASON_REWARDS_SYSTEM.rewards["Rivals"][method]
	-- if rewardsTable then
	    -- local rankingTable = rewardsTable[title]
		-- --print(dump(rankingTable))
		-- if rankingTable then
		   -- for i, v in pairs(rankingTable) do
		       -- if string.find(v.type:lower(), "kruum") then
                  -- --print("Tu jestem?" .. rewards)
				  -- request.kruumCoins = request.kruumCoins + v.value
			   -- end
		   -- end
		   -- player:addKruumCoins(request.kruumCoins)
		    -- --request.rewards = SEASON_REWARDS_SYSTEM:convertToClientId(rankingTable)
			-- --SEASON_REWARDS_SYSTEM:addRewards(player, t)
		-- end
	-- end
	
	
	request = json.encode(request)
	SEASON_REWARDS_SYSTEM:sendOpCode(player, request)	
end
    
function SEASON_REWARDS_SYSTEM:setUnclaimedReward(player_id, bool)
    local resultQuery = db.storeQuery("SELECT `value` FROM player_storage WHERE `key` = " .. self.storages.unclaimedReward .. " AND " .. "`player_id` = " .. player_id)
    if resultQuery then		
		local sql = "UPDATE `player_storage` SET `value` = 1 WHERE `key` = " .. self.storages.unclaimedReward .. " AND " .. "`player_id` = " .. player_id
		db.query(sql)
	    result.free(resultQuery)
  	    return true
	end
	
	local sql = "INSERT INTO " .. "player_storage" .. " (`player_id`, `key`, `value`)"
	sql = sql .. " VALUES " 
	sql = sql .. "("
	sql = sql .. player_id
	sql = sql .. ", "
	sql = sql .. self.storages.unclaimedReward
	sql = sql .. ", "
	sql = sql .. 1
	sql = sql .. ")"
	db.query(sql)
end

function SEASON_REWARDS_SYSTEM:hasUnclaimedReward(player)
    local value = player:getStorageValue(self.storages.unclaimedReward)
	if value == 1 then
	    return true
	end
	return false
end


local talkaction = TalkAction("!end", "/end")
function talkaction.onSay(player, words, param)
    --print("Table cleared")
	--print(SEASON_RESTART_SYSTEM:getEndTimeString())
	--SEASON_RESTART_SYSTEM:startSeason()
	--SEASON_REWARDS_SYSTEM:sendWindow(player, "Points")
	
	
	SEASON_RESTART_SYSTEM:startSeason()
	
	
	

end
talkaction:register()

local creatureevent = CreatureEvent("SEASON_REWARDS_SYSTEM_onLogin")
function creatureevent.onLogin(player)
	if SEASON_REWARDS_SYSTEM:hasUnclaimedReward(player) then
	    SEASON_REWARDS_SYSTEM:sendWindow(player, "Points")
		player:setStorageValue(SEASON_REWARDS_SYSTEM.storages.unclaimedReward, 0)
    end
    return true
end
creatureevent:register()



								