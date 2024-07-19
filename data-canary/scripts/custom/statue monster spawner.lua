STATUE_SPAWN_MONSTER_CONFIG = {
                 [1] = {
				         _automaticProcessWave = { enabled = true, interval = 15 },
						 ["Teleport"] = { 
						                  itemid = 27590,
										  destination = { 964, 1114, 6 },
										  position = { 970, 1115, 7 },
										  expireAt = 60 -- w sekundach kiedy znika teleport
										},
				         ["Position"] = { 970, 1110, 7 },
						 ["Waves"] = {
						               [1] = { 
									           [1] = "Fire Devil",
											   [2] = "Fire Devil",
											   [3] = "Fire Devil",
											   [4] = "Fire Elemental",
											},
									   [2] = {
									           [1] = "Dragon",
											   [2] = "Dragon",
											   [3] = "Dragon Lord",
											 }
						             }
											   
			            },
                 [2] = {
				         _automaticProcessWave = { enabled = false, interval = 15 },
						 ["Teleport"] = { 
						                  itemid = 27590,
										  destination = { 935, 1164, 6 },
										  position = { 1011, 1025, 7 },
										  expireAt = 60 -- w sekundach kiedy znika teleport
										},
				         ["Position"] = { 770, 1049, 7 },
						 ["Waves"] = {
						               [1] = { 
									           [1] = "Cave Rat",
											   [2] = "Cave Rat",
											   [3] = "Cave Rat",
											   [4] = "Troll",
											},
									   [2] = {
									           [1] = "Cave Rat",
											   [2] = "Dragon",
											   [3] = "Orc",
											 }
						             }
											   
			            },
						
				}
				
statueSpawnMonster = { }
statueSpawnMonster.__newindex = statueSpawnMonster
statueSpawnMonster.aid = 9123
statueSpawnMonster.index = "STATUE_SPAWN_MONSTER_INDEX"
statueSpawnMonster.number = "STATUE_SPAWN_MONSTER_NUMBER"

function Game.sendTextOnPosition(message, position, effect)
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

function statueSpawnMonster:findStatue(index)
    if not index then
	   return nil
	end
	
	local t = STATUE_SPAWN_MONSTER_CONFIG[index]
	
	local x = t["Position"][1]
	local y = t["Position"][2]
	local z = t["Position"][3]
	local pos = Position(x, y, z)
	if pos then
	   local tile = Tile(pos)
	   if tile then
	      local item = tile:getItems()
		  if item then
		     return item[1]
		  end
	   end
	end
end

function statueSpawnMonster:prepare()
	for index, v in pairs(STATUE_SPAWN_MONSTER_CONFIG) do
	    if v._automaticProcessWave then
		   STATUE_SPAWN_MONSTER_CONFIG[index]._automaticProcessWave.isRunning = false
		end
	    STATUE_SPAWN_MONSTER_CONFIG[index].currentWave = 1
		STATUE_SPAWN_MONSTER_CONFIG[index]["Waves"].monsterTable = {}
	    if v["Position"] then
            local x = v["Position"][1]
			local y = v["Position"][2]
			local z = v["Position"][3]
			local pos = Position(x, y, z)
			if pos then
			   local tile = Tile(pos)
			   if tile then
			      local items = tile:getItems()
				  if items then
				     for z, item in pairs(items) do
		                item:setAttribute(ITEM_ATTRIBUTE_ACTIONID, statueSpawnMonster.aid)
			            item:setCustomAttribute(statueSpawnMonster.index, index)
						item:setCustomAttribute(statueSpawnMonster.number, STATUE_SPAWN_MONSTER_CONFIG[index].currentWave) 
				     end
				  end
			  end
		   end
		end
    end
end

function statueSpawnMonster:getIndex(item)
    if not item then
	   return nil
	end
	
	local value = item:getCustomAttribute(statueSpawnMonster.index)
	if not value then
	   return 0
	end
	
	return value
end
	
function statueSpawnMonster:getWaveNumber(item)
    if not item then
	   return nil
	end
	local value = item:getCustomAttribute(statueSpawnMonster.number)
	return value
end

function statueSpawnMonster:setWave(item)
    
	if not item then
	   return nil
	end
	
	local index = item:getCustomAttribute(statueSpawnMonster.index)
    local waveNumber = statueSpawnMonster:getWaveNumber(item)
	
	if not index or not waveNumber then
	   return nil
	end
	
    if waveNumber >= #STATUE_SPAWN_MONSTER_CONFIG[index]["Waves"] then
	   return item:setCustomAttribute(statueSpawnMonster.number, -2)
	end
	
	return item:setCustomAttribute(statueSpawnMonster.number, waveNumber + 1)

end

function statueSpawnMonster:startWave(item)
    
	if not item then
	   return nil
	end
	
	local index = statueSpawnMonster:getIndex(item)
	local number = statueSpawnMonster:getWaveNumber(item)
	
	local t = STATUE_SPAWN_MONSTER_CONFIG[index]
	if not t then
	   return nil
	end
	
	local x = item:getPosition().x 
	local y = item:getPosition().y
	local z = item:getPosition().z
    local pos = Position(x, y, z)
	
	local attempts = 0
	
	for i, name in pairs(t["Waves"][number]) do
	    local monster = Game.createMonster(name, pos, false, false)
		if monster then
		   monster:setStorageValue(statueSpawnMonster.aid, index)
		   monster:setStorageValue(statueSpawnMonster.aid + 1, number)
		   monster:registerEvent("onDeath_statueSpawnMonster")
		   local id = monster:getId()
		   table.insert(STATUE_SPAWN_MONSTER_CONFIG[index]["Waves"].monsterTable, id)
		end
		      while not monster and attempts < 100 do
			        local rnd = math.random(0, 1)
					if rnd == 0 then
			           x = x + 1
					   local rnd_y = math.random(0, 1)
					   if rnd_y == 1 then
					      y = y + 1
					   end
					else
					   x = x - 1
					   local rnd_y = math.random(0, 1)
					   if rnd_y == 1 then
					      y = y - 1
					   end

		            end
					pos = Position(x, y, z)
					monster = Game.createMonster(name, pos, false, false)
					if monster then
					   monster:setStorageValue(statueSpawnMonster.aid, index)
					   monster:setStorageValue(statueSpawnMonster.aid + 1, number)
					   monster:registerEvent("onDeath_statueSpawnMonster")
					   local id = monster:getId()
		               table.insert(STATUE_SPAWN_MONSTER_CONFIG[index]["Waves"].monsterTable, id)
					end
					attempts = attempts + 1
			 end
	end
	
	local _automatic = t._automaticProcessWave.enabled
	if _automatic then
	   t._automaticProcessWave.isRunning = true
	end
end

function statueSpawnMonster:getMonstersTable(index)
   if not index then
      return nil
   end
   
   local t = STATUE_SPAWN_MONSTER_CONFIG[index]
   if not t then
	  return nil
   end
	
   local wavesTable = t["Waves"]
   local monsterTable = wavesTable.monsterTable
   return monsterTable
end

function statueSpawnMonster:removeMonsterFromTable(t, id)
    
	if not t or not id then
	   return nil
	end
	
    for i, v in ipairs(t) do
       if v == id then
          return table.remove(t, i)
       end
    end
	
end

function statueSpawnMonster:getMonstersCount(index)
    	
	local t = STATUE_SPAWN_MONSTER_CONFIG[index]
	if not t then
	   return nil
	end
	
	local wavesTable = t["Waves"]
	local monsterTable = wavesTable.monsterTable
	return #monsterTable
end

function statueSpawnMonster:createTeleport(t)
    
	if not t then
	   return nil
	end
	
	local itemid = t.itemid
	local destinationTable = t.destination
	local positionTable = t.position
	local expireAt = t.expireAt
	
	
	
	if not itemid or not destinationTable or not expireAt then
	   return nil
	end
	
	local x = destinationTable[1]
	local y = destinationTable[2]
	local z = destinationTable[3]
	local destination = Position(x, y, z)
	if not destination then
	   return nil
	end


	x = positionTable[1]
	y = positionTable[2]
	z = positionTable[3]
	local pos = Position(x, y, z)
	if not pos then
	   return nil
	end

	local teleport = Game.createItem(itemid, 1, pos)
	if not teleport then
	   return nil
	end
	teleport:setDestination(destination)
	
	local sec = 1 * expireAt * 1000
	
	addEvent(function()
	   local teleport = Tile(pos):getItemById(itemid)
	   if teleport then
	      teleport:remove()
		  pos:sendMagicEffect(CONST_ME_POFF)
	   end
	end, sec)
	
end
	
	
	
	
	
	

local globalevent = GlobalEvent("load_statueSpawnMonster")
function globalevent.onStartup()
	 statueSpawnMonster:prepare()
end
globalevent:register()	

local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
   	
	local index = statueSpawnMonster:getIndex(item)
	if not index then
	   return true
	end
	
	local number = statueSpawnMonster:getWaveNumber(item)
	if not number or number == -2 then
	   player:sendCancelMessage("You cannot use anymore this statue.")
	   return true
	end
	
	local t = STATUE_SPAWN_MONSTER_CONFIG[index] 
	if not t then
	   return true
	end
	
	local _automatic = t._automaticProcessWave.enabled
	if _automatic then
	   local _isRunning = t._automaticProcessWave.isRunning
	   if _isRunning then
	      player:sendCancelMessage("This statue is already activated.")
		  return true
	   end
	else
	   local count = statueSpawnMonster:getMonstersCount(index, number)
	   if count > 0 then
	      player:sendCancelMessage("You have to kill monsters first.")
		  return true
	   end
	end
	statueSpawnMonster:startWave(item)
return true
end
action:aid(statueSpawnMonster.aid)
action:register()


local creaturescript = CreatureEvent("onDeath_statueSpawnMonster")
function creaturescript.onDeath(creature, corpse, killer, mostDamage, unjustified, mostDamage_unjustified)	
	local index = creature:getStorageValue(statueSpawnMonster.aid)
	local number = creature:getStorageValue(statueSpawnMonster.aid + 1)
	local monsterTable = statueSpawnMonster:getMonstersTable(index, number)
	local id = creature:getId()
	statueSpawnMonster:removeMonsterFromTable(monsterTable, id)
	local count = statueSpawnMonster:getMonstersCount(index, number)	
	if count == 0 then
	   local item = statueSpawnMonster:findStatue(index)
	   local oldWave = statueSpawnMonster:getWaveNumber(item)
	   statueSpawnMonster:setWave(item)
	   number = statueSpawnMonster:getWaveNumber(item)

	   if number == -2 then
	      local t = STATUE_SPAWN_MONSTER_CONFIG[index]["Teleport"]
	      Game.sendTextOnPosition("Congratulations! There is no more monsters to defeat.", item:getPosition())
		  statueSpawnMonster:createTeleport(t)
	      return true
	   end
	   
	   Game.sendTextOnPosition("Wave " .. oldWave .. " Cleared!", item:getPosition())
	   local t = STATUE_SPAWN_MONSTER_CONFIG[index]
	   local _automatic = t._automaticProcessWave.enabled
	   if _automatic then
	      Game.sendTextOnPosition("Wave " .. number .. " will start soon..", item:getPosition())
	      local interval = 0
          local seconds = t._automaticProcessWave.interval
          for i = 0, seconds do 
              addEvent(function()
	             if seconds == 0 then
				    if statueSpawnMonster:getWaveNumber(item) == -2 then
					   return false
					   else
	                   Game.sendTextOnPosition("Wave " .. number .. " has begun! GOOD LUCK", item:getPosition())
					   statueSpawnMonster:startWave(item)
					end
	             else 		     
	                if seconds <= 5 or seconds == 10 or seconds == 15 or seconds == 20 or seconds == 25 then
	                   local message = "Wave " .. number .. " will begin at " .. seconds .. " seconds.."
                       Game.sendTextOnPosition(message, item:getPosition())
		            end
	            end
	            seconds = seconds - 1
	         end, interval)
	         interval = interval + 1000
		  end
	   end
	end
	return true
end
creaturescript:register()

