SCARAB_TILE_CONFIG = {
                       [1] = {
					           ["Position"] = { 836, 925, 3 },
							   ["Destination"] = { 838, 919, 3, effect = CONST_ME_TELEPORT },
							   ["Required Items"] = { 
							                          { itemid = 2159, count = 50 },
													},

							 }
					 }



ScarabTileSystem = { }
ScarabTileSystem.__newindex = ScarabTileSystem
ScarabTileSystem.storage = 5564
ScarabTileSystem.aid = 9124
ScarabTileSystem.index = "SCARAB_TILE_CONFIG_INDEX"

function ScarabTileSystem:prepare()
    for index, v in pairs(SCARAB_TILE_CONFIG) do
	    local t = v["Position"]
		if t then
		   local x = t[1]
		   local y = t[2]
		   local z = t[3]
		   local pos = Position(x, y, z)
		   if pos then
		      local tile = Tile(pos)
			  if tile then
			     local ground = tile:getGround()
				 if ground then
				    ground:setCustomAttribute(ScarabTileSystem.index, index)
					ground:setAttribute(ITEM_ATTRIBUTE_ACTIONID, ScarabTileSystem.aid)
			     end
			  end
		   end
		end
	end
end

local globalevent = GlobalEvent("load_ScarabTileSystem")
function globalevent.onStartup()
	 ScarabTileSystem:prepare()
end
globalevent:register()	


function ScarabTileSystem:canWalk(player, index)
    if not player or not index then
	   return nil
	end
	
	if player:getStorageValue(ScarabTileSystem.storage + index) >= 1 then
	   return true
	end
	
	return false
end

function ScarabTileSystem:getMissingItems(player, t)
    
	if not player or not t then
	   return nil
	end
	
    local str = "You still need: "
	local missingItemsCount = 0
	for index, v in pairs(t["Required Items"]) do
	    local id = v.itemid
		local count = v.count
		local playerCount = player:getItemCount(id)
		if playerCount < count then
		   local missingCount = count - playerCount
		   if index == #t["Required Items"] then
		      str = str .. missingCount .. "x " .. getItemName(id) .. "."
		   else
		      str = str .. missingCount .. "x " .. getItemName(id) .. ", " 
		   end
		   missingItemsCount = missingItemsCount + 1
		end
    end
	
	if missingItemsCount > 0 then
	   return str
	end
	
	return false
end

function ScarabTileSystem:removeRequiredItems(player, t)

	if not player or not t then
	   return nil
	end
    
	if ScarabTileSystem:getMissingItems(player, t) then
	   return false
	end
	
	for index, v in pairs(t["Required Items"]) do
	    local id = v.itemid
		local count = v.count
		player:removeItem(id, count)
    end
	
	return true
end

function ScarabTileSystem:setAccess(player, index)

    if not player or not index then
	   return nil
	end
	
	local t = SCARAB_TILE_CONFIG[index]
	if not t then
	   return nil
	end
	
	if ScarabTileSystem:removeRequiredItems(player, t) then
	   player:setStorageValue(ScarabTileSystem.storage + index, 1)
	   return true
	end
	return false
end
	
local moveevent = MoveEvent()
moveevent:type("stepin")
function moveevent.onStepIn(creature, item, position, fromPosition)
    
	local player = Player(creature)
	if not player then
	   return true
	end
	
	local index = item:getCustomAttribute(ScarabTileSystem.index)
	if not index then
	   return true
	end
	
	local t = SCARAB_TILE_CONFIG[index]
	if not t then
	   return true
	end
	
	local x = t["Destination"][1]
	local y = t["Destination"][2]
	local z = t["Destination"][3]
	local effect = t["Destination"].effect
	local destination = Position(x, y, z)
	
	if not ScarabTileSystem:canWalk(player, index) then
	   local missingItems = ScarabTileSystem:getMissingItems(player, t)
	   if missingItems then
	      player:sendTextMessage(MESSAGE_STATUS_WARNING, missingItems)
		  player:teleportTo(fromPosition)
		  return true
	   end
	   ScarabTileSystem:setAccess(player, index)
	   player:sendTextMessage(MESSAGE_INFO_DESCR, "You have unlocked access to this place.")
	   player:teleportTo(destination)
	   player:getPosition():sendMagicEffect(effect)
	   return true
	end
	
	player:teleportTo(destination)
	player:getPosition():sendMagicEffect(effect)
	
    
	return true
end
moveevent:aid(ScarabTileSystem.aid)
moveevent:register()
