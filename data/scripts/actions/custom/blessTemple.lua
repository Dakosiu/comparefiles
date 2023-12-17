local b1 = {
    name = "Blossom Blessing",
    item = 26180,
    itemName = " Small Energy Balls",
    quantity = 50,
    extraHealing = 5,
    protectionAll = 0,
    reflect = 2,
    money = 50000
} -- 2 Extra Healing
local b2 = {
    name = "Hunter Blessing",
    item = 26179,
    itemName = "Small Energy Balls",
    quantity = 100,
    money = 120000,
    extraHealing = 5,
    protectionAll = 0,
    reflect = 4
} -- 1 Extra Healing and 1 Protection All = 2 Extra Healing and 1 Protection All
local b3 = {
    name = "Explorer Blessing",
    item = 26179,
    itemName = "Small Energy Balls",
    quantity = 300,
    money = 250000,
    extraHealing = 10,
    protectionAll = 1,
    reflect = 8
} -- 2 Extra Healing and 1 Protection All = 4 Extra Healing and 2 Protection All
local b4 = {
    name = "Ancient Dragons Blessing",
    item = 26179,
    itemName = "Small Energy Balls",
    quantity = 600,
    money = 600000,
    extraHealing = 15,
    protectionAll = 1,
    reflect = 16
} -- 4 Extra Healing and 1 Protection All = 8 Extra Healing and 3 Protection All
local b5 = {
    name = "Awakening Blessing",
    item = 40554,
    itemName = " Warrior Coins",
    quantity = 10,
    money = 1100000,
    extraHealing = 20,
    reflect = 32,
    protectionAll = 2
} -- 6 Extra Healing and 2 Protection All and 2 Reflect = 14 Extra Healing and 5 Protection All and 2 Reflect
local b6 = {
    name = "Pvponicus Blessing",
    item = 40554,
    itemName = " Warrior Coins",
    quantity = 25,
    money = 2500000,
    extraHealing = 25,
    reflect = 64,
    protectionAll = 5
} -- 10 Extra Healing and 5 Reflect and 5 Protection All = 24 Extra Healing and 10 Protection All and 7 Reflect

local prices = {{item = 26179, value = 100}, {item = 26180, value = 1}}

function Player.getEnergyCurrency(player)
    local money = 0
    for i = 1, #prices do
        local item = prices[i].item
        local value = prices[i].value
        local itemCount = player:getItemCount(item)
        if itemCount >= 1 then money = money + itemCount * value end
    end
    return money
end

local function enoughCurrency(player, price)
    if player:getEnergyCurrency() >= price then
        return true
    else
        return false
    end
end

local function changeCurrency(player, item, quantity)
    local totalPrice = quantity
    local valueToGive = player:getEnergyCurrency() - totalPrice
    for i in pairs(prices) do
        local itemID = prices[i].item
        local itemCount = player:getItemCount(itemID)
        player:removeItem(itemID, itemCount)
    end

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

action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local totalAmount = select(1, player:getItemCurrency())
    local smallCount = select(2, player:getItemCurrency())
    local bigCount = select(3, player:getItemCurrency())
    local protecBase = player:getProtectionAllBase()
    local healBase = player:getExtraHealingBase()
    local reflectBase = player:getReflectBase()
    function Player:sendBlessings()
        -- Modal Window Functionallity
        local function buttonAccept(button, choice)
            if choice.text == b1.name then
                player:Bless1()
            elseif choice.text == b2.name then
                player:Bless2()
            elseif choice.text == b3.name then
                player:Bless3()
            elseif choice.text == b4.name then
                player:Bless4()
            elseif choice.text == b5.name then
                player:Bless5()
            elseif choice.text == b6.name then
                player:Bless6()
            end
        end

        -- Modal window design
        local window = ModalWindow {
            title = "Blessings", -- Title of the modal window
            message = "All the buffs work just when you have the blessings active." -- The message to be displayed on the modal window
        }

        -- Add buttons to the window (Note: if you change the names of these you must change the functions in the modal window functionallity!)
        window:addButton("Ok", buttonAccept)
        window:addButton("Exit")

        if not player:hasBlessing(1) then window:addChoice(b1.name) end
        if not player:hasBlessing(2) then window:addChoice(b2.name) end
        if not player:hasBlessing(3) then window:addChoice(b3.name) end
        if not player:hasBlessing(4) then window:addChoice(b4.name) end
        if not player:hasBlessing(5) then window:addChoice(b5.name) end
        if not player:hasBlessing(6) then window:addChoice(b6.name) end
        if player:hasBlessing(1) and player:hasBlessing(2) and
            player:hasBlessing(3) and player:hasBlessing(4) and
            player:hasBlessing(5) and player:hasBlessing(6) then
            player:say('I already have all the blessings')
            return false
        end

        -- Set what button is pressed when the player presses enter or escape
        window:setDefaultEnterButton("Ok")
        window:setDefaultEscapeButton("Exit")

        -- Send the window to player
        window:sendToPlayer(self)
    end

    -- Premium Packs
    function Player:FailedPurchase()
        -- Modal Window Functionality
        local function buttonAccept(button, choice)
            if button.text == "Back" then player:sendBlessings() end
        end

        -- Modal window design
        local window = ModalWindow {
            title = "Purchase Failed", -- Title of the modal window
            message = "You do not have the money to make this purchase." -- The message to be displayed on the modal window
        }

        -- Add buttons to the window (Note: if you change the names of these you must change the functions in the modal window functionallity!)
        window:addButton("Back", buttonAccept)
        window:addButton("Exit")

        -- Set what button is pressed when the player presses enter or escape
        window:setDefaultEnterButton("Back")
        window:setDefaultEscapeButton("Exit")

        -- Send the window to player
        window:sendToPlayer(self)
    end

    function Player:Bless1()
        -- Modal Window Functionallity
        local function buttonAccept(button, choice)
            if button.text == "Yes" then
                if player:hasBlessing(1) then
                    player:say("I already have that bless!")
                    player:getPosition():sendMagicEffect(CONST_ME_POFF)
                elseif button.text == "Yes" and player:getTotalMoney() >=
                    b1.money and enoughCurrency(player, b1.quantity) then
                    player:removeTotalMoney(b1.money)
                    changeCurrency(player, b1.item, b1.quantity)
                    player:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
                    -- !BUFFS
                    player:setExtraHealingBase(healBase + b1.extraHealing)
                    player:setReflect(reflectBase + b1.reflect)
                    player:setProtectionAllBase(protecBase + b1.protectionAll)
                    player:addBlessing(1)
                elseif player:getTotalMoney() <= b1.money then
                    player:say('I dont have enough money')
                    player:getPosition():sendMagicEffect(CONST_ME_POFF)
                elseif not enoughCurrency(player, b1.quantity) then
                    player:say('I dont have enough small energy balls')
                else
                    player:say("I need the previous bless!")
                end
            elseif button.text == "Back" then
                player:sendBlessings()
            end
        end

        -- Modal window design
        local window = ModalWindow {
            title = b1.name, -- Title of the modal window
            message = "Price: " .. b1.money .. " and " .. b1.quantity ..
                b1.itemName .. '.' ..
                "\n\nGives: \n5% Protection Loss;\n5% Bonus Healing;\n2% Reflection" -- The message to be displayed on the modal window
        }

        -- Add buttons to the window (Note: if you change the names of these you must change the functions in the modal window functionallity!)
        window:addButton("Yes", buttonAccept)
        window:addButton("Back", buttonAccept)
        window:addButton("Cancel")

        -- Set what button is pressed when the player presses enter or escape
        window:setDefaultEnterButton("Yes")
        window:setDefaultEscapeButton("Cancel")

        -- Send the window to player
        window:sendToPlayer(self)
    end

    function Player:Bless2()
        -- Modal Window Functionallity
        local function buttonAccept(button, choice)
            if button.text == "Yes" then
                if player:hasBlessing(2) then
                    player:say("I already have that bless!")
                    player:getPosition():sendMagicEffect(CONST_ME_POFF)
                elseif button.text == "Yes" and player:hasBlessing(1) and
                    player:getTotalMoney() >= b2.money and
                    enoughCurrency(player, b2.quantity) then
                    player:removeTotalMoney(b2.money)
                    changeCurrency(player, b1.item, b1.quantity)
                    player:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
                    -- !BUFFS
                    player:addBlessing(2)
                    player:setExtraHealingBase(healBase + b2.extraHealing)
                    player:setReflect(reflectBase + b2.reflect)
                    player:setProtectionAllBase(protecBase + b2.protectionAll)
                elseif not player:hasBlessing(1) then
                    player:say("I need the " .. b1.name .. " to buy this one")
                elseif player:getTotalMoney() <= b2.money then
                    player:say('I dont have enough money')
                    player:getPosition():sendMagicEffect(CONST_ME_POFF)
                elseif not enoughCurrency(player, b2.quantity) then
                    player:say('I dont have enough small energy balls')
                else
                    player:say("I need the previous bless!")
                    player:sendTextMessage(MESSAGE_STATUS_SMALL,
                                           "You need to have the previous bless " ..
                                               Bless1)
                end
            elseif button.text == "Back" then
                player:sendBlessings()
            end
        end

        -- Modal window design
        local window = ModalWindow {
            title = b2.name, -- Title of the modal window
            message = "Price: " .. b2.money .. " and " .. b2.quantity ..
                b2.itemName .. '.' ..
                "\n\n------------Extra------------: \n 5% Protection loss;\n5% Bonus Healing;\n4% Reflection;" -- The message to be displayed on the modal window
        }

        -- Add buttons to the window (Note: if you change the names of these you must change the functions in the modal window functionallity!)
        window:addButton("Yes", buttonAccept)
        window:addButton("Back", buttonAccept)
        window:addButton("Cancel")

        -- Set what button is pressed when the player presses enter or escape
        window:setDefaultEnterButton("Yes")
        window:setDefaultEscapeButton("Cancel")

        -- Send the window to player
        window:sendToPlayer(self)
    end

    function Player:Bless3()
        -- Modal Window Functionallity
        local function buttonAccept(button, choice)
            if button.text == "Yes" then
                if player:hasBlessing(3) then
                    player:say("I already have that bless!")
                    player:getPosition():sendMagicEffect(CONST_ME_POFF)
                elseif button.text == "Yes" and player:hasBlessing(1) and
                    player:hasBlessing(2) and player:getTotalMoney() >= b3.money and
                    enoughCurrency(player, b3.quantity) then
                    player:removeTotalMoney(b3.money)
                    changeCurrency(player, b3.item, b3.quantity)
                    player:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
                    -- !BUFFS
                    player:addBlessing(3)
                    player:setExtraHealingBase(healBase + b3.extraHealing)
                    player:setReflect(reflectBase + b3.reflect)
                    player:setProtectionAllBase(protecBase + b3.protectionAll)
                elseif not player:hasBlessing(2) then
                    player:say('I need the ' .. b2.name .. ' to buy this one')
                elseif player:getTotalMoney() <= b3.money then
                    player:say('I dont have enough money')
                    player:getPosition():sendMagicEffect(CONST_ME_POFF)
                elseif not enoughCurrency(player, b3.quantity) then
                    player:say('I dont have enough small energy balls')
                else
                    player:say('I need all the previous bless')
                end
            elseif button.text == "Back" then
                player:sendBlessings()
            end
        end

        -- Modal window design
        local window = ModalWindow {
            title = b3.name, -- Title of the modal window
            message = "Price: " .. b3.money .. " and " .. b3.quantity ..
                b3.itemName .. '.' ..
                "\n\n------------Extra------------ \n5% protection loss;\n1% Protection All; \n10% Bonus Healing;\n8% Reflection;" -- The message to be displayed on the modal window
        }

        -- Add buttons to the window (Note: if you change the names of these you must change the functions in the modal window functionallity!)
        window:addButton("Yes", buttonAccept)
        window:addButton("Back", buttonAccept)
        window:addButton("Cancel")

        -- Set what button is pressed when the player presses enter or escape
        window:setDefaultEnterButton("Yes")
        window:setDefaultEscapeButton("Cancel")

        -- Send the window to player
        window:sendToPlayer(self)
    end

    function Player:Bless4()
        -- Modal Window Functionallity
        local function buttonAccept(button, choice)
            if button.text == "Yes" then
                if player:hasBlessing(4) then
                    player:say("I already have that bless!")
                    player:getPosition():sendMagicEffect(CONST_ME_POFF)
                elseif button.text == "Yes" and player:hasBlessing(1) and
                    player:hasBlessing(2) and player:hasBlessing(3) and
                    player:getTotalMoney() >= b4.money and
                    enoughCurrency(player, b4.quantity) then
                    player:removeTotalMoney(b4.money)
                    changeCurrency(player, b4.item, b4.quantity)
                    player:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
                    -- !BUFFS
                    player:addBlessing(4)
                    player:setExtraHealingBase(healBase + b4.extraHealing)
                    player:setReflect(reflectBase + b4.reflect)
                    player:setProtectionAllBase(protecBase + b4.protectionAll)
                elseif not player:hasBlessing(3) then
                    player:say('I need the ' .. b3.name .. ' to buy this one')
                elseif player:getTotalMoney() <= b4.money then
                    player:say('I dont have enough money')
                    player:getPosition():sendMagicEffect(CONST_ME_POFF)
                elseif not enoughCurrency(player, b4.quantity) then
                    player:say('I dont have enough small energy balls')
                else
                    player:say("I need the previous bless!")
                end
            elseif button.text == "Back" then
                player:sendBlessings()
            end
        end

        -- Modal window design
        local window = ModalWindow {
            title = b4.name, -- Title of the modal window
            message = "Price: " .. b4.money .. " and " .. b4.quantity ..
                b4.itemName .. '.' ..
                "\n\n------------Extra------------ \n10% Protection loss;\n1% Protection all;\n15% Bonus Healing;\n16% Reflection;" -- The message to be displayed on the modal window
        }

        -- Add buttons to the window (Note: if you change the names of these you must change the functions in the modal window functionallity!)
        window:addButton("Yes", buttonAccept)
        window:addButton("Back", buttonAccept)
        window:addButton("Cancel")

        -- Set what button is pressed when the player presses enter or escape
        window:setDefaultEnterButton("Yes")
        window:setDefaultEscapeButton("Cancel")

        -- Send the window to player
        window:sendToPlayer(self)
    end

    function Player:Bless5()
        -- Modal Window Functionallity
        local function buttonAccept(button, choice)
            if button.text == "Yes" then
                if player:hasBlessing(5) then
                    player:say("I already have that bless!")
                    player:getPosition():sendMagicEffect(CONST_ME_POFF)
                elseif button.text == "Yes" and player:hasBlessing(1) and
                    player:hasBlessing(2) and player:hasBlessing(3) and
                    player:hasBlessing(4) and player:getTotalMoney() >= b5.money and
                    player:getItemCount(b5.item) >= b5.quantity then
                    player:removeTotalMoney(b5.money)
                    player:removeItem(b5.item, b5.quantity)
                    player:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
                    -- !BUFFS
                    player:addBlessing(5)
                    player:setExtraHealingBase(healBase + b5.extraHealing)
                    player:setReflect(reflectBase + b5.reflect)
                    player:setProtectionAllBase(protecBase + b5.protectionAll)
                elseif not player:hasBlessing(4) then
                    player:say('I need the ' .. b4.name .. ' to buy this one')
                elseif player:getTotalMoney() <= b5.money then
                    player:say('I dont have enough money')
                    player:getPosition():sendMagicEffect(CONST_ME_POFF)
                elseif player:getItemCount(b5.item) <= b5.quantity then
                    player:say('I dont have Warrior Coins enough')
                else
                    player:say("I need the previous bless!")
                end
            elseif button.text == "Back" then
                player:sendBlessings()
            end
        end

        -- Modal window design
        local window = ModalWindow {
            title = b5.name, -- Title of the modal window
            message = "Price: " .. b5.money .. " and " .. b5.quantity ..
                b5.itemName .. '.' ..
                "\n\n------------Extra------------ \n10% Protection loss;\n2% Protection all;\n20% Bonus Healing;\n32% Reflection;" -- The message to be displayed on the modal window
        }

        -- Add buttons to the window (Note: if you change the names of these you must change the functions in the modal window functionallity!)
        window:addButton("Yes", buttonAccept)
        window:addButton("Back", buttonAccept)
        window:addButton("Cancel")

        -- Set what button is pressed when the player presses enter or escape
        window:setDefaultEnterButton("Yes")
        window:setDefaultEscapeButton("Cancel")

        -- Send the window to player
        window:sendToPlayer(self)
    end

    function Player:Bless6()
        -- Modal Window Functionallity
        local function buttonAccept(button, choice)
            if button.text == "Yes" then
                if player:hasBlessing(6) then
                    player:say("I already have that bless!")
                    player:getPosition():sendMagicEffect(CONST_ME_POFF)
                elseif button.text == "Yes" and player:hasBlessing(1) and
                    player:hasBlessing(2) and player:hasBlessing(3) and
                    player:hasBlessing(4) and player:hasBlessing(5) and
                    player:getTotalMoney() >= b6.money and
                    player:getItemCount(b6.item) >= b6.quantity then
                    player:removeTotalMoney(b6.money)
                    player:removeItem(b6.item, b6.quantity)
                    player:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
                    -- !BUFFS
                    player:addBlessing(6)
                    player:setExtraHealingBase(healBase + b6.extraHealing)
                    player:setReflect(reflectBase + b6.reflect)
                    player:setProtectionAllBase(protecBase + b6.protectionAll)
                elseif not player:hasBlessing(5) then
                    player:say('I need the ' .. b5.name ..
                                   ' Blessing to buy this one')
                elseif player:getTotalMoney() <= b6.money then
                    player:say('I dont have enough money')
                    player:getPosition():sendMagicEffect(CONST_ME_POFF)
                elseif player:getItemCount(b6.item) <= b6.quantity then
                    player:say('I dont have ' .. b6.item .. ' enough')
                else
                    player:say("I need the previous bless!")
                end
            elseif button.text == "Back" then
                player:sendBlessings()
            end
        end

        -- Modal window design
        local window = ModalWindow {
            title = b6.name, -- Title of the modal window
            message = "Price: " .. b6.money .. " and " .. b6.quantity ..
                b6.itemName .. '.' ..
                "\n\n------------Extra------------ \n10% protection loss;\n5% protection all;\n25% Bonus Healing;\n64% Reflection;" -- The message to be displayed on the modal window
        }

        -- Add buttons to the window (Note: if you change the names of these you must change the functions in the modal window functionallity!)
        window:addButton("Yes", buttonAccept)
        window:addButton("Back", buttonAccept)
        window:addButton("Cancel")

        -- Set what button is pressed when the player presses enter or escape
        window:setDefaultEnterButton("Yes")
        window:setDefaultEscapeButton("Cancel")

        -- Send the window to player
        window:sendToPlayer(self)
    end

    player:sendBlessings()

end

action:aid(11011)
action:register()

local creatureevent = CreatureEvent("PlayerBless")

function creatureevent.onDeath(creature, corpse, killer, mostDamageKiller,
                               lastHitUnjustified, mostDamageUnjustified)
    -- BlessBuffRemove
    local player = Player(creature)
    local protecBase = player:getProtectionAllBase()
    local healBase = player:getExtraHealingBase()
    local reflectBase = player:getReflectBase()
    local totalRemoveHealing = 0
    local totalRemoveReflect = 0
    local totalRemoveProtectionAll = 0

    if not killer then return true end

    if creature:isPlayer() and not killer:isPlayer() then

        if player:hasBlessing(1) then
            totalRemoveHealing = totalRemoveHealing + b1.extraHealing
            totalRemoveReflect = totalRemoveReflect + b1.reflect
            totalRemoveProtectionAll = totalRemoveProtectionAll +
                                           b1.protectionAll
            player:removeBlessing(1)
        end
        if player:hasBlessing(2) then
            totalRemoveHealing = totalRemoveHealing + b2.extraHealing
            totalRemoveReflect = totalRemoveReflect + b2.reflect
            totalRemoveProtectionAll = totalRemoveProtectionAll +
                                           b2.protectionAll
            player:removeBlessing(2)
        end
        if player:hasBlessing(3) then
            totalRemoveHealing = totalRemoveHealing + b3.extraHealing
            totalRemoveReflect = totalRemoveReflect + b3.reflect
            totalRemoveProtectionAll = totalRemoveProtectionAll +
                                           b3.protectionAll
            player:removeBlessing(3)
        end
        if player:hasBlessing(4) then
            totalRemoveHealing = totalRemoveHealing + b4.extraHealing
            totalRemoveReflect = totalRemoveReflect + b4.reflect
            totalRemoveProtectionAll = totalRemoveProtectionAll +
                                           b4.protectionAll
            player:removeBlessing(4)
        end
        if player:hasBlessing(5) then
            totalRemoveHealing = totalRemoveHealing + b5.extraHealing
            totalRemoveReflect = totalRemoveReflect + b5.reflect
            totalRemoveProtectionAll = totalRemoveProtectionAll +
                                           b5.protectionAll
            player:removeBlessing(5)
        end
        player:setExtraHealingBase(healBase - totalRemoveHealing)
        player:setReflect(reflectBase - totalRemoveReflect)
        player:setProtectionAllBase(protecBase - totalRemoveProtectionAll)
    end
    if creature:isPlayer() and killer:isPlayer() then
        if player:hasBlessing(6) then
            player:setExtraHealingBase(healBase - b6.extraHealing)
            player:setReflect(reflectBase - b6.reflect)
            player:setProtectionAllBase(protecBase - b6.protectionAll)
            player:removeBlessing(6)
        end
    end
end

creatureevent:register()

local globalevent = GlobalEvent("load_Blessing")
function globalevent.onStartup()
    local tile = Tile(Position(852, 876, 5))
    if tile then
        -- local ground = tile:getGround()
        local thing = tile:getTopVisibleThing()
        if thing then
            local AID = 11011
            thing:setUnmovable()
            thing:setAttribute(ITEM_ATTRIBUTE_ACTIONID, AID)
        end
    end
end

globalevent:register()

local talkAction = TalkAction("!removeBlessings")

function talkAction.onSay(player, words, param, type)
    for i = 1, 6 do
        player:removeBlessing(i)
    end
    return false
end

talkAction:accountType(ACCOUNT_TYPE_GOD)
--talkAction:access(true)
--talkAction:separator(" ")
talkAction:register()
