local spell = Spell("instant")

function spell.onCastSpell(creature, var)
    local creaturePosition = creature:getPosition()
    local availablePlayers = {}
    local players = Game.getSpectators(creaturePosition, true, true, 8, 8, 8, 8)

    for i = 1, #players do
        local player = players[i]

        -- position:isSightClear(positionEx[, sameFloor = true])

        if player:getAccountType() < ACCOUNT_TYPE_GAMEMASTER and creaturePosition:getDistance(player:getPosition()) >= 3 and not Tile(player:getPosition()):hasFlag(TILESTATE_PROTECTIONZONE) then
            table.insert(availablePlayers, player)
        end
    end

    local player = availablePlayers[math.random(#availablePlayers)]

    if not player then
        return false
    end

    creaturePosition:sendDistanceEffect(player:getPosition(), CONST_ANI_ENERGY)
    creaturePosition:sendMagicEffect(CONST_ME_TELEPORT)
    creature:teleportTo(player:getPosition())
    creaturePosition:sendMagicEffect(CONST_ME_TELEPORT)
    creature:say("You're not gonna get away from me that easily!", TALKTYPE_MONSTER_SAY)

    return true
end

spell:name("teleport to player")
spell:words("###1000")
spell:needLearn(true)
spell:register()