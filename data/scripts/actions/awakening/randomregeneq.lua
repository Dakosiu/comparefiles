local randomregeneq = Action()

local config = {
   [1] = { itemID = 34757, count = { min = 1, max = 1 } }, -- amulet
   [2] = { itemID = 34756, count = { min = 1, max = 1 } }, -- helmet
   [3] = { itemID = 34755, count = { min = 1, max = 1 } }, -- armor
   [4] = { itemID = 34753, count = { min = 1, max = 1 } }, -- legs
   [5] = { itemID = 34754, count = { min = 1, max = 1 } }, -- boots
   [6] = { itemID = 34758, count = { min = 1, max = 1 } }, -- ammo item
}

function randomregeneq.onUse(player, item, fromPosition, target, toPosition, isHotkey)
   local random = math.random(1, #config)
   local a = config[random]
   local random2 = math.random(a.count.min, a.count.max)
   player:addItem(a.itemID, random2)
   player:sendTextMessage(MESSAGE_INFO_DESCR, "You received " .. random2 .. "x " .. getItemName(a.itemID) .. ".")
   player:SME(31)
   player:SME(42)
   player:SME(53)
   item:remove(1)
end

randomregeneq:id(28842)
randomregeneq:register()
