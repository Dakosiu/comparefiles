function onUse(cid, item, frompos, item2, topos)
losowo = math.random(1, 5)
if losowo == 1 then
doPlayerAddItem(cid, 2504, 1)
elseif losowo == 2 then
doPlayerAddItem(cid, 3983, 1)
elseif losowo == 3 then
doPlayerAddItem(cid, 2649, 1)
elseif losowo == 4 then
doPlayerAddItem(cid, 2468, 1)
elseif losowo == 5 then
doPlayerAddItem(cid, 2648, 1)
elseif losowo == 6 then
doPlayerAddItem(cid, 2495, 1)
elseif losowo == 7 then
doPlayerAddItem(cid, 2478, 1)
elseif losowo == 8 then
doPlayerAddItem(cid, 2467, 1)
elseif losowo == 9 then
doPlayerAddItem(cid, 2477, 1)
elseif losowo == 10 then
doPlayerAddItem(cid, 2470, 1)
elseif losowo == 11 then
doPlayerAddItem(cid, 2488, 1)
end
doRemoveItem(item.uid, 1)
doSendMagicEffect(topos, 3)
return true
end
