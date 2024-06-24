local evmaps = EVENTS_MAPS
local evconfig = EVENTS_CONFIG

EVENTS_DOORS = {
	[362] = 858,
	[365] = 859,
	[858] = 362,
	[859] = 365,
}

_EVENTS_HIGHSCORES = {}
_EVENTS_HIGHSCORES_LASTREFRESH = 0

playerRoomMemory = {}
eventRoomMemory = {}

function getVocationData()
	return EVENTS_CONFIG.vocationData or nil
end

function getEventRoom(index)
	return EVENTS_CONFIG.rooms[index] or nil
end

function getEventRooms()
	return EVENTS_CONFIG.rooms or nil
end

function offsetTablePositions(t, offset)
	if type(t) == 'table' then
		if t.x then
			t.x = t.x + offset[1]
		end	
		if t.y then
			t.y = t.y + offset[2]
		end
		for k,v in pairs(t) do
			if type(v) == 'table' then
				offsetTablePositions(v, offset)		
			end
		end
	end
end

function roomScanner(roomFrom, roomTo)
	for x = roomFrom.x, roomTo.x do
		for y = roomFrom.y, roomTo.y do
			for z = roomFrom.z, roomTo.z do
				local getTile = Tile({x = _x, y = _y, z = _z})
				if getTile then
					if getTile:getCreatures() then
						for _c, creature in ipairs(getTile:getCreatures()) do
							if creature:isPlayer() then
								--return false
							end
						end
					end
				end
			end
		end
	end
	return true
end

function chooseEmptyRoomLua()
	for i,child in ipairs(getEventRooms()) do
		if roomScanner(child.roomFrom, child.roomTo) then
			--return i
		end
	end
end

function scanMap(roomId)
	local config = getEventRoom(roomId)
	if not config then return {} end
	local rangeX = ((config.roomTo.x - config.roomFrom.x)/2) + 1
	local rangeY = ((config.roomTo.y - config.roomFrom.y)/2) + 1
	local centerX = (config.roomFrom.x + rangeX)
	local centerY = (config.roomFrom.y + rangeY)
	for _z = config.roomFrom.z, config.roomTo.z do
		local players = Game.getSpectators({x = centerX, y = centerY, z = _z}, false, true, rangeX, rangeX, rangeY, rangeY)
			return {id = roomId, player = players}
	end
	
	return {}
end

function chooseEmptyEvent(nameFilter)
	for i, child in ipairs(getEventRooms()) do
		if not nameFilter or string.len(nameFilter) < 1 or nameFilter == child.name then
			local output = scanMap(i)
			if output.id and eventRoomMemory[i].status == 0 then
				--local output2 = scanMap(i+1)
				--if output2.id and eventRoomMemory[i+1] and eventRoomMemory[i+1].status == 0 and #output2.player >= #output.player then
				--	return output2
				--else
					return output 
				--end
			end
		end
	end
	
	return {id = 0, player = {}}
end

function chooseEmptyRoom()

end

local broadcastEvent = {}
function showBroadcastMessage(players, roomId, seconds)
	
	if eventRoomMemory[roomId].status ~= 1 then return end
	if seconds < 0 then return end
	local ptable = {}
	for i, child in pairs(players) do
	    local player = Player(child)
		if player then
		-- if type(child) == "number" then 
			-- child = Player(child)
		-- end
		    if seconds == 0 then
			   player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Last player standing wins!")
		    else
			   player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Event will start in ".. seconds .." seconds.")
			   --table.insert(ptable, :getId())
		    end
		end
		if seconds == 0 then
		    openDoor(roomId)
		end
	end
	
	seconds = seconds - 1

	broadcastEvent[roomId] = addEvent(showBroadcastMessage, 1000, players, roomId, seconds)
end

function executeNextStageWarning(roomId)
	local getConfig = getEventRoom(roomId)
	if not getConfig then return end
	if eventRoomMemory[roomId].status < 2 then return end
	
	local players = eventRoomMemory[roomId].members
	for _, _player in ipairs(players) do
		local player = Player(_player.id)
		if player then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Area will restrict in 10 seconds!")
		end
	end
end

function executeNextStage(roomId)

	local getConfig = getEventRoom(roomId)
	if not getConfig then return end
	if eventRoomMemory[roomId].status < 2 then return end
	
	getConfig.stage = getConfig.stage + 1
	local currentStage = getConfig.stages[getConfig.stage]
	
	if currentStage.zones then
		
		local allZones = type(currentStage.zones) == 'string' and true or false
		
		local zonePositions = {}
		if not allZones then
			for _, zone in ipairs(currentStage.zones) do
				for z = zone.from.z, zone.to.z do
					for y = zone.from.y, zone.to.y do
						for x = zone.from.x, zone.to.x do
							local key = x .. ":" .. y .. ":" .. z
							zonePositions[key] = 1
						end
					end
				end
			end
		end
		
		for z = getConfig.roomFrom.z, getConfig.roomTo.z do
			for y = getConfig.roomFrom.y, getConfig.roomTo.y do
				for x = getConfig.roomFrom.x, getConfig.roomTo.x do
					local key = x .. ":" .. y .. ":" .. z 
					if not zonePositions[key] then
						local pos = Position(x, y, z)
						local tile = Tile(pos)
						if tile then
							if tile:getGround() and tile:getItemCountById(890) == 0 then
								Game.createItem(890, 1, pos)
							end
						end
					end
				end
			end
		end
	end
	
	if getConfig.stages[getConfig.stage + 1] then
		addEvent(executeNextStageWarning, (currentStage.duration * 1000) - 10000, roomId)
		addEvent(executeNextStage, currentStage.duration * 1000, roomId)
	end
	
end

function openDoor(roomId)
	local getConfig = getEventRoom(roomId)
	if not getConfig then return end
	if eventRoomMemory[roomId].status ~= 1 then return end

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
			addEvent(executeNextStageWarning, (currentStage.duration * 1000) - 10000, roomId)
			addEvent(executeNextStage, currentStage.duration * 1000, roomId)
		end
	end
	
	eventRoomMemory[roomId].status = 2
end

function startRoomEvent(roomId, roomPlayers)
	local getConfig = getEventRoom(roomId)

	if not getConfig then return end

	eventRoomMemory[roomId].status = 1
	eventRoomMemory[roomId].members = {}
	showBroadcastMessage(roomPlayers, roomId, evconfig.startTimer)
	local rangeX = ((getConfig.roomTo.x - getConfig.roomFrom.x)/2) + 1
	local rangeY = ((getConfig.roomTo.y - getConfig.roomFrom.y)/2) + 1
	local centerX = (getConfig.roomFrom.x + rangeX)
	local centerY = (getConfig.roomFrom.y + rangeY)
	for _z = getConfig.roomFrom.z, getConfig.roomTo.z do
		local monsters = Game.getSpectators({x = centerX, y = centerY, z = _z}, false, false, rangeX, rangeX, rangeY, rangeY)
		for i, child in pairs(monsters) do
			if child:isMonster() then
				child:remove()
			elseif child:isPlayer() then
			    --print("Dodalo gracza?")
				--table.insert(eventRoomMemory[roomId].members, {name=child:getName(),place=0})
			end
		end
	end
	eventRoomMemory[roomId].fightTime = os.time()
	
	if getConfig.playerEvents then
		for _, id in ipairs(roomPlayers) do
			for _i, ev in ipairs(getConfig.playerEvents) do
			    local participant = Player(id)
				if participant then
				   participant:registerEvent(ev)
				end
				--table.insert(eventRoomMemory[roomId].members, {name=roomPlayer:getName(),place=0})
			end
		end
	end
	for _, id in ipairs(roomPlayers) do
	    local participant = Player(id)
		if participant then
	       table.insert(eventRoomMemory[roomId].members, {name=participant:getName(),place=0})
		end
	end
	

	
	if getConfig.barrels then
		for _, barrel in ipairs(getConfig.barrels) do
			local barrelTile = Tile(barrel.pos)
			if barrelTile then
			
				local barrelFound = false
				local barrelTileCreatures = barrelTile:getCreatures()
				for _, creature in ipairs(barrelTileCreatures) do
					if creature:getName():lower() == "barrel" then
						barrelFound = true
						break
					end
				end
				
				if not barrelFound then
					local barrelMonster = Game.createMonster("Barrel", barrel.pos, false, true)
					if barrelMonster then
						barrelMonster:registerEvent("BarrelDeath")
					end
				end
			end
		end
	end
end

function estimatedWaitTime()
	local playersLastHour = {
		["1 vs 1"] = {},
		
	}
	local instantStart = false --max - 1 
	
end

function finishRoomEvent(eventName, roomId, index)
	local getConfig = getEventRoom(roomId)
	if not getConfig then return end
	local rangeX = ((getConfig.roomTo.x - getConfig.roomFrom.x)/2) + 1
	local rangeY = ((getConfig.roomTo.y - getConfig.roomFrom.y)/2) + 1
	local centerX = (getConfig.roomFrom.x + rangeX)
	local centerY = (getConfig.roomFrom.y + rangeY)
	for _z = getConfig.roomFrom.z, getConfig.roomTo.z do
		local monsters = Game.getSpectators({x = centerX, y = centerY, z = _z}, false, false, rangeX, rangeX, rangeY, rangeY)
		for i, child in pairs(monsters) do
			if child:isMonster() then
				child:remove()
			elseif child:isPlayer() then
				if getConfig.playerEvents then
					for _i, ev in ipairs(getConfig.playerEvents) do
						child:unregisterEvent(ev)
					end
				end
				child:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Congratulations! You just won current event room as last standing player.")
				if evconfig.dbs.eventsLog then
					db.query(string.format("INSERT INTO `"..evconfig.dbs.eventsLog.."`(`room_id`, `event_name`, `start_time`, `fight_time`, `finish_time`, `members`, `won_id`) VALUES (%s, %s, %s, %s, %s, %s, %s)", roomId, db.escapeString(eventRoomMemory[roomId].name), eventRoomMemory[roomId].startTime, eventRoomMemory[roomId].fightTime, os.time(), db.escapeString(eventRoomMemory[roomId].members), child:getGuid()))
				end
				child:findEvent()
			end
		end
	end
		
	if getConfig.doors then
		for i, child in ipairs(getConfig.doors) do
			for _i, _child in pairs(EVENTS_DOORS) do
				local item = Tile(child.pos):getItemById(_child)
				if item then
					item:transform(_i)
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
				item:setActionId(0)
			end
		end
	end
	
	if getConfig.spontaneousChests then
		for _, chestData in ipairs(getConfig.spontaneousChests) do
			local tile = Tile(chestData.pos)
			if tile then
				local tileItems = tile:getItems()
				if tileItems then
					for _i, tileItem in ipairs(tileItems) do
						if table.contains({355,356,856,857}, tileItem:getId()) then
							tileItem:remove()
							break
						end
					end
				end
			end
		end
		
		getConfig.spontaneousChests = {}
	end
	
	if getConfig.stages then
	
		getConfig.stage = 1
	
		for z = getConfig.roomFrom.z, getConfig.roomTo.z do
			for y = getConfig.roomFrom.y, getConfig.roomTo.y do
				for x = getConfig.roomFrom.x, getConfig.roomTo.x do
					local pos = {x = x, y = y, z = z}
					local tile = Tile(pos)
					if tile then
						local tileItem = tile:getItemById(890)
						if tileItem then
							tileItem:remove()
						end
					end
				end
			end
		end
	end
	
	getConfig.player = {}	
	eventRoomMemory[roomId].status = 0
	QUEUE_ROOM_SYSTEM:clearRoom(eventName, index)
end

function checkMapStart(roomId)
end

function generateScan(startPos)
	
end

function scanRoom(startPos)
	local walkablePos = {}
	local blockedPos = {}
	
	local generationArea = {
		{ 1, 1, 1 }, 
		{ 1, 0, 1 }, 
		{ 1, 1, 1 } 
	} 
	walkablePos[startPos.x .."/"..startPos.y.."/"..startPos.z] = startPos
	local emptyLoop = false
	while emptyLoop ~= true do
			local empty = true
			for __i, __child in pairs(walkablePos) do
			local getPosTable = getAreaPos(__child, generationArea, 2) or {}		
			for _i, _child in pairs(getPosTable) do
				for i, child in pairs(_child) do

					local getPosition = child
					local findTile = Tile(getPosition)
					if findTile then
						local itemsToCheck = {
							findTile:getTopDownItem(),
							findTile:getTopTopItem(),
							findTile:getGround(),
						}
						for _, getItem in pairs(itemsToCheck) do
							if getItem and ItemType(getItem.itemid) then
								local getType = ItemType(getItem.itemid)
								if getType:isBlocking() or getType:isDoor() then
									blockedPos[getPosition.x .."/"..getPosition.y.."/"..getPosition.z] = getPosition
								end
							end
						end
						if not blockedPos[getPosition.x .."/"..getPosition.y.."/"..getPosition.z] and not walkablePos[getPosition.x .."/"..getPosition.y.."/"..getPosition.z] then
							walkablePos[getPosition.x .."/"..getPosition.y.."/"..getPosition.z] = getPosition
							empty = false
						end
					end
				end
			end
		end
		emptyLoop = empty
	end
	return walkablePos
end

function scanWalkableRoom()

	return scanTiles
end

function getRandomOption(cat)

	local cat = evconfig.barrelData[cat]
	if not cat then
		return nil
	end
	
	local random_number = math.random()
	local cumulative_probability = 0
	
	for _, option in ipairs(cat) do
		cumulative_probability = cumulative_probability + option.probability
		if random_number <= cumulative_probability then
			return option.type
		end
	end
	
	return nil
end

function getEventName(name)
    if name == "Survival" or name == "x4 All vs All" or name == "1 vs 1" then
        return "Survival"
    end
    return name
end
	
	
function Player:findEvent(room, vocation, vocation_string)
    local player = self
	local roomId = playerRoomMemory[player:getId()] and playerRoomMemory[player:getId()].roomId 
	local getConfig = roomId and getEventRoom(roomId)
	if not vocation and getConfig then
		if not eventRoomMemory[roomId].members then print("SURVIVAL EVENT: "..player:getName().." findEvent bug with room:"..tostring(roomId)) return true end

		local getPlayers = eventRoomMemory[roomId].players
		for i,child in pairs(eventRoomMemory[roomId].members) do
			if string.lower(child.name) == string.lower(player:getName()) then
				if eventRoomMemory[roomId].stepOutOrder then
					child.place = #getConfig.players - (eventRoomMemory[roomId].players - 1)
					getPlayers = #getConfig.players - (eventRoomMemory[roomId].players - 1)
				else
					child.place = eventRoomMemory[roomId].players
				end
			end
		end

		getHighscoreInfo(player, true)

		local getResult = {}
		
		if eventRoomMemory[roomId].stepOutOrder then
			for i, child in pairs(eventRoomMemory[roomId].stepOutOrder) do
				if child == player:getGuid() then
					getPlayers = i
				end
			end
		end
		
		local getRewardPoints = getConfig.players[getPlayers].points
		--local kills = playerRoomMemory[player:getId()].kills
		--local getKillsPoints = evconfig.killsCombo[kills]
		local getRewardPoints = getConfig.players[getPlayers].points or 0
		local kills = playerRoomMemory[player:getId()].kills or 0
		local getKillsPoints = evconfig.killsCombo[kills] and evconfig.killsCombo[kills] or 0
		local getPoints = getRewardPoints + getKillsPoints
		
		local resultPoints = db.storeQuery("SELECT `event_name`, `points`, `kills_total`, `kills_combo`, `kills_asistance`, `finished_events` FROM `"..evconfig.dbs.playersLog.."` WHERE `player_id` = " .. player:getGuid() .. " AND `event_name` = ".. db.escapeString(getEventName(getConfig.name)) .."")
		
				
		if resultPoints == false then	
			db.query(string.format("INSERT INTO `"..evconfig.dbs.playersLog.."`(`player_id`, `event_name`, `points`, `kills_total`, `kills_combo`, `kills_asistance`, `reward_taken`, `finished_events`) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)", player:getGuid(), db.escapeString(getEventName(getConfig.name)), getRewardPoints, kills, getKillsPoints, 0, 0, 1))
		else
			getPoints = result.getNumber(resultPoints, "points") + getPoints
			local getKills = result.getNumber(resultPoints, "kills_total") + kills
			local getCombo = result.getNumber(resultPoints, "kills_combo")
			if getCombo < kills then
				getCombo = kills
			end
			local events_count = result.getNumber(resultPoints, "finished_events")
			--db.query("UPDATE `"..evconfig.dbs.playersLog.."` SET `kills_total`='".. getKills .."', `kills_combo`='".. getCombo .."', `points`='".. getPoints .." .. "," .. `finished_events`='" .. events_count + 1 "' WHERE `player_id` = " .. player:getGuid() .. " AND `event_name` = ".. db.escapeString(getEventName(getConfig.name)) .."");
			db.query("UPDATE " .. evconfig.dbs.playersLog .. " SET " .. "kills_total = " .. getKills .. ", " .. "kills_combo = " .. getCombo .. ", " .. "points = " .. getPoints .. ", " .. "finished_events = " .. events_count + 1 .. " WHERE player_id = " .. player:getGuid() .. " AND " .. "event_name = " .. db.escapeString(getEventName(getConfig.name)))
		end
		result.free(resultPoints)
		
		--updateTitle
		--SEASON_TITLE_SYSTEM:fetchTitles()
		
		--updateTitle
		--SEASON_TITLE_SYSTEM:fetchTitles()
		
		DIVISION_SYSTEM:addPoints(player, getConfig.players[getPlayers].points)
		
		playerRoomMemory[player:getId()].kills = 0
		
		local getMembers = {}
		local getMembersLeft = {}
		
		--print(dump(eventRoomMemory[roomId].members))
		
		for i, child in ipairs(eventRoomMemory[roomId].members) do
			if child.place > 0 then
				getMembers[child.place] = child.name
			else
				table.insert(getMembersLeft,child.name)
			end
		end
		
		for i = 1,#eventRoomMemory[roomId].members do
			if not getMembers[i] and #getMembersLeft > 0 then
				getMembers[i] = getMembersLeft[1]
			end
		end
		
		local secondRow = eventRoomMemory[roomId].stepOutOrder and {"",""} or {"Combo "..kills.." kills",getKillsPoints.." points"}
		local thirdRow = eventRoomMemory[roomId].stepOutOrder and {"",""} or {playerRoomMemory[player:getId()].asistance.." Asistance",tostring(playerRoomMemory[player:getId()].asistance * evconfig.assistData.points).." points"}
		table.insert(getResult, {getPlayers.." Position ",getRewardPoints.." points"})
		table.insert(getResult, secondRow)
		table.insert(getResult, thirdRow)
		local total = getRewardPoints + getKillsPoints + playerRoomMemory[player:getId()].asistance * evconfig.assistData.points
		table.insert(getResult, {"Total Points",total.." points"})
		local divisionValue = { str = DIVISION_SYSTEM:getPointsString(player), value = player:getDivision() }
		--getResult["Division"] = { str = DIVISION_SYSTEM:getPointsString(player), division = player:getDivision() }
		repetitiveSend(player, HIGHSCORE_OPCODE, "eventResult",{rewards = {}, result = getResult, members = getMembers, division = divisionValue })
		
		eventRoomMemory[roomId].players = eventRoomMemory[roomId].players - 1
		if eventRoomMemory[roomId].players < 2 then
		    --function finishRoomEvent(eventName, roomId, index)
		    local eventTable = QUEUE_ROOM_SYSTEM:getPlayerEvent(player)
			local eventName = eventTable.eventName
			local index = eventTable.room
			addEvent(finishRoomEvent, 50, eventName, roomId, index)
		end
		
		if evmaps["Social"].returnAfterEvents then
			player:teleportTo(evmaps["Social"].pos)
			player:addHealth(player:getMaxHealth())
			player:addMana(player:getMaxMana())
			return true
		end
		
		
		
		
	end
	
	--local getRoom = chooseEmptyEvent(room)
	
	local getRoom = QUEUE_ROOM_SYSTEM:selectRoom(room, player)
	if not getRoom then
	    print("There is no empty room for that event.")
		return false
	end
	roomId = getRoom.RealID
	--roomId = getRoom.id
	local roomPlayers = getRoom.player
	
	if roomId < 1 then 
		print("no empty event")
		return false 
	end
	getConfig = getEventRoom(roomId)
	if not getConfig then 
		print("no valid config "..roomId)
		return false 
	end
   
	local forceAdd = true
	-- for i,child in pairs(roomPlayers) do
		-- if child == player then
			-- forceAdd = false
		-- end
	-- end
	if forceAdd then 
	    --print("Voc: " .. vocation)
	    --print("Voc String: " .. vocation_string)
		local name = getRoom.name
	    if not QUEUE_ROOM_SYSTEM:addPlayer(name, getRoom.ID, player, vocation_string) then
	        return false
		end
		table.insert(roomPlayers, player:getId()) 
	end
	
	
	if #roomPlayers > #getConfig.players then
		print("EVENT BUG - starting event with too many players on same map "..roomId.. " "..#roomPlayers)
		return false
	end
	
	--print(os.mtime() - cScanner)
	local roomTaken = false
	-- for iConfig, childConfig in ipairs(getConfig.players) do
		-- roomTaken = false
		-- -- if not childConfig.skipRoomScan then
			-- -- local getTiles = scanRoom(childConfig.pos)
			-- -- local getNumber = 0
			-- -- for i,child in pairs(getTiles) do
				-- -- getNumber = getNumber + 1
			-- -- end
			-- -- for i,child in pairs(getTiles) do
				-- -- if childConfig.pos == child then
				
				-- -- end
				-- -- if Tile(child) and Tile(child):getCreatures() then
					-- -- for _i,_child in pairs(Tile(child):getCreatures()) do
						-- -- if _child:getId() ~= player:getId() and _child:isPlayer() then
							-- -- roomTaken = true
						-- -- end
					-- -- end
				-- -- end
			-- -- end
		-- -- end
		-- -- if not roomTaken then
		-- -- --	for i,child in pairs(getTiles) do
			-- -- --	if Tile(child) and Tile(child):getCreatures() then
			-- -- --		for _i,_child in pairs(Tile(child):getCreatures()) do
			-- -- --			if _child:getId() ~= player:getId() and child:isMonster() then
			-- -- --				_child:remove()
			-- -- --			end
			-- -- --		end
			-- -- --	end
			-- -- --end
			-- -- --player:teleportTo(childConfig.pos)
			-- -- player:addHealth(player:getMaxHealth())
			-- -- player:addMana(player:getMaxMana())
		-- -- --	Game.createMonster("Training Bag", childConfig.pos, true, false)
			-- -- if not playerRoomMemory[player:getId()] then
				-- -- playerRoomMemory[player:getId()] = {}
			-- -- end
			-- -- playerRoomMemory[player:getId()].roomId = roomId
			-- -- playerRoomMemory[player:getId()].kills = 0
			-- -- playerRoomMemory[player:getId()].asistance = 0
			-- -- eventRoomMemory[roomId].members = {}
			-- -- break
		-- end

	-- end
	if roomTaken then
		print("no empty event room "..roomId)
		return false 
	end
	
	

	room = getRoom.name
	if #roomPlayers == #getConfig.players and #QUEUE_ROOM_SYSTEM:getPlayers(getRoom.name, getRoom.ID) == #getConfig.players then
	    eventRoomMemory[roomId].members = {}
		eventRoomMemory[roomId].players = #roomPlayers
		startRoomEvent(roomId, roomPlayers)
		eventRoomMemory[roomId].startTime = os.time()		    
		QUEUE_ROOM_SYSTEM:teleportPlayers(room, getRoom.ID, roomId, getConfig.players, true)
	end
	
	return true
end

function refreshCategory(dbTable, dbSort, dbReturn, dbCheck, dbCollect, showLimit)
	local returnTable = {}
	table.insert(dbReturn, dbSort)
	local selectText = "SELECT"
	for i,child in pairs(dbReturn) do
		local last = i == #dbReturn and "" or "," 
		selectText = selectText .. " `"..child.."`" .. last
	end
	
	local whereText = ""
	if dbCheck then
		whereText = " WHERE ("
		for i,child in pairs(dbCheck) do
			local nextCheck = i == 1 and "" or " OR " 
			whereText = whereText .. ""..nextCheck
			local even = 1
			for _i,_child in pairs(child) do
				if _i % 2 ~= 0 then
					local first = _i == 1 and "" or " AND " 
					local getValue = type(child[_i+1]) == "string" and db.escapeString(child[_i+1]) or child[_i+1]
					whereText = whereText .. "".. first .."`"..child[_i].."` = " .. getValue
					even = even + 2
				end
			end
		end
		whereText = whereText .. ")"
	end
	local resultRank = db.storeQuery(selectText.. " FROM `".. dbTable .."`" ..whereText.." ORDER BY `".. dbSort .."` DESC LIMIT "..showLimit)

	local test = selectText.. " FROM `".. dbTable .."`" ..whereText.." ORDER BY `".. dbSort .."` DESC LIMIT "..showLimit

	if resultRank ~= false then
		repeat
			local localRank = {}		
			local localGet = {}
			for i, child in pairs(dbReturn) do
				localRank[child] = child == "name" 
					and result.getString(resultRank, child) 
					or result.getNumber(resultRank, child)
			end		
			localRank.value = localRank[dbSort]
			localRank.id = localRank["player_id"] or localRank["id"]
			
			if not localRank.name or evconfig.highscores.showOutfit then
				local get = {"name"}
				if evconfig.highscores.showOutfit then
					get = {"name","looktype","lookbody","lookfeet","lookhead","looklegs","lookaddons"}
				end
				
				local getSelect = ""
				for _i,_child in pairs(get) do
					local last = _i == #get and "" or ", "
					getSelect = getSelect .. "`" .. _child .. "`" .. last
				end
				
				local resultPlayerName = db.storeQuery("SELECT "..getSelect.." FROM `players` WHERE `id` = " .. localRank.id)
				if resultPlayerName ~= false then
					for _i,_child in pairs(get) do
						localRank[_child] = _child == "name" 
							and result.getString(resultPlayerName, _child) 
							or result.getNumber(resultPlayerName, _child)
					end
				end
				result.free(resultPlayerName)
			end
			
		table.insert(returnTable, localRank)
		until not result.next(resultRank)
	end
	result.free(resultRank)
	if dbCollect then
		local newTable = {}
		local count = 0
		for i,child in pairs(returnTable) do
			if not newTable[child[dbCollect[1]]] then
				newTable[child[dbCollect[1]]] = deepCopy(child)
				count = count + 1
			elseif dbCollect[2] then
				if child.value > newTable[child[dbCollect[1]]].value then
					newTable[child[dbCollect[1]]].value =  child.value
				end
			else
				newTable[child[dbCollect[1]]].value = newTable[child[dbCollect[1]]].value + child.value
			end
		end
		if count > 1 then
			table.sort(newTable, function(a, b) return a.value > b.value end)
		end
		--print("Nowe Table: 1 " .. dump(newTable))
		return newTable
	end
	
	--print("Nowe Table: 2 " .. dump(newTable))
	return returnTable
end
	
function getHighscoreInfo(player, onlyRefresh)	
	if os.time() - _EVENTS_HIGHSCORES_LASTREFRESH > evconfig.highscores.refreshLimit then 
		_EVENTS_HIGHSCORES = {}
		for i,child in pairs(evconfig.highscores.data) do
			if child.subCategory then
				_EVENTS_HIGHSCORES[child.showId] = {}
				_EVENTS_HIGHSCORES[child.showId].name = i
				_EVENTS_HIGHSCORES[child.showId].showIcon = child.showIcon
				_EVENTS_HIGHSCORES[child.showId].subCategory = {}
				for _i,_child in pairs(child.subCategory) do
					_EVENTS_HIGHSCORES[child.showId].subCategory[_child.showId] = {name = _i, icon = _child.showIcon, disable = _child.disable, info = refreshCategory(_child.dbTable, _child.dbSort, _child.dbReturn, _child.dbCheck, _child.dbCollect, _child.showLimit)}
				end
			else
				_EVENTS_HIGHSCORES[child.showId] = {name = i, icon = child.showIcon, disable = child.disable, info = refreshCategory(child.dbTable, child.dbSort, child.dbReturn, child.dbCheck, child.dbCollect, child.showLimit)}
			end
		end
	end
	if not onlyRefresh then
		repetitiveSend(player, HIGHSCORE_OPCODE, "refreshHighscore",{info = _EVENTS_HIGHSCORES, refresh = _EVENTS_HIGHSCORES_LASTREFRESH, time_end = SEASON_RESTART_SYSTEM:getEndTimeString(), points = player:getPoints(), division = player:getDivision(), pointsString = DIVISION_SYSTEM:getPointsString(player)})
	end
end

function sendMessageBox(playerId,title,message)
	local getPlayer = Player(playerId)
	if getPlayer then
		repetitiveSend(getPlayer, HIGHSCORE_OPCODE, "messageBox",{title = title, message = message})
	end
end

function sendRepetitiveEvent(playerId, opcode, action, data)
	local getPlayer = Player(playerId)
	if not getPlayer then return end
	
	local msg = NetworkMessage()
	msg:addByte(50)
	msg:addByte(opcode)
	msg:addString(json.encode({action = action, data = data}))
	msg:sendToPlayer(getPlayer)
end

function repetitiveSend(player,opcode,action,data)
	local getBuffer = json.encode(data)
	local lastGroup = math.ceil(string.len(getBuffer)/5000)
	local actualI=0
	for i = 1,lastGroup do
		local sendData = string.sub(getBuffer, ((i-1)*5000)+1, i*5000)
		local sendFirst = "false"
		local sendLast = "false"
		if i == lastGroup then
			sendLast = "true"
		end
		if i == 1 then
			sendFirst = "true"
		end
        addEvent(sendRepetitiveEvent,(actualI*60), player:getId(), opcode, action, {opcodeDataFirst = sendFirst,opcodeDataLast = sendLast,opcodeData = sendData} )
		actualI = (actualI+1)
	end
end

function getAlphaPoints(accId)
	local resultId = db.storeQuery("SELECT `points` FROM `znote_accounts` WHERE `account_id` = " .. accId)
	local getValue = 0
	if resultId then
		getValue = result.getDataInt(resultId, "points")
	end
	result.free(resultId)
	
	return getValue
end

function changeAlphaPoints(accId, points)
	local getValue = getAlphaPoints(accId) + points
	db.query("UPDATE `znote_accounts` SET `points` = " .. getValue .. " WHERE `account_id` = " .. accId)
	return getValue
end

function eventStepInCallback(player, position, fromPosition)
	if not player or player:isInGhostMode() or not playerRoomMemory[player:getId()] then
		return true
	end
	
	local roomId = playerRoomMemory[player:getId()] and playerRoomMemory[player:getId()].roomId
	if not roomId then print("SURVIVAL EVENT: onStepIn bug") return false end
	local getConfig = getEventRoom(roomId)
	if not getConfig then print("SURVIVAL EVENT: "..player:getName().." eventStepInCallback bug with room:"..tostring(roomId)) return true end
	if not getConfig.stepIn then return true end
	
	if not eventRoomMemory[roomId].stepInOrder then eventRoomMemory[roomId].stepInOrder = {} end
	for i,child in pairs(getConfig.stepIn) do
		if child.pos.x == position.x and child.pos.y == position.y then
			if eventRoomMemory[roomId].status < 2 then
				return false
			else
				table.insert(eventRoomMemory[roomId].stepInOrder, player:getGuid())
			end
		end
	end
	
	return true
end

function eventStepOutCallback(player, position, fromPosition)
	if not player or player:isInGhostMode() or not playerRoomMemory[player:getId()] then
		return true
	end
	
	local roomId = playerRoomMemory[player:getId()] and playerRoomMemory[player:getId()].roomId
	if not roomId then print("SURVIVAL EVENT: onStepOut bug") return false end
	local getConfig = getEventRoom(roomId)
	if not getConfig then print("SURVIVAL EVENT: "..player:getName().." eventStepOutCallback bug with room:"..tostring(roomId)) return true end
	if not getConfig.stepOut then return true end
	
	if not eventRoomMemory[roomId].stepOutOrder then eventRoomMemory[roomId].stepOutOrder = {} end
	for i,child in pairs(getConfig.stepOut) do
		if child.pos.x == position.x and child.pos.y == position.y then
			if eventRoomMemory[roomId].status < 2 then
				return false
			else
				table.insert(eventRoomMemory[roomId].stepOutOrder, player:getGuid())
				addEvent(findNewEvent,50, roomId, player:getId(), player:getName())
				return true
			end
		end
	end
	
	return true
end

function findNewEvent(roomId, playerId, playerName)
	local getPlayer = Player(playerId)
	local getConfig = getEventRoom(roomId)
	if not getConfig then print("SURVIVAL EVENT: findNewEvent bug with room:"..tostring(roomId)) return end
		
	if getPlayer then
		getPlayer:findEvent()
	end
end

function Player:prepareEventCharacter(vocation)
	local getVoc = self:getVocation():getName()
	if vocation and string.len(vocation) > 1 and string.lower(getVoc) ~= string.lower(vocation) then
		getVoc = vocation
		self:setVocation(Vocation(getVoc))
	end
	
	local vocationData = getVocationData()
	
	if vocationData.eqEnabled then
		if vocationData.data[getVoc].eq then
			for i = 1, 10 do
				local oldItem = self:getSlotItem(i)
				if oldItem then
					self:getSlotItem(i):remove()
				end
				
				local newItem = vocationData.data[getVoc].eq[i]
				if newItem then
					self:addItem(newItem[1],newItem[2],false,1,i)
				end
			end
		end
	end

	if vocationData.skillsEnabled then
		for skillId, skillValue in pairs(vocationData.data[getVoc].skills) do
			if skillId < SKILL_HEALTH then
				self:setStorageValue(evconfig.skillStorage + skillId, self:getSkill(skillId))
				if skillId == SKILL_MAGLEVEL then
					self:setMagicLevel(skillValue, false)
				else
					self:setSkillLevel(skillId, skillValue, false)
				end
			elseif skillId == SKILL_HEALTH then
				self:setStorageValue(evconfig.skillStorage + skillId, self:getMaxHealth())
				if type(skillValue) == "number" then
					self:setMaxHealth(skillValue)
				else
					local value = Vocation(getVoc):getHealthGain() * self:getLevel()
					self:setMaxHealth(value)
				end
			elseif skillId == SKILL_MANA then
				self:setStorageValue(evconfig.skillStorage + skillId, self:getMaxMana())
				if type(skillValue) == "number" then
					self:setMaxMana(skillValue)
				else
					local value = Vocation(getVoc):getManaGain() * self:getLevel()
					self:setMaxMana(value)
				end
			elseif skillId == SKILL_SOUL then
				self:setStorageValue(evconfig.skillStorage + skillId, self:getSoul())
				if type(skillValue) == "number" then
					self:addSoul(skillValue - self:getSoul())
				else
					local value = Vocation(getVoc):getMaxSoul()
					self:addSoul(value)
				end
			elseif skillId == SKILL_CAP then
				local getCap = math.min(2047483647, self:getCapacity())
				self:setStorageValue(evconfig.skillStorage + skillId, getCap)
				if type(skillValue) == "number" then
					self:setCapacity(skillValue)
				else
					local value = 250 + (Vocation(getVoc):getCapacityGain() * self:getLevel())
					self:setCapacity(value)
				end
			elseif skillId == SKILL_SPEED then
				self:setStorageValue(evconfig.skillStorage + skillId, self:getBaseSpeed())
				if type(skillValue) == "number" then
					self:changeSpeed(self:getSpeed() + (skillValue - self:getSpeed()))
				else
					self:changeSpeed(self:getSpeed() + (self:getBaseSpeed() - self:getSpeed()))
				end
			end
		end
	end
	
	local getBasedOutfit = Wikipedia.creatureAnimations["Based"] and Wikipedia.creatureAnimations["Based"][getVoc]
    if getBasedOutfit and getBasedOutfit.outfit then 
		self:setOutfit(getBasedOutfit.outfit)
	end
	
	--health recalculation
	
	self:addHealth(self:getMaxHealth())
	self:addMana(self:getMaxMana())
	self:removeOfflineTrainingTime(1)
	
	hotkeys:sendUpdate(self)
end