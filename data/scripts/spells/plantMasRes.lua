local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
    local master = creature:getMaster()
    if creature then
        if master then
            local conditions = {
                CONDITION_POISON, CONDITION_FIRE, CONDITION_ENERGY,
                CONDITION_PARALYZE, CONDITION_DRUNK, CONDITION_DROWN,
                CONDITION_CURSED
            }
            local party = master:getParty()
            local pos = creature:getPosition()
            if not party then
                local player = creature:getMaster()
                local playerPos = player:getPosition()
                local mxMana, mxHealth, ml, lvl = player:getMaxMana(),
                                                  player:getMaxHealth(),
                                                  player:getMagicLevel(),
                                                  player:getLevel()
                local formula = math.floor(ml * 10 + mxHealth * 0.5)
                pos:sendDistanceEffect(playerPos, 81) -- 81
                player:addHealth(formula)
                player:addMana(formula * 0.1)
                player:SME(15)
                for i, todos in ipairs(conditions) do
                    player:removeCondition(todos)
                end
                creature:setItemOutfit(31579, 1)
                return true
            end
            if party then
                local partyMembers = party:getMembers()
                for _, member in pairs(partyMembers) do
                    local memberPos = member:getPosition()
                    local mxMana, mxHealth, ml, lvl = member:getMaxMana(),
                                                      member:getMaxHealth(),
                                                      member:getMagicLevel(),
                                                      member:getLevel()
                    local formula = math.floor(ml * 10 + mxHealth * 0.5)
                    pos:sendDistanceEffect(memberPos, 81) -- 81
                    member:addHealth(formula)
                    member:addMana(formula * 0.1)
                    member:SME(15)
                    for i, todos in ipairs(conditions) do
                        member:removeCondition(todos)
                    end
                    local player = creature:getMaster()
                    local playerPos = player:getPosition()
                    local mxMana, mxHealth, ml, lvl = player:getMaxMana(),
                                                      player:getMaxHealth(),
                                                      player:getMagicLevel(),
                                                      player:getLevel()
                    local formula = math.floor(ml * 10 + mxHealth * 0.5)
                    pos:sendDistanceEffect(playerPos, 81) -- 81
                    player:addHealth(formula)
                    player:addMana(formula * 0.1)
                    player:SME(15)
                    for i, todos in ipairs(conditions) do
                        player:removeCondition(todos)
                    end
                    creature:setItemOutfit(31579, 1)
                end
            end
        end
    end
    return true
end

spell:name("Summon Healing")
spell:words("summon healing supreme")
spell:group("support")
vocation("Botanist")
spell:id(247)
spell:cooldown(2 * 500)
spell:groupCooldown(2 * 500)
spell:level(22)
spell:manaPercent(1)
spell:isAggressive(false)
spell:range(8)
spell:needCasterTargetOrDirection(true)
spell:isBlockingWalls(true)
spell:isPremium(false)
spell:needLearn(false)
spell:register()
