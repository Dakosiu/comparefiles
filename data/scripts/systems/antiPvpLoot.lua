local creatureevent = CreatureEvent("notifyIpPVP_onHealth")
function creatureevent.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType,
                                      origin)

   if primaryType == COMBAT_HEALING then
      return primaryDamage, primaryType, secondaryDamage, secondaryType
   end
   
   if not attacker or not attacker:isPlayer() then
      return primaryDamage, primaryType, secondaryDamage, secondaryType
   end

   if attacker and attacker:isPlayer() then
      local ip1 = attacker:getIp()
      if creature:isPlayer() then
         local ip2 = creature:getIp()
         if ip1 == ip2 then
            attacker:sendTextMessage(MESSAGE_STATUS_WARNING,
               "If you kill a player in the same ip of you, you both will be punished")
            creature:sendTextMessage(MESSAGE_STATUS_WARNING,
               "If you get killed by a player in the same ip of you, you both will be punished")
         end
      end
   end
   return primaryDamage, primaryType, secondaryDamage, secondaryType
end

creatureevent:register()

creatureevent = CreatureEvent("notifyIpPVP_onMana")
function creatureevent.onManaChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType,
                                    origin)

   if primaryType == COMBAT_HEALING then
      return primaryDamage, primaryType, secondaryDamage, secondaryType
   end

   if primaryType == COMBAT_MANADRAIN and primaryDamage > 0 then
      return primaryDamage, primaryType, secondaryDamage, secondaryType
   end

   if not attacker or not attacker:isPlayer() then
      return primaryDamage, primaryType, secondaryDamage, secondaryType
   end
   
   if attacker and attacker:isPlayer() then
      local ip1 = attacker:getIp()
      if creature:isPlayer() then
         local ip2 = creature:getIp()
         if ip1 == ip2 then
            attacker:sendTextMessage(MESSAGE_STATUS_WARNING,
               "If you kill a player in the same ip of you, you both will be punished")
            creature:sendTextMessage(MESSAGE_STATUS_WARNING,
               "If you get killed by a player in the same ip of you, you both will be punished")
         end
      end
   end
   return primaryDamage, primaryType, secondaryDamage, secondaryType
end

creatureevent:register()

local creatureevent = CreatureEvent("notifyIpPVP_onKill")
function creatureevent.onKill(creature, target, corpse, killer, mostDamageKiller, lastHitUnjustified,
                              mostDamageUnjustified)

   if creature:isPlayer() then
      local ip1 = creature:getIp()
      if target:isPlayer() then
         local ip2 = target:getIp()
         if ip1 == ip2 then
            creature:removeExperience(creature:getExperience() * 0.05)
            creature:sendTextMessage(MESSAGE_STATUS_WARNING,
               "By killing a player in the same ip you lost 5% of your total experience points.")
         end
      end
   end
end

creatureevent:register()

local ec = EventCallback
function ec.onGainExperience(self, source, exp, rawExp)
   if source:isPlayer() then
      local ip1 = self:getIp()
      local ip2 = source:getIp()
      if ip1 == ip2 then
         exp = 0
      end
   end
   return exp
end

ec:register(4)

creatureevent = CreatureEvent("notifyIpPVP_onLogin")
function creatureevent.onLogin(player)
   player:registerEvent("notifyIpPVP_onHealth")
   player:registerEvent("notifyIpPVP_onMana")
   player:registerEvent("notifyIpPVP_onKill")
   return true
end

creatureevent:register()
