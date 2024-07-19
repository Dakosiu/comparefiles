local theUnwelcome = CreatureEvent("TheUnwelcome")

function theUnwelcome.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    local summons = creature:getSummons()

    if #summons == 0 then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end

    local messageExhaust = creature:getStorage(MonsterStorage.theUnwelcome.messageExhaust)

    if messageExhaust <= 0 or messageExhaust < os.time() then
        creature:setStorage(MonsterStorage.theUnwelcome.messageExhaust, os.time() + 4)
        creature:say("I will not die! First, deal with my minions. Ahahahah!", TALKTYPE_MONSTER_SAY)
    end

    creature:getPosition():sendMagicEffect(CONST_ME_POFF)

    return 0, 0, secondaryDamage, secondaryType
end

theUnwelcome:register()
