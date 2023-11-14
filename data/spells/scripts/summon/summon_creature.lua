local summonConfig = {
    ["melee"] = {
        level = 22,
        mana = 6000,
        healthPercent = 15,
        manaPercent = 15,
    },
    ["strong melee"] = {
        level = 110,
        mana = 12000,
        healthPercent = 20,
        manaPercent = 20,
    },
    ["powerful melee"] = {
        level = 220,
        mana = 20000,
        healthPercent = 25,
        manaPercent = 25,
    },
    ["legendary melee"] = {
        level = 550,
        mana = 30000,
        healthPercent = 30,
        manaPercent = 30,
    },

    ["ranged"] = {
        level = 22,
        mana = 6000,
        healthPercent = 10,
        manaPercent = 10,
    },
    ["strong ranged"] = {
        level = 110,
        mana = 12000,
        healthPercent = 15,
        manaPercent = 15,
    },
    ["powerful ranged"] = {
        level = 220,
        mana = 20000,
        healthPercent = 20,
        manaPercent = 20,
    },
    ["legendary ranged"] = {
        level = 550,
        mana = 30000,
        healthPercent = 25,
        manaPercent = 25,
    },

    ["tank"] = {
        level = 22,
        mana = 6000,
        healthPercent = 20,
        manaPercent = 20,
    },
    ["strong tank"] = {
        level = 110,
        mana = 12000,
        healthPercent = 25,
        manaPercent = 25,
    },
    ["powerful tank"] = {
        level = 220,
        mana = 20000,
        healthPercent = 30,
        manaPercent = 30,
    },
    ["legendary tank"] = {
        level = 550,
        mana = 30000,
        healthPercent = 40,
        manaPercent = 40,
    },
}

function onCastSpell(creature, variant)
    if creature:getSkull() == SKULL_BLACK then
        creature:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
        return false
    end

    local monsterName = variant:getString():lower()
    local monsterType = MonsterType(monsterName)
    local summons = math.floor((creature:getLevel() / 140) + 1) -- Calculate the max Summons
    local level = creature:getLevel() -- Get player Level
    -- !CHECK IF MONSTER
    if not monsterType then
        creature:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
        creature:getPosition():sendMagicEffect(CONST_ME_POFF)
    end
    if summonConfig[monsterName] then
        if level >= 110 and level < 220 then
            monsterName = "strong " .. monsterName
        elseif level >= 220 and level < 550 then
            monsterName = "powerful " .. monsterName
        elseif level >= 550 then
            monsterName = "legendary " .. monsterName
        end
        if level >= summonConfig[monsterName].level and #creature:getSummons() <
            summons and creature:getMana() >= summonConfig[monsterName].mana then
            local position = creature:getPosition()
            local summon = Game.createMonsterLevel(monsterName, position, true,
                                                   false, creature:getLevel())
            creature:addMana(-summonConfig[monsterName].mana)
            creature:addSummon(summon)
            local a = summonConfig[monsterName]
            if summon then
                summon:registerEvent("followMaster")
                summon:setMaxHealth((creature:getMaxHealth() *
                                        (summonConfig[monsterName].healthPercent /
                                            100)) +
                                        (creature:getMaxHealth() *
                                            (summonConfig[monsterName]
                                                .manaPercent / 100)))
                summon:setHealth((creature:getMaxHealth() *
                                     (summonConfig[monsterName].healthPercent /
                                         100)) +
                                     (creature:getMaxHealth() *
                                         (summonConfig[monsterName].manaPercent /
                                             100)))
                summon:changeSpeed(2000)
            end
        elseif #creature:getSummons() >= summons then
            creature:say("I cant handle more summons at the moment")
        elseif level < summonConfig[monsterName].level then
            creature:say("This monster is too strong for me")
        elseif creature:getMana() < summonConfig[monsterName].mana then
            creature:say("I dont have enough mana to summon this monster")
            creature:sendCancelMessage(RETURNVALUE_NOTENOUGHMANA)
            creature:getPosition():sendMagicEffect(CONST_ME_POFF)
            --[[  elseif creature:getSoul() < summonConfig[monsterName].soul then
            creature:say("I dont have enough soul to spawn this monster") --]]
        elseif not summonConfig[monsterName] == monsterName and
            not monsterType:isSummonable() then
            creature:say("I cant summon this monster")
            creature:sendTextMessage(MESSAGE_STATUS_WARNING,
                                     "For now you have three summons: melee, ranged, tank")
            creature:getPosition():sendMagicEffect(CONST_ME_POFF)
            return false
        end
        return false
    end

    if monsterType then
        if not creature:hasFlag(PlayerFlag_CanSummonAll) then
            if not monsterType:isSummonable() then
                creature:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
                creature:getPosition():sendMagicEffect(CONST_ME_POFF)
                creature:say("I cant summon this monster")
                return false
            end
        end
    end

    -- !CHECK SUMMONS Y
    if #creature:getSummons() >= summons then
        creature:say("I cant handle more summons at the moment")
        creature:sendCancelMessage("You cannot summon more creatures.")
        creature:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end

    -- !CHECK MANA COST
    if monsterType then
        local manaCost = monsterType:getManaCost()
        if creature:getMana() < manaCost and
            not creature:hasFlag(PlayerFlag_HasInfiniteMana) then
            creature:say("I dont have enough mana to summon this monster")
            creature:sendCancelMessage(RETURNVALUE_NOTENOUGHMANA)
            creature:getPosition():sendMagicEffect(CONST_ME_POFF)
            return false
        end
    end

    -- !CHECK POSITION
    local position = creature:getPosition()
    -- !SUMMON
    local summon = Game.createMonsterLevel(monsterName, position, true, false,
                                           creature:getLevel())
    if not summon then
        creature:sendCancelMessage(
            "For now you have three summons: melee, ranged, tank")
        position:sendMagicEffect(CONST_ME_POFF)
        return false
    end
    if manaCost then
        creature:addMana(-manaCost)
        creature:addManaSpent(manaCost)
    end
    creature:addSummon(summon)
    summon:registerEvent("followMaster")
    position:sendMagicEffect(CONST_ME_MAGIC_BLUE)
    summon:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
    return true
end
