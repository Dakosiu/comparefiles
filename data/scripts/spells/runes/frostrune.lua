local frostcharm = Action()

local config = {
effect = 44,
distanceEffect = 29
}

local condition = Condition(CONDITION_OUTFIT)
condition:setParameter(CONDITION_PARAM_TICKS, 4000)
condition:setOutfit({lookTypeEx = 7303})

local function freezeTimer(creature,pos,count)
    if count >= 1 and Creature(creature) then
        local spectators = Game.getSpectators(pos, false, false, 13, 13, 7, 7)
        if #spectators > 0 then
            for _,spectator in pairs(spectators) do
                --local spectator = spectators[i]
                if spectator:isPlayer() then
                    spectator:sendTextMessage(MESSAGE_HEALED, nil, pos, count, TEXTCOLOR_ORANGE)
                end
            end
        end
        addEvent(freezeTimer, 1000, creature, pos, count - 1)
    end
end

local function unfreeze(cid)
    local player = Player(cid)
    if player then
    local pos = player:getPosition()
    pos:sendDistanceEffect(Position(pos.x+1, pos.y+1, pos.z), config.distanceEffect)
    pos:sendDistanceEffect(Position(pos.x+1, pos.y-1, pos.z), config.distanceEffect)
    pos:sendDistanceEffect(Position(pos.x-1, pos.y-1, pos.z), config.distanceEffect)
    pos:sendDistanceEffect(Position(pos.x-1, pos.y+1, pos.z), config.distanceEffect)
    player:say("UNFROZEN", TALKTYPE_MONSTER_SAY)
    pos:sendMagicEffect(config.effect)
    player:setMovementBlocked(false)
    end
end

function frostcharm.onUse(player, item, fromPosition, target, toPosition, isHotkey)
      if not target:isPlayer() then
        player:sendCancelMessage('You can just freeze players')
        player:getPosition():sendMagicEffect(3)
        return false
    end
    
    if player:getExhaustion(7212) <= 0 then
        player:setExhaustion(7212, 45)
    else
        player:sendCancelMessage('You\'re exhausted for: '..player:getExhaustion(7212)..' seconds.')
        return true
    end
    
    local pos = target:getPosition()
    Position(pos.x+1, pos.y+1, pos.z):sendDistanceEffect(pos, config.distanceEffect)
    Position(pos.x+1, pos.y-1, pos.z):sendDistanceEffect(pos, config.distanceEffect)
    Position(pos.x-1, pos.y-1, pos.z):sendDistanceEffect(pos, config.distanceEffect)
    Position(pos.x-1, pos.y+1, pos.z):sendDistanceEffect(pos, config.distanceEffect)
    target:addCondition(condition)
    pos:sendMagicEffect(config.effect)
    target:say("FROZEN", TALKTYPE_MONSTER_SAY)
    target:setMovementBlocked(true)
    addEvent(freezeTimer, 1000, target.uid, target:getPosition(), 3000 / 1000)
    addEvent(unfreeze, 4000, target.uid)
    return true
end

frostcharm:id(7289)
frostcharm:register()