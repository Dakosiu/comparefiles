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
    
	