local npcName = "Felix Garmentmaker"

local npcType = Game.createNpcType(npcName)
local npcConfig = {}

npcConfig.name = npcName
npcConfig.description = npcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000000
npcConfig.walkRadius = 1

npcConfig.outfit = {
	lookType = 1210,
	lookHead = 114,
	lookBody = 77,
	lookLegs = 94,
	lookFeet = 0,
	lookAddons = 3,
	lookMount = 0
}

npcConfig.flags = {
	floorchange = false
}


addoninfo = {
['first hunter addon'] = {cost = 0, items = {{5876,50}, {5948,50}, {5891,5}, {5887,1}, {5889,1}, {5888,1}}, outfit_female = 137, outfit_male = 129, addon = 1, storageID = 10044},
['second hunter addon'] = {cost = 0, items = {{5875,1}}, outfit_female = 137, outfit_male = 129, addon = 2, storageID = 10045},
['first knight addon'] = {cost = 0, items = {{5880,50}, {5892,1}}, outfit_female = 139, outfit_male = 131, addon = 1, storageID = 10046},
['second knight addon'] = {cost = 0, items = {{5893,50}, {11422,1}, {5885,1}, {5887,1}}, outfit_female = 139, outfit_male = 131, addon = 2, storageID = 10047},
['first mage addon'] = {cost = 0, items = {{2182,1}, {2186,1}, {2185,1}, {8911,1}, {2181,1}, {2183,1}, {2190,1}, {2191,1}, {2188,1}, {8921,1}, {2189,1}, {2187,1}, {2392,30}, {5809,1}, {2193,20}}, outfit_female = 138, outfit_male = 130, addon = 1, storageID = 10048},
['second mage addon'] = {cost = 0, items = {{5903,1}}, outfit_female = 138, outfit_male = 130, addon = 2, storageID = 10049},
['first barbarian addon'] = {cost = 0, items = {{5884,1}, {5885,1}, {5910,25}, {5911,25}, {5886,10}}, outfit_female = 147, outfit_male = 143, addon = 1, storageID = 10011},
['second barbarian addon'] = {cost = 0, items = {{5880,25}, {5892,1}, {5893,25}, {5876,25}}, outfit_female = 147, outfit_male = 143, addon = 2, storageID = 10012},
['first druid addon'] = {cost = 0, items = {{5896,20}, {5897,20}}, outfit_female = 148, outfit_male = 144, addon = 1, storageID = 10013},
['second druid addon'] = {cost = 0, items = {{5906,100}}, outfit_female = 148, outfit_male = 144, addon = 2, storageID = 10014},
['first nobleman addon'] = {cost = 300000, items = {}, outfit_female = 140, outfit_male = 132, addon = 1, storageID = 10015},
['second nobleman addon'] = {cost = 300000, items = {}, outfit_female = 140, outfit_male = 132, addon = 2, storageID = 10016},
['first warrior addon'] = {cost = 0, items = {{5925,40}, {5899,40}, {5884,1}, {5919,1}}, outfit_female = 142, outfit_male = 134, addon = 1, storageID = 10019},
['second warrior addon'] = {cost = 0, items = {{5880,40}, {5887,1}}, outfit_female = 142, outfit_male = 134, addon = 2, storageID = 10020},
['first wizard addon'] = {cost = 0, items = {{2536,1}, {2492,1}, {2488,1}, {2123,1}}, outfit_female = 149, outfit_male = 145, addon = 1, storageID = 10021},
['second wizard addon'] = {cost = 0, items = {{5922,40}, {2472,10}}, outfit_female = 149, outfit_male = 145, addon = 2, storageID = 10022},
['first assassin addon'] = {cost = 0, items = {{5912,20}, {5910,20}, {5911,20}, {5913,20}, {5914,20}, {5909,20}, {5886,10}}, outfit_female = 156, outfit_male = 152, addon = 1, storageID = 10023},
['second assassin addon'] = {cost = 0, items = {{5804,1}, {5930,10}}, outfit_female = 156, outfit_male = 152, addon = 2, storageID = 10024},
['first beggar addon'] = {cost = 0, items = {{5878,30}, {5921,20}, {5913,10}, {5894,10}}, outfit_female = 157, outfit_male = 153, addon = 1, storageID = 10025},
['second beggar addon'] = {cost = 0, items = {{5883,30}, {2160,2}}, outfit_female = 157, outfit_male = 153, addon = 2, storageID = 10026},
['first pirate addon'] = {cost = 0, items = {{6098,30}, {6126,30}, {6097,30}}, outfit_female = 155, outfit_male = 151, addon = 1, storageID = 10027},
['second pirate addon'] = {cost = 0, items = {{6101,1}, {6102,1}, {6100,1}, {6099,1}}, outfit_female = 155, outfit_male = 151, addon = 2, storageID = 10028},
['first shaman addon'] = {cost = 0, items = {{5810,5}, {3955,5}, {5015,1}}, outfit_female = 158, outfit_male = 154, addon = 1, storageID = 10029},
['second shaman addon'] = {cost = 0, items = {{3966,5}, {3967,5}}, outfit_female = 158, outfit_male = 154, addon = 2, storageID = 10030},
['first norseman addon'] = {cost = 0, items = {{7290,5}}, outfit_female = 252, outfit_male = 251, addon = 1, storageID = 10031},
['second norseman addon'] = {cost = 0, items = {{7290,10}}, outfit_female = 252, outfit_male = 251, addon = 2, storageID = 10032}
-- next storage 10052    -- next storage 10052    -- next storage 10052    -- next storage 10052    -- next storage 10052    -- next storage 10052    -- next storage 10052 --
}

local o = {'hunter', 'knight', 'mage', 'nobleman', 'warrior', 'barbarian', 'druid', 'wizard', 'pirate', 'assassin', 'beggar', 'shaman', 'norseman'}
local rtnt = {}

local talkState = {}

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

-- Function called by the callback "npcHandler:setCallback(CALLBACK_GREET, greetCallback)" in end of file
local function greetCallback(npc, player)
	npcHandler:setMessage(MESSAGE_GREET, "Hello |PLAYERNAME|, you need more info about {canary}?")
	return true
end


-- On creature say callback
local function creatureSayCallback(npc, player, type, msg)

	local playerId = player:getId()
	if not npcHandler:checkInteraction(npc, player) then
		return false
	end
	
	local talkUser = player:getId()

    if addoninfo[msg] ~= nil then
        if player:hasOutfit(addoninfo[msg].outfit_male, addoninfo[msg].addon) or player:hasOutfit(addoninfo[msg].outfit_female, addoninfo[msg].addon) then
                npcHandler:say('You already have this addon!', npc, player)
				
               -- npcHandler:resetNpc()
        else
        local itemsTable = addoninfo[msg].items
        local items_list = ''
            if table.maxn(itemsTable) > 0 then
                for i = 1, table.maxn(itemsTable) do
                    local item = itemsTable[i]
                    items_list = items_list .. item[2] .. ' ' .. ItemType(item[1]):getName()
                    if i ~= table.maxn(itemsTable) then
                        items_list = items_list .. ', '
                    end
                end
            end
        local text = ''
            if (addoninfo[msg].cost > 0) then
                text = addoninfo[msg].cost .. ' gp'
            elseif table.maxn(addoninfo[msg].items) then
                text = items_list
            elseif (addoninfo[msg].cost > 0) and table.maxn(addoninfo[msg].items) then
                text = items_list .. ' and ' .. addoninfo[msg].cost .. ' gp'
            end
            npcHandler:say('For ' .. msg .. ' you will need ' .. text .. '. Do you have it all with you?', npc, player)
            rtnt[talkUser] = msg
            talkState[talkUser] = addoninfo[msg].storageID
            return true
        end
    elseif MsgContains(msg, "yes") then
        if (talkState[talkUser] > 10010 and talkState[talkUser] < 10100) then
            local items_number = 0
            if table.maxn(addoninfo[rtnt[talkUser]].items) > 0 then
                for i = 1, table.maxn(addoninfo[rtnt[talkUser]].items) do
                    local item = addoninfo[rtnt[talkUser]].items[i]
                    if (getPlayerItemCount(player,item[1]) >= item[2]) then
                        items_number = items_number + 1
                    end
                end
            end
            if(getPlayerMoney(player) >= addoninfo[rtnt[talkUser]].cost) and (items_number == table.maxn(addoninfo[rtnt[talkUser]].items)) then
                doPlayerRemoveMoney(player, addoninfo[rtnt[talkUser]].cost)
                if table.maxn(addoninfo[rtnt[talkUser]].items) > 0 then
                    for i = 1, table.maxn(addoninfo[rtnt[talkUser]].items) do
                        local item = addoninfo[rtnt[talkUser]].items[i]
                        doPlayerRemoveItem(player,item[1],item[2])
                    end
                end
				
                player:addOutfitAddon(addoninfo[rtnt[talkUser]].outfit_male, addoninfo[rtnt[talkUser]].addon)
                player:addOutfitAddon(addoninfo[rtnt[talkUser]].outfit_female, addoninfo[rtnt[talkUser]].addon, true)
                setPlayerStorageValue(player,addoninfo[rtnt[talkUser]].storageID,1)
                npcHandler:say('Here you are.', npc, player)
            else
                npcHandler:say('You do not have needed items!', npc, player)
            end
            rtnt[talkUser] = nil
            talkState[talkUser] = 0
            --npcHandler:resetNpc()
            return true
        end
    elseif MsgContains(msg, "addon") then
        npcHandler:say('I can give you addons for {' .. table.concat(o, "}, {") .. '} outfits.', npc, player)
        rtnt[talkUser] = nil
        talkState[talkUser] = 0
        --npcHandler:resetNpc()
        return true
    elseif MsgContains(msg, "help") then
        npcHandler:say('To buy the first addon say \'first NAME addon\', for the second addon say \'second NAME addon\'.', npc, player)
        rtnt[talkUser] = nil
        talkState[talkUser] = 0
        --npcHandler:resetNpc()
        return true
    else
        if talkState[talkUser] ~= nil then
            if talkState[talkUser] > 0 then
            npcHandler:say('Come back when you get these items.', npc, player)
            rtnt[talkUser] = nil
            talkState[talkUser] = 0
            --npcHandler:resetNpc()
            return true
            end
        end
    end
    return true
end

-- Set to local function "greetCallback"
--npcHandler:setCallback(CALLBACK_GREET, greetCallback)

-- Set to local function "creatureSayCallback"
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

-- Bye message
--npcHandler:setMessage(MESSAGE_FAREWELL, "Yeah, good bye and don't come again!")
-- Walkaway message
--npcHandler:setMessage(MESSAGE_WALKAWAY, "You not have education?")

npcHandler:setMessage(MESSAGE_GREET, "Greetings |PLAYERNAME|. I need your help and I'll reward you with nice addons if you help me! Just say {addons} or {help} if you don't know what to do.")

npcHandler:addModule(FocusModule:new())

-- Register npc
npcType:register(npcConfig)
