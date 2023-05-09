function onUse(cid, item)
if getPlayerStorageValue(cid, 343450) == 1 then
doTeleportThing(cid, {x=666,y=1040,z=6})
else
doPlayerSendCancel(cid, "nie masz dostepu.")
end
return true
end
    