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

function Player.getAllProtection(self)
   
   	local value = 0	
	for i = 1, 11 do
		local item = self:getSlotItem(i)
		if item then
		           local _canCheck = false
			       local it = ItemType(item:getId())
			             if it then
						    local slot = it:getRealSlot()
							if slot then
							   if slot == "weapon" then
							      if i == 5 or i == 6 then
								     _canCheck = true
							      end
							   elseif i == slot then
							         _canCheck = true
						       end
							end
					     end
			 
			 if _canCheck then
		        local protection = item:getProtectionAll()
			    if protection > 0 then
			       value = value + protection
			    end
		     end
		end
	end
	
    if value == 0 then
       value = 0
    end
	
		value = (self:getProtectionAllBase() + value) + self:getAddonsBonusProtection() + self:protectionAllStatsBonus()
    return value
end

--HEALTH

local protec = CreatureEvent("protectionAllBase_onHealthChange")
function protec.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
   
   if not creature:isPlayer() then
      return primaryDamage, primaryType, secondaryDamage, secondaryType
   end

   if primaryType == COMBAT_HEALING then
      return primaryDamage, primaryType, secondaryDamage, secondaryType
   end
   
   local protection = creature:getAllProtection() / 100
   if protection then
      primaryDamage = primaryDamage + primaryDamage * -protection
      secondaryDamage = secondaryDamage + secondaryDamage * -protection
   end
   
return primaryDamage, primaryType, secondaryDamage, secondaryType
end

protec:register()

--MANA

local protec = CreatureEvent("protectionAllBase_onManaChange")
function protec.onManaChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
   
   if not creature:isPlayer() then
      return primaryDamage, primaryType, secondaryDamage, secondaryType
   end

   if primaryType == COMBAT_MANADRAIN and primaryDamage > 0 then
      return primaryDamage, primaryType, secondaryDamage, secondaryType
   end
   
   local protection = creature:getAllProtection() / 100
   if protection then
      primaryDamage = primaryDamage + primaryDamage * -protection
      secondaryDamage = secondaryDamage + secondaryDamage * -protection
   end
   
return primaryDamage, primaryType, secondaryDamage, secondaryType

end

protec:register()

protec = CreatureEvent("protectionAllBase_onLogin")
function protec.onLogin(player)
    player:registerEvent("protectionAllBase_onManaChange")
    player:registerEvent("protectionAllBase_onHealthChange")
	return true
end
protec:register()