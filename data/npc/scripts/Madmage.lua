local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)			npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)			npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()					npcHandler:onThink()					end

function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end

	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid

	if(msgcontains(msg, 'summon scroll') or msgcontains(msg, 'scroll')) then
		selfSay('Do you want to exchange Bronze, Silver and Golden trophies for Summon scrol?', cid)
		talkState[talkUser] = 1
	elseif(msgcontains(msg, 'yes') and talkState[talkUser] == 1) then
		if(getPlayerItemCount(cid, 7369) >= 1) and (getPlayerItemCount(cid, 7370) >= 1) and (getPlayerItemCount(cid, 7371) >= 1)then
				doPlayerRemoveItem(cid, 7369, 1)
				doPlayerRemoveItem(cid, 7370, 1)
				doPlayerRemoveItem(cid, 7371, 1)
				doPlayerAddItem(cid, 7724)
				selfSay('Here you are.', cid)
			else
				selfSay('Sorry, you don\'t have all the items.', cid)
			end
		talkState[talkUser] = 0
	elseif(msgcontains(msg, 'no') and isInArray({1}, talkState[talkUser]) == TRUE) then
		talkState[talkUser] = 0
		selfSay('Ok then.', cid)
	end

	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
