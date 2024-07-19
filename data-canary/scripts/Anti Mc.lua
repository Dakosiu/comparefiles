-- if not ANTI_MC_SYSTEM then
   -- ANTI_MC_SYSTEM = {}
-- end

-- ANTI_MC_SYSTEM.ipaddresses = { }

-- function ANTI_MC_SYSTEM:addPlayer(player)
    -- local ip = player:getIp()
	
	-- if not ANTI_MC_SYSTEM.ipaddresses[ip] then
	   -- ANTI_MC_SYSTEM.ipaddresses[ip] = {}
	-- end
	
	-- return table.insert(ANTI_MC_SYSTEM.ipaddresses[ip], player:getId())
-- end
	
-- function ANTI_MC_SYSTEM:removePlayer(player)
    
	-- local ip = player:getIp()
	
    -- if not ANTI_MC_SYSTEM.ipaddresses[ip] then
	   -- return false
	-- end
	
	-- for i = 1, #ANTI_MC_SYSTEM.ipaddresses[ip] do
	    -- local name = ANTI_MC_SYSTEM.ipaddresses[ip][i]
		-- if name == player:getId() then
		   -- return table.remove(ANTI_MC_SYSTEM.ipaddresses[ip], i)
		-- end
	-- end
    -- return false
-- end

-- function ANTI_MC_SYSTEM:getConnectedPlayersCount(ip)
    -- local value = 0
	
	-- if not ANTI_MC_SYSTEM.ipaddresses[ip] then
	   -- return value
	-- end
	-- value = #ANTI_MC_SYSTEM.ipaddresses[ip]
	-- return value
-- end

-- function ANTI_MC_SYSTEM:canConnect(player)
    
	-- local ip = player:getIp()
	-- ANTI_MC_SYSTEM:getConnectedPlayersCount(ip)
	
	-- local maxPlayers = getConfigInfo("maxPlayersSameIpAddress")
	-- if not maxPlayers then
	   -- return true
    -- end
	
	-- if ANTI_MC_SYSTEM:getConnectedPlayersCount(ip) < maxPlayers then 
	   -- return true
	-- end
	-- return false
-- end

-- local creaturescript = CreatureEvent("ANTI_MC_SYSTEM_onLogin")
-- function creaturescript.onLogin(player)

    -- if player:canConnect() then
	   -- print("Dziala")
	-- else
	   -- print("Nie dziala")
	-- end
	
    -- player:registerEvent("ANTI_MC_SYSTEM_onDeath")
	
	
    -- if not ANTI_MC_SYSTEM:canConnect(player) then
	   -- print("Disconnect")
	   -- player:allowConnection(false)
	   -- return true
    -- end
    -- player:allowConnection(true)
    -- ANTI_MC_SYSTEM:addPlayer(player)
	
-- return true
-- end
-- creaturescript:register()

-- creaturescript = CreatureEvent("ANTI_MC_SYSTEM_onLogout")
-- function creaturescript.onLogout(player)
    -- ANTI_MC_SYSTEM:removePlayer(player)
-- return true
-- end
-- creaturescript:register()

-- creaturescript = CreatureEvent("ANTI_MC_SYSTEM_onDeath")
-- function creaturescript.onDeath(creature, corpse, killer, mostDamage, unjustified, mostDamage_unjustified)
   -- ANTI_MC_SYSTEM:removePlayer(creature)
   -- return true
-- end
-- creaturescript:register()