function onUse(cid, item)
if getPlayerStorageValue(cid, 343455) == 1 then
doTeleportThing(cid, {x=996,y=1004,z=7})
else
doPlayerSendCancel(cid, "nie masz dostepu.")
end
return true
end
    