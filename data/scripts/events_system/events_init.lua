--INIT

local evmaps = EVENTS_MAPS
local evconfig = EVENTS_CONFIG

--SETUP ROOMS
for i, room in pairs(evconfig.rooms) do
	if room.offset and room.copyId and getEventRoom(room.copyId) then
		local baseRoom = getEventRoom(room.copyId)
		evconfig.rooms[i] = deepCopy(baseRoom)
		offsetTablePositions(evconfig.rooms[i], room.offset)
	end
	
	room = evconfig.rooms[i]
	QUEUE_ROOM_SYSTEM:addRoom(room.name, i, room)
	eventRoomMemory[i] = {status = 0, players = 0, startTime = 0, fightTime = 0, members = ""}
	if room.chests then
		for chestIndex, _ in ipairs(room.chests) do
			survivalEventChests:aid(evconfig.chestActionId + (i * 100) + chestIndex)
		end
	end
end

survivalEventChests:register()

