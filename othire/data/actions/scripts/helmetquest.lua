local nagrody_lista = {
[63018] = {ilosc = 1, id = 2323},
[63019] = {ilosc = 1, id = 3967},
}
function onUse(cid,item,fromPosition,itemEx,toPosition)
local list = nagrody_lista[item.actionid]
if getPlayerStorageValue(cid, 88317368) < 1 then
setPlayerStorageValue(cid, 88317368, 1)
doPlayerAddItem(cid, list.id, list.ilosc)
else
doPlayerSendCancel(cid, "odebrales juz nagrode.")
end
return true
end