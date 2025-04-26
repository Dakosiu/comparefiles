
informationStoreTable = {}
function getCreaturesTable()
return informationStoreTable
end
local ignoreStoreTable = {}
CREATURE_INFORMATION = 220
SPRITE_SIZE = 64
temporarySpellObject = {}
function init()
    connect(g_game, {
        onGameStart = creatureAppearStart
    })
    connect(Creature, {
        onHealthPercentChange = updateColorInformation,
        onAppear = creatureAppear,
        onProgressBarStart = toggleInteraction

    })
    connect(LocalPlayer, {
        onManaChange = updateColorInformation
    })

    ProtocolGame.registerExtendedOpcode(CREATURE_INFORMATION, onCreatureJSONOpcode)
end

local lastTimeSended
local sendingCooldown = 1
function sendAction(opcode, action, data)
    local protocolGame = g_game.getProtocolGame()
    if data == nil then
        data = {}
    end

    if protocolGame then
        protocolGame:sendExtendedOpcode(opcode, json.encode({
            action = action,
            data = data
        }))
    end
end

function onCreatureJSONOpcode(protocol, code, json_data_convert)
    local json_data = json.decode(json_data_convert)
    local action = json_data['action']
    local data = json_data['data']
    if not action or not data then
        return false
    end

    if action == 'sendCreatureInformation' then
		local player = g_map.getCreatureById(tonumber(data['uid']))
		if player then
				local getData = {}
				if informationStoreTable[data['uid']] then
				getData = informationStoreTable[data['uid']]
				end
				local changedAttr = {}
				for k,v in pairs(data) do 
				changedAttr[tostring(k)] = true
				getData[k] = v 
				end
                    informationStoreTable[data['uid']] = getData
                    informationStoreTable[data['uid']].lastUpdate = os.time() + sendingCooldown
                   -- player:clearTopWidgets()
                    updateColorInformation(player,changedAttr)
         end
    elseif action == 'sendIgnoreInformation' then
        ignoreStoreTable[data['uid']] = {}
    end
end

function returnCharacterInfo(creatureId)
--print(creatureId)
if g_game.getLocalPlayer() then
--print("local ".. g_game.getLocalPlayer():getId())
end
	local getInfo = informationStoreTable[creatureId]
	if getInfo then
		--printTable(getInfo," ")
	else
        sendAction(CREATURE_INFORMATION,"getCreatureInformation", {
            uid = creatureId
        })
	end

return getInfo
end

scheduleKeeper = {}

function overlayUpdate(creature,updateAttr)
updateAttr = updateAttr or {}
    local localPlayer = g_game.getLocalPlayer()
    if creature and localPlayer then
        if informationStoreTable[creature:getId()] and localPlayer and type(updateAttr) == "table" then
            local child = informationStoreTable[creature:getId()]
			if not child then return true end
            if child.spell_mouseTracking and child.spell_mouseTracking[tostring(localPlayer:getId())] and updateAttr["spell_mouseTracking"] then
                    for _i, _child in pairs(Wikipedia.Spells) do
          for __i,__child in pairs(child.spell_mouseTracking[tostring(localPlayer:getId())]) do
                        if _child.spellSV == __child.spellSV and g_game.mtime() - __child.castTime < 750 then
                            spell_aoe(Wikipedia.Spells[_i],__child.castTime)
                        end
                    end
end

			end		

            if child.spell_mouseInteraction and child.spell_mouseInteraction[tostring(localPlayer:getId())] and updateAttr["spell_mouseInteraction"] then
                    for _i, _child in pairs(Wikipedia.Spells) do
          for __i,__child in pairs(child.spell_mouseInteraction[tostring(localPlayer:getId())]) do
                        if _child.spellSV == __child.spellSV and (g_game.mtime() - __child.castTime) < 750 then
                            spell_aoe(Wikipedia.Spells[_i],__child.castTime)
                        end
                    end
end

			end		

            if child.spell_indicator and child.spell_indicator[tostring(localPlayer:getId())] and updateAttr["spell_indicator"] then
                    for _i, _child in pairs(Wikipedia.Spells) do
          for __i,__child in pairs(child.spell_indicator[tostring(localPlayer:getId())]) do
                        if _child.spellSV == __child.spellSV and g_game.mtime() - __child.castTime < 750 then
                            spell_aoe(Wikipedia.Spells[_i],__child.castTime)
                        end
                    end
end

			end		
	
	  end
    end
end
local overlayEvent = {}
function updateColorInformation(creature,updateAttr)
    overlayEvent[creature:getId()] = scheduleEvent(function()
        overlayUpdate(creature,updateAttr)
    end, 10)
end
indicatorsTable = {}
function spell_aoe(spellT,castTime)
    local localPlayer = g_game.getLocalPlayer()
    if not localPlayer then
        return
    end
    local getCopy = deepCopy(spellT)
    local calcT = spellcast_calculateFormula(localPlayer, getCopy)
    local playerPos = localPlayer:getPosition()
    local explosionPosT = getAreaPosCustom(playerPos, getCopy, localPlayer:getDirection())
	
	local getFirst = false
	local getLast = false
    for i, posT in pairs(explosionPosT) do
        for _, pos in pairs(posT) do
            local getCast = pos.cast or "adapt"
            local getDmg = 0
            if calcT and calcT[pos.dmg] then
                getDmg = calcT[pos.dmg]
            end
            if not indicatorsTable[castTime.."/"..localPlayer:getId() .. "/" .. math.floor(((i - 1) * 100) / 1000)] then
                indicatorsTable[castTime.."/"..localPlayer:getId() .. "/" .. math.floor(((i - 1) * 100) / 1000)] = scheduleEvent(
                    function()
                local getCreatureType = g_things.getThingType(localPlayer:getOutfit().type, ThingCategoryCreature)
				for _i,_child in pairs(pos.attr) do
						if spellT.bonusAttributes[_child] and spellT.bonusAttributes[_child].attr and spellT.bonusAttributes[_child].attr == "spell_indicator" and pos.timeZones[1] == i then
					createIndicator(i,spellT,castTime, playerPos, explosionPosT,getCreatureType:getDisplacementX(),getCreatureType:getDisplacementY(),spellT.spellSV)
					end
						if spellT.bonusAttributes[_child] and spellT.bonusAttributes[_child].attr and spellT.bonusAttributes[_child].attr == "spell_mouseInteraction" and pos.timeZones[1] == i then
					createIndicator(i,spellT,castTime, playerPos, explosionPosT,getCreatureType:getDisplacementX(),getCreatureType:getDisplacementY(),spellT.spellSV,#explosionPosT)
					end
						if spellT.bonusAttributes[_child] and spellT.bonusAttributes[_child].attr and spellT.bonusAttributes[_child].attr == "spell_mouseTracking" and pos.timeZones[1] == i then
					        createIndicator(i,spellT,castTime, playerPos, explosionPosT,getCreatureType:getDisplacementX(),getCreatureType:getDisplacementY(),spellT.spellSV,#explosionPosT,spellT.bonusAttributes[_child].limitUse or 99)
					        temporarySpellObject[spellT.spellSV..'/'..castTime] = {limitUse = spellT.bonusAttributes[_child].limitUse or 99, used=0}
						    if spellT.bonusAttributes[_child].autoCast then
						        temporarySpellObject[spellT.spellSV..'/'..castTime].autoCast = spellT.bonusAttributes[_child].autoCast
						    end
					    end
					
				end
                    end, math.floor(((i - 1) * 100) / 1000) * 1000)
            end
            scheduleEvent(function()
	      dealDamagePos(i, spellT, pos, playerPos, explosionPosT,castTime)
            end, (i - 1) * 100)
        end
    end
end
indicatorHolder = {}

function getActiveInteractions(findText,onlyRemove)
local allInteractions = {}
for i,child in pairs(indicatorHolder) do
local getBase = tostring(i)
if string.find(getBase,findText) then
if not onlyRemove then
table.insert(allInteractions,tostring(i))
end
indicatorHolder[i].widget:destroy()
indicatorHolder[i] = nil
end
end
return allInteractions
end
function getSpellObject(key)
	return temporarySpellObject[key]
end

function createIndicator(timePassed,spellT,castTime, adaptPos, mainTable,eX,eY,spellSV,interaction,tracking)
    local cid = g_game.getLocalPlayer()
    if not cid then
        return
    end
    removeEvent(indicatorsTable[castTime.."/"..cid:getId() .. "/" .. math.floor(((timePassed - 1) * 100) / 1000)])
    indicatorsTable[castTime.."/"..cid:getId() .. "/" .. math.floor(((timePassed - 1) * 100) / 1000)] = nil
	local counter = 0
	local lastIndex = 0
    for i, posT in pairs(mainTable) do
	lastIndex = i
        for _, poz in pairs(posT) do
            if i >= timePassed and poz.timeZones[1] == i and poz.timeZones[1] ~= interaction then
                local xDiff = (adaptPos.x - poz.x) * -1
                local yDiff = (adaptPos.y - poz.y) * -1
                local zDiff = adaptPos.z - poz.z
				if poz.x == cid:getPosition().x and poz.y == cid:getPosition().y and poz.z == cid:getPosition().z then
				goto continue
				end
				local getTable = informationStoreTable[cid:getId()]
				if not getTable then goto continue end
				
               -- if interaction and tracking and informationStoreTable[cid:getId()].spell_mouseTracking and informationStoreTable[cid:getId()].spell_mouseTracking.indicator and informationStoreTable[cid:getId()].spell_mouseTracking.indicator[interaction..'/'.. poz.x .. '/' .. poz.y .. '/' .. poz.z] then goto continue end
              --  if interaction and informationStoreTable[cid:getId()].spell_mouseInteraction and informationStoreTable[cid:getId()].spell_mouseInteraction.indicator  and informationStoreTable[cid:getId()].spell_mouseInteraction.indicator[interaction..'/'.. poz.x .. '/' .. poz.y .. '/' .. poz.z] then goto continue end
				
				if not poz.attr then poz.attr = {} end
				if interaction then
				if tracking then
				local passed = false
								for _i,_child in pairs(poz.attr) do
						if spellT.bonusAttributes[_child] and spellT.bonusAttributes[_child].attr and spellT.bonusAttributes[_child].attr == "spell_mouseTracking" and poz.timeZones[1] == i then
			passed = true
			end
			end
			if not passed then 
			baseIndicator:destroy()
			goto continue
			end
				if getTable.spell_mouseTracking then
          for __i,__child in pairs(getTable.spell_mouseTracking[tostring(cid:getId())]) do
                        if spellSV == __child.spellSV and __child.castTime == castTime  then
						
                local baseIndicator = g_ui.createWidget('Panel')
                baseIndicator:setHeight(SPRITE_SIZE + ((math.abs(yDiff * SPRITE_SIZE) * 2 * 2)))
                baseIndicator:setWidth(SPRITE_SIZE + ((math.abs(xDiff * SPRITE_SIZE) * 2 * 2)))
             -- baseIndicator:setAutoRotation(false)
                local label = g_ui.createWidget('Label', baseIndicator)
                label:addAnchor(AnchorHorizontalCenter, 'parent', AnchorHorizontalCenter)
                label:addAnchor(AnchorVerticalCenter, 'parent', AnchorVerticalCenter)
                label:setHeight(SPRITE_SIZE)
                label:setWidth(SPRITE_SIZE)
              -- label:setAutoRotation(false)
                label:setMarginLeft((xDiff * SPRITE_SIZE)+eX)
                label:setMarginTop((yDiff * SPRITE_SIZE)+eY)
                label:setOpacity(0.2)
				baseIndicator.aid = spellSV
				baseIndicator.castPosition = cid:getPosition()
				counter = counter + 1
				baseIndicator.aid = spellSV
				baseIndicator:setId("baseIndicator_"..counter)
				label:setId("labeloz"..counter)
				label:setId("spell_mouseTracking_"..counter)
				
				label:setId("spell_mouseTracking_"..counter)
                label:setBackgroundColor("green")
                indicatorHolder[__child.spellSV..'/'..castTime..'/'.. poz.x .. '/' .. poz.y .. '/' .. poz.z] = { widget = baseIndicator, limitUse = tracking, used=0}
                cid:addBottomWidget(baseIndicator)
end
end
end
					else
					
				local passed = false
								for _i,_child in pairs(poz.attr) do
						if spellT.bonusAttributes[_child] and spellT.bonusAttributes[_child].attr and spellT.bonusAttributes[_child].attr == "spell_mouseInteraction" and poz.timeZones[1] == i then
			passed = true
			end
			end
			if not passed then 
			baseIndicator:destroy()
			goto continue
			end
				if getTable.spell_mouseInteraction then
          for __i,__child in pairs(getTable.spell_mouseInteraction[tostring(cid:getId())]) do
                        if spellSV == __child.spellSV and __child.castTime == castTime  then
						
                local baseIndicator = g_ui.createWidget('Panel')
                baseIndicator:setHeight(SPRITE_SIZE + ((math.abs(yDiff * SPRITE_SIZE) * 2 * 2)))
                baseIndicator:setWidth(SPRITE_SIZE + ((math.abs(xDiff * SPRITE_SIZE) * 2 * 2)))
             --  baseIndicator:setAutoRotation(false)
                local label = g_ui.createWidget('Label', baseIndicator)
                label:addAnchor(AnchorHorizontalCenter, 'parent', AnchorHorizontalCenter)
                label:addAnchor(AnchorVerticalCenter, 'parent', AnchorVerticalCenter)
                label:setHeight(SPRITE_SIZE)
                label:setWidth(SPRITE_SIZE)
              -- label:setAutoRotation(false)
                label:setMarginLeft((xDiff * SPRITE_SIZE)+eX)
                label:setMarginTop((yDiff * SPRITE_SIZE)+eY)
                label:setOpacity(0.2)
				baseIndicator.aid = spellSV
				baseIndicator.castPosition = cid:getPosition()
				counter = counter + 1
				baseIndicator.aid = spellSV
				baseIndicator:setId("baseIndicator_"..counter)
				label:setId("labeloz"..counter)
				label:setId("spell_mouseTracking_"..counter)
				
				label:setId("spell_mouseInteraction_"..counter)
                label:setBackgroundColor("blue")
                indicatorHolder[__child.spellSV..'/'..castTime..'/'.. poz.x .. '/' .. poz.y .. '/' .. poz.z] = { widget = baseIndicator }
                cid:addBottomWidget(baseIndicator)
end
end
end
           
					end
				else
				if getTable.spell_indicator then
				local passed = false
								for _i,_child in pairs(poz.attr) do
						if spellT.bonusAttributes[_child] and spellT.bonusAttributes[_child].attr and spellT.bonusAttributes[_child].attr == "spell_indicator" and poz.timeZones[1] == i then
			passed = true
			end
			end
			if not passed then 
			baseIndicator:destroy()
			goto continue
			end
          for __i,__child in pairs(getTable.spell_indicator[tostring(cid:getId())]) do
                        if spellSV == __child.spellSV and __child.castTime == castTime  then
						
                local baseIndicator = g_ui.createWidget('Panel')
                baseIndicator:setHeight(SPRITE_SIZE + ((math.abs(yDiff * SPRITE_SIZE) * 2 * 2)))
                baseIndicator:setWidth(SPRITE_SIZE + ((math.abs(xDiff * SPRITE_SIZE) * 2 * 2)))
             --  baseIndicator:setAutoRotation(false)
                local label = g_ui.createWidget('Label', baseIndicator)
                label:addAnchor(AnchorHorizontalCenter, 'parent', AnchorHorizontalCenter)
                label:addAnchor(AnchorVerticalCenter, 'parent', AnchorVerticalCenter)
                label:setHeight(SPRITE_SIZE)
                label:setWidth(SPRITE_SIZE)
              -- label:setAutoRotation(false)
                label:setMarginLeft((xDiff * SPRITE_SIZE)+eX)
                label:setMarginTop((yDiff * SPRITE_SIZE)+eY)
                label:setOpacity(0.2)
				baseIndicator.aid = spellSV
				baseIndicator.castPosition = cid:getPosition()
				counter = counter + 1
				baseIndicator.aid = spellSV
				baseIndicator:setId("baseIndicator_"..counter)
				label:setId("labeloz"..counter)
				label:setId("spell_mouseTracking_"..counter)
				
				label:setId("spell_indicator_"..counter)
                label:setBackgroundColor("red")
                indicatorHolder[__child.spellSV..'/'..castTime..'/'.. poz.x .. '/' .. poz.y .. '/' .. poz.z] = { widget = baseIndicator }
                cid:addBottomWidget(baseIndicator)
end
end
  end         
				end
       
		end
    
  ::continue::
    end
    end

end

function dealDamagePos(timePassed, spellT, pos, adaptPos, mainTable,castTime)
    local cid = g_game.getLocalPlayer()
    if not cid then
        return
    end
    local conditionAdd = pos.attributes or {}
    local conditionAdd = pos.attributes or {}
    local ignoreList = pos.ignoreList or {}
    local damage = dmgTable or 0
    local sendPos = {
        x = pos.x,
        y = pos.y,
        z = pos.z
    }
	local adaptCreature = cid
    if adaptPos and adaptCreature then
        local xDiff = adaptPos.x - pos.x
        local yDiff = adaptPos.y - pos.y
        local zDiff = adaptPos.z - pos.z
        local actualPos = adaptCreature:getPosition()
        local forceDirection = forceDirection or adaptCreature:getDirection()
        if (adaptDirection == forceDirection) then
            sendPos.x = actualPos.x + (-1 * xDiff)
            sendPos.y = actualPos.y + (-1 * yDiff)
        elseif ((adaptDirection == 0 and forceDirection == 2) or (adaptDirection == 2 and forceDirection == 0) or
            (adaptDirection == 1 and forceDirection == 3) or (adaptDirection == 3 and forceDirection == 1)) then
            sendPos.x = actualPos.x + xDiff
            sendPos.y = actualPos.y + yDiff
        elseif ((adaptDirection == 0 and forceDirection == 1) or (adaptDirection == 1 and forceDirection == 2) or
            (adaptDirection == 2 and forceDirection == 3) or (adaptDirection == 3 and forceDirection == 0)) then
            sendPos.x = actualPos.x + yDiff
            sendPos.y = actualPos.y + (-1 * xDiff)
        elseif ((adaptDirection == 0 and forceDirection == 3) or (adaptDirection == 1 and forceDirection == 0) or
            (adaptDirection == 2 and forceDirection == 1) or (adaptDirection == 3 and forceDirection == 2)) then
            sendPos.x = actualPos.x + (-1 * yDiff)
            sendPos.y = actualPos.y + xDiff
        end
        sendPos.z = actualPos.z + zDiff
    end
	    local child = informationStoreTable[cid:getId()]
if timePassed == pos.timeZones[2] then	
     if child and child.spell_mouseTracking then
          for __i,__child in pairs(informationStoreTable[cid:getId()].spell_mouseTracking[tostring(cid:getId())]) do
                        if spellT.spellSV == __child.spellSV and __child.castTime == castTime  then
						local getText = tostring(__child.spellSV..'/'..castTime)
					for ebe,ibi in pairs(getActiveInteractions(getText,true)) do
					break
					end
		end
    end
 end
     if child and child.spell_mouseInteraction then
          for __i,__child in pairs(informationStoreTable[cid:getId()].spell_mouseInteraction[tostring(cid:getId())]) do
                        if spellT.spellSV == __child.spellSV and __child.castTime == castTime  then
						local getText = tostring(__child.spellSV..'/'..castTime)
					local getRemoved = getActiveInteractions(getText)
					if #getRemoved > 0 then
					break
					end
		end
    end
 end
     if child and child.spell_indicator then
          for __i,__child in pairs(informationStoreTable[cid:getId()].spell_indicator[tostring(cid:getId())]) do
                        if spellT.spellSV == __child.spellSV and __child.castTime == castTime  then
						local getText = tostring(__child.spellSV..'/'..castTime)
					for ebe,ibi in pairs(getActiveInteractions(getText,true)) do
					break
					end
		end
    end
 end

		end
    local tile = g_map.getTile(sendPos)
    if not tile then
        return
    end
   local creature = tile:getTopCreature()
    if (not creature) then
        -- doSendMagicEffect(sendPos, effectOnMiss)
        return false
    end
	
   -- for i, child in pairs(ignoreList) do
  --      if child == "caster" then
    --        if creature:getId() == cid then
     --           return false
   --         end
   --     end
  --  end
	
	if 1 > 0 then
                return true
				end
				
    if conditionAdd then
        for i, child in pairs(conditionAdd) do
            local passed = true
            if creature:getCustomAttribute(child.attr) then
                local getAttr = json.decode(creature:getCustomAttribute(child.attr))
                if getAttr.immuneTimer and getAttr.immuneTimer > g_game.mtime() then
                    passed = false
                end
            end
            if passed then
                local getAttr = deepCopy(child)
                if getAttr.condition then
                    local getCondition = getAttr.condition
                    if getCondition.name == "timeDuration" then
                        getAttr.timer = g_game.mtime() + getCondition.duration
                        if getCondition.immune then
                            getAttr.immuneTimer = g_game.mtime() + getCondition.immune
                        end
                    elseif getCondition.name == "onHit" then
                        getCondition.hitCounter = 0
                        getCondition.repetitiveCounter = 0
                    end
                    getAttr.casterId = cid
                    getAttr.targetId = creature:getId()
                    getAttr.spellSV = spellT.spellSV
                    local marks = {"playerMark", "monsterMark"}
                    creature:changeCustomAttribute(getAttr.attr, json.encode(getAttr))
                end
            end
        end
    end

    origin = origin or O_environment
    if origin == O_monster_spells and creature:isMonster() then
        return
    end

    if not noMoreDMG(cid, creature, origin) then
        if not effectOnHit then
            effectOnHit = 0
        end
        return doTargetCombatHealth(cid, creature:getId(), damType, -damage, -damage, effectOnHit, origin)
    end
end

function creatureAppearStart()
	scheduleEvent(function()
		creatureAppear(g_game.getLocalPlayer())
	end,500)
end

function creatureAppear(creature)
    local getId = creature:getId()
    if informationStoreTable[getId] then
        if informationStoreTable[getId].lastUpdate then
            if informationStoreTable[getId].lastUpdate > os.time() then
                updateColorInformation(creature)
                return true
            end
        end
    end
    if getId > 0 then
        sendAction(CREATURE_INFORMATION, "getCreatureInformation", {
            uid = getId
        })
    end
end

function terminate()
    disconnect(Creature, {
        onHealthPercentChange = updateColorInformation,
        onAppear = creatureAppear,
        onProgressBarStart = toggleInteraction
    })
    disconnect(LocalPlayer, {
        onManaChange = updateColorInformation
    })
    ProtocolGame.unregisterExtendedOpcode(CREATURE_INFORMATION, onCreatureJSONOpcode)
end
