local config = {
    poisonId = 2134,
    damage = {100, 200}
}

local spell = Spell("instant")

local function destructPoison(position)
    local item = Tile(position):getItemById(config.poisonId)

    if not item then
        return false
    end

    local positions = {
        Position(position.x - 1, position.y - 1, position.z),
        Position(position.x, position.y - 1, position.z),
        Position(position.x + 1, position.y - 1, position.z),
        Position(position.x + 1, position.y, position.z),
        Position(position.x + 1, position.y + 1, position.z),
        Position(position.x, position.y + 1, position.z),
        Position(position.x - 1, position.y + 1, position.z),
        Position(position.x - 1, position.y, position.z),
    }

    position:sendMagicEffect(CONST_ME_POFF)

    for i = 1, #positions do
        local explodePosition = positions[i]

        addEvent(function()
            local tile = Tile(explodePosition)

            if tile then
                position:sendDistanceEffect(explodePosition, CONST_ANI_POISON)
                explodePosition:sendMagicEffect(CONST_ME_YELLOW_RINGS)

                local creature = tile:getTopCreature()

                if creature and creature:isPlayer() then
                    creature:addHealth(-math.random(config.damage[1], config.damage[2]))
                end
            end
        end, i * 100)
    end

    addEvent(function()
        item:remove()
        position:sendMagicEffect(CONST_ME_POFF)
    end, #positions * 100)

    return true
end

function spell.onCastSpell(creature, var)
    local creaturePosition = creature:getPosition()

    Game.createItem(config.poisonId, 1, creaturePosition)
    addEvent(destructPoison, 3000, creaturePosition)

    return true
end

spell:name("vexseeker field")
spell:words("###1003")
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(true)
spell:register()