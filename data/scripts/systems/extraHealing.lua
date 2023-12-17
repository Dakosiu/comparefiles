function ItemType:getRealSlot()
	
	local slot = self:getSlotPosition() - SLOTP_LEFT - SLOTP_RIGHT
	
	if slot == SLOTP_HEAD then
	   return CONST_SLOT_HEAD
	elseif slot == SLOTP_NECKLACE then
	   return CONST_SLOT_NECKLACE 	
	elseif slot == SLOTP_BACKPACK then
	   return CONST_SLOT_BACKPACK
	elseif slot == SLOTP_ARMOR then
	   return CONST_SLOT_ARMOR
	elseif slot == SLOTP_LEGS then
	   return CONST_SLOT_LEGS
	elseif slot == SLOTP_FEET then
	   return CONST_SLOT_FEET
	elseif slot == SLOTP_RING then
	   return CONST_SLOT_RING
	elseif slot == SLOTP_AMMO then
	   return CONST_SLOT_AMMO 
	end
	
	local weapon = self:getWeaponType()
	if weapon > 0 then
	   return "weapon"
	end
	
	return false
end

function Player.getItemsExtraHealing(self)
   
   	local value = 0	
	
	for i = CONST_SLOT_HEAD, CONST_SLOT_AMMO do
		local item = self:getSlotItem(i)
		if item then
		           local _canCheck = false
			       local it = ItemType(item:getId())
			             if it then
						    local slot = it:getRealSlot()
							if slot then
							   if slot == "weapon" then
							      if i == CONST_SLOT_LEFT or i == CONST_SLOT_RIGHT then
								     _canCheck = true
							      end
							   elseif i == slot then
							         _canCheck = true
						       end
							end
					     end
			 
			 if _canCheck then
		        local extrahealing = item:getExtraHealing()
			    if extrahealing > 0 then
			       value = value + extrahealing
			    end
		     end
		end
	end
	
    if value == 0 then
       return false
    end
	
    return value --/100
end

function Player.getExtraHealing(self)

     local value = 0
	 
     local vocation = self:getVocation()
	 if not vocation then
	    return false
     end
	 
	 local vocationValue = vocation:getExtraHealing()
	 if vocationValue then
	    vocationValue = vocationValue -- /100
	    value = value + vocationValue
	 end
	 
	 local itemsValue = self:getItemsExtraHealing()
	 if itemsValue then
	    value = value + itemsValue
	 end
	 
	 local baseValue = self:getExtraHealingBase()
	 if baseValue then
	    value = value + baseValue
	 end
	 
	 if value == 0 then
	    return false
	 end
	 
	 return value
	 
end


local extraHealing = CreatureEvent("extraHealing_onHealthChange")
function extraHealing.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
   
   local player = Player(creature)
   if not player then
      return primaryDamage, primaryType, secondaryDamage, secondaryType
   end
   
   if not primaryType == COMBAT_HEALING then
      return primaryDamage, primaryType, secondaryDamage, secondaryType
   end

   if not secondaryType == COMBAT_HEALING then
      return primaryDamage, primaryType, secondaryDamage, secondaryType
   end
   
	local extraHealing = player:getTotalExtraHealing()
	if extraHealing then
		local value = extraHealing / 100 
		if value and primaryType == COMBAT_HEALING then
			primaryDamage = primaryDamage + primaryDamage * value
			secondaryDamage = secondaryDamage + secondaryDamage * value
		end
	end
   
return primaryDamage, primaryType, secondaryDamage, secondaryType
end
extraHealing:register()

extraHealing = CreatureEvent("extraHealing_onLogin")
function extraHealing.onLogin(player)
    player:registerEvent("extraHealing_onHealthChange")
	return true
end
extraHealing:register()