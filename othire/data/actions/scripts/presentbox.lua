function onUse(cid, item, frompos, item2, topos)
losowo = math.random(1, 5)
if losowo == 1 then
doPlayerAddItem(cid, 2408, 1)
elseif losowo == 2 then
doPlayerAddItem(cid, 2443, 1)
elseif losowo == 3 then
doPlayerAddItem(cid, 2424, 1)
elseif losowo == 4 then
doPlayerAddItem(cid, 2352, 1)
elseif losowo == 5 then
doPlayerAddItem(cid, 2410, 1)
end
doRemoveItem(item.uid, 1)
doSendMagicEffect(topos, 3)
return true
end