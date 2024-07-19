local function setExhaust(player, value)
  
  if not ONLINE_PLAYERS_EXHAUST then
     ONLINE_PLAYERS_EXHAUST = {}
  end
  
  if not ONLINE_PLAYERS_EXHAUST[player:getId()] then
     ONLINE_PLAYERS_EXHAUST[player:getId()] = {}
  end
  
  ONLINE_PLAYERS_EXHAUST[player:getId()] = os.time() + value
end

local function getExhaust(player)
  local currentTime = os.time()
 
  if not ONLINE_PLAYERS_EXHAUST then
     return false
  end
  
  if not ONLINE_PLAYERS_EXHAUST[player:getId()] then
     return false
  end
  
  if ONLINE_PLAYERS_EXHAUST[player:getId()] > currentTime then
     return true
  end
  
  return false
end

local talkaction = TalkAction("!online")
function talkaction.onSay(player, words, param)
    
	-- if getExhaust(player) then
	   -- player:sendCancelMessage("You are exhausted.")
	   -- return false
	-- end
	
	local players = Game.getPlayers()
	local onlineList = {}
	local staffList = {}

	for _, targetPlayer in ipairs(players) do
		if player:canSeeCreature(targetPlayer) then
			if targetPlayer:getGroup():getAccess() and targetPlayer:getAccountType() >= ACCOUNT_TYPE_GOD then 
		       table.insert(staffList, ("%s"):format(targetPlayer:getName()))
			else
			   if not TRAINING_ROOM_SYSTEM:isInRoom(targetPlayer) then
			      table.insert(onlineList, ("%s[%d]"):format(targetPlayer:getName(), targetPlayer:getLevel()))
			   end
			end
		end
	end
	local str = ""
	if #onlineList == 0 then
	   str = "There is no online players on server."
	else
	   str = "Online players on zakaria: " .. #onlineList
	   --str = str .. "\n"
	end
	
	-- for i, v in pairs(onlineList) do
	    -- str = str .. "{" .. "3406|" .. v .. "}"
	    -- if i == #onlineList or #onlineList == 1 then
		   -- str = str .. "."
		-- else
		   -- str = str .. ", "
		-- end
	-- end
	
	if #staffList > 0 then
	   str = str .. "\n"
	   -- if #onlineList > 0 then
	      -- str = str .. "\n"
       -- end
	   str = str .. "Staff Members: "
	   for i, v in pairs(staffList) do
	       str = str .. "{" .. "3055|" .. v .. "}"
	       if i == #staffList or #staffList == 1 then
		      str = str .. "."
		   else
		      str = str .. ", "
		   end
	    end	
    end
	
	
	--28724
	   
	
    -- local str = "Online players on zakaria: "
	-- for i, v in pairs(onlineList) do
	    -- str = str .. 
	-- end   
	
	
	player:sendTextMessage(MESSAGE_LOOT, str)
	
	--local playersOnline = #onlineList
	--player:sendTextMessage(MESSAGE_LOOT, ("%d players online."):format(playersOnline) .. "#{3366|2 Golden Account}")
	--player:sendTextMessage(MESSAGE_STATUS_DEFAULT, ("%d players online."):format(playersOnline))
	--setExhaust(player, 600)
	return false
end
talkaction:separator(" ")
talkaction:register()