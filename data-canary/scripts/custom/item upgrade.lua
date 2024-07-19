local WAND_DAMAGE_SYSTEM = {}
WAND_DAMAGE_SYSTEM.attribute = "item_upgrade_wand_damage"

function WAND_DAMAGE_SYSTEM:setDamage(item, value)
    
	if not item or not value then
	   return 
	end
	
	item:setCustomAttribute(WAND_DAMAGE_SYSTEM.attribute, value)
end

function WAND_DAMAGE_SYSTEM:getDamage(item)
    
	if not item then
	   return nil
	end
	
	local value = item:getCustomAttribute(WAND_DAMAGE_SYSTEM.attribute)
	if not value then
	   return false
	end
	return value
end

function WAND_DAMAGE_SYSTEM:addDamage(item, value)
   
   if not item then
      return nil
   end
   
   local value2 = WAND_DAMAGE_SYSTEM:getDamage(item)
   if not value2 then
      WAND_DAMAGE_SYSTEM:setDamage(item, value)
	  return
   end
   
   WAND_DAMAGE_SYSTEM:setDamage(item, value2 + value)
   return true
end   

local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    
	local pos = player:getPosition()
	local isEnabled = false
	--for zaweq
	if isEnabled then

	
	local exchangeGem = ITEM_UPGRADE_SYSTEM.EXCHANGE_GEMS[item:getId()]
	if exchangeGem then
	   
	   if item.type < exchangeGem.amount then
	      return true
	   end
	   
	   item:transform(item.itemid, item.type - exchangeGem.amount)
	   player:addItem(exchangeGem.exchangeTo, 1)
	   
	   pos:sendMagicEffect(CONST_ME_MAGIC_GREEN)
	   player:sendCancelMessage("You have sucessfully exchanged elements to upgrade gem.")
	   
	   return true
	end
	
	end
	
	
	if target == nil then
	   return true
	end
	
	local weaponUpgrade = ITEM_UPGRADE_SYSTEM.WEAPON_UPGRADE[item:getId()]
    if weaponUpgrade then
	
           local it = ItemType(target:getId())
           local slot = it:getRealSlot()
		 
		   if not slot then
		   return true
		   end

		   local _isWeapon = false
		   
		   if slot == "wand" or slot == "weapon" or slot == "distance" then
		      _isWeapon = true
		   end
		 
		   if not _isWeapon then
		      player:sendCancelMessage("Only weapons can be upgraded with this gem.")
		      return true
		   end
		   
		   local attr = "defense"
		   
		   local getUpgraded = target:getUpgradeLevel()
				 
		   local upgradeMaxLevel = #weaponUpgrade.UPGRADE_TABLE_VALUES	   
		   if getUpgraded >= upgradeMaxLevel then
		      player:sendCancelMessage("You can't upgrade this item anymore with this gem.")
			  return true
		   end
		   
		   
	       local up = weaponUpgrade.UPGRADE_TABLE_VALUES[getUpgraded+1]
		   
		   if not generateChance(up.chanceForUpgrade) then
		      
			  if generateChance(up.chanceForDestroy) then
			     pos:sendMagicEffect(CONST_ME_POFF)
				 player:sendTextMessage(MESSAGE_STATUS_WARNING, "You have failed the upgrade, item destroyed.")
				 target:remove()
				 item:remove(1)
				 return true
			  end
			  
			  if generateChance(up.chanceForDowngrade) then
				 
				 -- if getUpgraded == 0 then
				    -- target:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, "")
				 -- end
				 
				 local downgradeLevel = up.DowngradeLevel
				 
				 
				 local arm = 0
				 local atk = 0
				 
				 
				 local updateLevel = getUpgraded - downgradeLevel
				 				 
				 
				if updateLevel <= 0 then
				    updateLevel = 0
					arm = target:getType():getDefense()
					target:setUpgradeDescription("empty")
				else
				    local defStr = target:getUpgradeType("defense")[updateLevel]
					arm = tonumber(getValueFromString(defStr))
				    target:setUpgradeDescription("Upgraded: +" .. updateLevel .."")
				end
				 
				 target:setAttribute(attr, arm)
				 target:setAttribute("attack", atk)
				 
				 target:setUpgradeLevel(updateLevel)
				 pos:sendMagicEffect(CONST_ME_POFF)
				 player:sendTextMessage(MESSAGE_STATUS_WARNING, "You have failed the upgrade, item downgraded to level " .. updateLevel .. ".")
				 item:remove(1)
			     return true
		      end
			    pos:sendMagicEffect(CONST_ME_POFF)
			    player:sendTextMessage(MESSAGE_STATUS_WARNING, "You have failed the upgrade.")
				item:remove(1)
				return true
		    end
		   
		   local armor = target:getAttribute(attr)
		   if armor == 0 then
		      armor = target:getType():getDefense()
		   end
		   local attack = target:getAttribute("attack")
		   if attack == 0 then
		      attack = target:getType():getAttack()
		   end
		   
		   target:setUpgradeDescription("Upgraded: +" .. getUpgraded+1 .."")
		   target:setUpgradeLevel(getUpgraded+1)

		   
		   target:setAttribute(attr, armor+up.def)
		   
		   if slot == "wand" then
		      
		      target:setAttribute("attack", attack+up.magicatk)
			  --WAND_DAMAGE_SYSTEM:addDamage(target, attack+up.magicatk)
			  else
		      target:setAttribute("attack", attack+up.atk)
		   end
		   
		   local saveArmor = target:getAttribute(attr)
		   target:addUpgradeType(attr, "+" .. saveArmor)
		   
		   local saveAttack = target:getAttribute("attack")
		   target:addUpgradeType("attack", "+" .. saveAttack)
		   
		   pos:sendMagicEffect(CONST_ME_MAGIC_GREEN)
		   
		   if getUpgraded == 0 then
		      player:sendTextMessage(MESSAGE_INFO_DESCR, "Upgrade sucessfull to " .. getUpgraded + 1 .. " level.")
			  else
		      player:sendTextMessage(MESSAGE_INFO_DESCR, "Upgrade sucessfull from " .. " level " .. getUpgraded .. " to level " .. getUpgraded + 1 .. ".")
			  
		   end
		   item:remove(1)
		   
		return true   
	end
	
	local armorUpgrade = ITEM_UPGRADE_SYSTEM.ARMOR_UPGRADE[item:getId()]
    if armorUpgrade then
	
           local it = ItemType(target:getId())
           local slot = it:getRealSlot()
		 
		   if not slot then
		   return true
		   end

		   local _isArmor = true
		   local _isShield = false
		   
		   if slot == "amulet" or slot == "ring" or slot == "wand" or slot == "distance" or slot == "weapon" then
		      _isArmor = false
		   end
		 
		   if not _isArmor then
		      player:sendCancelMessage("Only equipment and shield can be upgraded with this gem.")
		      return true
		   end
		   
           local attr = "armor"		   
           if slot == "shield" then
		   attr = "defense"
		   _isShield = true
		   end
		   
		   local getUpgraded = target:getUpgradeLevel()
				 
		   local upgradeMaxLevel = #armorUpgrade.UPGRADE_TABLE_VALUES	   
		   if getUpgraded >= upgradeMaxLevel then
		      player:sendCancelMessage("You can't upgrade this item anymore with this gem.")
			  return true
		   end
		   
		   
	       local up = armorUpgrade.UPGRADE_TABLE_VALUES[getUpgraded+1]
		   
		   if not generateChance(up.chanceForUpgrade) then
		      
			  if generateChance(up.chanceForDestroy) then
			     pos:sendMagicEffect(CONST_ME_POFF)
				 player:sendTextMessage(MESSAGE_STATUS_WARNING, "You have failed the upgrade, item destroyed.")
				 target:remove()
				 item:remove(1)
				 return true
			  end
			  
			  if generateChance(up.chanceForDowngrade) then
				 
				 if getUpgraded == 0 then
				    target:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, "")
				 end
				 
				 local downgradeLevel = up.DowngradeLevel
				 player:say(downgradeLevel)
				 
				 
				 local arm = 0
				 
				 
				 local updateLevel = getUpgraded - downgradeLevel
				 				 
				 
				if updateLevel <= 0 then
				    updateLevel = 0
					if _isShield then
					   arm = target:getType():getDefense()
					   else
					   arm = target:getType():getArmor()
					end
					target:setUpgradeDescription("empty")
				else
				    if _isShield then
				    local defStr = target:getUpgradeType("defense")[updateLevel]
					arm = tonumber(getValueFromString(defStr))
					else
					local armStr = target:getUpgradeType("armor")[updateLevel]
					arm = tonumber(getValueFromString(armStr))
				    target:setUpgradeDescription("Upgraded: +" .. updateLevel .."")
					end
				end
				 
				 target:setAttribute(attr, arm)
				 
				 target:setUpgradeLevel(updateLevel)
				 pos:sendMagicEffect(CONST_ME_POFF)
				 player:sendTextMessage(MESSAGE_STATUS_WARNING, "You have failed the upgrade, item downgraded to level " .. updateLevel .. ".")
				 item:remove(1)
				 
			     return true
		      end
			  
			     pos:sendMagicEffect(CONST_ME_POFF)
				 player:sendTextMessage(MESSAGE_STATUS_WARNING, "You have failed the upgrade.")
				 item:remove(1)
				 return true
		   
		    end
		   
		   local armor = target:getAttribute(attr)
		   if armor == 0 then
		      if _isShield then
		         armor = target:getType():getDefense()
			  else
			     armor = target:getType():getArmor()
			  end
		   end
		   
		   target:setUpgradeDescription("Upgraded: +" .. getUpgraded+1 .."")
		   target:setUpgradeLevel(getUpgraded+1)		   
		   target:setAttribute(attr, armor+up.armor)
		   
		   local saveArmor = target:getAttribute(attr)
		   target:addUpgradeType(attr, "+" .. saveArmor)
		   
		   pos:sendMagicEffect(CONST_ME_MAGIC_GREEN)
		   
		   if getUpgraded == 0 then
		      player:sendTextMessage(MESSAGE_INFO_DESCR, "Upgrade sucessfull to " .. getUpgraded + 1 .. " level.")
			  else
		      player:sendTextMessage(MESSAGE_INFO_DESCR, "Upgrade sucessfull from " .. " level " .. getUpgraded .. " to level " .. getUpgraded + 1 .. ".")
		   end
		   item:remove(1)
		   
		return true   
	end
	
	local jewelUpgrade = ITEM_UPGRADE_SYSTEM.JEWELRY_UPGRADE[item:getId()]
    if jewelUpgrade then
	
           local it = ItemType(target:getId())
           local slot = it:getRealSlot()
		 
		   if not slot then
		   return true
		   end

		   local _isJewel = false
		   if slot == "necklace" or slot == "ring" then
		      _isJewel = true
		   end
		 
		   if not _isJewel then
		      player:sendCancelMessage("Only necklaces and rings can be upgraded with this gem.")
		      return true
		   end
		   
           local attr = "armor"		   
		   
		   local getUpgraded = target:getUpgradeLevel()
				 
		   local upgradeMaxLevel = #jewelUpgrade.UPGRADE_TABLE_VALUES	   
		   if getUpgraded >= upgradeMaxLevel then
		      player:sendCancelMessage("You can't upgrade this item anymore with this gem.")
			  return true
		   end
		   
		   
	       local up = jewelUpgrade.UPGRADE_TABLE_VALUES[getUpgraded+1]

		   if not generateChance(up.chanceForUpgrade) then
		      
			  if generateChance(up.chanceForDestroy) then
			     pos:sendMagicEffect(CONST_ME_POFF)
				 player:sendTextMessage(MESSAGE_STATUS_WARNING, "You have failed the upgrade, item destroyed.")
				 target:remove()
				 item:remove(1)
				 return true
			  end
			  
			  if generateChance(up.chanceForDowngrade) then
				 
				 if getUpgraded == 0 then
				    target:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, "")
				 end
				 
				 local downgradeLevel = up.DowngradeLevel
				 player:say(downgradeLevel)
				 
				 local arm = 0
				 
				 local updateLevel = getUpgraded - downgradeLevel
				 				 
				if updateLevel <= 0 then
				    updateLevel = 0
					arm = target:getType():getArmor()
					target:setUpgradeDescription("empty")
				else
					local armStr = target:getUpgradeType("armor")[updateLevel]
					arm = tonumber(getValueFromString(armStr))
				    target:setUpgradeDescription("Upgraded: +" .. updateLevel .."")
				end
				 
				 target:setAttribute(attr, arm)
				 
				 target:setUpgradeLevel(updateLevel)
				 pos:sendMagicEffect(CONST_ME_POFF)
				 player:sendTextMessage(MESSAGE_STATUS_WARNING, "You have failed the upgrade, item downgraded to level " .. updateLevel .. ".")
				 item:remove(1)
			     return true
		      end
			     pos:sendMagicEffect(CONST_ME_POFF)
			     player:sendTextMessage(MESSAGE_STATUS_WARNING, "You have failed the upgrade.")
				 item:remove(1)
				 return true
		   
		    end
		   
		   local armor = target:getAttribute(attr)
		   if armor == 0 then
			     armor = target:getType():getArmor()
		   end
		   
		   target:setUpgradeDescription("Upgraded: +" .. getUpgraded+1 .."")
		   target:setUpgradeLevel(getUpgraded+1)		   
		   target:setAttribute(attr, armor+up.armor)
		   
		   local saveArmor = target:getAttribute(attr)
		   target:addUpgradeType(attr, "+" .. saveArmor)
		   
		   pos:sendMagicEffect(CONST_ME_MAGIC_GREEN)
		   
		   if getUpgraded == 0 then
		      player:sendTextMessage(MESSAGE_INFO_DESCR, "Upgrade sucessfull to " .. getUpgraded + 1 .. " level.")
			  else
		      player:sendTextMessage(MESSAGE_INFO_DESCR, "Upgrade sucessfull from " .. " level " .. getUpgraded .. " to level " .. getUpgraded + 1 .. ".")
		   end
		   item:remove(1)
		return true   
	end
	
	local specialUpgrade = ITEM_UPGRADE_SYSTEM.SPECIAL_UPGRADE[item:getId()]
    if specialUpgrade then
	
           local it = ItemType(target:getId())
           local slot = it:getRealSlot()
		 
		   if not slot then
		   return true
		   end

		   local _isArmor = true
		   local _isShield = false
		   local _isWeapon = false
		   local _isJewelry = false
		   
		   local defensiveAttr = "armor"
		   local attackAttr = "attack"
		   
		   
		   if slot == "wand" or slot == "weapon" or slot == "distance" then
		      _isWeapon = true
			  _isShield = true
			  _isArmor = false
			  defensiveAttr = "defense"
           elseif slot == "shield" then
		      _isShield = true
			  _isArmor = false
			  defensiveAttr = "defense"
		   elseif slot == "necklace" or slot == "ring" then
		      _isJewelry = true
		   end
		   
			   
		   local getUpgraded = target:getUpgradeLevel()
		   
		   
		   local upgradeMaxLevel = ITEM_UPGRADE_SYSTEM.WEAPON_UPGRADE_LEVEL_MAX  
		   
		   if getUpgraded >= upgradeMaxLevel then
		      player:sendCancelMessage("This item reached max upgrade level.")
			  return true
		   end
		   
		   if getUpgraded ~= upgradeMaxLevel - 1 then
		      player:sendCancelMessage("Only item with " .. upgradeMaxLevel - 1 .. " upgrade level can be upgraded with this gem.")
			  return true
		   end
				  

		   local up = nil
		   
		   if _isWeapon then
	           up = specialUpgrade.UPGRADE_TABLE_VALUES["weapons"]
		   elseif _isShield or _isArmor then
		       up = specialUpgrade.UPGRADE_TABLE_VALUES["armors"]
		   elseif _isJewelry then
		       up = specialUpgrade.UPGRADE_TABLE_VALUES["jewelry"]
		   end
		   
		   
		   if not generateChance(up.chanceForUpgrade) then
		      
			  if generateChance(up.chanceForDestroy) then
			     pos:sendMagicEffect(CONST_ME_POFF)
				 player:sendTextMessage(MESSAGE_STATUS_WARNING, "You have failed the upgrade, item destroyed.")
				 target:remove()
				 item:remove(1)
				 return true
			  end
			  
			  if generateChance(up.chanceForDowngrade) then
				 
				 if getUpgraded == 0 then
				    target:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, "")
				 end
				 
				 local downgradeLevel = up.DowngradeLevel
				 player:say(downgradeLevel)
				 
				 
				 local arm = 0
				 local atk = 0
				 
				 local updateLevel = getUpgraded - downgradeLevel
				 				 
				 
				if updateLevel <= 0 then
				    updateLevel = 0
					if _isShield then
					   arm = target:getType():getDefense()
					   else
					   arm = target:getType():getArmor()
					end
					if _isWeapon then
					   arm = target:getType():getDefense()
					   atk = target:getType():getAttack()
					end
					target:setUpgradeDescription("empty")
				else
				    if _isShield or _isWeapon then
				    local defStr = target:getUpgradeType("defense")[updateLevel]
					arm = tonumber(getValueFromString(defStr))
					else
					local armStr = target:getUpgradeType("armor")[updateLevel]
					arm = tonumber(getValueFromString(armStr))
					end
					
					if _isweapon then
					local atkStr = target:getUpgradeType("attack")[updateLevel]
			        atk = tonumber(getValueFromString(atkStr))
					end
					target:setUpgradeDescription("Upgraded: +" .. updateLevel .."")
				end
				 
				 if _isWeapon then
				    target:setAttribute("attack", atk)
				 end
				 
				  
				  
				 target:setAttribute(defensiveAttr, arm)
				 
				 target:setUpgradeLevel(updateLevel)
				 pos:sendMagicEffect(CONST_ME_POFF)
				 player:sendTextMessage(MESSAGE_STATUS_WARNING, "You have failed the upgrade, item downgraded to level " .. updateLevel .. ".")
				 item:remove(1)
			     return true
		      end
		   
		    end
		   
		   local armor = target:getAttribute(defensiveAttr)
		   if armor == 0 then
		      if _isShield or _isWeapon then
		         armor = target:getType():getDefense()
			  else
			     armor = target:getType():getArmor()
			  end
		   end
		   
		   local attack = target:getAttribute("attack")
		   
		   target:setUpgradeDescription("Upgraded: +" .. getUpgraded+1 .."")
		   target:setUpgradeLevel(getUpgraded+1)
           
           if _isWeapon then	
              target:setAttribute(defensiveAttr, armor+up.def)
			  if slot == "wand" then
			     target:setAttribute("attack", attack+up.magicatk)
				 --WAND_DAMAGE_SYSTEM:addDamage(target, attack+up.magicatk)
				 else
				 target:setAttribute("attack", attack+up.atk)
			  end
              else			  
		      target:setAttribute(defensiveAttr, armor+up.armor)
		   end
		   
		   local saveArmor = target:getAttribute(defensiveAttr)
		   target:addUpgradeType(defensiveAttr, "+" .. saveArmor)
		   
		   if _isWeapon then
		       local saveAttack = target:getAttribute("attack")
		       target:addUpgradeType("attack", "+" .. saveAttack)
		   end
		   
		   pos:sendMagicEffect(CONST_ME_MAGIC_GREEN)
		   
		   if getUpgraded == 0 then
		      player:sendTextMessage(MESSAGE_INFO_DESCR, "Upgrade sucessfull to " .. getUpgraded + 1 .. " level.")
			  player:sendTextMessage(MESSAGE_INFO_DESCR, "Upgrade sucessfull to " .. getUpgraded + 1 .. " level.")
			  else
		      player:sendTextMessage(MESSAGE_INFO_DESCR, "Upgrade sucessfull from " .. " level " .. getUpgraded .. " to level " .. getUpgraded + 1 .. ".")
		   end
		   item:remove(1)
		   
		return true   
	end
	
return true
end


local wandDamage = CreatureEvent("onWandItemUpgrade")
function wandDamage.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
	   if not attacker or origin < 3 then
	      return primaryDamage, primaryType, secondaryDamage, secondaryType
	   end

	   
	   if attacker:isPlayer() then
	      local value = 0
		  
	      if creature:isPlayer() and attacker:getWandDamage() > 0 then 
		     value = attacker:getWandDamage(creature, primaryType) / 2
		  else
			 value = attacker:getWandDamage(creature, primaryType) 
	      end
		  
		  
	      if value > 0 then
	        if primaryDamage >= 1 then
	           primaryDamage = primaryDamage + value
            end
	   
	        if primaryDamage <= -1 then
	           primaryDamage = primaryDamage - value 
	        end
	        
	     end
	     
	   end

return primaryDamage, primaryType, secondaryDamage, secondaryType
end



local login = CreatureEvent("onLoginItemUpgrade")
function login.onLogin(player)
	player:registerEvent("onWandItemUpgrade")
	return true
end

login:register()
wandDamage:register()


for i, weapon in pairs(ITEM_UPGRADE_SYSTEM.WEAPON_UPGRADE) do
action:id(i)
end

for z, armor in pairs(ITEM_UPGRADE_SYSTEM.ARMOR_UPGRADE) do
action:id(z)
end

for x, jewelry in pairs(ITEM_UPGRADE_SYSTEM.JEWELRY_UPGRADE) do
action:id(x)
end

for a, special in pairs(ITEM_UPGRADE_SYSTEM.SPECIAL_UPGRADE) do
action:id(a)
end

for c, exchange in pairs(ITEM_UPGRADE_SYSTEM.EXCHANGE_GEMS) do
action:id(c)
end

action:register()