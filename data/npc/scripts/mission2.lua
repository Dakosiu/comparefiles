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
selfSay('Please bring me 500 hydra head "hydra head"', cid)
talkState[talkUser] = 1
elseif(msgcontains(msg, 'hydra head') and talkState[talkUser] == 1) then
if (getPlayerStorageValue(cid,103) > 0) then
selfSay('You finished this mission.', cid)
else
if(doPlayerRemoveItem(cid, 11192, 500) == TRUE) then
setPlayerStorageValue(cid,103,1)
doPlayerAddExperience(cid,20000000)
selfSay('Thank you! You can started "second mission".. (you received 20000000 points of experience)', cid)
else
selfSay('You must have more items', cid)
end
end
return true
end
---------------------------------------------------------
if(msgcontains(msg, 'second mission')) then
selfSay('Please bring me 600 tarantula egg "egg"', cid)
talkState[talkUser] = 1
elseif(msgcontains(msg, 'egg') and talkState[talkUser] == 1) then
if (getPlayerStorageValue(cid,104) > 0) then
selfSay('You finished this mission.', cid)
else
if(doPlayerRemoveItem(cid, 11191, 600) == TRUE) then
setPlayerStorageValue(cid,104,1)
doPlayerAddExperience(cid,60000000)
selfSay('Thank you! You can started "third mission".. (you received 60000000 points of experience)', cid)
else
selfSay('You must have more items', cid)
end
end
return true
end
---------------------------------------------------------
if(msgcontains(msg, 'third mission')) then
selfSay('Please bring me 1000 hellspawn tails  "tails"', cid)
talkState[talkUser] = 1
elseif(msgcontains(msg, 'tails') and talkState[talkUser] == 1) then
if (getPlayerStorageValue(cid,105) > 0) then
selfSay('You finished this mission.', cid)
else
if(doPlayerRemoveItem(cid, 11214, 1000) == TRUE) then
setPlayerStorageValue(cid,105,1)
doPlayerAddExperience(cid,150000000)
selfSay('Thank you! You finished all missions. (you received 150000000 points of experience)', cid)
else
selfSay('You must have more items', cid)
end
end
return true
end


end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new()) 