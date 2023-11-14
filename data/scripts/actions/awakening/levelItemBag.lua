local levelItemBag = Action()

local config = {
   --!Level50
   [1] = { itemID = 36795, level = 50 },
   [2] = { itemID = 36796, level = 50 },
   [3] = { itemID = 36797, level = 50 },
   [4] = { itemID = 36798, level = 50 },
   [5] = { itemID = 36799, level = 50 },
   [6] = { itemID = 36794, level = 50 },
   [7] = { itemID = 35964, level = 50 },
   --!Level100
   [8] = { itemID = 22396, level = 100 },
   [9] = { itemID = 25379, level = 100 },
   [10] = { itemID = 25376, level = 100 },
   [11] = { itemID = 25380, level = 100 },
   --!Level150
   [12] = { itemID = 26168, level = 150 },
   [13] = { itemID = 22397, level = 150 },
   [14] = { itemID = 25172, level = 150 },
   [15] = { itemID = 25378, level = 150 },
   [16] = { itemID = 25377, level = 150 },
   --!Level200
   [17] = { itemID = 16015, level = 200 },
   [18] = { itemID = 21395, level = 200 },
   [19] = { itemID = 41219, level = 200 },
   [20] = { itemID = 41218, level = 200 },
   [21] = { itemID = 41217, level = 200 },
   [22] = { itemID = 41216, level = 200 },
   --!Level300
   [23] = { itemID = 41231, level = 300 },
   [24] = { itemID = 41230, level = 300 },
   [25] = { itemID = 41191, level = 300 },
   [26] = { itemID = 41229, level = 300 },
   [27] = { itemID = 41232, level = 300 },
   [28] = { itemID = 41234, level = 300 },
   [29] = { itemID = 41235, level = 300 },
   [30] = { itemID = 41253, level = 300 },
   [31] = { itemID = 41233, level = 300 },
   --!Level400
   [32] = { itemID = 41243, level = 400 },
   [33] = { itemID = 41239, level = 400 },
   [34] = { itemID = 41238, level = 400 },
   [35] = { itemID = 41246, level = 400 },
   [36] = { itemID = 41245, level = 400 },
   --!Level500
   [37] = { itemID = 41241, level = 500 },
   [38] = { itemID = 41236, level = 500 },
   [39] = { itemID = 41244, level = 500 },
   [40] = { itemID = 41247, level = 500 },
   [41] = { itemID = 41240, level = 500 },
   [42] = { itemID = 41237, level = 500 },
   --!Level600
   [43] = { itemID = 26169, level = 600 },
   [44] = { itemID = 26171, level = 600 },
   [45] = { itemID = 26170, level = 600 },
   [46] = { itemID = 26172, level = 600 },
}

function levelItemBag.onUse(player, item, fromPosition, target, toPosition, isHotkey)
   local possibleItem = {}
   for i in pairs(config) do
      if player:getLevel() >= config[i].level then
         table.insert(possibleItem, config[i].itemID)
      end
   end
   local itemID = possibleItem[math.random(#possibleItem)]
   player:addItem(itemID, 1)
   player:sendTextMessage(MESSAGE_INFO_DESCR, "You received: " .. getItemName(itemID) .. ".")
   player:SME(CONST_ME_CRAPS)
   item:remove(1)
end

levelItemBag:id(26144)
levelItemBag:register()

local levelDesireBag = Action()

local Books = {
   --!Level50
   [1] = { itemID = 1976, level = 50 },
   [2] = { itemID = 1984, level = 50 },
   [3] = { itemID = 1985, level = 50 },
   --!Level100
   [4] = { itemID = 34367, level = 100 },
   [5] = { itemID = 34364, level = 100 },
   [6] = { itemID = 1983, level = 100 },
   [7] = { itemID = 1986, level = 100 },
   --!Level150
   [8] = { itemID = 37365, level = 150 },
   [9] = { itemID = 11134, level = 150 },
   [10] = { itemID = 1979, level = 150 },
   --!Level200
   [11] = { itemID = 30590, level = 200 },
   [12] = { itemID = 30588, level = 200 },
   [13] = { itemID = 30589, level = 200 },
   [14] = { itemID = 31476, level = 200 },
   --!Level300
   [15] = { itemID = 36923, level = 300 },
   [16] = { itemID = 41011, level = 300 },
   [17] = { itemID = 41010, level = 300 },
   [18] = { itemID = 41012, level = 300 },
   [19] = { itemID = 41013, level = 300 },
   [20] = { itemID = 41014, level = 300 },
   --!Level400
   [21] = { itemID = 36921, level = 400 },
   [22] = { itemID = 31358, level = 400 },
   [23] = { itemID = 39464, level = 400 },
   [24] = { itemID = 41009, level = 400 },
   --!Level500
   [25] = { itemID = 36922, level = 500 },
   [26] = { itemID = 34564, level = 500 },
   [27] = { itemID = 36809, level = 500 },
   --!Level600
   [28] = { itemID = 36920, level = 600 },
   [29] = { itemID = 25411, level = 600 },
}

function levelDesireBag.onUse(player, item, fromPosition, target, toPosition, isHotkey)
   local possibleBook = {}
   for i in pairs(Books) do
      if player:getLevel() >= Books[i].level then
         table.insert(possibleBook, Books[i].itemID)
      end
   end
   local itemID = possibleBook[math.random(#possibleBook)]
   player:addItem(itemID, 1)
   player:sendTextMessage(MESSAGE_INFO_DESCR, "You received: " .. getItemName(itemID) .. ".")
   player:SME(170)
   item:remove(1)
end

levelDesireBag:id(36765)
levelDesireBag:register()





local firstsurprisebox = Action()

local Books = {
   --!Level25
   [1] = { itemID = 41534, level = 25 },
   [2] = { itemID = 41535, level = 25 },
   [3] = { itemID = 41019, level = 25 },
   [4] = { itemID = 26179, level = 25 },
   [5] = { itemID = 21401, level = 25 },
   [6] = { itemID = 41114, level = 25 },
   [7] = { itemID = 41113, level = 25 },
   [8] = { itemID = 28436, level = 25 },
   [9] = { itemID = 27604, level = 25 },
   [10] = { itemID = 2160, level = 25 },
   [11] = { itemID = 36548, level = 25 },
   [12] = { itemID = 30501, level = 25 },
   [13] = { itemID = 10305, level = 25 },
   [14] = { itemID = 34006, level = 25 },
   [15] = { itemID = 41529, level = 25 },
   [16] = { itemID = 2173, level = 25 },
   --!Level50
   [17] = { itemID = 41533, level = 50 },
   [18] = { itemID = 41112, level = 50 },
   [19] = { itemID = 41611, level = 50 },
   --!Level75
   [20] = { itemID = 31949, level = 75 },
   [21] = { itemID = 21705, level = 75 },
   [22] = { itemID = 41530, level = 75 },
   --!Level110
   [23] = { itemID = 27046, level = 110 },
   [24] = { itemID = 26144, level = 110 },
   [25] = { itemID = 36765, level = 110 },
   --!Level175
   [26] = { itemID = 41131, level = 175 },
   --!Level220
   [27] = { itemID = 41072, level = 220 },
   [28] = { itemID = 41070, level = 220 },
   --!Level280
   [29] = { itemID = 31948, level = 280 },
   [30] = { itemID = 41537, level = 280 },
   --!Level360
   [31] = { itemID = 26130, level = 360 },
   [32] = { itemID = 26133, level = 360 },
   [33] = { itemID = 31950, level = 360 },
   [34] = { itemID = 16101, level = 360 },
}

function firstsurprisebox.onUse(player, item, fromPosition, target, toPosition, isHotkey)
   local possibleBook = {}
   for i in pairs(Books) do
      if player:getLevel() >= Books[i].level then
         table.insert(possibleBook, Books[i].itemID)
      end
   end
   local itemID = possibleBook[math.random(#possibleBook)]
   player:addItem(itemID, 1)
   player:sendTextMessage(MESSAGE_INFO_DESCR, "You received: " .. getItemName(itemID) .. ".")
   player:SME(170)
   item:remove(1)
end

firstsurprisebox:id(49999)
firstsurprisebox:register()
