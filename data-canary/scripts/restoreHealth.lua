RESTORE_HEALTH_AFTER_DEATH = {}

RESTORE_HEALTH_AFTER_DEATH.storage = 4237137


function RESTORE_HEALTH_AFTER_DEATH:setRestore(player, boolean)
   if boolean then
      return player:setStorageValue(self.storage, 1)
   end
   return player:setStorageValue(self.storage, 0)
end

function RESTORE_HEALTH_AFTER_DEATH:getRestore(player)
   local value = player:getStorageValue(self.storage)
   if value > 0 then
      return true
   end
   return false
end

function RESTORE_HEALTH_AFTER_DEATH:processRestore(player)
   player:addHealth(player:getMaxHealth())
   player:addMana(player:getMaxMana())
end

local creaturescript = CreatureEvent("RESTORE_HEALTH_AFTER_DEATH_onLogin")
function creaturescript.onLogin(player)
    player:registerEvent("RESTORE_HEALTH_AFTER_DEATH_onDeath")
    if RESTORE_HEALTH_AFTER_DEATH:getRestore(player) then
	   RESTORE_HEALTH_AFTER_DEATH:processRestore(player)
	   RESTORE_HEALTH_AFTER_DEATH:setRestore(player, false)
	end
	return true
end
creaturescript:register()

creaturescript = CreatureEvent("RESTORE_HEALTH_AFTER_DEATH_onDeath")
function creaturescript.onDeath(creature, corpse, killer, mostDamage, unjustified, mostDamage_unjustified)
	RESTORE_HEALTH_AFTER_DEATH:setRestore(creature, true)
	return true
end
creaturescript:register()