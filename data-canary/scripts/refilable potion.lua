RFILLABLE_POTION_CONFIG = {
                     ["potion of the titan"] = {
					                              ["Vocations"] = { "knight", "elite knight" },
							                      ["Normal"] = {
												                  requiredLevel = 750,
																  ["Health"] = { min = 1050, max = 1400 },
																  ["Refill"] = {
																                 ["Required Items"] = {
															                                           { type = "item", name = "crystal coin", value = 300 },
															                                          }
																	           },
																},
							                      ["Level 1"] = {
												                  requiredLevel = 1000,
																  ["Health"] = { min = 1150, max = 1500 },
																  ["Refill"] = {
																                 ["Required Items"] = {
															                                           { type = "item", name = "crystal coin", value = 400 },
															                                          }
																	           },
																  ["Upgrade"] = {  --- potrzebne przedmioty na upgrade na lvl 1.
																                 ["Required Items"] = {
																				                        { type = "item", id = 9642, value = 100 },
                                                                                                      }	
                                                                               }																									  
																},
							                      ["Level 2"] = {
												                  requiredLevel = 1250,
																  -- increaseCharges = 5000, -- usunąć jak nie ma zwiększać ilości ładunków
																  ["Health"] = { min = 1250, max = 1600 },
																  ["Refill"] = {
																                 ["Required Items"] = {
															                                            { type = "item", name = "crystal coin", value = 500 },
															                                          }
																	           },
																  ["Upgrade"] = {  --- potrzebne przedmioty na upgrade na lvl 2.
																                 ["Required Items"] = {
																				                        { type = "item", id = 9642, value = 100 },
                                                                                                      }	
                                                                               }																									  
																},		
							                      ["Level 3"] = {
												                  requiredLevel = 1500,
																  -- increaseCharges = 10000, -- usunąć jak nie ma zwiększać ilości ładunków
																  ["Health"] = { min = 1350, max = 1700 },
																  ["Refill"] = {
																                 ["Required Items"] = {
															                                            { type = "item", name = "crystal coin", value = 600 },
															                                          }
																	           },
																  ["Upgrade"] = {  --- potrzebne przedmioty na upgrade na lvl 2.
																                 ["Required Items"] = {
																				                        { type = "item", id = 9642, value = 100 },
                                                                                                      }	
                                                                               }																									  
																},																	
												},
				   				["potion of the ranger"] = {
								                  ["Vocations"] = { "paladin", "royal paladin" },
							                      ["Normal"] = {
												                  requiredLevel = 750, 
																  ["Health"] = { min = 500, max = 700 },
																  ["Mana"] = { min = 220, max = 320 },
																  ["Refill"] = {
																                 ["Required Items"] = {
															                                            { type = "item", name = "crystal coin", value = 300 },
															                                          }
																	           },
																},
							                      ["Level 1"] = {
												                  requiredLevel = 1000,
																  ["Health"] = { min = 550, max = 750 },
																  ["Mana"] = { min = 270, max = 370 },
																  ["Refill"] = {
																                 ["Required Items"] = {
															                                           { type = "item", name = "crystal coin", value = 400 },
															                                          }
																	           },
																  ["Upgrade"] = {  --- potrzebne przedmioty na upgrade na lvl 1.
																                 ["Required Items"] = {
																				                        { type = "item", id = 9642, value = 100 },
                                                                                                      }	
                                                                               }																									  
																},
							                      ["Level 2"] = {
												                  requiredLevel = 1250,
																  -- increaseCharges = 5000, -- usunąć jak nie ma zwiększać ilości ładunków
																  ["Health"] = { min = 600, max = 800 },
																  ["Mana"] = { min = 320, max = 420 },
																  ["Refill"] = {
																                 ["Required Items"] = {
															                                          { type = "item", name = "crystal coin", value = 500 },
															                                          }
																	           },
																  ["Upgrade"] = {  --- potrzebne przedmioty na upgrade na lvl 2.
																                 ["Required Items"] = {
																				                        { type = "item", id = 9642, value = 100 },
                                                                                                      }	
                                                                               }																									  
																},		
							                      ["Level 3"] = {
												                  requiredLevel = 1500,
																  -- increaseCharges = 10000, -- usunąć jak nie ma zwiększać ilości ładunków
																  ["Health"] = { min = 650, max = 850 },
																  ["Mana"] = { min = 370, max = 470 },
																  ["Refill"] = {
																                 ["Required Items"] = {
															                                            { type = "item", name = "crystal coin", value = 600 },
															                                          }
																	           },
																  ["Upgrade"] = {  --- potrzebne przedmioty na upgrade na lvl 2.
																                 ["Required Items"] = {
																				                        { type = "item", id = 9642, value = 100 },
                                                                                                      }	
                                                                               }																									  
																},																	
												},
                            ["potion of the wizard"] = {
							                      ["Vocations"] = { "sorcerer", "druid", "master sorcerer", "elder druid"  },
							                      ["Normal"] = {
												                  requiredLevel = 750, 
																  ["Mana"] = { min = 520, max = 720 },
																  ["Refill"] = {
																                 ["Required Items"] = {
															                                            { type = "item", name = "crystal coin", value = 300 },
															                                          }
																	           },
																},
							                      ["Level 1"] = {
												                  requiredLevel = 1000,
																  ["Mana"] = { min = 620, max = 820 },
																  ["Refill"] = {
																                 ["Required Items"] = {
															                                            { type = "item", name = "crystal coin", value = 400 },
															                                          }
																	           },
																  ["Upgrade"] = {  --- potrzebne przedmioty na upgrade na lvl 1.
																                 ["Required Items"] = {
																				                        { type = "item", id = 9642, value = 100 },
                                                                                                      }	
                                                                               }																									  
																},
							                      ["Level 2"] = {
												                  requiredLevel = 1250,
																  -- increaseCharges = 5000, -- usunąć jak nie ma zwiększać ilości ładunków
																  ["Mana"] = { min = 720, max = 920 },
																  ["Refill"] = {
																                 ["Required Items"] = {
															                                            { type = "item", name = "crystal coin", value = 500 },
															                                          }
																	           },
																  ["Upgrade"] = {  --- potrzebne przedmioty na upgrade na lvl 2.
																                 ["Required Items"] = {
																				                        { type = "item", id = 9642, value = 100 },
                                                                                                      }	
                                                                               }																									  
																},
							                      ["Level 3"] = {
												                  requiredLevel = 1500,
																  -- increaseCharges = 10000, -- usunąć jak nie ma zwiększać ilości ładunków
																  ["Mana"] = { min = 820, max = 1020 },
																  ["Refill"] = {
																                 ["Required Items"] = {
															                                            { type = "item", name = "crystal coin", value = 600 },
															                                          }
																	           },
																  ["Upgrade"] = {  --- potrzebne przedmioty na upgrade na lvl 2.
																                 ["Required Items"] = {
																				                        { type = "item", id = 9642, value = 100 },
                                                                                                      }	
                                                                               }																									  
																},																		
												},												
						 }
	

	
RFILLABLE_POTION_CONFIG_SMALL_POTIONS = {
                                          [19086] = { min = 50000, max = 50000 },
                                        }		

REFILLABLE_POTION_SYSTEM = {}
REFILLABLE_POTION_SYSTEM.attributes = {
                                       level = "refillable_potion_level",
									   maxCharges = "refillable_potion_saveCharges"
									  }
									 
for i, v in pairs(RFILLABLE_POTION_CONFIG) do
    if not REFILLABLE_POTION_SYSTEM.cache then
	   REFILLABLE_POTION_SYSTEM.cache = {}
	end
	local name = i:lower()
	REFILLABLE_POTION_SYSTEM.cache[name] = v
end


function REFILLABLE_POTION_SYSTEM:getDiscount(cost, leftCharges, maxCharges)
    local value = math.floor(leftCharges / maxCharges * 100);
    value = value / 100
    cost = cost - (cost * value)
	return cost
end

function REFILLABLE_POTION_SYSTEM:addMaxCharges(item, value)
   
 	if not item then
	   return nil
	end
	
	local charges = REFILLABLE_POTION_SYSTEM:getMaxCharges(item)
	
	return item:setCustomAttribute(REFILLABLE_POTION_SYSTEM.attributes.maxCharges, charges + value)
end

function REFILLABLE_POTION_SYSTEM:getMaxCharges(item)
    
	if not item then
	   return nil
	end

	local value = item:getCustomAttribute(REFILLABLE_POTION_SYSTEM.attributes.maxCharges)
	if not value then
	   local it = ItemType(item:getName())
	   return it:getRefill()
	end
	
	return value
end

function REFILLABLE_POTION_SYSTEM:getHealthValues(item)
    
	if not item then
	   return nil
	end
	
	local name = item:getName()
	
	local level = REFILLABLE_POTION_SYSTEM:getLevel(item)
	if level > 0 then
	   t = REFILLABLE_POTION_SYSTEM.cache[name]["Level " .. level]
	else
	   t = REFILLABLE_POTION_SYSTEM.cache[name]["Normal"]
	end
	
	if not t then
	   return nil
	end
	
	local str = ""
	
	local healthTable = t["Health"]
	if not healthTable then
	   return false
	end
	
	local minHealth = healthTable.min
	local maxHealth = healthTable.max
	
	str = "Regenerate Health: (" .. minHealth .. "-" .. maxHealth .. ")"
	return str
end	
	
function REFILLABLE_POTION_SYSTEM:getManaValues(item)
    
	if not item then
	   return nil
	end
	
	local name = item:getName()
	
	local level = REFILLABLE_POTION_SYSTEM:getLevel(item)
	if level > 0 then
	   t = REFILLABLE_POTION_SYSTEM.cache[name]["Level " .. level]
	else
	   t = REFILLABLE_POTION_SYSTEM.cache[name]["Normal"]
	end
	
	if not t then
	   return nil
	end
	
	local str = ""
	
	local manaTable = t["Mana"]
	if not manaTable then
	   return false
	end
	
	local minMana = manaTable.min
	local maxMana = manaTable.max
	
	str = "Regenerate Mana: (" .. minMana .. "-" .. maxMana .. ")"
	return str
end	

function REFILLABLE_POTION_SYSTEM:getLevel(item)
    
	if not item then
	   return nil
	end
	
	local value = item:getCustomAttribute(REFILLABLE_POTION_SYSTEM.attributes.level)
	if not value or value < 1 then
	   return 0
	end
	
	return value
end

function REFILLABLE_POTION_SYSTEM:addLevel(item)
    
	if not item then
	   return nil
	end
	
	local value = item:getCustomAttribute(REFILLABLE_POTION_SYSTEM.attributes.level)
	if not value or value < 1 then
	   return item:setCustomAttribute(REFILLABLE_POTION_SYSTEM.attributes.level, 1)
	end
	return item:setCustomAttribute(REFILLABLE_POTION_SYSTEM.attributes.level, value + 1)
end

function REFILLABLE_POTION_SYSTEM:canUse(player, item)
    
	if not player or not item then
	   return nil
	end
    local name = item:getName()
    local t = REFILLABLE_POTION_SYSTEM.cache[name]["Normal"]
	if not t then
	   return false
	end	
	
	local level = REFILLABLE_POTION_SYSTEM:getLevel(item)
	if level > 0 then
	   t = REFILLABLE_POTION_SYSTEM.cache[name]["Level " .. level]
	end

    local requiredLevel = t.requiredLevel
    if not requiredLevel or player:getLevel() >= requiredLevel then	
	   return true
	end
	return false
end
	
function REFILLABLE_POTION_SYSTEM:addValues(player, target, item)
    
	if not player or not item then
	   return nil
	end
	
	local name = item:getName()
	local t = REFILLABLE_POTION_SYSTEM.cache[name]["Normal"]
	if not t then
	   return nil
	end
	
	
	local level = REFILLABLE_POTION_SYSTEM:getLevel(item)
	if level > 0 then
	   t = REFILLABLE_POTION_SYSTEM.cache[name]["Level " .. level]
	end
	
	if not t then
	   return nil
	end
	
	local requiredLevel = t.requiredLevel
	if not REFILLABLE_POTION_SYSTEM:canUse(player, item) then
	   player:sendCancelMessage("You need atleast " .. requiredLevel .. " level to use this potion.")
	   player:getPosition():sendMagicEffect(CONST_ME_POFF)
	   return
	end
	
	local charges = item:getRefil()
	if charges <= 0 then
	   player:sendCancelMessage("this potion is out of charges and lost his power, you have to refill it.")
	   player:getPosition():sendMagicEffect(CONST_ME_POFF)
	   return
	end
	   
	local chargesUsed = 0
	local healthValue = 0
	local manaValue = 0
	
	local healthTable = t["Health"]
	if healthTable then
	   healthValue = math.random(healthTable.min, healthTable.max)
	   if player:hasUnityCharm() then
	      healthValue = healthValue + (healthValue * 0.04)
	   end
	   chargesUsed = chargesUsed + healthValue
	end

	local manaTable = t["Mana"]
	if manaTable then
	   manaValue = math.random(manaTable.min, manaTable.max)
	   chargesUsed = chargesUsed + manaValue
	end
	
	if charges < chargesUsed then
	   target:say("Aaaah...", TALKTYPE_MONSTER_SAY)
	   if healthValue > 0 then
	      doTargetCombatHealth(player, target, COMBAT_HEALING, charges, charges)
	   end
	   if manaValue > 0 then
	      doTargetCombatMana(0, target, charges, charges)
	   end
	   player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	   item:setRefil(0)
	   charges = item:getRefil()
	   --player:sendTextMessage(MESSAGE_STATUS_DEFAULT, "You have used refillable potion " .. charges .. " / " .. REFILLABLE_POTION_SYSTEM:getMaxCharges(item) .. " charges left.")
	   player:sendTextMessage(MESSAGE_STATUS_DEFAULT, "You have used potion " .. charges .. " charges left.")
	else
	   target:say("Aaaah...", TALKTYPE_MONSTER_SAY)
	   if healthValue > 0 then
	      doTargetCombatHealth(player, target, COMBAT_HEALING, healthValue, healthValue)
	   end
	   if manaValue > 0 then
	      doTargetCombatMana(0, target, manaValue, manaValue)
	   end
	   player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	   item:setRefil(charges - chargesUsed)
	   charges = item:getRefil()
	   --player:sendTextMessage(MESSAGE_STATUS_DEFAULT, "You have used refillable potion" .. "\n" .. charges .. " / " .. REFILLABLE_POTION_SYSTEM:getMaxCharges(item) .. " charges left.")
	   player:sendTextMessage(MESSAGE_STATUS_DEFAULT, "You have used potion " .. charges .. " charges left.")
	   
    end
end

function REFILLABLE_POTION_SYSTEM:isRefillable(item)
     
	if REFILLABLE_POTION_SYSTEM:getMaxCharges(item) > 0 then
	   return true
	end
	return false
end

function REFILLABLE_POTION_SYSTEM:isVocation(player, t)
    
	local vocation = player:getVocation()
	local name = vocation:getName():lower()
	
	for i, v in pairs(t) do
	    local table_name = v:lower()
	    if string.find(table_name, name) then
		   return true
		end
	end
	return false
end



local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    
	
	
	local smallRefil = RFILLABLE_POTION_CONFIG_SMALL_POTIONS[item:getId()]
	if smallRefil then
	   
	   if not target or not target:isItem() then
	      return true
	   end
	   
	   if not REFILLABLE_POTION_SYSTEM:isRefillable(target) then
	      player:sendCancelMessage("You can only use this potion on refiable potions")
	      return true
       end
	   
	   local charges = target:getRefil()
	   local value = math.random(smallRefil.min, smallRefil.max)
	  
	   local maxCharges = REFILLABLE_POTION_SYSTEM:getMaxCharges(target)
	   if (value + charges) > maxCharges then
		  target:setRefil(maxCharges)
	   else
	      target:setRefil(charges + value)
	   end
	   
	   player:sendTextMessage(MESSAGE_INFO_DESCR, "You have refiled your potion with " .. value .. " charges.")
	   player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	   item:remove(1)
	   return true
	end
	
	
	
	local t = REFILLABLE_POTION_SYSTEM.cache[item:getName()]
	if not t then
	   return true
	end
	
	if not target or not target:isCreature() then
	   return true
	end
	
	local vocTable = t["Vocations"]
	if vocTable then
	   if not REFILLABLE_POTION_SYSTEM:isVocation(player, vocTable) then
	      player:sendCancelMessage("Your vocation can't use this potion.")
		  return true
	   end  
	end
	
	REFILLABLE_POTION_SYSTEM:addValues(player, target, item)
    return true
end

for name, _ in pairs(REFILLABLE_POTION_SYSTEM.cache) do
    local id = dakosLib:getItemIdByName(name)
	action:id(id)
end
for i, _ in pairs(RFILLABLE_POTION_CONFIG_SMALL_POTIONS) do
    action:id(i)
end
action:register()
