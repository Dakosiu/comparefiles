local config = {
    sqmCount = 12,
    range = 8,
    damage = {100, 200},
    secondsToAttack = 3,
}

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
    local creaturePosition = creature:getPosition()
    local positions = {}

    for i = 1, config.sqmCount do
        local position = Position(creaturePosition.x + math.random(-config.range, config.range), creaturePosition.y + math.random(-config.range, config.range), creaturePosition.z)
        local tile = Tile(position)
        local isAvailable = true

        if tile then
            if tile:hasFlag(TILESTATE_BLOCKSOLID) or tile:hasFlag(TILESTATE_PROTECTIONZONE) then
                isAvailable = false
            end

            for j = 1, #positions do
                if positions[j].x == position.x and positions[j].y == position.y then
                    isAvailable = false
                end
            end

            if isAvailable then
                table.insert(positions, position)
            end
        end
    end

    for i = 1, #positions do
        local position = positions[i]

        addEvent(function()
            position:sendMagicEffect(56)

            addEvent(function()
                local tile = Tile(position)
                
                position:sendMagicEffect(CONST_ME_BIGCLOUDS)

                local creature = tile:getTopCreature()
                if creature and creature:isPlayer() then
                    creature:addHealth(-math.random(config.damage[1], config.damage[2]))
                    position:sendMagicEffect(CONST_ME_STONES)
                end
            end, 1000 * config.secondsToAttack)
        end, i * 100)
    end

    return true
end

spell:name("sorrowlich spell 2")
spell:words("###1002")
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(true)
spell:register()