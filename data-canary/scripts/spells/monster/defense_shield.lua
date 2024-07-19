local config = {
    seconds = 5,
}

local function removeShieldEffect(creatureId)
    local creature = Creature(creatureId)

    if not creature then
        return
    end

    creature:getPosition():sendMagicEffect(CONST_ME_SMALLCLOUDS)
    creature:say('Defense shield off.', TALKTYPE_MONSTER_SAY)

    return true
end

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
    local creatureId = creature:getId()
    local creaturePosition = creature:getPosition()

    creaturePosition:sendMagicEffect(427)

    local squarePositions = {
        Position(creaturePosition.x - 3, creaturePosition.y - 3, creaturePosition.z),
        Position(creaturePosition.x + 3, creaturePosition.y - 3, creaturePosition.z),
        Position(creaturePosition.x + 3, creaturePosition.y + 3, creaturePosition.z),
        Position(creaturePosition.x - 3, creaturePosition.y + 3, creaturePosition.z),
    }

    for i = 1, #squarePositions do
        local position = squarePositions[i]
        creaturePosition:sendDistanceEffect(position, CONST_ANI_HOLY)
        
        addEvent(function()
            position:sendMagicEffect(CONST_ME_HOLYAREA)
        end, 150)

        addEvent(function()
            position:sendDistanceEffect(creaturePosition, CONST_ANI_HOLY)

            local creature = Creature(creatureId)
            if creature and i == 1 then
                creature:say('For 5 seconds your damage will heal me!', TALKTYPE_MONSTER_SAY)
                creature:setStorage(MonsterStorage.defenseShield, os.time() + 5)
            end
        end, 300)
    end

    addEvent(removeShieldEffect, config.seconds * 1000, creatureId)

    return true
end

spell:name("defense shield")
spell:words("###1007")
spell:register()
