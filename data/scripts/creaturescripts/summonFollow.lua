local creatureevent = CreatureEvent("followMaster")
local Range = 9

function creatureevent.onThink(creature, interval)
    if creature then
        local master = creature:getMaster(self)
        if master then
            local masterPos, creaturePos = master:getPosition(), creature:getPosition()
            if masterPos.z ~= creaturePos.z or masterPos:getDistance(creaturePos) >= Range then
                local tile = Tile(masterPos)
                if tile and not tile:hasFlag(TILESTATE_PROTECTIONZONE) then
                    creaturePos:sendMagicEffect(CONST_ME_POFF)
                    creature:teleportTo(masterPos)
                    masterPos:sendMagicEffect(CONST_ME_TELEPORT)
                end
            end
        end
    end
end

creatureevent:register()