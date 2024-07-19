CHECKPOINTS_SYSTEM = {
                       [1] = { name = "Hell", 
					           position = { 734, 1091, 9 }, 
							   _mustVisit = false
							 },
							 
                       [2] = { name = "Dragon Lair", 
					           position = { 766, 1052, 7 },  
							   _mustVisit = true
							 },
		             }

CHECKPOINTS_SYSTEM.requiredSoul = 0

Checkpoints = { }
Checkpoints.__newindex = Checkpoints

CHECKPOINTS_SYSTEM.ActionID = 2372
CHECKPOINTS_SYSTEM.ItemID = 33313
--CHECKPOINTS_SYSTEM.ItemIndex = "CHECKPOINT_TELEPORTER_INDEX"
local players = {}

local houses = {}

function Checkpoints:loadInvitedHouses()
	local invitedList = {}
   	local resultQuery = db.storeQuery("SELECT `list`, `house_id` FROM `house_lists`")
	if resultQuery ~= false then
	   repeat
	   	local name = result.getDataString(resultQuery, "list")
		local id = result.getDataInt(resultQuery, "house_id")
		houses[id] = name
	    until not result.next(resultQuery)
	end
	result.free(resultQuery)
end

function Checkpoints:getInvitedHouses(player)
   local t = {}
   for i, v in pairs(houses) do
       if string.find(v, player:getName()) then
	      table.insert(t, i)
	   end
   end
   return t
end

function Checkpoints:setActionId()
	for i = 1, #CHECKPOINTS_SYSTEM do
		local pos = Position(CHECKPOINTS_SYSTEM[i].position[1], CHECKPOINTS_SYSTEM[i].position[2], CHECKPOINTS_SYSTEM[i].position[3])
        local tile = Tile(pos)
		if tile then
           local ground = tile:getGround()
		         if ground then
					   ground:setAttribute(ITEM_ATTRIBUTE_ACTIONID, CHECKPOINTS_SYSTEM.ActionID)
					   --ground:setCustomAttribute(CHECKPOINTS_SYSTEM.ItemIndex, i)
				    end
		end
    end
end

function Checkpoints:getIndex(player)
      
	if not player then
	   return nil
	end
	
	
	for i = 1, #CHECKPOINTS_SYSTEM do
	    local pos = Position(CHECKPOINTS_SYSTEM[i].position[1], CHECKPOINTS_SYSTEM[i].position[2], CHECKPOINTS_SYSTEM[i].position[3])
		if pos == player:getPosition() then
		   return i
		end
    end
	
	return 0
	
end

function Checkpoints:add(player)
    
	if not player then
	   return nil
	end
	
	local index = Checkpoints:getIndex(player)
	local storage = CHECKPOINTS_SYSTEM.ActionID + index
	
    
	if player:getStorageValue(storage) > 0 then
	   return false
	end
	
	local t = CHECKPOINTS_SYSTEM[index] 
	local _mustVisit = t._mustVisit
	
	if not _mustVisit then
	   return false
	end
	
	player:setStorageValue(storage, 1)
	local pos = player:getPosition()
	pos:sendMagicEffect(CONST_ME_MAGIC_GREEN)
	local name = CHECKPOINTS_SYSTEM[index].name
	player:sendTextMessage(MESSAGE_INFO_DESCR, "You have discovered a " .. name .. " checkpoint.")
	return true
	
end

function Checkpoints:getFight(player)

   if not player then
      return true
   end
   
   if player:hasCondition(CONDITION_INFIGHT) then
      return true
   end
   
   return false
end

function Checkpoints:sendList(player)
     
	 if not player then
	    return nil
     end
	 
	 player:registerEvent("ModalWindow_checkpoints")
	 
	 local title = "Checkpoints - Teleporter"
     local message = "Avaible Places: "
	 
	 local window = ModalWindow(1001, title, message)
     window:addButton(100, "Select") 
     window:addButton(101, "Cancel")     
     window:setDefaultEnterButton(100)
     window:setDefaultEscapeButton(101)
	 
	 players[player:getId()] = {}
	 
	 local index = 0
	 
	 for i = 1, #CHECKPOINTS_SYSTEM do
	     local _mustVisit = CHECKPOINTS_SYSTEM[i]._mustVisit
	     if player:getStorageValue(CHECKPOINTS_SYSTEM.ActionID + i) > 0 or not _mustVisit then
		    index = index + 1
		    local pos = CHECKPOINTS_SYSTEM[i].position
			local name = CHECKPOINTS_SYSTEM[i].name
			local values = { ["position"] = pos, ["name"] = name }
			table.insert(players[player:getId()], values)
			window:addChoice(index, players[player:getId()][index]["name"])
		 end
	 end
	 
	 local houseTable = Checkpoints:getInvitedHouses(player)
	 for i, v in ipairs(houseTable) do
	     index = index + 1
	     local house = House(v)
		 local name = house:getName()
		 local housePosition = house:getExitPosition()
		 local pos = { housePosition.x, housePosition.y, housePosition.z }
		 local values = { ["position"] = pos, ["name"] = name }
		 table.insert(players[player:getId()], values)
		 window:addChoice(index, name)
     end
	     
	 
	 
	 if index == 0 then
	    player:sendCancelMessage("You didnt discoreved any checkpoint yet.")
		player:sendTextMessage(MESSAGE_STATUS_WARNING, "You didnt discoreved any checkpoint yet.")
		player:getPosition():sendMagicEffect(371)
		return
	 end
	 
	 return window:sendToPlayer(player)
end

local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    Checkpoints:sendList(player)
	return true
end
action:id(CHECKPOINTS_SYSTEM.ItemID)
action:register()
		
local moveevent = MoveEvent()
moveevent:type("stepin")
function moveevent.onStepIn(creature, item, position, fromPosition)
    
	local player = Player(creature)
	if not player then
		return true
	end
	
	Checkpoints:add(player)
end
moveevent:aid(CHECKPOINTS_SYSTEM.ActionID)
moveevent:register()

local creaturescript = CreatureEvent("ModalWindow_checkpoints")
function creaturescript.onModalWindow(player, modalWindowId, buttonId, choiceId) 
		
		player:unregisterEvent("ModalWindow_checkpoints")
        
	    if buttonId == 101 then
		   return false
	    end
				
		local t = players[player:getId()][choiceId]
		local pos = Position(t.position[1], t.position[2], t.position[3])
		
		if player:getSoul() < CHECKPOINTS_SYSTEM.requiredSoul then
		   player:sendCancelMessage("You need atleast " .. CHECKPOINTS_SYSTEM.requiredSoul .. " soul to use the teleporter.")
		   return true
		end
		   
		if player:getPosition() == pos then
		   player:sendCancelMessage("You are already on this place.")
		   Checkpoints:sendList(player)
		   return true
		end
		
		if not player:getTile():hasFlag(TILESTATE_PROTECTIONZONE) then
		   player:sendCancelMessage("You can't use teleporter out of pz.")
		   return true
		end
		
		if Checkpoints:getFight(player) then
		   player:sendCancelMessage("You can't use teleporter while fighting.")
		   return true
		end
		
		player:sendCancelMessage("You have been teleported.")
		player:addSoul(-CHECKPOINTS_SYSTEM.requiredSoul)
		player:teleportTo(pos)
		pos:sendMagicEffect(CONST_ME_TELEPORT)
		players[player:getId()] = {}
		return true
		
end
creaturescript:register()

local globalevent = GlobalEvent("load_Checkpoints")
function globalevent.onStartup()
	Checkpoints:setActionId()
	Checkpoints:loadInvitedHouses()
end
globalevent:register()