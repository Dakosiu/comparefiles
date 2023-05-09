function onUse(cid, item, frompos, item2, topos)
losek = math.random(1, 100)
local ITEM_PRZED_AXE = 2431
local ITEM_PO_AXE = 2443
local SZANSA = 5
if (item2.itemid == ITEM_PRZED_AXE) then
if losek < SZANSA then -- powodzenie
doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "udalo sie.")
doTransformItem(item2.uid, ITEM_PO_AXE)
doRemoveItem(item.uid)
elseif losek < 100 then -- niepowodzenie 
doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "nie udalo sie.")
doRemoveItem(item.uid, 1)
---doRemoveItem(item2.uid, 1)
end
return true
end
end