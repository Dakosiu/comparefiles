function onCastSpell(cid, var)
    local target = Creature(var.number)

    
    if not target or not target:isPlayer() then
        return false
    end
    
    
    if target:getCondition(CONDITION_BLEEDING) then
        return false
    end
    
    local duration = 4
    local minDamagePercent = 5
    local maxDamagePercent = 10
    
    local maxHealth = target:getMaxHealth()
    local minDamage = math.floor(maxHealth * minDamagePercent / 100)
    local maxDamage = math.floor(maxHealth * maxDamagePercent / 100)
    
 
    doTargetCombatHealth(cid, target:getId(), COMBAT_FIREDAMAGE, -minDamage, -maxDamage, CONST_ME_MAGIC_GREEN)
    
  
    addEvent(removeBleedingEffect, duration * 1000, target:getId())
    
    return true
end

function removeBleedingEffect(cid)
    local creature = Creature(cid)
    
    if creature and creature:isPlayer() then
        creature:removeCondition(CONDITION_BLEEDING)
    end
end