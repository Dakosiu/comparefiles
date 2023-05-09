function onUse(cid, item, frompos, item2, topos)
local NOWY_MIECZ = 2408
-----------------
local UPGRADER = 2122
local SZANSA = 5
local losek = math.random(1, 100)
if (item2.itemid == UPGRADER) then
if losek < SZANSA then
doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "udalo sie.")
doTransformItem(item.uid, NOWY_MIECZ)
doRemoveItem(item2.uid, 1)
elseif losek < 100  then
doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "nie udalo sie.")
doRemoveItem(item2.uid, 1)
end
return true
end
end