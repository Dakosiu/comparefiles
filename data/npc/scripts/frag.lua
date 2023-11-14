local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
 
function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)			npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)			npcHandler:onCreatureSay(cid, type, msg) end
function onThink()					npcHandler:onThink() end
 
item = 'You do not have the required items.'
done = 'Here you are.'
 
function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end
 
		if msgcontains(msg, 'offer') then
		selfSay('You can here change 60 frag hearts for {blood orb}.', cid)
 
elseif msgcontains(msg, 'blood orb') then
				if getPlayerItemCount(cid,5943) >= 60 then
					selfSay('Did you bring me 60 frag rewards?', cid)
					talk_state = 4
				else
					selfSay('I need {60 frag reward}, to give you blood orb. Come back when you have them.', cid)
					talk_state = 0
				end
		elseif msgcontains(msg, 'yes') and talk_state == 4 then
			talk_state = 0
			if getPlayerItemCount(cid,5943) >= 60 then
					if doPlayerRemoveItem(cid,5943,60) == TRUE then
						doPlayerAddItem(cid,2363,1)
						selfSay(done, cid)
					end
				else
				selfSay(item, cid)
				end
        elseif msgcontains(msg, 'no') and (talk_state >= 1 and talk_state <= 5) then
            selfSay('So What The Fuck Do You Want From Me ?!, LEAVE ME NOW!')
            talk_state = 0
        end
    return true
end
 
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())