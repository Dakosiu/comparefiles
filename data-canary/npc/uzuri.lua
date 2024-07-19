local npcName = "Uzuri"

local npcType = Game.createNpcType(npcName)
local npcConfig = {}

npcConfig.name = npcName
npcConfig.description = npcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 10

npcConfig.outfit = {
	lookType = 145,
    lookHead = 95,
    lookBody = 109,
    lookLegs = 114,
    lookFeet = 114,
    lookAddons = 3,
    lookMount = 0
}

npcConfig.flags = {
	floorchange = false
}

-- Create keywordHandler and npcHandler
local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)

-- onThink
npcType.onThink = function(npc, interval)
	npcHandler:onThink(npc, interval)
end

-- onAppear
npcType.onAppear = function(npc, creature)
	npcHandler:onAppear(npc, creature)
end

-- onDisappear
npcType.onDisappear = function(npc, creature)
	npcHandler:onDisappear(npc, creature)
end

-- onMove
npcType.onMove = function(npc, creature, fromPosition, toPosition)
	npcHandler:onMove(npc, creature, fromPosition, toPosition)
end

-- onSay
npcType.onSay = function(npc, creature, type, message)
	npcHandler:onSay(npc, creature, type, message)
end

-- onPlayerCloseChannel
npcType.onCloseChannel = function(npc, player)
	npcHandler:onCloseChannel(npc, player)
end

-- On buy npc shop message
npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
	npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
end

-- On sell npc shop message
npcType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, name, totalCost)
	player:sendTextMessage(MESSAGE_TRADE, string.format("Sold %ix %s for %i gold.", amount, name, totalCost))
end

-- On check npc shop message (look item)
npcType.onCheckItem = function(npc, player, clientId, subType)
end

local paymentItemId = 19083
local itemsForSale = {
    ["Strike Enhancement"] = {price = 10, id = 36724},
    ["Stamina Extension"] = {price = 5, id = 36725}, 
	["Charm Upgrade"] = {price = 5, id = 36726},
	["Wealth Duplex"] = {price = 5, id = 36727},
	["Bestiary Betterment"] = {price = 5, id = 36728},
	["Power Amplification"] = {price = 5, id = 34362},
	["Defense Amplification"] = {price = 5, id = 34363},
}

local talkState = {}

-- On creature say callback
local function creatureSayCallback(npc, player, type, msg)
	local playerId = player:getId()
	if not npcHandler:checkInteraction(npc, player) then
		return false
	end

    local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or player
    local t = itemsForSale[msg:lower()]
    
    if t then
        npcHandler:say("Do you want to pay "..t.price.."x "..ItemType(paymentItemId):getName().." for a "..msg.."?", npc, player)
        talkState[talkUser] = 1
        xmsg = msg:lower()
    elseif MsgContains(msg:lower(), "yes") and talkState[talkUser] == 1 then
        t = itemsForSale[xmsg]
        if player:getItemCount(paymentItemId) >= t.price then
            if player:addItem(t.id, 1) then
                player:removeItem(paymentItemId, t.price)
                npcHandler:say("You bought a "..xmsg.." for "..t.price.."x "..ItemType(paymentItemId):getName().."!", npc, player)
            else
                npcHandler:say("You do not have enough capacity or free slots!", npc, player)
            end
        else
            npcHandler:say("Sorry, you do not have enough "..ItemType(paymentItemId):getName().."!", npc, player)
        end
        talkState[talkUser] = 0
    else
        npcHandler:say('What? Please tell me a correct item name!', npc, player)
        talkState[talkUser] = 0
    end
	
    return true
end

-- Set to local function "creatureSayCallback"
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

-- Generate item list for greet message
local itemList = ""
for itemName in pairs(itemsForSale) do
    itemList = itemList .. "{" .. itemName .. "}, "
end
itemList = itemList:sub(1, -3)

npcHandler:setMessage(MESSAGE_GREET, "Welcome |PLAYERNAME|! I am selling items: " .. itemList .. ".")

npcHandler:addModule(FocusModule:new())

-- Register npc
npcType:register(npcConfig)
