local defenseShield = CreatureEvent("DefenseShield")

function defenseShield.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType)
    if creature:getStorage(MonsterStorage.defenseShield) < os.time() then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end

    local damage = primaryDamage + secondaryDamage

    creature:addHealth(damage)
    creature:say('A foiled attack ' .. damage .. ' dmg!', TALKTYPE_MONSTER_SAY)
    creature:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)

    return 0, 0, secondaryDamage, secondaryType
end

defenseShield:register()
