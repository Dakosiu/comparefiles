DOOR_KEY_SYSTEM_CONFIG = {
                            [1] = { 
					                ["Position"] = { x = 964, y = 1108, z = 6 },
									["Key"] = { id = 29304, action_id = 451  },
									["Teleport"] = {
									                 toEntrace = { x = 964, y = 1107, z = 6 },
													 fromEntrace = {
													                 { x = 965, y = 1107, z = 6 },
																	 { x = 964, y = 1107, z = 6 }
																   },
													 exitPos = { x = 964, y = 1109, z = 6 }
												   }
												   
									
									
									--["Access"] = {  
						          },
				         }


DOOR_KEY_SYSTEM = {}
DOOR_KEY_SYSTEM_ATTRIBUTES = {
                               actionid = 1782,
							   index = "DOOR_KEY_SYSTEM_INDEX",
							   keyaid = "DOOR_KEY_SYSTEM_AID",
							   locked = "DOOR_KEY_SYSTEM_LOCKED",
                             }
							 
local doorId = {}
local keyLockedDoor = {}
local keyUnlockedDoor = {}


for index, value in ipairs(KeyDoorTable) do
	if not table.contains(doorId, value.closedDoor) then
		table.insert(doorId, value.closedDoor)
	end
	if not table.contains(doorId, value.lockedDoor) then
		table.insert(doorId, value.lockedDoor)
	end
	if not table.contains(doorId, value.openDoor) then
		table.insert(doorId, value.openDoor)
	end
	if not table.contains(keyLockedDoor, value.lockedDoor) then
		table.insert(keyLockedDoor, value.lockedDoor)
	end
	if not table.contains(keyUnlockedDoor, value.closedDoor) then
		table.insert(keyUnlockedDoor, value.closedDoor)
	end
end

for index, value in pairs(keysID) do
	if not table.contains(doorId, value) then
		table.insert(doorId, value)
	end
end

function DOOR_KEY_SYSTEM:getTeleportPosition(player, t)
    
	local to = t.toEntrace
	local from = t.fromEntrace
	local exitPos = t.exitPos
	
	local pos = player:getPosition()
	
	for i, v in pairs(from) do
	    local pos2 = Position(v.x, v.y, v.z)
		if pos2 == pos then
		   return exitPos
		end
    end
	return to
end

function DOOR_KEY_SYSTEM:prepare()
   
    for index, v in pairs(DOOR_KEY_SYSTEM_CONFIG) do
        local posTable = v["Position"]
		if posTable then
		   local pos = Position(posTable.x, posTable.y, posTable.z)
		   if pos then
		      local tile = Tile(pos)
			  if tile then
			     local keyTable = v["Key"]
			     local items = tile:getItems()
				 if items and #items > 0 then
				    for _, item in pairs(items) do
					    local reqAction = keyTable.action_id
						if reqAction then
						   item:setCustomAttribute(DOOR_KEY_SYSTEM_ATTRIBUTES.keyaid, reqAction)
						end
						item:setCustomAttribute(DOOR_KEY_SYSTEM_ATTRIBUTES.index, index)
						item:setAttribute(ITEM_ATTRIBUTE_ACTIONID, DOOR_KEY_SYSTEM_ATTRIBUTES.actionid)
						DOOR_KEY_SYSTEM:setLocked(item, true)
				    end
				 end
			 end
		   end
		end
	end
	
end

function DOOR_KEY_SYSTEM:isCorrectKey(key, index)
    
	local t = DOOR_KEY_SYSTEM_CONFIG[index]["Key"]
	if not t then
	   return nil
	end
	
	local id = t.id
    local keyId = key:getId()
		
	if not id == keyId then
	   return false
	end
	local aid = t.action_id
	local keyAid = key:getAttribute(ITEM_ATTRIBUTE_ACTIONID)
	if aid then
	   if not keyAid then
	      return false
	   end
	   if aid ~= keyAid then
          return false
       end
    end	   
	
	return true
end
	   
function DOOR_KEY_SYSTEM:setLocked(item, boolean)
	if boolean then
	   return item:setCustomAttribute(DOOR_KEY_SYSTEM_ATTRIBUTES.locked, 1)
	end   
	return item:setCustomAttribute(DOOR_KEY_SYSTEM_ATTRIBUTES.locked, 0)
end

function DOOR_KEY_SYSTEM:isLocked(item)
	local value = item:getCustomAttribute(DOOR_KEY_SYSTEM_ATTRIBUTES.locked)
	if not value or value < 1 then
	   return false
	end
	return true
end

function DOOR_KEY_SYSTEM:getDescription(item)
	if DOOR_KEY_SYSTEM:isLocked(item) then
	   return "It is locked."
	end
	return false
end

function DOOR_KEY_SYSTEM:isDoor(item)
    
	if item:getCustomAttribute(DOOR_KEY_SYSTEM_ATTRIBUTES.index) then
	   return true
	end
	
	return false
end

function DOOR_KEY_SYSTEM:getDoorTable(item)

    for i, v in pairs(KeyDoorTable) do
	    local id = item:getId()
		if id == v.closedDoor or id == v.openDoor then
		   return v
		end
    end
	
    for i, v in pairs(CustomDoorTable) do
	    local id = item:getId()
		if id == v.closedDoor or id == v.openDoor then
		   return v
		end
    end
	
	return false
end  

function DOOR_KEY_SYSTEM:isDoorClosed(item)
    
	local t = DOOR_KEY_SYSTEM:getDoorTable(item)
	if not t then
	   return nil
	end
	
	if item:getId() == t.closedDoor then
	   return true
	end
	return false
end

local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	
	if not DOOR_KEY_SYSTEM:isDoor(item) then
	   return true
	end
	
    if DOOR_KEY_SYSTEM:isLocked(item) then
	  player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "It is locked.")
	  return true
	end
	
	if Creature.checkCreatureInsideDoor(player, toPosition) then
	   return true
    end
	
	local t = DOOR_KEY_SYSTEM:getDoorTable(item)
	if item:getId() == t.closedDoor then
	   item:transform(t.openDoor)
	elseif item:getId() == t.openDoor then
	   item:transform(t.closedDoor)
	end
	
	
	

	return true
end
action:aid(DOOR_KEY_SYSTEM_ATTRIBUTES.actionid)
action:register()


local last_registered_id = 0
local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
   
   	if not DOOR_KEY_SYSTEM:isDoor(target) then
	   return true
	end
	
	local index = target:getCustomAttribute(DOOR_KEY_SYSTEM_ATTRIBUTES.index)
    if not DOOR_KEY_SYSTEM:isCorrectKey(item, index) then
	   player:sendCancelMessage("The key does not match.")
	   return true
	end

	if item:getActionId() == 451 then
	    if clockmasterTask:getQuestLogMission(player, 5) ~= 2 then
		   player:sendCancelMessage("You are not allowed to use this key.")
		   return true
		end
    end
	
	local configTable = DOOR_KEY_SYSTEM_CONFIG[index]
	local teleportTable = configTable["Teleport"]
	if teleportTable then
	   local pos = Position(DOOR_KEY_SYSTEM:getTeleportPosition(player, teleportTable))
	   player:teleportTo(pos)
	   player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	   return true
	end
	
	local t = DOOR_KEY_SYSTEM:getDoorTable(target)
	--local closedDoor = tonumber(t.closedDoor)

	if target:getId() == t.closedDoor then
	   if DOOR_KEY_SYSTEM:isLocked(target) then
	      target:transform(t.openDoor)
		  DOOR_KEY_SYSTEM:setLocked(target, false)
	   else
	      DOOR_KEY_SYSTEM:setLocked(target, true)
       end
	elseif target:getId() == t.openDoor then
	    if not DOOR_KEY_SYSTEM:isLocked(target) then
		   DOOR_KEY_SYSTEM:setLocked(target, true)
	       target:transform(t.closedDoor)
		end
	end
	
	
	return true
end

for i, v in pairs(DOOR_KEY_SYSTEM_CONFIG) do
    local id = v["Key"].id
	if id and last_registered_id ~= id then
	   action:id(id)
	   last_registered_id = id
	end
end
action:register()



local globalevent = GlobalEvent("load_DOOR_KEY_SYSTEM")
function globalevent.onStartup()
   DOOR_KEY_SYSTEM:prepare()
end
globalevent:register()
		
		   
		
	   
   