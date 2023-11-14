function comparePosition(pos1, pos2)
        return (pos1.x == pos2.x and pos1.y == pos2.y and pos1.z == pos2.z) and true or false
end 

local position = false
function onSay(player, words, param, channel)
        local pos, c = player:getPosition(),position
        if param == "clear" then
                position = false
                return player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Clear.")
        end
        if not(position) or not(comparePosition(position,pos)) then
                if position == false then
                        position = pos
                        return player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, string.format("The teleporter's position was set. [X: %i, Y: %i, Z: %i]",pos.x, pos.y, pos.z)) and doSendMagicEffect(pos, 14)
                end
                position = false
                return  player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, string.format("The teleporter was set up. From:[X: %i, Y: %i, Z: %i] To:[X: %i, Y: %i, Z: %i]",c.x, c.y, c.z, pos.x, pos.y, pos.z)) and doSendMagicEffect(pos, 14) and doCreateTeleport(1387, pos, c)
        end
        return  player:sendCancelMessage("The teleport position can't be the position where the teleporter is.")
end