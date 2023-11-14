local skills = {
    [31196] = {id=SKILL_SWORD,voc=4}, -- KNIGHT
    [31197] = {id=SKILL_AXE,voc=4}, -- KNIGHT
    [31198] = {id=SKILL_CLUB,voc=4}, -- KNIGHT
    [31199] = {id=SKILL_DISTANCE,voc=3,range=CONST_ANI_SIMPLEARROW}, -- PALADIN
    [31200] = {id=SKILL_MAGLEVEL,voc=2,range=CONST_ANI_SMALLICE}, -- DRUID
    [31201] = {id=SKILL_MAGLEVEL,voc=1,range=CONST_ANI_FIRE}, -- SORCERER
    [31208] = {id=SKILL_SWORD,voc=4}, -- KNIGHT
    [31209] = {id=SKILL_AXE,voc=4}, -- KNIGHT
    [31210] = {id=SKILL_CLUB,voc=4}, -- KNIGHT
    [31211] = {id=SKILL_DISTANCE,voc=3,range=CONST_ANI_SIMPLEARROW}, -- PALADIN
    [31212] = {id=SKILL_MAGLEVEL,voc=2,range=CONST_ANI_SMALLICE}, -- DRUID
    [31213] = {id=SKILL_MAGLEVEL,voc=1,range=CONST_ANI_FIRE}, -- SORCERER
    [37935] = {id=SKILL_SWORD,voc=4}, -- KNIGHT
    [37936] = {id=SKILL_AXE,voc=4}, -- KNIGHT
    [37937] = {id=SKILL_CLUB,voc=4}, -- KNIGHT
    [37938] = {id=SKILL_DISTANCE,voc=3,range=CONST_ANI_SIMPLEARROW}, -- PALADIN
    [37939] = {id=SKILL_MAGLEVEL,voc=2,range=CONST_ANI_SMALLICE}, -- DRUID
    [37940] = {id=SKILL_MAGLEVEL,voc=1,range=CONST_ANI_FIRE}, -- SORCERER
    [37941] = {id=SKILL_SWORD,voc=4}, -- KNIGHT
    [37942] = {id=SKILL_AXE,voc=4}, -- KNIGHT
    [37943] = {id=SKILL_CLUB,voc=4}, -- KNIGHT
    [37944] = {id=SKILL_DISTANCE,voc=3,range=CONST_ANI_SIMPLEARROW}, -- PALADIN
    [37945] = {id=SKILL_MAGLEVEL,voc=2,range=CONST_ANI_SMALLICE}, -- DRUID
    [37946] = {id=SKILL_MAGLEVEL,voc=1,range=CONST_ANI_FIRE} -- SORCERER
}

local houseDummies = {31215, 31216, 31217, 31218, 31219, 31220}
local freeDummies = {31214, 31221}
local skillRateDefault = configManager.getNumber(configKeys.RATE_SKILL)
local magicRateDefault = configManager.getNumber(configKeys.RATE_MAGIC)

local function removeExerciseWeapon(player, exercise)
    exercise:remove(1)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your training weapon vanished.")
    stopEvent(training)
    player:setStorageValue(30000,0)
    local hola = player:getStorageValue(30000)
    print(hola)
    player:setTraining(true)
end

local function startTraining(playerId, startPosition, itemid, tilePosition, bonusDummy, dummyId)
    local player = Player(playerId)
    if player ~= nil then
        if Tile(tilePosition):getItemById(dummyId) then
            local playerPosition = player:getPosition()
            if startPosition:getDistance(playerPosition) == 0 and getTilePzInfo(playerPosition) then
                if player:getItemCount(itemid) >= 1 then
                    local exercise = player:getItemById(itemid,true)
                    if exercise:isItem() then
                        if exercise:hasAttribute(ITEM_ATTRIBUTE_CHARGES) then
                            local charges_n = exercise:getAttribute(ITEM_ATTRIBUTE_CHARGES)
                            if charges_n >= 1 then
                                exercise:setAttribute(ITEM_ATTRIBUTE_CHARGES,(charges_n-1))

                                local voc = player:getVocation()

                                if skills[itemid].id == SKILL_MAGLEVEL then
                                    local magicRate = getRateFromTable(magicRateDefault)
                                    if not bonusDummy then
                                        player:addManaSpent(math.ceil(500*magicRate))
                                    else
                                        player:addManaSpent(math.ceil(500*magicRate)*1.1) -- 10%
                                    end
                                else
                                    local skillRate = getRateFromTable(skillRateDefault)
                                    if not bonusDummy then
                                        player:addSkillTries(skills[itemid].id, 7*skillRate)
                                    else
                                        player:addSkillTries(skills[itemid].id, (7*skillRate)*1.1) -- 10%
                                    end
                                end
                                    tilePosition:sendMagicEffect(CONST_ME_HITAREA)
                                if skills[itemid].range then
                                    playerPosition:sendDistanceEffect(tilePosition, skills[itemid].range)
                                end
                                if exercise:getAttribute(ITEM_ATTRIBUTE_CHARGES) == 0 then
                                    removeExerciseWeapon(player, exercise)
                                else
                                    local training = addEvent(startTraining, voc:getAttackSpeed(), playerId,startPosition,itemid,tilePosition,bonusDummy,dummyId)
                                    player:setStorageValue(30000,1)
                                    player:setTraining(true)
                                end
                            else
                                removeExerciseWeapon(player, exercise)
                            end
                        end
                    end
                end
            else
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your training has stopped.")
                stopEvent(training)
                player:setStorageValue(30000,0)
                player:setTraining(false)
            end
        else
            stopEvent(training)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your training has stopped.")
            player:setStorageValue(30000, 0)
            player:setTraining(false)
        end
    else
        stopEvent(training)
        if player then
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your training has stopped.")
            player:setStorageValue(30000,0)
            player:setTraining(false)
        end
    end
    return true
end

local exerciseTraining = Action()

function exerciseTraining.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local startPos = player:getPosition()
    if player:getStorageValue(30000) == 1 then
        player:sendTextMessage(MESSAGE_FAILURE, "You are already training.")
        return false
    end
    if target:isItem() then
        if isInArray(houseDummies,target:getId()) then
            if not skills[item.itemid].range and (startPos:getDistance(target:getPosition()) > 1) then
                player:sendTextMessage(MESSAGE_FAILURE, "Get closer to the dummy.")
                stopEvent(training)
                return true
            end
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You started training.")
            startTraining(player:getId(),startPos,item.itemid,target:getPosition(), false, target:getId())
        elseif isInArray(freeDummies, target:getId()) then
            if not skills[item.itemid].range and (startPos:getDistance(target:getPosition()) > 1) then
                player:sendTextMessage(MESSAGE_FAILURE, "Get closer to the dummy.")
                stopEvent(training)
                return true
            end
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You started training.")
            startTraining(player:getId(),startPos,item.itemid,target:getPosition(), false, target:getId())
        end
    end
    return true
end

for id = 31196, 31198 do
    exerciseTraining:id(id)
end

for id = 31199, 31201 do
    exerciseTraining:id(id)
    exerciseTraining:allowFarUse(true)
end

for id = 31208, 31210 do
    exerciseTraining:id(id)
end

for id = 31211, 31213 do
    exerciseTraining:id(id)
    exerciseTraining:allowFarUse(true)
end

for id = 37935, 37937 do
    exerciseTraining:id(id)
end

for id = 37938, 37940 do
    exerciseTraining:id(id)
    exerciseTraining:allowFarUse(true)
end

for id = 37941, 37943 do
    exerciseTraining:id(id)
end

for id = 37945, 37946 do
    exerciseTraining:id(id)
    exerciseTraining:allowFarUse(true)
end

exerciseTraining:register()