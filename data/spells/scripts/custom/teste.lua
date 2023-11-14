local function sendDistanceEffectDelay(cid, fromPos, toPos, effect)
    local player = Player(cid)
    if not player then
        return
    end
 
    fromPos:sendDistanceEffect(toPos, effect)
end
 
local function ninjaJumpDash(cid, target, oldPos, lastJump, back)
    local player = Player(cid)
    if not player then
        return
    end
 
    local target = Creature(target)
    if not target then
        player:setGhostMode(false)
        return
    end
   
    if lastJump then
        player:setGhostMode(false)
    end
 
    if back then
        player:teleportTo(oldPos)
    else
        player:teleportTo(target:getPosition())
    end
    doTargetCombatHealth(cid, target, COMBAT_PHYSICALDAMAGE, -1, -100, CONST_ME_THUNDER)
end
 
function onCastSpell(creature, var)
    local cid = creature:getId()
    local playerPos = creature:getPosition()
 
    creature:setGhostMode(true)
    addEvent(ninjaJumpDash, 0, cid, target:getId(), playerPos, false, false)
    addEvent(sendDistanceEffectDelay, 100, cid, playerPos, target:getPosition(), CONST_ANI_ENERGY)
    addEvent(sendDistanceEffectDelay, 300, cid, target:getPosition(), playerPos, CONST_ANI_ENERGY)
    addEvent(ninjaJumpDash, 400, cid, target:getId(), playerPos, false, true)
 
    addEvent(ninjaJumpDash, 600, cid, target:getId(), playerPos, false, false)
    addEvent(sendDistanceEffectDelay, 700, cid, playerPos, target:getPosition(), CONST_ANI_ENERGY)
    addEvent(sendDistanceEffectDelay, 1000, cid, target:getPosition(), playerPos, CONST_ANI_ENERGY)
    addEvent(ninjaJumpDash, 1100, cid, target:getId(), playerPos, false, true)
 
    addEvent(ninjaJumpDash, 1300, cid, target:getId(), playerPos, false, false)
    addEvent(sendDistanceEffectDelay, 1400, cid, playerPos, target:getPosition(), CONST_ANI_ENERGY)
    addEvent(sendDistanceEffectDelay, 1700, cid, target:getPosition(), playerPos, CONST_ANI_ENERGY)
    addEvent(ninjaJumpDash, 1800, cid, target:getId(), playerPos, true, true)
    return false
end