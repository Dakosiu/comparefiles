function onUse(cid, item)
if getPlayerStorageValue(cid, 343455) < 1 then
setPlayerStorageValue(cid, 343455, 1)
doPlayerSendTextMessage(cid,22,"zyskales dostep do drzwi")
else
doRemoveItem(item.uid, 1)
end
return false
end
    