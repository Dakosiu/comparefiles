local STORAGE_EXTRA_MANA_MAX = 323235

function Player.saveMana(self)

   if not self then
      return nil
   end
      
   local mp = self:getMaxMana()
   local bonus = self:getBonusMana()
   local extra = self:getExtraMana()
   local finalValue = mp - bonus - extra
      
   self:setStorageValue(STORAGE_EXTRA_MANA_MAX, finalValue)
   return true
end

function Player.updateMana(self)
   
   if not self then
      return nil
   end
   
   local mp = self:getStorageValue(STORAGE_EXTRA_MANA_MAX)
   local bonus = self:getBonusMana()
   local extra = self:getExtraMana()
   local value = mp + extra
   self:setMaxMana(value)
   if self:getMana() < value then
      self:addMana(value)
   end
   return true
end

function Player.addExtraMana(self, value)
       
	if not self then
           return nil
        end
        
        if not value then
           return nil
        end  
        
        self:setExtraMana(self:getExtraMana() + value)
        local bonus = self:getBonusMana()
        local mp = self:getMaxMana() - bonus
        local extra = self:getExtraMana()
        self:setMaxMana(mp + value)
        self:saveMana()
	    self:updateMana()
	return true
end   


function Player.getAllBonusesMana(self)
   local value = 0
   
   local extra = self:getExtraMana()
   if extra > 0 then
      value = value + extra
   end
   local bonus = self:getBonusMana()
   if bonus and bonus > 0 then
      value = value + bonus
   end
   
   local addon = self:getExtraManaAddon()
   if addon > 0 then
      value = value + addon
   end
   
   return value
end