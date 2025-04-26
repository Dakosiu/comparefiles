-- CREATE TABLE `server_status` (
  -- `day` varchar(255) NOT NULL DEFAULT '',
  -- `restarted` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  -- `players` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin CHECK (json_valid(`players`))
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- INSERT INTO `server_status` (`day`, `restarted`, `players`) VALUES ('not set', '0', '{}');
if not DAILY_SYSTEM then
    DAILY_SYSTEM = {}
end

DAILY_SYSTEM.storages = {
                            ["Daily"] = {
							              [1] = 312111,
										  [2] = 312112,
										},
							["Weekly"] = {
							                [1] = 312113,
											[2] = 312114
										 },
							["Combo"] = {
							                [1] = 312115,
											[2] = 312116,
											[3] = 312117
										}
						}
						

DAILY_SYSTEM.progress = {
                            ["Daily"] = 312118,
							["Weekly"] = 312119,
						}
						
DAILY_SYSTEM.combo = {
                        [1] = 312120,
                        [2] = 312121,
                        [3] = 312122
                     }						

DAILY_SYSTEM.chests = {
                        ["Daily"] = {
                                        [1] = { type = "Wooden Chest", requiredProgress = 15 },
                                        [2] = { type = "Wooden Chest", requiredProgress = 30 }
                                    },
                        ["Weekly"] = {
                                        [1] = { type = "Wooden Chest", requiredProgress = 7 },
                                        [2] = { type = "Wooden Chest", requiredProgress = 14 }
                                     },
						["Combo"] = {
						                [1] = { type = "Wooden Chest", requiredCombo = 1 },
                                        [2] = { type = "Bronze Chest", requiredCombo = 1 },  
										[3] = { type = "Artifact Chest", requiredCombo = 1 },
									}
                      }									

-- DAILY_SYSTEM.missions = { 
                            -- ["Daily"] = {
							                -- [1] = 15,
											-- [2] = 30
										-- },
							-- ["Weekly"] = {
							                -- [1] = 7,
											-- [2] = 14
										 -- }
						-- }





function DAILY_SYSTEM:restart(player, method)
    for i, v in pairs(self.storages[method]) do
	    player:setStorageValue(v, -1)
	end
	
	local t = self.progress[method]
	if t then
	    player:setStorageValue(t, -1)
	end
	-- for i, v in pairs(self.progress[method]) do
	    -- player:setStorageValue(v, -1)
	-- end
	
	if method == "Combo" then
	    for i, v in pairs(self.combo) do
		    player:setStorageValue(v, -1)
		end
	end
end
    


function DAILY_SYSTEM:getComboId(player, value)
    if value > 4 and value < 7 then
	    return 1
    end
	
	if value > 6 and value < 9 then
	    return 2
	end
	
	if value >= 9 then
	    return 3
	end
	return 0
end
	
function DAILY_SYSTEM:getComboProgress(player, id)
    local key = self.combo[id]
	local value = player:getStorageValue(key)
	if value < 0 then
	    value = 0
	end
	return value
end

function DAILY_SYSTEM:getProgress(player, type)
    local key = self.progress[type]
	local value = player:getStorageValue(key)
	if value < 0 then
	    value = 0
	end
	return value
end

function DAILY_SYSTEM:addComboProgress(player, id)
    local key = self.combo[id]
	local value = self:getComboProgress(player, id)
	player:setStorageValue(key, value + 1)
	value = self:getComboProgress(player, id)
	
	
	local comboTable = self.chests["Combo"][id]
	local requiredCombo = comboTable.requiredCombo
	if value >= requiredCombo then
	    if self:getClaimStatus(player, "Combo", id) ~= 1 then
	        self:setClaimChestStatus(player, "Combo", id, 1)
	    end
	end
	
	
	-- for i, v in pairs(self.chests["Combo"]) do
	    -- if value >= v.requiredCombo then
		    -- print("Index: " .. i)
			-- print("Required Combo: " .. v.requiredCombo)
		    -- if self:getClaimStatus(player, "Combo", i) ~= 1 then
			    -- self:setClaimChestStatus(player, "Combo", i, 1)
			-- end
		-- end
	-- end	
end

function DAILY_SYSTEM:removeComboProgress(player, id)
    local key = self.combo[id]
	local value = self:getComboProgress(player, id)
	player:setStorageValue(key, value - 1)
	value = self:getComboProgress(player, id)
end
	
	-- local comboTable = self.chests["Combo"][id]
	-- local requiredCombo = comboTable.requiredCombo
	-- if value >= requiredCombo then
	    -- if self:getClaimStatus(player, "Combo", id) ~= 1 then
	        -- self:setClaimChestStatus(player, "Combo", id, 1)
	    -- end
	-- end

function DAILY_SYSTEM:addProgress(player, type)
    local key = self.progress[type]
	local value = self:getProgress(player, type)
	player:setStorageValue(key, value + 1)
	
	value = self:getProgress(player, type) 
	--print("Value: " .. value)
	--print("Type: " .. type)
	for i, v in pairs(self.chests[type]) do
	    ---print("I : " .. i)
	    --print("Table: " .. dump(v))
	    if value >= v.requiredProgress then
		    --print("Status Claimed: " .. self:getClaimStatus(player, type, i))
		    if self:getClaimStatus(player, type, i) ~= 1 and self:getClaimStatus(player, type, i) ~= 2 then
			    self:setClaimChestStatus(player, type, i, 1)
			end
		end
	end
	
end

function DAILY_SYSTEM:restartProgress(player, type)
    local key = self.progress[type]
	player:setStorageValue(key, -1)
end

function DAILY_SYSTEM:isClaimed(player, type, id)
    local key = self.storages[type][id]
	local value = player:getStorageValue(key)
	if value == 2 then
	    return true
	end
	return false
end

function DAILY_SYSTEM:findChestTableByName(name)
    for i, v in pairs(storeIndex[1].offers) do
	    if v.name:lower() == name:lower() then
		    return v
		end
	end
    return false
end

function DAILY_SYSTEM:setClaimChestStatus(player, type, id, value)
    local key = self.storages[type][id]
	player:setStorageValue(key, value)
end	 

function DAILY_SYSTEM:getStoreTableByName(name)
	for i, v in pairs(storeIndex[1].offers) do
	    if v.name:lower() == name:lower() then
		    return v
		end
	end
	print("Store Table Not Found!")
    return false
end

local vocTable = {
                    [1] = "Kaer Disciple",
					[2] = "Jade Mystic",
					[3] = "Shepherd of Aureh",
					[4] = "Kokao Warrior"
				 }
function DAILY_SYSTEM:claimChest(player, type, id, name)
    if self:isClaimed(player, type, id) and type ~= "Combo" then
	    return
	end
	
	-- local chestTable = self:findChestTableByName(name)	
	-- local chestId = chestTable.id
	
	local storeTable = self:getStoreTableByName(name)
	if not storeTable then
	    return
	end
    local cost = storeTable.price
	local t = POINTS_SYSTEM.earnPoints[vocTable[math.random(1, #vocTable)]]
	POINTS_SYSTEM:generatePoints(player, cost, t)
	CHEST_SYSTEM:addChest(player, storeTable)
	--player:addChestCount(chestId, 1)
	if type == "Daily" then
	    self:addProgress(player, "Weekly")
	end
	
	if type == "Combo" then
		DAILY_SYSTEM:removeComboProgress(player, id)
	end
	
	
    local key = self.storages[type][id]
	player:setStorageValue(key, 2)
	player:sendClaimedChest(storeTable.name, storeTable.image2)
	player:sendAttributes(player)
end

function DAILY_SYSTEM:getClaimStatus(player, type, id)
    local key = self.storages[type][id]
	local value = player:getStorageValue(key)
	if value < 0 then
	    value = 0
	end
	
	return value
end

-- function DAILY_SYSTEM:claimChest(player, type, id)
    -- local key = self.storages[type][id]
	-- player:setStorageValue(key, 2)
	-- --addChest(player)
-- end

function DAILY_SYSTEM:restartClaimChest(player, type, id)
    local key = self.storages[type][id]
	player:setStorageValue(key, -1)
end

function DAILY_SYSTEM:sendOpCode(player, data)
    local packet = NetworkMessage()
	packet:addByte(0x32)
    packet:addByte(0x70) 
	packet:addString(data)
	packet:sendToPlayer(player)
	packet:delete()
end

function DAILY_SYSTEM:sendProgress(player)
    local t = {}
	t.buffer = "send_Informations"
	t.data = {}
	t.data["Progress"] = {}
	t.data["Chests"] = {}
	t.data["Combo"] = {}
	for i, v in pairs(self.progress) do
	    t.data["Progress"][i] = self:getProgress(player, i)
	end
	
	for i,v in ipairs(self.combo) do
	    --print("Value: " .. self:getComboProgress(player, i)) 
	    t.data["Combo"][i] = self:getComboProgress(player, i)
		
	end
	
	for i, v in pairs(self.chests) do
	    t.data["Chests"][i] = {}
		for z, b in pairs(v) do
		    t.data["Chests"][i][z] = {}
			t.data["Chests"][i][z].name = b.type
			t.data["Chests"][i][z].claimed = self:getClaimStatus(player, i, z)
			if b.requiredProgress then
			    t.data["Chests"][i][z].requiredProgress = b.requiredProgress
			end
			if b.requiredCombo then
			    t.data["Chests"][i][z].requiredCombo = b.requiredCombo
			end
			-- if self:isClaimed(player, i, z) then
			    -- t.data["Chests"][i][z].claimed = 1
			-- end
		end
	end
    self:sendOpCode(player, json.encode(t))
	return true
end

if not DAILY_RESTARTER then
    DAILY_RESTARTER = {}
end

function DAILY_RESTARTER:setDay(value)
    local sql = "UPDATE `server_status` SET `day` = " .. db.escapeString(value)
    db.query(sql)
	
	self.day = value
end

function DAILY_RESTARTER:getDay()
    return self.day
end

function DAILY_RESTARTER:setRestarted(value)
	if not value then
	    value = 0
	else
	    value = 1
	end
	
    local sql = "UPDATE `server_status` SET `restarted` = " .. value 
    db.query(sql)
	self.restarted = value
end

function DAILY_RESTARTER:getRestarted()
    if self.restarted then
	    return self.restarted
	end
   	local resultQuery = db.storeQuery("SELECT restarted FROM `server_status`")
	if resultQuery then	
	    local restarted = result.getDataInt(resultQuery, "restarted")
	    result.free(resultQuery)
        self.restarted = restarted
		return restarted
	end
	return 0
end
	
function DAILY_RESTARTER:checkDay()
   	local resultQuery = db.storeQuery("SELECT day FROM `server_status`")
	if resultQuery then
	    local day = result.getDataString(resultQuery, "day")
		local currentDay = os.date("%A")
		if day ~= currentDay then
		    self:setRestarted(false)
			self:setDay(currentDay)
			self:resetPlayers()
		end
		if not DAILY_RESTARTER.day then
		    self.day = day
		end
		result.free(resultQuery)
	end
end

function scheduleRestart()
	if DAILY_RESTARTER:getRestarted() == 1 then
	    return true
	end
	
	local configTime = getConfigInfo('dailyRestart')
	configTime = configTime:gsub(":", "")
	configTime = tonumber(configTime)
	
	local currentTime = os.date("%H:%M")
	currentTime = currentTime:gsub(":", "")
	currentTime = tonumber(currentTime)
	
	
	local weeklyDay = getConfigInfo('weeklyRestart')
	local currentDay = os.date("%A")
	
	if currentTime >= configTime then
	    local players = Game.getPlayers()
	    for _, player in ipairs(players) do
	        --DAILY_TASK_MONSTER_SYSTEM:restartTasks(player)
			DAILY_SYSTEM:restart(player, "Daily")
			if currentDay == weeklyDay then
			    DAILY_SYSTEM:restart(player, "Weekly")
			end
			DAILY_RESTARTER:addPlayer(player:getName())
	    end
	    Game.broadcastMessage("Daily Missions has been restarted.", MESSAGE_GAME_HIGHLIGHT)
		print("Restart Daily!")
		--DAILY_TASK_MONSTER_SYSTEM.dailyRestarted = true
		
		DAILY_RESTARTER:setRestarted(true)
		DAILY_RESTARTER:savePlayers()
	    return true
	end
	
	addEvent(scheduleRestart, 10000)
end

function DAILY_RESTARTER:resetPlayers()
    local sql = "UPDATE `server_status` SET `players` = " .. db.escapeString("{}")
    db.query(sql)
	self:fetchPlayers()
end

function DAILY_RESTARTER:fetchPlayers()
    local resultQuery = db.storeQuery("SELECT players FROM `server_status`")
	if resultQuery then
		self.players = json.decode(result.getDataString(resultQuery, "players"))
	end
end
	
function DAILY_RESTARTER:addPlayer(name)
	if self:isAdded(name) then
	    return false
	end
	self.players[name] = true
end

function DAILY_RESTARTER:savePlayers()
    local sql = "UPDATE `server_status` SET `players` = " .. db.escapeString(json.encode(self.players))
    db.query(sql)   
end

function DAILY_RESTARTER:isAdded(name)
    if not self.players then
	    return false
	end
	return self.players[name]
end

local globalevent = GlobalEvent("load_DAILY_RESTARTER")
function globalevent.onStartup()
	DAILY_RESTARTER:checkDay()
	DAILY_RESTARTER:fetchPlayers()
	scheduleRestart()
end
globalevent:register()

local creatureevent = CreatureEvent('onLogin_DAILY_RESTARTER')
function creatureevent.onLogin(player)
    if DAILY_RESTARTER:getRestarted() == 1 then
	    local name = player:getName()
	    if not DAILY_RESTARTER:isAdded(name) then
		    --DAILY_TASK_MONSTER_SYSTEM:restartTasks(player)
			--DAILY_RESTARTER:processRestart()
			DAILY_SYSTEM:restart(player, "Daily")
			DAILY_RESTARTER:addPlayer(name)
			DAILY_RESTARTER:savePlayers()
		end
	end
	player:registerEvent("DAILY_SYSTEM_onOpCode")
	return true
end
creatureevent:register()

creatureevent = CreatureEvent("DAILY_SYSTEM_onOpCode")
function creatureevent.onExtendedOpcode(player, opcode, buffer)
	if opcode ~= 112 then
	    return true
	end
	local data = json.decode(buffer)
	
	if data.buffer == "displayWindow" then
	    DAILY_SYSTEM:sendProgress(player)
		return true
	end
	
	if data.buffer == "sendClaimChest" then
		local type = data.type
	    local name = data.name
		local id = data.id
		
		print("Type: " .. type)
		print("Name: " .. name)
		print("Id: " .. id)
	    DAILY_SYSTEM:claimChest(player, type, id, name)
		--DAILY_SYSTEM:sendProgress(player)
		return true
	end
    return true
end
creatureevent:register()

-- creatureevent = CreatureEvent("TASK_SYSTEM_onLogin")
-- function creatureevent.onLogin(player)
    -- player:registerEvent("TASK_SYSTEM_onOpCode")
    -- return true
-- end
-- creatureevent:register()
	
	




