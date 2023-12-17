local reSpawn = CreatureEvent("trappedEnergy_onKill")

function reSpawn.onDeath(creature, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)
   local isABoss = MonsterType(creature:getName())
   if not isABoss then
      return false
   end

   if isABoss:isBoss() then
      return true
   end

   if not killer then
      return true
   end

   if killer:isPlayer() or killer:getMaster() then
      local chance
      if killer:isPlayer() then
	     chance = ABILITY_SYSTEM:getTrappedEnergy(killer)
         --chance = killer:getStorageValue(StatSystem.config.storages.trappedEnergyPoints)
      elseif killer:getMaster() then
         --chance = killer:getMaster():getStorageValue(StatSystem.config.storages.trappedEnergyPoints)
		 chance = ABILITY_SYSTEM:getTrappedEnergy(killer:getMaster())
      end
      local random = math.random(1, 100)
      local monsterName = creature:getName()
      if chance >= random then -- 1%
         local event = creature:getName():lower()
         if event then
            local item = Game.createItem(41547, 1, corpse:getPosition())
            if item then
               item:setAttribute(ITEM_ATTRIBUTE_ACTIONID, 17677)
               item:setCustomAttribute("CreatureName", event)
            end
         end
      end
   end
end

reSpawn:register()

local TrappedEnergy = Action()

function TrappedEnergy.onUse(player, item, fromPosition, target, toPosition, isHotkey)
   local Name = item:getCustomAttribute("CreatureName")
   local iPos = item:getPosition()
   iPos:sendMagicEffect(30)
   item:remove(1)
   local random = math.random(3, 9)
   for i = 1, random do
      local MetaverseMonster = Game.createMonster(Name, toPosition) --Create a monster far away
   end
end

TrappedEnergy:aid(17677)

TrappedEnergy:register()

local ec = EventCallback
function ec.onLook(player, thing, position, distance, description)
   if thing:isItem() then
      if thing:getCustomAttribute("CreatureName") then
         local crName = thing:getCustomAttribute("CreatureName")
         local name = crName:gsub("^%l", string.upper)
         description = description .. "\n" .. "Monster: " .. name .. "s."
      end

      if thing:getCustomAttribute("PlayerName") then
         local crName = thing:getCustomAttribute("PlayerName")
         local name = crName:gsub("^%l", string.upper)
         description = description .. "\n" .. "Created by: " .. name
      end

   end

   return description
end

ec:register(7)