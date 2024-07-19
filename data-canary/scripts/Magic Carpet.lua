-- local condition = Condition(CONDITION_OUTFIT)
-- condition:setOutfit({lookType = 267})
-- condition:setTicks(-1)

local swimming = MoveEvent()
swimming:type("stepin")

function swimming.onStepIn(creature, item, position, fromPosition)
    
	local player = Player(creature)
	if not player then
	   creature:teleportTo(fromPosition, true)
	   return true
	end

	local outfit = creature:getOutfit()
	local mount = outfit.lookMount
		
	if not mount or mount ~= 689 then
	   player:teleportTo(fromPosition, true)
	   player:sendCancelMessage("You have to wear magic carpet mount to access this water.")
	   return true
	end
	    
	--creature:addCondition(condition)
	return true
end

swimming:id(4609, 4610, 4611, 4612, 4613, 4614, 4597, 4598, 4599, 4600, 4601, 4602)
swimming:register()

-- local swimming = MoveEvent()
-- swimming:type("stepout")

-- function swimming.onStepOut(creature, item, position, fromPosition)
	-- if not creature:isPlayer() then
		-- return false
	-- end

	-- creature:removeCondition(CONDITION_OUTFIT)
	-- return true
-- end

-- swimming:id(629, 630, 631, 632, 633, 634, 4809, 4810, 4811, 4812, 4813, 4814)
-- swimming:register()
