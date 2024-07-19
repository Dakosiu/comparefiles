local config = {
    interval = 200,
    count = 12,
    delay = 1000,
}

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_POFF)
combat:setArea(createCombatArea(AREA_CIRCLE5X5))

local condition = Condition(CONDITION_BLEEDING)
condition:setParameter(CONDITION_PARAM_DELAYED, 10)
condition:addDamage(math.random(20, 100), 10000, -25)
combat:addCondition(condition)

local function getNextDirection(direction)
    if direction == 3 then
        return 0
    end

    return direction + 1
end

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
    local creatureId = creature:getId()

    for i = 1, config.count do
        addEvent(function()
            local creature = Creature(creatureId)

            if creature then
                creature:setDirection(getNextDirection(creature:getDirection()))
            end
        end, i * config.interval)
    end

    addEvent(function()
        local creature = Creature(creatureId)

        if creature then
            return combat:execute(creature, var)
        end
    end, config.delay + (config.count * config.interval))
end

spell:name("frosttaur spell")
spell:words("###1006")
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(true)
spell:register()