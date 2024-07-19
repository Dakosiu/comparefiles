function compileUpgradeTable(value)
    local separator = "`"
    return table.concat(value, separator)
end

function string:verifyStatIntegrity()
    local word = self:match("[+-x]?%d+%.?%d*%%?") or ""
    local length = self:len()
    
    return word:len() == length
end
	
function string:getValues()
    local s = self:split(separator)
    local out = {}
    
    if not s[2] then
        s[2] = ""
    end
    
    out = {{
        key = s[1],
        sign = s[2]:match("[+-x]?"),
        amount = s[2]:match("%d+%.?%d*"),
        flat = not s[2]:match("%%")
    }}
    
    return out
end

function generateChance(value)
      local number = math.random(0,100)
	  
	  if value == 0 then
	     return false
	  end
	  
      if number <= value then
         return true
      end

return false
end

function getValueFromString(txt)
local str = ""
string.gsub(txt,"%d+",function(e)
 str = str .. e
end)
return str;
end

function get_date(player, storage)
local time_string = ""
local time_left = player:getStorageValue(storage) - os.time()
local hours = string.format("%02.f", math.floor(time_left / 3600))
local mins = string.format("%02.f", math.floor(time_left / 60 - (hours * 60)))
local secs = string.format("%02.f", math.floor(time_left  - hours * 3600 - mins * 60))
--local time_string = hours ..":".. mins ..":".. secs

if hours == "00" then
time_string = mins .. " Minutes" .. " and " .. secs .. " Seconds" .. "."
else
time_string = hours .. " Hours" .. ", " .. mins .. " Minutes" .. " and " .. secs .. " Seconds" .. "."
end


return time_string
end


function removeFirst(tbl, val)
  for i, v in ipairs(tbl) do
    if v == val then
      return table.remove(tbl, i)
    end
  end
end

function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

function table.hasKey(table, key)

   for k, value in pairs(table) do
   
      if k == key then
	     return true
      end
   end
   
   return false
end


function mod(a, b)
    return a - (math.floor(a/b)*b)
end

function get_date(player, storage)
    local total_seconds = player:getStorageValue(storage) - os.time()
    local time_days     = math.floor(total_seconds / 86400)
    local time_hours    = math.floor(mod(total_seconds, 86400) / 3600)
    local time_minutes  = math.floor(mod(total_seconds, 3600) / 60)
    local time_seconds  = math.floor(mod(total_seconds, 60))
    if (time_hours < 10) then
        time_hours = "0" .. time_hours
    end
    if (time_minutes < 10) then
        time_minutes = "0" .. time_minutes
    end
    if (time_seconds < 10) then
        time_seconds = "0" .. time_seconds
    end
	
	local timestring = time_days .. " Days" .. ", " .. time_hours .. " Hours" .. ", " .. time_minutes .. " Minutes" .. " and " .. time_seconds .. " seconds."
	--local timestring = time_days .. " Days " .. time_hours .. " Hours "  .. time_minutes .. " Minutes" .. " and " .. time_seconds .. " seconds."
	return timestring
end