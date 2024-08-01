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
						   
						   
						   
POINTS_SYSTEM.rewardBoost = {
                                ["Kokao Warrior"] = {
                                                        { type = "item", id = 870 },
                                                    },
								["Kaer Disciple"] = {
								                        { type = "item", id = 878 }, 
                                                    }														
                            }													



function POINTS_SYSTEM:loadItemBoost()
    if not self.itemBoosts then
	    self.itemBoosts = {}
	end
    for i, v in pairs(self.rewardBoost) do
	    if not self.itemBoosts[i] then
	        self.itemBoosts[i] = {}
			self.itemBoosts[i].name = i
	    end
		for z, b in pairs(v) do
		    self.itemBoosts[i][b.id] = true
		end	
    end	    
	print(dump(self.itemBoosts))
end


local globalevent = GlobalEvent("load_POINTS_SYSTEM")
function globalevent.onStartup()	
	POINTS_SYSTEM:loadItemBoost()
end
globalevent:register()

					   
function POINTS_SYSTEM:hasItemBoost(vocation, id)	
	if self.itemBoosts[vocation][id] then
	    return true
	end
	
	return false
end

function POINTS_SYSTEM:findItemBoost(id)
    for i, v in pairs(self.itemBoosts) do
	    if self:hasItemBoost(i, id) then
		    return i
		end
	end
	return false
end

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


-- local function round(num)
  -- if math.abs(num) > 2^52 then
    -- return num
  -- end
  -- return num < 0 and num - 2^52 + 2^52 or num + 2^52 - 2^52
-- end


function POINTS_SYSTEM:generateRewards(player, requiredCoins, rewardTable)
    
	local usedPoints = 0
	local t = {}
	local start = true
	while usedPoints < requiredCoins and start do
	    for i, v in pairs(self.coins) do
		    local points = self:getCoins(player, i)
			points = math.random(1, 500)
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
				--t[i].left = 0
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
	
	
	for i, v in pairs(rewardTable) do
	    local chance = 50
		local rand = math.random(0, 100)
		local id = v.id
		print("ID:" .. id)
		
		local getBoostVocation = self:findItemBoost(id)
		if getBoostVocation then
		    local vocationTable = t[getBoostVocation]
			chance = chance + vocationTable.percentage
			
			print(dump(vocationTable))
			
			
		end
		
		print("Rand:" .. rand)
		print("Szansa: " .. chance)
		
		
		
		
		
    end
		
		--if rand <= chance then
		    
	
	--print(dump(rewardTable))
	
	
	
	
	
	
	-- print("Total Used Points: " .. usedPoints) 
    -- print(dump(t))
    return true
end		
	
    	
	
	




function POINTS_SYSTEM:generatePoints(player, value, t)
    local percentageLeft = 100
    local usedCoins = 0
    
    local pointsTable = {}
    print("Value: " .. value)
    for i, v in ipairs(t) do
        
	    local minValue = v.value.min * 100
		local maxValue = v.value.max * 100
		local rand = math.random(minValue, maxValue)
		percentageLeft = percentageLeft - rand
		local percentage = rand / 100
		print(v.name .. " Coin: ")
        print("Percentage: " .. percentage * 100 .. "%")
        local coins = (value / 100 * percentage)
        coins = math.floor(coins * 100)
		if coins < 1 then
		    coins = 1
		end
		print("Math Coins: " .. coins)
		usedCoins = usedCoins + coins
		pointsTable[v.name] = coins
		if percentageLeft < 1 or usedCoins >= value then
		   break
		end
    end
    print("Percent Left: " .. percentageLeft)
    print("Coins Left: " .. value - usedCoins)
    
    local coinsLeft = value - usedCoins
    if coinsLeft >= 1 then
         --coinsLeft = math.floor(coinsLeft / #t)
         coinsLeft = coinsLeft / #t
    end
    
    for i, v in pairs(pointsTable) do
         local finalValue = v + coinsLeft
         self:addCoins(player, i, finalValue)
		 print("Coins For: " .. i .. ": " .. self:getCoins(player, i))
    end
end

