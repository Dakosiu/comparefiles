if not GUILD_WAR_SYSTEM then
   GUILD_WAR_SYSTEM = {}
end

function GUILD_WAR_SYSTEM:createGuild(player, name, id)
	
	if player:getGuild() then
	   return false
	end

	local level = 3
	local creationdata = os.time()
	local motd = "test motd"
	local residence = 0
	local balance = 0
	local points = 0
	local logo_name = "default.gif"
	local description = "test"
	local image_url = "/images/default_guild_logo.png"
	local short_description = name
	local ownerid = player:getGuid()
	
	
	local str = "INSERT INTO `guilds` (`level`, `name`, `ownerid`, `creationdata`, `motd`, `residence`, `balance`, `points`, `logo_name`, `description`, `image_url`, `short_description`)" 
	str = str .. " VALUES "
	str = str .. "("
	str = str .. level .. ", " .. db.escapeString(name) .. ", " .. ownerid .. ", " .. creationdata .. ", "
	str = str .. db.escapeString(motd) .. ", " .. residence .. ", " .. balance .. ", " .. points .. ", "
	str = str .. db.escapeString(logo_name) .. ", " .. db.escapeString(description) .. ", " .. db.escapeString(image_url) .. ", " .. db.escapeString(short_description)
	str = str .. ")"
	
	db.query(str)
	
	str = "INSERT INTO `guild_membership` (`player_id`, `guild_id`, `rank_id`, `nick`)"
    str = str .. " VALUES " 
    str = str .. "("
    str = str .. ownerid .. ", " .. id .. ", " .. 1 .. ", " .. db.escapeString("")
	str = str .. ")"
	db.query(str)
end

function GUILD_WAR_SYSTEM:addMember(player, id)
	
	if player:getGuild() then
	   return false
	end
    
	local rank = 6
	
	str = "INSERT INTO `guild_membership` (`player_id`, `guild_id`, `rank_id`, `nick`)"
    str = str .. " VALUES " 
    str = str .. "("
    str = str .. player:getGuid() .. ", " .. id .. ", " .. rank .. ", " .. db.escapeString("")
	str = str .. ")"
	return db.query(str)
end

function GUILD_WAR_SYSTEM:acceptWarInvite(player, name)
	local guild = player:getGuild()
	if not guild then
	   player:sendCancelMessage("You dont have a guild.")
	   return false
	end
	local id = guild:getId()
		
	local opponentId = getGuildId(name)
	if not opponentId then
	   player:sendCancelMessage("this guild doesnt exsists.")
	   return false
	end
	
	local guildOpponent = Guild(opponentId)
	
	local resultQuery = db.storeQuery("SELECT `maxKills` FROM `guild_wars` WHERE `guild2` = " .. id .. " AND `name1` = " .. db.escapeString(name) .. " AND `status` = 1")
	if not resultQuery then
	   return false
	end
	local kills = result.getDataInt(resultQuery, "maxKills")
	result.free(resultQuery)
	
	
	
	local sql = "UPDATE `guild_wars` SET"
	sql = sql .. " `started` = " .. os.time()
	sql = sql .. ", `status` = " .. 2
	sql = sql .. " WHERE " .. "`name1` = " .. db.escapeString(name) .. " AND " .. "`guild2` = " .. id .. " AND " .. "`status` = 1"
	
	
    local members = guild:getMembersOnline()
	for i, member in pairs(members) do
	    member:addToWarList(opponentId)
		member:sendTextMessage(MESSAGE_INFO_DESCR, "Your guild have now Guild War with " .. name .. " to " .. kills .. " kills, Good Luck.")
    end
	
	if guildOpponent then
	   members = guildOpponent:getMembersOnline()
	   for i, member in pairs(members) do
	       member:addToWarList(id)
		   member:sendTextMessage(MESSAGE_INFO_DESCR, "Your guild have now Guild War with " .. guild:getName() .. " to " .. kills .. " kills, Good Luck.")
       end
	end
	
	return db.query(sql)
end
	

function GUILD_WAR_SYSTEM:sendWarInvite(player, name, kills)
    
	local guild = player:getGuild()
	if not guild then
	   player:sendCancelMessage("You dont have a guild.")
	   return false
	end

	local id = guild:getId()
	
	local guild_id = getGuildId(name)
	if not guild_id then
	   player:sendCancelMessage("This guild doesnt exsists.")
	   return false
	end
	
	local resultQuery = db.storeQuery("SELECT `guild1`, `guild2`, `status`, `ended` FROM `guild_wars` WHERE `guild1` = " .. id .. " OR `guild2` = " .. id)
	
	--local resultQuery = db.storeQuery("SELECT `guild1`, `guild2` FROM `guild_wars` WHERE `guild1` = " .. id .. " OR `guild2` = " .. id .. " AND `ended` = 0")
	
	--query << "SELECT `guild1`, `guild2` FROM `guild_wars` WHERE (`guild1` = " << guildId << " OR `guild2` = " << guildId << ") AND `ended` = 0 AND `status` = 1";
	
	
	if resultQuery ~= false then
	   repeat
	   local guild1 = result.getDataInt(resultQuery, "guild1")
	   local guild2 = result.getDataInt(resultQuery, "guild2")
	   
	   if guild1 == guild_id or guild2 == guild_id then
	      
		  local status = result.getDataInt(resultQuery, "ended")
		  if status == 1 then
		     player:sendCancelMessage("You have already a pending war with this guild.")
			 result.free(resultQuery)
			 return false
		  end
		  
	      local status = result.getDataInt(resultQuery, "status")
		  if status == 1 then
		     player:sendCancelMessage("You have already sended war invitation to this guild.")
			 result.free(resultQuery)
			 return false
		  end
	   end
	   until not result.next(resultQuery)
	end
	
	str = "INSERT INTO `guild_wars` (`guild1`, `guild2`, `name1`, `name2`, `status`, `started`, `ended`, `maxKills`)"
    str = str .. " VALUES " 
    str = str .. "("
    str = str .. id .. ", " .. guild_id .. ", " .. db.escapeString(guild:getName()) .. ", " .. db.escapeString(name) .. ", " .. 1 .. ", " .. 0 .. ", " .. 0 .. ", " .. kills
	str = str .. ")"
	db.query(str)
	
	player:sendTextMessage(MESSAGE_INFO_DESCR, "You have invited " .. name .. " to guild war.")
	   
	   
	return true
end

function GUILD_WAR_SYSTEM:getStatusString(id, index)
	if id == 1 then
	   if index == 1 then
	      return "Invited"
	   else
		  return "Wait for accept"
	   end
	elseif id == 2 then
       return "Active"
	elseif id == 3 then
       return "Finished"
    end
    return false
end	

function GUILD_WAR_SYSTEM:getWarList(player)
    
	local str = ""
	local _started = false
	
	local playerGuild = player:getGuild()
	local id = playerGuild:getId()
	local name = playerGuild:getName()
	
	--local resultQuery = db.storeQuery("SELECT `guild1`, `guild2`, `status`, `ended`, `name1`, `name2` FROM `guild_wars` WHERE `guild1` = " .. id .. " OR `guild2` = " .. id .. " AND `status` = 1")
	local resultQuery = db.storeQuery("SELECT `guild1`, `guild2`, `status`, `ended`, `name1`, `maxKills`, `name2`, `kill1`, `kill2` FROM `guild_wars` WHERE `guild1` = " .. id .. " OR `guild2` = " .. id .. " AND `ended` = 0")
	if resultQuery ~= false then
	   repeat
	   if not _started then
	      str = "Current Guild War's"
		  str = str .. "\n"
		  str = str .. "----------------------------------"
		  str = str .. "\n"
		  _started = true
	   end
	   local guild1 = result.getDataInt(resultQuery, "guild1")
	   local guild2 = result.getDataInt(resultQuery, "guild2")
	   local targetName = nil
	   local index = nil
	   local targetKills = nil
	   local playerKills = nil
	   local maxKills = result.getDataInt(resultQuery, "maxKills")
	   
	   if guild1 == id then
	      targetKills = result.getDataInt(resultQuery, "kill2")
		  playerKills = result.getDataInt(resultQuery, "kill1")
	      targetName = result.getDataString(resultQuery, "name2")
		  index = 1
	   else 
	   	  targetKills = result.getDataInt(resultQuery, "kill1")
		  playerKills = result.getDataInt(resultQuery, "kill2")
	      targetName = result.getDataString(resultQuery, "name1")
		  index = 2
	   end

	   str = str .. "Guild Name: " .. targetName
	   str = str .. "\n"
	   str = str .. "Max Kills: " .. maxKills
	   str = str .. "\n"
	   local status = result.getDataInt(resultQuery, "status")
	   str = str .. "Status: " .. GUILD_WAR_SYSTEM:getStatusString(status, index)
	   if status == 2 then
	      str = str .. "\n"
	      str = str .. "Guild Kills: " .. playerKills
		  str = str .. "\n"
	      str = str .. "Opponent Kills: " .. targetKills
	   end
		  
		  
		  
	   str = str .. "\n"
	   str = str .. "----------------------------------"
	   until not result.next(resultQuery)
	end

	return str
end
	   
function GUILD_WAR_SYSTEM:getLeaderGUID(guildName) 	
	local resultId = db.storeQuery("SELECT `ownerid` FROM `guilds` WHERE `name` = " .. db.escapeString(guildName))
	if resultId ~= false then
		local leaderGuid = result.getNumber(resultId, "ownerid")
		result.free(resultId)
		return leaderGuid
	end
	return nil
end

function GUILD_WAR_SYSTEM:getKillsGuild(player)
	local guild = player:getGuild()
	if not guild then
	   return false
	end
	
	local id = guild:getId()
	
    local resultId = db.storeQuery("SELECT `kills` FROM `guilds` WHERE `id` = " .. id)
	if resultId ~= false then
		local kills = result.getNumber(resultId, "kills")
		result.free(resultId)
		return kills
	end
	return nil
end
	
function GUILD_WAR_SYSTEM:addKillToGuild(player)
    
	local guild = player:getGuild()
	if not guild then
	   return false
	end
	
	local id = guild:getId()
	local kills = GUILD_WAR_SYSTEM:getKillsGuild(player) 
	
	local sql = "UPDATE `guilds` SET"
	sql = sql .. " `kills` =" .. kills + 1
	sql = sql .. " WHERE `id` =" .. id
    db.query(sql)
end

function GUILD_WAR_SYSTEM:sendMessage(guild, message)
	local members = guild:getMembersOnline()
	local channelID = 18
	for _, member in pairs(members) do
	   member:openChannel(channelID)
	   member:sendChannelMessage("[Guild War]", message, TALKTYPE_CHANNEL_O, channelID)
	end
end
	
	
	

function GUILD_WAR_SYSTEM:addGuildWarKill(player, opponent)
    
	local playerGuild = player:getGuild()
	if not playerGuild then
	   return false
	end
	local playerId = playerGuild:getId()
	
	local opponentGuild = opponent:getGuild()
	if not opponentGuild then
	   return false
	end
	local opponentId = opponentGuild:getId()
	
	
	--local count = nil
	local query = nil
	
	local resultQuery = db.storeQuery("SELECT `guild1`, `guild2`, `name1`, `name2`, `kill1`, `kill2`, `maxKills` FROM `guild_wars` WHERE `status` = 2" .. " AND " .. "`guild1` = " .. playerId .. " AND `guild2` = " .. opponentId)
	if not resultQuery then
	   resultQuery = db.storeQuery("SELECT `guild1`, `guild2`, `name1`, `name2`, `kill1`, `kill2`, `maxKills` FROM `guild_wars` WHERE `status` = 2" .. " AND " .. "`guild1` = " .. opponentId .. " AND `guild2` = " .. playerId)
	end
	
	---local resultQuery = db.storeQuery("SELECT `guild1`, `guild2`, `name1`, `name2`, `kill1`, `kill2`, `maxKills` FROM `guild_wars` WHERE `status` = 2" .. " AND " .. "`guild1` = " .. playerId .. " OR `guild2` = " .. playerId)
	if resultQuery ~= false then
	   local guild1 = result.getDataInt(resultQuery, "guild1")
	   local maxKills = result.getDataInt(resultQuery, "maxKills")
	   local playerKills = nil
	   local opponentKills = nil
	   if opponentId == guild1 then
	      playerKills = result.getDataInt(resultQuery, "kill2")
		  opponentKills = result.getDataInt(resultQuery, "kill1")
	      --count = result.getDataInt(resultQuery, "kill1")
		  local sql = "UPDATE `guild_wars` SET"
	      sql = sql .. "`kill1`" .. "=" .. opponentKills + 1 ..  " WHERE " .. "`guild1` = " .. opponentId .. " AND " .. "`guild2` = " .. playerId .. " AND " .. "`status` = 2"
		  db.query(sql)
		  local str = "Opponent: " .. player:getName() .. " from guild " .. playerGuild:getName() .. " has been killed by " .. opponent:getName() .. "."
		  str = str .. " This war will end when one of team will reach " .. maxKills .. " kills. "
		  if opponentKills == playerKills then
		     str = str .. "Currently is draw!"
	      elseif opponentKills < playerKills then
		     str = str .. "You are losing this war." 
	      else
		     str = str .. "You are winning this war."
		  end
		  str = str .. " You have " .. opponentKills + 1 .. " kills while enemy guild has " .. playerKills .. " kills."
		  GUILD_WAR_SYSTEM:sendMessage(opponentGuild, str)
		  
		  str = "Teammate: " .. player:getName() .. " has been killed by " .. opponent:getName() .. " from " .. opponentGuild:getName() .. "."
		  str = str .. " This war will end when one of team will reach " .. maxKills .. " kills. "
		  if opponentKills == playerKills then
		     str = str .. "Currently is draw!"
	      elseif playerKills < opponentKills then
		     str = str .. "You are losing this war." 
	      else
		     str = str .. "You are winning this war."
		  end
		  str = str .. " You have " .. playerKills .. " kills while enemy guild has " .. opponentKills + 1 .. " kills."
		  GUILD_WAR_SYSTEM:sendMessage(playerGuild, str)
		  if opponentKills + 1 >= maxKills then
		  	 local opponentName = result.getDataString(resultQuery, "name1")
			 local playerName = result.getDataString(resultQuery, "name2")
		     GUILD_WAR_SYSTEM:setFinish(opponentId, opponentName, playerId, playerName, 1)
			 opponent:removeFromWarList(playerId)
			 player:removeFromWarList(opponentId)
		  end 
	   else
	   	  playerKills = result.getDataInt(resultQuery, "kill1")
		  opponentKills = result.getDataInt(resultQuery, "kill2")
		  local sql = "UPDATE `guild_wars` SET"
	      sql = sql .. "`kill2`" .. "=" .. opponentKills + 1 ..  " WHERE " .. "`guild1` = " .. playerId .. " AND " .. "`guild2` = " .. opponentId .. " AND " .. "`status` = 2"
		  db.query(sql)
		  		  local sql = "UPDATE `guild_wars` SET"
	      sql = sql .. "`kill1`" .. "=" .. opponentKills + 1 ..  " WHERE " .. "`guild1` = " .. opponentId .. " AND " .. "`guild2` = " .. playerId .. " AND " .. "`status` = 2"
		  db.query(sql)
		  local str = "Opponent: " .. player:getName() .. " from guild " .. playerGuild:getName() .. " has been killed by " .. opponent:getName() .. "."
		  str = str .. " This war will end when one of team will reach " .. maxKills .. " kills. "
		  if opponentKills == playerKills then
		     str = str .. "Currently is draw!"
	      elseif opponentKills < playerKills then
		     str = str .. "You are losing this war." 
	      else
		     str = str .. "You are winning this war."
		  end
		  str = str .. " You have " .. opponentKills + 1 .. " kills while enemy guild has " .. playerKills .. " kills."
		  GUILD_WAR_SYSTEM:sendMessage(opponentGuild, str)
		  str = "Teammate: " .. player:getName() .. " has been killed by " .. opponent:getName() .. " from " .. opponentGuild:getName() .. "."
		  str = str .. " This war will end when one of team will reach " .. maxKills .. " kills. "
		  if opponentKills == playerKills then
		     str = str .. "Currently is draw!"
	      elseif playerKills < opponentKills then
		     str = str .. "You are losing this war." 
	      else
		     str = str .. "You are winning this war."
		  end
		  str = str .. " You have " .. playerKills .. " kills while enemy guild has " .. opponentKills + 1 .. " kills."
		  GUILD_WAR_SYSTEM:sendMessage(playerGuild, str)
		  if opponentKills + 1 >= maxKills then
		     local opponentName = result.getDataString(resultQuery, "name2")
			 local playerName = result.getDataString(resultQuery, "name1")
		     GUILD_WAR_SYSTEM:setFinish(opponentId, opponentName, playerId, playerName, 2)
			 opponent:removeFromWarList(playerId)
			 player:removeFromWarList(opponentId)
		  end 
	   end
	end
end

function GUILD_WAR_SYSTEM:setFinish(opponentId, opponentName, playerId, playerName, index)
	local sql = "UPDATE `guild_wars` SET"
	sql = sql .. " `ended`= " .. os.time()
	sql = sql .. ", `status` = " .. 3
	if index == 1 then
	   sql = sql .. " WHERE " .. "`guild1` = " .. opponentId .. " AND " .. "`guild2` = " .. playerId .. " AND " .. "`status` = 2"
    else
	   sql = sql .. " WHERE " .. "`guild1` = " .. playerId .. " AND " .. "`guild2` = " .. opponentId .. " AND " .. "`status` = 2"
	end
	db.query(sql)
	Game.broadcastMessage("Guild War between " .. opponentName .. " and " .. playerName .. " finished " .. " " .. opponentName .. " won this war.", MESSAGE_GAME_HIGHLIGHT)
end
	   
function GUILD_WAR_SYSTEM:getInfo(player)
   
    local guild = player:getGuild()
	if not guild then
	   player:sendCancelMessage("You dont have a guild.")
	   return false
	end
   
    local name = guild:getName()
    local title = "Guild Manager"
	local message = "Guild Name: " .. name .. "\n"
	local leader_id = GUILD_WAR_SYSTEM:getLeaderGUID(name)
	local leader_name = getPlayerNameByGUID(leader_id)
	
	message = message .. "Leader: " .. leader_name .. "\n"
	message = message .. "All Kills: " .. GUILD_WAR_SYSTEM:getKillsGuild(player)
	message = message .. "\n"
	
	local list = GUILD_WAR_SYSTEM:getWarList(player)
	if list then
	   message = message .. "\n" .. list 
	end
	
	message = message .. "\n"
	message = message .. 'To accept guild war invitation type "!guild accept, name"'
	message = message .. "\n"
	message = message .. "\n"
	-- message = message .. 'To decline guild war invitation type "!guild decline, name"'
	-- message = message .. "\n"
	-- message = message .. "\n"
	message = message .. "To invite guild to war"
	message = message .. "\n"
	message = message .. 'type "!guild invite, name"'
	
	
	local window = ModalWindow(300, title, message)
	window:addButton(100, "Ok") 
    window:setDefaultEnterButton(100)	  
    window:setDefaultEscapeButton(100)
	return window:sendToPlayer(player)
end


local talkaction = TalkAction("/guild", "!guild")
function talkaction.onSay(player, words, param)

	if param == "" then
		player:sendCancelMessage("Command param required.")
		return false
	end

	local split = param:split(",")
	
	
	if split[1] == "info" then
	   GUILD_WAR_SYSTEM:getInfo(player)
	   return false
	end
	
	if not split[2] then
		player:sendCancelMessage("Insufficient parameters.")
		return false
	end
	
	split[2] = split[2]:gsub("^%s*(.-)$", "%1")
	if split[1] == "invite" then
       local name = tostring(split[2])
	   if not split[3] then
	      player:sendCancelMessage("Insufficient parameters.")
		  return false
	   end
	   local kills = tonumber(split[3])
	   if not kills or kills < 1 then
	      player:sendCancelMessage("wrong kills ammount.")
		  return false
	   end
	   GUILD_WAR_SYSTEM:sendWarInvite(player, name, kills)
	elseif split[1] == "accept" then
	   local name = tostring(split[2])
	   GUILD_WAR_SYSTEM:acceptWarInvite(player, name)
	end
	
	

	return false
end
talkaction:separator(" ")
talkaction:register()



local creatureevent = CreatureEvent("GUILD_WAR_SYSTEM_onDeath")
function creatureevent.onDeath(player, corpse, killer, mostDamageKiller, unjustified, mostDamageUnjustified)
   
    local targetGuild = player:getGuild()
	
	if killer and killer:isPlayer() then
	   if player and player:isPlayer() then
	      GUILD_WAR_SYSTEM:addKillToGuild(killer)
	   end
	end
	
	targetGuild = targetGuild and targetGuild:getId() or 0
	if targetGuild ~= 0 then
	   local killerGuild = killer:getGuild()
	   killerGuild = killerGuild and killerGuild:getId() or 0
	   if killerGuild ~= 0 and targetGuild ~= killerGuild and isInWar(player:getId(), killer:getId()) then
	   	  resultId = db.storeQuery("SELECT `id` FROM `guild_wars` WHERE `status` = 2 AND ((`guild1` = " .. killerGuild .. " AND `guild2` = " .. targetGuild .. ") OR (`guild1` = " .. targetGuild .. " AND `guild2` = " .. killerGuild .. "))")
		  if resultId ~= false then
		     GUILD_WAR_SYSTEM:addGuildWarKill(player, killer)
          end
	   end
	end
  
return true
end
creatureevent:register()

creatureevent = CreatureEvent("GUILD_WAR_SYSTEM_onLogin")
function creatureevent.onLogin(player)
   player:registerEvent("GUILD_WAR_SYSTEM_onDeath")
return true
end
creatureevent:register()