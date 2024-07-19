local cfg = {
_checkCap = true,
_checkSpace = true,
item = { id = 2268, count = 100, backpack = 2001, price = 950000},
messages = {
cap = "You dont have enough capacity.",
space = "You dont have a free space to obtain this backpack.",
gold = "You dont have enough money.",
success = "You have bought a bp with sd." }
}


local function getFreeSlotsFromContainer(container)
    local slots = 0
    local containers = {}
	if container and container:isContainer() then
        table.insert(containers, container)
    end
    while #containers > 0 do
		for i = (containers[1]:getSize() - 1), 0, -1 do
			local it = containers[1]:getItem(i)
			if it:isContainer() then
                table.insert(containers, it)
            end
        end
        slots = slots + (containers[1]:getCapacity() - containers[1]:getSize())
        table.remove(containers, 1)
    end
    return slots
end

local function isPlayerHaveEmptySpace(self)
	  local check = 0
	  local PLAYER_BACKPACK = self:getSlotItem(CONST_SLOT_BACKPACK)
	  local PLAYER_BACKPACK_FREE_SLOTS = getFreeSlotsFromContainer(self:getSlotItem(CONST_SLOT_BACKPACK))
	  
	  if PLAYER_BACKPACK == nil or PLAYER_BACKPACK_FREE_SLOTS == 0 then
	     return false
	  end
	  
return true
end

local action = Action()
function action.onUse(player, item, fromPosition, itemEx, toPosition)
   local pos = player:getPosition()


   if item.itemid == 1945 or item.itemid == 1946 then
   
		 local containerEx = Game.createItem(cfg.item.backpack, 1)
		 local itemEx = Game.createItem(cfg.item.id, cfg.item.count)
		 local slots = getFreeSlotsFromContainer(containerEx)
		 local requiredCap = (containerEx:getWeight() + (itemEx:getWeight() * slots))
		 local playerCap = player:getFreeCapacity()
		 
	  if cfg._checkCap then
		 if playerCap < requiredCap then
			player:sendCancelMessage(cfg.messages.cap)
			pos:sendMagicEffect(2)
            player:sendTextMessage(22, cfg.messages.cap)
			
		    return true
		 end
	  end
	  

	  if cfg._checkSpace then
         if not isPlayerHaveEmptySpace(player) then
		    player:sendCancelMessage(cfg.messages.cap)
            pos:sendMagicEffect(2)
            player:sendTextMessage(22, cfg.messages.space)
		    return true
		 end
	  end
	  
      if player:removeMoney(cfg.item.price) then
		local container = player:addItem(cfg.item.backpack, 1)
		for i = 1, slots do
			container:addItem(cfg.item.id, cfg.item.count)
		end
		
		if item.itemid == 1945 then
		item:transform(item.itemid+1)
		end
		
		if item.itemid == 1946 then
		item:transform(item.itemid-1)
		end
		
		pos:sendMagicEffect(CONST_ME_MAGIC_GREEN)
		player:sendTextMessage(22, cfg.messages.success)
		
	  else
	    local requiredMoney = cfg.item.price - player:getMoney()
		player:sendCancelMessage(cfg.messages.gold .. " You still need: " .. requiredMoney .. " money to buy this item.")
        pos:sendMagicEffect(2)
        player:sendTextMessage(22, cfg.messages.gold .. " You still need: " .. requiredMoney .. " money to buy this item.")
		return true
		end
	end
		
	return true
end
action:aid(2566)
action:register()

local talkaction = TalkAction("/testbpsd")
function talkaction.onSay(player, words, param)	
    
	local pos = player:getPosition()
	pos:sendMagicEffect(CONST_ME_MAGIC_RED)
	
	local lever = Game.createItem(1945, 1, pos)
	if lever then
	   lever:setAttribute(ITEM_ATTRIBUTE_ACTIONID, 2566)
	end
	
	return true
end
talkaction:register()