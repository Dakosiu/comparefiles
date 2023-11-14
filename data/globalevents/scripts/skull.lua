local storage = 5675623

local function getTopItem(position)
local tile = Tile(position)
local items = tile:getItems()
if #items < 1 then
return false
end
local item = items[1]
return item
end

function onThink(cid, interval, lastExecution)

if getGlobalStorageValue(storage + 1) == 1 then


local seconds = 0
			 for i = 0, 5 do
			 
			     if i == 0 then
			        addEvent(function()
					SKULL_POSITION_NORTH_WEST.tile:sendMagicEffect(8)
                    SKULL_POSITION_NORTH_EAST.tile:sendMagicEffect(8)

                    SKULL_POSITION_SOUTH_WEST.tile:sendMagicEffect(8)
                    SKULL_POSITION_SOUTH_EAST.tile:sendMagicEffect(8)
					
					SKULL_POSITION_BASIN_WEST.tile:sendMagicEffect(8)
                    SKULL_POSITION_BASIN_EAST.tile:sendMagicEffect(8)

                    end, seconds)
			     else
			        seconds = seconds + 750
				    addEvent(function()
			        SKULL_POSITION_NORTH_WEST.tile:sendMagicEffect(8)
                    SKULL_POSITION_NORTH_EAST.tile:sendMagicEffect(8)

                    SKULL_POSITION_SOUTH_WEST.tile:sendMagicEffect(8)
                    SKULL_POSITION_SOUTH_EAST.tile:sendMagicEffect(8)
					
					SKULL_POSITION_BASIN_WEST.tile:sendMagicEffect(8)
                    SKULL_POSITION_BASIN_EAST.tile:sendMagicEffect(8)
					
                    end, seconds)
			     end
			end
			
	setGlobalStorageValue(storage + 1, 0)
	
	
end


if getGlobalStorageValue(storage) ~= 1 then
local check = 0
local item = 0
local id = 0
local count = 0

local WEST_BASIN_SKULL = getTopItem(SKULL_POSITION_BASIN_WEST.tile)
if WEST_BASIN_SKULL then
   id = WEST_BASIN_SKULL:getId()
   count = WEST_BASIN_SKULL:getCount()
   if id == SkullID and count == SKULL_POSITION_BASIN_WEST.count then
      check = check + 1
	  if getGlobalStorageValue(storage + 2) ~= 1 then
	  SKULL_POSITION_BASIN_WEST.tile:sendMagicEffect(8)
	  setGlobalStorageValue(storage + 2, 1)
	  end
	  else
	  setGlobalStorageValue(storage + 2, 0)
   end
end

local EAST_BASIN_SKULL = getTopItem(SKULL_POSITION_BASIN_EAST.tile)
if EAST_BASIN_SKULL then
   id = EAST_BASIN_SKULL:getId()
   count = EAST_BASIN_SKULL:getCount()
   if id == SkullID and count == SKULL_POSITION_BASIN_EAST.count then
      check = check + 1
	  if getGlobalStorageValue(storage + 3) ~= 1 then
	  SKULL_POSITION_BASIN_EAST.tile:sendMagicEffect(8)
	  setGlobalStorageValue(storage + 3, 1)
	  end
	  else
	  setGlobalStorageValue(storage + 3, 0)
   end
end

local NORTH_WEST_SKULL = getTopItem(SKULL_POSITION_NORTH_WEST.tile)
if NORTH_WEST_SKULL then
   local checked = false
   id = NORTH_WEST_SKULL:getId()
   count = NORTH_WEST_SKULL:getCount()
   if id == SkullID and count == SKULL_POSITION_NORTH_WEST.count then
      check = check + 1
	  checked = true
	  if getGlobalStorageValue(storage + 4) ~= 1 then
	  SKULL_POSITION_NORTH_WEST.tile:sendMagicEffect(8)
	  setGlobalStorageValue(storage + 4, 1)
	  end
	  else
	  setGlobalStorageValue(storage + 4, 0)
   end
   else
   if getGlobalStorageValue(storage + 4) == 1 then
   setGlobalStorageValue(storage + 4, 0)
   end
end



local SOUTH_WEST_SKULL = getTopItem(SKULL_POSITION_SOUTH_WEST.tile)
if SOUTH_WEST_SKULL then
   id = SOUTH_WEST_SKULL:getId()
   count = SOUTH_WEST_SKULL:getCount()
   if id == SkullID and count == SKULL_POSITION_SOUTH_WEST.count then
      check = check + 1
	  if getGlobalStorageValue(storage + 5) ~= 1 then
	  SKULL_POSITION_SOUTH_WEST.tile:sendMagicEffect(8)
	  setGlobalStorageValue(storage + 5, 1)
	  end
	  else
	  setGlobalStorageValue(storage + 5, 0)
   end
   else
   if getGlobalStorageValue(storage + 5) == 1 then
   setGlobalStorageValue(storage + 5, 0)
   end
end



local SOUTH_EAST_SKULL = getTopItem(SKULL_POSITION_SOUTH_EAST.tile)
if SOUTH_EAST_SKULL then
   id = SOUTH_EAST_SKULL:getId()
   count = SOUTH_EAST_SKULL:getCount()
   if id == SkullID and count == SKULL_POSITION_SOUTH_EAST.count then
      check = check + 1
	  if getGlobalStorageValue(storage + 6) ~= 1 then
	  SKULL_POSITION_SOUTH_EAST.tile:sendMagicEffect(8)
	  setGlobalStorageValue(storage + 6, 1)
	  end
	  else
	  setGlobalStorageValue(storage + 6, 0)
   end
   else
   if getGlobalStorageValue(storage + 6) == 1 then
   setGlobalStorageValue(storage + 6, 0)
   end
end



local NORTH_EAST_SKULL = getTopItem(SKULL_POSITION_NORTH_EAST.tile)
if NORTH_EAST_SKULL then
   id = NORTH_EAST_SKULL:getId()
   count = NORTH_EAST_SKULL:getCount()
   if id == SkullID and count == SKULL_POSITION_NORTH_EAST.count then
      check = check + 1
	  if getGlobalStorageValue(storage + 7) ~= 1 then
	  SKULL_POSITION_NORTH_EAST.tile:sendMagicEffect(8)
	  setGlobalStorageValue(storage + 7, 1)
	  end
	  else
	  setGlobalStorageValue(storage + 7, 0)
   end
   else
   if getGlobalStorageValue(storage + 7) == 1 then
   setGlobalStorageValue(storage + 7, 0)
   end
end


if check == 6 then
setGlobalStorageValue(storage, 1)
setGlobalStorageValue(storage + 1, 1)

local position1 = Position(878, 867, 10)
local position2 = Position(879, 867, 10)
local wall1 = Tile(position1):getItemById(1718)
local wall2 = Tile(position2):getItemById(1718)


addEvent(function()
if wall1 then
wall1:remove()
end

if wall2 then
wall2:remove()
end
end, 500)

end

end


return true
end
