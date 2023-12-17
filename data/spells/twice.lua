Position.directionOffset = {
    [DIRECTION_NORTH] = {x = 0, y = -1},
    [DIRECTION_EAST] = {x = 1, y = 0},
    [DIRECTION_SOUTH] = {x = 0, y = 1},
    [DIRECTION_WEST] = {x = -1, y = 0},
    [DIRECTION_SOUTHWEST] = {x = -1, y = 1},
    [DIRECTION_SOUTHEAST] = {x = 1, y = 1},
    [DIRECTION_NORTHWEST] = {x = -1, y = -1},
    [DIRECTION_NORTHEAST] = {x = 1, y = -1}
}

function Position:setDirectionOffset(dir)
    local tmp = Position.directionOffset[dir]
    if not tmp then
        return self
    end
    return Position(self.x + tmp.x, self.y + tmp.y, self.z)
end

--[[#######################################################################################]]--
function doAreaCombatDamage(cid, attacker, combatType, position, min, max, effect)
   --// Incase the creature disappears within 120-250ms time window
   local creature = Creature(cid)
   if not creature then
       return
   end
   doAreaCombatHealth(attacker, combatType, position, 0, min, max, effect)
end
 
local running = {}
 
 local function getMinDamage(cid)
   local player = Player(cid)
   local magic = player:getMagicLevel()
   local level = player:getLevel()
   return magic * level * 2
end

local function getMaxDamage(cid)
   local player = Player(cid)
   local magic = player:getMagicLevel()
   local level = player:getLevel()
   return magic * level * 3
end
 
local function runSpell(cid, i, j, delay, radius, damageType, areaEffect, distanceEffect)
   local player = Player(cid)
   --// Player doesn't exist anymore
   if not player or Tile(player:getPosition()):hasFlag(TILESTATE_PROTECTIONZONE) and bit.band(player:getGroup():getFlags(), PlayerFlag_IgnoreProtectionZone) == 0 then
       stopEvent(running[cid])
       running[cid] = nil
       return
   end
   --// Maximum rounds complete
   if i > j then
       stopEvent(running[cid])
       running[cid] = nil
       return
   end
   local center = player:getPosition()
   local specs = Game.getSpectators(center, false, false, radius.x, radius.x, radius.y, radius.y)
   --// Send effects and damage creatures within radius
   local args = {nil, cid, damageType, nil, getMinDamage(cid), getMaxDamage(cid), areaEffect}
   for i = 1, #specs do
       if specs[i]:isMonster() then
           local specPos = specs[i]:getPosition()
           args[1] = specs[i]:getId()
           args[4] = specPos
           center:sendDistanceEffect(specPos, distanceEffect)
           addEvent(doAreaCombatDamage, 120 + (center:getDistance(specPos) * 7), unpack(args))
       end
   end
   addEvent(runSpell, delay, cid, i+1, j, delay, radius, damageType, areaEffect, distanceEffect)
end
 
local offsets = {DIRECTION_WEST, DIRECTION_NORTH, DIRECTION_EAST, DIRECTION_SOUTH}
 
local function sendEffects(cid, delay, areaEffect, distanceEffect)
   local player = Player(cid)
   if not player or Tile(player:getPosition()):hasFlag(TILESTATE_PROTECTIONZONE) and bit.band(player:getGroup():getFlags(), PlayerFlag_IgnoreProtectionZone) == 0 then
       stopEvent(running[cid])
       running[cid] = nil
       return
   end
   local pos = player:getPosition()
   --// Send distance effects (N/E/S/W) & area effect on player
   for i = 1, #offsets do
       local fromPos = pos:setDirectionOffset(offsets[i])
       local toPos = pos:setDirectionOffset(offsets[i+1] or offsets[1])
       fromPos:sendDistanceEffect(toPos, distanceEffect)
   end
   pos:sendMagicEffect(areaEffect)
   running[cid] = addEvent(sendEffects, delay, cid, delay, areaEffect, distanceEffect)
end
--[[#######################################################################################]]--
local config = {
   rounds = 3, -- number of times the spell loops (effects & damage)
   delay = 300, -- ms
   radius = {x = 3, y = 3}, -- sqm radius
   damageType = COMBAT_DEATHDAMAGE,
   areaEffect = CONST_ME_MORTAREA,
   distanceEffect = CONST_ANI_SUDDENDEATH,
}
 
function onCastSpell(creature, variant)
   local player = creature:getPlayer()
   if not player then
       return false
   end
   sendEffects(player:getId(), config.delay, config.areaEffect, config.distanceEffect)
   runSpell(player:getId(), 0, config.rounds, config.delay, config.radius, config.damageType, config.areaEffect, config.distanceEffect)
   return true
end