if not DIVISION_SYSTEM then
    DIVISION_SYSTEM = {}
end

DIVISION_SYSTEM.divisions = {
                                [1] = {
								        [1] = {
										        name = "Nobody III",
												points = 100
											  },
								        [2] = {
										        name = "Nobody II",
												points = 100
											  },	
								        [3] = {
										        name = "Nobody I",
												points = 100
											  },
                                      },
                                [2] = {
								        [1] = {
										        name = "Nobody with a stick III",
												points = 200
											  },
								        [2] = {
										        name = "Nobody with a stick II",
												points = 200
											  },	
								        [3] = {
										        name = "Nobody with a stick I",
												points = 200
											  },
                                      },	
                                [3] = {
								        [1] = {
										        name = "Adventurer III",
												points = 300
											  },
								        [2] = {
										        name = "Adventurer II",
												points = 300
											  },	
								        [3] = {
										        name = "Adventurer I",
												points = 300
											  },
                                      },		
                                [4] = {
								        [1] = {
										        name = "Gladiator IV",
												points = 300
											  },								
								        [2] = {
										        name = "Gladiator III",
												points = 300
											  },
								        [3] = {
										        name = "Gladiator II",
												points = 300
											  },	
								        [4] = {
										        name = "Gladiator I",
												points = 300
											  },
                                      },	
                                [5] = {
								        [1] = {
										        name = "Master Gladiator IV",
												points = 500
											  },								
								        [2] = {
										        name = "Master Gladiator III",
												points = 500
											  },
								        [3] = {
										        name = "Master Gladiator II",
												points = 500
											  },	
								        [4] = {
										        name = "Master Gladiator I",
												points = 500
											  },
                                      },			
                                [6] = {
								        [1] = {
										        name = "God of the Arena V",
												points = 500
											  },								
								        [2] = {
										        name = "God of the Arena IV",
												points = 500
											  },								
								        [3] = {
										        name = "God of the Arena III",
												points = 500
											  },
								        [4] = {
										        name = "God of the Arena II",
												points = 500
											  },	
								        [5] = {
										        name = "God of the Arena I",
												points = 500
											  },
                                      },	
                                [7] = {
								        [1] = {
										        name = "Kraantian Gladiator",
											  },								
                                      },									  
                            }

function DIVISION_SYSTEM:getDivisionValues(player)
	local t = self.divisions
	-- if player:getDivision():lower() == "not set" or player:getDivision():lower() == "" then
	    -- player:setDivision(t[1][1].name)
	-- end
	
	for i, v in ipairs(t) do
	    for z, b in ipairs(v) do
	        if b.name:lower() == player:getDivision():lower() then
		        return { ["Index"] = i, ["Rank"] = z, ["Table"] = b }
			end
		end
	end
    
	player:setDivision(t[1][1].name)
	return { ["Index"] = 1, ["Rank"] = 1, ["Table"] = t[1][1] }
end

function DIVISION_SYSTEM:updateDivision(player, values)
    
	local index = values["Index"]
	local rank = values["Rank"]
	local t = self.divisions
	
	if index == #t and rank == #t[index] then
	    return false
	end
	
	local divisionTable = values["Table"]
	local points = divisionTable.points
	--local player_points = player:getPoints()
	
	local newTable = nil
		
	if rank == #t[index] then
	    newTable = t[index + 1][1]
	else 
	    newTable = t[index][rank + 1]
	end	
	player:setDivision(newTable.name)
	player:removePoints(points)
	
end
	
function DIVISION_SYSTEM:addPoints(player, points)
    if not points then
	    return false
	end
	player:addPoints(points)
	local player_points = player:getPoints()
	local values = self:getDivisionValues(player)
	local t = values["Table"]
	if t.points and player_points >= t.points then
	    self:updateDivision(player, values)
	end
end

function DIVISION_SYSTEM:getPointsString(player)
	local values = self:getDivisionValues(player)
	if not values then
	    return false
	end
	
	local player_points = player:getPoints()
	local t = values["Table"]
	local points = t.points
	if not points then
	    return player_points .. " Points"
	end
	
	return player_points .. "/" .. points
end
	

-- local talkaction = TalkAction("!testo", "/testo")

-- function talkaction.onSay(player, words, param)
    -- --DIVISION_SYSTEM:addPoints(player, 20)
	-- print("Points: " .. player:getPoints())
	-- --player:setDivision("Nobody III")
	-- print("Player Division: " .. player:getDivision())
	
	
	-- -- local values = DIVISION_SYSTEM:getDivisionValues(player)
	-- -- print(dump(values))
-- end

-- talkaction:register()