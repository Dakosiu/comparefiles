function onUse(cid, item, frompos, item2, topos)
losowo = math.random(1, 6)
if losowo == 1 then
doPlayerAddItem(cid, 2643, 1)
elseif losowo == 2 then
doPlayerAddItem(cid, 3982, 1)
elseif losowo == 3 then
doPlayerAddItem(cid, 2640, 1)
elseif losowo == 4 then
doPlayerAddItem(cid, 2644, 1)
elseif losowo == 5 then
doPlayerAddItem(cid, 2195, 1)
elseif losowo == 6 then
doPlayerAddItem(cid, 2358, 1)
elseif losowo == 7 then
doPlayerAddItem(cid, 2530, 1)
elseif losowo == 8 then
doPlayerAddItem(cid, 2541, 1)
elseif losowo == 9 then
doPlayerAddItem(cid, 2270, 1)
elseif losowo == 10 then
doPlayerAddItem(cid, 2201, 1)
elseif losowo == 11 then
doPlayerAddItem(cid, 2197, 1)
end
doRemoveItem(item.uid, 1)
doSendMagicEffect(topos, 3)
return true
end