local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end

function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end

function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end

function onThink() npcHandler:onThink() end

local voices = {
    {text = 'Hello there, adventurer! Looking for some quests ? I\'m your man!'}
}
npcHandler:addModule(VoiceModule:new(voices))

local function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then return false end
    local player = Player(cid)

    local min = 139
    local max = 151

    local a
    local function getStorage()
        for i = min, max do
            a = NPCTasks[i]
            if player:getStorageValue(a.Storage) ~= 2 then
                b = a
                local value = a
                return value
            end
        end
    end

    local function getPositiveStorage()
        for i = min, max do
            a = NPCTasks[i]
            if player:getStorageValue(a.Storage) == 2 then
                b = a
                local value = a
                return value
            end
        end
    end

    if npcHandler.topic[cid] == 0 then
        if msgcontains(msg, 'tasks') or msgcontains(msg, 'missions') or
            msgcontains(msg, 'help') then
            npcHandler.topic[cid] = 1
            local value = getStorage()
            local b = value
            if not value then
                npcHandler:say("You already made all my tasks", cid)
                return false
            end
            if player:getVocation():getId() == 0 then
                npcHandler:say("You need a vocation to take my tasks", cid)
                npcHandler:releaseFocus(cid)
                npcHandler:resetNpc(cid)
                return false
            end
            if player:getStorageValue(b.Storage) ~= 2 and npcHandler.topic[cid] ==
                1 then -- ! Doesnt has tasks
                if b.itemsToBring then
                    local c = b.itemsToBring
                    local toSay
                    local amount = #b.itemsToBring
                    local itemList = ""

                    for i = 1, amount, 2 do
                        itemList = itemList .. c[i + 1] .. " " ..
                                       getItemName(c[i]) .. ", "
                    end
                    itemList = string.sub(itemList, 1, -3)
                    toSay = "Can you bring me these items: " .. itemList ..
                                " {yes} or {no} ?"

                    if player:getStorageValue(b.Storage) == 1 then
                        npcHandler:say(
                            "You didnt finished your task. " .. toSay ..
                                " If you already have the items, you should {report} the quest.",
                            cid)
                        npcHandler.topic[cid] = 0
                        return false
                    end
                    npcHandler:say(toSay, cid)
                    npcHandler.topic[cid] = 2
                end
                if b.creature then
                    local toSay
                    local c = b.creature
                    local d = b.Quantity
                    local v = #c
                    if v > 0 then
                        toSay = "Can you kill ? " .. d .. " " ..
                                    table.concat(c, ", ") .. "."
                    else
                        toSay = "Can you kill ? 0 creatures."
                    end
                    if player:getStorageValue(b.Storage) == 1 then -- ! Incomplete Quest
                        npcHandler:say(
                            "You didnt finished your task. " .. toSay, cid)
                        return false
                    end
                    if player:getStorageValue(b.Storage) == 3 then
                        npcHandler:say(
                            "Seems that you already finished your mission, you should {report} it.",
                            cid)
                        npcHandler.topic[cid] = 0
                        return false
                    end
                    npcHandler.topic[cid] = 2
                    npcHandler:say(toSay, cid)
                    return false
                end
                if b.boss then
                    if player:getStorageValue(b.Storage) == 1 then -- ! Incomplete Quest
                        npcHandler:say(
                            "You didnt finished your task. " .. toSay, cid)
                        return false
                    end
                    if player:getStorageValue(b.Storage) == 3 then
                        npcHandler:say(
                            "Seems that you already finished your mission, you should {report} it.",
                            cid)
                        npcHandler.topic[cid] = 0
                        return false
                    end
                    npcHandler:say("You need to kil the " .. b.boss[1] ..
                                       " you accept it? {yes} or {no}", cid)
                    npcHandler.topic[cid] = 2
                    return false
                end
            end
        elseif msgcontains(msg, "report") then
            local value = getStorage()
            local b = value
            if not value then
                npcHandler:say("You already made all my tasks", cid)
                return false
            end
            if player:getStorageValue(b.Storage) == 1 or
                player:getStorageValue(b.Storage) == 3 then
                if b.itemsToBring then
                    local c = b.itemsToBring
                    local amount = 0
                    for _ in pairs(b.itemsToBring) do
                        amount = amount + 1
                    end
                    local has_all_items = true
                    for i = 1, amount, 2 do
                        if player:getItemCount(c[i]) < c[i + 1] then
                            has_all_items = false
                            break
                        end
                    end
                    if has_all_items then
                        for i = 1, amount, 2 do
                            player:removeItem(c[i], c[i + 1])
                        end
                        local rewards = b.reward
                        player:addNpcReward(rewards)
                        player:setStorageValue(b.Storage, 2)
                        npcHandler:say(b.lastMessage, cid)
                        npcHandler.topic[cid] = 0
                        return false
                    else
                        npcHandler:say("You don't have all the items.", cid)
                    end
                end

                if b.creature then
                    local rewards = b.reward
                    if player:getStorageValue(b.Storage) == 3 then
                        player:addNpcReward(rewards)
                        npcHandler:say(b.lastMessage, cid)
                        player:setStorageValue(b.Storage, 2)
                    else
                        npcHandler:say("You cannot fool me, go away!.", cid)
                    end
                end
                if b.boss then
                    local rewards = b.reward
                    if player:getStorageValue(b.Storage) == 3 then
                        player:addNpcReward(rewards)
                        npcHandler:say(b.lastMessage, cid)
                        player:setStorageValue(b.Storage, 2)
                    else
                        npcHandler:say("You cannot fool me, go away!.", cid)
                    end
                end
            else
                npcHandler:say("You don't have any task to report.", cid)
            end
        end
    end

    if msgcontains(msg, "yes") then
        if npcHandler.topic[cid] == 2 and player:getStorageValue(b.Storage) == 2 or
            npcHandler.topic[cid] == 2 and player:getStorageValue(b.Storage) ==
            3 then
            if b.itemsToBring then
                player:setStorageValue(b.Storage, 2)
                npcHandler:say(b.lastMessage, cid)
            end
            if b.creature then
                player:setStorageValue(b.Storage, 2)
                npcHandler:say(b.lastMessage, cid)
            end
            if b.boss then
                player:setStorageValue(b.Storage, 2)
                npcHandler:say(b.lastMessage, cid)
            end
        elseif npcHandler.topic[cid] == 2 and player:getStorageValue(b.Storage) ==
            2 then
            player:setStorageValue(b.Storage, 1)
            npcHandler:say(b.TakeTaskMessage, cid)
            npcHandler.topic[cid] = 0
        end
        if npcHandler.topic[cid] == 2 and player:getStorageValue(b.Storage) ==
            -1 then
            player:setStorageValue(b.Storage, 1)
            npcHandler.topic[cid] = 0
            npcHandler:say(b.TakeTaskMessage, cid)
            if b.creature or b.boss then
                player:setStorageValue(b.Storage * 2, 0)
            end
        end
    end
end

keywordHandler:addKeyword({'quests'}, StdModule.say, {
    npcHandler = npcHandler,
    text = "I can give you some good rewards in trade of some tasks."
})

npcHandler:setMessage(MESSAGE_GREET,
                      "Hey |PLAYERNAME|, can you help me in some {tasks} ?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye and come again, |PLAYERNAME|.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
