function onUse(cid, item)
if getPlayerStorageValue(cid, 343450) < 1 then
setPlayerStorageValue(cid, 343450, 1)
doPlayerSendTextMessage(cid,22,"zyskales dostep do drzwi")
else
doPlayerSendCancel(cid, "odebrales juz nagrode.")
end
return false
end
    