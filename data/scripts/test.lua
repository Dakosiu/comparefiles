local talk = TalkAction("/points", "!points")



local function testOutfits(cid)
	local player = Player(cid)
	if not player then
	   return false
	end
	
	
	
	local outfit = player:getOutfit()
	print(dump(outfit))
	local states = { 
	                 [1] = { type = "back", id = 41, delay = 500 },
					 [2] = { type = "back", id = 42, delay = 1000 },
					 [3] = { type = "back", id = 43, delay = 10000 },
					 [4] = { type = "front", id = 44, delay = 500 },
					 [5] = { type = "front", id = 45, delay = 1000 },
					 [6] = { type = "front", id = 46, delay = 10000 },
				   }
	for i, v in ipairs(states) do
		addEvent(function()
		   if v.type == "back" then
		      outfit.lookAuraBack = v.id
		   else
		      outfit.lookAuraFront = v.id
		   end
		   player:setOutfit(outfit)
		end, v.delay)
	end
	
	addEvent(function()
	    outfit.lookAuraBack = 0
		outfit.lookAuraFront = 0
		player:setOutfit(outfit)
	end, states[#states].delay + 500) 
	 
end
	 
	 
	
	
local data = {

														                [1] = { startPosition = { x = 128, y = 673, z = 6} },      
																		[2] = { startPosition = { x = 18,  y = 672, z = 6} },
																		[3] = { startPosition = { x = 125, y = 674, z = 6} },  
																		[4] = { startPosition = { x = 185, y = 675, z = 6} }, 
																		[5] = { startPosition = { x = 185, y = 711, z = 6} },  
																		[6] = { startPosition = { x = 125, y = 710, z = 6} },  
																		[7] = { startPosition = { x = 74,  y = 709, z = 6} },
																		[8] = { startPosition = { x = 18,  y = 708, z = 6} },
																		[9] = { startPosition = { x = 18,  y = 745, z = 6} },
																		[10] = { startPosition = { x = 74,  y = 746, z = 6} },
																		[11] = { startPosition = { x = 125, y = 747, z = 6} }, 
																		[12] = { startPosition = { x = 185, y = 748, z = 6} },  
																		[13] = { startPosition = { x = 185, y = 783, z = 6} },
																		[14] = { startPosition = { x = 125, y = 782, z = 6} },  
																		[15] = { startPosition = { x = 74, y = 781, z = 6} },  
																		[16] = { startPosition = { x = 18, y = 780, z = 6} }, 
																		[17] = { startPosition = { x = 18, y = 817, z = 6} },  
																		[18] = { startPosition = { x = 186, y = 856, z = 6} },
																		[19] = { startPosition = { x = 126, y = 855, z = 6} }, 
																		[20] = { startPosition = { x = 75, y = 854, z = 6} }, 
																		[21] = { startPosition = { x = 19, y = 853, z = 6} },
																		[22] = { startPosition = { x = 19, y = 890, z = 6} },  
																		[23] = { startPosition = { x = 75, y = 891, z = 6} },
																		[24] = { startPosition = { x = 126, y = 892, z = 6} }, 
																		[25] = { startPosition = { x = 186, y = 893, z = 6} }, 
																		[26] = { startPosition = { x = 186, y = 928, z = 6} }, 
																		[27] = { startPosition = { x = 126, y = 927, z = 6} }, 
																		[28] = { startPosition = { x = 75, y = 926, z = 6} }, 
																		[29] = { startPosition = { x = 19, y = 925, z = 6} },
																		[30] = { startPosition = { x = 19, y = 962, z = 6} },
																		[31] = { startPosition = { x = 75, y = 963, z = 6} }, 
																		[32] = { startPosition = { x = 126, y = 964, z = 6} }, 
																		[33] = { startPosition = { x = 186, y = 965, z = 6} },
																		[34] = { startPosition = { x = 187, y = 1002, z = 6} },
																		[35] = { startPosition = { x = 127, y = 1001, z = 6} },
																		[36] = { startPosition = { x = 76, y = 1000, z = 6} }, 
																		[37] = { startPosition = { x = 20, y = 999, z = 6} },
																		[38] = { startPosition = { x = 20, y = 1036, z = 6} }, 
																		[39] = { startPosition = { x = 76, y = 1037, z = 6} }, 
																		[40] = { startPosition = { x = 127, y = 1038, z = 6} }, 
																		[41] = { startPosition = { x = 187, y = 1039, z = 6} }, 
																		[42] = { startPosition = { x = 187, y = 1074, z = 6} },
																		[43] = { startPosition = { x = 127, y = 1073, z = 6} },
																		[44] = { startPosition = { x = 76, y = 1072, z = 6} }, 
																		[45] = { startPosition = { x = 20, y = 1071, z = 6} }, 
																		[46] = { startPosition = {x = 20, y = 1108, z = 6} },
																		[47] = { startPosition = {x = 76, y = 1109, z = 6} },
																		[48] = { startPosition = {x = 127, y = 1110, z = 6} },
																		[49] = { startPosition = {x = 187, y = 1111, z = 6} }, 
																		[50] = { startPosition = {x = 74, y = 818, z = 6} },
																		[51] = { startPosition = {x = 125, y = 819, z = 6} },
																		[52] = { startPosition = {x = 185, y = 820, z = 6} }																		
					} 
	

function talk.onSay(player, words, param)
    player:say("Script executed.")
	
	
	print("Current Hour: " .. os.date("%H"))
	
	
	
	-- for i, v in ipairs(data) do
	   -- local pos = Position(v.startPosition.x, v.startPosition.y, v.startPosition.z)
	   -- local tile = Tile(pos)
	   -- if not tile then
	      -- print("ERROR: " .. "INDEX: " .. i .. "Tile: " .. "X: " .. v.startPosition.x .. ", " .. "Y: " .. v.startPosition.y .. ", " .. "Z: " .. v.startPosition.z)
	   -- else
	      -- --print("Tile Checked: " .. "INDEX: " .. i)
	   -- end
	-- end
	--player:sendProgressBar(-1, true)
	
	--player:setShield(400)
	--print("Player Shield Bar: " .. player:getShieldBar())
	--player:sendUpdateProgressBar(param)
	
	
	
	
	
	-- local percent = 100
	-- for i = 1, 10 do
	    -- print("Tu jestem " .. i)
	    -- addEvent(function()
		    -- player:sendUpdateProgressBar(i)
	    -- end, 10000)
		-- --percent = percent - 5
	-- end
		    
	
	
	--SEASON_RESTART_SYSTEM:processRestart()
	--SEASON_REWARDS_SYSTEM:sendWindow(player, "Points")
	--testOutfits(player:getId())
	--SURVIVAL_EVENT_MONSTERS:selectMap(player)
	--local outfit = player:getOutfit()
	-- outfit.lookAuraBack = 41
	-- outfit.lookAuraFront = 44
	-- player:setOutfit(outfit)
	-- local outfit = player:getOutfit()
	-- outfit.lookWings = 41
	
	-- player:setOutfit(outfit)
	
	
	
	
	
	
	--print("Outfit Class: " .. dump(player:getOutfit()))
	--player:addOutfitAddon(75, 1)
    -- --DAILY_SYSTEM:addProgress(player, "Weekly")
	-- DAILY_SYSTEM:addComboProgress(player, 2)
	-- -- DAILY_SYSTEM:sendProgress(player)
	
	-- for i = 1, 15 do
	    -- DAILY_SYSTEM:addProgress(player, "Daily")
	-- end
	-- DAILY_SYSTEM:sendProgress(player)
	
	-- print("Combo Progress1: " .. DAILY_SYSTEM:getComboProgress(player, 1))
	-- print("Combo Progress2: " .. DAILY_SYSTEM:getComboProgress(player, 2))
	-- print("Combo Progress3: " .. DAILY_SYSTEM:getComboProgress(player, 3))
	-- local t = POINTS_SYSTEM.earnPoints["Kokao Warrior"]
	-- --POINTS_SYSTEM:generatePoints(player, 25, t)
	-- --POINTS_SYSTEM:generatePoints(player, 100000, t)
	-- --POINTS_SYSTEM:generateRewards(player, 750, storeIndex[1].offers[1])
	
	
	-- local index = 1
	-- local t = storeIndex[1].offers[index]
	
	-- CHEST_SYSTEM:addChest(player, t)
	
	
	
	-- local name = "Wooden Chest"
	
	-- print(dump(CHEST_SYSTEM:getChestByIndex(player, name, 1)))
	
	
	-- print("Ilosc: " .. name .. " : " .. CHEST_SYSTEM:getChestsCount(player, name))
	
	
	
	-- local actionName = "updateChests"
	-- local t = {}
	-- t.buffer = actionName
	-- t.data = { ["Wooden Chest"] = 4, ["Bronze Chest"] = 6, ["Artifact Chest"] = 2 }
	-- t = json.encode(t)
	-- CHEST_SYSTEM:sendAction(player, t)
	
	return false
end

talk:separator(" ")
talk:register()
