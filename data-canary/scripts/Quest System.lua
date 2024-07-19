-- CREATE TABLE `player_quests` (
-- `quest_name` varchar(30) NOT NULL,
-- `player_id` bigint(20) NOT NULL,
-- `finished` bigint(20) NOT NULL
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

QUEST_SYSTEM_CONFIG = {
                        ["Annhilator"] = {
							              [1] = {
								                  ["Position"] = { 932, 873, 6 },
										          ["Rewards"] = {
										                          { type = "item", id = 3043, count = 5 },
																  { type = "item", id = 3035, count = 15 },
																  { type = "experience bonus", value = 0.01 },
																  { type = "mission bonus", value = 1 },
													            }
									            },
							            },						  
					  }
					  
					  
					  

QUEST_SYSTEM = {}
QUEST_SYSTEM.actionid = 122
QUEST_SYSTEM.attributes = { 
                            index = "quest_system_index",
							index_reward = "quest_system_index_reward",
						  }

function QUEST_SYSTEM:StartUp()
   for index, questTable in pairs(QUEST_SYSTEM_CONFIG) do
       for i, v in pairs(questTable) do
          local positionTable = v["Position"]
	      if positionTable then
	         local x = positionTable[1]
		     local y = positionTable[2]
		     local z = positionTable[3]
		     local pos = Position(x, y, z)
		     if pos then
		        local tile = Tile(pos)
			    if tile then
			       local items = tile:getItems()
				   if items and #items > 0 then
				      for _, item in pairs(items) do
				          item:setCustomAttribute(QUEST_SYSTEM.attributes.index, index)
						  item:setCustomAttribute(QUEST_SYSTEM.attributes.index_reward, i)
						  item:setAttribute(ITEM_ATTRIBUTE_ACTIONID, QUEST_SYSTEM.actionid)
						  QUEST_SYSTEM:addItemToChest(item)
						  QUEST_SYSTEM:getAllItemsInside(item)
					  end
				  end
				end
		     end
			end
	    end
	end
end

function QUEST_SYSTEM:isQuest(item)
    if not item then
	   return nil
	end
	
	if item:getCustomAttribute(QUEST_SYSTEM.attributes.index) then
	   return true
	end
	return false
end

function QUEST_SYSTEM:getDescription(item)
    if not item then
	   return nil
	end
	
   	local index = item:getCustomAttribute(QUEST_SYSTEM.attributes.index)
	local index_reward = item:getCustomAttribute(QUEST_SYSTEM.attributes.index_reward)
	
	if not index or not index_reward then
	   return ""
	end
	local str = "\n" .. "Quest Index: " .. index .. "\n" .. "Reward Index: " .. index_reward
	return str
end

function QUEST_SYSTEM:getIndex(item)

    if not item then
	   return nil
	end
    
	local index = item:getCustomAttribute(QUEST_SYSTEM.attributes.index)
	if not index then
	   return false
	end
	
	return index
end

function QUEST_SYSTEM:getIndexReward(item)

    if not item then
	   return nil
	end
	
	local index = item:getCustomAttribute(QUEST_SYSTEM.attributes.index_reward)
	if not index then
	   return false
	end
	return index
end

function QUEST_SYSTEM:addItemToChest(chest)
    
	if not chest then
	   return
	end
	
	if not chest:isContainer() then
	   return
	end
	
	local index = QUEST_SYSTEM:getIndex(chest)
	local index_reward = QUEST_SYSTEM:getIndexReward(chest)
	if not index or not index_reward then
	   return
	end
	
	local rewardsTable = QUEST_SYSTEM_CONFIG[index][index_reward]["Rewards"]
	if not rewardsTable then
	   return
	end
	
	for _, v in pairs(rewardsTable) do
	   if v.type == "item" then
	      local id = v.id
		  local count = v.count
		  chest:addItem(id, count)
	   end
	end
	
end

function QUEST_SYSTEM:getAllItemsInside(chest)
    local itemList = {}
    if chest:isContainer() then
        local size = chest:getSize()
        for slot=0, size-1 do
            local item = chest:getItem(slot)
            if (item) then
                if(item:isContainer()) then
                    itemList = TableConcat(itemList, item:getAllItemsInside())
                end
                itemList[#itemList+1] = { type = "item", id = item:getId(), count = item:getCount() }
            end
        end
    end
    return itemList
end

function QUEST_SYSTEM:addRewards(player, chest)
   
   if not player or not chest then
      return
   end
   
   local rewardsTable = {}
   
   local itemsTable = QUEST_SYSTEM:getAllItemsInside(chest)
   if itemsTable then
      for i, v in pairs(itemsTable) do
	      rewardsTable[#rewardsTable+1] = v
	  end
   end
   
   local index = QUEST_SYSTEM:getIndex(chest)
   local index_reward = QUEST_SYSTEM:getIndexReward(chest)
   
   local t = QUEST_SYSTEM_CONFIG[index][index_reward]["Rewards"]
   
   for i, v in pairs(t) do
       if v.type ~= "item" then
	      rewardsTable[#rewardsTable+1] = v
	   end
   end
   
   dakosLib:addReward(player, rewardsTable)
end

function QUEST_SYSTEM:isFinished(player, chest)
    
	if not player or not chest then
	   return
	end
	
	local guid = player:getGuid()
	local index = '"' .. QUEST_SYSTEM:getIndex(chest) .. '"'
    local resultx = db.storeQuery("SELECT `player_id` FROM `player_quests` WHERE `player_id` = " .. guid .. " AND `quest_name` = " .. index)
	
	if resultx then
	   result.free(resultx)
	   return true
	end
	result.free(resultx)
	return false
end

function QUEST_SYSTEM:setFinished(player, chest)

	if not player or not chest then
	   return
	end
	
	if QUEST_SYSTEM:isFinished(player, chest) then
	   player:sendCancelMessage("You have already got reward from this quest.")
	   return
	end
	
	local guid = player:getGuid()
	local index = '"' .. QUEST_SYSTEM:getIndex(chest) .. '"'
	db.query("INSERT INTO `player_quests` (`quest_name`, `player_id`, `finished`) VALUES " .. "(" .. index .. "," .. guid .. ", " .. 1 .. ")" .. ";")
	QUEST_SYSTEM:addRewards(player, chest)
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
end	
    	
local globalevent = GlobalEvent("QUEST_SYSTEM_onStartUp")
function globalevent.onStartup()
	QUEST_SYSTEM:StartUp()
	return true
end
globalevent:register()


local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    --QUEST_SYSTEM:addRewards(player, item)
	QUEST_SYSTEM:setFinished(player, item)
	return true
end
action:aid(QUEST_SYSTEM.actionid)
action:register()