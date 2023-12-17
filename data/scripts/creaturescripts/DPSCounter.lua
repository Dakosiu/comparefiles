DPS_STORAGE = 50392
PLAYER_DPS = {}
PLAYER_EVENTS = {}

function ReadDPS(pid, cid)
    local player = Player(pid)
    local summon = Monster(cid)
    local target = Monster(cid)
    if player and target or summon and target then
        PLAYER_DPS[pid] = PLAYER_DPS[pid] * -1
        if summon then
            PLAYER_DPS[pid] = PLAYER_DPS[pid] * -1
            target:say(string.format("DPS: %d", PLAYER_DPS[pid]), TALKTYPE_MONSTER_SAY, false, player, target:getPosition())
            return true
        end
        if PLAYER_DPS[pid] > player:getStorageValue(DPS_STORAGE) then
            player:setStorageValue(DPS_STORAGE, PLAYER_DPS[pid])
            target:say(string.format("New Record! DPS: %d", PLAYER_DPS[pid]), TALKTYPE_MONSTER_SAY, false, player, target:getPosition())
        else
            target:say(string.format("DPS: %d", PLAYER_DPS[pid]), TALKTYPE_MONSTER_SAY, false, player, target:getPosition())
        end
        PLAYER_DPS[pid] = 0
        PLAYER_EVENTS[pid] = nil
    end
end

local DPSCounter = CreatureEvent("DPSCounter_onHealth")
function DPSCounter.onHealthChange(creature, attacker, primaryDamage,
                                   primaryType, secondaryDamage, secondaryType,
                                   origin)
    if not creature then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end
    if not attacker then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end
    if creature:isMonster() and attacker then
        if creature:getName() == "Training Dummy" then
            local damage = primaryDamage + secondaryDamage
            local pid = attacker:getId()
            if not attacker:isPlayer() then
                PLAYER_DPS[pid] = 0
                PLAYER_DPS[pid] = PLAYER_DPS[pid] + damage
                PLAYER_EVENTS[pid] = addEvent(ReadDPS, 1000, pid,
                creature:getId())
            end
            if not PLAYER_DPS[pid] then PLAYER_DPS[pid] = 0 end
            PLAYER_DPS[pid] = PLAYER_DPS[pid] + damage
            if not PLAYER_EVENTS[pid] then
                PLAYER_EVENTS[pid] = addEvent(ReadDPS, 1000, pid,
                                              creature:getId())
            end
        end
    end

    return primaryDamage, primaryType, secondaryDamage, secondaryType
end
DPSCounter:register()

local ec = EventCallback
function ec.onTargetCombat(creature, target)
    if target:getName() == "Training Dummy" then
        target:registerEvent("DPSCounter_onHealth")
    end
    return RETURNVALUE_NOERROR
end

ec:register(7)