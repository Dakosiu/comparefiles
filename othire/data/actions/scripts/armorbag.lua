function onUse(cid, item, frompos, item2, topos)
losowo = math.random(1, 11)
if losowo == 1 then
doPlayerAddItem(cid, 3968, 1)
elseif losowo == 2 then
doPlayerAddItem(cid, 2486, 1)
elseif losowo == 3 then
doPlayerAddItem(cid, 2465, 1)
elseif losowo == 4 then
doPlayerAddItem(cid, 2467, 1)
elseif losowo == 5 then
doPlayerAddItem(cid, 2472, 1)
elseif losowo == 6 then
doPlayerAddItem(cid, 2463, 1)
elseif losowo == 7 then
doPlayerAddItem(cid, 2483, 1)
elseif losowo == 8 then
doPlayerAddItem(cid, 2464, 1)
elseif losowo == 9 then
doPlayerAddItem(cid, 2476, 1)
elseif losowo == 10 then
doPlayerAddItem(cid, 2478, 1)
elseif losowo == 11 then
doPlayerAddItem(cid, 2466, 1)
end
doRemoveItem(item.uid, 1)
doSendMagicEffect(topos, 3)
return true
end