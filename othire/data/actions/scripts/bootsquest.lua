local nagrody_lista = {
[63020] = {ilosc = 1, id = 2358},
[63021] = {ilosc = 1, id = 2642},
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