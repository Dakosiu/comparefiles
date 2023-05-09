function onUse(cid, item, fromPosition, itemEx, toPosition)
		doPlayerAddLevel(cid, 1)
        doRemoveItem(item.uid, 1)
        doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You gain ?.")
return true

end