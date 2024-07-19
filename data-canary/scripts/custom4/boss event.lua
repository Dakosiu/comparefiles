bossEvent = { }
bossEvent.__newindex = bossEvent
bossEvent.storage = 4878743
bossEvent.aid = 64432		

local DEVELOPER_MODE = true

local prepare_interval_storage = 0
local prepare_interval = 0

function spairs(t, order)
    -- collect the keys
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end

    -- if order function given, sort by it by passing the table and keys a, b,
    -- otherwise just sort the keys 
    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end

    -- return the iterator function
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end

function Player.isBossEventParticipating()

    if not self then
	   return nil
	end
	
	if self:getStorageValue(bossEvent.storage) == 1 then
	   return true
	end
	
	return false
end

function Player.getEventPlace(self, t)
         
	if not self then
	   return nil
	end	 
	
	for i = 1, #bossEvent:getDamage(t) do
	    local id = bossEvent:getDamage(t)[i]["player_id"]
		if self:getId() == id then
		   return i
		end
    end

    return false
end	
		 

function bossEvent:createTeleport()

	for name, v in pairs(BOSS_EVENT_SYSTEM["Rooms"]) do
	    local teleportTable = v["Teleport"]
		if teleportTable then
		   local tile = Tile(teleportTable.position)
		   if tile then
		      local tp = tile:getItemById(teleportTable.id)
			  if tp then
			     tp:remove()
			  end
		         tp = Game.createItem(teleportTable.id, 1, teleportTable.position)
                 tp:setAttribute("aid", bossEvent.aid)
		         tp:setCustomAttribute("room", name)	
            end
        end
        
        teleportTable = v["Teleport Kick"]	
        if teleportTable then
		   local tile = Tile(teleportTable.position)
		   if tile then
		      local tp = tile:getItemById(teleportTable.id)
			  if tp then
			  tp:remove()
			  end
		         tp = Game.createItem(teleportTable.id, 1, teleportTable.position)
                 tp:setAttribute("aid", bossEvent.aid + 1)
		         tp:setCustomAttribute("room", name)	
            end
        end
		
	end
	
	return true
end

function bossEvent:removeTeleport()

	for name, v in pairs(BOSS_EVENT_SYSTEM["Rooms"]) do
	    local teleportTable = v["Teleport"]
		if teleportTable then
		   local tile = Tile(teleportTable.position)
		   if tile then
		      local tp = tile:getItemById(teleportTable.id)
			  if tp then
			     tp:remove()
			  end
            end
        end
        
        teleportTable = v["Teleport Kick"]	
        if teleportTable then
		   local tile = Tile(teleportTable.position)
		   if tile then
		      local tp = tile:getItemById(teleportTable.id)
			  if tp then
			  tp:remove()
			  end
            end
        end
		
	end
	
	return true
end

function bossEvent:getPlayerTable(t, key)
for i, value in pairs(t.creatures["Players"]) do 
    
	local playerTable = value[key] 
	if playerTable then
	   local array = { table = playerTable, index = i }
	   return array
	end
     
end
   return false
end

function bossEvent:getRequiredLevel(player)

   if not player then
      return nil
   end
   
   local minLevel = BOSS_EVENT_SYSTEM["Configuration"].requiredLevel
   if player:getLevel() < minLevel then
      return false
   end
   
   return true
end


	
function bossEvent:getVocationRoom(player)

  if not player then
  return
  end
  
  local t = nil
  local str = player:getVocation():getName():lower()
  
  if string.find(str, "knight") then
     t = BOSS_EVENT_SYSTEM["Rooms"]["Knight Room"]
  elseif string.find(str, "paladin") then
     t = BOSS_EVENT_SYSTEM["Rooms"]["Paladin Room"]
  elseif string.find(str, "druid") then
     t = BOSS_EVENT_SYSTEM["Rooms"]["Druid Room"]
  elseif string.find(str, "sorcerer") then
     t = BOSS_EVENT_SYSTEM["Rooms"]["Sorcerer Room"]
  end
  return t or false
end

function bossEvent:getDamage(t)

   if not t then
      return
   end
	
   local sortTable = { }
   local participants = { }
   
   for _, playersTable in pairs(t.creatures["Players"]) do
       for player_id, v in pairs(playersTable) do
           participants[player_id] = v.damage
       end
   end

   local index = 1
   for k,v in spairs(participants, function(t,a,b) return t[b] < t[a] end) do
          if v > 0 then
             local value = { ["damage"] = v , ["player_id"] = k }
		     table.insert(sortTable, value)
		  end
   end
	

	return sortTable
end

function bossEvent:prepare()
   
   local second = 0
   if DEVELOPER_MODE then
      second = 100
	  else
	  second = 1000
   end
   
   _enable = false
   
   bossEvent:createTeleport()
   
   for _, t in pairs(BOSS_EVENT_SYSTEM["Rooms"]) do
       t.activated = false
       t.canRegister = true
	   if not t.creatures then
	      t.creatures = { ["Players"] = {}, ["Boss"] = {} }
	   else	   
		  bossEvent:kickPlayers(t)
		  for _, v in pairs(t.creatures["Boss"]) do
		     local boss = Creature(v.id)
		     if boss then
		        boss:remove()
		     end
		  end
		  
		  local summons = t.creatures["Summons"]
		  if summons then
		     for _, v in pairs(summons) do
			    local summon = Monster(v)
				if summon then
				   summon:remove()
				end
		     end
		  end

       end
   end
   
   Game.broadcastMessage("[Boss Event] will start in 5 minutes.", MESSAGE_EVENT_ADVANCE)
   
   addEvent(function()
   Game.broadcastMessage("[Boss Event] will start in 3 minutes.", MESSAGE_EVENT_ADVANCE)
   end, 2 * second * 60)
   
   addEvent(function()
   Game.broadcastMessage("[Boss Event] will start in 2 minutes.", MESSAGE_EVENT_ADVANCE)
   end, 3 * second * 60)

   addEvent(function()
   Game.broadcastMessage("[Boss Event] will start in 1 minute.", MESSAGE_EVENT_ADVANCE)
   end, 4 * second * 60)
   
   addEvent(function()

   for name, t in pairs(BOSS_EVENT_SYSTEM["Rooms"]) do

	  local players = t.creatures["Players"]
      if #players >= t.minPlayers then
	      t.activated = true
		  _enable = true
      else
          Game.broadcastMessage("[Boss Event - " .. name .. "] will not start. There is not enough participants.", MESSAGE_EVENT_ADVANCE)
		  t.activated = false
		  t.canRegister = false
		  bossEvent:kickPlayers(t)
		  bossEvent:removeTeleport()
      end
   
   end
   
   if _enable then
      bossEvent:start()
	  bossEvent:timeout()
   end
   
   
   end, 5 * second * 60)
   
   
end

function bossEvent:getDate()
local storage = bossEvent.storage
local time_string = ""
local time_left = Game.getStorageValue(storage) - os.time()
local hours = string.format("%02.f", math.floor(time_left / 3600))
local mins = string.format("%02.f", math.floor(time_left / 60 - (hours * 60)))
local secs = string.format("%02.f", math.floor(time_left  - hours * 3600 - mins * 60))
--local time_string = hours ..":".. mins ..":".. secs

if hours == "00" then
time_string = mins .. " Minutes" .. " and " .. secs .. " Seconds" .. "."
else
time_string = hours .. " Hours" .. ", " .. mins .. " Minutes" .. " and " .. secs .. " Seconds" .. "."
end


return time_string
end

function bossEvent:start()
   

   for _, t in pairs(BOSS_EVENT_SYSTEM["Rooms"]) do
       if t.activated then
          --t.canRegister = false
	      local boss = Game.createMonster(t["Boss"].name, t["Boss"].position, false, true)
		  if boss then
		  boss:registerEvent("bossEvent_onHealthChange")
		  boss:registerEvent("bossEvent_Death")
		  local values = { ["id"] = boss:getId(), ["hpmax"] = boss:getMaxHealth() }
		  table.insert(t.creatures["Boss"], values)
		  else
		  -- print("[Boss Event - Can't create boss in " .. _ .. ".")
		  end
	   end
   end
   
   Game.broadcastMessage("[Boss Event] has begun, Good Luck!", MESSAGE_EVENT_ADVANCE)
   
   if DEVELOPER_MODE then
      -- print("[Event Boss]" .. " - " .. "Started Sucessfully.")
   end

end

function bossEvent:timeout()
	
	local _enable = false
	
	addEvent(function()
	for _, t in pairs(BOSS_EVENT_SYSTEM["Rooms"]) do
	   if t.activated then
	   _enable = true
	   end
	end
	
	if _enable then
	   bossEvent:finished(false, false, true)
	end
	end, 7 * 1000 * 60)
	
end

function bossEvent:joinPlayer(player, t)

     if not player or not t then
	    return
     end
     
	 if not bossEvent:getRequiredLevel(player) then
	    return true
     end
	 
	 if not t.canRegister then
	      player:sendCancelMessage("You can't join to this event right now.")
		  return true
	 end
	 
	 local id = player:getId()
	 if bossEvent:getPlayerTable(t, id) then
	      player:sendCancelMessage("You are already participating this event.")
		  return true
	 end
	 
	 player:teleportTo(t.destination)
	 player:setStorageValue(bossEvent.storage, 1)
	 player:registerEvent("bossEvent_Death")
	 bossEvent:displayDamage()
	 player:sendTextMessage(MESSAGE_INFO_DESCR, "You have joined to the boss event.")
	 
	 local value = { [id] = { damage = 0 } }
	 table.insert(t.creatures["Players"], value)
	 
	 if DEVELOPER_MODE then
	    -- print("[Event Boss]" .. " - " .. "Player: " .. player:getName() .. " has been added to event.")
     end
	 
end

function bossEvent:kickPlayer(player, t, death)

     if not player or not t then
	    return
     end
	 
	 if not death then 
	    player:teleportTo(t.kickPos)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You have left the boss event.")
     end
	 
	 player:setStorageValue(bossEvent.storage, 0)
	 if DEVELOPER_MODE then
	    -- print("[Event Boss]" .. " - " .. "Player: " .. player:getName() .. " has been removed from participating storage.")
	 end
	 
	 local id = player:getId()
	 if bossEvent:getPlayerTable(t, id) then
	    local values = bossEvent:getPlayerTable(t, id)
		table.remove(t.creatures["Players"], values.index)
		-- if DEVELOPER_MODE then
		-- print("[Event Boss]" .. " - " .. "Player: " .. player:getName() .. " has been removed from table.")
		-- end
     end
	 
	 if t.activated then
	    if #t.creatures["Players"] <= 1 then
		   bossEvent:displayDamage()
	       bossEvent:finished(t, false, false)
		end
     end
	 
end

function bossEvent:kickPlayers(t)

         if not t then
		    return
		 end
		 
		 local players = t.creatures["Players"]
		 
		 while #players > 0 do
            for _, playerTable in pairs(players) do
		       for player_id, v in pairs(playerTable) do
                   local player = Player(player_id)
	               if player then
	                  bossEvent:kickPlayer(player, t)
                   end
			   end
            end
		 end
		 
		 return
end

function bossEvent:addRewards(t)
          
		  local values = bossEvent:getDamage(t)
		  local firstPlayer = nil
		  local secondPlayer = nil
		  local thirdPlayer = nil
		  
		  local firstPlace = values[1]
		  if firstPlace then 
		  firstPlayer = Player(firstPlace["player_id"])
		  end
		  
		  local secondPlace = values[2]
		  if secondPlace then 
		  secondPlayer = Player(secondPlace["player_id"])
		  end
		  
		  local thirdPlace = values[3]
		  if thirdPlace then 
		  thirdPlayer = Player(thirdPlace["player_id"])
		  end
		  
		  local rewardPlayer = nil
		  local rewardTable = nil
		  
		  for i = 1, #bossEvent:getDamage(t) do

		     if i == 1 then
			    rewardPlayer = firstPlayer
				rewardTable = "First Place"
		  	 elseif i == 2 then
		        rewardPlayer = secondPlayer
				rewardTable = "Second Place"
			 elseif i == 3 then
			    rewardPlayer = thirdPlayer 
				rewardTable = "Third Place"
			 elseif i > 3 then
			    local id = bossEvent:getDamage(t)[i]["player_id"]
				rewardPlayer = Player(id)
				rewardTable = "Normal"
		     end
			 

		      
		  if rewardPlayer then
		     local items = {}
			 local experience = 0
			 local points = 0
			 
			 local str = "You have received: "
			 
			 local backpack_obtained = false
			 local backpack_method = false
			 
		     for _, rewardTable in pairs(t.rewards[rewardTable]) do
			    if rewardTable.type == "experience" then
				   rewardPlayer:addExperience(rewardTable.value, true)
				   experience = experience + rewardTable.value
				elseif rewardTable.type == "points" then
				   rewardPlayer:setTournamentCoinsBalance(rewardPlayer:getTournamentCoinsBalance() + rewardTable.value)
				   points = points + rewardTable.value
				elseif rewardTable.type == "item" then
				   local canObtained = false
				   local chance = rewardTable.chance
				   
				   if chance then
				      local rnd = math.random(1, 100)
					  if rnd <= chance then
					  canObtained = true
					  end
					  else
					  canObtained = true
				   end
				   
				   local id = rewardTable.item_id
				   local count = rewardTable.count
				   if canObtained then
				         if t.rewards.backpack.enabled then
						    if not backpack_obtained then
							   backpack_obtained = rewardPlayer:addItem(t.rewards.backpack.backpack_id)
							   backpack_obtained:setAttribute("name", t.rewards.backpack.name)
							   backpack_obtained:setAttribute("description", t.rewards.backpack.description)
							end
							backpack_obtained:addItem(id, count)
				         else
				            rewardPlayer:addItem(id, count)
				         end
				   end
				   local values = { [id] = { ["Count"] = count } }
				   if canObtained then
				      table.insert(items, values)
				   end
				end
			 end
			 
			 if experience > 0 then
			    if #items == 0 and points == 0 then
			       str = str .. "Experience: " .. experience .. "."
				else
				   if #items > 0 then
				      str = str .. "Experience: " .. experience .. ", Items: "
				   elseif points > 0 then
				      str = str .. "Experience: " .. experience .. ", Points: "
				   end
				end
				else
				if #items > 0 then
				   str = str .. "Items: "
				elseif points > 0 then
				   str = str .. "Points: "
				end
			 end
			 
             local index = 1			 
			 for _, itemTable in pairs(items) do
				 
			     for id, v in pairs(itemTable) do
				     local count = v["Count"]
					 if index == #items then
					    if points == 0 then
						   str = str .. count .. "x " .. getItemName(id) .. "."
						   else
						   str = str .. count .. "x " .. getItemName(id) .. ", "
						end
						else
						   str = str .. count .. "x " .. getItemName(id) .. ", "
				     end
                     index = index + 1
				 end
			 end
			 
			 if points > 0 then
			    str = str .. "Points: " .. points .. "."
		     end

			 rewardPlayer:sendTextMessage(MESSAGE_STATUS_DEFAULT, str)
		  end
		  
		  end
		     

		  

		  return
end

function bossEvent:winnersMessage(t, single)

        if not t then 
	     return
	    end
		
		local name = ""
		
		for n, v in pairs(BOSS_EVENT_SYSTEM["Rooms"]) do
		    if v == t then
			name = n
	        break
			end
	    end
	  
	  	local values = bossEvent:getDamage(t)
		local firstPlayer = nil
		local secondPlayer = nil
		local thirdPlayer = nil
		  
		local firstPlace = values[1]
		if firstPlace then 
            firstPlayer = Player(firstPlace["player_id"])
		end
		  
		local secondPlace = values[2]
		if secondPlace then 
		   secondPlayer = Player(secondPlace["player_id"])
		end
		  
		local thirdPlace = values[3]
		if thirdPlace then 
		   thirdPlayer = Player(thirdPlace["player_id"])
		end
		
		if single and firstPlayer then
		   Game.broadcastMessage("[Boss Event - " .. name .. "]" .. " - " .. " has ended. Only Player " .. firstPlayer:getName() .. " is alive! " .. "Congratulations!")
		return
		end
		
		
		  if firstPlayer and secondPlayer and thirdPlayer then
		        Game.broadcastMessage("[Boss Event - " .. name .. "]" .. " - " .. " has ended. Boss was defeated. Congratulations!" .. "The Winners:" .. "\n" .. "[1] Place: " .. firstPlayer:getName() .. "\n" .. "[2] Place: " .. secondPlayer:getName() .. "\n" .. "[3] Place: " .. thirdPlayer:getName())
		  elseif firstPlayer and secondPlayer and not thirdPlayer then
		        Game.broadcastMessage("[Boss Event - " .. name .. "]" .. " - " .. " has ended. Boss was defeated. Congratulations!" .. "\n" .. "The Winners:" .. "\n" .. "[1] Place: " .. firstPlayer:getName() .. "\n" .. "[2] Place: " .. secondPlayer:getName())
		  elseif firstPlayer and not secondPlayer and not thirdPlayer then
		       Game.broadcastMessage("[Boss Event - " .. name .. "]" .. " - " .. " has ended. Boss was defeated. Congratulations!" .. "\n" .. "The Winners:" .. "\n" .. "[1] Place: " .. firstPlayer:getName())
          end
		
		
	return
end
		
function bossEvent:finished(t, bossKilled, timeout)

        if timeout then
		    for _, t in pairs(BOSS_EVENT_SYSTEM["Rooms"]) do
			   if t.activated then
	              local boss = Creature(t.creatures["Boss"][1].id)
				  removeFirst(t.creatures["Boss"], boss:getId())
				  bossEvent:displayDamage()
				  if boss then
				  boss:remove()
				  end
			      t.activated = false
				  bossEvent:winnersMessage(t, false)
                  bossEvent:addRewards(t)
                  bossEvent:kickPlayers(t)	
                  bossEvent:removeTeleport()				  
			   end
			end
			
			return
	    end
		
		
		if not t then
	       return
	    end
		
		t.activated = false

		if bossKilled then
		   bossEvent:displayDamage()
           bossEvent:winnersMessage(t, false)
		   bossEvent:addRewards(t)
		   bossEvent:kickPlayers(t)
		   bossEvent:removeTeleport()
		   t.activated = false
		  return
		end   
		bossEvent:displayDamage()
		bossEvent:winnersMessage(t, true)
		bossEvent:addRewards(t)
		bossEvent:kickPlayers(t)
		bossEvent:removeTeleport()
		t.activated = false
		return
end

function bossEvent:logout(player)

    if not player then
	   return false
	end
	
	if player:getStorageValue(bossEvent.storage) == 1 then
       local t = bossEvent:getVocationRoom(player)
       bossEvent:kickPlayer(player, t)
	
	   if t.activated then
	      if #t.creatures["Players"] <= 1 then
	      bossEvent:finished(t, false, false)
	      end
	   end
    end
	
	
	
	return true
end

function bossEvent:death(creature, corpse, killer, mostDamage, unjustified, mostDamage_unjustified)
 
 if not creature then
    return false
 end
 
 local player = Player(creature) 
 
 if player then
    if player:getStorageValue(bossEvent.storage) == 1 then
       local t = bossEvent:getVocationRoom(player)
       bossEvent:kickPlayer(player, t)
	   
	   if t.activated then
	      if #t.creatures["Players"] <= 1 then
		  bossEvent:displayDamage()
	      bossEvent:finished(t, false, false)
	      end
	   end
    end
	return true
  end
  
  local monster = Monster(creature)
  
  if monster then
     if killer and killer:isPlayer() then
	    if killer:getStorageValue(bossEvent.storage) == 1 then
		   local t = bossEvent:getVocationRoom(killer)
		   if t.activated then
		       bossEvent:displayDamage()
		       bossEvent:finished(t, true, false)
		   end
		end
     end
	 return true
   end

return true
end

function bossEvent:displayDamage()
	local players = Game.getPlayers()
	
	for _, player in pairs(players) do
	
	if player:getStorageValue(bossEvent.storage) == 1 then
	    player:openChannel(13)
	    local id = player:getId()
		local t = bossEvent:getVocationRoom(player)
	    local v = bossEvent:getPlayerTable(t, id)
		
		if not t.activated then
		   return true
		end
		
		
		if v then  
	        local getDamage = v.table.damage
			if getDamage then
			player:openChannel(13)
				   local values = bossEvent:getDamage(t)
	   
	   if values then
	      
		  msgtype = nil
		  
		  if player:getStorageValue(bossEvent.storage + 1) <= 1 then
		     msgtype = TALKTYPE_CHANNEL_O
			 else
			 msgtype = TALKTYPE_CHANNEL_Y
		  end
	      
	      player:openChannel(13)
		  local firstPlayer = nil
		  local secondPlayer = nil
		  local thirdPlayer = nil
		  
		  local firstPlace = values[1]
		  if firstPlace then 
		  player:openChannel(13)
		  player:sendChannelMessage("[Boss Event]", "--------------------------------------------------------------------------------------------------", TALKTYPE_CHANNEL_R1, 13)	
		  firstPlayer = Player(firstPlace["player_id"])
		  if firstPlayer then
		       local bossTable = t.creatures["Boss"][1]
			   if bossTable then  
				  local hp = t.creatures["Boss"][1].hpmax
                  local maxhp = t.creatures["Boss"][1].hpmax
                  local hppc = 0
                  local damage = firstPlace["damage"]
                  hp = hp - damage
                  hppc = math.ceil(hp * 100 / maxhp)
				  local dealtPercentage = 100 - hppc
				  if dealtPercentage > 100 then
				     dealtPercentage = 100
			      end
		          player:sendChannelMessage("[Boss Event]", "[1] Place player: " .. firstPlayer:getName() .. ", Damage Dealt: " .. damage .. "[" .. dealtPercentage .. "%" .. "]" .. " of total health. " .. "to Boss.", msgtype, 13)	
               end			   
		  end
		  end
		  
		  local secondPlace = values[2]
		  if secondPlace then 
		  secondPlayer = Player(secondPlace["player_id"])
		  if secondPlayer then
		       local bossTable = t.creatures["Boss"][1]
			   if bossTable then  
				  local hp = t.creatures["Boss"][1].hpmax
                  local maxhp = t.creatures["Boss"][1].hpmax
                  local hppc = 0
                  local damage = secondPlace["damage"]
                  hp = hp - damage
                  hppc = math.ceil(hp * 100 / maxhp)
				  local dealtPercentage = 100 - hppc
				  if dealtPercentage > 100 then
				     dealtPercentage = 100
			      end
		          player:sendChannelMessage("[Boss Event]", "[2] Place player: " .. secondPlayer:getName() .. ", Damage Dealt: " .. damage .. "[" .. dealtPercentage .. "%" .. "]" .. " of total health. " .. "to Boss.", msgtype, 13)	
               end			   
		  end
		  end
		  
		  local thirdPlace = values[3]
		  if thirdPlace then 
		  thirdPlayer = Player(thirdPlace["player_id"])
		  if thirdPlayer then
		       local bossTable = t.creatures["Boss"][1]
			   if bossTable then  
				  local hp = t.creatures["Boss"][1].hpmax
                  local maxhp = t.creatures["Boss"][1].hpmax
                  local hppc = 0
                  local damage = thirdPlace["damage"]
                  hp = hp - damage
                  hppc = math.ceil(hp * 100 / maxhp)
				  local dealtPercentage = 100 - hppc
				  if dealtPercentage > 100 then
				     dealtPercentage = 100
			      end
		          player:sendChannelMessage("[Boss Event]", "[3] Place player: " .. thirdPlayer:getName() .. ", Damage Dealt: " .. damage .. "[" .. dealtPercentage .. "%" .. "]" .. " of total health. " .. "to Boss.", msgtype, 13)	
               end			   
		  end
		  end
		    local id = player:getEventPlace(t)
		    if firstPlace and firstPlayer and firstPlayer == player then 
		       player:sendChannelMessage("[Boss Event]", "You have [1] Place in damage deal to Boss. Congratulations!", msgtype, 13)
			   elseif secondPlace and secondPlayer and secondPlayer == player then 
			          player:sendChannelMessage("[Boss Event]", "You have [2] Place in damage deal to Boss. Congratulations!", msgtype, 13)
			   elseif thirdPlace and thirdPlayer and thirdPlayer == player then 
			          player:sendChannelMessage("[Boss Event]", "You have [3] Place in damage deal to Boss. Congratulations!", msgtype, 13)
			   elseif id and id > 3 then
			          player:sendChannelMessage("[Boss Event]", "You have " .. "[" .. id .. "]" .. " Place in damage deal to Boss. Try harder..", msgtype, 13)
			end	
			if getDamage > 0 then  
				  local hp = t.creatures["Boss"][1].hpmax
                  local maxhp = t.creatures["Boss"][1].hpmax
                  local hppc = 0
                  local damage = getDamage
                  hp = hp - getDamage
                  hppc = math.ceil(hp * 100 / maxhp)
				  local dealtPercentage = 100 - hppc
				  if dealtPercentage > 100 then
				     dealtPercentage = 100
			      end
				  
			   player:sendChannelMessage("[Boss Event]", "You have dealt " ..  damage .. "[" .. dealtPercentage .. "%" .. "]" .. " of total health. " .. "to Boss.", msgtype, 13)
			   
			   else 
			   if firstPlace then
			      player:sendChannelMessage("[Boss Event]", "You have no deal any dmg to Boss.", msgtype, 13)
			   end
			end
			
			   if player:getStorageValue(bossEvent.storage + 1) <= 1 then
			      player:setStorageValue(bossEvent.storage + 1, 2)
			   else
			     player:setStorageValue(bossEvent.storage + 1, 1)
			   end
			end
	    end
		
		end
	   
	end
	
	end
	
	return
end

function bossEvent:regenerateHealth(t, percent)
    if not t then
	return nil
	end
	
	local boss = Creature(t.creatures["Boss"][1].id)
	if boss then
	   local maxhp = boss:getMaxHealth()
	   local value = maxhp * (percent / 100)
	   boss:addHealth(value)
	   boss:say("Arghhh... You can't beat me!")
	   return true
	end
return false
end

local talk = TalkAction("/bossevent")
function talk.onSay(player, words, param)
		
	if not player:getGroup():getAccess() then
		return true
	end

	if player:getAccountType() < ACCOUNT_TYPE_GOD then
		return false
	end
    
	bossEvent:prepare()
    player:getPosition():sendMagicEffect(30)
	
    return true

end
talk:separator(" ")
talk:register()

local talk2 = TalkAction("!join")
function talk2.onSay(player, words, param)

    player:getPosition():sendMagicEffect(10)
	local t = bossEvent:getVocationRoom(player)
	

	if t then
	   bossEvent:joinPlayer(player, t)
	end
	
    return true

end
talk2:separator(" ")
talk2:register()



local logout = CreatureEvent("bossEvent_Logout")
function logout.onLogout(player)
   bossEvent:logout(player)
   return true
end
logout:register()

local death = CreatureEvent("bossEvent_Death")
function death.onDeath(creature, corpse, killer, mostDamage, unjustified, mostDamage_unjustified)
   bossEvent:death(creature, corpse, killer, mostDamage, unjustified, mostDamage_unjustified)
   return true
end
death:register()

local healthchange = CreatureEvent("bossEvent_onHealthChange")
function healthchange.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)

	   local player = Player(attacker)
	   
	   if not player then
	      return primaryDamage, primaryType, secondaryDamage, secondaryType
	   end
	   
	   local finalDamage = primaryDamage + secondaryDamage 
	   if finalDamage < 0 then
	      finalDamage = (finalDamage * -1)
	   end

	   local id = player:getId()
	   local t = bossEvent:getVocationRoom(player)
	   local v = bossEvent:getPlayerTable(t, id)
	   
	   if v then  
	        local getDamage = v.table.damage
			v.table.damage = getDamage + finalDamage
	   end
	   
	return primaryDamage, primaryType, secondaryDamage, secondaryType
end
healthchange:register()

if DEVELOPER_MODE then
     -- print("Developer_Mode is enabled.")
	 -- print("[Event Boss]" .. " - " .. "set start next event to 3 minutes.")
	 -- print("[Event Boss]" .. " - " .. "prepare event set to few seconds")
	 prepare_interval_storage = 3 * 60
	 prepare_interval = prepare_interval_storage * 1000
	 Game.setStorageValue(bossEvent.storage, os.time() + prepare_interval_storage)
	 else
	 prepare_interval_storage = BOSS_EVENT_SYSTEM["Configuration"].time * 3600
     prepare_interval = prepare_interval_storage * 1000
	 Game.setStorageValue(bossEvent.storage, os.time() + prepare_interval_storage)
end

local globalevent = GlobalEvent("eventBoss_sendDamage")
function globalevent.onThink(interval, lastExecution)
    bossEvent:displayDamage()
	return true
end
globalevent:interval(20000)
globalevent:register()

globalevent = GlobalEvent("eventBoss_prepare")
function globalevent.onThink(interval, lastExecution)
	  bossEvent:prepare()
	  Game.setStorageValue(bossEvent.storage, os.time() + prepare_interval_storage)
	  return true
end
if not DEVELOPER_MODE then
globalevent:interval(prepare_interval)
globalevent:register()
end
	
local movevent = MoveEvent()
function movevent.onStepIn(creature, item, position, fromPosition)
    
	local player = Player(creature)
	if not player then
		return true
	end

	local t = bossEvent:getVocationRoom(player)
	
	local vocation = player:getVocation():getName():lower()
	local str = ""
	if string.find(vocation, "knight") then
	   str = "knight"
	elseif string.find(vocation, "paladin") then
	   str = "paladin"
	elseif string.find(vocation, "druid") then
	   str = "druid" 
	elseif string.find(vocation, "sorcerer") then
	   str = "sorcerer"
	end
	
	
	local room = item:getCustomAttribute("room"):lower()
	
	
    if item:getActionId() == bossEvent.aid then
       if not string.find(room, str) then
	      player:teleportTo(fromPosition)
	      player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You can't join to this room.")
	      return false
	   end
	   
	   local minLevel = BOSS_EVENT_SYSTEM["Configuration"].requiredLevel
	   if not bossEvent:getRequiredLevel(player) then
	      player:teleportTo(fromPosition)
		  player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need " .. minLevel .. " level to participate this event.")
		  return false
	   end
	   
	   bossEvent:joinPlayer(player, t)
	end
	
	if item:getActionId() == bossEvent.aid + 1 then
	   bossEvent:kickPlayer(player, t)
	end
	
	return true
end
movevent:aid(bossEvent.aid)
movevent:aid(bossEvent.aid + 1)
movevent:register()

