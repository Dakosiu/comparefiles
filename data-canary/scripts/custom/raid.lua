raid = { }
raid.__newindex = raid
			  
RAID_STORAGE_MONSTERS_TOWN = 4325257
RAID_STORAGE_MONSTERS_BOSS = RAID_STORAGE_MONSTERS_TOWN + 1
RAID_STORAGE_TIME_LEFT = 1725757
RAID_STORAGE_EVENT_STARTED = 1825748
RAID_LANTERN_ID = 27667
RAID_LANTERN_GREEN_ID = 27669
RAID_LANTERN_BLUE_ID = 27670
RAID_LANTERN_RED_ID = 27668

function raid:removeCreature(tbl, val)
  for i, v in ipairs(tbl) do
    if v == val then
      return table.remove(tbl, i)
    end
  end
end

function raid:prepareTables(name)

	local v = CITIES_TO_RAID[name].monsters
	
	if not v then
	return false
	end
	
	v = { 
	      ["Monsters"] = {},
		  ["Boss"] = {},
		  maxKill = 0,
		  Killed = 0,
	}
	
	if not tableHasKey(CITIES_TO_RAID[name].monsters, "Monsters") and not tableHasKey(CITIES_TO_RAID[name].monsters, "Boss") then
	   CITIES_TO_RAID[name].monsters = v
	end
end

function raid:timeleft(storage)
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

function tableHasKey(table,key)
    return table[key] ~= nil
end

function raid:start(index)

   local t = RAID_SYSTEM[index]
   
   if t == nil then
       print("[Raid System] - Can't find table..")
      return false
   end
   
   print("[Raid System] - Raid " .. t.raidName .. " started.")
   local cities = { }
   
   local number = 1
   

   
   addEvent(function()
   for i, v in pairs(CITIES_TO_RAID) do
       raid:prepareTables(i)
       raid:stop(i, number, false, false, true)
       if isInArray(t.avaibleCities, i) or isInArray(t.avaibleCities, "all") then
	      table.insert(cities, i)
          local x = 0
	      local y = 0
	      local z = 0
	      local count = 0
	      local pos = nil
		  
		  if t.monsters.boss and v.positionBoss then
		    local bossTable = v.positionBoss[math.random(1, #v.positionBoss)]
		     x = bossTable.x
	         y = bossTable.y
	         z = bossTable.z
	         pos = Position(x, y, z)
		     local monster = Game.createMonster(t.monsters.boss, pos, false, true)
			 
			 if monster then
			 monster:setTown(RAID_STORAGE_MONSTERS_TOWN, i)
			 monster:setStorageValue(RAID_STORAGE_MONSTERS_BOSS, 1)
			 monster:registerEvent("Raid_monsterDeath")
			 table.insert(v.monsters["Boss"], monster:getId())
			 end
			 
		  end
		  
		  
		  local monstersCount = t.monsters.monsterCount
		  local monstersSpawned = 0
		  local maxAttempts = 5000
		  local attempts = 0
		  
		  if not raid.badPositions then
		     raid.badPositions = {}
		  end
		  
		  if not raid.takenPositions then
		    raid.takenPositions = {}
	      end
		  
		  local posChangeAttempts = 0
		  
		  	 if not raid.badPositions[i] then
				raid.badPositions[i] = {}
			 end
			 
			 if not raid.takenPositions[i] then
				raid.takenPositions[i] = {}
			 end
					
		  while monstersSpawned < monstersCount and attempts < maxAttempts do
		    x = math.random(v.position.from_x, v.position.to_x)
			y = math.random(v.position.from_y, v.position.to_y)
			z = v.position.z
		    pos = Position(x, y, z)
			
			while isInArray(raid.badPositions[i], pos) or isInArray(raid.takenPositions[i], pos) and posChangeAttempts < 500 do
		        x = math.random(v.position.from_x, v.position.to_x)
			    y = math.random(v.position.from_y, v.position.to_y)
			    z = v.position.z
			    pos = Position(x, y, z)
				posChangeAttempts = posChangeAttempts + 1
			end
				
			local foundTile = Tile(pos)
			if foundTile and foundTile:getGround() and not foundTile:hasProperty(TILESTATE_NONE) then
			    --print("Tu przechodzi?")
			    local randMonster = math.random(1, #t.monsters.monsterList)
				local monster = Game.createMonster(t.monsters.monsterList[randMonster], pos, false, false)
				if monster then
				    print("Attempt: " .. attempts)
					print("Zrespiono: " .. monster:getName())
				    monster:registerEvent("Raid_monsterDeath")
					monster:setTown(RAID_STORAGE_MONSTERS_TOWN, i)
			        table.insert(v.monsters["Monsters"], monster:getId())
					monstersSpawned = monstersSpawned + 1
					table.insert(raid.takenPositions[i], monster:getPosition())
				else

					table.insert(raid.badPositions[i], pos)
				end
		    end
			attempts = attempts + 1
		 end
		  -- for z = 1, t.monsters.monsterCount do
             -- x = math.random(v.position.from_x, v.position.to_x)
             -- y = math.random(v.position.from_y, v.position.to_y)
		     -- z = v.position.z
		     -- pos = Position(x, y, z)
			 
			-- local foundTile = Tile(pos)
			-- if foundTile ~= nil and foundTile:getGround() ~= nil and not foundTile:hasProperty(TILESTATE_NONE) and
            -- not foundTile:hasProperty(TILESTATE_PROTECTIONZONE) and (foundTile:getCreatureCount() == 0) then
			 
			 
			 
			 -- local randMonster = math.random(1, #t.monsters.monsterList)
             -- local monster = Game.createMonster(t.monsters.monsterList[randMonster], pos, false, false)
			
			 -- if monster then
			 -- monster:registerEvent("Raid_monsterDeath")
			 -- monster:setTown(RAID_STORAGE_MONSTERS_TOWN, i)
			 -- table.insert(v.monsters["Monsters"], monster:getId())
			 -- end
			 
			 -- if not monster and attempts < 100 then
			   -- z = z - 1
			   -- attempts = attempts + 1
			 -- end			    
             -- end
		  -- end

        for a = 1, #v.positionLanterns do
		      x = v.positionLanterns[a].x
		      y = v.positionLanterns[a].y
			  z = v.positionLanterns[a].z
			  pos = Position(x, y, z)
			  local tile = Tile(pos)
			  if tile then
			  local lantern = tile:getItemById(RAID_LANTERN_ID)
				       
					   if not lantern then
					      lantern = tile:getItemById(RAID_LANTERN_GREEN_ID) 
					   end
					   
					   if not lantern then
					      lantern = tile:getItemById(RAID_LANTERN_BLUE_ID) 
					   end
					   
					   if not lantern then
					      lantern = tile:getItemById(RAID_LANTERN_RED_ID) 
					   end
					   
					   
			           if lantern and t.lanternColor then
			              if t.lanternColor == "green" then
				             lantern:transform(RAID_LANTERN_GREEN_ID)
							 lantern:setAttribute(ITEM_ATTRIBUTE_NAME, 'Raid Lantern')
							 lantern:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, 'The City is under attack! raid type: easy.')
							 lantern:setCustomAttribute("RaidName", i)
							 lantern:setCustomAttribute("RaidIndex", number)
				          elseif t.lanternColor == "blue" then
				             lantern:transform(RAID_LANTERN_BLUE_ID)
							 lantern:setAttribute(ITEM_ATTRIBUTE_NAME, 'Raid Lantern')
							 lantern:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, 'The City is under attack! raid type: medium')
							 lantern:setCustomAttribute("RaidName", i)
							 lantern:setCustomAttribute("RaidIndex", number)
				          elseif t.lanternColor == "red" then
		                     lantern:transform(RAID_LANTERN_RED_ID)
							 lantern:setAttribute(ITEM_ATTRIBUTE_NAME, 'Raid Lantern')
							 lantern:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, 'The City is under attack! raid type: hard')
							 lantern:setCustomAttribute("RaidName", i)
							 lantern:setCustomAttribute("RaidIndex", number)
			              end
					end
			  end
	      end
		  local mn = t.timeDuration * 1000 * 3600
		  
		  addEvent(function()
		  raid:stop(i, number, false, true)
		  end, mn)
		  
		  Game.setStorageValue(RAID_STORAGE_TIME_LEFT + number, os.time() + t.timeDuration * 3600)	  
		  
		  local maxKill = #v.monsters["Monsters"] + #v.monsters["Boss"]

		  
		  CITIES_TO_RAID[i].monsters.maxKill = maxKill
		  CITIES_TO_RAID[i].monsters.Killed = maxKill
		  
		  number = number + 1
      end
   end
	  
   local city = ""
   
   if #cities == 1 then
      city = cities[1]
   elseif #cities > 1 then
      for i = 1, #cities do
	      if i == #cities then
		     city = city .. cities[i] .. "."
			 else 
             city = city .. cities[i] .. ", " 
		  end
      end
   end
      
   Game.broadcastMessage(t.raidName .. " Raid " .. " in " .. city .. " has begun! Good luck, Warrios!.", MESSAGE_EVENT_ADVANCE)
   end, 20000)
	  

   addEvent(function()
      Game.broadcastMessage("Warrios!, prepare for " .. t.raidName .. " Raid.", MESSAGE_EVENT_ADVANCE)
   end, 0)


   addEvent(function()
      Game.broadcastMessage("Warrios!, prepare for " .. t.raidName .. " Raid." .. " the monsters are awakening..", MESSAGE_EVENT_ADVANCE)
   end, 15000)


       
	  
	  
   return true
end

function raid:monsters(name)

	local v = CITIES_TO_RAID[name].monsters.Killed
	
	if not v then
	return 0
	end
	
    return v
end

function raid:stop(name, index, killed, notification, clearAll)
        
		
		local _sendMessage = false
		
	    local v = CITIES_TO_RAID[name]
		
		if not killed then
			    for i, bosses in pairs(v.monsters["Boss"]) do
			        local boss = Monster(bosses)
				          if boss then
				             boss:remove()
							
							 if notification then
				             _sendMessage = true
					         end
			             end
				end
				
				for z, monsters in pairs(v.monsters["Monsters"]) do				
				local monster = Monster(monsters)
				      if monster then
				         monster:remove()
						 
				         if notification then
				            _sendMessage = true
					     end
				     end
			    end
			
		end
		
		-- if clearAll then
		    -- for i, v in pairs(CITIES_TO_RAID) do
			    -- for _, bosses in pairs(v.monsters["Boss"]) do
			        -- local boss = Monster(bosses)
				          -- if boss then
				             -- boss:remove()
							
							 -- if notification then
				             -- _sendMessage = true
					         -- end
			             -- end
				-- end
				
				-- for z, monsters in pairs(v.monsters["Monsters"]) do				
				-- local monster = Monster(z)
				      -- if monster then
				         -- monster:remove()
						 
				         -- if notification then
				            -- _sendMessage = true
					     -- end
				     -- end
			    -- end 
            -- end
        -- end			
		
		for a = 1, #v.positionLanterns do
		      x = v.positionLanterns[a].x
		      y = v.positionLanterns[a].y
			  z = v.positionLanterns[a].z
			  pos = Position(x, y, z)
			  local tile = Tile(pos)
			  if tile then
			  local lantern = tile:getItemById(RAID_LANTERN_ID)
				       
					   if not lantern then
					      lantern = tile:getItemById(RAID_LANTERN_GREEN_ID) 
					   end
					   
					   if not lantern then
					      lantern = tile:getItemById(RAID_LANTERN_BLUE_ID) 
					   end
					   
					   if not lantern then
					      lantern = tile:getItemById(RAID_LANTERN_RED_ID) 
					   end
					   
					   
			           if lantern then
				          lantern:transform(RAID_LANTERN_ID)
					      lantern:setAttribute(ITEM_ATTRIBUTE_NAME, 'Raid Lantern')
						  lantern:removeCustomAttribute("RaidName")
						  lantern:removeCustomAttribute("RaidIndex")
						  lantern:removeAttribute(ITEM_ATTRIBUTE_DESCRIPTION)
			           end
						
			  end
	      end
		  
		  if _sendMessage then
		     Game.broadcastMessage("The raid is over, " .. name:lower() .. " city is now safe.", MESSAGE_EVENT_ADVANCE)
		  end
		  
		  if killed then
		     Game.broadcastMessage("All monsters has been killed! Congratulations. The raid is over," .. name:lower() .. " city is now safe.", MESSAGE_EVENT_ADVANCE)
		  end 
		  
		  v = { 
	      ["Monsters"] = {},
		  ["Boss"] = {},
		  maxKill = 0,
		  Killed = 0,
	      }
		  
		  CITIES_TO_RAID[name].monsters = v
		  
		  
		return true
end

function raid:StartUp()

    for i, v in pairs(CITIES_TO_RAID) do
	    for a = 1, #v.positionLanterns do
		      x = v.positionLanterns[a].x
		      y = v.positionLanterns[a].y
			  z = v.positionLanterns[a].z
			  pos = Position(x, y, z)
			  local tile = Tile(pos)
			  if tile then
			  local lantern = tile:getItemById(RAID_LANTERN_ID)
				       
					   if not lantern then
					      lantern = tile:getItemById(RAID_LANTERN_GREEN_ID) 
					   end
					   
					   if not lantern then
					      lantern = tile:getItemById(RAID_LANTERN_BLUE_ID) 
					   end
					   
					   if not lantern then
					      lantern = tile:getItemById(RAID_LANTERN_RED_ID) 
					   end
					   
					   
			           if lantern then
					      if lantern:getId() ~= RAID_LANTERN_ID then
				             lantern:transform(RAID_LANTERN_ID)
					      end
					   end
							 
			 end
		end
	end
end

local globalevent = GlobalEvent("raid_onStartUp")
function globalevent.onStartup()
	raid:StartUp()
	return true
end
globalevent:register()

	
local talk = TalkAction("/raid")
function talk.onSay(player, words, param)
		
	if not player:getGroup():getAccess() then
		return true
	end

	if player:getAccountType() < ACCOUNT_TYPE_GOD then
		return false
	end
    
	local index = tonumber(param)
	
    raid:start(index)
    player:getPosition():sendMagicEffect(30)
	
    return true

end
talk:separator(" ")
talk:register()

local talk2 = TalkAction("/carlin")
function talk2.onSay(player, words, param)
		
	if not player:getGroup():getAccess() then
		return true
	end

	if player:getAccountType() < ACCOUNT_TYPE_GOD then
		return false
	end
    
	player:teleportTo(Position(32360, 31789, 7))
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	
    return true

end
talk2:separator(" ")
talk2:register()


-- local talk3 = TalkAction("/tested")
-- function talk3.onSay(player, words, param)
		
	-- if not player:getGroup():getAccess() then
		-- return true
	-- end

	-- if player:getAccountType() < ACCOUNT_TYPE_GOD then
		-- return false
	-- end
    
	
    -- return true

-- end
-- talk3:separator(" ")
-- talk3:register()

local Raid_monsterDeath = CreatureEvent("Raid_monsterDeath")
function Raid_monsterDeath.onDeath(creature, corpse, killer, mostDamageKiller, unjustified, mostDamageUnjustified)
    
	local monster = Monster(creature)
	
	if not monster or not monster:getTown(RAID_STORAGE_MONSTERS_TOWN) then
	   return true
	end
	
	local name = monster:getTown(RAID_STORAGE_MONSTERS_TOWN)
	
	local v = CITIES_TO_RAID[name] 
	
	if not v then
	return true
	end
	
	local maxKills = v.monsters.maxKills

	local count = raid:monsters(name)

	if count > 1 then
	   if monster:getStorageValue(RAID_STORAGE_MONSTERS_BOSS) == 1 then
	      raid:removeCreature(v.monsters["Boss"], monster:getId())
	   else
	      raid:removeCreature(v.monsters["Monsters"], monster:getId())
	   end
	   CITIES_TO_RAID[name].monsters.Killed = CITIES_TO_RAID[name].monsters.Killed - 1
	elseif count == 1 then
	   if monster:getStorageValue(RAID_STORAGE_MONSTERS_BOSS) == 1 then
	      raid:removeCreature(v.monsters["Boss"], monster:getId())
	   else
	      raid:removeCreature(v.monsters["Monsters"], monster:getId())
	   end
	   CITIES_TO_RAID[name].monsters.Killed = CITIES_TO_RAID[name].monsters.Killed - 1
	   raid:stop(name, t, true, false)
	end
	
	count = raid:monsters(name)
	
	

end
Raid_monsterDeath:register()

local globalevent = GlobalEvent("RaidScheduler")
function globalevent.onThink(interval)

	for i = 1, #RAID_SYSTEM do
		for day, v in pairs(RAID_SYSTEM[i].scheduler.Days) do
			local currentDay = os.date("%A")
				if day == currentDay or day == "Everyday" then
	
					 for Time, t in pairs(v.Time) do
		                 local time = os.date("%H:%M")
			             if t == time then
	
							 if Game.getStorageValue(RAID_STORAGE_EVENT_STARTED + i) < 1 then
							    raid:start(i)
							    Game.setStorageValue(RAID_STORAGE_EVENT_STARTED + i, 1)
								
								addEvent(function()
		                        Game.setStorageValue(RAID_STORAGE_EVENT_STARTED + i, 0)
		                        end, 60 * 1000)
						     end
				        end
		             end
		        end
        end
	end

	return true
end
globalevent:interval(1000)
globalevent:register()

-- local action = Action()
-- function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)

-- local index = Game.getStorageValue(RAID_STORAGE)

   -- if index < 1 then
   -- player:sendCancelMessage("There is no active raid.")
   -- return true
   -- end
   
   -- local t = RAID_SYSTEM[index]
   
   -- if not t then
   -- return true
   -- end
   
   -- local pos = player:getPosition()
   -- local number = math.random(0,100)
   -- if number <= 25 then
      -- local randMonster = math.random(1, #t.monsters.monsterList)
	  -- local position = Position(fromPosition.x + math.random(1,3), fromPosition.y + math.random(1,3), fromPosition.z)
	  -- local monster = Game.createMonster(t.monsters.monsterList[randMonster], fromPosition, true, true)
	  -- if not monster then
	     -- player:sendCancelMessage("There is not enough room.")
		 -- pos:sendMagicEffect(CONST_ME_POFF)
		 -- return true
	  -- end
      -- pos:sendMagicEffect(CONST_ME_MAGIC_GREEN)
   -- else
      -- pos:sendMagicEffect(CONST_ME_POFF)
   -- end


-- return true
-- end

-- action:id(RAID_LANTERN_ID, RAID_LANTERN_GREEN_ID, RAID_LANTERN_BLUE_ID, RAID_LANTERN_RED_ID)
-- action:register()