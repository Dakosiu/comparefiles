function isWalkable(cid, pos)
    local tile = Tile(pos)
    if not tile then
        return false
    end
 
    if tile:queryAdd(cid) == 1 and not tile:hasFlag(TILESTATE_PROTECTIONZONE) then
        return true
    end
    return false
end
 
local function jumpBehindTarget(cid, target)
    local player = Player(cid)
    local target = Creature(target)
    local targetPos = target:getPosition()
    local targetPositions = {
        north = Position(targetPos.x, targetPos.y-1, targetPos.z),
        east = Position(targetPos.x+1, targetPos.y, targetPos.z),
        west = Position(targetPos.x-1, targetPos.y, targetPos.z),
        south = Position(targetPos.x, targetPos.y+1, targetPos.z)
    }
 
    local targetDir = target:getDirection()
    if targetDir == NORTH then
        dir = targetPositions.south
    elseif targetDir == EAST then
        dir = targetPositions.west
    elseif targetDir == WEST then
        dir = targetPositions.east
    elseif targetDir == SOUTH then
        dir = targetPositions.north
    end
    return dir
end
 
local function oldPos(cid, oldPos)
    local player = Player(cid)
    if not player then
        return
    end
 
    player:teleportTo(oldPos)
end

local function backOldPos(cid, savePosition)
    local player = Player(cid)
    if player ~= nil then
        player:teleportTo(savePosition)
    end
end
 
local function checkHasTarget(cid, count, oldPos)
    local player = Player(cid)
    if not player then
        return
    end
 
    if count < 1 then
        player:setGhostMode(false)
        return
    end
   
    local target = player:getTarget()
    if target then
        local behindTarget = jumpBehindTarget(cid, target:getId())
        if isWalkable(cid, behindTarget) then
            player:teleportTo(behindTarget)
        else
            local savePosition = player:getPosition()
            player:teleportTo(target:getPosition())
            addEvent(backOldPos, 100, cid, savePosition)
        end
        player:setDirection(target:getDirection())
        player:setGhostMode(false)
        doTargetCombatHealth(cid, target, COMBAT_PHYSICALDAMAGE, -650, -700, CONST_ME_CRAPS)
        return true
    end
    addEvent(checkHasTarget, 1 * 100, cid, count - 1)
end
 
function onCastSpell(creature, var)
    local playerPos = creature:getPosition()
 
    creature:setGhostMode(true)
    playerPos:sendMagicEffect(CONST_ME_POFF)
    addEvent(checkHasTarget, 1 * 250, creature:getId(), 50, playerPos)
    return false
end