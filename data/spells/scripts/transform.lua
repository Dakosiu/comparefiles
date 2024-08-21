dofile('data/scripts/spells/transformConfig.lua')

local TransformCostTime = 3000 -- miliseconds

costEvent = {}
local function transformCost(playerId,costTable,revertPercent)
local statsPlayer = Player(playerId)
if statsPlayer then

end
end



function onCastSpell(creature, variant, isHotkey)
print("transform1")
local transformPlayer = Player(creature)
local pickedTable = child	
local pickedTableName = ""	
if transformPlayer then
print("transform2")
	local playerVocation = transformPlayer:getVocation()
	for i,child in pairs(TransformTable) do
print("transform3 "..i)
		for iTransform,childTransform in ipairs(child) do
print("transform4 "..iTransform)
			if childTransform.vocation.before ~= childTransform.vocation.after and childTransform.vocation.before == playerVocation:getId() then
print("transform5     "..playerVocation:getId())
				if transformPlayer:getLevel() >= childTransform.level then
print("transform6    "..childTransform.vocation.after)
local setVoc = Vocation(childTransform.vocation.after)
					transformPlayer:setVocation(setVoc)
print("transform7     "..transformPlayer:getVocation():getId())
					local playerOutfit = transformPlayer:getOutfit()
					local pickedOutfit = 1
					for _i,_child in ipairs(child[iTransform-1].lookTypes) do
					print("transform 8 ".._child.lookType)
						if playerOutfit.lookType == _child.lookType then
							pickedOutfit = _i
						end
					end
					
					playerOutfit.lookType = childTransform.lookTypes[pickedOutfit].lookType
					print("transform 9 "..childTransform.lookTypes[pickedOutfit].lookType)
					transformPlayer:setOutfit(playerOutfit)
					pickedTableName = i
					for _i,_child in ipairs(childTransform.transformEffects) do
						local transformEffectPosition = transformPlayer:getPosition()
						transformEffectPosition.x = transformEffectPosition.x + _child.pos.x;
						transformEffectPosition.y = transformEffectPosition.y + _child.pos.y;
						transformEffectPosition:sendMagicEffect(_child.id)
					end
					for _i,_child in ipairs(childTransform.stats) do
						local conditionContainer = Condition(CONDITION_ATTRIBUTES)
						conditionContainer:setParameter(CONDITION_PARAM_TICKS, -1)
						conditionContainer:setParameter(_child.condition, _child.value)
						transformPlayer:addCondition(conditionContainer)
					end
					if childTransform.permanent.hp > 0 then
						local actualHealth = transformPlayer:getMaxHealth()
						transformPlayer:setMaxHealth(actualHealth + childTransform.permanent.hp)
					end
					if childTransform.permanent.ki > 0 then
						local actualMana = transformPlayer:getMaxMana()
						transformPlayer:setMaxMana(actualMana + childTransform.permanent.ki)
					end
					if childTransform.ebeebe and childTransform.ebege then
					
					end
					costEvent[transformPlayer:getId()] = addEvent(transformCost,TransformCostTime,transformPlayer:getId(),childTransform.cost,childTransform.revertKiPercent)
					
				else
					transformPlayer:sendTextMessage(MESSAGE_STATUS_SMALL, "You need "..childTransform.level.." level to next transform!")
				end
				
				
				break
			end
	
		if string.len(pickedTableName) > 0 then
			break
end
end

		if string.len(pickedTableName) > 0 then
			break
end
	end
	end

	
	
	
	return true
end
