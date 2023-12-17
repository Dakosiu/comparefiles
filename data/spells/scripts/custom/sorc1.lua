-- Minimum amount of magic missiles
local minMissiles = 2

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)

local function arcaneDamage(player, target, missileEffectpos, animationroll)
    local player = Player(player)
    local creature = Creature(target)
    if player and creature then
        local level = player:getLevel()
        local magiclevel = player:getMagicLevel()
        local min = (level * 20) + (magiclevel * 35) + 1000
        local max = (level * 25) + (magiclevel * 45) + 2000
        combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, 5, min, 10, max)
        Position(missileEffectpos):sendDistanceEffect(creature:getPosition(), 62)
        if animationroll == 1 then
            creature:getPosition():sendMagicEffect(222)
        end
        local damage = minMissiles * min
        creature:doCombat(player, combat, -1, -1, animationroll)
        return damage
    end

    return 0
end





local function arcaneBolt(player, var, target, count)
    local player = Player(player)
    local creature = Creature(target)
    if player and creature then
        local playerpos = player:getPosition()
        local creaturepos = creature:getPosition()
        local missileEffectpos = Position(playerpos)
        local differencey = playerpos.y - creaturepos.y -- positive = N, negative = S
        local differencex = playerpos.x - creaturepos.x -- positive = W, negative = E
        local ymodifier = 0
        local xmodifier = 0
        local animationroll = 0
        -- Cycle between each side of player depending if missile is even or odd
        if count % 2 == 0 then -- even
            if differencey > 0 then -- Target it to the N
                xmodifier = xmodifier + 1
                if math.random(1, 2) == 2 then
                    ymodifier = ymodifier - 1
                end
            elseif differencey < 0 then -- Target is to the S
                xmodifier = xmodifier - 1
                if differencey < -1 or math.random(1, 2) == 2 then -- Force if 1sqm away due to client perspective
                    ymodifier = ymodifier + 1
                end
            end
            if differencex < 0 then -- Target is to the E
                ymodifier = ymodifier + 1
                if differencex < -1 or math.random(1, 2) == 2 then -- Force if 1sqm away due to client perspective
                    xmodifier = xmodifier + 1
                end
            elseif differencex > 0 then -- Target is to the W
                ymodifier = ymodifier - 1
                if math.random(1, 2) == 2 then
                    xmodifier = xmodifier - 1
                end
            end
        else -- odd
            animationroll = 1
            if differencey > 0 then -- Target it to the N
                xmodifier = xmodifier - 1
                if math.random(1, 2) == 2 then
                    ymodifier = ymodifier - 1
                end
            elseif differencey < 0 then -- Target is to the S
                xmodifier = xmodifier + 1
                if differencey < -1 or math.random(1, 2) == 2 then -- Force if 1sqm away due to client perspective
                    ymodifier = ymodifier + 1
                end
            end
            if differencex < 0 then -- Target is to the E
                ymodifier = ymodifier - 1
                if differencex < -1 or math.random(1, 2) == 2 then -- Force if 1sqm away due to client perspective
                    xmodifier = xmodifier + 1
                end
            elseif differencex > 0 then -- Target is to the W
                ymodifier = ymodifier + 1
                if math.random(1, 2) == 2 then
                    xmodifier = xmodifier - 1
                end
            end
        end
        missileEffectpos.x = missileEffectpos.x + xmodifier
        missileEffectpos.y = missileEffectpos.y + ymodifier
        Position(playerpos):sendDistanceEffect(missileEffectpos,
                                               CONST_ANI_ENERGYBALL)
        addEvent(arcaneDamage, 1500, player.uid, var, creature.uid,
                 missileEffectpos, animationroll)
        -- addEvent(arcaneDamage, 150, player.uid, var, creature.uid, missileEffectpos, animationroll)
    end
    return true
end

function onCastSpell(player, var)
    -- function onCastSpell(player, var)
    local magiclevel = player:getMagicLevel()
    local target = player:getTarget()
    local missileCount = minMissiles + math.floor(magiclevel / 20) -- extra missile every 20 magic levels
    local count = 1
    if target then
        for i = 1, missileCount do
            addEvent(arcaneBolt, 1500 * (i - 1), player.uid, var, target.uid,
                     count)
            count = count + 1
        end
    else
        player:sendTextMessage(MESSAGE_STATUS_SMALL,
                               "You need to select a target.")

        return false
    end
    return true
end
