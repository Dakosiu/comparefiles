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
				local attackPoints = 1
				if hasMaster:isPlayer() then
                   attackPoints = math.max(0, hasMaster:getStorageValue(StatSystem.config.storages.attackPoints))
				end
				
                if attackPoints < 0 then
                    attackPoints = 1
                end
                local increase = (hasMaster:getLevel() * 10) + (hasMaster:getMagicLevel() * hasMaster:getMagicLevel())
                --increase = increase + increase * (attackPoints / 100)
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