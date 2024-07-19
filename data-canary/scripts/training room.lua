local config = {
	-- Position of the first position (line 1 column 1)
	firstRoomPosition = {x = 10, y = 11, z = 7},
	-- X distance between each room (on the same line)
	distancePositionX= 14,
	-- Y distance between each room (on the same line)
	distancePositionY= 14,
	-- Number of columns
	columns= 24,
	-- Number of lines
	lines= 30
}

TRAINING_ROOM_SYSTEM = {}
TRAINING_ROOM_SYSTEM.aid = 5671
TRAINING_ROOM_SYSTEM.customAttribute = "TRAINING_ROOM_ITEM"
TRAINING_ROOM_SYSTEM.storage = 51314551


function TRAINING_ROOM_SYSTEM:isInRoom(player)
    local value = player:getStorageValue(self.storage)
	if not value or value < 1 then
	   return false
	end
	return true
end

function TRAINING_ROOM_SYSTEM:setInRoom(player, bool)
    if bool then
	   return player:setStorageValue(self.storage, 1)
	end
	return player:setStorageValue(self.storage, 0)
end
   
   
function TRAINING_ROOM_SYSTEM:isTrainingRoomItem(item)
    if item:getCustomAttribute(self.customAttribute) then
	   return true
	end
	return false
end
	
local function isBusyable(position)
	local player = Tile(position):getTopCreature()
	if player then
		if player:isPlayer() then
			return false
		end
	end

	local tile = Tile(position)
	if not tile then
		return false
	end

	local ground = tile:getGround()
	if not ground or ground:hasProperty(CONST_PROP_BLOCKSOLID) then
		return false
	end

	local items = tile:getItems()
	for i = 1, tile:getItemCount() do
		local item = items[i]
		local itemType = item:getType()
		if itemType:getType() ~= ITEM_TYPE_MAGICFIELD and not itemType:isMovable() and item:hasProperty(CONST_PROP_BLOCKSOLID) then
			return false
		end
	end
	return true
end

local function calculatingRoom(uid, position, column, line)
	local player = Player(uid)
	if column >= config.columns then
		column = 0
		line = line < (config.lines -1) and line + 1 or false
	end

	if line then
		local room_pos = {x = position.x + (column * config.distancePositionX), y = position.y + (line * config.distancePositionY), z = position.z}
		if isBusyable(room_pos) then
			player:teleportTo(room_pos)
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		else
			calculatingRoom(uid, position, column + 1, line)
		end
	else
		player:sendCancelMessage("Couldn't find any position for you right now.")
	end
end

local trainerEntrance = MoveEvent()
function trainerEntrance.onStepIn(creature, item, position, fromPosition)
	if not creature:isPlayer() then
		return true
	end

	calculatingRoom(creature.uid, config.firstRoomPosition, 0, 0)
	local pos = creature:getPosition()
	local x = pos.x
	local y = pos.y
	local z = pos.z
	
	Game.createMonster("Training Monk", pos, true, false)
	Game.createMonster("Training Monk", pos, true, false)
	
	local tile = Tile(Position(x, y + 1, z))
	if tile then
	   local items = tile:getItems()
	   for _, item in pairs(items) do
	        if item then
			   item:setAttribute(ITEM_ATTRIBUTE_ACTIONID, TRAINING_ROOM_SYSTEM.aid)
			   break
			end
	   end
	end
	
	tile = Tile(Position(x + 1, y, z))
	if tile then
	   local items = tile:getItems()
	   for _, item in pairs(items) do
	        if item then
			   item:setCustomAttribute(TRAINING_ROOM_SYSTEM.customAttribute, 1)
			end
	   end
	end	
	
	tile = Tile(Position(x - 1, y, z))
	if tile then
	   local items = tile:getItems()
	   for _, item in pairs(items) do
	        if item then
			   item:setCustomAttribute(TRAINING_ROOM_SYSTEM.customAttribute, 1)
			end
	   end
	end		
	
	
	TRAINING_ROOM_SYSTEM:setInRoom(creature, true)
	return true
end

trainerEntrance:position({x = 1022, y = 731, z = 7})
trainerEntrance:register()


local moveevent = MoveEvent()
moveevent:type("stepin")
function moveevent.onStepIn(creature, item, position, fromPosition)
	local player = Player(creature)
	if not player then
		return true
	end
    
	
	TRAINING_ROOM_SYSTEM:setInRoom(player, false)
	player:teleportTo(player:getTown():getTemplePosition())
	player:sendCancelMessage("You have been teleported to temple.")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "You have been teleported to temple.")
	
	return true
end
moveevent:aid(TRAINING_ROOM_SYSTEM.aid)
moveevent:register()


local creatureevent = CreatureEvent("TRAINING_ROOM_SYSTEM_onLogin")
function creatureevent.onLogin(player)
   
   	if not TRAINING_ROOM_SYSTEM:isInRoom(player) then
	   return true
	end
	
	TRAINING_ROOM_SYSTEM:setInRoom(player, false)
	player:teleportTo(player:getTown():getTemplePosition())
	
	
   
return true
end
creatureevent:register()