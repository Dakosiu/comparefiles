EXTRA_INCREASE_HEALTH_CONFIG = {
	[10455] = {
		addExtraHealth = 500, 
		addExtraMana = 500,
	},
	[2137] = {
		addExtraHealth = 500,
		addExtraMana = 500,
	},
	[2348] = {
		addExtraHealth = 500,
		addExtraMana = 500,
	},
	[8983] = {
		addExtraHealth = 500,
		addExtraMana = 500,
	},
	[5945] = {
		addExtraHealth = 500,
		addExtraMana = 500,
	},
	[11423] = {
		addExtraHealth = 500,
		addExtraMana = 500,
	},
	[18547] = {
		addExtraHealth = 500,
		addExtraMana = 500,
	},
	[11211] = {
		addExtraHealth = 500,
		addExtraMana = 500,
	},
	[9019] = {
		addExtraHealth = 500,
		addExtraMana = 500,
	},
	[26334] = {
		addExtraHealth = 500,
		addExtraMana = 500,
	},
	[35574] = {
		addExtraHealth = 1000,
		addExtraMana = 1000,
	},
	[36436] = {
		addExtraHealth = 2000,
		addExtraMana = 2000,
	},
	[36435] = {
		addExtraHealth = 2000,
		addExtraMana = 2000,
	},
	[36434] = {
		addExtraHealth = 2000,
		addExtraMana = 2000,
	},
	[2346] = {
		addExtraHealth = 500,
		addExtraMana = 500,
	},
	[34394] = {
		addExtraHealth = 500,
		addExtraMana = 500,
	},
	[32081] = {
		addExtraHealth = 1000,
		addExtraMana = 1000,
	},
	[30117] = {
		addExtraHealth = 1000,
		addExtraMana = 1000,
	},
	[28837] = {
		addExtraHealth = 1000,
		addExtraMana = 1000,
	},
	[10614] = {
		addExtraHealth = 2000,
		addExtraMana = 2000,
	},
	[12328] = {
		addExtraHealth = 5000,
		addExtraMana = 5000,
	},
	[8980] = {
		addExtraHealth = 500,
		addExtraMana = 500,
	},
	[8979] = {
		addExtraHealth = 500,
		addExtraMana = 500,
	},
	[9003] = {
		addExtraHealth = 500,
		addExtraMana = 500,
	},
	[2345] = {
		addExtraHealth = 500,
		addExtraMana = 500,
	},
	[2350] = {
		addExtraHealth = 500,
		addExtraMana = 500,
	},
	[36866] = {
		addExtraHealth = 1000,
		addExtraMana = 1000,
	},
	[28636] = {
		addExtraHealth = 2000,
		addExtraMana = 2000,
	},
	[35421] = {
		addExtraHealth = 1000,
		addExtraMana = 1000,
	},
	[13031] = {
		addExtraHealth = 1000,
		addExtraMana = 1000,
	},
	[2112] = {
		addExtraHealth = 500,
		addExtraMana = 500,
	},
	[5802] = {
		addExtraHealth = 500,
		addExtraMana = 500,
	},


}
EXTRA_INCREASE_HEALTH_STORAGE = 1313353
for index, v in pairs(EXTRA_INCREASE_HEALTH_CONFIG) do
	v.storage = EXTRA_INCREASE_HEALTH_STORAGE + index
end


local function openWindow(player, t, itemid)
    

	  
   local title = "Quest Manager"
   local message = "You can select one of these rewards: "
   
   local window = ModalWindow(1666, title, message)
   window:addButton(100, "Select") 
   window:addButton(101, "Cancel")     
   window:setDefaultEnterButton(100)
   window:setDefaultEscapeButton(101)
   
   if not EXTRA_INCREASE_HEALTH_PLAYERS then
      EXTRA_INCREASE_HEALTH_PLAYERS = {}
   end
   
   EXTRA_INCREASE_HEALTH_PLAYERS[player:getId()] = {}
   EXTRA_INCREASE_HEALTH_PLAYERS[player:getId()].storage = t.storage
   EXTRA_INCREASE_HEALTH_PLAYERS[player:getId()].itemid = itemid                                            
   
   
   local index = 0
   local health = t.addExtraHealth
   local mana = t.addExtraMana
   if health then
      index = index + 1
	  window:addChoice(index, "+" .. health .. " Health")
	  EXTRA_INCREASE_HEALTH_PLAYERS[player:getId()][index] = { name = "Health", value = health }
   end
   if mana then
      index = index + 1
	  window:addChoice(index, "+" .. mana .. " Mana")
	  EXTRA_INCREASE_HEALTH_PLAYERS[player:getId()][index] = { name = "Mana", value = mana }
   end  

   player:registerEvent("ModalWindow_extraHealth")
   
   return window:sendToPlayer(player)
end

local creaturescript = CreatureEvent("ModalWindow_extraHealth")
function creaturescript.onModalWindow(player, modalWindowId, buttonId, choiceId) 
        
	if modalWindowId ~= 1666 then
	   return
	end
		
	if buttonId == 101 then
	   return
    end
		
		
	local t = EXTRA_INCREASE_HEALTH_PLAYERS[player:getId()][choiceId]
	local name = t.name 
	local value = t.value
	if name == "Health" then
	   player:addExtraHealth(value)
	   elseif name == "Mana" then
	player:addExtraMana(value)
	end
		
	local storage = EXTRA_INCREASE_HEALTH_PLAYERS[player:getId()].storage
	local id = EXTRA_INCREASE_HEALTH_PLAYERS[player:getId()].itemid
	player:getPosition():sendMagicEffect(357)
	player:sendTextMessage(MESSAGE_INFO_DESCR, "Your " .. name .. " has been increase by " .. value .. ".")
	player:setStorageValue(storage, 1)
	player:removeItem(id, 1)
	EXTRA_INCREASE_HEALTH_PLAYERS[player:getId()] = nil
end
creaturescript:register()   
   

local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	local v = EXTRA_INCREASE_HEALTH_CONFIG[item:getId()]

	if not v then
		return true
	end

	if player:getStorageValue(v.storage) >= 1 then
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "You can't use this item anymore.")
		player:getPosition():sendMagicEffect(3)
		return true
	end
	
	if not player:canUseFromGround(item) then
	   player:sendTextMessage(MESSAGE_STATUS_WARNING, "this item cannot be used from ground.")
       player:getPosition():sendMagicEffect(CONST_ME_POFF)
	   return true
	end	
	openWindow(player, v, item:getId())
	return true
end

for id, v in pairs(EXTRA_INCREASE_HEALTH_CONFIG) do
	action:id(id)
end
action:register()
