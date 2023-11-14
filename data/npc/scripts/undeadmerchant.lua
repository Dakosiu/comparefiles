local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)            npcHandler:onCreatureAppear(cid)        end
function onCreatureDisappear(cid)        npcHandler:onCreatureDisappear(cid)        end
function onCreatureSay(cid, type, msg)        npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                npcHandler:onThink()                end

function AssassinFirst(cid, message, keywords, parameters, node)

    if(not npcHandler:isFocused(cid)) then
        return false
    end

    
        if getPlayerItemCount(cid,11360) >= 100 then
        if doPlayerRemoveItem(cid,11360,100) then
            npcHandler:say('Here is your item!', cid)
            doPlayerAddItem(cid,9020,1)
        end
        else
            npcHandler:say('You don\'t have 100 undead hearts!', cid)
        end
    end

keywordHandler:addKeyword({'help'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I can exchange 100 undead hearts for 1 Boss token."})

local node = keywordHandler:addKeyword({'change'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Do you want to trade 100 undead hearts for 1 Boss token?'})
    node:addChildKeyword({'yes'}, AssassinFirst, {npcHandler = npcHandler, onlyFocus = true, reset = true})
    node:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Alright then. Come back when you got the neccessary items.', reset = true})
npcHandler:addModule(FocusModule:new())
