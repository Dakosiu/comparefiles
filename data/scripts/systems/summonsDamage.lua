local extraDamage = CreatureEvent("extraDamage_summon")
function extraDamage.onHealthChange(creature, attacker, primaryDamage,
                                    primaryType, secondaryDamage, secondaryType,
                                    origin)
    local player = Player(creature)

    if not creature then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end

    if not primaryType == COMBAT_HEALING then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end

    if not secondaryType == COMBAT_HEALING then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end

    if attacker then
        local hasMaster = attacker:getMaster()
        if hasMaster then
            if hasMaster:isPlayer() then
                local summon = attacker			
                local increase = (hasMaster:getLevel() * 10) + (hasMaster:getMagicLevel() * hasMaster:getMagicLevel())
				local ability = ABILITY_SYSTEM:getSummonDamage(hasMaster)
				if ability > 0 then
				   ability = ability / 100
				   increase = increase + (increase * ability)
				end
                local damage = increase
                if summon:getName() == "Melee" then
                    local value = damage*0.5
                    if increase then
                        primaryDamage = (primaryDamage + primaryDamage + value)
                    end
                end
                if summon:getName() == "Ranged" then
                    local value = damage*0.9
                    if increase then
                        primaryDamage = (primaryDamage + primaryDamage + value)
                    end
                end
                if summon:getName() == "Tank" then
                    local value = damage*0.2
                    if increase then
                        primaryDamage = (primaryDamage + primaryDamage + value)
                    end
                end
           end
        end
    end
    return primaryDamage, primaryType, secondaryDamage, secondaryType
end
extraDamage:register()

local ec = EventCallback
function ec.onTargetCombat(creature, target)
    if creature and target then
        if creature:isPlayer() then target:registerEvent("trappedEnergy") end
    end
    return RETURNVALUE_NOERROR
end

ec:register(7)