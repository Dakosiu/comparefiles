local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, 0)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)

function onGetFormulaValues(player, level, maglevel)
    local maxHealth = player:getMaxHealth() / 100
    local min = (maxHealth * 45)
    local max = (maxHealth * 70)
    return min, max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local spell = Spell("instant")
function spell.onCastSpell(creature, variant)
    return combat:execute(creature, variant) 
end

spell:name("Pally Healing")
spell:words("exura hyper vita")
spell:group("support")
spell:vocation("Royal Paladin")
spell:id(24)
spell:cooldown(1 * 1000)
spell:groupCooldown(1 * 1000)
spell:level(10000)
spell:mana(3000)
spell:isAggressive(false)
spell:isSelfTarget(true)
spell:isPremium(false)
spell:needLearn(false)
spell:register()