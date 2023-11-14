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
 
local function runSpell(cid, i, j, delay, radius, damage, damageType, areaEffect, distanceEffect)
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
   local args = {nil, cid, damageType, nil, damage.min, damage.max, areaEffect}
   for i = 1, #specs do
       if specs[i]:isMonster() then
           local specPos = specs[i]:getPosition()
           args[1] = specs[i]:getId()
           args[4] = specPos
           center:sendDistanceEffect(specPos, distanceEffect)
           addEvent(doAreaCombatDamage, 120 + (center:getDistance(specPos) * 7), unpack(args))
       end
   end
   addEvent(runSpell, delay, cid, i+1, j, delay, radius, damage, damageType, areaEffect, distanceEffect)
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
   damage = {min = -120, max = -205},
   rounds = 10, -- number of times the spell loops (effects & damage)
   delay = 360, -- ms
   radius = {x = 3, y = 3}, -- sqm radius
   damageType = COMBAT_PHYSICALDAMAGE,
   areaEffect = CONST_ME_WHIRLWINDCLUB,
   distanceEffect = CONST_ANI_WEAPONTYPE,
}
 
function onCastSpell(creature, variant)
   local player = creature:getPlayer()
   if not player then
       return false
   end
   sendEffects(player:getId(), config.delay, config.areaEffect, config.distanceEffect)
   runSpell(player:getId(), 0, config.rounds, config.delay, config.radius, config.damage, config.damageType, config.areaEffect, config.distanceEffect)
   return true
end