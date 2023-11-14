local experiencePouch = Action()

local config = {
   [1] = { itemID = 35962, count = { min = 1, max = 4 } }, -- Experience pearl grade 1
   [2] = { itemID = 35961, count = { min = 1, max = 4 } }, -- Experience pearl grade 2
   [3] = { itemID = 35966, count = { min = 1, max = 4 } }, -- Experience pearl grade 3
   [4] = { itemID = 35965, count = { min = 1, max = 4 } }, -- Experience pearl grade 4
   [5] = { itemID = 35959, count = { min = 1, max = 4 } }, -- Experience pearl grade 5
   [6] = { itemID = 35960, count = { min = 1, max = 4 } }, -- Experience pearl grade 6
   [7] = { itemID = 35964, count = { min = 1, max = 4 } }, -- Experience pearl grade 7
   [8] = { itemID = 35967, count = { min = 1, max = 4 } }, -- Experience pearl grade 8
   [9] = { itemID = 35963, count = { min = 1, max = 4 } }, -- Experience pearl grade 9
}

function experiencePouch.onUse(player, item, fromPosition, target, toPosition, isHotkey)
   local random = math.random(1, #config)
   local a = config[random]
   local random2 = math.random(a.count.min, a.count.max)
   player:addItem(a.itemID, random2)
   player:sendTextMessage(MESSAGE_INFO_DESCR, "You received " .. random2 .. "x " .. getItemName(a.itemID) .. ".")
   player:SME(31)
   item:remove(1)
end

experiencePouch:id(28436)
experiencePouch:register()
