--[[ local function getPlayerWeapon(player)
   local weapon = player:getSlotItem(CONST_SLOT_LEFT)
   if not weapon or weapon:getType():getWeaponType() == WEAPON_NONE then
      weapon = player:getSlotItem(CONST_SLOT_RIGHT)
      if not weapon or weapon:getType():getWeaponType() == WEAPON_NONE then
         return
      end
   end

   return weapon
end

local function isWeapon(item)
   return item:getType():getWeaponType() ~= WEAPON_NONE
end

local function isWand(item)
   return item:getType():getWeaponType() == WEAPON_WAND
end

local function isBow(item)
   return item:getType():getWeaponType() == WEAPON_DISTANCE
end

local creatureEvent = CreatureEvent("ExplosionDamage_onHealth")

function creatureEvent.onHealthChange(creature, attacker, primaryDamage, primaryType, position, secondaryDamage, secondaryType,
                                      origin)
   local weapon
   weapon = getPlayerWeapon(attacker)
   if weapon:getExplosion() then
      player:onCastSpell("")
   end
   return primaryDamage, primaryType, secondaryDamage, secondaryType
end

creatureEvent:register()

local ec = EventCallback

function ec.onTargetCombat(creature, target)
   if creature and target then
      if creature:isPlayer() then
         target:registerEvent("ExplosionDamage_onHealth")
      end
   end
   return RETURNVALUE_NOERROR
end

ec:register(7)

creatureevent = CreatureEvent("Register_Weapon_Upgrades")
function creatureevent.onLogin(player)
   player:registerEvent("ExplosionDamage_onHealth")
   return true
end

creatureevent:register()
--]]