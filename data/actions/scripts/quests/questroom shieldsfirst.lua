function onUse(cid, item, fromPosition, itemEx, toPosition)
   	if item.uid == 22000 then
		queststatus = getPlayerStorageValue(cid,22000)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "You have found a scale shield.")
   			doPlayerAddItem(cid,41323,1)
   			setPlayerStorageValue(cid,22000,1)
   		else
   			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "It is empty.")
   		end
   	elseif item.uid == 22001 then
		queststatus = getPlayerStorageValue(cid,22000)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "You have found a  monks shield.")
   			doPlayerAddItem(cid,32838,1)
   			setPlayerStorageValue(cid,22000,1)
   		else
   			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "It is empty.")
   		end
   	elseif item.uid == 22002 then
		queststatus = getPlayerStorageValue(cid,22000)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "You have found a spellbook of the novice.")
			local bag = doPlayerAddItem(cid,23771,1)
			doAddContainerItem(bag,2326,1)
   			setPlayerStorageValue(cid,22000,1)
   		else
   			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "It is empty.")
   		end
	end
   	return 1
end