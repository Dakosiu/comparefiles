if not SEASON_TITLE_SYSTEM then
    SEASON_TITLE_SYSTEM = {}
end

SEASON_TITLE_SYSTEM.config = {
                                minGames = 1,
                                ["Titles"] = {
								                [1] = { name = "Arena Challenger", points = 8000 },
												[2] = { name = "Arena Grandmaster", points = 7000 },
												[3] = { name = "Arena Master", points = 6000},
												[4] = { name = "Advanced Gladiator", points = 5000 },
												[4] = { name = "Gladiator", points = 4000 },
												[5] = { name = "Warrior", points = 3000 },
												[6] = { name = "Rookie", points = 100 },
												[7] = { name = "Beginner" }
											 },
							 }

SEASON_TITLE_SYSTEM.database = "logs_players"


function SEASON_TITLE_SYSTEM:getTitle(player)
	local serverTitle = self.players[player:getName()]
	local t = self.config["Titles"]
	if serverTitle then
	    local rank = serverTitle.ranking
		-- if rank == 1 then
		    -- return t[1].name
		-- end
		-- if rank == 2 then
		    -- return t[2].name
		-- end
		-- if rank == 3 then
		    -- return t[3].name
		-- end
		
		local points = serverTitle.points
		local title = t[#t].name
		for i, v in ipairs(self.players) do
		    if v.points and points >= v.points then
			    return v.name
			end
		end
	end
	return t[#t].name
end

function SEASON_TITLE_SYSTEM:getTitleByPoints(points)
    local t = self.config["Titles"]
	for i, v in ipairs(t) do
	    local tablePoints = v.points
		if not tablePoints then
		    tablePoints = 0
		end
	    if points >= tablePoints then
		    return v.name
		end
	end
	
	return t[#t].name
end


-- function SEASON_TITLE_SYSTEM:isSurvival(name)
    -- if name == "Survival" or name == "x4 All vs All" or name == "1 vs 1" then
	    -- return true
	-- end
	-- return false
-- end


function SEASON_TITLE_SYSTEM:fetchTitles()
    self.players = {}
	
	local resultQuery = db.storeQuery("SELECT player_id, points FROM " .. self.database .. " WHERE `event_name` = " .. '"Survival"' .. " AND " .. "finished_events" .. ">=" .. self.config.minGames .. " ORDER BY " .. "points" .. " DESC")
	if resultQuery ~= false then
	    local rank = 1
	    repeat
	        local guid = result.getNumber(resultQuery, "player_id")
	        local name = NIIDE_LIB:getNameByGuid(guid)
			self.players[name] = { ["points"] = result.getNumber(resultQuery, "points"), ["ranking"] = rank }
			rank = rank + 1
		until not result.next(resultQuery)
	end
	return true
end
				
-- function SEASON_TITLE_SYSTEM:getTitle(player)
    -- local t = self.config["Titles"]
    -- if position == 1 then
        -- return t[1].name
	-- end
	-- if position == 2 then
	    -- return t[2].name
	-- end
	-- if position == 3 then
	    -- return t[3].name
	-- end
	
	-- local title = t[#t].name
	-- -- for titleName, v in ipairs(t) do
	    -- -- if v.points and points >= v.points then
		    -- -- return v.name
		-- -- end
	-- -- end
	-- return title
-- end
		
function SEASON_TITLE_SYSTEM:setTitles()
    local t = players
    table.sort(t, function(a, b) return a.points > b.points end)			
	for i, v in ipairs(t) do
	    local title = SEASON_TITLE_SYSTEM:getTitle(v.name, v.points, i)
		v.title = title
	end
end


local talkaction = TalkAction("!testo", "/testo")

function talkaction.onSay(player, words, param)
    --print("Table cleared")
	--print(SEASON_RESTART_SYSTEM:getEndTimeString())
	--SEASON_RESTART_SYSTEM:startSeason()
	SEASON_TITLE_SYSTEM:setTitles()
end

talkaction:register()
				




local globalevent = GlobalEvent("load_SEASON_TITLE_SYSTEM")
function globalevent.onStartup()	
	SEASON_TITLE_SYSTEM:fetchTitles()
end
globalevent:register()
