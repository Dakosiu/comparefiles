local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end

function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end

function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end

function onThink() npcHandler:onThink() end

function startQuests(cid, type, msg, message, keywords, parameters, node)
    local player, cmsg = Player(cid)

    if (not npcHandler:isFocused(cid)) then
        return false
    end

    for i in pairs(NPCTasks) do
        for a = 7, 13 do
            local b = NPCTasks[a]
            if player:getStorageValue(b.Storage) == -1 then
                if b.itemsToBring then
                    local c = b.itemsToBring
                    --player:sendTextMessage(MESSAGE_STATUS_ADVANCE, "Bring me these items: " .. c[2] " " ..getItemName(c[1]) ..", " .. c[4] .. " " .. getItemName(c[3]) .. ", " .. c[6] .. " " .. getItemName(c[5]) .. ".")
                    npcHandler:say("Bring me these items: " .. c[2] .. " " .. getItemName(c[1]), cid)
                    player:setStorageValue(b.Storage, 1)
                    return false
                end
                if b.creature then
                    npcHandler:say("You need to kil: " .. b.Quantity .. " " .. b.creature .. ".", cid)
                    --player:sendTextMessage(MESSAGE_STATUS_ADVANCE, "You need to kil: " .. b.Quantity .. " " .. b.creature)
                    player:setStorageValue(b.Storage, 1)
                    player:setStorageValue(b.Storage * 2, 0)
                    return false
                end
                if b.boss then
                    npcHandler:say("You need to kil: " .. b.Quantity .. " " .. b.boss .. ".", cid)
                    --player:sendTextMessage(MESSAGE_STATUS_ADVANCE, "You need to kil: " .. b.Quantity .. " " .. b.creature)
                    player:setStorageValue(b.Storage, 1)
                    player:setStorageValue(b.Storage * 2, 0)
                    return false
                end
            end
            if player:getStorageValue(b.Storage) == 1 then
                if b.itemsToBring then
                    local c = b.itemsToBring
                    if player:getItemCount(c[1]) >= c[2] then
                        npcHandler:say("Thanks for your service.", cid)
                        player:removeItem(c[1], c[2])
                        player:addItem(b.reward.items[1], b.reward.items[2])
                        player:addStatsPoint(b.reward.statsPoint)
                        player:addExperience(b.reward.experience)
                        player:setStorageValue(b.Storage, 2)
                    else
                        npcHandler:say("Bring me these items: " .. c[2] .. " " .. getItemName(c[1]), cid)
                    end
                    return false
                end
            end
            if player:getStorageValue(b.Storage) == 3 then
                if b.creature then
                    if player:getStorageValue(b.Storage) == 3 then
                        npcHandler:say("Thanks for your service.", cid)
                        player:addItem(b.reward.items[1], b.reward.items[2])
                        player:addStatsPoint(b.reward.statsPoint)
                        player:addExperience(b.reward.experience)
                        player:setStorageValue(b.Storage, 2)
                    else
                        npcHandler:say("You need to kil: " .. b.Quantity .. " " .. b.creature .. ".", cid)
                    end
                    return false
                end
                if b.boss then
                    if player:getStorageValue(b.Storage) == 3 then
                        npcHandler:say("Thanks for your service.", cid)
                        player:addItem(b.reward.items[1], b.reward.items[2])
                        player:addStatsPoint(b.reward.statsPoint)
                        player:addExperience(b.reward.experience)
                        player:setStorageValue(b.Storage, 2)
                    else
                        npcHandler:say("You need to kil: " .. b.Quantity .. " " .. b.boss .. ".", cid)
                    end
                    return false
                end
            end
            if player:getStorageValue(b.Storage) == 2 then
                npcHandler:say("You already finishehd all your tasks.", cid)
            end
        end
    end
end

keywordHandler:addKeyword({ 'help' }, StdModule.say,
    { npcHandler = npcHandler, onlyFocus = true,
        text = "Can you make me some {missions} in trade of some worthy things ? " })
node1 = keywordHandler:addKeyword({ 'missions' }, StdModule.say,
    { npcHandler = npcHandler, onlyFocus = true, text = 'Okay, so you want to see your missions, {yes} or {no} ?' })
node1:addChildKeyword({ 'yes' }, startQuests, {})
node1:addChildKeyword({ 'no' }, StdModule.say,
    { npcHandler = npcHandler, onlyFocus = true, text = 'Alright then. Come back when you want.', reset = true })


npcHandler:addModule(FocusModule:new())
