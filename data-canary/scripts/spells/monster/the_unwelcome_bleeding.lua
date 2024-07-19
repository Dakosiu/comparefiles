local config = {
    cureChance = 1,
    oneSummonDamage = 1,
}

local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
    local killedSummons = creature:getStorage(MonsterStorage.theUnwelcome.killedSummons)
    killedSummons = killedSummons > 0 and killedSummons or 0

    if killedSummons == 0 then
        return false
    end

    if math.random(1, 100) <= config.cureChance then
        creature:say("God relieved my suffering! My bleeding has slightly decreased!", TALKTYPE_MONSTER_SAY)
        creature:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)

        return true
    end

    local damage = config.oneSummonDamage * killedSummons
    
    creature:addHealth(-damage)
    creature:getPosition():sendMagicEffect(CONST_ME_DRAWBLOOD)
    
    return true
end

spell:name("the unwelcome bleeding")
spell:words("###995")
spell:blockWalls(true)
spell:needLearn(true)
spell:register()