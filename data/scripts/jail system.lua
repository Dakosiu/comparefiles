if not JAIL_SYSTEM then
   JAIL_SYSTEM = {}
end

JAIL_SYSTEM.config = {
                        ["Jail Exit"] = { 847, 871, 5 },
                        ["Cells"] = {
					                    ["Normal"] = {
									                   [1] = { 984, 1062, 7 },
													   [2] = { 984, 1065, 7 },
													   [3] = { 984, 1068, 7 },
													   [4] = { 984, 1071, 7 },
													   [5] = { 992, 1068, 7 },
													   [6] = { 993, 1071, 7 }
													 },
										["Vip"] = {
										            [1] = { 984, 1074, 7 },
													[2] = { 993, 1075, 7 },
												  }
									}
					 }
					 
					 
					 
JAIL_SYSTEM.storages = {
                         inJail = 5555512,
						 expireTime = 5555513
                       }

if not JAIL_SYSTEM.players then
   JAIL_SYSTEM.players = {}		
end 

function JAIL_SYSTEM:getTable(method)
   	local cellsTable = nil
	if not method then
	   print("[Jail System] - Error - method not found.")
	   return false
	end
	

	if method == "normal" then
	   cellsTable = self.config["Cells"]["Normal"]
	elseif method == "vip" then
	   cellsTable = self.config["Cells"]["Vip"]
	end
	
	if not cellsTable then
	   print("[Jail System] - Error - wrong method set.")
	   return false
	end
	
	return cellsTable
end

function JAIL_SYSTEM:getCell(player, method)
    
    local t = JAIL_SYSTEM:getTable(method)
	if not t then
	   return false
	end
	
	local playersTable = JAIL_SYSTEM.players[method]
	if not playersTable then
	   return 1
	end
	
	for i, v in ipairs(t) do
	    if not playersTable[i] then
		   return i
		end
		local player = Player(playersTable[i])
		if not player then
		   return i
		end	
	end
	
	return false
end

function JAIL_SYSTEM:addPlayer(player, method, durationType, duration, reason)
	local index = JAIL_SYSTEM:getCell(player, method)
	if not index then
	   return false
	end
	
	local cellTable = JAIL_SYSTEM:getTable(method)
	if not cellTable then
	   return false
	end
	
	cellTable = cellTable[index]
	
	local x = cellTable[1]
	local y = cellTable[2]
	local z = cellTable[3]
	
	local pos = Position(x, y, z)
	
	local playersTable = JAIL_SYSTEM.players[method]
	if not playersTable then
	   JAIL_SYSTEM.players[method] = {}
	end
	
	
	JAIL_SYSTEM.players[method][index] = player:getId()
	player:teleportTo(pos, true)
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	player:sendCancelMessage("You are jailed!")
	if reason then
	   player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "You are jailed" .. " for " .. duration .. " " .. durationType .. ".")
	   player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Reason: " .. reason)
	end  
	   
	player:setStorageValue(self.storages.inJail, index)
	JAIL_SYSTEM:addTimer(player, durationType, duration)
	return true
end

function JAIL_SYSTEM:getPlayer(player)
	local t = JAIL_SYSTEM.players["normal"]
	if t then
	   for i, v in ipairs(t) do
	        if player:getId() == v then
               return { ["method"] = "normal", ["index"] = i }
            end
       end 
    end	 
	t = JAIL_SYSTEM.players["vip"]
	if t then
	   for i, v in ipairs(t) do
	        if player:getId() == v then
               return { ["method"] = "vip", ["index"] = i }
            end
       end 
    end	
	return false
end
   
function JAIL_SYSTEM:isInJail(player)
	if player:getStorageValue(self.storages.inJail) > 0 then
	   return true
	end
	
	if JAIL_SYSTEM:getPlayer(player) then
	   return true
	end
end

function JAIL_SYSTEM:removePlayer(player)
	player:setStorageValue(self.storages.inJail, 0)
	local posTable = self.config["Jail Exit"]
	local x = posTable[1]
	local y = posTable[2]
	local z = posTable[3]
	local pos = Position(x, y, z)
	player:teleportTo(pos)
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
    local t = JAIL_SYSTEM:getPlayer(player)
	if t then
	   local method = t.method
	   local index = t.index
	   JAIL_SYSTEM.players[method][index] = nil
	end
end

function JAIL_SYSTEM:addTimer(player, method, duration)
	local interval = 0
    if string.find(method, "second") then
	   interval = duration * 1000
    elseif string.find(method, "minute") then
	   interval = duration * 60
    elseif string.find(method, "hour") then 
	   interval = duration * 60 * 60
    end 
	player:setStorageValue(self.storages.expireTime, interval + os.time())
	addEvent(function(player_id)
	    local target = Player(player_id)
		if not target then
		   return false
		end
		if not JAIL_SYSTEM:isInJail(target) then
		   return false
		end
		JAIL_SYSTEM:removePlayer(target)
    end, interval * 1000, player:getId())
end

function JAIL_SYSTEM:getJailString(player)
  local time_left = player:getStorageValue(self.storages.expireTime) - os.time()
  local days = math.floor(time_left/86400)
  local remaining = time_left % 86400
  local hours = math.floor(remaining/3600)
  remaining = remaining % 3600
  local minutes = math.floor(remaining/60)
  remaining = remaining % 60
  local seconds = remaining
  
  str = ""
  
  local isStarted = false
  
  if days > 0 then
     str = str .. days .. " days"
	 isStarted = true
  end
  
  if hours > 0 then
     if isStarted then
	    str = str .. ", "
	 end
	 str = str .. hours .. " hours"
	 isStarted = true
  end

  if minutes > 0 then
     if isStarted then
	    str = str .. ", "
	 end
	 str = str .. minutes .. " minutes"
	 isStarted = true
  end
  
  if seconds > 0 then
     if days == 0 and hours == 0 and minutes == 0 then
	    str = seconds .. " seconds"
     elseif minutes > 0 then
	    str = str .. " and " .. seconds .. " seconds"
	 end
  end
  
   str = str .. "."
   return str
end

local creatureevent = CreatureEvent("JAIL_SYSTEM_onLogin")
function creatureevent.onLogin(player)
    if JAIL_SYSTEM:isInJail(player) then
	   JAIL_SYSTEM:removePlayer(player)
	end
   return true
end
creatureevent:register()

local talk = TalkAction("/jail", "!jail")
function talk.onSay(player, words, param)

    local split = param:split(",")

    if JAIL_SYSTEM:isInJail(player) then
       player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "You are jailed!")
	   player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Timeleft to leave the jail: " .. JAIL_SYSTEM:getJailString(player))
	   return false
	else
	   if not split[1] then
	      player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "You are not in jail.")
		  return false
	   end
	end
	
	if player:getAccountType() < ACCOUNT_TYPE_GOD then
	   return false
	end
	

	
	if not split[2] then
	   player:sendCancelMessage("Insufficient parameters.")
	   return false
	end
	
	local jailType = split[1]:gsub("^%s*(.-)$", "%1")
	if not jailType then
	   player:sendCancelMessage("Insufficient parameters.")
	   return false
	end
	
	
	if jailType ~= "add" and jailType ~= "release" then
	   player:sendCancelMessage("Insufficient parameters.")
	   return false
	end
	
	local targetName = split[2]:gsub("^%s*(.-)$", "%1")
	local target =  Player(targetName)
    if not target then
       player:sendCancelMessage("Player not found.")
	   return false
    end
	
	if jailType == "add" then
	    if JAIL_SYSTEM:isInJail(target) then
	       player:sendCancelMessage("This player is already in jail.")
	       return false
	    end
		
		if not split[5] then
		   player:sendCancelMessage("Insufficient parameters. 5")
		   return false
		end
		
		
		local method = split[3]:gsub("^%s*(.-)$", "%1")
		local durationType = split[4]:gsub("^%s*(.-)$", "%1")
		local duration = tonumber(split[5])
		
		local reason = nil
		if split[6] then
		   reason = split[6]:gsub("^%s*(.-)$", "%1")
		end
		

		if not JAIL_SYSTEM:addPlayer(target, method, durationType, duration, reason) then
		   player:sendCancelMessage("Sorry, cells are full.")
		   return false
		end
		
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Player " .. targetName .. " has been sended to jail " .. " for " .. duration .. " " .. durationType .. ".")
		return false
    end
	
	if jailType == "release" then
	    if not JAIL_SYSTEM:isInJail(target) then
	       player:sendCancelMessage("This player is not jailed.")
	       return false
	    end
		
		JAIL_SYSTEM:removePlayer(target)
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Player " .. targetName .. " has been released from jail.")
	    return false
    end
	
    return false
end
talk:separator(" ")
talk:register()
	
	
	
	
	
	
	
	
	
	
	
	
	 
	   
	