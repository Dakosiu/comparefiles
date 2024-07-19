function Party:onJoin(player)
	return true
end

function Party:onLeave(player)
	return true
end

function Party:onDisband()
	return true
end


local function getMultiplier(exp, value)
    if value >= 100 then
       value = value / 100
    end
    exp = exp + (exp * value)
    return exp
end

local config =  {
                  [2] = 0.60,
				  [3] = 0.9,
				  [4] = 120,
			    }
				
				
function Party:onShareExperience(exp)
    local vocationIds = {}
	
	local vocationId = self:getLeader():getVocation():getBase():getId()
	if vocationId ~= VOCATION_NONE then
		table.insert(vocationIds, vocationId)
	end
	
    for _, member in ipairs(self:getMembers()) do
        local vocationId = member:getVocation():getBase():getId()
		if not table.contains(vocationIds, vocationId) and vocationId ~= VOCATION_NONE then
		   table.insert(vocationIds, vocationId)
		end
	end
	
	local size = #vocationIds
	
	local multiplierTable = config[size]
	if not multiplierTable then
	   return exp
	end
	
	return math.max(getMultiplier(exp, multiplierTable))
end
