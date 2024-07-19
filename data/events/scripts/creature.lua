-- function getBonus(outfit)
    -- for outfits, bonus in pairs(outfitBonuses) do
        -- if table.contains(outfits, outfit) then
            -- return bonus
        -- end
    -- end
    -- return nil
-- end

function Creature:onChangeOutfit(outfit)
    local player = Player(self)
	if player then
		local familiarLookType = self:getFamiliarLooktype()
		if familiarLookType ~= 0 then
			for _, summon in pairs(self:getSummons()) do
				if summon:getType():familiar() and string.find(summon:getName(), "familiar") then
						if summon:getOutfit().lookType ~= familiarLookType then
							summon:setOutfit({lookType = familiarLookType})
						end
					break
				end
			end
		end
		
		-- local previousBonus = getBonus(self:getOutfit().lookType)
        -- local newBonus = getBonus(outfit.lookType)
		local subid = 38
		if outfit.lookMount ~= 0 then
			for _, data in pairs(mountBonuses) do
				if table.contains(data.mounts, outfit.lookMount) then
					local mountCapCondition = Condition(CONDITION_ATTRIBUTES, CONDITIONID_COMBAT)
					mountCapCondition:setParameter(CONDITION_PARAM_TICKS, -1)
					mountCapCondition:setParameter(CONDITION_PARAM_SUBID, subid)
					mountCapCondition:setParameter(CONDITION_PARAM_STAT_CAPACITYPERCENT, data.capPercent)
					player:addCondition(mountCapCondition)
					break
				end
			end
		else
	        if player:getCondition(CONDITION_ATTRIBUTES, CONDITIONID_COMBAT, subid) then
	           player:removeCondition(CONDITION_ATTRIBUTES, CONDITIONID_COMBAT, subid)
            end
            --end
	    end
	end
	return true
end


function Creature:onHear(speaker, words, type)
end

function Creature:onAreaCombat(tile, isAggressive)
	return true
end

local function removeCombatProtection(cid)
	local player = Player(cid)
	if not player then
		return true
	end

	local time = 0
	if player:isMage() then
		time = 10
	elseif player:isPaladin() then
		time = 20
	else
		time = 30
	end

	player:setStorageValue(Storage.combatProtectionStorage, 2)
	addEvent(function(cid)
		local player = Player(cid)
		if not player then
			return
		end

		player:setStorageValue(Storage.combatProtectionStorage, 0)
		player:remove()
	end, time * 1000, cid)
end

picIf = {}
function Creature:onTargetCombat(target)
	if not self then
		return true
	end
	
	if self:isPlayer() and target:isMonster() and target:isFamiliar() then
	   return RETURNVALUE_YOUMAYNOTATTACKTHISCREATURE
	end

	if not picIf[target.uid] then
		if target:isMonster() then
			target:registerEvent("RewardSystemSlogan")
			picIf[target.uid] = {}
		end
	end

	if target:isPlayer() then
		if self:isMonster() then
			local protectionStorage = target:getStorageValue(Storage.combatProtectionStorage)

			if target:getIp() == 0 then -- If player is disconnected, monster shall ignore to attack the player
				if target:isPzLocked() then return true end
				if protectionStorage <= 0 then
					addEvent(removeCombatProtection, 30 * 1000, target.uid)
					target:setStorageValue(Storage.combatProtectionStorage, 1)
				elseif protectionStorage == 1 then
					self:searchTarget()
					return RETURNVALUE_YOUMAYNOTATTACKTHISPLAYER
				end

				return true
			end

			if protectionStorage >= os.time() then
				return RETURNVALUE_YOUMAYNOTATTACKTHISPLAYER
			end
		end
	end

	if ((target:isMonster() and self:isPlayer() and target:getMaster() == self)
	or (self:isMonster() and target:isPlayer() and self:getMaster() == target)) then
		return RETURNVALUE_YOUMAYNOTATTACKTHISCREATURE
	end

	if PARTY_PROTECTION ~= 0 then
		if self:isPlayer() and target:isPlayer() then
			local party = self:getParty()
			if party then
				local targetParty = target:getParty()
				if targetParty and targetParty == party then
					return RETURNVALUE_YOUMAYNOTATTACKTHISPLAYER
				end
			end
		end
	end

	if ADVANCED_SECURE_MODE ~= 0 then
		if self:isPlayer() and target:isPlayer() then
			if self:hasSecureMode() then
				return RETURNVALUE_YOUMAYNOTATTACKTHISPLAYER
			end
		end
	end

	self:addEventStamina(target)
	return true
end

function Creature:onDrainHealth(attacker, typePrimary, damagePrimary,
				typeSecondary, damageSecondary, colorPrimary, colorSecondary)
	if (not self) then
		return typePrimary, damagePrimary, typeSecondary, damageSecondary, colorPrimary, colorSecondary
	end

	if (not attacker) then
		return typePrimary, damagePrimary, typeSecondary, damageSecondary, colorPrimary, colorSecondary
	end
	
	if attacker:isPlayer() then
		if typePrimary ~= COMBAT_HEALING then
			-- Divine empowerment
			local data = WheelOfDestiny.Revelation.Divine_Empowerment.PLAYERS[attacker:getId()]
			if data then
				if data[1] >= os.time() then
					local pos = data[3]
					if attacker:getPosition():isInRange(Position(pos.x - 1, pos.y - 1, pos.z), Position(pos.x + 1, pos.y + 1, pos.z)) then
						damagePrimary = damagePrimary * data[2]
						damageSecondary = damageSecondary * data[2]
					end
				end
			end
		end
	end

	return typePrimary, damagePrimary, typeSecondary, damageSecondary, colorPrimary, colorSecondary
end
