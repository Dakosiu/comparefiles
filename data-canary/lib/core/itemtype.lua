function ItemType.isWeapon(self)
    -- NOTE: stackable weapons such as throwing stars and spears are treated as ammunition
    -- ammunition is not supposed to be upgradeable
    -- stackable items with attributes can't be restacked
    return (self:getAttack() > 0 or self:getShootRange() > 1) and not self:isStackable()
end

function ItemType:getRealSlot()

    if self:isStackable() or self:isContainer() or self:getCharges() > 0 or self:getDecayId() > -1 or self:getTransformEquipId() > 0 then
		return false
	end
    
	local str = nil
	
    local slot = self:getSlotPosition() - SLOTP_LEFT - SLOTP_RIGHT
          if slot == SLOTP_NECKLACE then
	         str = "necklace"
	      elseif slot == SLOTP_RING then
	         str = "ring"
		  elseif slot == SLOTP_ARMOR then
		     str = "armor"
		  elseif slot == SLOTP_LEGS then
		     str = "legs"
		  elseif slot == SLOTP_HEAD then
		     str = "helmet"
		  elseif slot == SLOTP_FEET then
		     str = "boots"
	      end
		  
		  local weapon = self:getWeaponType()
		  
		  if weapon > 0 then
		     if weapon == WEAPON_SHIELD then
			    str = "shield"
			 elseif weapon == WEAPON_DISTANCE then
			    str = "distance"
			 elseif weapon == WEAPON_WAND then
			    str = "wand"
			 elseif isInArray({WEAPON_SWORD, WEAPON_CLUB, WEAPON_AXE}, weapon) then
			    str = "weapon"
			
			 end
		  end
		  
	return str or false
end

function ItemType:getRealSlot2()
	
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