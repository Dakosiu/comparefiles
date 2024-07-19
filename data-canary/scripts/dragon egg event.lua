if not DRAGON_EGG_EVENT then
    DRAGON_EGG_EVENT = {}
end

DRAGON_EGG_EVENT.config = {
                            ["Scheduler"] = {
							                  interval = { type = "minute", value = 5 },
											  stop = { type = "minute", value = 10 },
							                },
							["Positions"] = { from_x = 925, to_x = 1026, from_y = 1105, to_y = 1171, z = 7 },
							["Monsters"] = {
							                  list = { "Dragon", "Dragon Hatchling", "Dragon Egg" },
											  count = 500
										   },
							["Rewards"] = {
											{ type = "item", id = 16263, count = 1, chance = 0.05 },
											{ type = "item", id = 3363, count = 1, chance = 0.05 },
											{ type = "item", id = 10326, count = 1, chance = 0.05 },
											{ type = "item", id = 39694, count = 1, chance = 0.05 },
											{ type = "item", id = 24967, count = 1, chance = 0.05 },
											{ type = "item", id = 5919, count = 1, chance = 0.05 }											
										  }
						  }
						  
						  
if not DRAGON_EGG_EVENT.creatures then
    DRAGON_EGG_EVENT.creatures = {}
end

DRAGON_EGG_EVENT.event = "onDeath_DRAGON_EGG_EVENT"

local function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function DRAGON_EGG_EVENT:setAvaible(boolean)
    if boolean then
	   self.avaible = true
	else
	   self.avaible = false
	end
end

function DRAGON_EGG_EVENT:getAvaible()
    if not self.avaible then
	   return false
	end
	return true
end

function DRAGON_EGG_EVENT:getInterval(t)
	local method = t.type
	local duration = t.value

    local interval = 0
    if string.find(method, "second") then
	   interval = duration
    elseif string.find(method, "minute") then
	   interval = duration * 60
    elseif string.find(method, "hour") then 
	   interval = duration * 60 * 60
    end
   
    return interval
end

function DRAGON_EGG_EVENT:addMonster(name, position)
	local monster = Game.createMonster(name, position, false, false)
	if not monster then
	   return false
	end
	monster:registerEvent(self.event)
	
	table.insert(DRAGON_EGG_EVENT.creatures, monster:getId())
    return true
end
	
function DRAGON_EGG_EVENT:removeMonsters()
    if #DRAGON_EGG_EVENT.creatures == 0 then
	    return false
    end
	for i, v in ipairs(self.creatures) do
	    local creature = Creature(v)
		if creature then
		   creature:remove()
		end
	end
	DRAGON_EGG_EVENT.creatures = {}
end
	
function DRAGON_EGG_EVENT:spawnMonsters()
    self:removeMonsters()
	local t = self.config["Monsters"]
	local listTable = t.list
	local count = t.count
	local posTable = self.config["Positions"]
	local from_x = posTable.from_x
	local from_y = posTable.from_y
	local to_x = posTable.to_x
	local to_y = posTable.to_y
	local z = posTable.z
	
	local attempts = 0
	for i = 1, count do
	    local x = math.random(from_x, to_x)
        local y = math.random(from_y, to_y)
		local pos = Position(x, y, z)
		local foundTile = Tile(pos)
		if foundTile ~= nil and foundTile:getGround() ~= nil and not foundTile:hasProperty(TILESTATE_NONE) and not foundTile:hasProperty(TILESTATE_PROTECTIONZONE) and (foundTile:getCreatureCount() == 0) then
		    local name = listTable[math.random(1, #listTable)]
			self:addMonster(name, pos)
		end
	end
	DRAGON_EGG_EVENT:respawnMonster()
end

function DRAGON_EGG_EVENT:respawnMonster()
	local t = self.config["Scheduler"]
	local interval = DRAGON_EGG_EVENT:getInterval(t.interval)
	
	local second = 0
    if DEVELOPER_MODE then
        second = 1000
	    else
	    second = 1000
    end
	
	function processRespawn() 
		if not self:getAvaible() then
			return false
		end	
		
        Game.broadcastMessage("[Dragon Egg Event] Dragons will attack the city in 2 minutes.", MESSAGE_EVENT_ADVANCE)
   
        addEvent(function()
		    if not self:getAvaible() then
			   return false
			end
            Game.broadcastMessage("[Dragon Egg Event] Dragons will attack the city in 1 minutes", MESSAGE_EVENT_ADVANCE)
        end, 1 * second * 60)
   
        addEvent(function()
		    if not self:getAvaible() then
			   return false
			end		
            DRAGON_EGG_EVENT:spawnMonsters()
		    Game.broadcastMessage("[Dragon Egg Event] Dragons attacked the city.", MESSAGE_EVENT_ADVANCE)
			DRAGON_EGG_EVENT:start(true)
        end, 2 * second * 60)		
		addEvent(processRespawn, interval * 1000)
	end
	addEvent(processRespawn, interval * 1000)
end
	
function DRAGON_EGG_EVENT:start(boolean)
	if boolean then
	   DRAGON_EGG_EVENT:spawnMonsters()
	   DRAGON_EGG_EVENT:setAvaible(true)
	   return true
	end
	
	local second = 0
    if DEVELOPER_MODE then
        second = 1000
	    else
	    second = 1000
    end

    Game.broadcastMessage("[Dragon Egg Event] will start in 5 minutes.", MESSAGE_EVENT_ADVANCE)
   
    addEvent(function()
        Game.broadcastMessage("[Dragon Egg Event] will start in 3 minutes.", MESSAGE_EVENT_ADVANCE)
    end, 2 * second * 60)
   
    addEvent(function()
        Game.broadcastMessage("[Dragon Egg Event] will start in 2 minutes.", MESSAGE_EVENT_ADVANCE)
    end, 3 * second * 60)

    addEvent(function()
        Game.broadcastMessage("[Dragon Egg Event] will start in 1 minute.", MESSAGE_EVENT_ADVANCE)
    end, 4 * second * 60)
   
    addEvent(function()
        DRAGON_EGG_EVENT:spawnMonsters()
		DRAGON_EGG_EVENT:setAvaible(true)
		DRAGON_EGG_EVENT:finish()
		Game.broadcastMessage("[Dragon Egg Event] has begun!", MESSAGE_EVENT_ADVANCE)
    end, 5 * second * 60)
end

function DRAGON_EGG_EVENT:finish()
    local t = self.config["Scheduler"]
	local interval = DRAGON_EGG_EVENT:getInterval(t.stop)
	
	local second = 0
    if DEVELOPER_MODE then
        second = 1000
	    else
	    second = 1000
    end
	
	function finish()
	   	Game.broadcastMessage("[Dragon Egg Event] will end in 5 minutes.", MESSAGE_EVENT_ADVANCE)
		DRAGON_EGG_EVENT:setAvaible(false)
	    addEvent(function()
	        Game.broadcastMessage("[Dragon Egg Event] will end in 3 minutes.", MESSAGE_EVENT_ADVANCE)
		end, 2 * second * 60)
	    addEvent(function()
	        Game.broadcastMessage("[Dragon Egg Event] will end in 2 minutes.", MESSAGE_EVENT_ADVANCE)
		end, 3 * second * 60)	
		
	    addEvent(function()
	        Game.broadcastMessage("[Dragon Egg Event] will end in 1 minutes", MESSAGE_EVENT_ADVANCE)
		end, 4 * second * 60)	

	    addEvent(function()
	        Game.broadcastMessage("[Dragon Egg Event] finished.", MESSAGE_EVENT_ADVANCE)
            DRAGON_EGG_EVENT:removeMonsters()
		end, 5 * second * 60)			
	end
	
	addEvent(finish, interval * 1000)
end

function DRAGON_EGG_EVENT:getAvaibleExchanges()
	local str = ""
	local t = self.config["Rewards"]
	local length = tablelength(t)
	local index = 1
	for i, v in pairs(t) do
	    str = str .. "{" .. getItemName(i) .. "}"
		if index == length then
		   str = str .. "."
		else
		   str = str .. ", "
		end
		index = index + 1
	end
	return str
end
	
local talk = TalkAction("/dragon")
function talk.onSay(player, words, param)
		
	if not player:getGroup():getAccess() then
		return true
	end

	if player:getAccountType() < ACCOUNT_TYPE_GOD then
		return false
	end
    
	DRAGON_EGG_EVENT:start()
	
    return true

end
talk:separator(" ")
talk:register()