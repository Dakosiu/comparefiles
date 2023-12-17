local cost = 50000
local blessings = 6
 
function onSay(player, words, param)
    if player:isPzLocked() then
        player:sendCancelMessage("You can't buy bless, when you are in a battle.")
        return false
    end
 
    local hasAllBlessings = true
    for blessing = 1, blessings do
        if not player:hasBlessing(blessing) then
            hasAllBlessings = false
            break
        end
    end
 
    if hasAllBlessings then
        player:sendCancelMessage("You have already been blessed by the gods.")
        return false
    end
 
    if not player:removeTotalMoney(cost) then
        player:sendCancelMessage(("You need %d gold coins to buy all blessings."):format(cost))
        return false
    end
 
    for blessing = 1, blessings do
        player:addBlessing(blessing)
    end
 
    player:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have been blessed by the gods!")
    return false
end
