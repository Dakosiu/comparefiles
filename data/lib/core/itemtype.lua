local slotBits = {
	[CONST_SLOT_HEAD] = SLOTP_HEAD,
	[CONST_SLOT_NECKLACE] = SLOTP_NECKLACE,
	[CONST_SLOT_BACKPACK] = SLOTP_BACKPACK,
	[CONST_SLOT_ARMOR] = SLOTP_ARMOR,
	[CONST_SLOT_RIGHT] = SLOTP_RIGHT,
	[CONST_SLOT_LEFT] = SLOTP_LEFT,
	[CONST_SLOT_LEGS] = SLOTP_LEGS,
	[CONST_SLOT_FEET] = SLOTP_FEET,
	[CONST_SLOT_RING] = SLOTP_RING,
	[CONST_SLOT_AMMO] = SLOTP_AMMO
}

function ItemType.usesSlot(self, slot)
	return bit.band(self:getSlotPosition(), slotBits[slot] or 0) ~= 0
end


function ItemType:getRealSlot2()
	
	
	if self:isStackable() then
	   return false
	end
	
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
