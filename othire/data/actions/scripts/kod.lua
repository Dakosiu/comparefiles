local nagrody_lista = {
[63001] = {ilosc = 1, id = 2400},
[63002] = {ilosc = 1, id = 2431},
[63003] = {ilosc = 1, id = 2421},
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