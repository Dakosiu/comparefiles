local openShop_With_ActionID = 15100
local openShop_With_ItemID = nil
local openShop_StorageID = nil
local openShop_StorageValue = nil
local openShop_MessageFailStorage = "nil"
local currencyID = 18422		-- minor crystalline token
local currencyName = ItemType(currencyID):getName()
local currencyNamePlural = ItemType(currencyID):getPluralName()
local mOdAlWiNdOw_iD = 99999 -- Try to keep this ID unique for this window
local shop = {}
local modalWindow = ModalWindow(mOdAlWiNdOw_iD, "~ Lost tower "..currencyNamePlural.." shop ~", "List of items available in the shop.\nPrices are in "..currencyNamePlural)
modalWindow:addButton(1, "Buy")
modalWindow:addButton(2, "Sell")
modalWindow:addButton(3, "Close")
modalWindow:setDefaultEscapeButton(3)
modalWindow:setDefaultEnterButton(3)

local items = {
    {name = "Prismatic Armor", id=18404, price=20, sell=10 },
    {name = "Prismatic Boots", id=18406, price=20, sell=10 },
    {name = "Prismatic Helmet", id=18403, price=20, sell=10 },
    {name = "Prismatic Legs", id=18405, price=20, sell=10 },
    {name = "Prismatic Shield", id=18410, price=20, sell=10 },
    {name = "Silver Token", id=25172, price=10, sell=5, count=1 } -- item stackable
}


for index, item in ipairs(items) do
    local lowerCaseName = item.name:lower()
    if index <= 255 then 
		modalWindow:addChoice(index, string.format("[%s] Buy for %d / Sell for %d", lowerCaseName, item.price, item.sell))
        shop[index] = lowerCaseName 
    end
    shop[lowerCaseName] = item
end

local function buyItem(player, param)
    local item = shop[param:lower()]
    if not item then
        player:sendCancelMessage(string.format("Item with name %s not found!", param))
        return false
    end
    local money = player:getItemCount(currencyID)
    local totalMoney = money
	local moneyAfter = totalMoney-item.price
    if totalMoney < item.price then
		if item.price> 1 then
        player:sendCancelMessage(string.format("You don't have enough "..currencyNamePlural..", You need %d "..currencyNamePlural..".", item.price))
		else
        player:sendCancelMessage(string.format("You don't have enough "..currencyNamePlural..", You need %d "..currencyName..".", item.price))		
		end
        return false
    end

    local buyedItem = Game.createItem(item.id, math.min((item.count and item.count or 1), 100))
    if not buyedItem or not buyedItem:getType():isMovable() then
        print(string.format("Warning: The shop item with ID: %d is invalid.\n%s", item.id, debug.traceback()))
        Item.remove(buyedItem) -- in case the buyedItem is nil, no problem will occur
        return false
    end

    if player:addItemEx(buyedItem) ~= RETURNVALUE_NOERROR then
        player:sendCancelMessage(RETURNVALUE_NOTENOUGHCAPACITY)
        buyedItem:remove()
        return false
    end

    player:removeItem(currencyID, item.price)

    player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
	if moneyAfter >1 then
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, string.format("Your purchase was successful! (%s x%d).\nYou now have %d "..currencyNamePlural.." left.", buyedItem:getName(), buyedItem:getCount(), moneyAfter))
	else
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, string.format("Your purchase was successful! (%s x%d).\nYou now have %d "..currencyName.." left.", buyedItem:getName(), buyedItem:getCount(), moneyAfter))
	end
    return false
end

local function sellItem(player, itemName)
    if not itemName then
        return false
    end

    local item = shop[itemName:lower()]
    if not item then
        player:sendCancelMessage(string.format("Item with name %s not found!", itemName))
        return false
    end

    local itemCount = item.count or 1
    if not player:removeItem(item.id, itemCount) then
        player:sendCancelMessage(string.format("You do not have %d %s in your inventory.", itemCount, itemName))
        return false
    end

    player:addItem(currencyID,item.sell)
    player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
	local moneyBack = item.sell*itemCount
	if (item.sell * itemCount) >1 then
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, string.format("Your sale was successful! (%s x%d).\nYou have obtained %d "..currencyNamePlural..".", itemName, itemCount or 1, moneyBack))
	else 
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, string.format("Your sale was successful! (%s x%d).\nYou have obtained %d "..currencyName..".", itemName, itemCount or 1, moneyBack))	
	end
    return false
end

local talkAction = TalkAction("!shop")
function talkAction.onSay(player, words, param, type)
    if param == "list" then
        if openShop_StorageID then
            if player:getStorageValue(openShop_StorageID) ~= openShop_StorageValue then
                player:sendCancelMessage(openShop_MessageFailStorage)
                return false
            end
        end
        modalWindow:sendToPlayer(player)
        return false
    elseif param == "sell" then
        return sellItem(player, param:splitTrimmed(",")[2])
    end
    return buyItem(player, param)
end
talkAction:separator(" ")
talkAction:register()

if openShop_With_ActionID or openShop_With_ItemID then
    local action = Action()
    function action.onUse(player, item, fromPos, target, toPos, isHotkey)
        if openShop_StorageID then
            if player:getStorageValue(openShop_StorageID) ~= openShop_StorageValue then
                player:sendCancelMessage(openShop_MessageFailStorage)
                return false
            end
        end
        modalWindow:sendToPlayer(player)
        return true
    end
    if openShop_With_ItemID then action:id(openShop_With_ItemID) end
    if openShop_With_ActionID then action:aid(openShop_With_ActionID) end
    action:register()
end

local creatureEvent = CreatureEvent("shopModalWindowMinor")
function creatureEvent.onModalWindow(player, modalWindowId, buttonId, choiceId)
    if modalWindowId == mOdAlWiNdOw_iD then
        if buttonId == 1 then
            local param = shop[choiceId]
            if not param then
                return true
            end
            buyItem(player, param)
            return true
        elseif buttonId == 2 then
            local param = shop[choiceId]
            if not param then
                return true
            end
            sellItem(player, param)
            return true
        end
    end
    return true
end
creatureEvent:register()

local creatureEvent = CreatureEvent("shopRegisterMinor")
function creatureEvent.onLogin(player)
    player:registerEvent("shopModalWindowMinor")
    return true
end
creatureEvent:register()