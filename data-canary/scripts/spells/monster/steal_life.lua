local config = {
    health = 10000,
}

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
    local creatureId = creature:getId()
    local creaturePosition = creature:getPosition()
    local deadHumanPosition = nil

    for x = creaturePosition.x - 5, creaturePosition.x + 5 do
        for y = creaturePosition.y - 5, creaturePosition.y + 5 do
            local position = Position(x, y, creaturePosition.z)
            local item = Tile(position):getItemById(4240)

            if item and not deadHumanPosition then
                item:remove()
                deadHumanPosition = position
                break
            end
        end
    end

    if not deadHumanPosition then
        creature:say('There is no one dead? Impossible!', TALKTYPE_MONSTER_SAY)
        return false
    end

    creature:teleportTo(deadHumanPosition)
    creature:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
    creature:say('Dead human!', TALKTYPE_MONSTER_SAY)
    Game.createItem(2121, 1, deadHumanPosition)

    for i = 1, 3 do
        addEvent(function()
            deadHumanPosition:sendMagicEffect(CONST_ME_POISONAREA)
        end, i * 150)
    end

    addEvent(function()
        local creature = Creature(creatureId)
        if creature then
            creature:addHealth(config.health)
        end
    end, 3 * 150)

    return true
end

spell:name("steal life")
spell:words("###997")
spell:isAggressive(true)
spell:needTarget(true)
spell:needLearn(true)
spell:isSelfTarget("1")
spell:register()