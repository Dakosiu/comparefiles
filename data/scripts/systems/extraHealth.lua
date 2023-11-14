local STORAGE_EXTRA_HEALTH_MAX = 323234

function Player.saveHealth(self)

   if not self then
      return nil
   end

   local hp = self:getMaxHealth()
   local bonushp = self:getBonusHealth()
   local extrahp = self:getExtraHealth()
   local finalValue = hp - bonushp - extrahp

   self:setStorageValue(STORAGE_EXTRA_HEALTH_MAX, finalValue)
   return true
end

function Player.updateHealth(self)

   if not self then
      return nil
   end

   local hp = self:getStorageValue(STORAGE_EXTRA_HEALTH_MAX)
   local bonushp = self:getBonusHealth()
   local extrahp = self:getExtraHealth()
   local value = hp + extrahp
   self:setMaxHealth(value)
   if self:getHealth() < value then
      self:setHealth(value)
   end
   return true
end

function Player.addExtraHealth(self, value)

   if not self then
      return nil
   end

   if not value then
      return nil
   end

   self:setExtraHealth(self:getExtraHealth() + value)
   local bonushp = self:getBonusHealth()

   local hp = self:getMaxHealth() - bonushp
   local extrahp = self:getExtraHealth()
   self:setMaxHealth(hp + value)
   self:saveHealth()
   self:updateHealth()
   return true
end

function Player.getAllBonusesHealth(self)
   local value = 0

   local extra = self:getExtraHealth()
   if extra > 0 then
      value = value + extra
   end
   local bonus = self:getBonusHealth()
   if bonus > 0 then
      value = value + bonus
   end

   local addon = self:getExtraHealthAddon()
   if addon and addon > 0 then
      value = value + addon
   end

   return value
end
