local config = {
    outfit = 12,
    effect = 364, -- Effect on equip and deequip
    distanceeffect = 77, -- Distance effect on equip and deequip
    distanceeffectaura = 32, -- Distance effect aura
    -- animation means how fast the aura should go around the player so 500 = 0.5 sec, 1 sec = 1000
    animation = 500,
    ["Burner"] = {
				   checkTime = 3, -- in seconds
				   effect = CONST_ME_MAGIC_RED,
				   ["Required Items"] = {
						                  { itemid = 26180, count = 2 },
										--   { itemid = 2160, count = 1 },
										},
			     }
}   

-- Do not change the ticks or sub ids if you don't know how to do that :D
local condition = Condition(CONDITION_ATTRIBUTES)
condition:setParameter(CONDITION_PARAM_TICKS, -1)
condition:setParameter(CONDITION_PARAM_STAT_MAXHITPOINTSPERCENT, 120)
condition:setParameter(CONDITION_PARAM_STAT_MAXMANAPOINTSPERCENT, 120)
condition:setParameter(CONDITION_PARAM_SUBID, 1)

-- Do not change the ticks or sub ids if you don't know how to do that :D
local condition2 = Condition(CONDITION_OUTFIT)
condition2:setParameter(CONDITION_PARAM_TICKS, -1)
condition2:setOutfit({lookType = config.outfit})
condition2:setParameter(CONDITION_PARAM_SUBID, 1)

local effectEvent = nil
local requireditemsEvent = nil

function RingAura(cid)
    local player = Player(cid)
    if player then
        local pos = player:getPosition()
        Position(pos.x, pos.y+1, pos.z):sendDistanceEffect(Position(pos.x-1, pos.y, pos.z), config.distanceeffectaura)       
        Position(pos.x-1, pos.y, pos.z):sendDistanceEffect(Position(pos.x, pos.y-1, pos.z), config.distanceeffectaura)
        Position(pos.x, pos.y-1, pos.z):sendDistanceEffect(Position(pos.x+1, pos.y, pos.z), config.distanceeffectaura)
        Position(pos.x+1, pos.y, pos.z):sendDistanceEffect(Position(pos.x, pos.y+1, pos.z), config.distanceeffectaura)
        effectEvent = addEvent(RingAura, 1 * config.animation, cid)
    else
        effectEvent = nil
    end
end

function Test(self)

    local player = Player(self)
    if player then
	   if player:getName() == "Dakoseq" or player:getName() == "Vanagas" then
	      local burnerTable = config["Burner"]
	      local interval = burnerTable.checkTime
		  local effect = burnerTable.effect
		  local missingItems = {}
		  local missingString = ""
		  
		  for index, itemsTable in pairs(burnerTable["Required Items"]) do
			  local id = itemsTable.itemid
			  local count = itemsTable.count
			  if player:getItemCount(id) < count then
			     local countLeft = count - player:getItemCount(id)
				 local values = { ["ItemID"] = id, ["Count"] = countLeft }
			     table.insert(missingItems, values)
			  end
		  end
		  
		  if #missingItems > 0 then
			     local str = "Ring lost his power.. You still need "
				 for index, missingTable in pairs(missingItems) do
				     local id = missingTable["ItemID"]
					 local count = missingTable["Count"]
					 
				     if index == #missingItems then
					    str = str .. count .. " " .. getItemName(id) .. " to active this ring again."
				     else
					    str = str .. count .. " " .. getItemName(id) .. ", "
			         end
				end
				requireditemsEvent = addEvent(Test, interval * 3000, self)
				stopEvent(effectEvent)
				player:removeCondition(CONDITION_ATTRIBUTES, condition, 1)
                player:removeCondition(CONDITION_OUTFIT, condition2, 1)
				player:say(str)
			    return true
		  end
		  
		  for index, itemsTable in pairs(burnerTable["Required Items"]) do
		  	  local id = itemsTable.itemid
			  local count = itemsTable.count
		      player:removeItem(id, count)
		  end
		  
		  local pos = player:getPosition()
		  pos:sendMagicEffect(effect)
		  
          requireditemsEvent = addEvent(Test, interval * 3000, self)
	end
	end
end


function onEquip(player, item, slot, isCheck)
 
		local missingItems = {}
		local missingString = ""
		local burnerTable = config["Burner"]
		
    	for index, itemsTable in pairs(burnerTable["Required Items"]) do
			  local id = itemsTable.itemid
			  local count = itemsTable.count
			  if player:getItemCount(id) < count then
			     local countLeft = count - player:getItemCount(id)
				 local values = { ["ItemID"] = id, ["Count"] = countLeft }
			     table.insert(missingItems, values)
			  end
		end
		
		if #missingItems > 0 then
			     local str = "To active this ring you need still: "
				 for index, missingTable in pairs(missingItems) do
				     local id = missingTable["ItemID"]
					 local count = missingTable["Count"]
					 
				     if index == #missingItems then
					    str = str .. count .. " " .. getItemName(id) .. "."
				     else
					    str = str .. count .. " " .. getItemName(id) .. ", "
			         end
				end
				player:say(str)
				stopEvent(requireditemsEvent)
			    return false
		  end
		  
    if isCheck then
        return true
    end
	
	player:saveHealth()
    player:saveMana()
	
    local pos = player:getPosition()
    player:addCondition(condition)
    player:addCondition(condition2)
    pos:sendMagicEffect(config.effect)
    player:say('ACTIVATED', TALKTYPE_MONSTER_SAY)
    Position(pos.x+1, pos.y+1, pos.z):sendDistanceEffect(pos, config.distanceeffect)
    Position(pos.x+1, pos.y-1, pos.z):sendDistanceEffect(pos, config.distanceeffect)
    Position(pos.x-1, pos.y-1, pos.z):sendDistanceEffect(pos, config.distanceeffect)
    Position(pos.x-1, pos.y+1, pos.z):sendDistanceEffect(pos, config.distanceeffect)
    effectEvent = addEvent(RingAura, 1 * 1000, player:getId())
	
	requireditemsEvent = addEvent(Test, 3000, player:getId())
end

function onDeEquip(player, item, slot)
    local pos = player:getPosition()
    pos:sendMagicEffect(config.effect)
    pos:sendDistanceEffect(Position(pos.x+1, pos.y+1, pos.z), config.distanceeffect)
    pos:sendDistanceEffect(Position(pos.x+1, pos.y-1, pos.z), config.distanceeffect)
    pos:sendDistanceEffect(Position(pos.x-1, pos.y-1, pos.z), config.distanceeffect)
    pos:sendDistanceEffect(Position(pos.x-1, pos.y+1, pos.z), config.distanceeffect)
    player:say('DEACTIVATED', TALKTYPE_MONSTER_SAY)
    stopEvent(effectEvent)
    player:removeCondition(CONDITION_ATTRIBUTES, condition, 1)
    player:removeCondition(CONDITION_OUTFIT, condition2, 1)
	stopEvent(requireditemsEvent)
	player:updateHealth()
    player:updateMana()
    return true
end