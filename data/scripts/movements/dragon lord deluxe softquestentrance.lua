sofquestentrance = {
                       [1] = {
					           tileDamage = { value = 4444, times = 33, interval = 1 }, --- interval in seconds
							   tileCooldown = 1, -- in minutes
					           ["Position"] = { 192, 2255, 10 },
							   ["Monsters"] = { 
							                    [1] = "Dragon Lord Deluxe",
											  }
							   
							 }
					 }



sofquestentrancedldeluxe = { }
sofquestentrancedldeluxe.__newindex = sofquestentrancedldeluxe
sofquestentrancedldeluxe.aid = 9122
sofquestentrancedldeluxe.index = "sofquestentrance_INDEX"
sofquestentrancedldeluxe.cooldown = "sofquestentrance_COOLDOWN"

function sofquestentrancedldeluxe:prepare()
    for index, v in pairs(sofquestentrance) do
	    local t = v["Position"]
		if t then
		   local x = t[1]
		   local y = t[2]
		   local z = t[3]
		   local pos = Position(x, y, z)
		   if pos then
		      local tile = Tile(pos)
			  if tile then
			     local ground = tile:getGround()
				 if ground then
				    ground:setCustomAttribute(sofquestentrancedldeluxe.index, index)
					ground:setAttribute(ITEM_ATTRIBUTE_ACTIONID, sofquestentrancedldeluxe.aid)
			     end
			  end
		   end
		end
	end
end

function sofquestentrancedldeluxe:spawnMonsters(item)

    if not item then
       return nil
    end
	
	local index = item:getCustomAttribute(sofquestentrancedldeluxe.index)
	if not index then
	   return nil
	end
	
	local t = sofquestentrance[index]
	if not t then
	   return nil
	end
	
	local monstersCount = 0
	
	local monstersRnd = math.random(1, #t["Monsters"])
	local attempts = 0
    
	local x = item:getPosition().x 
	local y = item:getPosition().y
	local z = item:getPosition().z
    local pos = Position(x, y, z)
	
	for i = 1, monstersRnd do
	    local name = t["Monsters"][i]
		local monster = Game.createMonster(name, pos, false, false)
		if monster then
		   --
		   monstersCount = monstersCount + 1
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
				    ---
					monstersCount = monstersCount + 1
				 end
				 attempts = attempts + 1
		end
	end
	
	if monstersCount > 0 then
	   return true
	else
	   return false
	end
end			
   
function sofquestentrancedldeluxe:sendPoison(player, t)

    if not t or not player then
	   return nil
	end
	
	local damage = t.tileDamage.value
	local times = t.tileDamage.times
	local interval = t.tileDamage.interval * 1000
	
	local subid = 231
	local condition = Condition(CONDITION_FIRE)
    condition:setParameter(CONDITION_PARAM_SUBID, subid)
    condition:addDamage(times, interval, -damage)
	player:addCondition(condition)
	return true
end

function sofquestentrancedldeluxe:setCooldown(item)

    if not item then
       return nil
    end
	
	local index = item:getCustomAttribute(sofquestentrancedldeluxe.index)
	if not index then
	   return nil
	end
	
	local t = sofquestentrance[index]
	if not t then
	   return nil
	end
	
	local cooldown = t.tileCooldown * 60
	
	return item:setCustomAttribute(sofquestentrancedldeluxe.cooldown, cooldown + os.time())
end

function sofquestentrancedldeluxe:getCooldownStr(item)
   local time_string = ""
   local cooldown = item:getCustomAttribute(sofquestentrancedldeluxe.cooldown)
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

function sofquestentrancedldeluxe:canSpawn(item)

   if not item then
	  return nil
   end 
   
   local cooldown = item:getCustomAttribute(sofquestentrancedldeluxe.cooldown)
   if not cooldown then
      return true
   end
   
   if cooldown > os.time() then
	  return false
   end
   
   return true
end

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


local globalevent = GlobalEvent("load_sofquestentrancedldeluxe")
function globalevent.onStartup()
	 sofquestentrancedldeluxe:prepare()
end
globalevent:register()	
	
local moveevent = MoveEvent()
moveevent:type("stepin")
function moveevent.onStepIn(creature, item, position, fromPosition)
    
	local player = Player(creature)
	if not player then
	   return true
	end
	
	local index = item:getCustomAttribute(sofquestentrancedldeluxe.index)
	if not index then
	   return true
	end
	
	local t = sofquestentrance[index]
	if not t then
	   return true
	end

    local pos = player:getPosition()
    
	if sofquestentrancedldeluxe:canSpawn(item) then
	   sofquestentrancedldeluxe:spawnMonsters(item)
	   sofquestentrancedldeluxe:setCooldown(item)
	   Game.sendTextOnPosition("Monsters spawns..", item:getPosition())
	else
	   Game.sendTextOnPosition("The monsters can be spawn at: " .. sofquestentrancedldeluxe:getCooldownStr(item), item:getPosition())
	end
    
	
	Game.sendTextOnPosition("You are poisoned!", item:getPosition())
	pos:sendMagicEffect(CONST_ME_MAGIC_GREEN)
	sofquestentrancedldeluxe:sendPoison(player, t)
	
	--print("COOLDOWN: " .. sofquestentrancedldeluxe:getCooldownStr(item))
	return true
end
moveevent:aid(sofquestentrancedldeluxe.aid)
moveevent:register()
