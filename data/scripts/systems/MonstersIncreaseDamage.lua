local creatureevent = CreatureEvent("MonsterLevelSystem_onHealthChange")
function creatureevent.onHealthChange(creature, attacker, primaryDamage,
                                      primaryType, secondaryDamage,
                                      secondaryType, origin)

    if not attacker then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end

    local monster = Monster(attacker)
    if not monster then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end

    local master = monster:getMaster()
        if monster and master and master:isPlayer() then
            local masterLevel = master:getLevel()
            local increase = masterLevel
            local value = increase * 3
            primaryDamage = primaryDamage + primaryDamage + value
            return primaryDamage, primaryType, secondaryDamage, secondaryType
        end

    local increaseRatio = getConfigInfo("rateMonsterAttack")
    if increaseRatio then
        if increaseRatio < 1 then
            primaryDamage = primaryDamage + primaryDamage * increaseRatio
        else
            primaryDamage = primaryDamage * increaseRatio
        end
    end

    local increaseRatioLevel = getConfigInfo("levelMonsterBonusAttack")
    if increaseRatioLevel then
        local level = monster:getMonsterLevel()
        local value = monster:getMonsterLevel() * increaseRatioLevel
        if increaseRatioLevel < 1 then
            primaryDamage = primaryDamage + primaryDamage * value
        else
            primaryDamage = primaryDamage * value
        end
    end

    return primaryDamage, primaryType, secondaryDamage, secondaryType
end
creatureevent:register()

creatureevent = CreatureEvent("MonsterLevelSystem_onManaChange")
function creatureevent.onManaChange(creature, attacker, primaryDamage,
                                    primaryType, secondaryDamage, secondaryType,
                                    origin)

    if not attacker then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end

    local monster = Monster(attacker)
    if not monster then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end
    
    local master = monster:getMaster()
        if monster and master and master:isPlayer() then
            local masterLevel = master:getLevel()
            local increase = masterLevel
            local value = increase * 3
            primaryDamage = primaryDamage + primaryDamage + value
            return primaryDamage, primaryType, secondaryDamage, secondaryType
        end

    local increaseRatio = getConfigInfo("rateMonsterAttack")
    if increaseRatio then
        if increaseRatio < 1 then
            primaryDamage = primaryDamage + primaryDamage * increaseRatio
        else
            primaryDamage = primaryDamage * increaseRatio
        end
    end

    local increaseRatioLevel = getConfigInfo("levelMonsterBonusAttack")
    if increaseRatioLevel then
        local level = monster:getMonsterLevel()
        local value = monster:getMonsterLevel() * increaseRatioLevel
        if increaseRatioLevel < 1 then
            primaryDamage = primaryDamage + primaryDamage * value
        else
            primaryDamage = primaryDamage * value
        end
    end

    return primaryDamage, primaryType, secondaryDamage, secondaryType
end
creatureevent:register()

creatureevent = CreatureEvent("MonsterLevelSystem_onLogin")
function creatureevent.onLogin(player)
    player:registerEvent("MonsterLevelSystem_onHealthChange")
    player:registerEvent("MonsterLevelSystem_onManaChange")
    return true
end
creatureevent:register()
