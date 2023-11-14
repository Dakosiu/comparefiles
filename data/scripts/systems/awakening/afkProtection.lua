local creatureevent = CreatureEvent("ProtectionAFK_Dodge_Health")
function creatureevent.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType,
                                      origin)

   if not creature:isPlayer() then
      return primaryDamage, primaryType, secondaryDamage, secondaryType
   end

   if primaryType == COMBAT_HEALING then
      return primaryDamage, primaryType, secondaryDamage, secondaryType
   end

   local client = creature:getClient()
   local ip = Game.convertIpToString(creature:getIp())
   local looking = client.ping
   local confirmation = {}

   if ip == "0.0.0.0" then
      for i = 1, 10 do
         if client.ping == looking then
            table.insert(confirmation, i)
         end
         for i in pairs(confirmation) do
            if i == 10 then
               primaryDamage = 0
               secondaryDamage = 0
               creature:getPosition():sendMagicEffect(50) --251
            end
         end
      end
   end
   return primaryDamage, primaryType, secondaryDamage, secondaryType
end

creatureevent:register()

creatureevent = CreatureEvent("ProtectionAFK_Dodge_Mana")
function creatureevent.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType,
                                      origin)

   if not creature:isPlayer() then
      return primaryDamage, primaryType, secondaryDamage, secondaryType
   end

   if primaryType == COMBAT_HEALING then
      return primaryDamage, primaryType, secondaryDamage, secondaryType
   end

   local client = creature:getClient()
   local ip = Game.convertIpToString(creature:getIp())
   local looking = client.ping
   local confirmation = {}
   
   if client.ping >= 1000 then
      ip = "0.0.0.0"
   end
   if ip == "0.0.0.0" then
      for i = 1, 10 do
         if client.ping == looking then
            table.insert(confirmation, i)
         end
         for i in pairs(confirmation) do
            if i == 10 then
               primaryDamage = 0
               secondaryDamage = 0
               creature:getPosition():sendMagicEffect(50) --251
            end
         end
      end
   end
   return primaryDamage, primaryType, secondaryDamage, secondaryType
end

creatureevent:register()

creatureevent = CreatureEvent("ProtectionAFK_Dodge_Login")
function creatureevent.onLogin(player)
   player:registerEvent("ProtectionAFK_Dodge_Health")
   player:registerEvent("ProtectionAFK_Dodge_Mana")
   return true
end

creatureevent:register()
