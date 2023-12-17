local greenboxsurpriseee = Action()

local config = {
   [1] = { itemID = 41534, count = { min = 1, max = 1 } }, -- 
   [2] = { itemID = 41535, count = { min = 1, max = 1 } }, -- 
   [3] = { itemID = 41019, count = { min = 1, max = 1 } }, -- 
   [4] = { itemID = 26179, count = { min = 1, max = 50 } }, -- 
   [5] = { itemID = 21401, count = { min = 1, max = 5 } }, --
   [6] = { itemID = 41114, count = { min = 1, max = 1 } }, -- 
   [7] = { itemID = 41113, count = { min = 1, max = 1 } }, --
   [8] = { itemID = 28436, count = { min = 1, max = 11 } }, -- 
   [9] = { itemID = 27604, count = { min = 1, max = 20 } }, --
   [10] = { itemID = 2160, count = { min = 70, max = 400 } }, --
   [11] = { itemID = 36548, count = { min = 1, max = 1 } }, --
   [12] = { itemID = 30501, count = { min = 1, max = 1 } }, --
   [13] = { itemID = 10305, count = { min = 1, max = 1 } }, --
   [14] = { itemID = 34006, count = { min = 1, max = 1 } }, --
   [15] = { itemID = 41529, count = { min = 1, max = 44 } }, --
   [16] = { itemID = 2173, count = { min = 4, max = 11 } }, --
   [17] = { itemID = 13546, count = { min = 1, max = 1 } }, --
   [18] = { itemID = 41533, count = { min = 1, max = 1 } }, --
   [19] = { itemID = 41112, count = { min = 1, max = 1 } }, --
   [20] = { itemID = 41611, count = { min = 1, max = 11 } }, --
   [21] = { itemID = 31949, count = { min = 1, max = 1 } }, --
   [22] = { itemID = 21705, count = { min = 1, max = 1 } }, --
   [23] = { itemID = 41530, count = { min = 1, max = 11 } }, --
   [24] = { itemID = 27046, count = { min = 1, max = 2 } }, --
   [25] = { itemID = 26144, count = { min = 1, max = 2 } }, --
   [26] = { itemID = 36765, count = { min = 1, max = 2 } }, --
   [27] = { itemID = 41131, count = { min = 1, max = 1 } }, --
   [28] = { itemID = 41072, count = { min = 1, max = 1 } }, --
   [29] = { itemID = 41070, count = { min = 1, max = 1 } }, --
   [30] = { itemID = 31948, count = { min = 1, max = 1 } }, --
   [31] = { itemID = 41537, count = { min = 1, max = 1 } }, --
   [32] = { itemID = 26130, count = { min = 1, max = 1 } }, --
   [33] = { itemID = 26133, count = { min = 1, max = 1 } }, --
   [34] = { itemID = 31950, count = { min = 1, max = 1 } }, --
   [35] = { itemID = 16101, count = { min = 1, max = 1 } }, --
   [36] = { itemID = 40554, count = { min = 25, max = 2000 } }, --
   [37] = { itemID = 26377, count = { min = 1, max = 3 } }, --
}

function greenboxsurpriseee.onUse(player, item, fromPosition, target, toPosition, isHotkey)
   local random = math.random(1, #config)
   local a = config[random]
   local random3 = math.random(a.count.min, a.count.max)
   player:addItem(a.itemID, random3)
   player:sendTextMessage(MESSAGE_INFO_DESCR, "You received " .. random3 .. "x " .. getItemName(a.itemID) .. ".")
   player:SME(196)
   item:remove(1)
end

greenboxsurpriseee:id(40685)
greenboxsurpriseee:register()
