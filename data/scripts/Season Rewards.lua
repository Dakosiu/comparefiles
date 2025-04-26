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
												                },
								                  ["Kills"] = {
								                                 [1] =  { 
																          { type = "chest", name = "Artifact Chest", count = 20 },
																		  { type = "chest", name = "Bronze Chest", count = 24 },
																          { type = "chest", name = "Wooden Chest", count = 36 },
																		},
								                                 [2] =  { 
																          { type = "chest", name = "Artifact Chest", count = 12 },
																		  { type = "chest", name = "Bronze Chest", count = 20 },
																          { type = "chest", name = "Wooden Chest", count = 36 },
																		},		
								                                 [3] =  { 
																          { type = "chest", name = "Artifact Chest", count = 8 },
																		  { type = "chest", name = "Bronze Chest", count = 16 },
																          { type = "chest", name = "Wooden Chest", count = 36 },
																		},																		
								                                 [4] =  { 
																          { type = "chest", name = "Artifact Chest", count = 6 },
																		  { type = "chest", name = "Bronze Chest", count = 8 },
																          { type = "chest", name = "Wooden Chest", count = 18 },
																		},	
								                                 [5] =  { 
																          { type = "chest", name = "Artifact Chest", count = 5 },
																		  { type = "chest", name = "Bronze Chest", count = 8 },
																          { type = "chest", name = "Wooden Chest", count = 18 },
																		},	
								                                 [6] =  { 
																          { type = "chest", name = "Artifact Chest", count = 4 },
																		  { type = "chest", name = "Bronze Chest", count = 8 },
																          { type = "chest", name = "Wooden Chest", count = 18 },
																		},		
								                                 [7] =  { 
																          { type = "chest", name = "Artifact Chest", count = 3 },
																		  { type = "chest", name = "Bronze Chest", count = 6 },
																          { type = "chest", name = "Wooden Chest", count = 12 },
																		},		
								                                 [8] =  { 
																          { type = "chest", name = "Artifact Chest", count = 3 },
																		  { type = "chest", name = "Bronze Chest", count = 6 },
																          { type = "chest", name = "Wooden Chest", count = 12 },
																		},		
								                                 [9] =  { 
																          { type = "chest", name = "Artifact Chest", count = 3 },
																		  { type = "chest", name = "Bronze Chest", count = 6 },
																          { type = "chest", name = "Wooden Chest", count = 12 },
																		},		
								                                 [10] =  { 
																          { type = "chest", name = "Artifact Chest", count = 3 },
																		  { type = "chest", name = "Bronze Chest", count = 6 },
																          { type = "chest", name = "Wooden Chest", count = 12 },
																		},																			
												              },																
																
												}
							    }

SEASON_REWARDS_SYSTEM.database = "season_history"
SEASON_REWARDS_SYSTEM.opCode = 148

SEASON_REWARDS_SYSTEM.storages = {
                                    unclaimedReward = 4445666
								 }

function SEASON_REWARDS_SYSTEM:sendOpCode(player, data)
	local packet = NetworkMessage()
	packet:addByte(0x32)
    packet:addByte(0x94)
	packet:addString(data)
	packet:sendToPlayer(player)
	packet:delete()
    return true
end

function SEASON_REWARDS_SYSTEM:addRewards(player, rewards)
	
	local kruumCoin = rewards.kruum
	if kruumCoin and kruumCoin > 0 then
	    player:addKruumCoins(kruumCoin)
	end
	
	local woodenChest = rewards.woodenChest
	if woodenChest and woodenChest > 0 then
	    local storeTable = storeIndex[1].offers[1]
		for i = 1, woodenChest do
	        CHEST_SYSTEM:addChest(player, storeTable)
		end
	end
	
	local bronzeChest = rewards.bronzeChest
	if bronzeChest and bronzeChest > 0 then
	    local storeTable = storeIndex[1].offers[2]
		for i = 1, bronzeChest do
	        CHEST_SYSTEM:addChest(player, storeTable)
		end
	end	
	
	
	local artifactChest = rewards.artifactChest
	if artifactChest and artifactChest > 0 then
	    local storeTable = storeIndex[1].offers[3]
		for i = 1, artifactChest do
	        CHEST_SYSTEM:addChest(player, storeTable)
		end
	end	
	
	
	
end
	
	

function SEASON_REWARDS_SYSTEM:getRewardsTable(place, method)
    if method == "Points" then
	    method = "Rivals"
	end
    if not SEASON_REWARDS_SYSTEM.rewards["Points"][method] then
	    return false
	end

    local t = SEASON_REWARDS_SYSTEM.rewards["Points"][method][place]
	if not t then
	    return false
	end
	local kruum = 0
	if method == "Rivals" then
	    kruum = kruum + t.points
	end
	local woodenChest = 0
	local bronzeChest = 0
	local artifactChest = 0
    local nft = 0
	
	if method ~= "Rivals" then
	    for i, v in pairs(t) do
	        if v.name == "Wooden Chest" then
		        woodenChest = woodenChest + v.count
		    elseif v.name == "Bronze Chest" then
		        bronzeChest = bronzeChest + v.count
		    elseif v.name == "Artifact Chest" then
		        artifactChest = artifactChest + v.count
		    end
		end
	end
	
	local t2 = {}
	t2.kruum = kruum
	t2.woodenChest = woodenChest
	t2.bronzeChest = bronzeChest
	t2.artifactChest = artifactChest
	t2.nft = nft
	
	return t2
end
	
	


function SEASON_REWARDS_SYSTEM:sendWindow(player, method)
    if method == "Rivals" or method == "Points" then
	    local buffer = "request_top10Rivals"
		local rankingData = SEASON_REWARDS_SYSTEM:getData()
		if not rankingData then
		    return true
		end
				
		rankingData = rankingData["Points"]
		table.sort(rankingData, function(a, b) return a.points > b.points end)
		
		local t = {}
		
		t.buffer = buffer
		t.data = {}
		
		for i, v in ipairs(rankingData) do
		    t.data[i] = {}
			t.data[i].points = v.points
			t.data[i].name = v.name
			t.data[i].rewardsTable = SEASON_REWARDS_SYSTEM:getRewardsTable(i, "Rivals")
		end
		SEASON_REWARDS_SYSTEM:sendOpCode(player, json.encode(t))	    
		return true
	end
	
	if method == "Kills" then
	    local buffer = "request_top10Kills"
		local rankingData = SEASON_REWARDS_SYSTEM:getData()
		if not rankingData then
		    return true
		end
		rankingData = rankingData["Kills"]
		table.sort(rankingData, function(a, b) return a.kills > b.kills end)
		
		local t = {}
		
		t.buffer = buffer
		t.data = {}
		
		for i, v in ipairs(rankingData) do
		    t.data[i] = {}
			t.data[i].name = v.name
			t.data[i].kruum = 0
			t.data[i].rewardsTable = SEASON_REWARDS_SYSTEM:getRewardsTable(i, "Kills")
        end
		SEASON_REWARDS_SYSTEM:sendOpCode(player, json.encode(t))    
		return true
	end
	
	
end
    
	
	
	
	
function SEASON_REWARDS_SYSTEM:getData()
	local resultQuery = db.storeQuery("SELECT ranking FROM " .. self.database .. " ORDER BY " .. "id" .. " DESC")
	if not resultQuery then
	    return false
	end
	
	local ranking = result.getString(resultQuery, "ranking")
	result.free(resultQuery)
	return json.decode(ranking)
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

local creatureevent = CreatureEvent("SEASON_REWARDS_SYSTEM.onOpCode")
function creatureevent.onExtendedOpcode(player, opcode, buffer)
    if opcode ~= 148 then
	    return true
	end
	
	local data = json.decode(buffer)
	if data.buffer == "request_top10Rivals" then
        SEASON_REWARDS_SYSTEM:sendWindow(player, "Rivals")
		return true
	end
	if data.buffer == "request_top10Kills" then
        SEASON_REWARDS_SYSTEM:sendWindow(player, "Kills")
		return true
	end
    return true
end
creatureevent:register()

creatureevent = CreatureEvent("SEASON_REWARDS_SYSTEM.onLogin")
function creatureevent.onLogin(player)
    player:registerEvent("SEASON_REWARDS_SYSTEM.onOpCode")
	
	-- if SEASON_REWARDS_SYSTEM:hasUnclaimedReward(player) then
	    -- SEASON_REWARDS_SYSTEM:sendWindow(player, "Points", "Rivals")
		-- player:setStorageValue(SEASON_REWARDS_SYSTEM.storages.unclaimedReward, 0)
    -- end
	
	return true
end
creatureevent:register()