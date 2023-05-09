function onUse(cid, item, frompos, item2, topos)
losowo = math.random(1, 5)
if losowo == 1 then
doPlayerAddItem(cid, 3967, 1)
elseif losowo == 2 then
doPlayerAddItem(cid, 2323, 1)
elseif losowo == 3 then
doPlayerAddItem(cid, 2663, 1)
elseif losowo == 4 then
doPlayerAddItem(cid, 2662, 1)
elseif losowo == 5 then
doPlayerAddItem(cid, 2473, 1)
elseif losowo == 6 then
doPlayerAddItem(cid, 2482, 1)
elseif losowo == 7 then
doPlayerAddItem(cid, 2481, 1)
elseif losowo == 8 then
doPlayerAddItem(cid, 2491, 1)
elseif losowo == 9 then
doPlayerAddItem(cid, 2475, 1)
elseif losowo == 10 then
doPlayerAddItem(cid, 2479, 1)
elseif losowo == 11 then
doPlayerAddItem(cid, 2497, 1)
end
doRemoveItem(item.uid, 1)
doSendMagicEffect(topos, 3)
return true
end
