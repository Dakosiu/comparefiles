if not ITEM_UPGRADE_SYSTEM then
   ITEM_UPGRADE_SYSTEM = {}
   ITEM_UPGRADE_SYSTEM.players = {}
end

ITEM_UPGRADE_SYSTEM.config = {
                                ["Max Slots"] = 8,
                                ["Sockets"] = {
								                [8306] = { chance = 0.9 },
												[8302] = { chance = 0.9 },
												[8300] = { chance = 0.9 }
										      },
								["Gems"] = {
                                             [30523] = {
											             avaibleBonuses = { 
														                    ["Health"] = { 
																			                ["Flat"] = { min = 50, max = 200 },
																							["Percentage"] = { min = 1, max = 5, chance = 0.5 }
																						 },
														                    ["Speed"] = { 
																							["Percentage"] = { min = 1, max = 5, chance = 0.5 }
																						},																						 
														                    ["Mana"] = { 
																			                ["Flat"] = { min = 50, max = 200 },
																							["Percentage"] = { min = 1, max = 5, chance = 0.5 }
																					   },																				   
														                    ["Life Leech Chance"] = { 
																							            ["Percentage"] = { min = 1, max = 5, chance = 0.5 }
																					                },	
														                    ["Life Leech Amount"] = { 
																							            ["Percentage"] = { min = 1, max = 5, chance = 0.5 }
																					                },	
														                    ["Mana Leech Chance"] = { 
																							            ["Percentage"] = { min = 1, max = 5, chance = 0.5 }
																					                },	
														                    ["Mana Leech Amount"] = { 
																							            ["Percentage"] = { min = 1, max = 5, chance = 0.5 }
																					                },																									
														                    ["Critical Chance"] = { 
																							        ["Percentage"] = { min = 1, max = 5, chance = 0.5 }
																					              },
														                    ["Critical Damage"] = { 
																							        ["Percentage"] = { min = 1, max = 5, chance = 0.5 }
																					              },	
														                    ["Gain Experience"] = { 
																							        ["Percentage"] = { min = 1, max = 5, chance = 0.5 }
																					              },	  
														                    ["Attack Speed"] = { 
																							        ["Percentage"] = { min = 1, max = 5, chance = 0.5 }
																					           },	
														                    ["Trapped Energy"] = { 
																							        ["Percentage"] = { min = 1, max = 5, chance = 0.5 }
																					             },		
														                    ["Summon Damage"] = { 
																							        ["Percentage"] = { min = 1, max = 5, chance = 0.5 }
																					            },
														                    ["Spell Cooldown"] = { 
																							        ["Percentage"] = { min = 1, max = 5, chance = 0.5 }
																					             },																								
														                    ["Damage"] = { 
																							        ["Percentage"] = { min = 1, max = 5, chance = 0.5 }
																					     },																									
														                    ["Melee Fighting"] = { 
																							       ["Flat"] = { min = 1, max = 10 }
																					             },	
														                    ["Magic Level"] = { 
																							       ["Flat"] = { min = 1, max = 10 }
																					          },	
														                    ["Distance Fighting"] = { 
																							            ["Flat"] = { min = 1, max = 10 }
																					                },		
														                    ["Fist Fighting"] = { 
																							            ["Flat"] = { min = 1, max = 20 }
																					            },		
														                    ["Fishing"] = { 
																							            ["Flat"] = { min = 1, max = 10 }
																					      },	
														                    ["Shielding"] = { 
																							            ["Flat"] = { min = 1, max = 5 }
																					       }																								
                                                                          },																					   
											             chance = 0.1,
														 avaibleSlots = { "Head", "Armor", "Legs", "Feet", "Weapon", "Wand", "Ammo", "Shield", "Necklace", "Ring", "Backpack" },
													   },
                                             [30524] = {
											             avaibleBonuses = { 
														                    ["Health"] = { 
																			                ["Flat"] = { min = 50, max = 200 },
																							["Percentage"] = { min = 1, max = 5, chance = 0.5 }
																						 },
														                    ["Speed"] = { 
																							["Percentage"] = { min = 1, max = 5, chance = 0.5 }
																						},																						 
														                    ["Mana"] = { 
																			                ["Flat"] = { min = 50, max = 200 },
																							["Percentage"] = { min = 1, max = 5, chance = 0.5 }
																					   },																				   
														                    ["Life Leech Chance"] = { 
																							            ["Percentage"] = { min = 1, max = 5, chance = 0.5 }
																					                },	
														                    ["Life Leech Amount"] = { 
																							            ["Percentage"] = { min = 1, max = 5, chance = 0.5 }
																					                },	
														                    ["Mana Leech Chance"] = { 
																							            ["Percentage"] = { min = 1, max = 5, chance = 0.5 }
																					                },	
														                    ["Mana Leech Amount"] = { 
																							            ["Percentage"] = { min = 1, max = 5, chance = 0.5 }
																					                },																									
														                    ["Critical Chance"] = { 
																							        ["Percentage"] = { min = 1, max = 5, chance = 0.5 }
																					              },
														                    ["Critical Damage"] = { 
																							        ["Percentage"] = { min = 1, max = 5, chance = 0.5 }
																					              },	
														                    ["Gain Experience"] = { 
																							        ["Percentage"] = { min = 1, max = 5, chance = 0.5 }
																					              },	  
														                    ["Attack Speed"] = { 
																							        ["Percentage"] = { min = 1, max = 5, chance = 0.5 }
																					           },	
														                    ["Trapped Energy"] = { 
																							        ["Percentage"] = { min = 1, max = 5, chance = 0.5 }
																					             },		
														                    ["Summon Damage"] = { 
																							        ["Percentage"] = { min = 1, max = 5, chance = 0.5 }
																					            },
														                    ["Spell Cooldown"] = { 
																							        ["Percentage"] = { min = 1, max = 5, chance = 0.5 }
																					             },																									
														                    ["Damage"] = { 
																							        ["Percentage"] = { min = 1, max = 5, chance = 0.5 }
																					     },																									
														                    ["Melee Fighting"] = { 
																							       ["Flat"] = { min = 1, max = 10 }
																					             },	
														                    ["Magic Level"] = { 
																							       ["Flat"] = { min = 1, max = 10 }
																					          },	
														                    ["Distance Fighting"] = { 
																							            ["Flat"] = { min = 1, max = 10 }
																					                },		
														                    ["Fist Fighting"] = { 
																							            ["Flat"] = { min = 1, max = 20 }
																					            },		
														                    ["Fishing"] = { 
																							            ["Flat"] = { min = 1, max = 10 }
																					      },	
														                    ["Shielding"] = { 
																							            ["Flat"] = { min = 1, max = 5 }
																					       }																								
                                                                          },																					   
											             chance = 0.2,
														 avaibleSlots = { "Head", "Armor", "Legs", "Feet", "Weapon", "Wand", "Ammo", "Shield", "Necklace", "Ring", "Backpack" },
													   },		
                                             [30525] = {
											             avaibleBonuses = { 
														                    ["Health"] = { 
																			                ["Flat"] = { min = 50, max = 200 },
																							["Percentage"] = { min = 1, max = 5, chance = 0.5 }
																						 },
														                    ["Speed"] = { 
																							["Percentage"] = { min = 1, max = 5, chance = 0.5 }
																						},																						 
														                    ["Mana"] = { 
																			                ["Flat"] = { min = 50, max = 200 },
																							["Percentage"] = { min = 1, max = 5, chance = 0.5 }
																					   },																				   
														                    ["Life Leech Chance"] = { 
																							            ["Percentage"] = { min = 1, max = 5, chance = 0.5 }
																					                },	
														                    ["Life Leech Amount"] = { 
																							            ["Percentage"] = { min = 1, max = 5, chance = 0.5 }
																					                },	
														                    ["Mana Leech Chance"] = { 
																							            ["Percentage"] = { min = 1, max = 5, chance = 0.5 }
																					                },	
														                    ["Mana Leech Amount"] = { 
																							            ["Percentage"] = { min = 1, max = 5, chance = 0.5 }
																					                },																									
														                    ["Critical Chance"] = { 
																							        ["Percentage"] = { min = 1, max = 5, chance = 0.5 }
																					              },
														                    ["Critical Damage"] = { 
																							        ["Percentage"] = { min = 1, max = 5, chance = 0.5 }
																					              },	
														                    ["Gain Experience"] = { 
																							        ["Percentage"] = { min = 1, max = 5, chance = 0.5 }
																					              },	  
														                    ["Attack Speed"] = { 
																							        ["Percentage"] = { min = 1, max = 5, chance = 0.5 }
																					           },	
														                    ["Trapped Energy"] = { 
																							        ["Percentage"] = { min = 1, max = 5, chance = 0.5 }
																					             },	
														                    ["Spell Cooldown"] = { 
																							        ["Percentage"] = { min = 1, max = 5, chance = 0.5 }
																					             },																								 
														                    ["Summon Damage"] = { 
																							        ["Percentage"] = { min = 1, max = 5, chance = 0.5 }
																					            },
														                    ["Damage"] = { 
																							        ["Percentage"] = { min = 1, max = 5, chance = 0.5 }
																					     },																								
														                    ["Melee Fighting"] = { 
																							       ["Flat"] = { min = 1, max = 10 }
																					             },	
														                    ["Magic Level"] = { 
																							       ["Flat"] = { min = 1, max = 10 }
																					          },	
														                    ["Distance Fighting"] = { 
																							            ["Flat"] = { min = 1, max = 10 }
																					                },		
														                    ["Fist Fighting"] = { 
																							            ["Flat"] = { min = 1, max = 20 }
																					            },		
														                    ["Fishing"] = { 
																							            ["Flat"] = { min = 1, max = 10 }
																					      },	
														                    ["Shielding"] = { 
																							            ["Flat"] = { min = 1, max = 5 }
																					       }																					  
                                                                          },																					   
											             chance = 0.4,
														 avaibleSlots = { "Head", "Armor", "Legs", "Feet", "Weapon", "Wand", "Ammo", "Shield", "Necklace", "Ring", "Backpack" },
													   },
                                             [32843] = {
											             avaibleBonuses = { 	
														                    ["Spell Cooldown"] = { 
																							        ["Percentage"] = { min = 90, max = 100, chance = 0.5 }
																					              },																							  
                                                                          },																					   
											             chance = 0.9,
														 avaibleSlots = { "Head", "Armor", "Legs", "Feet", "Weapon", "Wand", "Ammo", "Shield", "Necklace", "Ring", "Backpack" },
													   },														   
										   },
								["Events"] = {
								                sockets = { 
												            onSuccess = { effect = 312, type = MESSAGE_STATUS_SMALL, text = "You Have Sucescesfully Added Socket To Item" },
															onFailed = { effect = 384, type = MESSAGE_STATUS_WARNING, text = "You Have Failed Adding Socket To Item." },
															onMaxSlot = { effect = 310, type = MESSAGE_INFO_DESCR, text = "This Item Already Have Max Slots." },
															onNoAvaibleSlot = { type = MESSAGE_INFO_DESCR, text = "This item have no empty socket to add bonus." }
														  },
												gems =    {
                                                            onSuccess = { effect = CONST_ME_MAGIC_GREEN, type = MESSAGE_STATUS_SMALL, text = "You have sucescesfully added bonus to item" },
                                                            onFailed = { effect = CONST_ME_POFF,type = MESSAGE_STATUS_WARNING, text = "You have failed adding bonus to item." }
                                                          }
											 }
							}
							
ITEM_UPGRADE_SYSTEM.modalId = 1056614
ITEM_UPGRADE_SYSTEM.bonusRemover = 39384
ITEM_UPGRADE_SYSTEM.bonusHolder = 32659
ITEM_UPGRADE_SYSTEM.extractor = 32662						

ITEM_UPGRADE_SYSTEM.attributes = {
                                    socket = "ITEM_UPGRADE_SYSTEM_SOCKET",
									socketCount = "ITEM_UPGRADE_SYSTEM_SOCKET_COUNT",
									bonusName = "ITEM_UPGRADE_SYSTEM_BONUS_NAME",
									
									holdValue = "ITEM_UPGRADE_SYSTEM_BONUS_HOLD_VALUE",
									holdName = "ITEM_UPGRADE_SYSTEM_BONUS_HOLD_NAME",
									holdPercentage = "ITEM_UPGRADE_SYSTEM_BONUS_HOLD_PERCENTAGE",
							     }
								 
								 
								 
ITEM_UPGRADE_SYSTEM.keys = {
                                ["Health"] = {
                                                flat = "ITEM_UPGRADE_SYSTEM_HEALTH_FLAT",
                                                percentage = "ITEM_UPGRADE_SYSTEM_HEALTH_PERCENTAGE",
												condition = { CONDITION_PARAM_STAT_MAXHITPOINTSPERCENT, CONDITION_PARAM_STAT_MAXHITPOINTS }, 
											    prefix = "Health"
                                             },	
                                ["Mana"] = {
                                                flat = "ITEM_UPGRADE_SYSTEM_MANA_FLAT",
                                                percentage = "ITEM_UPGRADE_SYSTEM_MANA_PERCENTAGE",
												condition = { CONDITION_PARAM_STAT_MAXMANAPOINTSPERCENT, CONDITION_PARAM_STAT_MAXMANAPOINTS }, 
											    prefix = "Mana"
                                           },	
                                ["Speed"] = {
								                flat = "ITEM_UPGRADE_SYSTEM_SPEED_FLAT",
                                                percentage = "ITEM_UPGRADE_SYSTEM_SPEED_PERCENTAGE",
                                                condition = { CONDITION_PARAM_SPEED }, 												
                                                prefix = "Speed",
                                            },	
                                ["Melee Fighting"] = {
								                        flat = "ITEM_UPGRADE_SYSTEM_MELEE_FLAT",
                                                        percentage = "ITEM_UPGRADE_SYSTEM_MELEE_PERCENTAGE",
                                                        condition = { CONDITION_PARAM_SKILL_MELEEPERCENT, CONDITION_PARAM_SKILL_MELEE  }, 												
                                                        prefix = "Melee Fighting",
                                                     },	
                                ["Distance Fighting"] = {
								                            flat = "ITEM_UPGRADE_SYSTEM_DISTANCE_FLAT",
                                                            percentage = "ITEM_UPGRADE_SYSTEM_DISTANCE_PERCENTAGE",
                                                            condition = { CONDITION_PARAM_SKILL_DISTANCEPERCENT, CONDITION_PARAM_SKILL_DISTANCE  }, 												
                                                            prefix = "Distance Fighting",
                                                        },
                                ["Fist Fighting"] = {
								                            flat = "ITEM_UPGRADE_SYSTEM_FIST_FLAT",
                                                            percentage = "ITEM_UPGRADE_SYSTEM_FIST_PERCENTAGE",
                                                            condition = { CONDITION_PARAM_SKILL_FISTPERCENT, CONDITION_PARAM_SKILL_FIST  }, 												
                                                            prefix = "Fist Fighting",
                                                    },
														
                                ["Shielding"] = {
								                    flat = "ITEM_UPGRADE_SYSTEM_SHIELD_FLAT",
                                                    percentage = "ITEM_UPGRADE_SYSTEM_SHIELD_PERCENTAGE",
                                                    condition = { CONDITION_PARAM_SKILL_SHIELDPERCENT, CONDITION_PARAM_SKILL_SHIELD  }, 												
                                                    prefix = "Shielding",
                                                },		
                                ["Fishing"] = {
								                    flat = "ITEM_UPGRADE_SYSTEM_FISHING_FLAT",
                                                    percentage = "ITEM_UPGRADE_SYSTEM_FISHING_PERCENTAGE",
                                                    condition = { CONDITION_PARAM_SKILL_FISHINGPERCENT, CONDITION_PARAM_SKILL_FISHING  }, 												
                                                    prefix = "Fishing",
                                              },
                                ["Magic Level"] = {
								                    flat = "ITEM_UPGRADE_SYSTEM_MAGIC_FLAT",
                                                    percentage = "ITEM_UPGRADE_SYSTEM_MAGIC_PERCENTAGE",
                                                    condition = { CONDITION_PARAM_STAT_MAGICPOINTSPERCENT, CONDITION_PARAM_STAT_MAGICPOINTS  }, 												
                                                    prefix = "Magic Level",
                                                  },											  
								["Life Leech Chance"] = {
								                          percentage = "ITEM_UPGRADE_SYSTEM_LIFELEECHCHANCE_PERCENTAGE",
														  condition = { CONDITION_PARAM_SPECIALSKILL_LIFELEECHCHANCE },
														  prefix = "Life Leech Chance"
														},
								["Life Leech Amount"] = {
								                          percentage = "ITEM_UPGRADE_SYSTEM_LIFELEECHAMOUNT_PERCENTAGE",
														  condition = { CONDITION_PARAM_SPECIALSKILL_LIFELEECHAMOUNT },
														  prefix = "Life Leech Amount"
														},		
								["Mana Leech Chance"] = {
								                          percentage = "ITEM_UPGRADE_SYSTEM_MANALEECHCHANCE_PERCENTAGE",
														  condition = { CONDITION_PARAM_SPECIALSKILL_MANALEECHCHANCE },
														  prefix = "Mana Leech Chance"
														},
								["Mana Leech Amount"] = {
								                          percentage = "ITEM_UPGRADE_SYSTEM_MANALEECHAMOUNT_PERCENTAGE",
														  condition = { CONDITION_PARAM_SPECIALSKILL_MANALEECHAMOUNT },
														  prefix = "Mana Leech Amount"
														},	
								["Critical Chance"] = {
								                          percentage = "ITEM_UPGRADE_SYSTEM_CRITICALCHANCE_PERCENTAGE",
														  condition = { CONDITION_PARAM_SPECIALSKILL_CRITICALHITCHANCE },
														  prefix = "Critical Chance"
													  },			
								["Critical Damage"] = {
								                          percentage = "ITEM_UPGRADE_SYSTEM_CRITICALDAMAGE_PERCENTAGE",
														  condition = { CONDITION_PARAM_SPECIALSKILL_CRITICALHITAMOUNT },
														  prefix = "Critical Damage"
													  },
                                ["Dodge"] = {
                                                percentage = "ITEM_UPGRADE_SYSTEM_DODGE_PERCENTAGE",	
                                                prefix = "Dodge",
												abilityName = ABILITIES_DODGE
                                            },
                                ["Reflect"] = {
                                                percentage = "ITEM_UPGRADE_SYSTEM_REFLECT_PERCENTAGE",	
                                                prefix = "Reflect",
												abilityName = ABILITIES_REFLECT
                                              },	
                                ["Healing"] = {
                                                percentage = "ITEM_UPGRADE_SYSTEM_HEALING_PERCENTAGE",	
                                                prefix = "Healing",
												abilityName = ABILITIES_HEALING
                                              },
                                ["Protection All"] = {
                                                        percentage = "ITEM_UPGRADE_SYSTEM_PROTECTIONALL_PERCENTAGE",	
                                                        prefix = "Protection All",
												        abilityName = ABILITIES_PROTECTIONALL
                                                     },
                                ["Gain Experience"] = {
                                                        percentage = "ITEM_UPGRADE_SYSTEM_GAINEXPERIENCE_PERCENTAGE",	
                                                        prefix = "Experience",
												        abilityName = ABILITIES_GAINEXPERIENCE
                                                     },		
                                ["Summon Damage"] = {
                                                        percentage = "ITEM_UPGRADE_SYSTEM_SUMMONDAMAGE_PERCENTAGE",	
                                                        prefix = "Summon Damage",
												        abilityName = ABILITIES_SUMMONDAMAGE
                                                    },	
                                ["Damage"] = {
                                                        percentage = "ITEM_UPGRADE_SYSTEM_DAMAGE_PERCENTAGE",	
                                                        prefix = "Bonus Damage",
												        abilityName = ABILITIES_DAMAGE
                                             },													
                                ["Attack Speed"] = {
                                                        percentage = "ITEM_UPGRADE_SYSTEM_ATTACKSPEED_PERCENTAGE",	
                                                        prefix = "Attack Speed",
												        abilityName = ABILITIES_ATTACKSPEED
                                                   },			
                                ["Trapped Energy"] = {
                                                        percentage = "ITEM_UPGRADE_SYSTEM_TRAPPEDENERGY_PERCENTAGE",	
                                                        prefix = "Trapped Energy",
												        abilityName = ABILITIES_TRAPPEDENERGY
                                                     },			
                                ["Spell Cooldown"] = {
                                                        percentage = "ITEM_UPGRADE_SYSTEM_SPELLCOOLDOWN_PERCENTAGE",	
                                                        prefix = "Spell Cooldown",
												        abilityName = ABILITIES_SPELLCOOLDOWN
                                                     },														 
						   }	 
								 
ITEM_UPGRADE_SYSTEM.SubID = {
                              ["Head"] = 500,
							  ["Armor"] = 501,
							  ["Legs"] = 502,
							  ["Feet"] = 503,
							  ["Ring"] = 504,
							  ["Necklace"] = 505,
							  ["Backpack"] = 506,
							  ["Weapon"] = 507,
							  ["Shield"] = 508,
							  ["Ammo"] = 509,
							  ["Wand"] = 510,
							}
								
local SOCKET_FREE = 1
local SOCKET_USED = 2
								 
function ITEM_UPGRADE_SYSTEM:updateSocketCount(item, method)
	local key = self.attributes.socketCount
	local value = item:getCustomAttribute(key)
	if not value or value < 0 then
	   value = 0
	end
	
	if method == "add" then
	   item:setCustomAttribute(key, value + 1)
	   return true
	end
	
	if method == "remove" then
	    if value == 0 then
	      return true
	    end
	    item:setCustomAttribute(key, value - 1)
	end
end

function ITEM_UPGRADE_SYSTEM:getSocketCount(item)
    local key = self.attributes.socketCount
	local value = item:getCustomAttribute(key)
	if not value or value < 0 then
	   value = 0
	end
	return value
end
	
function ITEM_UPGRADE_SYSTEM:updateSocket(item, method)
    local count = self:getSocketCount(item)
	local key = self.attributes.socket .. count + 1
	if method == "free" then
	   item:setCustomAttribute(key, SOCKET_FREE)
	   self:updateSocketCount(item, "add")
	else 
	   key = self.attributes.socket .. self:getAvaibleSlot(item)
	   item:setCustomAttribute(key, SOCKET_USED)
	end
	return true
end

function ITEM_UPGRADE_SYSTEM:getSocket(item, index)
    local key = self.attributes.socket .. index
	local value = item:getCustomAttribute(key)
	if value then
	   return value
	end
	return false
end

function ITEM_UPGRADE_SYSTEM:removeBonus(item, index)
    local key = self.attributes.socket .. index
	item:setCustomAttribute(key, SOCKET_FREE)
end
	
local function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function ITEM_UPGRADE_SYSTEM:getHolderValues(item)
    local values = {}
	
    local value = item:getCustomAttribute(self.attributes.holdValue)
	if value then
	   values.value = value
	end
	local type = item:getCustomAttribute(self.attributes.holdName)
	if type then
	   values.name = type
	end
	local percentage = item:getCustomAttribute(self.attributes.holdPercentage)
	if percentage then
	   values.percentage = percentage
	end
	
	if tablelength(values) == 0 then
	   return false
	end
		
	return values
end
	
function ITEM_UPGRADE_SYSTEM:getDescription(item)
	
	if item:getId() == self.bonusHolder then
	    local values = self:getHolderValues(item) 
	    if not values then
		   return "This holder is empty."
		end
		
		local value = values.value
		local type = values.name
		local percentage = values.percentage
		
		local str = "It Contains: " .. "[" .. type .. " +" .. value
		if percentage then
		   str = str .. "%"
		end
		str = str .. "]"
		str = str .. " Bonus."
		return str
    end

	if item:getId() == self.extractor then
	    local values = self:getHolderValues(item) 
	    if not values then
		   return "This holder is empty."
		end
		
		local value = values.value
		local type = values.name
		local percentage = values.percentage
		
		local str = "It Contains: " .. "[" .. type .. " +" .. value
		if percentage then
		   str = str .. "%"
		end
		str = str .. "]"
		str = str .. " Bonus."
		return str
    end    	
	   
	   
	   
	   
	
	
	
	
	local count = self:getSocketCount(item)
	if count == 0 then
	   return false
	end
	
	local str = ""
	for i = 1, count do
	    local socketValue = self:getSocket(item, i)
	    if socketValue == 1 then
		    --str = str .. "[]"
			str = str .. "[Empty Socket]"
			if count > 1 and i ~= count then
				str = str .. "\n"
			end
		elseif socketValue == 2 then
			local bonus = self:getBonus(item, i)
			if bonus then
			    local value = bonus.value
			    local prefix = bonus.prefix
			    local percentage = bonus.percentage
				str = str .. "[" .. prefix .. " +" .. value
				if percentage then
				   str = str .. "%"
				end
				str = str .. "]"
				if count > 1 and i ~= count then
				   str = str .. "\n"
				end
			    -- str = str .. "["
				-- str = str .. value
			    -- if percentage then
			       -- str = str .. "%"
				-- end				
				-- str = str .. " "
			    -- str = str .. prefix 
				-- str = str .. "]"
			end
	    end
	end
	return str
end

function ITEM_UPGRADE_SYSTEM:hasMaxSockets(item)
	if self:getSocketCount(item) == self.config["Max Slots"] then
	   return true
	end
	return false
end

function ITEM_UPGRADE_SYSTEM:rollChance(value)
	if value < 1 then
	   value = value * 100
	end
	
	local number = math.random(1, 100)
	if number <= value then
	   return true
	end
	return false
end

function ITEM_UPGRADE_SYSTEM:rollBonus(t, id)

    if not self.bonusList then
	   self.bonusList = {}
	end
	
	local avaibleBonusTable = t.avaibleBonuses
	-- wroc tu pozniej
	--if not self.bonusList[id] then
	    self.bonusList[id] = {}
	    for bonusName, v in pairs(avaibleBonusTable) do
		    table.insert(self.bonusList[id], bonusName)
		end
	--end
		
    local values = {}

	local bonusType = self.bonusList[id][math.random(1, #self.bonusList[id])]
	local bonusTable = avaibleBonusTable[bonusType]
	local percentageTable = bonusTable["Percentage"]
	local flatTable = bonusTable["Flat"]
	local finalTable = nil
	
	if not finalTable then
        if not flatTable then	
	       finalTable = percentageTable
		   values.percentage = true
		end
	end
	
	if not finalTable then
	    if not percentageTable then
		   finalTable = flatTable
		end
	end
	
	if not finalTable then
	   	local chance = percentageTable.chance
		if not chance then
		   chance = 50
		end
		if chance < 1 then
		   chance = chance * 100
		end
		
		local rand = math.random(1, 100)
		if rand <= chance then
		   finalTable = bonusTable["Percentage"]
	       values.percentage = true
		else
		   finalTable = bonusTable["Flat"]
		end
	end
	
	local minValue = finalTable.min
	local maxValue = finalTable.max
	local value = math.random(minValue, maxValue)
	values.value = value
	values.bonusType = bonusType
	return values
end

function ITEM_UPGRADE_SYSTEM:getAvaibleSlot(item)
    local count = self:getSocketCount(item)
	if count == 0 then
	   return false
	end
	for i = 1, count do
	    if self:getSocket(item, i) == 1 then
		   return i
		end
    end
	return false
end

function ITEM_UPGRADE_SYSTEM:hasBonuses(item)
    local count = self:getSocketCount(item)
	if count == 0 then
	   return false
	end
    
    for i = 1, count do
        if self:getSocket(item, i) == 2 then	
	        return true
		end
	end
	return false
end

function ITEM_UPGRADE_SYSTEM:holdBonus(item, index, craftItem, removeBonus)
    local count = self:getSocketCount(item)
	if count == 0 then
	   return false
	end
	
	local bonus = self:getBonus(item, index)
	if not bonus then
	    return false
	end
	
	local type = bonus.type
	local value = bonus.value
	local percentage = bonus.percentage		
	craftItem:setCustomAttribute(self.attributes.holdValue, value)
	craftItem:setCustomAttribute(self.attributes.holdName, type)
	craftItem:setCustomAttribute(self.attributes.holdPercentage, percentage)
end

function ITEM_UPGRADE_SYSTEM:addBonus(item, type, method, value)
	local avaibleSlot = self:getAvaibleSlot(item)
	item:setCustomAttribute(self.attributes.bonusName .. avaibleSlot, type)
	local t = self.keys[type]
	
	if method == "flat" then
	    if t.flat then
		   item:setCustomAttribute(t.flat .. avaibleSlot, value)
		end
	elseif method == "percentage" then
	    if t.percentage then
	       item:setCustomAttribute(t.percentage .. avaibleSlot, value)
		end
	end
	
	self:updateSocket(item, "bonus")
end

function ITEM_UPGRADE_SYSTEM:getBonus(item, index)
	local keyType = self.attributes.bonusName .. index
	if not keyType then
	    return false
	end
	local bonusType = item:getCustomAttribute(keyType)
	if not bonusType then
	    return false
    end
				
	local t = self.keys[bonusType]
	if t.flat then
	    local key = t.flat .. index
	    local value = item:getCustomAttribute(key)
	    local values = { }
	    if value then
	        values.value = value
	        values.type = bonusType
	        values.prefix = t.prefix
			return values
	    end
	end
	
	if t.percentage then
	    key = t.percentage .. index
	    value = item:getCustomAttribute(key)
	    if value then
		    local values = { }
	   	    values.value = value
	        values.type = bonusType
		    values.prefix = t.prefix
		    values.percentage = true
	        return values
		end
	end
	return false
end

function ITEM_UPGRADE_SYSTEM:getEquipmentSlot(item)
    local id = item:getId()
	local it = ItemType(id)
	
	if it:isStackable() then
	    return false
    end
	
	local weaponType = it:getWeaponType()
	if weaponType == WEAPON_SHIELD then
	   return "Shield"
	elseif weaponType == WEAPON_AMMO then
	   return "Ammo"
	elseif weaponType == WEAPON_WAND then
	   return "Wand"
	elseif weaponType ~= 0 then
	   return "Weapon"
	end

	local name = it:getSlotName()
	return name
end

function ITEM_UPGRADE_SYSTEM:isCorrectSlot(item, t)
	local slotName = self:getEquipmentSlot(item)
	if not slotName then
	    return false
    end
	
	local slotTable = t.avaibleSlots
	if isInArray(slotTable, slotName) then
	   return true
	end
	return false
end
	
function ITEM_UPGRADE_SYSTEM:updateBonuses(player, item, delete)
	local count = self:getSocketCount(item)
	if count == 0 then
	   return false
	end
	local begin = true
	local slotString = ITEM_UPGRADE_SYSTEM:getEquipmentSlot(item)
	local subid = self.SubID[slotString]
	local abilities = {}
	local stats = {}
	
    for i = 1, count do
	    local socketValue = self:getSocket(item, i)
	    if socketValue == 2 then
		    local bonus = self:getBonus(item, i)
			if bonus then
			    local type = bonus.type
			    local value = bonus.value
			    local percentage = bonus.percentage
				local t = self.keys[type]
				local abilityTable = t.abilityName
				local conditionTable = t.condition
				if subid then
					if conditionTable then
					    local conditionName = nil
						if percentage then
						   conditionName = conditionTable[1]
						else
						   conditionName = conditionTable[2]
						end
						
						
						if conditionName == CONDITION_PARAM_STAT_MAXHITPOINTSPERCENT then
						    conditionName = conditionTable[2]
							value = math.floor(player:getMaxHealth() * (value / 100))
						elseif conditionName == CONDITION_PARAM_STAT_MAXMANAPOINTSPERCENT then
						    conditionName = conditionTable[2]
						    value = math.floor(player:getMaxMana() * (value / 100))
					    end
						
					    if not stats[conditionName] then
						   stats[conditionName] = 0
						end
						stats[conditionName] = stats[conditionName] + value
				    else
					    local abilityName = self.keys[type].abilityName
						if not abilities[abilityName] then
							abilities[abilityName] = 0
						end
						abilities[abilityName] = abilities[abilityName] + value
					end
				end
			end
		end
	end

	for i, v in pairs(abilities) do
	    if delete then
		   player:removeAbility(i, v)
		else
	       player:addAbility(i, v)
		end
	end
	
	if delete then
	   player:removeCondition(CONDITION_ATTRIBUTES, CONDITIONID_DEFAULT, subid)
	   player:removeCondition(CONDITION_HASTE, CONDITIONID_DEFAULT, subid)
	   return true
	end
		
	local condition = nil
	local conditionHaste = nil
	for i, v in pairs(stats) do
	    if i == CONDITION_PARAM_SPEED then
	        if not conditionHaste then   
			   conditionHaste = Condition(CONDITION_HASTE, CONDITIONID_DEFAULT)
			   conditionHaste:setParameter(CONDITION_PARAM_SUBID, subid)
			   conditionHaste:setParameter(CONDITION_PARAM_ICON, -1)
               conditionHaste:setParameter(CONDITION_HASTE_SHOWICON, false)
			   conditionHaste:setTicks(-1)
			end
			local value = v / 100
			conditionHaste:setFormula(value, 0, value, 0)
		else
	        if not condition then
		        condition = Condition(CONDITION_ATTRIBUTES, CONDITIONID_DEFAULT)
	   	        condition:setParameter(CONDITION_PARAM_SUBID, subid)
	   	        condition:setTicks(-1)
		    end
		    condition:setParameter(i, v)
		end
	end
	
	if condition then
	   player:addCondition(condition)
    end
	
	if conditionHaste then
	   player:addCondition(conditionHaste)
	end
    
	
	return true
end

function ITEM_UPGRADE_SYSTEM:isEquiped(position)
	if not position then
	    return false
    end
	
	local x = position.x
	local y = position.y
	local z = position.z
	
	if z == 0 and x == 65535 and y <= 10 then
	   return true
	end
	return false
end

function ITEM_UPGRADE_SYSTEM:onLogin(player)
	for i = CONST_SLOT_FIRST, CONST_SLOT_LAST do
	    local item = player:getSlotItem(i)
		if item then
		   ITEM_UPGRADE_SYSTEM:updateBonuses(player, item)
		end
	end
	return true
end

function ITEM_UPGRADE_SYSTEM:displayModal(player, item, craftItem, method, position)
    
	player:registerEvent("ModalWindow_ITEM_UPGRADE_SYSTEM")
    local title = "Item Abilities - "
	if method == "remover" then
	   title = title .. "Remover"
	else
	   title = title .. "Holder"
	end
	
	local message = "List of avaible abilities "
	
	if method == "remover" then
	   message = message .. "to remove."
	else
	   message = message .. "to hold."
	end
	
	local modalId = self.modalId
	if method == "holder" then
	   modalId = modalId + 1
	end
	
	
	
	local window = ModalWindow(modalId, title, message)
    window:addButton(100, "Select") 
    window:addButton(101, "Cancel")     
    window:setDefaultEnterButton(100)
    window:setDefaultEscapeButton(101)
	
	local count = self:getSocketCount(item)
	if count == 0 then
	   return false
	end
	
	local index = 0
	for i = 1, count do
	    local socketValue = self:getSocket(item, i)
		if socketValue == 2 then
		    index = index + 1
		    local str = ""
			local bonus = self:getBonus(item, i)
			if bonus then
			    local value = bonus.value
			    local prefix = bonus.prefix
			    local percentage = bonus.percentage
				str = str .. prefix .. " +" .. value
				if percentage then
				   str = str .. "%"
				end
			    window:addChoice(index, str)
				if not self.players[player:getId()] then
				   self.players[player:getId()] = {}
				end
				if not self.players[player:getId()][method] then
				   self.players[player:getId()][method] = {}
				end
				self.players[player:getId()][method][index] = i
			end
	    end
	end
	
	if index > 0 then
	    self.players[player:getId()][method].itemId = item:getId()
		self.players[player:getId()][method].craftId = craftItem:getId()
		self.players[player:getId()][method].position = position
	    item:setCraftable(true)
		craftItem:setCraftable(true)
	    window:sendToPlayer(player)
	end
end

local creaturescript = CreatureEvent("ModalWindow_ITEM_UPGRADE_SYSTEM")
function creaturescript.onModalWindow(player, modalWindowId, buttonId, choiceId) 
    local method = nil
	if modalWindowId == ITEM_UPGRADE_SYSTEM.modalId then
	   method = "remover"
	elseif modalWindowId == ITEM_UPGRADE_SYSTEM.modalId + 1 then
	   method = "holder"
	end
	
	if not method then
	    return
    end
	
	local playerTable = ITEM_UPGRADE_SYSTEM.players[player:getId()][method]
	if not playerTable then
	   return
	end
	
	if buttonId == 101 then
	   ITEM_UPGRADE_SYSTEM.players[player:getId()][method] = nil
	   return
	end
	
	local itemId = playerTable.itemId
	local item = player:getItemById(itemId, true, -1, true)
	if not item then
	    ITEM_UPGRADE_SYSTEM.players[player:getId()][method] = nil
	    return
	end
	
	local craftId = playerTable.craftId
	local crafter = player:getItemById(craftId, true, -1, true)
	if not crafter then
	    ITEM_UPGRADE_SYSTEM.players[player:getId()][method] = nil
		return
	end
	
	local index = playerTable[choiceId]
	local pos = playerTable.position
	ITEM_UPGRADE_SYSTEM:removeBonus(item, index)
	if method == "remover" then
	    player:sendTextMessage(MESSAGE_INFO_DESCR, "You have successfully removed bonus from item.")
		crafter:setCraftable(false)
		player:removeItem(craftId, 1)
		player:getPosition():sendMagicEffect(312)
		ITEM_UPGRADE_SYSTEM.players[player:getId()][method] = nil
	elseif method == "holder" then
	    ITEM_UPGRADE_SYSTEM:holdBonus(item, index, crafter, true)
		crafter:setCraftable(false)
		crafter:transform(ITEM_UPGRADE_SYSTEM.extractor)
	end
	
	if ITEM_UPGRADE_SYSTEM:isEquiped(position) then
		ITEM_UPGRADE_SYSTEM:updateBonuses(player, item)
	end
		
		
		
	return true
end
creaturescript:register()

local action = Action()
function action.onUse(player, item, fromPosition, itemEx, toPosition, isHotkey)
    local target = itemEx
	if not target or not target:isItem() then
	   return false
	end
	
	
	
	
	local pos = player:getPosition()
	
	
	if item:getId() == ITEM_UPGRADE_SYSTEM.bonusRemover then
		if not player:canUseFromGround(target) or not player:canUseFromGround(item) then
		    player:sendTextMessage(MESSAGE_STATUS_WARNING, "this item cannot be used from ground.")
            pos:sendMagicEffect(CONST_ME_POFF)
			return true
		end
		
		if not ITEM_UPGRADE_SYSTEM:hasBonuses(target) then
		    player:sendTextMessage(MESSAGE_STATUS_WARNING, "this item have no bonuses to remove.")
			pos:sendMagicEffect(5)
			return true
	    end
		
		ITEM_UPGRADE_SYSTEM:displayModal(player, target, item, "remover", toPosition)
	    return true
	end
	
	if item:getId() == ITEM_UPGRADE_SYSTEM.bonusHolder or item:getId() == ITEM_UPGRADE_SYSTEM.extractor then 
		if not player:canUseFromGround(target) or not player:canUseFromGround(item) then
		    player:sendTextMessage(MESSAGE_STATUS_WARNING, "this item cannot be used from ground.")
            pos:sendMagicEffect(CONST_ME_POOF)
			return true
		end
		
		local values = ITEM_UPGRADE_SYSTEM:getHolderValues(item)
		
		if not values then
		   	if not ITEM_UPGRADE_SYSTEM:hasBonuses(target) then
		        player:sendTextMessage(MESSAGE_STATUS_WARNING, "this item have no bonuses to hold.")
				pos:sendMagicEffect(CONST_ME_POOF)
			    return true
	        end
		    ITEM_UPGRADE_SYSTEM:displayModal(player, target, item, "holder", toPosition)
		else
		
		local eventsTable = ITEM_UPGRADE_SYSTEM.config["Events"].sockets
	    if not ITEM_UPGRADE_SYSTEM:getAvaibleSlot(target) then
	        if eventsTable then
			    local noSlotTable = eventsTable.onNoAvaibleSlot
			    if noSlotTable then
			        local effect = noSlotTable.effect 
				    if effect then
				       pos:sendMagicEffect(effect)
					end
					local text = noSlotTable.text
					local messageType = noSlotTable.type
					if text and messageType then
					   player:sendTextMessage(messageType, text)
					end
				end
			end
			return true
		end
		
		    local name = values.name
		    local value = values.value
		    local percentage = values.percentage
		    local method = "flat"
		    if percentage then
		      method = "percentage"
		    end
		    ITEM_UPGRADE_SYSTEM:addBonus(target, name, method, value)
			if ITEM_UPGRADE_SYSTEM:isEquiped(toPosition) then
		        ITEM_UPGRADE_SYSTEM:updateBonuses(player, target)
		    end
			player:sendTextMessage(MESSAGE_INFO_DESCR, "You have sucessfully transfered bonus.")
			pos:sendMagicEffect(312)
			item:remove(1)
		end
	    return true
    end		
	
	
	
	
	
	
	local gemTable = ITEM_UPGRADE_SYSTEM.config["Gems"][item:getId()]
	if gemTable then
	
	    if not ITEM_UPGRADE_SYSTEM:isCorrectSlot(target, gemTable) then
		    player:sendTextMessage(MESSAGE_STATUS_WARNING, "You can't upgrade this item with this gem.")
			return true
		end
		
	    local eventsTable = ITEM_UPGRADE_SYSTEM.config["Events"].sockets
	    if not ITEM_UPGRADE_SYSTEM:getAvaibleSlot(target) then
	        if eventsTable then
			    local noSlotTable = eventsTable.onNoAvaibleSlot
			    if noSlotTable then
			        local effect = noSlotTable.effect 
				    if effect then
				       pos:sendMagicEffect(effect)
					end
					local text = noSlotTable.text
					local messageType = noSlotTable.type
					if text and messageType then
					   player:sendTextMessage(messageType, text)
					end
				end
			end
			return true
		end
		
		local value = gemTable.chance
		eventsTable = ITEM_UPGRADE_SYSTEM.config["Events"].gems
	    if not ITEM_UPGRADE_SYSTEM:rollChance(value) then
		    if eventsTable then
		      	local failedTable = eventsTable.onFailed
		        if failedTable then
			        local effect = failedTable.effect
				    if effect then
				        pos:sendMagicEffect(effect)
					    local messageType = failedTable.type
					    local text = failedTable.text
					    if messageType and text then
					        player:sendTextMessage(messageType, text)
					    end
					end
				end
			end
            item:remove(1)
            return true
        end
		
		local bonus = ITEM_UPGRADE_SYSTEM:rollBonus(gemTable, item:getId())
		local bonusType = bonus.bonusType
		local value = bonus.value
		local percentage = bonus.percentage
		local method = "flat"
		
		if percentage then
		    method = "percentage"
	    end
		
		local avaibleSlot = ITEM_UPGRADE_SYSTEM:getAvaibleSlot(target)
		ITEM_UPGRADE_SYSTEM:addBonus(target, bonusType, method, value)
		if ITEM_UPGRADE_SYSTEM:isEquiped(toPosition) then
		   ITEM_UPGRADE_SYSTEM:updateBonuses(player, target)
		end
		   
		--ITEM_UPGRADE_SYSTEM:updateBonus(player, target, avaibleSlot)
		
		local successTable = eventsTable.onSuccess
		if successTable then
			local effect = successTable.effect
			if effect then
				pos:sendMagicEffect(effect)
				local messageType = successTable.type
				local text = successTable.text
				if messageType and text then
					player:sendTextMessage(messageType, text)
				end
			end
		end
		item:remove(1)
	    return true
	end
	
	
	
	
	
	local socketTable = ITEM_UPGRADE_SYSTEM.config["Sockets"][item:getId()]
	if socketTable then
	    local eventsTable = ITEM_UPGRADE_SYSTEM.config["Events"].sockets
	    if ITEM_UPGRADE_SYSTEM:hasMaxSockets(target) then
		   if eventsTable then
		      	local maxTable = eventsTable.onMaxSlot
		        if maxTable then
			        local effect = maxTable.effect
				    if effect then
				        pos:sendMagicEffect(effect)
					    local messageType = maxTable.type
					    local text = maxTable.text
					    if messageType and text then
					        player:sendTextMessage(messageType, text)
					    end
					end
				end
			end
		    return true
		end
	
	    local value = socketTable.chance
	    if not ITEM_UPGRADE_SYSTEM:rollChance(value) then
		    if eventsTable then
		      	local failedTable = eventsTable.onFailed
		        if failedTable then
			        local effect = failedTable.effect
				    if effect then
				        pos:sendMagicEffect(effect)
					    local messageType = failedTable.type
					    local text = failedTable.text
					    if messageType and text then
					        player:sendTextMessage(messageType, text)
					    end
					end
				end
			end
            item:remove(1)
            return true
        end		

		local successTable = eventsTable.onSuccess
		if successTable then
			local effect = successTable.effect
			if effect then
				pos:sendMagicEffect(effect)
				local messageType = successTable.type
				local text = successTable.text
				if messageType and text then
					player:sendTextMessage(messageType, text)
				end
			end
		end
		ITEM_UPGRADE_SYSTEM:updateSocket(target, "free") 
		item:remove(1)
	    return true
	end
	
	
	
    return true
end

for i, v in pairs(ITEM_UPGRADE_SYSTEM.config["Sockets"]) do
    action:id(i)
end
for i, v in pairs(ITEM_UPGRADE_SYSTEM.config["Gems"]) do
    action:id(i)
end
action:id(ITEM_UPGRADE_SYSTEM.bonusRemover)
action:id(ITEM_UPGRADE_SYSTEM.bonusHolder)
action:id(ITEM_UPGRADE_SYSTEM.extractor)
action:register()

local creatureevent = CreatureEvent("ITEM_UPGRADE_SYSTEM_onLogin")
function creatureevent.onLogin(player)
    ITEM_UPGRADE_SYSTEM:onLogin(player)
	return true
end
creatureevent:register()
	