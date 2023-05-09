function onUse(cid, item, frompos, item2, topos)
losek = math.random(1, 100)
local ITEM_PRZED_BOLT = 2547
local ITEM_PO_BOLT = 2410
local SZANSA = 5
if (item2.itemid == ITEM_PRZED_BOLT) then
if losek < SZANSA then -- powodzenie
doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "udalo sie.")
doTransformItem(item2.uid, ITEM_PO_BOLT)
doRemoveItem(item.uid)
elseif losek < 100 then -- niepowodzenie 
doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "nie udalo sie.")
doRemoveItem(item.uid, 1)
---doRemoveItem(item2.uid, 1)
end
return true
end
end