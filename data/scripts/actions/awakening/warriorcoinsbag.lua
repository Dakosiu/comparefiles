local experiencePouch = Action()

local config = {
   [1] = { itemID = 40554, count = { min = 1, max = 50 } }, -- warrior coins
   [2] = { itemID = 40554, count = { min = 2, max = 100 } }, --warrior coins
   [3] = { itemID = 40554, count = { min = 3, max = 150 } }, --warrior coins
   [4] = { itemID = 40554, count = { min = 4, max = 200 } }, --warrior coins
   [5] = { itemID = 40554, count = { min = 5, max = 250 } }, --warrior coins
   [6] = { itemID = 40554, count = { min = 6, max = 300 } }, --warrior coins
   [7] = { itemID = 40554, count = { min = 7, max = 350 } }, --warrior coins
   [8] = { itemID = 40554, count = { min = 8, max = 400 } }, --warrior coins
}

function experiencePouch.onUse(player, item, fromPosition, target, toPosition, isHotkey)
   local random = math.random(1, #config)
   local a = config[random]
   local random2 = math.random(a.count.min, a.count.max)
   player:addItem(a.itemID, random2)
   player:sendTextMessage(MESSAGE_INFO_DESCR, "You received " .. random2 .. "x " .. getItemName(a.itemID) .. ".")
   player:SME(450)
   item:remove(1)
end

experiencePouch:id(26377)
experiencePouch:register()
