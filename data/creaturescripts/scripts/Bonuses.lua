local OPCODE_LANGUAGE = 1

function onExtendedOpcode(player, opcode, buffer)
    return
    if opcode == 16 then
        local value = 0
        local condition = player:getCondition(CONDITION_REGENERATION, CONDITIONID_DEFAULT)
        if condition and condition:getTicks() ~= nil then
            value = condition:getTicks()
        end

        if not (buffer == "getRefresh") then
            if buffer == "sendBanana" then
                player:setStorageValue(1311, (player:getStorageValue(1311) + 1))
                player:addItem(2676, 1)
            end
        end

        local toAddHere = 0
        if player:getItemsBonusDamage() then
            toAddHere = player:getItemsBonusDamage()
        end

        local rate = _G.rate
        local response = {
            ExtraHealing = player:getTotalExtraHealing(),
            BonusDamage = math.max(0, player:getStorageValue(StatSystem.config.storages.attackPoints) / 2) + toAddHere,
            ProtectionLoss = player:getLossPercent(),
            TrappedEnergy = math.floor(player:getStorageValue(StatSystem.config.storages.trappedEnergyPoints) / 3),
            BonusHealth = player:onLookBonusHealth(),
            BonusMana = player:onLookBonusMana(),
            SpeedBonus = player:getTotalSpeedBonus() / 2,
            BonusExp = rate,
            CapBonus = player:getStorageValue(31214124) * 25,
            Reflect = player:getTotalReflect(),
            Dodge = player:getTotalDodge(),
            protectionAll = player:getAllProtection(),
            HPs = player:getExtraHealthRegeneration(),
            MPs = player:getExtraManaRegeneration(),
            RegenTime = value,
        }
        player:sendExtendedOpcode(16, json.encode(response))
    end
end
