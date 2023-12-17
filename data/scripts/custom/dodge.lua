local creatureevent = CreatureEvent("system_Dodge_Health")
function creatureevent.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)

   if primaryType == COMBAT_HEALING then
      return primaryDamage, primaryType, secondaryDamage, secondaryType
   end

   local chance = creature:getTotalDodge()
   local rnd = math.random(1, 100)
   if chance > 0 then
      if rnd <= chance then
         primaryDamage = 0
         secondaryDamage = 0
         creature:getPosition():sendMagicEffect(382) --382
      end
   end

   return primaryDamage, primaryType, secondaryDamage, secondaryType

end


creatureevent:register()

creatureevent = CreatureEvent("system_Dodge_Mana")
function creatureevent.onManaChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)

   if not creature:isPlayer() then
      return primaryDamage, primaryType, secondaryDamage, secondaryType
   end

   local getDodge = creature:getTotalDodge()

   if primaryType == COMBAT_MANADRAIN and primaryDamage > 0 then
      return primaryDamage, primaryType, secondaryDamage, secondaryType
   end

   local chance = creature:getTotalDodge()
   local rnd = math.random(1, 100)
   if chance > 0 then
      if rnd <= chance then
         primaryDamage = 0
         secondaryDamage = 0
         creature:getPosition()
         creature:getPosition():sendMagicEffect(382) --382
      end
   end



   return primaryDamage, primaryType, secondaryDamage, secondaryType
end

creatureevent:register()

creatureevent = CreatureEvent("system_Dodge_Login")
function creatureevent.onLogin(player)
   player:registerEvent("system_Dodge_Health")
   player:registerEvent("system_Dodge_Mana")
   return true
end

creatureevent:register()