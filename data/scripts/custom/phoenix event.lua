PHEONIX_EVENT = {
                  [1] = {
				          attempts = 5, -- how many items need to be burned before spawn monsters
						  time = 30, -- in seconds
						  ["Items"] = { 21394 }, --- item list that can be burned
						  ["Positions"] = { 
						                    { 809, 871, 3 },
										  },
						  ["Monsters"] = { 
										   { name = "Freegoiz", position = { 812, 872, 3 } },
										 },
						  ["Effects"] = {
						                  onBurn = 7,
										},  
										  
				        },
                  [2] = {
				          attempts = 5, -- how many items need to be burned before spawn monsters
						  time = 30, -- in seconds
						  ["Items"] = { 2160 }, --- item list that can be burned
						  ["Positions"] = { 
						                    { 741, 555, 4 },
										  },
						  ["Monsters"] = { 
										   { name = "Rat", position = { 811, 555, 4 } },
										 },
						  ["Effects"] = {
						                  onBurn = 7,
										},  
										  
				        }						
			    }

phoenixEvent = { }
phoenixEvent.__newindex = phoenixEvent

function phoenixEvent:prepare()
	for i = 1, #PHEONIX_EVENT do
	    for a = 1, #PHEONIX_EVENT[i]["Positions"] do
		    local x = PHEONIX_EVENT[i]["Positions"][a][1]
			local y = PHEONIX_EVENT[i]["Positions"][a][2]
			local z = PHEONIX_EVENT[i]["Positions"][a][3]
			local position = Position(x, y, z)
			local tile = Tile(position)
			
			local items = tile:getItems()
			if items then
			   for index, item in pairs(items) do
				   item:setCustomAttribute("PHOENIX_EVENT_INDEX", i)
				   local attempts = PHEONIX_EVENT[i].attempts
				   item:setCustomAttribute("PHOENIX_EVENT_ATTEMPTS", attempts)
			   end
			end
	    end
	end
end
				      
function phoenixEvent:getTable(item)
    
	if not item then
	   return nil
	end
	    
	if not item:getCustomAttribute("PHOENIX_EVENT_INDEX") then
	   return false
	end
	
	local index = item:getCustomAttribute("PHOENIX_EVENT_INDEX")
	
	return PHEONIX_EVENT[index]
end

function phoenixEvent:getAttempts(item)
    
	if not item then
	   return nil
	end
	    
	if not item:getCustomAttribute("PHOENIX_EVENT_ATTEMPTS") then
	   return false
	end
	
	return item:getCustomAttribute("PHOENIX_EVENT_ATTEMPTS")
end

function phoenixEvent:addAttempts(item)
    
	if not item then
	   return nil
	end
	    
	if not item:getCustomAttribute("PHOENIX_EVENT_ATTEMPTS") then
	   return false
	end
	
	return item:setCustomAttribute("PHOENIX_EVENT_ATTEMPTS", item:getCustomAttribute("PHOENIX_EVENT_ATTEMPTS") - 1)
end

function phoenixEvent:isValidItem(t, item)
         
    if not t then
	   return nil
	end
	
	for index, id in pairs(t["Items"]) do
	    if item:getId() == id then
		   return true
		end
    end
	
	return false
end

function phoenixEvent:spawnMonsters(t)
    
	if not t then
	   return nil
	end
	
	if not t.monsters then
	   t.monsters = {}
	end
	
	for index, monsterTable in pairs(t["Monsters"]) do 
	    local name = monsterTable.name
		local x = monsterTable.position[1]
		local y = monsterTable.position[2]
		local z = monsterTable.position[3]
		local position = Position(x, y, z)
		
		local monster = Game.createMonster(name, position)
		if monster then
		   monster:registerEvent("PhoenixEvent_onDeath")
		   table.insert(t.monsters, monster:getId())
		end
	end
end

function phoenixEvent:MonstersAlive(t)
    
	if not t.monsters then
	   return false
	end
	   
	for index, id in pairs(t.monsters) do
	    local monster = Monster(id) 
		if monster then
		   return true
		end
	end
	
	return false
end

function phoenixEvent:removeMonster(id)

    if not id then
	   return nil
	end
		
	for index, config in pairs(PHEONIX_EVENT) do
	    local monsterTable = config.monsters
		if monsterTable then
           for i, v in ipairs(monsterTable) do
               if v == id then
                  return table.remove(monsterTable, i)
               end
           end
        end
    end
	
end
         
function phoenixEvent:displayTimer(t, position, item)
    if not t then
	   return nil
	end
	
	local times = t.time
	local interval = 1000
	local delay = 0
    
	item:setCustomAttribute("PHOENIX_EVENT_ATTEMPTS", t.attempts + 1)
	
    for i = 1, times do
        if i == 1 then
           delay = 0
        else
           delay = delay + interval
        end

        addEvent(function()
		    Game.sendAnimatedText(times - i, position, 181)
			if i == times then
			   phoenixEvent:spawnMonsters(t)
			   item:setCustomAttribute("PHOENIX_EVENT_ATTEMPTS", t.attempts)
			end
		end, delay)
	end
end

local globalevent = GlobalEvent("Phoenix Event")
function globalevent.onStartup()
	phoenixEvent:prepare()
	return true
end
globalevent:register()

local creatureevent = CreatureEvent("PhoenixEvent_onDeath")
function creatureevent.onDeath(creature, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)
    
    if not creature or not creature:isMonster() then
	   return true
	end
	
	local id = creature:getId()
	phoenixEvent:removeMonster(id)
	return true
end
creatureevent:register()



    

