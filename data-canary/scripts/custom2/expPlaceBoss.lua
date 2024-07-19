-- CREATE TABLE `players_bosses` (
  -- `id` int NOT NULL AUTO_INCREMENT,
  -- `player_id` int(11) NOT NULL,
  -- `points` int(11) NOT NULL DEFAULT 0,
  -- PRIMARY KEY (id)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


if not expPlaceBoss then
   expPlaceBoss = {
    restarter = {
	              day = "Friday",
				  time = "00:50"
	            },
	rewards = {
	            [1] = { ---- first place i tak dalej
			            { type = "item", name = "crystal coin", count = 5 },
						{ type = "item", name = "boots of haste", count = 1 },
						{ type = "item", itemid = 42339, count = 1 },
				      },
	            [2] = { ---- first place i tak dalej
			            { type = "item", name = "crystal coin", count = 3 },
						{ type = "item", name = "boots of haste", count = 1 },
				      },	
	            [3] = { ---- first place i tak dalej
			            { type = "item", name = "crystal coin", count = 1 },
						{ type = "item", name = "boots of haste", count = 1 },
				      },					  
			  },
	delayTime = 2 * 60 * 60, -- 2 hours
	defaultDistance = 30,
	database = "players_bosses",
	bosses = {
		{name = 'Teleskor', pos = Position(1007, 1303, 8), place = 'Skeleton', distance = 5, points = 3},
		{name = 'The Old Widow', pos = Position(1043, 1296, 8), place = 'Giant Spider', distance = 5, points = 5},
		{name = 'Fernfang', pos = Position(1099, 1206, 8), place = 'Hero', points = 3},
		{name = 'Demodras', pos = Position(1212, 1204, 8), place = 'Dragon', points = 3},
		{name = 'The Blightfather', pos = Position(1113, 962, 7), place = 'Forest Fury', distance = 5, points = 5},
		{name = 'Tromphonyte', pos = Position(1388, 1137, 8), place = 'Stampor', distance = 5, points = 5},
		{name = 'Ribstride', pos = Position(1323, 987, 8), place = 'Mummy', distance = 5, points = 3},
		{name = 'Zomba', pos = Position(1153, 1025, 8), place = 'Noble Lion', distance = 5, points = 5},
		{name = 'Munster', pos = Position(1193, 916, 8), place = 'Corym', distance = 5, points = 3},
		{name = 'Boogey', pos = Position(1304, 784, 8), place = 'Grim Reaper', distance = 5, points = 1},
		{name = 'Irgix The Flimsy', pos = Position(969, 858, 8), place = 'Flimsy Lost Soul', distance = 5, points = 5},
		{name = 'The Baron from Below', pos = Position(1309, 1031, 8), place = 'Yielothax', distance = 5, points = 3},
		{name = 'Gorgo', pos = Position(1233, 1091, 8), place = 'Medusa', distance = 5, points = 2},
		{name = 'The Voice Of Ruin', pos = Position(1080, 1048, 7), place = 'Lizard Chosen', distance = 5, points = 3},
		{name = 'Hirintror', pos = Position(1058, 1060, 7), place = 'Crystal Crusher', distance = 5, points = 4},
		{name = 'Sir Valorcrest', pos = Position(1200, 839, 8), place = 'Vampire', distance = 5, points = 5},
		{name = 'The Pale Count', pos = Position(1201, 839, 8), place = 'Vampire', distance = 5, points = 3},
		{name = 'Lisa', pos = Position(1087, 877, 8), place = 'Glooth Bandit', distance = 5, points = 2},
		{name = 'Man in the Cave', pos = Position(873, 1062, 9), place = 'Leaf Golem', distance = 5, points = 1},
		{name = 'Countess Sorrow', pos = Position(1235, 894, 10), place = 'Rapper Spectre', distance = 5, points = 2},
		{name = 'Zoralurk', pos = Position(1438, 1106, 9), place = 'Demon', distance = 5, points = 3},
		{name = 'The Count of the Core', pos = Position(1338, 863, 8), place = 'Burster Spectre', distance = 5, points = 4},
		{name = 'Mr. Punish', pos = Position(1313, 630, 8), place = 'Dark Torturer', distance = 5, points = 5},
		{name = 'The Plasmother', pos = Position(737, 1448, 8), place = 'Defiler', distance = 5, points = 5},
		{name = 'Mahrdis', pos = Position(1610, 697, 8), place = 'Putrid Mummy', distance = 5, points = 3},
    	{name = 'The Old Whopper', pos = Position(1649, 807, 8), place = 'Cyclops', distance = 5, points = 2},
		{name = 'Brokul', pos = Position(1307, 1062, 9), place = 'Sea Serpent', distance = 5, points = 3},
		{name = 'Terofar', pos = Position(1324, 1259, 8), place = 'Tunnel Tyrant', distance = 5, points = 2},
		{name = 'Lady Tenebris', pos = Position(1248, 1192, 8), place = 'Gazer Spectre', distance = 5, points = 1},
	},
	onThink = function(uid)
		local monster = Monster(uid)

		if (not monster) then
			return true
		end
		
		for index, boss in ipairs(expPlaceBoss.bosses) do
			if (boss.uid and boss.uid == monster.uid) then
				local spawnDistance = monster:getPosition():getDistance(boss.pos)

				if ((boss.distance and spawnDistance > boss.distance) or (not boss.distance and spawnDistance > expPlaceBoss.defaultDistance)) then
					monster:getPosition():sendMagicEffect(CONST_ME_POFF)
					monster:teleportTo(boss.pos, true)
					monster:setHealth(monster:getMaxHealth())
					monster:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				end

				break
			end
		end
	end,
	onDisappear = function(uid)
		local monster = Monster(uid)

		if (not monster) then
			return true
		end

		for index, boss in ipairs(expPlaceBoss.bosses) do
			if (boss.uid and boss.uid == monster.uid) then
				expPlaceBoss.bosses[index].uid = nil
				expPlaceBoss.bosses[index].timestamp = os.time()
				break
			end
		end
	end,
}
end


function expPlaceBoss:shouldRestart()
	local currentDay = os.date("%A")
	if currentDay == self.restarter.day then
	   return true
	end
	return false
end
	

expPlaceBoss.isRetarded = false

function expPlaceBoss:getTable(name)
	for i, v in pairs(self.bosses) do
	    if v.name == name or v.name:lower() == name:lower() then
		   return v
		end
	end
	return false
end

function expPlaceBoss:addPoints(player, value)
	local database = self.database
	local id = player:getGuid()
	local resultQuery = db.storeQuery("SELECT `points` FROM " .. database .. " WHERE `player_id` = " .. id)
    local points = 0
	if resultQuery ~= false then
	   points = result.getDataInt(resultQuery, "points")
	   result.free(resultQuery)
	   local sql = "UPDATE " .. database .. " SET"
	   sql = sql .. " `points` =" .. points + value
	   sql = sql .. " WHERE `player_id` =" .. id
       db.query(sql)
	else
	   db.query("INSERT INTO " .. database .. " (`player_id`, `points`) VALUES (" .. id .. ", " .. points + value .. ")")
    end
end

function expPlaceBoss:resetPoints()    	
	local database = self.database
	local resultQuery = db.storeQuery("SELECT `player_id`, `points` FROM " .. database)   
	if resultQuery ~= false then
       repeat
	   local id = result.getDataInt(resultQuery, "player_id")
	   local sql = "UPDATE " .. database .. " SET"
	   sql = sql .. " `points` =" .. 0
	   sql = sql .. " WHERE `player_id` =" .. id
       db.query(sql)
	   until not result.next(resultQuery)
       result.free(resultQuery) 
    end
end

function expPlaceBoss:addRewards()
   local resultQuery = db.storeQuery("SELECT `player_id`, `points` FROM " .. self.database .. " ORDER BY `points` DESC LIMIT " .. #self.rewards)
   if resultQuery ~= false then
      local index = 1
      repeat
	    local id = result.getDataInt(resultQuery, "player_id")
        local player = Player(id)
	    if not player then
	       player = Game.getOfflinePlayer(id)
	    end
		local rewardTable = self.rewards[index]
		local inbox = player:getSlotItem(CONST_SLOT_STORE_INBOX)
		dakosLib:addReward(player, rewardTable, false, false, false, inbox)
		player:save()
		index = index + 1
      until not result.next(resultQuery)	
	  result.free(resultQuery) 
   end
end
   
   
   
for index, boss in ipairs(expPlaceBoss.bosses) do
	boss.timestamp = 1
end

local events = {
	global = GlobalEvent('ExpPlaceBoss'),
	talk = TalkAction('!boss'),
}

function events.global.onThink()
	for index, boss in ipairs(expPlaceBoss.bosses) do
		if (boss.uid) then -- do nothing, boss is still on the map
		elseif (boss.timestamp < os.time() - expPlaceBoss.delayTime) then
			local mid = Game.createMonster(boss.name, boss.pos)

			if (mid) then
				expPlaceBoss.bosses[index].uid = mid.uid
				boss.pos:sendMagicEffect(CONST_ME_TELEPORT)
			end
		end
	end

	return true
end

function events.talk.onSay(player, words, param)
	local message = 'Current exp boss list:'

	for index, boss in ipairs(expPlaceBoss.bosses) do
		if (boss.uid or boss.timestamp > 1) then
			message = message .. "\n\n" .. boss.name .. ' - '

			if (boss.uid) then
				message = message .. 'still on the ' .. boss.place .. ' exp'
			else
				local spawnDifference = boss.timestamp + expPlaceBoss.delayTime - os.time()

				local hours = math.floor(spawnDifference / 3600)
				spawnDifference = spawnDifference - hours * 3600
				local minutes = math.floor(spawnDifference / 60)
				spawnDifference = spawnDifference - minutes * 60
				message = message .. 'will spawn on the ' .. boss.place .. ' exp in'

				if (hours) then
					message = message .. ' ' .. hours .. 'h'
				end

				if (minutes) then
					message = message .. ' ' .. minutes .. 'm'
				end

				if (spawnDifference) then
					message = message .. ' ' .. spawnDifference .. 's'
				end
			end
		end
	end

	player:showTextDialog(22706, message)
end
events.global:interval(15 * 1000) -- every 15s
events.global:register()
events.talk:register()


local creaturescript = CreatureEvent("expPlaceBoss_onDeath")
function creaturescript.onDeath(creature, corpse, killer, mostDamage, unjustified, mostDamage_unjustified)	
    
	print("Tu jestem 1")
    if not creature:isMonster() then
        return false
    end
	
    if creature:getMaster() ~= nil then
        return false
    end
	
    local player = Player(mostDamage)
	if not player then
	   return false
	end
		
	local t = expPlaceBoss:getTable(creature:getName())
	
	if not t then
	   return true
	end
	
	local points = t.points
	expPlaceBoss:addPoints(player, points)
	player:say("+" .. points .. " Boss Points.")
	--player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have got " .. points .. " boss points by killing " .. creature:getName() .. ".")
	Game.broadcastMessage("Player " .. player:getName() .. " killed " .. creature:getName() .. ".", MESSAGE_GAME_HIGHLIGHT)
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	return true
end
creaturescript:register()

local globalevent = GlobalEvent("expPlaceBoss_onStartup")
function globalevent.onStartup()	
    if expPlaceBoss:shouldRestart() then
	   local globalevent2 = GlobalEvent("expPlaceBoss_onThink")
	   local isRestarted = false
	   function globalevent2.onThink()
	      if isRestarted then
		     return true
	      end
	      local currentTime = os.date("%H:%M")
		  currentTime = dakosLib:convertTimeToNumber(currentTime)
		  if currentTime >= dakosLib:convertTimeToNumber(expPlaceBoss.restarter.time) then
		     expPlaceBoss:resetPoints()
			 expPlaceBoss:addRewards()
			 Game.broadcastMessage("Boss points been restarted.", MESSAGE_GAME_HIGHLIGHT)
		     isRestarted = true		  
		  end
		  return true
	   end
	   globalevent2:interval(1000 * 60) 
	   globalevent2:register()
	end
end
globalevent:register()