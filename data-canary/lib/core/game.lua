function Game.sendTextOnPosition(message, position, effect)
    local spectators = Game.getSpectators(position, false, false, 7, 7, 5, 5)

    if #spectators > 0 then
        if message then
            for i = 1, #spectators do
                spectators[i]:say(message, TALKTYPE_MONSTER_SAY, false, spectators[i], position)
            end
        end

        if effect then
            position:sendMagicEffect(effect)
        end
    end

    return true
end