if not CHEST_SYSTEM then
    CHEST_SYSTEM = {}
	CHEST_SYSTEM.players = {}
end

CHEST_SYSTEM.database = "players_chests"

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function CHEST_SYSTEM:addChest(player, storeTable)
    
	if not self.players[player:getGuid()] then
	    self.players[player:getGuid()] = {}
	end
	

	
	local tableId = storeTable.id
	local name = storeTable.name
	
	if not self.players[player:getGuid()][name] then
	    self.players[player:getGuid()][name] = {}
	end
	
	local chestTable = POINTS_SYSTEM.chests[tableId]
	local requiredCoins = chestTable["Cost"]
	
	local finalRewardTable = {}
	
	--print(dump(chestTable))
	
	local usedPoints = 0
	local t = {}
	local start = true
	while usedPoints < requiredCoins and start do
	    for i, v in pairs(POINTS_SYSTEM.coins) do
		    local points = POINTS_SYSTEM:getCoins(player, i)
			--points = math.random(1, 500)
			local random_points = math.random(0, points)
			local pointsLeft = requiredCoins - usedPoints
			
			if random_points > pointsLeft then
			    random_points = pointsLeft
			end

			local left = requiredCoins - random_points
			local percentage = ((left - requiredCoins) / requiredCoins)
			percentage = tonumber(string.format("%.3f", percentage))
			percentage = percentage * 100
			percentage = math.abs(percentage)
			if not t[i] then
				t[i] = {}
				t[i].percentage = 0
				t[i].points = 0
			end
			t[i].percentage = t[i].percentage + percentage
			t[i].points = t[i].points + random_points
			usedPoints = usedPoints + random_points
			
			if usedPoints == requiredCoins then
			    start = false
				break
			end
			
		end
    end
	
	local t2 = {}
	for i, v in pairs(t) do
	    v.name = i
		table.insert(t2, v)
	end
	
	table.sort(t2, function(a, b) return a.points < b.points end)	
	
	local countTable = chestTable["Rewards Count"]
	
	local rewardsCount = math.random(countTable.min, countTable.max)
	--print("Rewards Count: " .. rewardsCount)
	local rewards = 0
	while rewards < rewardsCount do
	    for i, v in ipairs(t2) do
		    local className = v.name
			local percentage = v.percentage
			local classTable = chestTable["Materials"][className]
			if classTable then
			    local rand = math.random(0, 100)
				--print("Rand: " .. rand)
				--print("Chance: " .. percentage)
				if rand <= percentage then
				    --print("Wylosowano Class: " .. className .. ".")
				    local rewardTable = classTable[math.random(1, #classTable)]
					local id = rewardTable.id
					local countT = rewardTable.count
					local minCount = countT.min
					local maxCount = countT.max
					local count = math.random(minCount, maxCount)
					
					--print("Reward:" .. getItemName(id) .. " Count: " .. count)
					--player:addToInventory(id, count)
					if not finalRewardTable["ItemID " .. id] then
					    finalRewardTable["ItemID " .. id] = {}
						finalRewardTable["ItemID " .. id].id = id
						finalRewardTable["ItemID " .. id].count = 0
						finalRewardTable["ItemID " .. id].name = getItemName(id)
					end
					finalRewardTable["ItemID " .. id].count = finalRewardTable["ItemID " .. id].count + count
					rewards = rewards + 1
					
					
					
				end
			end
		end
	end
	
	
	for i, v in ipairs(t2) do
	    POINTS_SYSTEM:removeCoins(player, v.name, v.points)
	end
	
	
	
	
	                --["Chest" .. tablelength(self.players[player:getGuid()][name]) + 1] = finalRewardTable

    self.players[player:getGuid()][name]["Chest" .. tablelength(self.players[player:getGuid()][name]) + 1] = finalRewardTable

					
	--table.insert(self.players[player:getGuid()][name], values)
	
	
	CHEST_SYSTEM:savePlayer(player:getGuid(), player:getName())
	
	
	--print(dump(self.players))
end

function CHEST_SYSTEM:getChestsCount(player, name)
    local id = player:getGuid()
	if not self.players[id] then
	    return 0
	end

	if not self.players[id][name] then
	    return 0
	end
	
	return tablelength(self.players[id][name])
end

function CHEST_SYSTEM:getChestByIndex(player, name, index)
	local id = player:getGuid()
	if not self.players[id] then
	    return false
	end

	if not self.players[id][name] then
	    return false
	end
	
	return self.players[id][name]["Chest" .. index]
end

function CHEST_SYSTEM:removeChestByIndex(player, name, index)
	local id = player:getGuid()
	if not self.players[id] then
	    return false
	end
	self.players[id]["Chest" .. index] = nil
end

function CHEST_SYSTEM:sendAction(player, data)
	local packet = NetworkMessage()
    packet:addByte(0x32)
    packet:addByte(0xCA)
    packet:addString(data)
    packet:sendToPlayer(player)
    packet:delete()
end

function CHEST_SYSTEM:openChest(player, index, ammount)
    local t = storeIndex[1].offers[index]
	
	if not t then
	    print("This chest has no table yet, return.")
		return
	end	
	
	local name = t.name
	
	
	if self:getChestsCount(player, name) < ammount then
	    return
	end
	
	local rewardsCount = 0
	local i = 1
	local rewards = {}
	while rewardsCount ~= ammount do
	    local chestTable = self.players[player:getGuid()][name]["Chest" .. i]
		if chestTable then
		    for z, b in pairs(chestTable) do 
			    local id = b.id
			    local count = b.count
				local name = b.name
	            --print("Chest:" .. i .. ": " .. "Dodano: " .. count .. "x " .. "ID: " .. id)
				if not rewards[z] then
			       rewards[z] = {}
			       rewards[z].count = 0
				   rewards[z].name = name
			       rewards[z].id = id
			    end
			    rewards[z].count = rewards[z].count + count
		    end
		    self.players[player:getGuid()][name]["Chest" .. i] = nil
			rewardsCount = rewardsCount + 1
		end
		i = i + 1
		
	end

	for i, v in pairs(rewards) do
	    player:addToInventory(v.id, v.count)
	end
	
	
	print("Name: " .. t.name)
	player:sendChestRewards(rewards, t.name)
	player:sendAttributes(player)
	self:savePlayer(player:getGuid(), player:getName())
end

function CHEST_SYSTEM:savePlayer(guid, name)
    
	local t = self.players[guid]
	if not t then
	    return false
	end
	
	t = json.encode(t)
	
	--print("T:" .. t)
	local resultQuery = db.storeQuery("SELECT `id`, `chests` FROM " .. self.database .. " WHERE `id` = " .. guid)
	local sql = nil
	if resultQuery then
	    sql = "UPDATE " .. self.database .. " SET"
		sql = sql .. " `chests` = " .. db.escapeString(t)
        sql = sql .. " WHERE " .. "`id` = " .. guid
        db.query(sql)
	    result.free(resultQuery)
		return true
	end
	
	sql = "INSERT INTO " .. self.database .. " (`id`, `name`, `chests`)"
    sql = sql .. " VALUES " 
    sql = sql .. "("
	sql = sql .. guid
	sql = sql .. ", "
    sql = sql .. db.escapeString(name)
	sql = sql .. ", "
	sql = sql .. db.escapeString(t)
	sql = sql .. ")"
	db.query(sql)
	return true
end
    
function CHEST_SYSTEM:fetchDatabase()
    if not self.players then
	    self.players = {}
    end
	
	local resultQuery = db.storeQuery("SELECT `id`, `chests` FROM " .. self.database)
	if resultQuery ~= false then
	   repeat
	   local chests = result.getDataString(resultQuery, "chests")
	   local guid = result.getNumber(resultQuery, "id")
	   self.players[guid] = json.decode(chests)
	   until not result.next(resultQuery)
	end
	
	print(">> Chest System v1.0 - Loaded.")
	
	--print(dump(self.players))
end

local globalevent = GlobalEvent("load_CHEST_SYSTEM")
function globalevent.onStartup()
    CHEST_SYSTEM:fetchDatabase()
end
globalevent:register()

-- local creatureevent = CreatureEvent("CHEST_SYSTEM_onOpCode")
-- function creatureevent.onExtendedOpcode(player, opcode, buffer)
    -- if opcode ~= 202 then
	    -- print("Tu return?")
        -- return true
    -- end		
	
	-- local t = json.decode(buffer)
	-- if t.buffer == "updateChests" then
	    -- local actionName = "updateChests"
	    -- local data = {}
	    -- data.buffer = actionName
	    -- data.data = { ["Wooden Chest"] = 4, ["Bronze Chest"] = 6, ["Artifact Chest"] = 2 }
	    -- data = json.encode(data)
	    -- CHEST_SYSTEM:sendAction(player, data)
	-- end

    -- return true
-- end
-- creatureevent:register()

-- creatureevent = CreatureEvent("CHEST_SYSTEM_onLogin")
-- function creatureevent.onLogin(player)
    -- player:registerEvent("CHEST_SYSTEM_onOpCode")
    -- return true
-- end
-- creatureevent:register()


	
    
	
	