function onUse(cid, item, fromPosition, itemEx, toPosition)
   	if item.uid == 22009 then
		queststatus = getPlayerStorageValue(cid,22003)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "You have found a Royal Citadel Armor.")
   			doPlayerAddItem(cid,41123,1)
   			setPlayerStorageValue(cid,22003,1)
   		else
   			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "It is empty.")
   		end
   	elseif item.uid == 22010 then
		queststatus = getPlayerStorageValue(cid,22003)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "You have found a Luminous Novice Attire.")
   			doPlayerAddItem(cid,32079,1)
   			setPlayerStorageValue(cid,22003,1)
   		else
   			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "It is empty.")
   		end
   	elseif item.uid == 22011 then
		queststatus = getPlayerStorageValue(cid,22003)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "You have found a Mystic Neophyte Attire.")
			local bag = doPlayerAddItem(cid,34235,1)
   			setPlayerStorageValue(cid,22003,1)
   		else
   			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "It is empty.")
   		end
	end
   	return 1
end