local nagrody_lista = {
[63010] = {ilosc = 1, id = 1997},
[63011] = {ilosc = 1, id = 1991},
[63012] = {ilosc = 1, id = 1994},
[63013] = {ilosc = 1, id = 1995},
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