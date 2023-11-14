local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

local condition = Condition(CONDITION_LIGHT)
condition:setParameter(CONDITION_PARAM_LIGHT_LEVEL, 15)
condition:setParameter(CONDITION_PARAM_LIGHT_COLOR, 215)
condition:setParameter(CONDITION_PARAM_TICKS, (60 * 33 + 10) * 2000)
combat:addCondition(condition)

function onCastSpell(creature, variant)
    local player = Player(creature)
    if player then
        if player:getStorageValue(33301) < 1 then
            player:sendCancelMessage("You need to unlock this spell first.")
            return false
        else
            return combat:execute(creature, variant)
        end
    else
        return combat:execute(creature, variant)
    end
end
