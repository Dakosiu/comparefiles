local increasePercent = 0.5
local subid = 37

local inf_bp = MoveEvent()
function inf_bp.onEquip(player, item, slot, boolean)
	--if not boolean then
		-- local baseCap = player:getCapacity()
		-- local baseStor = math.max(player:getStorageValue(INF_BP_STOR), 0)
		-- local extraCap = baseCap * 0.50
		-- if baseStor <= 0 then
			-- player:setCapacity(baseCap + extraCap)
			-- player:setStorageValue(INF_BP_STOR, baseStor + extraCap)
		-- end

		
		local capCondition = Condition(CONDITION_ATTRIBUTES, CONDITIONID_DEFAULT)
		--capCondition:setParameter(CONDITION_PARAM_STAT_MAXHITPOINTS, 110)
		capCondition:setParameter(CONDITION_PARAM_TICKS, -1)
		capCondition:setParameter(CONDITION_PARAM_SUBID, subid)
		capCondition:setParameter(CONDITION_PARAM_STAT_CAPACITYPERCENT, increasePercent * 100)

		player:addCondition(capCondition)
					
	--end
	return true
end

inf_bp:type("equip")
inf_bp:id(31625)
inf_bp:register()

local inf_deEquip = MoveEvent()
function inf_deEquip.onDeEquip(player, item, slot)
	-- local baseStor = player:getStorageValue(INF_BP_STOR)
	-- local baseCap = player:getCapacity()
	-- if baseStor > 0 then
		-- player:setCapacity(baseCap - baseStor)
		-- player:setStorageValue(INF_BP_STOR, 0)
	-- end
	player:removeCondition(CONDITION_ATTRIBUTES, CONDITIONID_DEFAULT, subid)
	
	return true
end

inf_deEquip:type("deequip")
inf_deEquip:id(31625)
inf_deEquip:register()
