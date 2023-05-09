local nagrody_lista = {
[63007] = {ilosc = 1, id = 2443},
[63008] = {ilosc = 1, id = 2424},
[63009] = {ilosc = 1, id = 2408},
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