local money = 10000

local talkAction = TalkAction("!softboots", "!soft")

function talkAction.onSay(player, words, param)  
    if player:getItemCount(6530) >= 1 then
        if player:removeMoney(money) then
            player:removeItem(6530, 1)
            player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
            player:addItem(3549, 1) -- id new soft boots  
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You charged a soft boots!")
        else
            player:getPosition():sendMagicEffect(CONST_ME_POFF)
            player:sendCancelMessage("You do not have enough money!.")
        end
    else
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        player:sendCancelMessage("You do not have worn soft boots!.")
    end
    return false
end

talkAction:register()