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
local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
if(msgcontains(msg, 'quest')) then
selfSay('Ok, you can started "first mission"?', cid)
end
---------------------------------------------------------
if(msgcontains(msg, 'first mission')) then
selfSay('Please bring me 600 soul orbs "soul orb"', cid)
talkState[talkUser] = 1
elseif(msgcontains(msg, 'soul orb') and talkState[talkUser] == 1) then
if (getPlayerStorageValue(cid,106) > 0) then
selfSay('You finished this mission.', cid)
else
if(doPlayerRemoveItem(cid, 5944, 600) == TRUE) then
setPlayerStorageValue(cid,106,1)
doPlayerAddExperience(cid,40000000)
selfSay('Thank you! You can started "second mission".. (you received 4000000 points of experience)', cid)
else
selfSay('You must have more items', cid)
end
end
return true
end
---------------------------------------------------------
if(msgcontains(msg, 'second mission')) then
selfSay('Please bring me 600 Undead heart "heart"', cid)
talkState[talkUser] = 1
elseif(msgcontains(msg, 'heart') and talkState[talkUser] == 1) then
if (getPlayerStorageValue(cid,107) > 0) then
selfSay('You finished this mission.', cid)
else
if(doPlayerRemoveItem(cid, 11360, 600) == TRUE) then
setPlayerStorageValue(cid,107,1)
doPlayerAddExperience(cid,80000000)
selfSay('Thank you! You can started "third mission".. (you received 8000000 points of experience)', cid)
else
selfSay('You must have more items', cid)
end
end
return true
end
---------------------------------------------------------
if(msgcontains(msg, 'third mission')) then
selfSay('Please bring me 100 gold nugget  "gn"', cid)
talkState[talkUser] = 1
elseif(msgcontains(msg, 'gn') and talkState[talkUser] == 1) then
if (getPlayerStorageValue(cid,108) > 0) then
selfSay('You finished this mission.', cid)
else
if(doPlayerRemoveItem(cid, 2157, 100) == TRUE) then
setPlayerStorageValue(cid,108,1)
doPlayerAddExperience(cid,200000000)
selfSay('Thank you! You finished all missions. (you received 20000000 points of experience)', cid)
else
selfSay('You must have more items', cid)
end
end
return true
end


end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new()) 