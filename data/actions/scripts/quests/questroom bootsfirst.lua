function onUse(cid, item, fromPosition, itemEx, toPosition)
   	if item.uid == 22006 then
		queststatus = getPlayerStorageValue(cid,22002)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "You have found a Sentinel Platewalkers.")
   			doPlayerAddItem(cid,40487,1)
   			setPlayerStorageValue(cid,22002,1)
   		else
   			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "It is empty.")
   		end
   	elseif item.uid == 22007 then
		queststatus = getPlayerStorageValue(cid,22002)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "You have found a Sacred Guardian Boots.")
   			doPlayerAddItem(cid,33050,1)
   			setPlayerStorageValue(cid,22002,1)
   		else
   			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "It is empty.")
   		end
   	elseif item.uid == 22008 then
		queststatus = getPlayerStorageValue(cid,22002)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "You have found a Astral Weaver Sandals.")
			local bag = doPlayerAddItem(cid,32852,1)
   			setPlayerStorageValue(cid,22002,1)
   		else
   			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "It is empty.")
   		end
	end
   	return 1
end