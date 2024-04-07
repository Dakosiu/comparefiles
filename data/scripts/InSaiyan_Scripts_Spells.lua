
for i, child in pairs(Wikipedia.Spells) do
    local customSpell = Spell(SPELL_INSTANT)
    function customSpell.onCastSpell(creature, variant, isHotkey)
        spellcast_castSpell(creature, child.word, nil)
    end
    customSpell:name(i)
    customSpell:id(child.spellSV-29950)
    customSpell:words(child.word)
    customSpell:level(child.min_L)
    customSpell:mana(child.manaCost)
    customSpell:group(child.spellGroup)
    customSpell:isAggressive(child.aggressive)
    customSpell:cooldown(child.cooldown * 1000)
	local getVocations = child.vocation or {}
    for _i, _child in pairs(getVocations) do
        customSpell:vocation(_child)
    end
	if child.groupCooldown then
		customSpell:groupCooldown(child.groupCooldown * 1000)
	end
    customSpell:needLearn(false)
    customSpell:register()

end


local healthChangeDistanceFighter = CreatureEvent("healthChangeDistanceFighter")
healthChangeDistanceFighter:type("damagechange")

local playerTargetedList = {}
function removeFromTargetList(playerId, targetId)
    for i, child in pairs(playerTargetedList[playerId]) do
        if child.targetId == targetId and os.time() >= child.removeTime then
            table.remove(playerTargetedList[playerId], i)
        end
    end
end

function addToTargetList(playerId, targetId)
    local finded = false
    if not playerTargetedList[playerId] then
        playerTargetedList[playerId] = {}
    end
    for i, child in pairs(playerTargetedList[playerId]) do
        if child.targetId == targetId then
            finded = true
            child.removeTime = os.time() + timeToRemoveFromList
            child.event = addEvent(removeFromTargetList, 5000, playerId, targetId)
        end
    end
    if not finded then
        table.insert(playerTargetedList[playerId], { targetId = targetId, removeTime = os.time() + timeToRemoveFromList, event = addEvent(removeFromTargetList, 5000, playerId, targetId) })
    end
end

function healthChangeDistanceFighter.onDamageChange(caster, target, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
													
	if primaryType == COMBAT_HEALING or primaryType == COMBAT_MANADRAIN or primaryType == COMBAT_LIFEDRAIN then
    return primaryDamage, primaryType, secondaryDamage, secondaryType
	end
	
	local casterObject = {dmg=math.abs(primaryDamage), target=target, attackers=1}
	local targetObject = {dmg=math.abs(primaryDamage), target=caster, attackers=1}

    local dmgRelatedTable = {
        ["Damage"] = caster, ----Damage caster as caster
        ["Provocation"] = caster, ----Provocated target as caster
        ["Absorb"] = target, ----Absorbing caster as target
        ["playerMark"] = target, ----targeter of marked as caster
        ["monsterMark"] = target ----Marked getting damage as target
    }
	--trueDmg
	--spellDmg
	--spellDef
    for i, child in pairs(dmgRelatedTable) do
        if child and child:getCustomAttribute(i) and primaryDamage ~= 0 then
            local getAttr = json.decode(child:getCustomAttribute(i))
            if (i ~= "Provocation") or i == "Provocation" and getAttr.casterId and getAttr.casterId > 1 and
                    Creature(getAttr.casterId) and target and Creature(getAttr.casterId) == target then
                local marks = {
                    ["playerMark"] = 100,
                    ["monsterMark"] = 420
                }
                local passed = true
                local stackMultiplier = 1
                for _i, _child in pairs(marks) do
                    if i == _i then
                        passed = false
                        if getAttr[tostring(caster:getId())] then
                            passed = true
                            getAttr = getAttr[tostring(caster:getId())]
                            stackMultiplier = getAttr.ammount
                        end
                    end

                end
                if passed then
                    if getAttr.condition and getAttr.condition.hitCounter then
                        getAttr.condition.hitCounter = getAttr.condition.hitCounter + 1
                        child:changeCustomAttribute(i, json.encode(getAttr))
                    end
                    if (getAttr.timer and getAttr.timer > os.time()) or
                            (getAttr.condition and getAttr.condition.hitCounter and getAttr.condition.hitCounter >=
                                    getAttr.condition.count) then
						if i == "playerMark" or i == "monsterMark" then
							casterObject.creatureStacks = stackMultiplier
							targetObject.creatureStacks = stackMultiplier
							casterObject.trueValueDmgBuff = (casterObject.trueValueDmgBuff or 0) + (((origin == ORIGIN_RANGED or origin == ORIGIN_MELEE) and getAttr.meleeValue) or
                                ((origin ~= ORIGIN_RANGED and origin ~= ORIGIN_MELEE) and getAttr.spellValue) or 0)
							casterObject.truePercentDmgBuff = (casterObject.truePercentDmgBuff or 0) + (((origin == ORIGIN_RANGED or origin == ORIGIN_MELEE) and getAttr.meleeValue) or
                                ((origin ~= ORIGIN_RANGED and origin ~= ORIGIN_MELEE) and getAttr.spellPercent) or 0)
						elseif i == "Provocation"  then
							casterObject.valueDmgBuff = (casterObject.valueDmgBuff or 0) + (((origin == ORIGIN_RANGED or origin == ORIGIN_MELEE) and getAttr.meleeValue) or
                                ((origin ~= ORIGIN_RANGED and origin ~= ORIGIN_MELEE) and getAttr.spellValue) or 0)
							casterObject.percentDmgBuff = (casterObject.percentDmgBuff or 0) + (((origin == ORIGIN_RANGED or origin == ORIGIN_MELEE) and getAttr.meleeValue) or
                                ((origin ~= ORIGIN_RANGED and origin ~= ORIGIN_MELEE) and getAttr.spellPercent) or 0)
						elseif i == "Damage"  then
							casterObject.valueDmgBuff = (casterObject.valueDmgBuff or 0) + (((origin == ORIGIN_RANGED or origin == ORIGIN_MELEE) and getAttr.meleeValue) or
                                ((origin ~= ORIGIN_RANGED and origin ~= ORIGIN_MELEE) and getAttr.spellValue) or 0)
							casterObject.percentDmgBuff = (casterObject.percentDmgBuff or 0) + (((origin == ORIGIN_RANGED or origin == ORIGIN_MELEE) and getAttr.meleeValue) or
                                ((origin ~= ORIGIN_RANGED and origin ~= ORIGIN_MELEE) and getAttr.spellPercent) or 0)
						elseif i == "Absorb"  then
							targetObject.valueDefBuff = (targetObject.valueDefBuff or 0) + (((origin == ORIGIN_RANGED or origin == ORIGIN_MELEE) and getAttr.meleeValue) or
                                ((origin ~= ORIGIN_RANGED and origin ~= ORIGIN_MELEE) and getAttr.spellValue) or 0)
							targetObject.percentDefBuff = (targetObject.percentDefBuff or 0) + (((origin == ORIGIN_RANGED or origin == ORIGIN_MELEE) and getAttr.meleeValue) or
                                ((origin ~= ORIGIN_RANGED and origin ~= ORIGIN_MELEE) and getAttr.spellPercent) or 0)
						end
                    end

                    if getAttr.condition and getAttr.condition.hitCounter then
                        getAttr.condition.hitCounter = 0
                    end
                    if getAttr.condition and getAttr.condition.repetitiveCounter then
                        getAttr.condition.repetitiveCounter = getAttr.condition.repetitiveCounter + 1
                        if getAttr.condition.repetitiveCounter >= getAttr.condition.repetitive then
                            child:removeCustomAttribute(getAttr.attr)
                        else
                            child:changeCustomAttribute(i, json.encode(getAttr))
                        end
                    end
                end
            end
        end
    end	
	
if origin == ORIGIN_MELEE or origin == ORIGIN_RANGED then
	if caster and caster:isPlayer() then
	if caster:getCustomAttribute("Silence") then
	local getAttr = json.decode(caster:getCustomAttribute("Silence"))
	if getAttr.timer and getAttr.timer > os.time() and getAttr.damage then
	primaryDamage = 0
	secondaryDamage = 0
	end
	end
       
	if caster:getCustomAttribute("Dash") then
	local getAttr = json.decode(caster:getCustomAttribute("Dash"))
                    if getAttr.condition and getAttr.condition.hitCounter then
                        getAttr.condition.hitCounter = getAttr.condition.hitCounter + 1
                        caster:changeCustomAttribute("Dash", json.encode(getAttr))
                    end
                    if (getAttr.condition and getAttr.condition.hitCounter and getAttr.condition.hitCounter >= getAttr.condition.count) then
        local passed = false
if getAttr.condition and getAttr.condition.origin then
for i,child in pairs(getAttr.condition.origin) do
			if child == origin then
			passed = true
end 
end
end
				
	   if passed then
	   local getPos = caster:getPosition()
				getPos:getNextPosition(caster:getDirection(),3)  
		if not hasObstacle(getPos, "solid") and not hasObstacle(getPos, "creature") then
					if Tile(getPos) and Tile(getPos):getCreatureCount() == 0 and not Tile(getPos):hasProperty(CONST_PROP_IMMOVABLEBLOCKSOLID) then
	if caster:getPathTo(getPos,0,50,true,true) then
if getAttr.condition.hitEffect then
    local spellEffect = (type(getAttr.condition.hitEffect) == "table" and getAttr.condition.hitEffect[caster:getDirection()+1]) or getAttr.condition.hitEffect
 Position(getPos):sendMagicEffect(spellEffect) 
end
				getAttr.condition.hitCounter = 0
				addEvent(function() caster:teleportTo(getPos,false,250) end,10)
						if not getAttr.condition.repetitiveCounter then getAttr.condition.repetitiveCounter = 0 end
                        getAttr.condition.repetitiveCounter = getAttr.condition.repetitiveCounter + 1
                        if getAttr.condition.repetitiveCounter >= getAttr.condition.repetitive then
                            caster:removeCustomAttribute(getAttr.attr)
                        else
                            caster:changeCustomAttribute("Dash", json.encode(getAttr))
                        end
						end
	   end
	   end
	   end
	   end
	   end

	if caster:getCustomAttribute("Jump") then
	local getAttr = json.decode(caster:getCustomAttribute("Jump"))
                    if getAttr.condition and getAttr.condition.hitCounter then
                        getAttr.condition.hitCounter = getAttr.condition.hitCounter + 1
                        caster:changeCustomAttribute("Jump", json.encode(getAttr))
                    end
                    if (getAttr.condition and getAttr.condition.hitCounter and getAttr.condition.hitCounter >= getAttr.condition.count) then
        local passed = false
if getAttr.condition and getAttr.condition.origin then
for i,child in pairs(getAttr.condition.origin) do
			if child == origin then
			passed = true
end 
end
end
				if passed then
					local backPos = target:getPosition()
					backPos:getNextPosition(0,1)
					local reverseTable = {[1]=backPos}
                local getArea = getAreaPos(target:getPosition(), {{1, 1, 1}, {1, 0, 1}, {1, 1, 1}}, target:getDirection())[1]
				for i = #getArea, 1, -1 do
				table.insert(reverseTable,getArea[i])
				end
				
				for i,child in pairs(reverseTable) do
				local jumpPos = child
					local tileToJump = Tile(jumpPos)
		if not hasObstacle(jumpPos, "solid") and not hasObstacle(jumpPos, "creature") then
					if tileToJump and tileToJump:getCreatureCount() == 0 and not tileToJump:hasProperty(CONST_PROP_IMMOVABLEBLOCKSOLID) then
	if caster:getPathTo(jumpPos,0,50,true,true) then
						
if getAttr.condition.hitEffect then
    local spellEffect = (type(getAttr.condition.hitEffect) == "table" and getAttr.condition.hitEffect[caster:getDirection()+1]) or getAttr.condition.hitEffect
 Position(jumpPos):sendMagicEffect(spellEffect) 
end
			addEvent(function() caster:teleportTo(jumpPos,false,250) end,10)
                        getAttr.condition.hitCounter = 0
						if not getAttr.condition.repetitiveCounter then getAttr.condition.repetitiveCounter = 0 end
                        getAttr.condition.repetitiveCounter = getAttr.condition.repetitiveCounter + 1
                        if getAttr.condition.repetitiveCounter >= getAttr.condition.repetitive then
                            caster:removeCustomAttribute(getAttr.attr)
                        else
                            caster:changeCustomAttribute("Jump", json.encode(getAttr))
                        end
						end
					end
				end
			end
end
end
      
end
          end
   end

	
        local calcC = spellcast_calculateFormula(caster, Wikipedia.Spells["All Passive"], casterObject)
        if origin == ORIGIN_RANGED or origin == ORIGIN_MELEE then
		
			local getOutfit = getGlobalAnimation("Based", caster)
			local getAnimation = getGlobalAnimation("Basic Attack", caster)
			if target and getOutfit and getAnimation and getOutfit.outfit.lookType == caster:getOutfit().lookType then
			local getAttr = {attr="creature_animation", condition={name="creatureAction",importance=99}, outfit="Basic Attack", animationDuration=getAnimation.animationDuration}
                        getAttr.timer = os.mtime() + getAnimation.animationDuration
                        getAttr.casterId = cid
						getAttr.castTime = os.mtime()
                        getAttr.targetPos = sendPos
						--getAttr.spellSV = spellT.spellSV
						--getAttr.spellName = spellT.spellName
				local getDirection = 0 
				if math.abs(caster:getPosition().x - target:getPosition().x) < math.abs(caster:getPosition().y - target:getPosition().y) then
					if caster:getPosition().y - target:getPosition().y < 0 then
						getDirection = 2 
					else 
						getDirection = 0 
					end
				else
					if caster:getPosition().x - target:getPosition().x < 0 then
						getDirection = 1
					else 
						getDirection = 3 
					end
				end
				
				addEvent(function() caster:setDirection(getDirection) end,300)		
				caster:changeCustomAttribute("creature_animation", json.encode(getAttr))
			end
			
            if calcC and calcC["Melee Damage"] then
                primaryDamage = calcC["Melee Damage"]
                secondaryDamage = calcC["Melee Damage Secondary"]
                secondaryType = COMBAT_HOLYDAMAGE
				if primaryDamage > 0 or secondaryDamage > 0 then
					target:getPosition():sendMagicEffect(75)
				end
            end
		else
            if calcC and calcC["Spell Damage"] then
                primaryDamage = calcC["Spell Damage"]
                secondaryDamage = calcC["Spell Damage Secondary"]
                secondaryType = COMBAT_HOLYDAMAGE
            end
        end
		
    if (target and target:isPlayer()) then
		targetObject.dmg=primaryDamage

        local calcT = spellcast_calculateFormula(target, Wikipedia.Spells["All Passive"], targetObject)
        if origin == ORIGIN_RANGED or origin == ORIGIN_MELEE then
            if calcT and calcT["Melee Defense"] then
                primaryDamage = calcT["Melee Defense"]
				if targetObject.dmg > 0 and primaryDamage < 1 then
					target:getPosition():sendMagicEffect(80)
				end
            end
		else
            if calcT and calcT["Spell Defense"] then
                primaryDamage = calcT["Spell Defense"]
				if targetObject.dmg > 0 and primaryDamage < 1 then
					target:getPosition():sendMagicEffect(80)
				end
            end
		end
			
    end
				
    return primaryDamage, primaryType, secondaryDamage, secondaryType
end

healthChangeDistanceFighter:register()

local healthChangeScript = CreatureEvent("spellsHealthChange")

function refreshHpConditions(creature)
	local eventList = {}
		local getAttr = creature:getCustomAttribute("customBuff") and json.decode(creature:getCustomAttribute("customBuff"))
		local currentHealth = math.floor(creature:getHealth()/creature:getMaxHealth())*100
		local updateAttribute = false
		if getAttr then
			for i,child in pairs(getAttr) do
				local collectedConditions = child.condition or {}
				for _i,_child in pairs(collectedConditions) do
					if _child.name == "health" and currentHealth >= _child.range[1] and currentHealth <= _child.range[2] then
						if not child.lastValue or child.lastValue ~= (_child.value*100) then
							getAttr[i].lastValue = _child.value*100
							updateAttribute = true
							creature:setCustomAttribute(child.customName, _child.value*100)
							--creature:changeCustomAttribute("customBuff", json.encode(getAttr))
						end
					end
				end
			end
		if updateAttribute then
			creature:setCustomAttribute("customBuff", json.encode(getAttr))
		end
	end
end
function healthChangeScript.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)

	if creature then
		refreshHpConditions(creature)
	end
    return primaryDamage, primaryType, secondaryDamage, secondaryType
end

healthChangeScript:register()


local creatureeventMove = CreatureEvent("spellsMove")
creatureeventMove:type("move")
function creatureeventMove.onMove(creature, fromPos, toPos, base, pathFinding)
    if fromPos == toPos or fromPos.x == 0 or fromPos.y == 0 or fromPos.z == 0 then
        return 0
    end
	if creature:isPlayer() and Tile(toPos) and Tile(toPos):getGround() and Tile(toPos):getGround():getActionId() == 2340 then 
		if not eventStepInCallback(creature, toPos, fromPos) then 
			return 1
		end
	end
	if creature:isPlayer() and Tile(toPos) and Tile(toPos):getGround() and Tile(toPos):getGround():getActionId() == 2341 then 
		if not eventStepOutCallback(creature, toPos, fromPos) then 
			return 1
		end
	end
    if creature:isMonster() and toPos.z ~= fromPos.z then
        return 1
    end
    if creature:isMonster() and Tile(toPos) and ((Tile(toPos):hasFlag(TILESTATE_PROTECTIONZONE)) or (Tile(toPos):hasFlag(TILESTATE_FLOORCHANGE)) or (Tile(toPos):hasFlag(TILESTATE_FLOORCHANGE_DOWN)) or (Tile(toPos):hasFlag(TILESTATE_TELEPORT)) or (Tile(toPos):hasFlag(TILESTATE_MAGICFIELD)) or (Tile(toPos):hasFlag(TILESTATE_BLOCKSOLID)) or (Tile(toPos):hasFlag(TILESTATE_IMMOVABLEBLOCKSOLID))) then
        return 1
    end

    if Tile(toPos) and Tile(toPos):hasFlag(TILESTATE_FLOORCHANGE) then
        if not Tile(toPos):hasFlag(TILESTATE_FLOORCHANGE_DOWN) then
            if Tile(toPos):hasFlag(TILESTATE_FLOORCHANGE_NORTH) then
                toPos = { x = toPos.x, y = toPos.y - 1, z = toPos.z - 1 }
            elseif Tile(toPos):hasFlag(TILESTATE_FLOORCHANGE_EAST) then
                toPos = { x = toPos.x + 1, y = toPos.y, z = toPos.z - 1 }
            elseif Tile(toPos):hasFlag(TILESTATE_FLOORCHANGE_SOUTH) then
                toPos = { x = toPos.x, y = toPos.y + 1, z = toPos.z - 1 }
            elseif Tile(toPos):hasFlag(TILESTATE_FLOORCHANGE_WEST) then
                toPos = { x = toPos.x - 1, y = toPos.y, z = toPos.z - 1 }
            end
        end

        if Tile(toPos):hasFlag(TILESTATE_FLOORCHANGE_DOWN) then
            toPos = { x = toPos.x, y = toPos.y - 1, z = toPos.z + 1 }
        elseif Tile(toPos):hasFlag(TILESTATE_FLOORCHANGE_EAST) then
            toPos = { x = toPos.x + 1, y = toPos.y, z = toPos.z + 1 }
        elseif Tile(toPos):hasFlag(TILESTATE_FLOORCHANGE_SOUTH) then
            toPos = { x = toPos.x, y = toPos.y + 1, z = toPos.z + 1 }
        elseif Tile(toPos):hasFlag(TILESTATE_FLOORCHANGE_WEST) then
            toPos = { x = toPos.x - 1, y = toPos.y, z = toPos.z + 1 }
        end

    end

   local delayedTime = 10
    if base == 0 and not pathFinding then
		local eventList = {}
		local getAttr = creature:getCustomAttribute("spawnArea") and json.decode(creature:getCustomAttribute("spawnArea"))
		if getAttr then
			if getAttr.condition[2] and getAttr.condition[2].repetition and getAttr.condition[2].repetition > 0 then
				--getAttr.condition[2].repetition = getAttr.condition[2].repetition - 1
				creature:changeCustomAttribute("spawnArea", json.encode(getAttr))
			elseif getAttr.condition[2] and getAttr.condition[2].repetition and getAttr.condition[2].repetition < 1 then
				creature:removeCustomAttribute("spawnArea")
			end
		end
  end
    return base
end
function sendSingleFunction(creatureId, desc)
    local getCreature = Creature(creatureId)
    if getCreature then
        getCreature:sendTextMessage(MESSAGE_EVENT_SYSTEM, desc)
    end
end
creatureeventMove:register()


local creatureInformationOpcode = CreatureEvent("creatureInformationOpcode")
function creatureInformationOpcode.onExtendedOpcode(player, opcode, buffer)
    if opcode == CREATURE_INFORMATION then
        local status, json_data = pcall(function()
            return json.decode(buffer)
        end)
        if not status then
            return false
        end
        local action = json_data['action']
        local data = json_data['data']
        if action == "getCreatureInformation" then
            if not data['uid'] then
                return true
            end
            local getCreature = Creature(data['uid']) or nil
            if getCreature then
				getCreature:sendAttributes(player)
            else
                json.sendJSON(player, CREATURE_INFORMATION, "sendIgnoreInformation", {
                    uid = data['uid']
                })
            end
		        elseif action == "mouseInteraction" then
		local getSpellAid = tonumber(data['aid'])
		local getSpellTime = tonumber(data['castTime'])
		for i,child in pairs(Wikipedia.Spells) do
		if child.spellSV == getSpellAid then
		if player:getCustomAttribute("spell_mouseInteraction") then
                local getTable = json.decode(player:getCustomAttribute("spell_mouseInteraction"))
            if getTable and getTable[tostring(player:getId())] then
	for getI,getAttr in pairs(getTable[tostring(player:getId())]) do
                if getAttr.timer and getAttr.timer >= os.time() and getAttr.spellSV == getSpellAid and getAttr.castTime == getSpellTime then
				spell_onSpawn(player:getId(), child, getAttr.areaSpawn, {
                    x = data['mousePosition'].x,
                    y = data['mousePosition'].y,
                    z = data['mousePosition'].z
                })
				
				
				
                end
    end
		
		end
		end
		end
		end
		
        elseif action == "mouseTracking" then
		local getSpellAid = tonumber(data['aid'])
		local getSpellTime = tonumber(data['castTime'])
		for i,child in pairs(Wikipedia.Spells) do
		if child.spellSV == getSpellAid then
		if player:getCustomAttribute("spell_mouseTracking") then
                local getTable = json.decode(player:getCustomAttribute("spell_mouseTracking"))
            if getTable and getTable[tostring(player:getId())] then
	for getI,getAttr in pairs(getTable[tostring(player:getId())]) do
                if getAttr.timer and getAttr.timer >= os.time() and getAttr.spellSV == getSpellAid and getAttr.castTime == getSpellTime then
				spell_onSpawn(player:getId(), child, getAttr.areaSpawn, {
                    x = data['mousePosition'].x,
                    y = data['mousePosition'].y,
                    z = data['mousePosition'].z
                })
				
				
                end
    end
		
		end
		end
		end
		end
		end
	


    end
end
creatureInformationOpcode:register()

local customRunes = Action()

function customRunes.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	for i,child in pairs(Wikipedia.Spells) do
		if child.itemId and child.itemId == item.itemid then
		    
			if child.requiredSquareCreature then
			    local tile = Tile(toPosition)
			    if tile then
			        local creatures = tile:getCreatures()
				    if not creatures or #creatures == 0 then
					        player:sendCancelMessage(RETURNVALUE_CANONLYUSETHISRUNEONCREATURES)
					        return true
					end
				end
			end
			
			if spellcast_castSpell(player, child.word, "Default", toPosition) then
				item:remove(1)
			end
		end
	end
	
	
	return true
end

customRunes:id(861)
customRunes:allowFarUse(true)
customRunes:register()


local customSpells = CreatureEvent("customSpells")
customSpells:type('login')
function customSpells.onLogin(player)
    player:registerEvent('creatureInformationOpcode')
	player:registerEvent("spellsHealthChange")
	player:registerEvent("healthChangeDistanceFighter")
	player:registerEvent("spellsMove")
    local getActualBar = 1
    if player:getStorageValue(80333) > 1 then
        getActualBar = player:getStorageValue(80333)
    end
    player:changeCustomAttribute("actualBar", json.encode(getActualBar))
	
    return true
end
customSpells:register()
