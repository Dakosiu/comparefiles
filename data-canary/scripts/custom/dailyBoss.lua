dailyBossConfig = {
	npcName = 'Henselt',
	npcPos = Position(901, 1037, 7),
	bossFightPos = Position(749, 982, 7),
	bossPos = Position(750, 971, 7),
	miniBossName = 'Shamanflayer',
	miniBossTime = 10, -- w minutach
	miniBossTimer = { 
	                  ["Interval"] = 10, -- w sekundach
	                  ["Statue"] = { enabled = true, id = 746 },
					  ["Position"] = { 750, 971, 7 },
					},
    mainBossTeleports = {
                          id = 25051,
						  ["Positions"] = {
						                    { 902, 1035, 7 },
                                            { 903, 1035, 7 },
									      }
						},
	mainBossRoom = Position(797, 1017, 5),
	bossName = 'Flayer of the Hatebound',
	["Statues"] = {
	                name = "Power Statue",
					increaseDamage = 0.2,
					healing = 5000,
					["Positions"] = { 
	                                  { 802, 1017, 5 },
					                  { 802, 1012, 5 },
					                  { 793, 1012, 5 },
					                  { 793, 1017, 5 },
							        }
				  },
	["Teleport"] = {
	                 ["Position"] = { 749, 983, 7 },
					 ["ItemID"] = 25051
				   }
}

local MINI_DAILY_BOSS_STORAGE = 6271477
local MINI_DAILY_BOSS_ACTIONID = 4221
if not DAILY_BOSS_TABLE then
   DAILY_BOSS_TABLE = dailyBossConfig
   DAILY_BOSS_TABLE["Boss"] = {}
   DAILY_BOSS_TABLE["Statues"]["StatuesID"] = {}
   DAILY_BOSS_TABLE["Mini Boss"] = { ["Boss"] = {}, ["Player"] = {}, ["Reminder"] = {} }
end
miniDailyBoss = { }
miniDailyBoss.__newindex = miniDailyBoss
local DEVELOPER_MODE = true

function miniDailyBoss:prepare()
    
	local posTable = dailyBossConfig["Teleport"]["Position"]
    local x = posTable[1]
	local y = posTable[2]
	local z = posTable[3]
	local pos = Position(x, y, z)
	local tile = Tile(pos)
	local items = tile:getItems()
	for i, item in pairs(items) do
	    item:remove()
	end
	
	local item = Game.createItem(dailyBossConfig["Teleport"].ItemID, 1, pos)
	item:setAttribute(ITEM_ATTRIBUTE_ACTIONID, MINI_DAILY_BOSS_ACTIONID)
	item:setCustomAttribute("MINI_DAILY_INDEX", 1)
end

local globalevent = GlobalEvent("load_miniDailyBossTeleport")
function globalevent.onStartup()
	miniDailyBoss:prepare()
end
globalevent:register()	

local moveevent = MoveEvent()
moveevent:type("stepin")

function moveevent.onStepIn(creature, item, position, fromPosition)
    
	local player = Player(creature)
	if not player then
	    creature:teleportTo(position)
	    return true
	end
	
	if player == miniDailyBoss:getPlayer() then
        miniDailyBoss:removeMonster()
    end
    miniDailyBoss:teleportPlayer(player)
    miniDailyBoss:removePlayer(player)
	
	return true
end

moveevent:aid(MINI_DAILY_BOSS_ACTIONID)
moveevent:register()


function miniDailyBoss:addPlayer(player)
         
	if not player then
	   return nil
	end
	player:registerEvent("miniDailyBoss_onDeath")
	player:registerEvent("miniDailyBoss_onThink")
	DAILY_BOSS_TABLE["Mini Boss"]["Player"] = player:getId()
	DAILY_BOSS_TABLE["Mini Boss"]["Reminder"] = 0
	return true
end

function miniDailyBoss:removePlayer(player)

	if not player then
	   return nil
	end
	
    local id = DAILY_BOSS_TABLE["Mini Boss"]["Player"]
   
    if player:getId() == id then
       DAILY_BOSS_TABLE["Mini Boss"]["Player"] = {}
    end
	
	return true
end
	
function miniDailyBoss:getPlayer()
    
	local player = Player(DAILY_BOSS_TABLE["Mini Boss"]["Player"])
	
	if not player then
	   return nil
	end
	
	return player
end

function miniDailyBoss:teleportPlayer(player)
      
	 if not player then
	    return nil
     end
	 
	 if player == miniDailyBoss:getPlayer() then
	 	 local pos = DAILY_BOSS_TABLE.npcPos
		 local newPos = Position(pos.x, pos.y + 1, pos.z)
	     player:teleportTo(newPos)
		 return true
	 end
	 
	 return false
end

function miniDailyBoss:addMonster()
    miniDailyBoss:removeMonster()
	local monster = Game.createMonster(DAILY_BOSS_TABLE.miniBossName, DAILY_BOSS_TABLE.bossPos)
	
	if not monster then
	   return nil
	end 
	monster:registerEvent("miniDailyBoss_onDeath")
	DAILY_BOSS_TABLE["Mini Boss"]["Monster"] = monster:getId()
	return true
end

function miniDailyBoss:removeMonster()
    
	local id = DAILY_BOSS_TABLE["Mini Boss"]["Monster"]
	
	local monster = Monster(id)
	
	if not monster then
	   return nil
	end
	
	if monster then 
	   monster:remove()
	end
    
	DAILY_BOSS_TABLE["Mini Boss"]["Monster"] = {}

	return true
end
	
function miniDailyBoss:getMonster()
    
	local monster = Monster(DAILY_BOSS_TABLE["Mini Boss"]["Monster"])
	
	if not monster then
	   return nil
	end
	
	return monster
end

function miniDailyBoss:getTimeString()
    local total_seconds = Game.getStorageValue(MINI_DAILY_BOSS_STORAGE) - os.time()
    local time_days     = math.floor(total_seconds / 86400)
    local time_hours    = math.floor(mod(total_seconds, 86400) / 3600)
    local time_minutes  = math.floor(mod(total_seconds, 3600) / 60)
    local time_seconds  = math.floor(mod(total_seconds, 60))

	local timestring = ""
	if time_days == 0 then
	   timestring = time_hours .. " Hours" .. ", " .. time_minutes .. " Minutes" .. " and " .. time_seconds .. " seconds."
	end
	
	if time_hours == 0 then
	   timestring = time_minutes .. " Minutes" .. " and " .. time_seconds .. " seconds."
	end
	
	if time_minutes == 0 then
	   timestring = time_seconds .. " seconds."
	end

	return timestring
end

function miniDailyBoss:getTime()
    local total_seconds = Game.getStorageValue(MINI_DAILY_BOSS_STORAGE) - os.time()
	local seconds  = math.floor(mod(total_seconds, 60))
    local minutes  = math.floor(mod(total_seconds, 3600) / 60)
    		
	local values = { ["Minutes"] = minutes, ["Seconds"] = seconds }
	return values
end

function miniDailyBoss:setTime()
    Game.setStorageValue(MINI_DAILY_BOSS_STORAGE, os.time() + DAILY_BOSS_TABLE.miniBossTime * 60)
end

function miniDailyBoss:addStatue()
        if not DAILY_BOSS_TABLE.miniBossTimer["Statue"].enabled then
		   return
		end
		
         local id = DAILY_BOSS_TABLE.miniBossTimer["Statue"].id
		 local position = Position(DAILY_BOSS_TABLE.miniBossTimer["Position"][1], DAILY_BOSS_TABLE.miniBossTimer["Position"][2], DAILY_BOSS_TABLE.miniBossTimer["Position"][3])
		 local tile = Tile(position)
		 if tile then
		    local item = tile:getItemById(id) 
		    if not item then
		    item = Game.createItem(id, 1, position)
		    end
		 end
end
		 
local gl = GlobalEvent("miniDailyBoss_displayTimer")
function gl.onThink(interval, lastExecution)
    
	if not miniDailyBoss:getPlayer() then
	   return true
	end
	
	if not miniDailyBoss:getMonster() then
	   return true
	end
	
	local value = miniDailyBoss:getTimeString()
	local position = Position(DAILY_BOSS_TABLE.miniBossTimer["Position"][1], DAILY_BOSS_TABLE.miniBossTimer["Position"][2], DAILY_BOSS_TABLE.miniBossTimer["Position"][3])
	Game.sendTextOnPosition("You have " .. value .. " to kill this boss.", position)
	return true
end
gl:interval(DAILY_BOSS_TABLE.miniBossTimer["Interval"] * 1000)
gl:register()
 
local cScript = CreatureEvent("miniDailyBoss_onLogout")
function cScript.onLogout(player)
   if player == miniDailyBoss:getPlayer() then
      miniDailyBoss:removeMonster()
   end
   miniDailyBoss:teleportPlayer(player)
   miniDailyBoss:removePlayer(player)
return true
end
cScript:register()

cScript = CreatureEvent("miniDailyBoss_onDeath")
function cScript.onDeath(creature, corpse, killer, mostDamage, unjustified, mostDamage_unjustified)
   
    if creature and creature:isPlayer() then
      miniDailyBoss:removePlayer(creature)
	  miniDailyBoss:removeMonster()
      return true
	end
	
	if creature and creature:isMonster() then
      miniDailyBoss:removeMonster()
	  if killer and killer:isPlayer() then
	     miniDailyBoss:teleportPlayer(killer)
		 miniDailyBoss:removePlayer(killer)
		 killer:setStorageValue(Storage.DailyBoss.Mission01, 2)
	     killer:setStorageValue(Storage.DailyBoss.Mission02, 1)
	  end
      return true
	end
	
	return true
end
cScript:register()

cScript = CreatureEvent("miniDailyBoss_onThink")
function cScript.onThink(player)
	local reminder = DAILY_BOSS_TABLE["Mini Boss"]["Reminder"]
	local getTime = miniDailyBoss:getTime()
	
	local value = DAILY_BOSS_TABLE.miniBossTime 
	if reminder == 0 then
	   if value <= 3 then
	      DAILY_BOSS_TABLE["Mini Boss"]["Reminder"] = DAILY_BOSS_TABLE["Mini Boss"]["Reminder"] + 1
	   else
	      if getTime["Minutes"] == 3 and getTime["Seconds"] <= 1 then
	      player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have 3 minutes left to kill this boss.")
		  DAILY_BOSS_TABLE["Mini Boss"]["Reminder"] = DAILY_BOSS_TABLE["Mini Boss"]["Reminder"] + 1
		  end
	   end
	elseif reminder == 1 then
	   if value <= 2 then
	      DAILY_BOSS_TABLE["Mini Boss"]["Reminder"] = DAILY_BOSS_TABLE["Mini Boss"]["Reminder"] + 1
	   else  
	      if getTime["Minutes"] == 2 and getTime["Seconds"] <= 1 then
	      player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have 2 minutes left to kill this boss.")
		  DAILY_BOSS_TABLE["Mini Boss"]["Reminder"] = DAILY_BOSS_TABLE["Mini Boss"]["Reminder"] + 1
		  end
	   end
	elseif reminder == 2 then
	   if value <= 1 then
	      DAILY_BOSS_TABLE["Mini Boss"]["Reminder"] = DAILY_BOSS_TABLE["Mini Boss"]["Reminder"] + 1
	   else 
	      if getTime["Minutes"] == 1 and getTime["Seconds"] <= 1 then
	      player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have 1 minute left to kill this boss.")
		  DAILY_BOSS_TABLE["Mini Boss"]["Reminder"] = DAILY_BOSS_TABLE["Mini Boss"]["Reminder"] + 1
		  end
	   end
	elseif reminder == 3 then
	   if getTime["Minutes"] == 0 and getTime["Seconds"] <= 10 then
	         player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have 10 seconds left to kill this boss.")
		     DAILY_BOSS_TABLE["Mini Boss"]["Reminder"] = DAILY_BOSS_TABLE["Mini Boss"]["Reminder"] + 1
	   end
	elseif reminder == 4 then
	   if getTime["Minutes"] == 0 and getTime["Seconds"] <= 5 then
	         player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have 5 seconds left to kill this boss.")
		     DAILY_BOSS_TABLE["Mini Boss"]["Reminder"] = DAILY_BOSS_TABLE["Mini Boss"]["Reminder"] + 1
	   end
	elseif reminder == 5 then
	   if getTime["Minutes"] == 0 and getTime["Seconds"] <= 0 then
	         DAILY_BOSS_TABLE["Mini Boss"]["Reminder"] = 0
	         player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Timeout! You have failed your mission.")
			 miniDailyBoss:teleportPlayer(player)
			 miniDailyBoss:removePlayer(player)
			 miniDailyBoss:removeMonster()
			 player:unregisterEvent("miniDailyBoss_onThink")
	   end
	end
	   
	return true
end
cScript:register()

local function isEventParticipating(player)
      
	  if not player then
	     return nil
	  end

	  local storage = player:getStorageValue(54978)
	  
	  if storage > 0 then
	     return true
	  end
	  
	  return false
end
	  
local function createTeleports()
      
	  for index, position in pairs(DAILY_BOSS_TABLE.mainBossTeleports["Positions"]) do
	       local id = DAILY_BOSS_TABLE.mainBossTeleports.id
		   local pos = Position(position[1], position[2], position[3])
	       local tile = Tile(pos)
		   if tile then
		      local tp = tile:getItemById(id)
			  if tp then
			     tp:remove()
			  end
			  tp = Game.createItem(id, 1, pos)
			  if tp then
			     tp:setAttribute("aid", 54978)
			  end
		   end
	  end
	  
end

local function removeTeleports()

	  for index, position in pairs(DAILY_BOSS_TABLE.mainBossTeleports["Positions"]) do
	       local id = DAILY_BOSS_TABLE.mainBossTeleports.id
		   local pos = Position(position[1], position[2], position[3])
	       local tile = Tile(pos)
		   if tile then
		      local tp = tile:getItemById(id)
			  if tp then
			     tp:remove()
			  end
		   end
	  end
end

local function finished()
	local boss = Monster(DAILY_BOSS_TABLE["Boss"])
	if boss then
	   boss:remove()
	end
	
	for i = 1, #DAILY_BOSS_TABLE["Statues"]["StatuesID"] do
          local statue = Monster(DAILY_BOSS_TABLE["Statues"]["StatuesID"][i])
          if statue then
             statue:remove()
          end
    end
	removeTeleports()
	Game.setStorageValue(54978, 0)
	addEvent(function()
       local players = Game.getPlayers()
	   for _, player in pairs(players) do
	       if isEventParticipating(player) then
		   player:teleportTo(player:getTown():getTemplePosition())
		   player:setStorageValue(54978, 0)
		   end
       end
    end, 1 * 1000 * 60)

end

local function timeout()
      
   local second = 0
   if DEVELOPER_MODE then
      second = 100
	  else
	  second = 1000
   end
   if Game.getStorageValue(54978) > 0 then
      Game.broadcastMessage("[Daily Boss Event] will end in 5 minutes.", MESSAGE_EVENT_ADVANCE)
   end
   
   addEvent(function()
   if Game.getStorageValue(54978) > 0 then
      Game.broadcastMessage("[Daily Boss Event] will end in 3 minutes.", MESSAGE_EVENT_ADVANCE)
   end
   end, 2 * second * 60)
   
   addEvent(function()
   if Game.getStorageValue(54978) > 0 then
      Game.broadcastMessage("[Daily Boss Event] will end in 2 minutes.", MESSAGE_EVENT_ADVANCE)
   end
   end, 3 * second * 60)

   addEvent(function()
   if Game.getStorageValue(54978) > 0 then
      Game.broadcastMessage("[Daily Boss Event] will end in 1 minute.", MESSAGE_EVENT_ADVANCE)
   end
   end, 4 * second * 60)
   
   addEvent(function()
   if Game.getStorageValue(54978) > 0 then
      Game.broadcastMessage("[Daily Boss Event] has ended.", MESSAGE_EVENT_ADVANCE)
      finished()
   end
   end, 5 * second * 60)
   
end

local function prepare()
	Game.createNpc(DAILY_BOSS_TABLE.npcName, DAILY_BOSS_TABLE.npcPos)
	--Game.createItem(1387, 1, DAILY_BOSS_TABLE.mainBossTeleport)
	local questIndex = 1

	while true do
		if (not Quests[questIndex]) then
			Quests[questIndex] = {
				name = "Daily Boss",
				startStorageId = 52421,
				startStorageValue = 1,
				missions = {
					[1] = {
						name = "Defeat weak boss",
						storageId = 52421,
						missionId = 52421,
						startValue = 1,
						endValue = 2,
						states = {
							[1] = "Ask NPC Peasant to fight with mini-boss " .. DAILY_BOSS_TABLE.miniBossName .. ".",
							[2] = "Well done, you have defeated mini-boss " .. DAILY_BOSS_TABLE.miniBossName .. ".",
						}
					},
					[2] = {
						name = "Ready for boss",
						storageId = 52422,
						missionId = 52422,
						startValue = 1,
						endValue = 1,
						states = {
							[1] = "You are ready to fight " .. DAILY_BOSS_TABLE.bossName .. " everyday at 08:00 A.M and 08:00 P.M.",
						}
					},
				}
			}
			break
		end

		questIndex = questIndex + 1
	end
end

local function countStatues()
      
      local count = 0
      
      for i = 1, #DAILY_BOSS_TABLE["Statues"]["StatuesID"] do
          local statue = Monster(DAILY_BOSS_TABLE["Statues"]["StatuesID"][i])
          if statue then
             count = count + 1
          end
      end
      
      return count
end

local function spawnStatues()
   DAILY_BOSS_TABLE["Statues"]["StatuesID"] = {}
   local name = DAILY_BOSS_TABLE["Statues"].name

   for index, position in pairs(DAILY_BOSS_TABLE["Statues"]["Positions"]) do       
       local pos = Position(position[1], position[2], position[3])
       local statue = Game.createMonster(name, pos, false, true)
       if statue then
          table.insert(DAILY_BOSS_TABLE["Statues"]["StatuesID"], statue:getId())
       end
   end   
end

local function removeBoss()
   local id = DAILY_BOSS_TABLE["Boss"]
   if not id then
      return
   end
   

   local creature = Creature(id)
   if creature then
      creature:remove()
   end
   
   	for i = 1, #DAILY_BOSS_TABLE["Statues"]["StatuesID"] do
          local statue = Monster(DAILY_BOSS_TABLE["Statues"]["StatuesID"][i])
          if statue then
             statue:remove()
          end
    end
	
end

local function spawnBoss()
   local second = 0
   if DEVELOPER_MODE then
      second = 100
	  else
	  second = 1000
   end
   
   Game.broadcastMessage("[Daily Boss Event] will start in 5 minutes.", MESSAGE_EVENT_ADVANCE)
   
   addEvent(function()
   Game.broadcastMessage("[Daily Boss Event] will start in 3 minutes.", MESSAGE_EVENT_ADVANCE)
   end, 2 * second * 60)
   
   addEvent(function()
   Game.broadcastMessage("[Daily Boss Event] will start in 2 minutes.", MESSAGE_EVENT_ADVANCE)
   end, 3 * second * 60)

   addEvent(function()
   Game.broadcastMessage("[Daily Boss Event] will start in 1 minute.", MESSAGE_EVENT_ADVANCE)
   end, 4 * second * 60)
   
   
   addEvent(function()
      removeBoss()
	  local boss = Game.createMonster(DAILY_BOSS_TABLE.bossName, DAILY_BOSS_TABLE.mainBossRoom)
	   if boss then
	      DAILY_BOSS_TABLE["Boss"] = boss:getId()
		  boss:registerEvent("dailyBoss_onDeath")
	   end
	    
	   DAILY_BOSS_TABLE.mainBossRoom:sendMagicEffect(CONST_ME_TELEPORT)
	   spawnStatues()
	   createTeleports()
	   Game.setStorageValue(54978, 1)
	   Game.broadcastMessage("[Boss Event] has begun!", MESSAGE_EVENT_ADVANCE)
	   addEvent(function()
	   timeout()
	   end, 1 * second * 3600)
	   --prepare_interval_storage = BOSS_EVENT_SYSTEM["Configuration"].time * 3600
	end, 5 * second * 60)
	
end

local talkaction = TalkAction("/dailybosson")
function talkaction.onSay(player, words, param)	
    spawnBoss()
return true
end
talkaction:register()

local function healBoss(creatureId)
    
	if not creatureId then
	   return nil
	end
	
	if not countStatues or countStatues() < 1 then
	   return false
	end
	
	local monster = Monster(creatureId)
	
	if not monster then
	   return false
	end
	
	local healthValue = DAILY_BOSS_TABLE["Statues"].healing
	
	if not healthValue or healthValue <= 0 then
	   return false
	end
	
	local count = countStatues()
	
	local value = healthValue * count
	--doTargetCombatHealth(0, monster, value, value, CONST_ME_MAGIC_BLUE)
	doTargetCombatHealth(monster, monster, COMBAT_HEALING, value, value)
	--monster:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
	
end


local events = {
	global = GlobalEvent("DailyBoss"),
	creature = CreatureEvent("DailyBossOnKill"),
	move = MoveEvent(),
	boss1 = GlobalEvent("DailyBoss1"),
	boss2 = GlobalEvent("DailyBoss2"),
}

function events.global.onStartup()
	addEvent(prepare, 200)
end

function events.boss1.onTime(interval)
	spawnBoss()

	return true
end

function events.boss2.onTime(interval)
	spawnBoss()

	return true
end

-- function events.creature.onKill(player, creature, lastHit)
	-- if (not player:isPlayer() or not creature:isMonster() or creature:hasBeenSummoned() or creature:isPlayer() or creature:getName() ~= DAILY_BOSS_TABLE.miniBossName) then
	    -- print("Tu jestem 1")
		-- return true
	-- end
    
	-- print("Tu jestem 2")
	-- player:setStorageValue(Storage.DailyBoss.Mission01, 2)
	-- player:setStorageValue(Storage.DailyBoss.Mission02, 1)

	-- return true
-- end

function events.move.onStepIn(creature, item, position, fromPosition)
	if (not creature:isPlayer()) then
		return false
	end
	

	if (creature:getStorageValue(Storage.DailyBoss.Mission02) < 1) then
		creature:sendTextMessage(MESSAGE_INFO_DESCR, 'You have to defeat ' .. DAILY_BOSS_TABLE.miniBossName .. ' first.')
		creature:teleportTo(fromPosition, true)
		return false
	end
    creature:setStorageValue(54978, 1)
	creature:teleportTo(DAILY_BOSS_TABLE.mainBossRoom, true)
	creature:getPosition():sendMagicEffect(CONST_ME_TELEPORT)

	return true
end

globalevent = GlobalEvent("statueSystem_healing")
function globalevent.onThink(interval, lastExecution)
    
	local monster = Monster(DAILY_BOSS_TABLE["Boss"])
	
	if not monster then
	   return true
	end
	
	if countStatues() < 1 then
	   return true
	end
	healBoss(monster:getId())
	return true
end
globalevent:interval(1000)
globalevent:register()

local creaturescript = CreatureEvent("dailyBoss_onHealthChange")
function creaturescript.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)

	   if not creature then
	      return primaryDamage, primaryType, secondaryDamage, secondaryType
	   end
	   
	   if not attacker then
	      return primaryDamage, primaryType, secondaryDamage, secondaryType
	   end
	   
	   
	   local player = Player(creature)
	   
	   if not player then
	      return primaryDamage, primaryType, secondaryDamage, secondaryType
	   end
	   
	   local bossId = DAILY_BOSS_TABLE["Boss"]
	   if not bossId then
	      return primaryDamage, primaryType, secondaryDamage, secondaryType
	   end
	    
	   local boss = Monster(bossId) 
	   if not boss then
	      return primaryDamage, primaryType, secondaryDamage, secondaryType
	   end
	   
	   if attacker:getId() ~=  bossId then
	      return primaryDamage, primaryType, secondaryDamage, secondaryType
	   end
	   
	   
	   local count = countStatues()
	   if not count or count < 1 then
	      return primaryDamage, primaryType, secondaryDamage, secondaryType
	   end
	   
	   local percentage = DAILY_BOSS_TABLE["Statues"].increaseDamage
	   
	   if not percentage then
	      return primaryDamage, primaryType, secondaryDamage, secondaryType
	   end
	   
	   local value = percentage * count
	   primaryDamage = primaryDamage + (primaryDamage * value)
	   secondaryDamage = secondaryDamage + (primaryDamage * value)
	return primaryDamage, primaryType, secondaryDamage, secondaryType
end
creaturescript:register()

creaturescript = CreatureEvent("dailyBoss_onLogin")
function creaturescript.onLogin(player)
   player:registerEvent("dailyBoss_onHealthChange")
   
   if isEventParticipating(player) then
      player:teleportTo(player:getTown():getTemplePosition())
   end
   
return true
end
creaturescript:register()

creaturescript = CreatureEvent("dailyBoss_onDeath")
function creaturescript.onDeath(creature, corpse, killer, mostDamage, unjustified, mostDamage_unjustified)
   Game.broadcastMessage("[Daily Boss Event] The boss has been defeated! Congratulations!", MESSAGE_EVENT_ADVANCE)
   finished()
   return true
end
creaturescript:register()

events.global:register()
events.boss1:time("10:00:00")
events.boss1:register()
events.boss2:time("22:00:00")
events.boss2:register()
--events.creature:register()
events.move:aid(54978)
events.move:register()