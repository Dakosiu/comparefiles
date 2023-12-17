local summonConfig = {
    ["support"] = {level = 22, soul = 0, mana = 10, livingTime = 30},
    ["venom"] = {level = 22, soul = 0, mana = 10, livingTime = 30},
    ["poison"] = {level = 22, soul = 0, mana = 10, livingTime = 60}
}

local function removeCreature(cid)
local summon = Creature(cid)
   if not summon then
      stopEvent(removeCreature)
      return false
   end
	summon:getPosition():sendMagicEffect(CONST_ME_POFF)
	summon:remove()
end

function onCastSpell(creature, variant)
	local removeSummon
    if creature:getSkull() == SKULL_BLACK then
        creature:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
        return false
    end

    local monsterName = variant:getString():lower()
    local monsterType = MonsterType(monsterName)
    local summons = math.floor((creature:getLevel() / 100) + 1) -- Calculate the max Summons
    local level = creature:getLevel() -- Get player Level
    -- !CHECK IF MONSTER
    if not monsterType then
        creature:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
        creature:getPosition():sendMagicEffect(CONST_ME_POFF)
    end

    if summonConfig[monsterName] then
        if level >= summonConfig[monsterName].level and #creature:getSummons() <
            summons and creature:getMana() >= summonConfig[monsterName].mana then
            local position = creature:getPosition()
            local summon = Game.createMonsterLevel(monsterName, position, true,
                                                   false, creature:getLevel())
            -- creature:addSoul(-summonConfig[monsterName].soul)
            creature:addMana(-summonConfig[monsterName].mana)
            creature:addSummon(summon)
				removeSummon = addEvent(removeCreature, summonConfig[monsterName].livingTime*1000, summon:getId())
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
    position:sendMagicEffect(CONST_ME_MAGIC_BLUE)
    summon:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
    return true
end
