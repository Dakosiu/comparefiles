local delayTable = {}

local bp = TalkAction("!bp")
function bp.onSay(cid, words, param)
    local playerId = cid:getId()
    local currentTime = os.time()
    if delayTable[playerId] and delayTable[playerId] > currentTime then
        doPlayerSendCancel(cid, "Please wait a few moments.")
        return false
    end
    delayTable[playerId] = currentTime + 5
   
    if doPlayerRemoveMoney(cid, 100) then
        doPlayerAddItem(cid,2854,1)
        doSendMagicEffect(getPlayerPosition(cid),12)
        doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR,"You've bought an backpack!")
    else
        doPlayerSendCancel(cid,"You don't have enough money.")
        doSendMagicEffect(getPlayerPosition(cid),2)
    end
    return true
end
bp:register()