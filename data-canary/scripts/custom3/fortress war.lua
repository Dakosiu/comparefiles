FORTRESS_WAR_EVENT_CONFIG = {
                              minMembers = 2, --- ile minimum musi byc graczy z minLevelem w danej guildi by mogli zapisac sie na event.
							  minLevel = 300, --- minimalny level dolaczenia do eventu
							  ["Scheduler"] = {
							                    ["Wednesday"] = { "22:10" },      --- dni tygodnia albo po prostu mozna wpisac ["Everyday"] to bedzie codziennie.
												["Monday"] = { "21:00", "19:00" },
										      },
							  ["Island"] = {
							                 position = { 971, 1053, 7 } -- pozycja wyspy na ktora ma teleportowac npc
										   },
							  ["Guild House"] = { 
							                      position = { 1027, 1022, 7 } -- pozycja drzwi guild house
												},
							  ["Teleport"] = { 
							                   itemid = 1387, --- id teleportu na event
											   position = { 1014, 1022, 7 }, --- pozycja teleportu na event
											 },
							  ["Main Boss"] = { 
							                    name = "Dragon",
												PlayersPosition = { 612, 918, 5 },
												SpawnPosition = { 615, 904, 5 },
							                  },
							  ["Mini Boss"] = { 
							                    name = "Cave Rat",
							                    teleportTo = { 607, 907, 7 },
											  },
							  ["Daily Boss"] = {
							                     ["Scheduler"] = { 
												                   ["Everyday"] = { "23:43", "23:48" }, --- dni tygodnia albo po prostu mozna wpisac ["Everyday"] to bedzie codziennie.
																   ["Monday"] = { "21:00", "19:00" },
 												                 },
												 name = "Orc Leader", --- nazwa daily bosa
							                     EntracePosition = { 1024, 1031, 7 }, --- sqm na ktory moga wejsc tylko wygrani
												 SpawnPosition = { 1008, 1045, 7 }, --- miejsce gdzie respi sie daily boss
												 DestinationPosition = { 1008, 1041, 7 }, --- gdzie teleportuje graczy
											   },
							  ["Daily Chest"] = {
							                      itemid = 1746, --- id skrzynki
							                      position = { 1018, 1030, 7 }, --- pozycja skrzynki
												  ["Rewards"] = {
															      ["Monday"] = { 
																                [1] = { 
																					    { itemid = 2317, count = 1 }, --- item id i ilosc
																					   },
																				[2] = { 
																					    { itemid = 2160, count = 10 }, 
																					    { itemid = 2152, count = 5 },
																				      },
																               },
															      ["Tuesday"] = { 
																                 [1] = { 
																					     { itemid = 2317, count = 1 },
																					   },
																				 [2] = { 
																					     { itemid = 2160, count = 10 }, 
																					     { itemid = 2152, count = 5 },
																				      },
																                },
															      ["Wednesday"] = { 
																                    [1] = { 
																					        { itemid = 2316, count = 1 },
																						  },
																					[2] = { 
																					        { itemid = 2160, count = 50 }, 
																							{ itemid = 2152, count = 10 },
																						  },
																                  },
															      ["Thursday"] = { 
																                  [1] = { 
																					      { itemid = 2317, count = 1 },
																					    },
																				  [2] = { 
																					      { itemid = 2160, count = 10 }, 
																					      { itemid = 2152, count = 5 },
																				      },
																                 },
															      ["Friday"] = { 
																                 [1] = { 
																					     { itemid = 2317, count = 1 },
																					   },
																				 [2] = { 
																					     { itemid = 2160, count = 10 }, 
																					     { itemid = 2152, count = 5 },
																				      },
																               },
															      ["Saturday"] = { 
																                  [1] = { 
																					      { itemid = 2317, count = 1 },
																					    },
																				  [2] = { 
																					      { itemid = 2160, count = 10 }, 
																					      { itemid = 2152, count = 5 },
																				        },
																                 },
															      ["Sunday"] = { 
																                 [1] = { 
																					     { itemid = 2317, count = 1 },
																					   },
																				 [2] = { 
																					     { itemid = 2160, count = 10 }, 
																					     { itemid = 2152, count = 5 },
																				       },
																               },
                                                                }    
                                                },														
							  ["Rooms"] = {
							                [1] = {
													["Waiting Room"] = {  663, 1008, 6 },
													["Mini Boss"] = { 
													                   PlayersPosition = { 528, 923, 7 },
																	   SpawnPosition = { 548, 916, 7 },
																	   DestinationPosition = { 557, 917, 7 }
																	}
												  },
							                [2] = {
													["Waiting Room"] = { 617, 973, 6 },
													["Mini Boss"] = { 
													                   PlayersPosition = { 541, 995, 7 },
																	   SpawnPosition = { 558, 984, 7 },
																	   DestinationPosition = { 567, 978, 7 }
																	}
												  },
											[3] = {
													["Waiting Room"] = { 569, 1001, 6 },
													["Mini Boss"] = { 
													                   PlayersPosition = { 602, 1008, 7 },
																	   SpawnPosition = { 604, 991, 7 },
																	   DestinationPosition = { 610, 982, 7 }
																	}
												  }, 
											[4] = {
													["Waiting Room"] = { 519, 920, 6 },
													["Mini Boss"] = { 
													                   PlayersPosition = { 677, 997, 7 },
																	   SpawnPosition = { 661, 986, 7 },
																	   DestinationPosition = { 653, 979, 7 }
																	}
												  }, 
											[5] = {
													["Waiting Room"] = { 568, 891, 6 },
													["Mini Boss"] = { 
													                   PlayersPosition = { 699, 912, 7 },
																	   SpawnPosition = { 676, 913, 7  },
																	   DestinationPosition = { 668, 912, 7 }
																	}
												  }, 
											[6] = {
													["Waiting Room"] = { 569, 861, 6 },
													["Mini Boss"] = { 
													                   PlayersPosition = { 699, 879, 7 },
																	   SpawnPosition = { 685, 879, 7  },
																	   DestinationPosition = { 669, 880, 7 }
																	}
												  },
											[7] = {
													["Waiting Room"] = { 590, 822, 6 },
													["Mini Boss"] = { 
													                   PlayersPosition = { 672, 822, 7 },
																	   SpawnPosition = { 660, 838, 7 },
																	   DestinationPosition = { 653, 846, 7 }
																	}
												  },
											[8] = {
													["Waiting Room"] = { 649, 857, 6 },
													["Mini Boss"] = { 
													                   PlayersPosition = { 607, 809, 7 },
																	   SpawnPosition = { 609, 831, 7 },
																	   DestinationPosition = { 608, 837, 7 }
																	}
												  },
											[9] = {
													["Waiting Room"] = { 654, 896, 6 },
													["Mini Boss"] = { 
													                   PlayersPosition = { 548, 823, 7 },
																	   SpawnPosition = { 561, 838, 7 },
																	   DestinationPosition = { 568, 847, 7 }
																	}
												  },
											[10] = {
													["Waiting Room"] = { 669, 944, 6 },
													["Mini Boss"] = { 
													                   PlayersPosition = { 530, 875, 7 },
																	   SpawnPosition = { 550, 878, 7 },
																	   DestinationPosition = { 558, 878, 7 }
																	}
												  },
                                         },
							  ["Spawn NPC"] = {	
							                    name = "Fortress Refiler",
                                                ["Positions"] = {
                                                                  { 669, 951, 6},
                                                                  { 663, 1015, 6},
                                                                  { 617, 980, 6},
                                                                  { 569, 1008, 6},
                                                                  { 519, 927, 6},
                                                                  { 568, 898, 6},
                                                                  { 569, 868, 6},
                                                                  { 590, 829, 6},
                                                                  { 649, 864, 6},
                                                                  { 654, 903, 6},
															    }
											  }
							}
							
if not FortressWar then
   FortressWar = { }
   FortressWar.__newindex = FortressWar
   FortressWar.aid = 7652
   FortressWar.storageTeamID = 321313
end

local _debugMode = true

local function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function FortressWar:isLeader(player)

    if not player then
	   if _debugMode then
	      print("Function isLeader(player): Player not found.")
	   end
	   return nil
	end
	
	local guild = player:getGuild()
	if not guild then
	   return false
	end
	
	if player:getGuildLevel() == 3 then
	   return true
	end
	
	return false
end

function FortressWar:kickLeaders()
    local t = FortressWar.leaders
	if not t then
	   return
	end
	
	for index, id in pairs(t) do
	    local player = Player(id)
		if player then
           local town = player:getTown()
	       local id = town:getId()
	       player:teleportTo(Town(id):getTemplePosition())
		end
    end
	
	FortressWar.leaders = nil
	return true
end

function FortressWar:getMembersCount(player)

    if not player then
	   if _debugMode then
	      print("function FortressWar:getMembersCount(player): Player not found.")
	   end
	   return nil
	end
	
	if not FortressWar:isLeader(player) then
	   return false
	end
	
	local members = 0
	local requiredLevel = FORTRESS_WAR_EVENT_CONFIG.minLevel
	
	local guild = player:getGuild()
	if not guild then
	   return false
	end
	
	local onlineMembers = guild:getMembersOnline()
	for index, member in pairs(onlineMembers) do
	    local level = member:getLevel()
		if level >= requiredLevel then
		   members = members + 1
		end
    end
	
	return members
end

function FortressWar:isGuildReady(player)

    if not player then
	   return nil
	end
	
	local count = FortressWar:getMembersCount(player)
	if not count or count < FORTRESS_WAR_EVENT_CONFIG.minMembers then
	   return false
	end
	
	return true
end
	
function FortressWar:createTeleport()
    
	local t = FORTRESS_WAR_EVENT_CONFIG["Teleport"]
    if not t then
	   if _debugMode then
	      print("function FortressWar:createTeleport(): Table not found.")
	   end
	   return nil
	end
	
	local x = t.position[1]
	local y = t.position[2]
	local z = t.position[3]
	local pos = Position(x, y, z)
	if pos then
	   local tile = Tile(pos)
	   if tile then
	      local id = t.itemid
	      local teleport = tile:getItemById(id)
		  if teleport then
		     teleport:remove()
		  end
		  teleport = Game.createItem(id, 1, pos)
		  if teleport then
		     teleport:setAttribute(ITEM_ATTRIBUTE_ACTIONID, FortressWar.aid)
		  end
	   end
	end
end

function FortressWar:removeTeleport()
    
	local t = FORTRESS_WAR_EVENT_CONFIG["Teleport"]
    if not t then
	   if _debugMode then
	      print("function FortressWar:createTeleport(): Table not found.")
	   end
	   return nil
	end
	
	local x = t.position[1]
	local y = t.position[2]
	local z = t.position[3]
	local pos = Position(x, y, z)
	if pos then
	   local tile = Tile(pos)
	   if tile then
	      local id = t.itemid
	      local teleport = tile:getItemById(id)
		  if teleport then
		     teleport:remove()
			 pos:sendMagicEffect(CONST_ME_POFF)
		  end
	   end
	end
end

function FortressWar:getFreeTeamID()

	if not FortressWar.teams then
	   FortressWar.teams = { }
	end
	
	local maxTeams = #FORTRESS_WAR_EVENT_CONFIG["Rooms"]
	if #FortressWar.teams == maxTeams then
	   return false
	end
	
    local randTeamID = math.random(1, maxTeams)
	
	if #FortressWar.teams == 0 then
	   return randTeamID
	end
	
	local takenTeams = { }
	for index, v in pairs(FortressWar.teams) do
	    local id = v["Team ID"]
		if id then
			  table.insert(takenTeams, id)
	    end
	end
	
	while isInArray(takenTeams, randTeamID) do
	  randTeamID = math.random(1, maxTeams)
    end
	
	return randTeamID
end
	    
function FortressWar:generateTeamID(player)
    
	if not player then
	   if _debugMode then
	      print("function FortressWar:generateTeamID(player): Player not found.")
	   end
	   return nil
	end
		
	local id = FortressWar:getFreeTeamID()
	if not id then
	   return false
	end
	
	local values = { ["Leader ID"] = player:getId(), ["Team ID"] = id }
	table.insert(FortressWar.teams, values)
	player:setStorageValue(FortressWar.storageTeamID, id)
	return true
end

function FortressWar:getTeamID(player)

     
	if not player then
	   if _debugMode then
	      print("function FortressWar:getTeamID(player): Player not found.")
	   end
	   return nil
	end
	
	return player:getStorageValue(FortressWar.storageTeamID)
end

function FortressWar:insertPlayersToTable()

    if not FortressWar.participants then
	   FortressWar.participants = {}
	end
	
	if not FortressWar.teams then
	   return false
	end

	for i, leaderTable in pairs(FortressWar.teams) do
	    local leader_id = leaderTable["Leader ID"]
		if leader_id then
		   local player = Player(leader_id)
		   if player then
		      if not FortressWar:isGuildReady(player) then
                 local town = player:getTown()
	             local id = town:getId()
	             player:teleportTo(Town(id):getTemplePosition())
				 player:sendCancelMessage("Your guild has not enough online members to participate in fortress war event.")
			  else
	             local guild = player:getGuild()
	             if guild then
			        local onlineMembers = guild:getMembersOnline()
	                for index, member in pairs(onlineMembers) do
	                    local level = member:getLevel()
		                local requiredLevel = FORTRESS_WAR_EVENT_CONFIG.minLevel
		                if level >= requiredLevel then
		                   local teamid = FortressWar:getTeamID(player)
		                   member:setStorageValue(FortressWar.storageTeamID, teamid)
						   member:registerEvent("FortressWar_onDeath")
		                if not FortressWar.participants["Team " .. teamid] then
		                   FortressWar.participants["Team " .. teamid] = {}
		                end
		                local values = { ["Player Id"] = member:getId() }
		                table.insert(FortressWar.participants["Team " .. teamid], values)
		            end 
				end
			  end
		   end
		   end
		end
	end
end

function FortressWar:isParticipant(player)
    
	local TeamID = FortressWar:getTeamID(player)
	if not TeamID then
	   return false
	end
	
	local t = FortressWar.participants
	if not t then
	   return false
	end
	
	local teamTable = t["Team " .. TeamID]
	if not teamTable then
	   return false
	end
	
	for index, v in pairs(teamTable) do
	    local playerTable = v["Player Id"]
		if playerTable then
	       local id = player:getId()
		   if playerTable == id then
		      return true
		   end
		end
    end
	
	return false
end

function FortressWar:kickPlayer(player)
    
	if not FortressWar:isParticipant(player) then
	   return false
	end
	
	local TeamID = FortressWar:getTeamID(player)
	if not TeamID then
	   return false
	end
	
	local t = FortressWar.participants
	if not t then
	   return false
	end
	
	local teamTable = t["Team " .. TeamID]
	if not teamTable then
	   return false
	end
	
	for index, v in pairs(teamTable) do
	    local playerTable = v["Player Id"]
		if playerTable then
	       local id = player:getId()
		   if playerTable == id then
		      player:setStorageValue(FortressWar.storageTeamID, -1)
		      table.remove(teamTable, index)
			  local length = #teamTable
			  if length == 0 then
			     FortressWar:sendMessage(MESSAGE_STATUS_WARNING, FortressWar:getGuildName(player) .. " Guild has been defeated.")
			     FortressWar.participants["Team " .. TeamID] = nil
			  end
			  return true
		   end
		end
    end

	return false
end

function FortressWar:loadMiniBosses()
    
	if not FortressWar.bosses then
	   FortressWar.bosses = {}
	end
	
	FortressWar:removeMiniBosses()
	
	for index, v in pairs(FORTRESS_WAR_EVENT_CONFIG["Rooms"]) do
	    local bossTable = v["Mini Boss"]
		if bossTable then
		   local x = bossTable.SpawnPosition[1]
		   local y = bossTable.SpawnPosition[2]
		   local z = bossTable.SpawnPosition[3]
		   local pos = Position(x, y, z)
		   if pos then
		      local name = FORTRESS_WAR_EVENT_CONFIG["Mini Boss"].name
		      local boss = Game.createMonster(name, pos)
              if boss then
			     boss:setStorageValue(FortressWar.aid, index)
				 boss:registerEvent("FortressWar_onDeath")
				 local id = boss:getId()
				 table.insert(FortressWar.bosses, id)
			  end
		   end
		end
    end
end

function FortressWar:loadMainBoss()
    
	if not FortressWar.mainboss then
	   FortressWar.mainboss = {}
	end
	
	FortressWar:removeMainBoss()
	local bossTable = FORTRESS_WAR_EVENT_CONFIG["Main Boss"]
	if bossTable then
	   local x = bossTable.SpawnPosition[1]
	   local y = bossTable.SpawnPosition[2]
	   local z = bossTable.SpawnPosition[3]
	   local pos = Position(x, y, z)
	   if pos then
		  local name = bossTable.name
		  local boss = Game.createMonster(name, pos)
          if boss then
			 --boss:setStorageValue(FortressWar.aid, index)
			 --boss:registerEvent("FortressWar_onDeath")
			 local id = boss:getId()
			 table.insert(FortressWar.mainboss, id)
		  end
	   end
	end
end

function FortressWar:loadDailyBoss()
    
	if not FortressWar.dailyboss then
	   FortressWar.dailyboss = {}
	end
	
	FortressWar:removeDailyBoss()
	local bossTable = FORTRESS_WAR_EVENT_CONFIG["Daily Boss"]
	if bossTable then
	   local x = bossTable.SpawnPosition[1]
	   local y = bossTable.SpawnPosition[2]
	   local z = bossTable.SpawnPosition[3]
	   local pos = Position(x, y, z)
	   if pos then
		  local name = bossTable.name
		  local boss = Game.createMonster(name, pos)
          if boss then
		     FortressWar.SpawnDailyBoss = false
			 addEvent(function()
			    FortressWar.SpawnDailyBoss = true
             end, 1 * 1000 * 60)
			 --boss:setStorageValue(FortressWar.aid, index)
			 --boss:registerEvent("FortressWar_onDeath")
			 local id = boss:getId()
			 table.insert(FortressWar.dailyboss, id)
		  end
	   end
	end
end

function FortressWar:removeMiniBosses()
    
	local t = FortressWar.bosses
	if not t then
	   return false
	end
	
	for i, id in pairs(t) do
	    local boss = Monster(id)
		if boss then
		   boss:remove()
		end
		table.remove(t, i)
	end
end

function FortressWar:removeMainBoss()
    
	local t = FortressWar.mainboss
	if not t then
	   return false
	end
	
	for i, id in pairs(t) do
	    local boss = Monster(id)
		if boss then
		   boss:remove()
		end
		table.remove(t, i)
	end
end

function FortressWar:removeDailyBoss()
    
	local t = FortressWar.dailyboss
	if not t then
	   return false
	end
	
	for i, id in pairs(t) do
	    local boss = Monster(id)
		if boss then
		   boss:remove()
		end
		table.remove(t, i)
	end
end

function FortressWar:loadParticipants()
   local index = 0
   
   for i in pairs(FortressWar.participants) do
		index = index + 1
	    local roomTable = FORTRESS_WAR_EVENT_CONFIG["Rooms"][index]
		if roomTable then
		   local positionTable = roomTable["Mini Boss"]
		   if positionTable then
			  local x = positionTable.PlayersPosition[1]
			  local y = positionTable.PlayersPosition[2]
			  local z = positionTable.PlayersPosition[3]
			  local position = Position(x, y, z)
		      if position then
				 FortressWar:teleportTeam(index, position)
			  end
			end
		end
    end
end	
       
function FortressWar:getTeamTable(id)
    
	if not id then
	   return nil
	end
	
    local t = FortressWar.participants
	if not t then
	   return false
	end
	
	local teamTable = FortressWar.participants["Team " .. id]
	if teamTable then
	   return teamTable
	end
	
	return false
end

function FortressWar:getTeamsCount()

    local t = FortressWar.participants
	if not t then
	   return 0
	end
	
	local count = tablelength(t)
    if not count then
	   return 0
	end
	
	return count
end

function FortressWar:teleportTeam(id, position)
    
	if not id or not position then
	   return nil
	end
	
	local t = FortressWar:getTeamTable(id)
	if not t then
	   return false
	end
	
	for i, v in pairs(t) do		
	    local player = Player(v["Player Id"])
		if player then
		   player:teleportTo(position)
		end
	end
	
	return true
end

function FortressWar:setStorageTeam(id, value)
    
	if not id or not value then
	   return nil
	end
	
	local t = FortressWar:getTeamTable(id)
	if not t then
	   return false
	end
	
	for i, v in pairs(t) do		
	    local player = Player(v["Player Id"])
		if player then
		   player:setStorageValue(FortressWar.storageTeamID, value)
		end
	end
	
	return true
end

function FortressWar:onMiniBossDeath(id)

    if not id then
	   return nil
	end
	
	local t = FORTRESS_WAR_EVENT_CONFIG["Mini Boss"]
	local x = t.teleportTo[1]
	local y = t.teleportTo[2]
	local z = t.teleportTo[3]
	local position = Position(x, y, z)
	
	if not position then
	   return nil
	end
	FortressWar:teleportTeam(id, position)
	
	local index = 0
	for i in pairs(FortressWar.participants) do
		index = index + 1
	    if index ~= id then
	       local roomTable = FORTRESS_WAR_EVENT_CONFIG["Rooms"][index]
		   if roomTable then
		      local positionTable = roomTable["Mini Boss"]
			  if positionTable then
			     x = positionTable.DestinationPosition[1]
				 y = positionTable.DestinationPosition[2]
				 z = positionTable.DestinationPosition[3]
			     position = Position(x, y, z)
				 if position then
				    FortressWar:teleportTeam(index, position)
			     end
			  end
		   end
		end
    end
	
end

function FortressWar:onPlayerRemoved(player)
    
	if not player then
	   return nil
	end
	
	local id = FortressWar:getWinnersGuildID()
	local winners = FortressWar:getTeamTable(id)
	if winners then
	   local guildName = nil
	   for index, v in pairs(winners) do
	       local player = Player(v["Player Id"])
		   if player then
		      if not guildName then
			     guildName = FortressWar:getGuildName(player)
				 if guildName then
				    Game.broadcastMessage("[Fortress War] " .. " Guild " .. guildName .. " won the event and now they are owners of guild house.", MESSAGE_STATUS_WARNING)
				    local guid = FortressWar:getLeaderGUID(guildName)
					if guid then
					   FortressWar:setGuildHouse(guid)
					end
				    break
			     end
		      end
		   end 
	   end
	   
	   local t = FORTRESS_WAR_EVENT_CONFIG["Main Boss"]
	   local x = t.PlayersPosition[1]
	   local y = t.PlayersPosition[2]
	   local z = t.PlayersPosition[3]
	   local pos = Position(x, y, z)
	   FortressWar:loadMainBoss()
	   FortressWar:teleportTeam(id, pos)
	   FortressWar:addGuildMembers(id)
	   FortressWar:setStorageTeam(id, -1)
	   FortressWar.participants = {}
	end

	return true
end

function FortressWar:getWinnersGuildID()

   local t = FortressWar.participants
   if not t then
      return false
   end
   
   local isActive = FortressWar.isActive
   if not isActive then
      return false
   end
   
   local length = tablelength(t)
   if length == 1 then
      for teamName in pairs(t) do
	      local id = teamName:gsub("%D+", "")
		  FortressWar.isActive = false
	      return id
	  end
   end

   
   return false
end

function FortressWar:getGuildName(player)
    
	if not player then
	   return nil
	end

	local guild = player:getGuild()
	if guild then
	   return guild:getName()
	end
	
	return false
end

function FortressWar:sendMessage(type, text)
    
	if not type or not text then
	   return nil
	end
	
	if not FortressWar.participants then
	   return false
	end

    for i, teamTable in pairs(FortressWar.participants) do
		for index, v in pairs(teamTable) do
	        local player = Player(v["Player Id"])
		    if player then
		       player:sendTextMessage(type, "[Fortress War] " .. text)
		    end
	    end
	end	    
	
	return true
end

function FortressWar:getGuildHouse()
    
	local t = FORTRESS_WAR_EVENT_CONFIG["Guild House"].position
	local x = t[1]
	local y = t[2]
	local z = t[3]
	local pos = Position(x, y, z)
	if pos then
	   local tile = Tile(pos)
	   if tile then
	      local house = tile:getHouse()
		  if house then
		     return house
		  end
	    end
    end
	
	return false
end

function FortressWar:setGuildHouse(guid)
    
	if not guid then
	   return nil
	end
	
	local house = FortressWar:getGuildHouse()
	if not house then
	   return false
	end
    
	local id = 0x100
	local list = ""
    house:setAccessList(id, list)
	house:setOwnerGuid(guid)
	
    return true
end

function FortressWar:getLeaderGUID(guildName) 	
	local resultId = db.storeQuery("SELECT `ownerid` FROM `guilds` WHERE `name` = " .. db.escapeString(guildName))
	if resultId ~= false then
		local leaderGuid = result.getNumber(resultId, "ownerid")
		result.free(resultId)
		return leaderGuid
	end
	return nil
end

function FortressWar:addGuildMember(player)
    
	if not player then
	   return nil
	end
	
	local guildName = FortressWar:getGuildName(player)
	if not guildName then
	   return false
	end
	
	local guid = player:getGuid()
	local leaderGuid = FortressWar:getLeaderGUID(guildName)
	
	if guid == leaderGuid then
	   return false
	end

    local house = FortressWar:getGuildHouse() 
	if house then
	   local id = 0x100
	   local name = player:getName()
	   local list = house:getAccessList(id)
	   if string.find(list, name) then
	      return false
	   end
	   if list == "" then
	      list = name
	   else
	      list = list .. "\n" .. name
	   end
       house:setAccessList(id, list)
	end
end

function FortressWar:addGuildMembers(id)

	if not id then
	   return nil
	end
	
	local t = FortressWar:getTeamTable(id)
	if not t then
	   return false
	end
	
	for i, v in pairs(t) do		
	    local player = Player(v["Player Id"])
		if player then
		   FortressWar:addGuildMember(player)
		end
	end
	
	return true
end

function FortressWar:isWinner(player)
    	
	local guildName = FortressWar:getGuildName(player)
	if not guildName then
	   return false
	end
	
    local house = FortressWar:getGuildHouse()
	if not house then
	   return false
	end
	
    local ownerGuid = house:getOwnerGuid()
	local leaderGuid = FortressWar:getLeaderGUID(guildName)
	
	if ownerGuid == leaderGuid then
	   return true
	end
	
	return false
end

function FortressWar:loadNPC()
   
   local t = FORTRESS_WAR_EVENT_CONFIG["Spawn NPC"]
   if not t then
      return nil
   end
   
   local positionTable = t["Positions"]
   if not positionTable then
      return nil
   end
   
   for i, v in pairs(positionTable) do
       local x = v[1]
	   local y = v[2]
	   local z = v[3]
	   local pos = Position(x, y, z)
	   if pos then
	      local name = t.name
	      Game.createNpc(name, pos)
	   end
    end
end

function FortressWar:loadTiles()
    
	local t = FORTRESS_WAR_EVENT_CONFIG["Daily Boss"]
	if not t then 
	   return false
	end
	
	local positionTable = t.EntracePosition
	local x = positionTable[1]
	local y = positionTable[2]
	local z = positionTable[3]
	local pos = Position(x, y, z)
	if pos then
	   local tile = Tile(pos)
	   if tile then
	      local ground = tile:getGround()
		  if ground then
		     ground:setAttribute(ITEM_ATTRIBUTE_ACTIONID, FortressWar.aid + 1)
		  end
	   end
	end
end

function FortressWar:isDailyBoss()

	local t = FortressWar.dailyboss
	if not t then
	   return false
	end
	
	for i, id in pairs(t) do
	    local boss = Monster(id)
		if boss then
		   return true
		end
	end
	
	return false
end

function FortressWar:canSpawnDailyBoss()
    
	if FortressWar.SpawnDailyBoss == nil then
	   return nil
	end
	
	if FortressWar.SpawnDailyBoss == false then
	   return false
	end
	
	return true
end

function FortressWar:canRunEvent()
    
	if FortressWar.isRunning == nil then
	   return nil
	end
	
	if FortressWar.isRunning == false then
	   return false
	end
	
	return true
end

function FortressWar:shouldSpawnDailyBoss()
    
	local t = FORTRESS_WAR_EVENT_CONFIG["Daily Boss"]["Scheduler"]
	if not t then
	   return nil
	end
	

    local _canSpawn = FortressWar:canSpawnDailyBoss()
	
	if _canSpawn == nil then
	   FortressWar.SpawnDailyBoss = true
	end

	if _canSpawn == false then
	   return false
	end
	
	local currentDay = os.date("%A")
	local currentTime = os.date("%H:%M")
	for day, v in pairs(t) do
	    if day == currentDay or day == "Everyday" then
           for i, timeSchedule in pairs(v) do
		       if timeSchedule == currentTime then
				  return true
			   end
		   end
		end
    end
	
	return false
end

function FortressWar:shouldLoadEvent()

	local t = FORTRESS_WAR_EVENT_CONFIG["Scheduler"]
	if not t then
	   return nil
	end
	
	local _isRunning = FortressWar:canRunEvent()
	
	if _isRunning == nil then
	   FortressWar.SpawnDailyBoss = true
	end

	if _isRunning == false then
	   return false
	end
	
	local currentDay = os.date("%A")
	local currentTime = os.date("%H:%M")
	for day, v in pairs(t) do
	    if day == currentDay or day == "Everyday" then
           for i, timeSchedule in pairs(v) do
		       if timeSchedule == currentTime then
                  print(timeSchedule)
				  return true
			   end
		   end
		end
    end
   
end
    
function FortressWar:prepare(_developerMode, _shortMode)
    
	FortressWar.participants = {}
	local second = 1000
	local hour = second * 3600
	local minute = second * 60
	
	if _shortMode then
	   minute = second * 6
	end
	   
	if _developerMode then
	   print("[Fortress War] - Activated from command.")	
	   Game.broadcastMessage("[Fortress War] will start in 3 minutes.", MESSAGE_EVENT_ADVANCE)
	   
	   local interval = 1 * minute
	   addEvent(function()
       Game.broadcastMessage("[Fortress War] will start in 2 minutes. Guild Leaders can register now.", MESSAGE_EVENT_ADVANCE)
	   FortressWar:createTeleport()
       end, interval)
	
	   interval = interval + 1 * minute
	   addEvent(function()
          Game.broadcastMessage("[Fortress War] will start in 1 minutes. Guild Leaders can register now.", MESSAGE_EVENT_ADVANCE)
	      FortressWar:createTeleport()
       end, interval)
	   
	   if _shortMode then
	      interval = interval + 30 * 1000
		  else
		  interval = interval + 5 * second
	   end
	   addEvent(function()
	      FortressWar:insertPlayersToTable()
	      if FortressWar:getTeamsCount() < 2 then
		     FortressWar:kickLeaders()
	         Game.broadcastMessage("[Fortress War] event is canceled, not enough participants.", MESSAGE_EVENT_ADVANCE)
	      else
	         FortressWar:loadMiniBosses()
	         FortressWar:loadParticipants()
			 FortressWar.isActive = true
             Game.broadcastMessage("[Fortress War] has begun! Good luck.", MESSAGE_EVENT_ADVANCE)
	      end
		  FortressWar:removeTeleport()
       end, interval)
	   return true
	end
	
	FortressWar.isRunning = false
	 addEvent(function()
		FortressWar.isRunning = true
    end, 1 * 1000 * 60)

	Game.broadcastMessage("[Fortress War] will start in 2 hours.", MESSAGE_EVENT_ADVANCE)
	
	local interval = 1 * hour
	addEvent(function()
       Game.broadcastMessage("[Fortress War] will start in 1 hour.", MESSAGE_EVENT_ADVANCE)
    end, 1 * interval)
	
	interval = interval + 45 * minute
	addEvent(function()
       Game.broadcastMessage("[Fortress War] will start in 45 minutes.", MESSAGE_EVENT_ADVANCE)
    end, interval)
	
	interval = interval + 30 * minute
	addEvent(function()
       Game.broadcastMessage("[Fortress War] will start in 30 minutes.", MESSAGE_EVENT_ADVANCE)
    end, interval)

	interval = interval + 15 * minute
	addEvent(function()
       Game.broadcastMessage("[Fortress War] will start in 15 minutes.", MESSAGE_EVENT_ADVANCE)
    end, interval)
	
	interval = interval + 10 * minute
	addEvent(function()
       Game.broadcastMessage("[Fortress War] will start in 10 minutes.", MESSAGE_EVENT_ADVANCE)
    end, interval)
	
	interval = interval + 5 * minute
	addEvent(function()
       Game.broadcastMessage("[Fortress War] will start in 5 minutes. Guild Leaders can register now.", MESSAGE_EVENT_ADVANCE)
	   FortressWar:createTeleport()
    end, interval)
	
	interval = interval + 3 * minute
	addEvent(function()
       Game.broadcastMessage("[Fortress War] will start in 3 minutes. Guild Leaders can register now.", MESSAGE_EVENT_ADVANCE)
    end, interval)
	
	interval = interval + 1 * minute
	addEvent(function()
       Game.broadcastMessage("[Fortress War] will start in 1 minutes. Guild Leaders can register now.", MESSAGE_EVENT_ADVANCE)
    end, interval)
	
	interval = interval + 5 * second
	addEvent(function()
	   FortressWar:insertPlayersToTable()
	   if FortressWar:getTeamsCount() < 2 then
	      FortressWar:kickLeaders()
	      Game.broadcastMessage("[Fortress War] event is canceled, not enough participants.", MESSAGE_EVENT_ADVANCE)
	   else
	      FortressWar:loadMiniBosses()
	      FortressWar:loadParticipants()
		  FortressWar.isActive = true
          Game.broadcastMessage("[Fortress War] has begun! Good luck.", MESSAGE_EVENT_ADVANCE)
	   end
	   FortressWar:removeTeleport()
    end, interval)
	
end

function FortressWar:getIslandPosition()

    local t = FORTRESS_WAR_EVENT_CONFIG["Island"].position
	
	if not t then
	   return false
	end
	
	local x = t[1]
	local y = t[2]
	local z = t[3]
	local pos = Position(x, y, z)
	return pos
end

function FortressWar:loadDailyChest()
    
	local t = FORTRESS_WAR_EVENT_CONFIG["Daily Chest"]
	if not t then
	   return false
	end
	
	local positionTable = t.position
	if positionTable then
	   local x = positionTable[1]
	   local y = positionTable[2]
	   local z = positionTable[3]
	   local pos = Position(x, y, z)
	   if pos then
	      local id = t.itemid
	      local chest = Game.createItem(id, 1, pos)
		  if chest then
		     chest:setAttribute(ITEM_ATTRIBUTE_ACTIONID, FortressWar.aid + 3)
		  end
	   end
	end
end

function FortressWar:getDailyChestDate(player)
   local time_string = ""
   local cooldown = player:getStorageValue(FortressWar.storageTeamID + 1)
   if not cooldown then
      cooldown = 0
   end
   local time_left = cooldown - os.time()
   local hours = string.format("%02.f", math.floor(time_left / 3600))
   local mins = string.format("%02.f", math.floor(time_left / 60 - (hours * 60)))
   local secs = string.format("%02.f", math.floor(time_left  - hours * 3600 - mins * 60))

  if hours == "00" then
     time_string = mins .. " Minutes" .. " and " .. secs .. " Seconds" .. "."
  else
     time_string = hours .. " Hours" .. ", " .. mins .. " Minutes" .. " and " .. secs .. " Seconds" .. "."
  end
 
return time_string
end

function FortressWar:setDailyChestCooldown(player)
    
	if not player then
	   return nil
	end
	
	return player:setStorageValue(FortressWar.storageTeamID + 1, os.time() + 24 * 3600)
end

function FortressWar:hasDailyChestCooldown(player)
    
	if not player then
	   return nil
	end
	
	local cooldown = player:getStorageValue(FortressWar.storageTeamID + 1)
	if cooldown >= os.time() then
	   return true
	end
	
	return false
end

function FortressWar:addDailyChestReward(player)
    
	if not player then
	   return nil
	end
	
	if not FortressWar:isWinner(player) then
	   player:sendTextMessage(MESSAGE_STATUS_WARNING, "Only winners from team fortress war can open this chest.")
	   player:sendCancelMessage("Only winners from team fortress war can open this chest.")
	return true
	end

	local cooldown = FortressWar:hasDailyChestCooldown(player)
	if cooldown then
	   player:sendTextMessage(MESSAGE_STATUS_WARNING, "You have to wait: " .. FortressWar:getDailyChestDate(player) .. " to obtain again daily reward.")
	   player:sendCancelMessage("You have to wait: " .. FortressWar:getDailyChestDate(player) .. " to obtain again daily reward.")
	   return false
    end
	
	local currentDay = os.date("%A")
	
	local t = FORTRESS_WAR_EVENT_CONFIG["Daily Chest"]["Rewards"]
	if not t then
	   return false
	end
	
	local dayTable = t[currentDay]
	if not dayTable then
	   return false
	end
	
	local number = math.random(1, #dayTable)
	local rewardTable = dayTable[number]
	if not rewardTable then
	   return false
	end
		
	local str = "You have received "
	
	for i, itemTable in pairs(rewardTable) do
	    local id = itemTable.itemid
		local count = itemTable.count
		player:addItem(id, count)
		if i == #rewardTable then
		   if #rewardTable > 1 then
		      str = str .. count .. "x " .. getItemName(id) .. "."
		   else
		      str = str .. count .. "x " .. getItemName(id) .. "."
		   end
		else
		   str = str .. count .. "x " .. getItemName(id) .. ", "
		end
    end
	FortressWar:setDailyChestCooldown(player)
	player:sendTextMessage(MESSAGE_INFO_DESCR, str)
	return true
end
	
function FortressWar:sendTextOnPosition(message, position, effect)
    local spectators = Game.getSpectators(position, false, false, 7, 7, 5, 5)

    if #spectators > 0 then
        if message then
            for i = 1, #spectators do
                spectators[i]:say(message, TALKTYPE_MONSTER_SAY, false, spectators[i], position)
            end
        end

        if effect then
            position:sendMagicEffect(effect)
        end
    end

    return true
end

function FortressWar:blockMoveItem(item)
    
	if not item then 
	   return nil
	end
	
	local aid = item:getAttribute(ITEM_ATTRIBUTE_ACTIONID)
	if not aid then
	   return false
	end
	
	if aid ~= FortressWar.aid + 3 then
	   return false
	end
	
	return true
end
local globalevent = GlobalEvent("FortressWar_onStartup")

function globalevent.onStartup()
	FortressWar:loadNPC()
	FortressWar:loadTiles()
	FortressWar:loadDailyChest()
end
globalevent:register()

globalevent = GlobalEvent("FortressWar_Scheduler")
function globalevent.onThink(interval, lastExecution)
    
	if FortressWar:shouldSpawnDailyBoss() then
	   if not FortressWar:isDailyBoss() then
	      FortressWar:loadDailyBoss()
	   end
	end

	if FortressWar:shouldLoadEvent() then
	      FortressWar:prepare()
	end
	
	local t = FORTRESS_WAR_EVENT_CONFIG["Daily Chest"]
	if not t then
	   return false
	end
	
	local positionTable = t.position
	if positionTable then
	   local x = positionTable[1]
	   local y = positionTable[2]
	   local z = positionTable[3]
	   local pos = Position(x, y, z)	
	   FortressWar:sendTextOnPosition("Daily Chest for winners" .. "\n" .. "Fortress War event.", pos)
	end
	
	return true
end
globalevent:interval(5000)
globalevent:register()

creaturescript = CreatureEvent("FortressWar_onDeath")
function creaturescript.onDeath(creature, corpse, killer, mostDamage, unjustified, mostDamage_unjustified)

    local player = Player(creature)
    if player then
	   if FortressWar:kickPlayer(player) then
	      FortressWar:onPlayerRemoved(player)
	   end
	   return true
    end
	
    local monster = Monster(creature)
    if monster then
      local player = Player(killer)
      if player then
         local id = FortressWar:getTeamID(player)
	     FortressWar:onMiniBossDeath(id)
      end
      FortressWar:removeMiniBosses()
	  return true
    end
   
    return true
end
creaturescript:register()

local logout = CreatureEvent("FortressWar_onLogout")
function logout.onLogout(player)
   local town = player:getTown()
   local id = town:getId()
   if FortressWar:kickPlayer(player) then 
      FortressWar:onPlayerRemoved(player)
	  player:teleportTo(Town(id):getTemplePosition())
   elseif player:getStorageValue(FortressWar.storageTeamID) ~= -1 then
      player:setStorageValue(FortressWar.storageTeamID, -1)
	  player:teleportTo(Town(id):getTemplePosition())
   end
	  
   return true
end
logout:register()

local moveevent = MoveEvent()
moveevent:type("stepin")
function moveevent.onStepIn(creature, item, position, fromPosition)
    
	local player = Player(creature)
	if not player then
	   return true
	end
	
	if not FortressWar:isLeader(player) then
	   player:teleportTo(fromPosition)
	   player:sendTextMessage(MESSAGE_STATUS_WARNING, "Only Guild Leader can access this teleport.")
	   return true
	end
	
	local minLevel = FORTRESS_WAR_EVENT_CONFIG.minLevel
	if player:getLevel() < minLevel then
	   player:teleportTo(fromPosition)
	   player:sendTextMessage(MESSAGE_STATUS_WARNING, "You need to be atleast " .. minLevel .. " level to access this teleport.")
	   return true
	end
	
	local minMembers = FORTRESS_WAR_EVENT_CONFIG.minMembers
	local members = FortressWar:getMembersCount(player)
	
	if members < minMembers then
	   player:teleportTo(fromPosition)
	   player:sendTextMessage(MESSAGE_STATUS_WARNING, "You need to have atleast " .. minMembers .. " active players with " .. minLevel .. " level to access this teleport.")
	   return true
	end
	
	local TeamID = FortressWar:generateTeamID(player)
	--print("TEAM ID TO " .. TeamID)
	if not TeamID then
	   player:teleportTo(fromPosition)
	   player:sendTextMessage(MESSAGE_STATUS_WARNING, "The Fortress War Event is already full.")
	   return true
	end
	
	local id = FortressWar:getTeamID(player)
	local t = FORTRESS_WAR_EVENT_CONFIG["Rooms"][id]
	if t then
	   local x = t["Waiting Room"][1]
	   local y = t["Waiting Room"][2]
	   local z = t["Waiting Room"][3]
	   local pos = Position(x, y, z)
	   if pos then
	      if not FortressWar.leaders then
		     FortressWar.leaders = {}
	      end
	      player:teleportTo(pos)
		  table.insert(FortressWar.leaders, player:getId())
       end
	end
    
	return true
end
moveevent:aid(FortressWar.aid)
moveevent:register()

moveevent = MoveEvent()
moveevent:type("stepin")
function moveevent.onStepIn(creature, item, position, fromPosition)
    
	local player = Player(creature)
	if not player then
	   return true
	end
	
	if not FortressWar:isWinner(player) then
	   player:sendCancelMessage("Only winners from team fortress war can enter this place.")
	   player:teleportTo(fromPosition)
	   return true
	end
	
	if not FortressWar:isDailyBoss() then
	   player:sendCancelMessage("Boss is not spawned yet.")
	   player:teleportTo(fromPosition)
	   return true
	end
	
	local t = FORTRESS_WAR_EVENT_CONFIG["Daily Boss"]
	if not t then 
	   return true
	end
	
	local positionTable = t.DestinationPosition
	local x = positionTable[1]
	local y = positionTable[2]
	local z = positionTable[3]
	local pos = Position(x, y, z)
	if pos then
	   player:teleportTo(pos)
	end
    
	return true
end
moveevent:aid(FortressWar.aid + 1)
moveevent:register()

local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
  FortressWar:addDailyChestReward(player)
return true
end
action:aid(FortressWar.aid + 3)
action:register()

local talkaction = TalkAction("!startwar", "/startwar")
function talkaction.onSay(player, words, param)
	FortressWar:prepare(true, true)
    return false
end
talkaction:separator(" ")
talkaction:register()

talkaction = TalkAction("!setoutfit", "/setoutfit", "!outfit", "/outfit")
function talkaction.onSay(player, words, param)
	
	if not FortressWar:isLeader(player) then
	   player:sendCancelMessage("Only guild leader can use this command.")
	   return false
	end
	
	local outfit = player:getOutfit()
	local head = outfit.lookHead 
	local body = outfit.lookBody
	local legs = outfit.lookLegs
	local feet = outfit.lookFeet	
	
	local guild = player:getGuild()
	local onlineMembers = guild:getMembersOnline()
	for index, member in pairs(onlineMembers) do
	    local memberOutfit = member:getOutfit()
		local looktype = memberOutfit.lookType
	    local newOutfit = { ["lookType"] = looktype, ["lookHead"] = head, ["lookBody"] = body, ["lookLegs"] = legs, ["lookFeet"] = feet }
	    member:setOutfit(newOutfit)
    end
	
    return false
end
talkaction:separator(" ")
talkaction:register()