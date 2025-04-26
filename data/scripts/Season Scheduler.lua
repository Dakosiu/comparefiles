-- CREATE TABLE `season_scheduler` (
  -- `date` BIGINT NOT NULL DEFAULT 0,
  -- `restarted` tinyint(1) UNSIGNED NOT NULL DEFAULT 0
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--INSERT INTO `season_scheduler` (`date`, `restarted`) VALUES ('0', '0');



if not SEASON_RESTART_SYSTEM then
    SEASON_RESTART_SYSTEM = {}
end


							   
SEASON_RESTART_SYSTEM.config = {
                                    ["season_start"] = "22:00",
									["season_end"] = "24:00",
                                    ["season_duration"] = { type = "hour", value = "2" },
									--["season_hour"] = { "00" }
							   }
							   
							   
SEASON_RESTART_SYSTEM.tables = {
                                 ["main_table"] = "season_scheduler",
								 ["history_table"] = "season_history",
                                 ["event_table"] = "logs_players"
							   }							   



function SEASON_RESTART_SYSTEM:canEnterEvent()
    if not self.canEnter then
	    return false
	end
	
	return self.canEnter
end


function SEASON_RESTART_SYSTEM:setCanEnterEvent(boolean)
    self.canEnter = boolean
end

function SEASON_RESTART_SYSTEM:getScheduleString()
    return "Sorry this event is only avaible at " .. self.config["season_start"] .. " to " .. self.config["season_end"] .. " CET."
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

function SEASON_RESTART_SYSTEM:fetchDate()
	local resultQuery = db.storeQuery("SELECT `date`, `restarted` FROM " .. self.tables["main_table"])
    if not resultQuery then
	    print(">> [Season Scheduler] - Error in database.")
		return false
	end
	
	self.date = result.getNumber(resultQuery, "date")
	self.restarted = result.getNumber(resultQuery, "restarted")
	return true
end

function SEASON_RESTART_SYSTEM:isRestarted()
    if self:getRestarted() > 0 then
	    return true
	end
	return false
end

function SEASON_RESTART_SYSTEM:getRestarted()
    local data = self.restarted
	if not data then
	    local resultQuery = db.storeQuery("SELECT `restarted` FROM " .. self.tables["main_table"])
        if not resultQuery then
	        print(">> [Season Scheduler] - Error in database.")
		    return false
		end
		self.restarted = result.getNumber(resultQuery, "restarted")
	end    
    return self.restarted    
end

function SEASON_RESTART_SYSTEM:getDate()
    local season_date = self.date
	if not season_date then
	    local resultQuery = db.storeQuery("SELECT `date` FROM " .. self.tables["main_table"])
        if not resultQuery then
	        print(">> [Season Scheduler] - Error in database.")
		    return false
		end
		self.date = result.getNumber(resultQuery, "date")
	end    
    return self.date    
end
	
	
function SEASON_RESTART_SYSTEM:getTimeString()
   
   
    if not SEASON_RESTART_SYSTEM:canEnterEvent() then
        return "Season will start at " .. SEASON_RESTART_SYSTEM.config["season_start"] .. " CET"
    end
	

    str = "Season will end at " .. SEASON_RESTART_SYSTEM.config["season_end"] .. " CET" 
   
   
   
  -- local time_left = self:getDate() - os.time()
  -- local days = math.floor(time_left/86400)
  -- local remaining = time_left % 86400
  -- local hours = math.floor(remaining/3600)
  -- remaining = remaining % 3600
  -- local minutes = math.floor(remaining/60)
  -- remaining = remaining % 60
  -- local seconds = remaining
  
  -- str = ""
  
  -- local isStarted = false
  
  -- if days > 0 then
     -- str = str .. days .. " days"
	 -- isStarted = true
  -- end
  
  -- if hours > 0 then
     -- if isStarted then
	    -- str = str .. ", "
	 -- end
	 -- str = str .. hours .. " hours"
	 -- isStarted = true
  -- end

  -- if minutes > 0 then
     -- if isStarted then
	    -- str = str .. ", "
	 -- end
	 -- str = str .. minutes .. " minutes"
	 -- isStarted = true
  -- end
  
  -- if seconds > 0 then
     -- if days == 0 and hours == 0 and minutes == 0 then
	    -- str = seconds .. " seconds"
     -- -- elseif minutes > 0 then
	    -- -- str = str .. " and " .. seconds .. " seconds"
	 -- end
  -- end
  
   -- str = str .. "."
   return str
end


function SEASON_RESTART_SYSTEM:scheduleRestart()
    -- if not SEASON_RESTART_SYSTEM:isRestarted() then
	    -- SEASON_RESTART_SYSTEM:processRestart()
		-- return true
	-- end
	
	local function scheduler()
	   -- print(">> Sprawdzam co minute")
		local currentDate = NIIDE_LIB:GetCurrentDateInNumber()
		--print("Hour String: " .. currentDate)
		local startEvent = NIIDE_LIB:TimeFromStringToNumber(SEASON_RESTART_SYSTEM.config["season_start"])
		--print("Start Event: " .. startEvent)
		local endEvent = NIIDE_LIB:TimeFromStringToNumber(SEASON_RESTART_SYSTEM.config["season_end"])
		--print("End Event: " .. endEvent)
		
		
		if self:canEnterEvent() then
		   -- print("Event is open.")
		else
		   -- print("Event is closed.")
		end
		
		if not self:canEnterEvent() then
		    if currentDate >= startEvent and currentDate < endEvent then
			    --print("Set enter even't back.")
			    SEASON_RESTART_SYSTEM:setCanEnterEvent(true)
			end
		else
		    if currentDate >= endEvent then
			   -- print("Event Ended.")
			    SEASON_RESTART_SYSTEM:setCanEnterEvent(false)
				SEASON_RESTART_SYSTEM:processRestart()
			end
		end
			    
	    addEvent(scheduler, 60 * 1000)
	end
	scheduler()
	return true
end

function SEASON_RESTART_SYSTEM:saveHistory()
    local t = {}
	t["Points"] = {}	
	t["Kills"] = {}	
	t["Kills Combo"] = {}
		
	local resultQuery = db.storeQuery("SELECT * FROM " .. self.tables["event_table"] .. " WHERE `event_name` = " .. '"Rival"' .. " ORDER BY " .. "points DESC LIMIT 15")
	if resultQuery ~= false then	
	
	    repeat
		    local points = result.getNumber(resultQuery, "points")
			if points > 0 then
	            local player_id = result.getNumber(resultQuery, "player_id")
			    local kills_total = result.getNumber(resultQuery, "kills_total")
			    local kills_combo = result.getNumber(resultQuery, "kills_combo")
			    local kills_assistance = result.getNumber(resultQuery, "kills_asistance")
			    local name = NIIDE_LIB:getNameByGuid(player_id)
			    local values = { ["name"] = name, ["player_id"] = player_id, ["points"] = points, ["total kills"] = kills_total, ["combo kills"] = kills_combo, ["assistance kills"] = kills_assistance  }
				--print("Points Gracza:" .. name .. " : " .. points)
				table.insert(t["Points"], values)
			end
			
		until not result.next(resultQuery)
	end
	
	local resultQuery = db.storeQuery("SELECT * FROM " .. self.tables["event_table"] .. " WHERE `event_name` = " .. '"Rival"' .. " ORDER BY " .. "kills_total DESC LIMIT 15")
	if resultQuery ~= false then		
	    repeat
	        local player_id = result.getNumber(resultQuery, "player_id")
		    local kills = result.getNumber(resultQuery, "kills_total")
			local name = NIIDE_LIB:getNameByGuid(player_id)
			local values = { ["name"] = name, ["player_id"] = player_id, ["kills"] = kills }
			table.insert(t["Kills"], values)
		until not result.next(resultQuery)
	end

	local resultQuery = db.storeQuery("SELECT * FROM " .. self.tables["event_table"] .. " WHERE `event_name` = " .. '"Rival"' .. " ORDER BY " .. "kills_combo DESC LIMIT 15")
	if resultQuery ~= false then	
        		
	    repeat
	        local player_id = result.getNumber(resultQuery, "player_id")
			local name = NIIDE_LIB:getNameByGuid(player_id)
		    local kills = result.getNumber(resultQuery, "kills_combo")
			local values = { ["name"] = name, ["player_id"] = player_id, ["kills"] = kills }
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

function SEASON_RESTART_SYSTEM:processRestart()
    print(">> [Season Scheduler] - Season Restarted.")
	local resultQuery = db.storeQuery("SELECT `restarted`, `date` FROM " .. self.tables["main_table"])
    if not resultQuery then
	    print(">> [Season Scheduler] - Error in database.")
		return false
	end
	local interval = self:getInterval() + os.time()
	
	self.date = interval
	self.restarted = 1
	
	local sql = "UPDATE " .. self.tables["main_table"] .. " SET"
	sql = sql .. " `restarted` = " .. self.restarted
	sql = sql .. ","
	sql = sql .. " `date` = " .. self.date
	db.query(sql)
	result.free(resultQuery)
	
	self:saveHistory()
	local cachedPlayers = {}
	local playersTable = SEASON_REWARDS_SYSTEM:getData()
	if playersTable then
	    local playerData = {}
	    for method, v in pairs(playersTable) do
		    for b, c in ipairs(v) do
			    if not c.name then
				    c.name = "Empty"
				end
			    local player = Player(c.name)
				if not playerData[c.name] then
				   playerData[c.name] = {}
				end
				if not playerData[c.name].rewards then
				    playerData[c.name].rewards = {}
				end
				
			    local rewards = SEASON_REWARDS_SYSTEM:getRewardsTable(b, method)
				if rewards then
				    for x, n in pairs(rewards) do
				        if not playerData[c.name].rewards[x] then
						    playerData[c.name].rewards[x] = 0
						end
						playerData[c.name].rewards[x] = playerData[c.name].rewards[x] + n
					end
				end
			end
		end
		
		for playerName, v in pairs(playerData) do
		    local player = Player(playerName)
			if player then
			    SEASON_REWARDS_SYSTEM:addRewards(player, v.rewards)
			    SEASON_REWARDS_SYSTEM:sendWindow(player, "Rivals")
			end
		end
	end
	
	
	db.query("TRUNCATE TABLE " .. self.tables["event_table"])
	
	
	

	for _, player in ipairs(Game.getPlayers()) do
		DIVISION_SYSTEM:restartDivision(player)
	end
	
	
	--for _, name in ipairs(getOnlinePlayers()) do
	
	
	--DIVISION_SYSTEM:restartDivision(player)
	
	
	
	
	
	Game.broadcastMessage("Season has been restarted.", MESSAGE_EVENT_ADVANCE)
end

local globalevent = GlobalEvent("load_SEASON_RESTART_SYSTEM")
function globalevent.onStartup()
    print(">> Load Season Scheduler v.3.0")
	SEASON_RESTART_SYSTEM:fetchDate()
	SEASON_RESTART_SYSTEM:scheduleRestart()
end
globalevent:register()
							   