if not SEASON_RESTART_SYSTEM then
    SEASON_RESTART_SYSTEM = {}
	SEASON_RESTART_SYSTEM.events = {}
end

SEASON_RESTART_SYSTEM.config = {
                                    ["season_start"] = "00",
                                    ["season_duration"] = { type = "day", value = "28" },
							   }

SEASON_RESTART_SYSTEM.tables = {
                                 ["main_table"] = "season_scheduler",
								 ["history_table"] = "season_history",
                                 ["event_table"] = "logs_players"
							   }
							   
-- CREATE TABLE `season_scheduler` (
	-- `start_time` int DEFAULT NULL,
	-- `end_time` int DEFAULT NULL
-- )

-- CREATE TABLE `season_history` (
  -- `id` int(11) NOT NULL AUTO_INCREMENT,
  -- `ranking` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`ranking`)),
  -- PRIMARY KEY (id)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

function SEASON_RESTART_SYSTEM:saveHistory()
    local t = {}
	local resultQuery = db.storeQuery("SELECT * FROM " .. self.tables["event_table"] .. " WHERE `event_name` = " .. '"Survival"' .. " ORDER BY " .. "points DESC LIMIT 15")
	if resultQuery ~= false then	
        t["Points"] = {}		
	    repeat
	        local player_id = result.getNumber(resultQuery, "player_id")
		    local points = result.getNumber(resultQuery, "points")
			local kills_total = result.getNumber(resultQuery, "kills_total")
			local kills_combo = result.getNumber(resultQuery, "kills_combo")
			local kills_assistance = result.getNumber(resultQuery, "kills_asistance")
			local name = NIIDE_LIB:getNameByGuid(player_id)
			local values = { ["name"] = name, ["player_id"] = player_id, ["points"] = points, ["total kills"] = kills_total, ["combo kills"] = kills_combo, ["assistance kills"] = kills_assistance  }
			table.insert(t["Points"], values)
		until not result.next(resultQuery)
	end
	local resultQuery = db.storeQuery("SELECT * FROM " .. self.tables["event_table"] .. " WHERE `event_name` = " .. '"Survival"' .. " ORDER BY " .. "kills_total DESC LIMIT 15")
	if resultQuery ~= false then	
        t["Kills"] = {}		
	    repeat
	        local player_id = result.getNumber(resultQuery, "player_id")
		    local kills = result.getNumber(resultQuery, "kills_total")
			local values = { ["player_id"] = player_id, ["kills"] = kills }
			table.insert(t["Kills"], values)
		until not result.next(resultQuery)
	end

	local resultQuery = db.storeQuery("SELECT * FROM " .. self.tables["event_table"] .. " WHERE `event_name` = " .. '"Survival"' .. " ORDER BY " .. "kills_combo DESC LIMIT 15")
	if resultQuery ~= false then	
        t["Kills Combo"] = {}		
	    repeat
	        local player_id = result.getNumber(resultQuery, "player_id")
		    local kills = result.getNumber(resultQuery, "kills_combo")
			local values = { ["player_id"] = player_id, ["kills"] = kills }
			table.insert(t["Kills Combo"], values)
		until not result.next(resultQuery)
	end	
		
	sql = "INSERT INTO " .. self.tables["history_table"] .. " (`ranking`)"
    sql = sql .. " VALUES " 
    sql = sql .. "("
    sql = sql .. db.escapeString(json.encode(t))
	sql = sql .. ")"
	db.query(sql)
end

function SEASON_RESTART_SYSTEM:getInterval()
    
	local method = self.config["season_duration"].type
	local value = self.config["season_duration"].value
	
    
    if string.find(method, "second") then
	   value = value
    elseif string.find(method, "minute") then
	   value = value * 60
    elseif string.find(method, "hour") then 
	   value = value * 60 * 60
    elseif string.find(method, "day") then
	   value = value * 86400
	end
	
	return value
end

function SEASON_RESTART_SYSTEM:setInterval()
    local interval = self:getInterval()
   
    --local resultQuery = db.storeQuery("SELECT `start_time`, `end_time` FROM " .. self.tables["main_table"] .. " WHERE `id` = 1")
	
	local start_time = os.time()
	local end_time = os.time() + interval
	local resultQuery = db.storeQuery("SELECT `start_time`, `end_time` FROM " .. self.tables["main_table"])
    if resultQuery then
	    local sql = "UPDATE " .. self.tables["main_table"] .. " SET"
		sql = sql .. " `start_time` = " .. start_time
		sql = sql .. ","
		sql = sql .. " `end_time` = " .. end_time
		db.query(sql)
	    result.free(resultQuery)
    else
	    local sql = "INSERT INTO " .. self.tables["main_table"] .. " (`start_time`, `end_time`)"
	    sql = sql .. " VALUES " 
        sql = sql .. "("
	    sql = sql .. start_time
	    sql = sql .. ", "
	    sql = sql .. end_time
	    sql = sql .. ")"	
	    db.query(sql)
	end
	
	if not self.info then
	    self.info = {}
	end
	self.info["start_time"] = start_time
	self.info["end_time"] = end_time
end
   
function SEASON_RESTART_SYSTEM:startSeason()
	print("Season Restarted!")
	--save Season
	self:saveHistory()
	
	local playersTable = SEASON_REWARDS_SYSTEM:getData()
	if playersTable then
	    local method = "Points"
	    local t = playersTable[method]
		if t then
			for i, v in ipairs(t) do
		        local player = Player(v.name)
			    if player then
					SEASON_REWARDS_SYSTEM:sendWindow(player, method)
			    else
				    SEASON_REWARDS_SYSTEM:setUnclaimedReward(v.player_id)
				end
			end
		end
	end

	if SEASON_RESTART_SYSTEM:isStarted() then
	    db.query("TRUNCATE TABLE " .. self.tables["event_table"])
	end
	--newSeason
	self:setInterval()
	self:ScheduleEnd()
end

function SEASON_RESTART_SYSTEM:fetchInfo()
    if not self.info then
	    self.info = {}
	end
	
	local resultQuery = db.storeQuery("SELECT `start_time`, `end_time` FROM " .. self.tables["main_table"])
    if resultQuery then
        self.info["start_time"] = result.getNumber(resultQuery, "start_time")
		self.info["end_time"] = result.getNumber(resultQuery, "end_time")
		self:ScheduleEnd()
		return true
	end
end
		
function SEASON_RESTART_SYSTEM:getStartTime()
   return self["start_time"]
end	

function SEASON_RESTART_SYSTEM:getEndTime()
    return self.info["end_time"]
end

function SecToStr(a,b,c) -- Time in seconds, Precision, Delimiter
    local a = math.ceil( math.abs(a) ) or 0
    local b = b or 7
    local c = c or ' '
    if a == math.huge or a == -math.huge then
        return ' ∞ '
    end
    local d = {3153600000,31536000,2592000,86400,3600,60,1}
    local e = {'C','Y','M','D','h','m','s'}
    local g = {}
    for i, v in ipairs(e) do
        local h = math.floor( a / d[i] )
        if h ~= h then
            return table.concat(g, c)
        end
        if b > 0 and ( h > 0 or #g > 0) then
            a = a - h * d[i]
            if h > 0 then
                table.insert(g, h..v)
            end
            b = h==0 and b or b - 1
        end
    end
    return table.concat(g, c)
end

function SEASON_RESTART_SYSTEM:getEndTimeString()
    if not self:getEndTime() then
	    return "28 Days"
	end
	
	local timeleft = self:getEndTime() - os.time()
	return math.floor(timeleft / 86400) ..  " Days"
end
	
function SEASON_RESTART_SYSTEM:ScheduleEnd()
    if not self:isStarted() then
	    return true
	end
	
	if self.events.scheduleEnd then
	    stopEvent(self.events.scheduleEnd)
	end
	
	self.events.scheduleEnd = addEvent(function()
	    if self:getEndTime() < os.time() then
		    self:startSeason()
			return true
		end
		self:ScheduleEnd()
	end, 1 * 1000 * 60)
end

function SEASON_RESTART_SYSTEM:ScheduleStart()
    if self.events.scheduleStart then
	    stopEvent(self.events.scheduleStart) 
    end		
	
	self.events.scheduleStart = addEvent(function()
	    local currentTime = os.date("%H")
		--if self.config["season_start"] == currentTime then
		    self:startSeason()
			return true
		--end
	end, 1 * 1000 * 60)
end

function SEASON_RESTART_SYSTEM:onStartUp()
    if self:isStarted() then
	    self:fetchInfo()
		return true
	end
	self:ScheduleStart()
end

function SEASON_RESTART_SYSTEM:isStarted()
    local resultQuery = db.storeQuery("SELECT `start_time`, `end_time` FROM " .. self.tables["main_table"])
    if resultQuery then
	    result.free(resultQuery)
		return true
	end
	return false
end
	

local globalevent = GlobalEvent("load_SEASON_RESTART_SYSTEM")
function globalevent.onStartup()	
	SEASON_RESTART_SYSTEM:onStartUp()
end
globalevent:register()