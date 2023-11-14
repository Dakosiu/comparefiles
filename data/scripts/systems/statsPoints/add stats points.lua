if not ADD_STATS_POINT_SYSTEM then
   ADD_STATS_POINT_SYSTEM = {} 
end

ADD_STATS_POINT_SYSTEM.config = {
                                    [1] = {
						                    itemID = 2494,
											usages = 5,
									        rewards = { 
									                    { type = "stats", name = "health", value = 10 },
												        { type = "stats", name = "mana", value = 15 },
											          }

								          }
						        }
						 
ADD_STATS_POINT_SYSTEM.storage = 37250						 
--ADD_STATS_POINT_SYSTEM.abilitiesTable = nil

-- function ADD_STATS_POINT_SYSTEM:checkCache()
    -- if ADD_STATS_POINT_SYSTEM.abilitiesTable then
	   -- return true
	-- end
	
    -- local t = StatSystem.getConfig()
	-- print(dump(t))
    -- local t2 = StatSystem.config.storages
	
    -- ADD_STATS_POINT_SYSTEM.abilitiesTable = {
                                                -- ["Health"] = { t.Health, t2.healthPoints },
											    -- ["Mana"] = { t.Mana, t2.manaPoints },
											    -- ["Attack"] = { t.Attack, t2.attackPoints },
											    -- ["Protection All"] = { t.ProtectionAll, t2.protectionAllPoints },
											    -- ["Healing"] = { t.Healing, t2.healingBoostPoints },
											    -- ["Reflect"] = { t.Reflection, t2.reflectPoints },
											    -- ["Dodge"] = { t.Dodge, t2.dodgePoints },
											    -- ["Speed"] = { t.Speed, t2.speedPoints },
											    -- ["Trapped Energy"] = { t.TrappedEnergy, t2.trappedEnergyPoints },
												-- ["Experience Gain"] = { t.ExpRate, t2.experienceIncreasePoints },
												-- ["Critical Chance"] = { t.CriticalChance, t2.criticalChancePoints },
												-- ["Critical Damage"] = { t.CriticalDamage, t2.criticalDamagePoints },
												-- ["Life Leech Chance"] = { t.LifeLeechChance, t2.lifeLeechChancePoints },
												-- ["Life Leech Amount"] = { t.LifeLeechAmount, t2.lifeLeechAmountPoints },
												-- ["Mana Leech Chance"] = { t.ManaLeechChance, t2.manaLeechChancePoints },
												-- ["Mana Leech Amount"] = { t.ManaLeechAmount, t2.manaLeechAmountPoints },	
                                                -- ["Attack Speed"] = { t.BonusAttackSpeed, t2.bonusAttackSpeed }												
										    -- }
	-- --print(dump(ADD_STATS_POINT_SYSTEM.abilitiesTable))
-- end
						 
function ADD_STATS_POINT_SYSTEM:findTable(id)
    for i, v in ipairs(self.config) do
        if v.itemID == id then
	       return v
		end
	end
	return false
end

function ADD_STATS_POINT_SYSTEM:getUsages(player, index)
	local value = player:getStorageValue(self.storage + index)
	if value < 0 then
	   value = 0
	end
	return value
end

function ADD_STATS_POINT_SYSTEM:addUsages(player, index, value)
	if not value then
	   value = 1
	end
	return player:setStorageValue(self.storage + index, self:getUsages(player, index) + value)
end

function ADD_STATS_POINT_SYSTEM:canUse(player, index)
    
	local id = item:getId()
	local t = self.config[index]
    
    if not t then
       return false
    end
    
	local usages = t.usages
	if not usages then
	   return true
	end
	
	if ADD_STATS_POINT_SYSTEM:getUsages(player, index) >= usages then
	    player:sendTextMessage(MESSAGE_STATUS_WARNING, "You have already used this item " .. usages .. " times.")
	    return false
	end
	
	return true
end
	
local function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end



function ADD_STATS_POINT_SYSTEM:addAbilityPoints(player, name, amount)

   
    print(dump(StatSystem.abilitiesTable))



    local t = StatSystem.abilitiesTable[name]
	if not t then
	   t = StatSystem.abilitiesTable[firstToUpper(name)]
	end
	if not t then
	   return false
	end
	
	local storageex = t[2]
	local priceTable = StatSystem:getPrice(player, t[1], storageex)
	if not priceTable then
	   return false
	end
	local price = priceTable[1]
	local gain = priceTable[2]
	local limit = priceTable[3]	
	
	local points = player:getStorageValue(StatSystem.config.storages.pointsBalance)
	local pstoragex = player:getStorageValue(storagex)

	if price * amount > points then
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You don't have enough points.")
		return false
	end
	
	if pstoragex + amount > limit then
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You can't go pass the grade.")
		return false
	end
	
	if name == "health" or name == "Health" then
		player:setMaxHealth(player:getMaxHealth() - player:getBonusHealth() + gain * amount)
		local outfit = player:getOutfit()
		local addon = outfit.lookAddons
		if player:getCondition(CONDITION_INFIGHT) == false then
		   player:addHealth(player:getExtraHealthAddon())
		end
		player:setStorageValue(a.addedHealth, math.max(0, player:getStorageValue(a.addedHealth)) + gain * amount)
	elseif name == "mana" or name == "Mana" then
		player:setMaxMana(player:getMaxMana() - player:getBonusMana() + gain * amount)
		local outfit = player:getOutfit()
		local addon = outfit.lookAddons
		if player:getCondition(CONDITION_INFIGHT) == false then
		   player:addMana(player:getExtraManaAddon())
		end
		player:setStorageValue(StatSystem.config.storages.addedMana,
		math.max(0, player:getStorageValue(StatSystem.config.storages.addedMana)) + gain * amount)
	elseif name == "speed" or name == "Speed" then
		player:changeSpeed(gain * amount * 2)
	elseif name == "critical chance" or name == "Critical Chance" then
		player:addSpecialSkill(0, gain * amount)
	elseif name == "critical damage" or name == "Critical Damage" then
		player:addSpecialSkill(1, gain * amount)
	elseif name == "life leech chance" or name == "Life Leech Chance" then
	    player:addSpecialSkill(2, gain * amount)
	elseif name == "life leech amount" or name == "Life Leech Amount" then
	    player:addSpecialSkill(3, gain * amount)
	elseif name == "mana leech chance" or name == "Mana Leech Chance" then
	    player:addSpecialSkill(4, gain * amount)
	elseif name == "mana leech amount" or name == "Mana Leech Amount" then	
	    player:addSpecialSkill(5, gain * amount)
	end
	
	StatSystem.addPointToStat(player, name, amount*gain)
	StatSystem.addPoints(player, -price * amount)
	player:getPosition():sendMagicEffect(225)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You added " .. amount * price .. " point to chosen stat.")
	if player:getStorageValue(ToReset) == -1 then
	    player:setStorageValue(ToReset, 0)
	end
	player:setStorageValue(ToReset, player:getStorageValue(ToReset) + amount * price)
	return true
end

local action = Action()
function action.onUse(player, item, fromPos, target, toPos, isHotkey)

    if player:getName() ~= "Dakos" then
	   return true
	end
	
	
	ADD_STATS_POINT_SYSTEM:addAbilityPoints(player, "Health", 10)
	
	player:say("Heyo")
	
    return true
end

for i, v in pairs(ADD_STATS_POINT_SYSTEM.config) do
    local id = v.itemID
	if id then
       action:id(id)
	end
end
action:register()


   
