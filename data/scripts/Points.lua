if not POINTS_SYSTEM then
    POINTS_SYSTEM = {}
end
POINTS_SYSTEM.coins = {
                            ["Kaer Disciple"] = 6723112,
							["Jade Mystic"] = 6723113,
							["Shepherd of Aureh"] = 6723114,
							["Kokao Warrior"] = 6723115
					  }

POINTS_SYSTEM.earnPoints = {
                                ["Kokao Warrior"] = {
								                      [1] = { name = "Kokao Warrior", value = { min = 0.1, max = 0.12 } },
													  [2] = { name = "Jade Mystic", value = { min = 0.15, max = 0.3 } },
													  [3] = { name = "Shepherd of Aureh", value = { min = 0.15, max = 0.3 } }, 
													  [4] = { name = "Kaer Disciple", value = { min = 0.1, max = 0.25 } }
													},
                                ["Jade Mystic"] = {
								                      [1] = { name = "Jade Mystic", value = { min = 0.1, max = 0.15 } },
								                      [2] = { name = "Kokao Warrior", value = { min = 0.25, max = 0.35 } },
													  [3] = { name = "Shepherd of Aureh", value = { min = 0.25, max = 0.3 } }, 
													  [4] = { name = "Kaer Disciple", value = { min = 0.15, max = 0.25 } }
												  },	
                                ["Shepherd of Aureh"] = {
								                      [1] = { name = "Shepherd of Aureh", value = { min = 0.1, max = 0.15 } },
								                      [2] = { name = "Kokao Warrior", value = { min = 0.25, max = 0.35 } },
													  [3] = { name = "Jade Mystic", value = { min = 0.25, max = 0.3 } }, 
													  [4] = { name = "Kaer Disciple", value = { min = 0.15, max = 0.25 } }
												  },	
                                ["Kaer Disciple"] = {
								                      [1] = { name = "Kaer Disciple", value = { min = 0.1, max = 0.15 } },
								                      [2] = { name = "Kokao Warrior", value = { min = 0.25, max = 0.35 } },
													  [3] = { name = "Jade Mystic", value = { min = 0.25, max = 0.3 } }, 
													  [4] = { name = "Shepherd of Aureh", value = { min = 0.15, max = 0.25 } }
												  },												  
						   }
						   
						   
						   
-- POINTS_SYSTEM.rewardBoost = {
                                -- ["Kokao Warrior"] = {
                                                        -- { type = "item", id = 870, count = 1 },
                                                    -- },
								-- ["Kaer Disciple"] = {
								                        -- { type = "item", id = 878, count = 1 }, 
                                                    -- }														
                            -- }													



POINTS_SYSTEM.chests = {
                            [1] = {
							        ["Cost"] = 750,
							        ["Name"] = "Wooden Chest",
									["Rewards Count"] = { min = 1, max = 7 },
						            ["Materials"] = {
									                    ["Kokao Warrior"]     = {
														                            [1] = { type = "item", id = 870, count = { min = 1, max = 3 } },
																				    [2] = { type = "item", id = 875, count = { min = 1, max = 5 } }
																			    },
									                    ["Kaer Disciple"]     = {
														                            [1] = { type = "item", id = 871, count = { min = 1, max = 3 } },
																				    [2] = { type = "item", id = 874, count = { min = 1, max = 5 } }
																			    },		
									                    ["Jade Mystic"]       = {
														                            [1] = { type = "item", id = 872, count = { min = 1, max = 3 } },
																				    [2] = { type = "item", id = 873, count = { min = 1, max = 5 } }
																			    },		
									                    ["Shepherd of Aureh"] = {
														                            [1] = { type = "item", id = 872, count = { min = 1, max = 3 } },
																			  	    [2] = { type = "item", id = 873, count = { min = 1, max = 5 } }
																			    }																			
												    }
									}
						}

-- function POINTS_SYSTEM:loadItemBoost()
    -- if not self.itemBoosts then
	    -- self.itemBoosts = {}
	-- end
    -- for i, v in pairs(self.rewardBoost) do
	    -- if not self.itemBoosts[i] then
	        -- self.itemBoosts[i] = {}
			-- self.itemBoosts[i].name = i
	    -- end
		-- for z, b in pairs(v) do
		    -- self.itemBoosts[i][b.id] = true
		-- end	
    -- end	    
	-- --print(dump(self.itemBoosts))
-- end


-- local globalevent = GlobalEvent("load_POINTS_SYSTEM")
-- function globalevent.onStartup()	
	-- POINTS_SYSTEM:loadItemBoost()
-- end
-- globalevent:register()

					   
-- function POINTS_SYSTEM:hasItemBoost(vocation, id)	
	-- if self.itemBoosts[vocation][id] then
	    -- return true
	-- end
	
	-- return false
-- end

-- function POINTS_SYSTEM:findItemBoost(id)
    -- for i, v in pairs(self.itemBoosts) do
	    -- if self:hasItemBoost(i, id) then
		    -- return i
		-- end
	-- end
	-- return false
-- end

function POINTS_SYSTEM:getCoins(player, coinType)
    local key = self.coins[coinType]
	local value = player:getStorageValue(key)
	if value < 0 then
	    value = 0
	end
	return value
end

function POINTS_SYSTEM:addCoins(player, coinType, value)
    local key = self.coins[coinType]
	local value2 = self:getCoins(player, coinType)
	return player:setStorageValue(key, value2 + value)
end

function POINTS_SYSTEM:removeCoins(player, coinType, value)
    local key = self.coins[coinType]
	local value2 = self:getCoins(player, coinType)
	return player:setStorageValue(key, value2 - value)
end

function POINTS_SYSTEM:getAlphaPoints(player)
    return self:getCoins(player, "Kaer Disciple") + self:getCoins(player, "Jade Mystic") + self:getCoins(player, "Shepherd of Aureh") + self:getCoins(player, "Kokao Warrior")
end

function POINTS_SYSTEM:generateRewards(player, storeTable)
    
	
	local tableId = storeTable.id
	local chestTable = self.chests[tableId]
	local requiredCoins = chestTable["Cost"]
	
	local finalRewardTable = {}
	
	if self:getAlphaPoints(player) < requiredCoins then
	    return
	end
	--print(dump(chestTable))
	
	
	
	local usedPoints = 0
	local t = {}
	local start = true
	while usedPoints < requiredCoins and start do
	    for i, v in pairs(self.coins) do
		    local points = self:getCoins(player, i)
			--points = math.random(1, 500)
			local random_points = math.random(0, points)
			local pointsLeft = requiredCoins - usedPoints
			
			if random_points > pointsLeft then
			    random_points = pointsLeft
			end

			local left = requiredCoins - random_points
			local percentage = ((left - requiredCoins) / requiredCoins)
			percentage = tonumber(string.format("%.3f", percentage))
			percentage = percentage * 100
			percentage = math.abs(percentage)
			if not t[i] then
				t[i] = {}
				t[i].percentage = 0
				t[i].points = 0
			end
			t[i].percentage = t[i].percentage + percentage
			t[i].points = t[i].points + random_points
			usedPoints = usedPoints + random_points
			
			if usedPoints == requiredCoins then
			    start = false
				break
			end
			
		end
    end
	
	local t2 = {}
	for i, v in pairs(t) do
	    v.name = i
		table.insert(t2, v)
	end
	
	table.sort(t2, function(a, b) return a.points < b.points end)	
	
	local countTable = chestTable["Rewards Count"]
	
	local rewardsCount = math.random(countTable.min, countTable.max)
	print("Rewards Count: " .. rewardsCount)
	local rewards = 0
	while rewards < rewardsCount do
	    for i, v in ipairs(t2) do
		    local className = v.name
			local percentage = v.percentage
			local classTable = chestTable["Materials"][className]
			if classTable then
			    local rand = math.random(0, 100)
				print("Rand: " .. rand)
				print("Chance: " .. percentage)
				if rand <= percentage then
				    --print("Wylosowano Class: " .. className .. ".")
				    local rewardTable = classTable[math.random(1, #classTable)]
					local id = rewardTable.id
					local countT = rewardTable.count
					local minCount = countT.min
					local maxCount = countT.max
					local count = math.random(minCount, maxCount)
					
					print("Reward:" .. getItemName(id) .. " Count: " .. count)
					player:addToInventory(id, count)
					if not finalRewardTable[id] then
					    finalRewardTable[id] = {}
						finalRewardTable[id].id = id
						finalRewardTable[id].count = 0
						finalRewardTable[id].name = getItemName(id)
					end
					finalRewardTable[id].count = finalRewardTable[id].count + count
					rewards = rewards + 1
					
					
					
				end
			end
		end
	end
	
	
	for i, v in ipairs(t2) do
	    POINTS_SYSTEM:removeCoins(player, v.name, v.points)
	end
	
	
	
    return finalRewardTable
end
	
    	
	
	




-- function POINTS_SYSTEM:generatePoints(player, value, t)
	-- local usedPoints = 0
	-- local t = {}
	-- local start = true
	-- while usedPoints < requiredCoins and start do
	    -- for i, v in pairs(self.coins) do
		    -- local points = self:getCoins(player, i)
			-- --points = math.random(1, 500)
			-- local random_points = math.random(0, points)
			-- local pointsLeft = requiredCoins - usedPoints
			
			-- if random_points > pointsLeft then
			    -- random_points = pointsLeft
			-- end

			-- local left = requiredCoins - random_points
			-- local percentage = ((left - requiredCoins) / requiredCoins)
			-- percentage = tonumber(string.format("%.3f", percentage))
			-- percentage = percentage * 100
			-- percentage = math.abs(percentage)
			-- if not t[i] then
				-- t[i] = {}
				-- t[i].percentage = 0
				-- t[i].points = 0
			-- end
			-- t[i].percentage = t[i].percentage + percentage
			-- t[i].points = t[i].points + random_points
			-- usedPoints = usedPoints + random_points
			
			-- if usedPoints == requiredCoins then
			    -- start = false
				-- break
			-- end
			
		-- end
    -- end
-- end


function POINTS_SYSTEM:generatePoints(player, value, t)
	local usedPoints = 0
	local start = true
	
	
	print("Value:" .. value)
	local percentageTable = {}
	local usedPercentage = 0
	while usedPercentage < 100 and start do
	    for i, v in pairs(t) do	
		    local minValue = v.value.min * 100
		    local maxValue = v.value.max * 100
			local rand = math.random(minValue, maxValue)
			local percentage = rand
			--tonumber(string.format("%.3f", percentage))
			local percentageLeft = 100 - usedPercentage
			if percentage > percentageLeft then
			    percentage = percentageLeft
			end
			
			local name = v.name
			
			if not percentageTable[name] then
			    percentageTable[name] = {}
				percentageTable[name].name = name
				percentageTable[name].percentage = 0
			end
			print(v.name .. " Coin: ")
            print("Percentage: " .. percentage)
			percentageTable[name].percentage = percentageTable[name].percentage + percentage
			
			usedPercentage = usedPercentage + percentage
			
			if usedPercentage == 100 then
			    start = false
				break
			end
		end
		--start = false
	end
	print(dump(percentageTable))
	
	
	
	
	local percentageTable2 = {}
	for i, v in pairs(percentageTable) do
	    table.insert(percentageTable2, v)
	end
	
	local coinsLeft = value
	for i, v in pairs(percentageTable) do
	    print("Table Name: " .. i)
	    local percent = v.percentage / 100
		print("Percentage: " .. percent)
		print("Value: " .. value)
		local points = math.floor(value * percent)
		
		--local points = value - (value * percent)
		self:addCoins(player, i, points)
		print("Points: " .. points)
		coinsLeft = coinsLeft - points
	end
	    --local coins = ((left - requiredCoins) / requiredCoins)
	
	
	print("Left Points: " .. coinsLeft)
	
	if coinsLeft > 0 then
	    local randTable = percentageTable2[math.random(1, #percentageTable2)]
		local name = randTable.name
		print("Reaming Points: " .. coinsLeft)
		self:addCoins(player, name, coinsLeft)
		coinsLeft = 0
	end
	
	print("Left Points2: " .. coinsLeft)
	player:sendAttributes(player)
	
end





    -- local percentageLeft = 100
    -- local usedCoins = 0
    
    -- local pointsTable = {}
    -- print("Value: " .. value)
    -- for i, v in ipairs(t) do
        
	    -- local minValue = v.value.min * 100
		-- local maxValue = v.value.max * 100
		-- local rand = math.random(minValue, maxValue)
		-- percentageLeft = percentageLeft - rand
		-- local percentage = rand / 100
		-- print(v.name .. " Coin: ")
        -- print("Percentage: " .. percentage * 100 .. "%")
        -- local coins = (value / 100 * percentage)
        -- coins = math.floor(coins * 100)
		-- if coins < 1 then
		    -- coins = 1
		-- end
		-- print("Math Coins: " .. coins)
		-- usedCoins = usedCoins + coins
		-- pointsTable[v.name] = coins
		-- if percentageLeft < 1 or usedCoins >= value then
		   -- break
		-- end
    -- end
    -- print("Percent Left: " .. percentageLeft)
    -- print("Coins Left: " .. value - usedCoins)
    
    -- local coinsLeft = value - usedCoins
    -- if coinsLeft >= 1 then
         -- --coinsLeft = math.floor(coinsLeft / #t)
         -- coinsLeft = coinsLeft / #t
    -- end
    
    -- for i, v in pairs(pointsTable) do
         -- local finalValue = v + coinsLeft
         -- self:addCoins(player, i, finalValue)
		 -- print("Coins For: " .. i .. ": " .. self:getCoins(player, i))
    -- end