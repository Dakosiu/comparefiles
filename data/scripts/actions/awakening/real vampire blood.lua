local realvampireblood = Action()

local config = {
   [1] = { itemID = 2160, count = { min = 1, max = 10 } }, -- cc
   [2] = { itemID = 40554, count = { min = 1, max = 10 } }, -- warrior coin
   [3] = { itemID = 2148, count = { min = 1, max = 100 } }, -- gold coin
   [4] = { itemID = 2231, count = { min = 1, max = 2 } }, -- bone
   [5] = { itemID = 2230, count = { min = 1, max = 2 } }, -- bone
   [6] = { itemID = 2229, count = { min = 1, max = 2 } }, -- skull
   [7] = { itemID = 2173, count = { min = 1, max = 1 } }, -- aol
   [8] = { itemID = 2268, count = { min = 1, max = 100 } }, -- master sd rune
   [9] = { itemID = 2024, count = { min = 1, max = 1 } }, -- broken glass
   [10] = { itemID = 2232, count = { min = 1, max = 1 } }, --  broken glass
   [11] = { itemID = 2233, count = { min = 1, max = 1 } }, --  broken glass
   [12] = { itemID = 2236, count = { min = 1, max = 1 } }, -- old dirty book
   [13] = { itemID = 2103, count = { min = 1, max = 1 } }, -- flower
   [14] = { itemID = 10148, count = { min = 1, max = 1 } }, -- flower
   [15] = { itemID = 2100, count = { min = 1, max = 1 } }, -- flower
   [16] = { itemID = 3976, count = { min = 1, max = 100 } }, -- worms
   [17] = { itemID = 46061, count = { min = 1, max = 1 } }, -- grand vampire shield
}


local required_config = {
                           requiredItem = 12405,
						   count = 10,
						   message = "You need 10x Blood Presevation to use this",
						   effect = 1045
						}

function realvampireblood.onUse(player, item, fromPosition, target, toPosition, isHotkey)

    if player:getItemCount(required_config.requiredItem) < required_config.count then
       player:sendCancelMessage(required_config.message)
	   player:sendMagicEffect(required_config.effect)
	   return true
	end
	
	  
    local random = math.random(1, #config)
    local a = config[random]
    local random2 = math.random(a.count.min, a.count.max)
    player:addItem(a.itemID, random2)
    player:sendTextMessage(MESSAGE_INFO_DESCR, "You received " .. random2 .. "x " .. getItemName(a.itemID) .. ".")
    player:SME(31)
	player:removeItem(required_config.requiredItem, required_config.count)
    item:remove(1)
end

realvampireblood:id(45204)
realvampireblood:register()
