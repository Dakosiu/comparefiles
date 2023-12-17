function onUse(cid, item, fromPosition, itemEx, toPosition)
   	if item.uid == 22003 then
		queststatus = getPlayerStorageValue(cid,22001)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "You have found a dwurf helmet.")
   			doPlayerAddItem(cid,30303,1)
   			setPlayerStorageValue(cid,22001,1)
   		else
   			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "It is empty.")
   		end
   	elseif item.uid == 22004 then
		queststatus = getPlayerStorageValue(cid,22001)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "You have found a hunter helmet.")
   			doPlayerAddItem(cid,34393,1)
   			setPlayerStorageValue(cid,22001,1)
   		else
   			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "It is empty.")
   		end
   	elseif item.uid == 22005 then
		queststatus = getPlayerStorageValue(cid,22001)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "You have found a priest helmet.")
			local bag = doPlayerAddItem(cid,40582,1)
   			setPlayerStorageValue(cid,22001,1)
   		else
   			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "It is empty.")
   		end
	end
   	return 1
end