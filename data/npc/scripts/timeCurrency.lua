local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}
function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

function creatureSayCallback(cid, type, msg)
if(not npcHandler:isFocused(cid)) then
return false
end
local talkUser = NPCHANDLER_CONVbehavior == CONVERSATION_DEFAULT and 0 or cid
local shopWindow = {}
local t = {
          [34089] = {price = 500, price2 = 0}, -- [ITEMID TO SELL] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
          [34090] = {price = 10000, price2 = 0},
		  [34091] = {price = 1000000, price2 = 0},
          [34092] = {price = 100000000, price2 = 0},
          }
local TradeItem = 31947

local prices = {
    {item = 31950, value = 1000000},
    {item = 31948, value = 10000},
    {item = 31949, value = 100},
    {item = 31947, value = 1},
}

local function getTimeMoney(player)
    local money = 0
    for i = 1, #prices do
        local item = prices[i].item
        local value = prices[i].value
        local itemCount = player:getItemCount(item)
        if itemCount >= 1 then
            money = money + itemCount * value
        end
    end
    return money
end

local function doBuyIt(player, item, amount)
    local totalPrice = t[item].price * amount
    local timeMoney = getTimeMoney(player)
    local valueToGive = timeMoney - totalPrice
    
    if valueToGive < 0 then
        return false
    end
    
    -- Remove the required amount of each currency item from the player's inventory
    for i in pairs(prices) do
        local itemID = prices[i].item
        local itemCount = player:getItemCount(itemID)
        player:removeItem(itemID, itemCount)
    end
    
    -- Give the player the item they bought
    player:addItem(item, amount)
    
    -- Give the player any remaining value as item currency
    for _, price in ipairs(prices) do
        local value = price.value
        local currency = price.item
        while valueToGive >= value do
            player:addItem(currency, 1)
            valueToGive = valueToGive - value
        end
    end
end

local function doSellIt(player, item, amount)
    player:removeItem(item, amount)
    local money = t[item].price2 * amount
    for i = #prices, 1, -1 do
        local currency = prices[i].item
        local value = prices[i].value
        while money >= value do
            player:addItem(currency, 1)
            money = money - value
        end
    end
end

local onBuy = function(cid, item, subType, amount, ignoreCap, inBackpacks)
    local player = Player(cid)
    if getTimeMoney(player) < t[item].price*amount then
        selfSay("You don't have enough tokens.", cid)
    else 
        doBuyIt(player, item, amount)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have bought " .. amount .. "x " .. getItemName(item) .. " for " .. t[item].price*amount .. " tokens.")
    end
    return true
end
local onSell = function(cid, item, subType, amount)
    local player = Player(cid)
    doSellIt(player, item, amount)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have sold " .. amount .. "x " .. getItemName(item) .. " for " .. t[item].price2*amount .. " tokens.")
    --selfSay("Here your are!", cid)
    return true
end
if (msgcontains(msg, 'trade') or msgcontains(msg, 'TRADE'))then
    for var, ret in pairs(t) do
        table.insert(shopWindow, {id = var, subType = 0, buy = ret.price, sell = ret.price2, name = getItemName(var)})
    end
    openTimeCurrencyWindow(cid, shopWindow, onBuy, onSell) end
    return true
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())