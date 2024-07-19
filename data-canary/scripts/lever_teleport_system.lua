LEVER_SYSTEM_QUEST_CONFIG = {
                 [1] = {
				         minLevel = 20,
				         ["Lever"] = { 32695, 31605, 7 },
						 ["Positions"] = {
						                     [1] = { 32695, 31606, 7 },
										     [2] = { 32695, 31607, 7 },
										 },
						 ["Destination"] = {
						                     [1] = { 32682, 31613, 7 },
										     [2] = { 32682, 31614, 7 },
										   },
                       },   
                 [2] = {
				         minLevel = 200,
				         ["Lever"] = { 3666, 6666, 10 },
						 ["Positions"] = {
						                     [1] = { 326975, 316706, 7 },
										     [2] = { 326975, 316077, 7 },
										 },
						 ["Destination"] = {
						                     [1] = { 326872, 316713, 7 },
										     [2] = { 326872, 316714, 7 },
										   },
                       }, 
			   }
                 					   
				          


leverSystemQuest = { }
leverSystemQuest.__newindex = leverSystemQuest
leverSystemQuest.aid = 1678

function leverSystemQuest:getOwner(index)
    
	if not index then
	   return nil
	end
	
    local t = LEVER_SYSTEM_QUEST_CONFIG[index]
	if not t then
	   return nil
	end
	
	local x = t["Positions"][1][1]
	local y = t["Positions"][1][2]
	local z = t["Positions"][1][3]
	
	local pos = Position(x, y, z)
	if not pos then
	   return false
	end
	
	local tile = Tile(pos)
	local creatures = tile:getCreatures()
	if creatures then
	   for index, creature in pairs(creatures) do
	       if creature:isPlayer() then
		      return creature:getId()
		   end
	   end
	end
	
	return false
end

function leverSystemQuest:addPlayers(index)
   	
	if not index then
	   return nil
	end
	
    local t = LEVER_SYSTEM_QUEST_CONFIG[index]
	if not t then
	   return nil
	end
	
    local playersTable = { ["Index"] = index, ["Players"] = {} }
	
	for i, position in pairs(LEVER_SYSTEM_QUEST_CONFIG[index]["Positions"]) do
	    local x = position[1]
		local y = position[2]
		local z = position[3]
		local pos = Position(x, y, z)
		if pos then
		   local tile = Tile(pos)
		   if tile then
		      local creatures = tile:getCreatures()
			  for z, creature in pairs(creatures) do
			      if creature:isPlayer() then
				     local minLevel = LEVER_SYSTEM_QUEST_CONFIG[index].minLevel
					 local id = creature:getId()
				     if creature:getLevel() >= minLevel then
					    local values = { ["Player_ID"] = id, ["Joined"] = true }
					    table.insert(playersTable["Players"], values)
						else
						local values = { ["Player_ID"] = id, ["Joined"] = false }
						table.insert(playersTable["Players"], values)
				     end
				  end
			 end
		  end
		end
    end
	

	return playersTable
end

function leverSystemQuest:getPlayers(t)

    if not t then
	   return nil
	end
	
	local participants = {}
	local index = t["Index"]
	local players = t["Players"]
	
	for i, v in pairs(players) do
	    local id = v["Player_ID"]
		table.insert(participants, id)
	end
	
	return participants
end

function leverSystemQuest:sendMessageToPlayers(t, msg)
    
	if not t then
	   return nil
	end
	
	if not msg then
	   return nil
	end
	
	for index, id in pairs(t) do
	    local player = Player(id)
		if player then
		   player:sendCancelMessage(msg)
		end
    end
end

function leverSystemQuest:teleportPlayers(index, t)
    
	if not t then
	   return nil
	end
	
	if not index then
	   return nil
	end
	
    for i, id in pairs(t) do
	    local player = Player(id)
		   if player then
		      local x = LEVER_SYSTEM_QUEST_CONFIG[index]["Destination"][i][1]
		      local y = LEVER_SYSTEM_QUEST_CONFIG[index]["Destination"][i][2]
		      local z = LEVER_SYSTEM_QUEST_CONFIG[index]["Destination"][i][3]
		      local pos = Position(x, y, z)
		      if pos then
		         player:teleportTo(pos)
	          end
		    end
	end
end



function leverSystemQuest:checkPlayers(t)

    if not t then
	   return nil
	end
	
	local index = t["Index"]
	local players = t["Players"]
	local check = 0
	local invalidPlayers = {}
	local participants = leverSystemQuest:getPlayers(t)
	
	local requiredPlayers = #LEVER_SYSTEM_QUEST_CONFIG[index]["Positions"]
	if #players < requiredPlayers then
	   leverSystemQuest:sendMessageToPlayers(participants, "There is not enough players.")
	   return false
	end
	
	for i, v in pairs(players) do
	    local id = v["Player_ID"]
		local _canJoin = v["Joined"]
		if _canJoin then
		   check = check + 1
		   else
		   table.insert(invalidPlayers, id)
		end
	end
		
	if check == requiredPlayers then
	   return true
	end
	
	local str = ""
		
	if #invalidPlayers == 1 then
	   str = "Player: "
	elseif #invalidPlayers > 1 then
	   str = "Players: "
	end
	
	for i, id in pairs(invalidPlayers) do
	    local player = Player(id)
		if player then
		   local name = player:getName()
		   if i == #invalidPlayers then
		      str = str .. name .. " dont have required level."
			  else
			  str = str .. name .. ", "
			end
		end
    end
	
	leverSystemQuest:sendMessageToPlayers(participants, str)
	
	return false
end

function leverSystemQuest:prepare()

for index, v in pairs(LEVER_SYSTEM_QUEST_CONFIG) do
    local x = v["Lever"][1]
	local y = v["Lever"][2]
	local z = v["Lever"][3]
	local pos = Position(x, y, z)
	
	if pos then
	   local tile = Tile(pos)
	   if tile then
	      local items = tile:getItems()
	      if items then
	         for i, item in pairs(items) do
		         item:setAttribute(ITEM_ATTRIBUTE_ACTIONID, leverSystemQuest.aid)
			     item:setCustomAttribute("LEVER_SYSTEM_QUEST_INDEX", index)
			     item:setCustomAttribute("LEVER_SYSTEM_QUEST_ID", item:getId())
		     end 
		   end
	   end
	end
end

end
   
local globalevent = GlobalEvent("load_leverSystemQuest")
function globalevent.onStartup()
	leverSystemQuest:prepare()
end
globalevent:register()	
	
local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
      
	  local index = item:getCustomAttribute("LEVER_SYSTEM_QUEST_INDEX")
	  if not index then
	     return true
	  end
	   
	  local t = LEVER_SYSTEM_QUEST_CONFIG[index]
	  if not t then
	     print("TABLE NOT FOUND")
	     return true
	  end
	  
	  local ownerID = leverSystemQuest:getOwner(index)
	  if not ownerID  then
	     player:sendCancelMessage("You can't use this lever.")
		 return true
      end
	  
	  if player:getId() ~= ownerID then
	     player:sendCancelMessage("You can't use this lever.")
		 return true
      end
	  
	  local playersTable = leverSystemQuest:addPlayers(index)
	  
	  if not leverSystemQuest:checkPlayers(playersTable) then
	     return true
      end
	  
	  local participants = leverSystemQuest:getPlayers(playersTable)
	  leverSystemQuest:teleportPlayers(index, participants)
	  
	  local lever_id = item:getCustomAttribute("LEVER_SYSTEM_QUEST_ID")
	  if not lever_id then
	    print("LEVER ID NOT FOUND")
	    return true
      end
	 
	  if item:getId() == lever_id then
	     item:transform(lever_id + 1)
	  else
	     item:transform(lever_id)
	  end
	  
return true
end

action:aid(leverSystemQuest.aid)
action:register()