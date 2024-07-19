-- CREATE TABLE `server_status` (
  -- `day` varchar(255) NOT NULL DEFAULT '',
  -- `restarted` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  -- `players` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin CHECK (json_valid(`players`))
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- INSERT INTO `server_status` (`day`, `restarted`, `players`) VALUES ('not set', '0', '{}');

if not DAILY_RESTARTER then
    DAILY_RESTARTER = {}
end

function DAILY_RESTARTER:setDay(value)
    local sql = "UPDATE `server_status` SET `day` = " .. db.escapeString(value)
    db.query(sql)
	
	self.day = value
end

function DAILY_RESTARTER:getDay()
    return self.day
end

function DAILY_RESTARTER:setRestarted(value)
	if not value then
	    value = 0
	else
	    value = 1
	end
	
    local sql = "UPDATE `server_status` SET `restarted` = " .. value 
    db.query(sql)
	self.restarted = value
end

function DAILY_RESTARTER:getRestarted()
    if self.restarted then
	    return self.restarted
	end
   	local resultQuery = db.storeQuery("SELECT restarted FROM `server_status`")
	if resultQuery then	
	    local restarted = result.getDataInt(resultQuery, "restarted")
	    result.free(resultQuery)
        self.restarted = restarted
		return restarted
	end
	return 0
end
	
function DAILY_RESTARTER:checkDay()
   	local resultQuery = db.storeQuery("SELECT day FROM `server_status`")
	if resultQuery then
	    local day = result.getDataString(resultQuery, "day")
		local currentDay = os.date("%A")
		if day ~= currentDay then
		    self:setRestarted(false)
			self:setDay(currentDay)
			self:resetPlayers()
		end
		if not DAILY_RESTARTER.day then
		    self.day = day
		end
		result.free(resultQuery)
	end
end

function scheduleRestart()
	if DAILY_RESTARTER:getRestarted() == 1 then
	    return true
	end
	
	local configTime = getConfigInfo('dailyTaskRestart')
	configTime = configTime:gsub(":", "")
	configTime = tonumber(configTime)
	
	local currentTime = os.date("%H:%M")
	currentTime = currentTime:gsub(":", "")
	currentTime = tonumber(currentTime)
	
	if currentTime >= configTime then
	    local players = Game.getPlayers()
	    for _, player in ipairs(players) do
	        DAILY_TASK_MONSTER_SYSTEM:restartTasks(player)
			DAILY_RESTARTER:addPlayer(player:getName())
	    end
	    Game.broadcastMessage("Daily Tasks has been restarted.", MESSAGE_GAME_HIGHLIGHT)
		DAILY_TASK_MONSTER_SYSTEM.dailyRestarted = true
		DAILY_RESTARTER:setRestarted(true)
		DAILY_RESTARTER:savePlayers()
	    return true
	end
	
	addEvent(scheduleRestart, 10000)
end

function DAILY_RESTARTER:resetPlayers()
    local sql = "UPDATE `server_status` SET `players` = " .. db.escapeString("{}")
    db.query(sql)
	self:fetchPlayers()
end

function DAILY_RESTARTER:fetchPlayers()
    local resultQuery = db.storeQuery("SELECT players FROM `server_status`")
	if resultQuery then
		self.players = json.decode(result.getDataString(resultQuery, "players"))
	end
end
	
function DAILY_RESTARTER:addPlayer(name)
	if self:isAdded(name) then
	    return false
	end
	self.players[name] = true
end

function DAILY_RESTARTER:savePlayers()
    local sql = "UPDATE `server_status` SET `players` = " .. db.escapeString(json.encode(self.players))
    db.query(sql)   
end

function DAILY_RESTARTER:isAdded(name)
    if not self.players then
	    return false
	end
	return self.players[name]
end

local globalevent = GlobalEvent("load_DAILY_RESTARTER")
function globalevent.onStartup()
	DAILY_RESTARTER:checkDay()
	DAILY_RESTARTER:fetchPlayers()
	scheduleRestart()
end
globalevent:register()

local creatureevent = CreatureEvent('onLogin_DAILY_RESTARTER')
function creatureevent.onLogin(player)
    if DAILY_RESTARTER:getRestarted() == 1 then
	    local name = player:getName()
	    if not DAILY_RESTARTER:isAdded(name) then
		    DAILY_TASK_MONSTER_SYSTEM:restartTasks(player)
			DAILY_RESTARTER:addPlayer(name)
			DAILY_RESTARTER:savePlayers()
		end
	end
	return true
end
creatureevent:register()
	
	




