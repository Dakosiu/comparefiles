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
          [9969] = {price = 8, price2 = 0}, -- [ITEMID TO SELL] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
          [36678] = {price = 30, price2 = 0},
		  [36679] = {price = 60, price2 = 0},
		  [34280] = {price = 200, price2 = 0},
          [36680] = {price = 300, price2 = 0},
		  [36866] = {price = 25, price2 = 0},
          [28636] = {price = 60, price2 = 0},
		  [41114] = {price = 100, price2 = 0},
		  [41113] = {price = 150, price2 = 0},
		  [41112] = {price = 200, price2 = 0},
		  [41019] = {price = 200, price2 = 0},
		  [40685] = {price = 500, price2 = 0},
		  [41533] = {price = 700, price2 = 0},
		  [41653] = {price = 1000, price2 = 0},
		  [41654] = {price = 1000, price2 = 0},
		  [41655] = {price = 1000, price2 = 0},
		  [41158] = {price = 1, price2 = 0},
		  [41155] = {price = 2, price2 = 0},
		  [41156] = {price = 3, price2 = 0},
		  [41174] = {price = 1, price2 = 0},
		  [41200] = {price = 2, price2 = 0},
		  [41193] = {price = 3, price2 = 0},
		  [41181] = {price = 1, price2 = 0},
		  [41178] = {price = 2, price2 = 0},
		  [41179] = {price = 3, price2 = 0},
          }
local TradeItem = 40554
local onBuy = function(cid, item, subType, amount, ignoreCap, inBackpacks)
    local player = Player(cid)
    if player:getItemCount(TradeItem) < t[item].price*amount then
        selfSay("You don't have enough coins.", cid)
    else
        player:addItem(item, amount)
        player:removeItem(TradeItem, t[item].price*amount)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have bought " .. amount .. "x " .. getItemName(item) .. " for " .. t[item].price*amount .. " coins.")
    end
    return true
end
local onSell = function(cid, item, subType, amount)
    local player = Player(cid)
    player:removeItem(item, amount)
    player:addItem(TradeItem, t[item].price2*amount)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have sold " .. amount .. "x " .. getItemName(item) .. " for " .. t[item].price2*amount .. " coins.")
    --selfSay("Here your are!", cid)
    return true
end
if (msgcontains(msg, 'trade') or msgcontains(msg, 'TRADE'))then
    for var, ret in pairs(t) do
        table.insert(shopWindow, {id = var, subType = 0, buy = ret.price, sell = ret.price2, name = getItemName(var)})
    end
    openWarriorCurrencyWindow(cid, shopWindow, onBuy, onSell) end
    return true
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())