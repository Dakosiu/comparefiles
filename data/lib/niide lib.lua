if not NIIDE_LIB then
    NIIDE_LIB = {}
end

function NIIDE_LIB:getNameByGuid(guid)
	local resultQuery = db.storeQuery("SELECT `name` FROM " .. "players" .. " WHERE " .. "id = " .. guid)
	if resultQuery then
	    local name = result.getString(resultQuery, "name")
		result.free(resultQuery)
		return name
	end
	return false
end
    
local squares = {
                  { x = 1, y = -1 },
				  { x = 0, y = -1 },
				  { x = -1, y = -1 },
				  { x = 1, y = 0 },
				  { x = -1, y = 0 },
				  { x = 1, y = 1 },
				  { x = 0, y = 1 },
				  { x = -1, y = 1 },
				}
						
function NIIDE_LIB:getClosestFreeSquare(creature, position)
   
   local t = {}
   
   local sqms = deepCopy(squares)
   
   local max_attempts = 1000
   local attempts = 0
   
    while #sqms > 0 do
        local tableNumber = math.random(1, #sqms)
		local positionTable = sqms[tableNumber]
		local pos = position
		if positionTable.x < 0 then
		   pos.x = pos.x - positionTable.x
		else
		   pos.x = pos.x + positionTable.x
		end
		if positionTable.y < 0 then
		   pos.y = pos.y - positionTable.y
		else
		   pos.y = pos.y + positionTable.y
		end		
		
		local tile = Tile(pos)
		if tile then
		    if #tile:getCreatures() == 0 and not tile:hasFlag(TILESTATE_BLOCKSOLID) and not tile:hasFlag(TILESTATE_IMMOVABLEBLOCKSOLID) then
			    return pos
			end
		end
		
		table.remove(sqms, tableNumber)
	end
		
   -- while attempts < max_attempts do
        -- local tableNumber = math.random(1, #squares)
		-- local positionTable = squares[tableNumber]
		-- local pos = position
		-- if positionTable.x < 0 then
		   -- pos.x = pos.x - positionTable.x
		-- else
		   -- pos.x = pos.x + positionTable.x
		-- end
		-- if positionTable.y < 0 then
		   -- pos.y = pos.y - positionTable.y
		-- else
		   -- pos.y = pos.y + positionTable.y
		-- end
		
		-- local tile = Tile(pos)
		-- if tile then
		    -- if not hasObstacle(pos, "solid") and #tile:getCreatures() == 0 and not tile:hasFlag(TILESTATE_BLOCKSOLID) and not tile:hasFlag(TILESTATE_IMMOVABLEBLOCKSOLID) then
			   -- return pos
			-- end
		-- end
		-- attempts = attempts + 1 
	-- end
    return false
end
		
function NIIDE_LIB:TimeFromStringToNumber(value)
	value = value:gsub(":", "")
	return tonumber(value)
end

function NIIDE_LIB:GetCurrentDateInNumber()
	local hour = tonumber(os.date("%H"))
	local minute = tonumber(os.date("%M"))
	local value = hour .. ":" .. minute
	
	return NIIDE_LIB:TimeFromStringToNumber(value)
end