--[[ local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end

function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end

function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end

function onThink() npcHandler:onThink() end

local function startQuests(cid, type, msg)
    local player, cmsg = Player(cid)

    if (not npcHandler:isFocused(cid)) then
        return false
    end

    for i in pairs(NPCTasks) do
        for a = 0, 6 do
            local b = NPCTasks[a]
            player:setStorageValue(39001, -1)
            if player:getStorageValue(b.Storage) == -1 then -- ==-1
                if b.itemsToBring then
                    local c = b.itemsToBring
                    local toSay
                    for v, k in pairs(b.itemsToBring) do
                        if v == 10 then
                            toSay = "Can you bring me these items? : " ..
                                c[2] ..
                                " " ..
                                getItemName(c[1]) ..
                                ", " ..
                                c[4] ..
                                " " ..
                                getItemName(c[3]) ..
                                ", " ..
                                c[6] ..
                                " " ..
                                getItemName(c[5]) ..
                                ", " ..
                                c[8] .. " " .. getItemName(c[7]) .. ", " .. c[10] .. " " .. getItemName(c[9]) .. "."
                        elseif v == 8 then
                            toSay = "Can you bring me these items? : " ..
                                c[2] ..
                                " " ..
                                getItemName(c[1]) ..
                                ", " ..
                                c[4] ..
                                " " ..
                                getItemName(c[3]) ..
                                ", " .. c[6] .. " " ..
                                getItemName(c[5]) .. ", " .. c[8] .. " " .. getItemName(c[7]) .. "."
                        elseif v == 6 then
                            toSay = "Can you bring me these items? : " ..
                                c[2] ..
                                " " ..
                                getItemName(c[1]) ..
                                ", " .. c[4] .. " " ..
                                getItemName(c[3]) .. ", " .. c[6] .. " " .. getItemName(c[5]) .. "."
                        elseif v == 4 then
                            toSay = "Can you bring me these items? : " ..
                                c[2] .. " " .. getItemName(c[1]) .. ", " .. c[4] .. " " .. getItemName(c[3]) .. "."
                        elseif v == 2 then
                            toSay = "Can you bring me this items: " .. c[2] .. " " .. getItemName(c[1]) .. "."
                        end
                    end
                    npcHandler:say(toSay, cid)
                    player:setStorageValue(b.Storage, 1)
                    --player:sendTextMessage(MESSAGE_STATUS_ADVANCE, "Bring me these items: " .. c[2] " " ..getItemName(c[1]) ..", " .. c[4] .. " " .. getItemName(c[3]) .. ", " .. c[6] .. " " .. getItemName(c[5]) .. ".")
                    --npcHandler:say(b.TakeTaskMessage, cid)
                    return false
                end
                if b.creature then
                    local c = b.creature
                    local d = b.Quantity
                    for v, k in pairs(c) do
                        if v == 10 then
                            toSay = "You need to kill: " ..
                                d ..
                                " " ..
                                c[1] ..
                                ", " ..
                                c[2] ..
                                ", " ..
                                c[3] ..
                                ", " ..
                                c[4] ..
                                ", " ..
                                c[5] ..
                                ", " .. c[6] .. ", " .. c[7] .. ", " .. c[8] .. ", " .. c[9] .. ", " .. c[10] .. "."
                        elseif v == 9 then
                            toSay = "You need to kill: " ..
                                d ..
                                " " ..
                                c[1] ..
                                ", " ..
                                c[2] ..
                                ", " ..
                                c[3] ..
                                ", " ..
                                c[4] ..
                                ", " .. c[5] .. ", " .. c[6] .. ", " .. c[7] .. ", " .. c[8] .. ", " .. c[9] .. "."
                        elseif v == 8 then
                            toSay = "You need to kill: " ..
                                d ..
                                " " ..
                                c[1] ..
                                ", " ..
                                c[2] ..
                                ", " ..
                                c[3] ..
                                ", " .. c[4] .. ", " .. c[5] .. ", " .. c[6] .. ", " .. c[7] .. ", " .. c[8] .. "."
                        elseif v == 7 then
                            toSay = "You need to kill: " ..
                                d ..
                                " " ..
                                c[1] ..
                                ", " ..
                                c[2] ..
                                ", " .. c[3] .. ", " .. c[4] .. ", " .. c[5] .. ", " .. c[6] .. ", " .. c[7] .. "."
                        elseif v == 6 then
                            toSay = "You need to kill: " ..
                                d ..
                                " " ..
                                c[1] ..
                                ", " .. c[2] .. ", " .. c[3] .. ", " .. c[4] .. ", " .. c[5] .. ", " .. c[6] .. "."
                        elseif v == 5 then
                            toSay = "You need to kill: " ..
                                d .. " " .. c[1] .. ", " .. c[2] .. ", " .. c[3] .. ", " .. c[4] .. ", " .. c[5] .. "."
                        elseif v == 4 then
                            toSay = "You need to kill: " ..
                                d .. " " .. c[1] .. ", " .. c[2] .. ", " .. c[3] .. ", " .. c[4] .. "."
                        elseif v == 3 then
                            toSay = "You need to kill: " .. d .. " " .. c[1] .. ", " .. c[2] .. ", " .. c[3] .. "."
                        elseif v == 2 then
                            toSay = "You need to kill: " .. d .. " " .. c[1] .. ", " .. c[2] .. "."
                        else
                            toSay = "You need to kill: " .. d .. " " .. c[1] .. "."
                        end
                    end
                    npcHandler:say(toSay, cid)
                    --player:sendTextMessage(MESSAGE_STATUS_ADVANCE, "You need to kil: " .. b.Quantity .. " " .. b.creature)
                    --player:setStorageValue(b.Storage, 1)
                    --player:setStorageValue(b.Storage * 2, 0)
                    return false
                end
                if b.boss then
                    npcHandler:say("You need to kil: " .. b.Quantity .. " " .. b.creature, cid)
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
                        npcHandler:say(b.lastMessage, cid)
                        player:removeItem(c[1], c[2])
                        player:addItem(b.reward.items[1], b.reward.items[2])
                        player:addStatsPoint(b.reward.statsPoint)
                        player:addExperience(b.reward.experience)
                        player:setStorageValue(b.Storage, 2)
                    else
                        npcHandler:say("You cannot fool me, go away.", cid)
                    end
                    return false
                end
            end
            if player:getStorageValue(b.Storage) == 3 then
                if b.creature then
                    if player:getStorageValue(b.Storage) == 3 then
                        npcHandler:say(b.lastMessage, cid)
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
                        npcHandler:say(b.lastMessage, cid)
                        player:addItem(b.reward.items[1], b.reward.items[2])
                        player:addStatsPoint(b.reward.statsPoint)
                        player:addExperience(b.reward.experience)
                        player:setStorageValue(b.Storage, 2)
                    else
                        npcHandler:say("You cannot fool me, go away.", cid)
                    end
                    return false
                end
            end
            if player:getStorageValue(b.Storage) == 2 then
                npcHandler:say("You already completed all my missions.", cid)
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
node2 = keywordHandler:addKeyword({ 'report' }, StdModule.say,
    { npcHandler = npcHandler, onlyFocus = true, text = 'So you already finished your mission ?' })
node2:addChildKeyword({ 'yes' }, startQuests, {})
node2:addChildKeyword({ 'no' }, StdModule.say,
    { npcHandler = npcHandler, onlyFocus = true, text = 'Alright then. Come back when have finished it.', reset = true })


npcHandler:addModule(FocusModule:new())
 --]]