local TransformCostTime = 60000 -- miliseconds



local TransformTable = {
	["Saiyan"] = {
		[1] = {name = "Young", vocation = {before = 1, after = 1, revert = 1}, level = 1, shader = 0, revertKiPercent = 25,
		permanent = {hp = 5000,ki = 5000,}, cost = {transformUseHp = 100,transformUseKi = 100,transformUsePercentHp = 0.1,transformUsePercentKi = 1},
		lookTypes = {
		[1] = {lookType = 33, name = "Young Goku"},
		[2] = {lookType = 44, name = "Young Saiyan from Vegeta"},
		[3] = {lookType = 55, name = "Young Oozaru"},
		[4] = {lookType = 66, name = "Young Saiyan"},
		[5] = {lookType = 77, name = "Young Saiyan2"},
		[6] = {lookType = 88, name = "Young Saiyan3"}
		}, stats = {
		{condition = CONDITION_PARAM_STAT_MAXHITPOINTS, value = 5000}, 
		{condition = CONDITION_PARAM_STAT_MAXMANAPOINTS, value = 5000}, 
		{condition = CONDITION_PARAM_STAT_MAXHITPOINTSPERCENT, value = 5000}, 
		{condition = CONDITION_PARAM_STAT_MAXMANAPOINTSPERCENT, value = 5000},
		{condition = CONDITION_PARAM_SKILL_MELEE, value = 10}, 
		{condition = CONDITION_PARAM_SKILL_MELEE_DEFENSE, value = 10}, 
		{condition = CONDITION_PARAM_SKILL_ATTACK_SPEED, value = 10}, 
		{condition = CONDITION_PARAM_SKILL_MOVEMENT_SPEED, value = 10}, 
		{condition = CONDITION_PARAM_SKILL_KI_DAMAGE, value = 10}, 
		{condition = CONDITION_PARAM_SKILL_KI_DEFENSE, value = 10}
		}, transformEffects = {
		{pos = {x = 0, y = 0}, id = 78}
		}, revertEffects = {
		{pos = {x = 0, y = 0}, id = 78}
		}
		}, 
		[2] = {name = "Teen", vocation = {before = 1, after = 2, revert = 1}, level = 10, shader = 0, revertKiPercent = 25,
		permanent = {hp = 5000,ki = 5000,}, cost = {transformUseHp = 100,transformUseKi = 100,transformUsePercentHp = 0.1,transformUsePercentKi = 1},
		lookTypes = {
		[1] = {lookType = 33, name = "Teen Goku"},
		[2] = {lookType = 44, name = "Teen Saiyan from Vegeta"},
		[3] = {lookType = 55, name = "Teen Oozaru"},
		[4] = {lookType = 66, name = "Teen Saiyan"},
		[5] = {lookType = 77, name = "Teen Saiyan2"},
		[6] = {lookType = 88, name = "Teen Saiyan3"}
		}, stats = {
		{condition = CONDITION_PARAM_STAT_MAXHITPOINTS, value = 5000}, 
		{condition = CONDITION_PARAM_STAT_MAXMANAPOINTS, value = 5000}, 
		{condition = CONDITION_PARAM_STAT_MAXHITPOINTSPERCENT, value = 5000}, 
		{condition = CONDITION_PARAM_STAT_MAXMANAPOINTSPERCENT, value = 5000},
		{condition = CONDITION_PARAM_SKILL_MELEE, value = 10}, 
		{condition = CONDITION_PARAM_SKILL_MELEE_DEFENSE, value = 10}, 
		{condition = CONDITION_PARAM_SKILL_ATTACK_SPEED, value = 10}, 
		{condition = CONDITION_PARAM_SKILL_MOVEMENT_SPEED, value = 10}, 
		{condition = CONDITION_PARAM_SKILL_KI_DAMAGE, value = 10}, 
		{condition = CONDITION_PARAM_SKILL_KI_DEFENSE, value = 10}
		}, transformEffects = {
		{pos = {x = 0, y = 0}, id = 78}
		}, revertEffects = {
		{pos = {x = 0, y = 0}, id = 78}
		}
		}, 
		[3] = {name = "Adult", vocation = {before = 2, after = 3, revert = 3}, level = 12, shader = 0, revertKiPercent = 25,
		permanent = {hp = 5000,ki = 5000,}, cost = {transformUseHp = 100,transformUseKi = 100,transformUsePercentHp = 0.1,transformUsePercentKi = 1},
		lookTypes = {
		[1] = {lookType = 33, name = "Adult Goku"},
		[2] = {lookType = 44, name = "Adult Saiyan from Vegeta"},
		[3] = {lookType = 55, name = "Adult Oozaru"},
		[4] = {lookType = 66, name = "Adult Saiyan"},
		[5] = {lookType = 77, name = "Adult Saiyan2"},
		[6] = {lookType = 88, name = "Adult Saiyan3"}
		}, stats = {
		{condition = CONDITION_PARAM_STAT_MAXHITPOINTS, value = 5000}, 
		{condition = CONDITION_PARAM_STAT_MAXMANAPOINTS, value = 5000}, 
		{condition = CONDITION_PARAM_STAT_MAXHITPOINTSPERCENT, value = 5000}, 
		{condition = CONDITION_PARAM_STAT_MAXMANAPOINTSPERCENT, value = 5000},
		{condition = CONDITION_PARAM_SKILL_MELEE, value = 10}, 
		{condition = CONDITION_PARAM_SKILL_MELEE_DEFENSE, value = 10}, 
		{condition = CONDITION_PARAM_SKILL_ATTACK_SPEED, value = 10}, 
		{condition = CONDITION_PARAM_SKILL_MOVEMENT_SPEED, value = 10}, 
		{condition = CONDITION_PARAM_SKILL_KI_DAMAGE, value = 10}, 
		{condition = CONDITION_PARAM_SKILL_KI_DEFENSE, value = 10}
		}, transformEffects = {
		{pos = {x = 0, y = 0}, id = 78}
		}, revertEffects = {
		{pos = {x = 0, y = 0}, id = 78}
		}
		}, 
		[4] = {name = "Super", vocation = {before = 3, after = 4, revert = 3}, level = 22, shader = 0, revertKiPercent = 25,
		permanent = {hp = 5000,ki = 5000,}, cost = {transformUseHp = 100,transformUseKi = 100,transformUsePercentHp = 0.1,transformUsePercentKi = 1},
		lookTypes = {
		[1] = {lookType = 33, name = "Super Goku"},
		[2] = {lookType = 44, name = "Super Saiyan from Vegeta"},
		[3] = {lookType = 55, name = "Super Oozaru"},
		[4] = {lookType = 66, name = "Super Saiyan"},
		[5] = {lookType = 77, name = "Super Saiyan2"},
		[6] = {lookType = 88, name = "Super Saiyan3"}
		}, stats = {
		{condition = CONDITION_PARAM_STAT_MAXHITPOINTS, value = 5000}, 
		{condition = CONDITION_PARAM_STAT_MAXMANAPOINTS, value = 5000}, 
		{condition = CONDITION_PARAM_STAT_MAXHITPOINTSPERCENT, value = 5000}, 
		{condition = CONDITION_PARAM_STAT_MAXMANAPOINTSPERCENT, value = 5000},
		{condition = CONDITION_PARAM_SKILL_MELEE, value = 10}, 
		{condition = CONDITION_PARAM_SKILL_MELEE_DEFENSE, value = 10}, 
		{condition = CONDITION_PARAM_SKILL_ATTACK_SPEED, value = 10}, 
		{condition = CONDITION_PARAM_SKILL_MOVEMENT_SPEED, value = 10}, 
		{condition = CONDITION_PARAM_SKILL_KI_DAMAGE, value = 10}, 
		{condition = CONDITION_PARAM_SKILL_KI_DEFENSE, value = 10}
		}, transformEffects = {
		{pos = {x = 0, y = 0}, id = 78}
		}, revertEffects = {
		{pos = {x = 0, y = 0}, id = 78}
		}
		}, 
		[5] = {name = "God", vocation = {before = 4, after = 5, revert = 3}, level = 200, shader = 0, revertKiPercent = 25,
		permanent = {hp = 5000,ki = 5000,}, cost = {transformUseHp = 100,transformUseKi = 100,transformUsePercentHp = 0.1,transformUsePercentKi = 1},
		lookTypes = {
		[1] = {lookType = 31, name = "God Goku"},
		[2] = {lookType = 42, name = "God Saiyan from Vegeta"},
		[3] = {lookType = 53, name = "God Oozaru"},
		[4] = {lookType = 64, name = "God Saiyan"},
		[5] = {lookType = 75, name = "God Saiyan2"},
		[6] = {lookType = 86, name = "God Saiyan3"}
		}, stats = {
		{condition = CONDITION_PARAM_STAT_MAXHITPOINTS, value = 5000}, 
		{condition = CONDITION_PARAM_STAT_MAXMANAPOINTS, value = 5000}, 
		{condition = CONDITION_PARAM_STAT_MAXHITPOINTSPERCENT, value = 5000}, 
		{condition = CONDITION_PARAM_STAT_MAXMANAPOINTSPERCENT, value = 5000},
		{condition = CONDITION_PARAM_SKILL_MELEE, value = 10}, 
		{condition = CONDITION_PARAM_SKILL_MELEE_DEFENSE, value = 10}, 
		{condition = CONDITION_PARAM_SKILL_ATTACK_SPEED, value = 10}, 
		{condition = CONDITION_PARAM_SKILL_MOVEMENT_SPEED, value = 10}, 
		{condition = CONDITION_PARAM_SKILL_KI_DAMAGE, value = 10}, 
		{condition = CONDITION_PARAM_SKILL_KI_DEFENSE, value = 10}
		}, transformEffects = {
		{pos = {x = 0, y = 0}, id = 78}
		}, revertEffects = {
		{pos = {x = 0, y = 0}, id = 78}
		}
		} 
		},
	["Vegeta"] = {
		[1] = {name = "Young", vocation = {before = 11, after = 11, revert = 11}, level = 1, shader = 0, revertKiPercent = 25
		}
	}
	}








costEvent = {}
local function transformCost(playerId,costTable,revertPercent)
local statsPlayer = Player(playerId)
if statsPlayer then

end
end



function onCastSpell(creature, variant, isHotkey)
print("revert1")
local transformPlayer = Player(creature)
local pickedTable = child	
local pickedTableName = ""	
if transformPlayer then
print("revert2")
	local playerVocation = transformPlayer:getVocation()
	for i,child in pairs(TransformTable) do
print("revert3 "..i)
		for iTransform,childTransform in ipairs(child) do
print("revert4 "..iTransform)
			if childTransform.vocation.revert ~= childTransform.vocation.after and childTransform.vocation.after == playerVocation:getId() then

print("revert5     "..playerVocation:getId())
print("revert6    "..childTransform.vocation.revert)
local setVoc = Vocation(childTransform.vocation.revert)
					transformPlayer:setVocation(setVoc)
print("revert7     "..transformPlayer:getVocation():getId())
					local playerOutfit = transformPlayer:getOutfit()
					local pickedOutfit = 1
					for _i,_child in ipairs(child[iTransform].lookTypes) do
					print("revert 8 ".._child.lookType)
						if playerOutfit.lookType == _child.lookType then
							pickedOutfit = _i
						end
					end
					
					for _iTransform,_childTransform in ipairs(child) do
					if _childTransform.vocation.after == childTransform.vocation.revert then
					playerOutfit.lookType = _childTransform.lookTypes[pickedOutfit].lookType
					end
					end
					print("revert 9 "..childTransform.lookTypes[pickedOutfit].lookType)
					transformPlayer:setOutfit(playerOutfit)
					pickedTableName = i
					for _i,_child in ipairs(childTransform.revertEffects) do
						local transformEffectPosition = transformPlayer:getPosition()
						transformEffectPosition.x = transformEffectPosition.x + _child.pos.x;
						transformEffectPosition.y = transformEffectPosition.y + _child.pos.y;
						transformEffectPosition:sendMagicEffect(_child.id)
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
