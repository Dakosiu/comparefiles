if not QUEUE_ROOM_SYSTEM then
    QUEUE_ROOM_SYSTEM = {}
end
local evconfig = EVENTS_CONFIG
function QUEUE_ROOM_SYSTEM:sendOpCode(player, request) 
	local packet = NetworkMessage()
	packet:addByte(0x32)
    packet:addByte(0xF2)
	packet:addString(request)
	packet:sendToPlayer(player)
	packet:delete()
    return true
end

function QUEUE_ROOM_SYSTEM:addPlayer(eventName, roomID, player, vocation)
    
	-- if not self.events then
	    -- self.events = {}
	-- end
	
	-- if not self.events[eventName] then
	    -- self.events[eventName] = {}
	-- end
	
	-- if not self.events[eventName][roomID] then
	    -- self.events[eventName][roomID] = {}
	-- end
	
	if QUEUE_ROOM_SYSTEM:getPlayerEvent(player) then
	    return false
	end
	
	if not self.events[eventName][roomID].queuePlayers then
	    self.events[eventName][roomID].queuePlayers = {}
	end
	
	local index = math.random(1, self:getMaxParticipants(eventName))
	while self.events[eventName][roomID].queuePlayers[index] do
	    index = math.random(1, self:getMaxParticipants(eventName))
	end
	
	self.events[eventName][roomID].queuePlayers[index] = { ["id"] = player:getId(), ["name"] = player:getName(), ["vocation"] = vocation, ["index"] = index  }
	self:addPlayerToQueue(eventName, roomID, player)
	self:updateQueue(eventName, roomID)
	return true
end

function QUEUE_ROOM_SYSTEM:addPlayerToQueue(eventName, roomID, player)

    if QUEUE_ROOM_SYSTEM:getPlayerEvent(player) then
	    return false
	end
	
	if not self.queuePlayers then
	    self.queuePlayers = {}
	end
	
	if not self.queuePlayers[eventName] then
	    self.queuePlayers[eventName] = {}
	end
	
	if not self.queuePlayers[eventName][roomID] then
	    self.queuePlayers[eventName][roomID] = {}
	end
	
	self.queuePlayers[eventName][roomID][player:getId()] = true
	self:setPlayerEvent(eventName, roomID, player)
    local t = {}
	t.buffer = "displayWindow"
	t.data = {}
	t.data.maxParticipants = self:getMaxParticipants(eventName)
	t.data.countPlayers = #self:getPlayers(eventName, roomID)
	t.data.eventName = eventName

	self:sendOpCode(player, json.encode(t))
	return true
	---self.queuePlayers[player:getId()] = { ["eventName"] = eventName, ["room"] = roomID }
end

function QUEUE_ROOM_SYSTEM:getPlayerQueue(player)
    if not self.queuePlayers then
	    return false
	end
	
	for i, v in pairs(self.queuePlayers) do
	    if i == player:getId() then
		    return v
		end
	end
	return false
end

function QUEUE_ROOM_SYSTEM:updateQueue(eventName, roomID)
    if not self.queuePlayers then
	    return false
	end
	local t = self.queuePlayers[eventName][roomID]
	if not t then
	    return false
	end
	
	for i, v in pairs(t) do
	    local player = Player(i)
		if player then
		    local t = {}
			t.buffer = "fetchData"
			t.data = {}
			t.data.maxParticipants = self:getMaxParticipants(eventName)
			t.data.countPlayers = #self:getPlayers(eventName, roomID)
		    self:sendOpCode(player, json.encode(t))
		end
	end
	return false
end
    
function QUEUE_ROOM_SYSTEM:getPlayerTable(eventName, roomID, player)
    for i, v in pairs(self.events[eventName][roomID].queuePlayers) do
	    if v["id"] == player:getId() then
		    return v
		end
	end
    return false
end

function QUEUE_ROOM_SYSTEM:getPlayerTableIndex(eventName, roomID, player)
    if not self.events then
	    return false
	end
	
	if not self.events[eventName] then
	    return false
	end
	
	if not self.events[eventName][roomID] then
	    return false
	end
	
	local t = self.events[eventName][roomID].queuePlayers
	if not t then
	    return false
	end
	
    for i, v in pairs(t) do
	    if v["id"] == player:getId() then
		    return i
		end
	end
    return false
end

function QUEUE_ROOM_SYSTEM:getRooms(eventName)
    if not self.rooms then
	    self.rooms = {}
	end
	if not self.rooms[eventName] then
	   self.rooms[eventName] = {}
	end
	
	return self.rooms[eventName]
end

function QUEUE_ROOM_SYSTEM:removeRoom(eventName, roomID)
    if not self.rooms then
	    return false
	end
	
	if not self.rooms[eventName] then
	    return false
	end
	
	if not self.rooms[eventName][roomID] then
	    return false
	end	
    --print("Event Name: " .. eventName)
	--print("Event Room ID: " .. roomID)
	
	local name = self.rooms[eventName][roomID].name
	self.rooms[name][roomID] = nil
	--print("USUNIETE: " .. dump(self.rooms))
end

function QUEUE_ROOM_SYSTEM:getRoom(eventName, roomID)
    return self.events[eventName][roomID]
end

function QUEUE_ROOM_SYSTEM:setActive(eventName, roomID, boolean)
    self.events[eventName][roomID].Active = boolean
end

function QUEUE_ROOM_SYSTEM:getMaxParticipants(eventName)
    
	if not self.maxParticipants then
	    self.maxParticipants = {}
	end
	
	if self.maxParticipants[eventName] then
	    return self.maxParticipants[eventName]
	end
	
	for i, v in pairs(EVENTS_CONFIG.rooms) do
	    if v.name:lower() == eventName:lower() then
	       self.maxParticipants[eventName] = #v.players
		   return self.maxParticipants[eventName]
		end
	end
	
	return 0
end

function QUEUE_ROOM_SYSTEM:addRoom(eventName, index, room)
	if not self.events then
	    self.events = {}
	end
	
	if not self.events[eventName] then
	    self.events[eventName] = {}
	end
	
	room.ID = #self.events[eventName] + 1
	room.RealID = index
	room.player = {}
	table.insert(self.events[eventName], room)
end

function QUEUE_ROOM_SYSTEM:selectRoom(eventName, player)
	if eventName == "1 vs 1" or eventName == "Rival" then
	    local rooms = self:getRooms(eventName)
		local maxParticipants = self:getMaxParticipants(eventName)
		for i, v in ipairs(rooms) do
		    local players = QUEUE_ROOM_SYSTEM:getPlayers(eventName, i)
		    if players and #players < maxParticipants then
			    return v
		    end
		end
		rooms = self:getRooms("Rival")
		maxParticipants = self:getMaxParticipants("Rival")
		for i, v in ipairs(rooms) do
		    local players = QUEUE_ROOM_SYSTEM:getPlayers("Rival", i)
		    if players and #players < maxParticipants then
			    return v
		    end
		end		
		
		local rand = math.random(1, 2)
		if rand == 2 then
		    eventName = "Rival"
		end
	end
	
    local maxParticipants = self:getMaxParticipants(eventName)
	
	local rooms = self:getRooms(eventName)
	if #rooms == 0 then
	    self.rooms[eventName][1] = self.events[eventName][1]
		return self.rooms[eventName][1]
	end

	for i, v in ipairs(rooms) do
		local players = QUEUE_ROOM_SYSTEM:getPlayers(eventName, i)
		if #players < maxParticipants then
			return v
		end
	end
	
	for i, v in ipairs(self.events[eventName]) do
	    local players = QUEUE_ROOM_SYSTEM:getPlayers(eventName, i)
		if #players < maxParticipants then
		    self.rooms[eventName][i] = self.events[eventName][i]
			return v
		end
    end		
	return false
end
	
function QUEUE_ROOM_SYSTEM:getPlayers(eventName, roomID)
    local players = {}
	if not self.events then
	    return players
	end
	
	--print("Event Name: " .. eventName)
	if not self.events[eventName] then
	    return players
	end
	
	if not self.events[eventName][roomID] then
	    return players
	end
	
	local t = self.events[eventName][roomID].queuePlayers
	if not t then
	    return players
	end
	
	for i, v in pairs(t) do
	    local id = v.id
	    local player = Player(id)
		if player then
		    table.insert(players, v)
		end
	end
	return players
end

function QUEUE_ROOM_SYSTEM:clearRoom(eventName, roomID)
	if not self.events then
	    return false
	end
	
	if not self.events[eventName] then
	    return false
	end
	
	if not self.events[eventName][roomID] then
	    return false
	end
	
	
	local t = self.events[eventName][roomID].queuePlayers
	if not t then
	    return false
	end

	for i, v in pairs(t) do
	    local player = Player(v.id)
		if player then
		   QUEUE_ROOM_SYSTEM:removePlayer(player)
		end
	end
	self.events[eventName][roomID].queuePlayers = nil
	self:removeRoom(eventName, roomID)
end
     
function QUEUE_ROOM_SYSTEM:getPlayersByRoom(room)
    return room["queuePlayers"]
end

function QUEUE_ROOM_SYSTEM:teleportPlayers(eventName, roomID, roomRealID, posTable, hideWindow)
    local t = self.events[eventName][roomID].queuePlayers
	for i,v in pairs(t) do
	    local player = Player(v.id) 
		if player then
		    player:prepareEventCharacter(v.vocation)
			print("Vocation: " .. v.vocation)
 			player:addHealth(player:getMaxHealth())
			player:addMana(player:getMaxMana())
			if not playerRoomMemory[player:getId()] then
				playerRoomMemory[player:getId()] = {}
			end
			playerRoomMemory[player:getId()].roomId = roomRealID
			playerRoomMemory[player:getId()].kills = 0
			playerRoomMemory[player:getId()].asistance = 0
			playerRoomMemory[player:getId()].eventName = eventName
			playerRoomMemory[player:getId()].vocation = v.vocation
			
			
			print("Room ID:" .. roomID)
			print("Real Room ID: " .. roomRealID)
			print("Players Table: " .. dump(playerRoomMemory))
			-- if not playerRoomMemory[roomRealID].eventName then
			    -- playerRoomMemory[roomRealID].eventName = eventName
			-- end
		    local pos = posTable[v.index].pos
			--player:registerEvent('QUEUE_ROOM_SYSTEM_onPrepareDeath')
			player:teleportTo(pos)
			if hideWindow then
			    local t = {}
				t.buffer = "hideWindow"
			    QUEUE_ROOM_SYSTEM:sendOpCode(player, json.encode(t)) 
			end
		end
	end
end

function QUEUE_ROOM_SYSTEM:openDoor(room)
	local getConfig = room
	if not getConfig then return end
	local roomId = room.RealID
	if eventRoomMemory[roomId].status ~= 1 then 
	   return 
	end

	if getConfig.doors then
		for i, child in ipairs(getConfig.doors) do
			for _i, _child in pairs(EVENTS_DOORS) do
				local tile = Tile(child.pos)
				if tile then
					local item = tile:getItemById(_i)
					if item then
						item:transform(_child)
					end
				end
			end
		end
	end
	
	if getConfig.chests then
		for i, child in ipairs(getConfig.chests) do
			for _i,item in pairs(Tile(child.pos):getItems()) do
				if item:getId() == 857 then
					item:transform(355)
				elseif item:getId() == 856 then
					item:transform(356)
				end
				item:setActionId(evconfig.chestActionId + (roomId * 100) + i) 
			end
		end
	end
	
	if getConfig.monsters then
		for i, child in ipairs(getConfig.monsters) do
			Game.createMonster(child.monster.name, child.pos, true, false)
		end
	end
	
	if getConfig.stages then
		local currentStage = getConfig.stages[getConfig.stage]
		if currentStage and getConfig.stages[getConfig.stage + 1] then
			addEvent(executeNextStage, currentStage.duration * 1000, roomId)
		end
	end
	
	eventRoomMemory[roomId].status = 2
end

function QUEUE_ROOM_SYSTEM:sendMessage(room)
	local seconds = room["eventStartTimer"]
	if seconds < 0 then 
	   return true
	end
	local players = self:getPlayersByRoom(room)
	if not players then
	    return false
	end
	
	local delay = 0
	for i = 0, seconds do
	    local value = seconds - i
	    addEvent(function()
	        for i, v in pairs(players) do
	            local player = Player(v.id)
                if value == 0 then
		            if player then
			            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Last player standing wins!")
			        end
			    self:openDoor(room)
	      	    else
		            if player then
			            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Event will start in ".. value .." seconds.")
			        end
		        end
	        end		    
		end, delay)
		delay = delay + 1000
	end
end

function QUEUE_ROOM_SYSTEM:setPlayerEvent(eventName, roomID, player)
    if not self.playerEvents then
	    self.playerEvents = {}
	end
	
	self.playerEvents[player:getId()] = { ["eventName"] = eventName, ["room"] = roomID }
end

function QUEUE_ROOM_SYSTEM:getPlayerEvent(player)
    if not self.playerEvents then
	    self.playerEvents = {}
	end   
	
	return self.playerEvents[player:getId()]
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function QUEUE_ROOM_SYSTEM:removeById(eventName, roomId, id)
    
    if not self.rooms then
	    return false
	end
		
	if not self.rooms[eventName] then
	    return false
	end
	
	--print(dump(self.rooms[eventName]))
	
	--print("Room ID:" .. roomId)
	if not self.rooms[eventName][roomId] then
	    return false
	end
	
	local t = self.rooms[eventName][roomId].player
	for i, v in pairs(t) do
	    if v == id then
		    table.remove(t, i)
			--print(dump(self.rooms[eventName]))
		    return true
		end
	end
	return false
end

function QUEUE_ROOM_SYSTEM:removePlayer(player, teleport)
    local t = QUEUE_ROOM_SYSTEM:getPlayerEvent(player)
	if not t then
	    return false
	end
	
	local eventName = t.eventName
	local roomID = t.room
	
	local name = self.events[eventName][roomID].name
	

	
	local index = QUEUE_ROOM_SYSTEM:getPlayerTableIndex(name, roomID, player)
	if index then
	    self.events[name][roomID].queuePlayers[index] = nil
		self.playerEvents[player:getId()] = nil
		self:removeById(name, roomID, player:getId())    
		self:updateQueue(name, roomID)
		if tablelength(self.events[name][roomID].queuePlayers) == 0 then
		    self:removeRoom(name, roomID)
		end
	end
end

local creatureevent = CreatureEvent("QUEUE_ROOM_SYSTEM_onLogout")
function creatureevent.onLogout(player)
    if QUEUE_ROOM_SYSTEM:getPlayerEvent(player) then
	    return true
	end
    QUEUE_ROOM_SYSTEM:removePlayer(player)
    return true
end
creatureevent:register()

creatureevent = CreatureEvent("QUEUE_ROOM_SYSTEM_onOpCode")
function creatureevent.onExtendedOpcode(player, opcode, buffer)
	if opcode ~= 242 then
	    return true
	end
	
	local t = json.decode(buffer)
	
	if t.buffer == "removeFromQueue" then
	    QUEUE_ROOM_SYSTEM:removePlayer(player)
	   	local data = {}
		data.buffer = "hideWindow"
		QUEUE_ROOM_SYSTEM:sendOpCode(player, json.encode(data)) 
	   return true
	end
	
    return true
end
creatureevent:register()

creatureevent = CreatureEvent("QUEUE_ROOM_SYSTEM_onLogin")
function creatureevent.onLogin(player)
    player:registerEvent("QUEUE_ROOM_SYSTEM_onOpCode")
    return true
end
creatureevent:register()


-- creatureevent = CreatureEvent("QUEUE_ROOM_SYSTEM_onPrepareDeath")
-- function creatureevent.onPrepareDeath(player, killer)

	-- local roomId = playerRoomMemory[player:getId()] and playerRoomMemory[player:getId()].roomId

     
	-- -- local playerEvent = QUEUE_ROOM_SYSTEM:getPlayerEvent(player)
	-- -- if not playerEvent then
	    -- -- return true
	-- -- end
	
	-- -- local eventName = playerEvent.eventName
	-- -- local roomID = playerEvent.room
	

	
	
	-- -- local room = QUEUE_ROOM_SYSTEM:getRoom(eventName, roomID)
	-- -- local roomId = room.RealID
	
	-- if not roomId then return true end
	
	-- print("Tu jestem 2")
	-- local getConfig = getEventRoom(roomId)
	-- if not getConfig then print("SURVIVAL EVENT: "..player:getName().." onPrepareDeath bug with room:"..tostring(roomId)) return true end
	-- --if eventRoomMemory[roomId].status < 1 then return true end
	
	-- local getPlayers = eventRoomMemory[roomId].players	
	-- if evconfig.dbs.playersLog then
	    -- print("Tu jestem 3")
		-- for i,child in pairs(player:getDamageMap()) do
			-- if child.attackerName and string.len(child.attackerName) > 1 then
				-- if os.mtime() - child.ticks < evconfig.assistData.duration*1000 then
					-- if not killer or (killer and killer:getId() ~= i) and playerRoomMemory[i] then
						-- playerRoomMemory[i].asistance = playerRoomMemory[i].asistance and playerRoomMemory[i].asistance + 1 or 1
					-- end
					-- DIVISION_SYSTEM:addPoints(player, evconfig.assistData.points)
					-- local resultAsistance = db.storeQuery("SELECT `event_name`, `points`, `kills_asistance` FROM `"..evconfig.dbs.playersLog.."` WHERE `player_id` = " .. child.attackerGuid .. " AND `event_name` = ".. db.escapeString(getEventName(getConfig.name)) .."")
					-- if resultAsistance == false then
						-- db.query(string.format("INSERT INTO `"..evconfig.dbs.playersLog.."`(`player_id`, `event_name`, `points`, `kills_total`, `kills_combo`, `kills_asistance`, `reward_taken`) VALUES (%s, %s, %s, %s, %s, %s, %s)", child.attackerGuid, db.escapeString(getEventName(getConfig.name)), evconfig.assistData.points, 0, 0, 1, 0))
					-- else
						-- local getPoints = result.getNumber(resultAsistance, "points") + evconfig.assistData.points
						
						-- local getAsistance = result.getNumber(resultAsistance, "kills_asistance") + 1
						-- db.query("UPDATE `"..evconfig.dbs.playersLog.."` SET `kills_asistance`='".. getAsistance .."', `points`='".. getPoints .."' WHERE `player_id` = " .. child.attackerGuid .. " AND `event_name` = ".. db.escapeString(getEventName(getConfig.name)) .."");
					-- end
					-- result.free(resultAsistance)
				-- end
			-- end
		-- end
	-- end
	-- print("Tu jestem 4")
	-- --if not playerRoomMemory[killer:getId()].kills then print("SURVIVAL EVENT: onDeath killer bug") return false end
	-- if killer and playerRoomMemory[killer:getId()] then
		-- playerRoomMemory[killer:getId()].kills = playerRoomMemory[killer:getId()].kills and playerRoomMemory[killer:getId()].kills + 1 or 1
	-- end
	
	-- if getConfig.playerEvents then
	   -- print("Tu jestem 5")
		-- for _i, ev in ipairs(getConfig.playerEvents) do
			-- player:unregisterEvent(ev)
			-- player:unregisterEvent('QUEUE_ROOM_SYSTEM_onPrepareDeath')
		-- end
	-- end
	-- print("Tu jestem 6")	
	-- -- if player:findEvent() then 
		-- -- player:addHealth(player:getMaxHealth())
		-- -- player:addMana(player:getMaxMana())
		-- -- return false 
	-- -- end
	
	-- return true
-- end
-- --creatureevent:type('preparedeath')
-- creatureevent:register()


-- local creatureevent = CreatureEvent("TASK_SYSTEM_onDeath")
-- function creatureevent.onDeath(creature, corpse, killer, mostDamage, unjustified, mostDamage_unjustified)
    -- TASK_SYSTEM:updateTask(killer, creature)
-- end
-- creatureevent:register()
	
	
	
	
