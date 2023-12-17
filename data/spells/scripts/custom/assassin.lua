local function targetEffect(cid)
    local player = Player(cid)
    if not player then
        return
    end
 
    local effect =  CONST_ANI_REDSTAR
    local orig = player:getPosition()
    local d1, d2 = {z = orig.z}, {z = orig.z}
 
    d1.x = orig.x - 5
    d2.x = orig.x + 5
    for i = -2, 2 do
        d1.y = orig.y + i
        d2.y = d1.y
        orig:sendDistanceEffect(d1, effect)
        orig:sendDistanceEffect(d2, effect)
    end
 
    d1.y = orig.y - 3
    d2.y = orig.y + 3
    for i = -4, 4 do
        d1.x = orig.x + i
        d2.x = d1.x
        orig:sendDistanceEffect(d1, effect)
        orig:sendDistanceEffect(d2, effect)
    end
end
 
local function backOldPosition(cid, oldPosition)
    local player = Player(cid)
    if not player then
        return
    end
   
    player:teleportTo(oldPosition)
    player:setGhostMode(false)
end
 
local function jumpEffect(cid, target)
    local player = Player(cid)
    if not player then
        return
    end
 
    local target = Creature(target)
    if target then
        player:getPosition():sendDistanceEffect(target:getPosition(), CONST_ANI_EXPLOSION)
    end
end
 
local function jumpOnTarget(cid, target, targetCount, oldPosition)
    local player = Player(cid)
    if not player then
        return
    end
 
    local target = Creature(target)
    if target then
        addEvent(targetEffect, 100, cid)
        player:teleportTo(target:getPosition())
        player:setGhostMode(true)
        doTargetCombatHealth(cid, target, COMBAT_PHYSICALDAMAGE, -300, -600, CONST_ME_ASSASSIN)
        if targetCount == 0 then
            addEvent(backOldPosition, 400, cid, oldPosition)
        end
    end
end
 
local function extractRandomValuesFromTable(tbl) --By Printer(This will make sure not to select a value twice from the table)
    if #tbl == 0 then
        return false
    end
          return table.remove(tbl, math.random(#tbl))
end
 
function onCastSpell(creature, var)
    local targets = {}
 
    local playerPos = creature:getPosition()
    local spectators = Game.getSpectators(playerPos, false, false, 0, 10, 0, 10)
    for i = 1, #spectators do
        local specs = spectators[i]
        if specs ~= creature and not specs:isNpc() then
            targets[#targets+1] = specs
        end
    end
 
    if #targets == 0 then
        creature:sendCancelMessage('There is no targets in sight.')
        playerPos:sendMagicEffect(CONST_ME_POFF)
        return false
    end
 
    local targetCount = #targets
    for i = 1, #targets do
        local randTarget = extractRandomValuesFromTable(targets)
        addEvent(jumpOnTarget, i * 400, creature:getId(), randTarget:getId(), targetCount - i, playerPos)
        addEvent(jumpEffect, i * 300, creature:getId(), randTarget:getId())
    end
    return false
end