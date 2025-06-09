-- recursive dump function
function dumpLevel(input, level)
	local indent = ''

	for i = 1, level do
		indent = indent .. '    '
	end

	if type(input) == 'table' then
		local str = '{ \n'
		local lines = {}

		for k, v in pairs(input) do
			if type(k) ~= 'number' then
				k = '"' .. k .. '"'
			end

			if type(v) == 'string' then
				v = '"' .. v .. '"'
			end

			table.insert(lines, indent .. '    [' .. k .. '] = ' .. dumpLevel(v, level + 1))
		end
		return str .. table.concat(lines, ',\n') .. '\n' .. indent .. '}'
	end

	return tostring(input)
end

-- Return a string representation of input for debugging purposes
function dump(input)
	return dumpLevel(input, 0)
end

-- Call the dump function and print it to console
function pdump(input)
	local dump_str = dump(input)
	print(dump_str)
	return dump_str
end

-- Call the dump function with a title and print it beautifully to the console
function tdump(title, input)
	local title_fill = ''
	for i = 1, title:len() do
		title_fill = title_fill .. '='
	end

	local header_str = '\n====' .. title_fill .. '====\n'
	header_str = header_str .. '=== ' .. title .. ' ===\n'
	header_str = header_str .. '====' .. title_fill .. '====\n'

	local dump_str = dump(input)
	local footer_str = '\n====' .. title_fill .. '====\n'

	print(header_str .. dump_str .. footer_str)

	return dump_str
end

function deepCopy(object)

    local lookup_table = {}

    local function _copy(object)
        local new_table = {}

        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end

        lookup_table[object] = new_table

        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end

        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end

function removeFromTableByValue(tbl, val, _allentries) 
    for i,v in pairs(tbl) do
        if v == val then
            table.remove(tbl,i)
			if not _allentries then
			   break
			end
        end
    end
end

function removeFromTableAdvancedByValue(tbl, val, _allentries) 
    for i,v in pairs(tbl) do
        if v.ID and v.ID == val then
            table.remove(tbl,i)
			if not _allentries then
			   break
			end
        end
    end
end

-- function round(num, numDecimalPlaces)
  -- local mult = 10^(numDecimalPlaces or 0)
  -- return math.floor(num * mult + 0.5) / mult
-- end
function math.sign(v)
	return (v >= 0 and 1) or -1
end

function math.round(v, bracket)
	bracket = bracket or 1
	return math.floor(v/bracket + math.sign(v) * 0.5) * bracket
end