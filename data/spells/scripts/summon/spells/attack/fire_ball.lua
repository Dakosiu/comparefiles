--[[ local combat = createCombatObject()
local area = createCombatArea(AREA_SQUARE1X1)
setCombatArea(combat, area)
function onCastSpell(creature, var)
    local target = creature:getTarget()
    local summs = creature:getSummons()
        if #summs == 0 then
        creature:getPosition():sendMagicEffect(CONST_ME_POFF)
        creature:sendTextMessage(MESSAGE_STATUS_DEFAULT, "You do not have any summons.")
        return false
    end
   

    for i, summon in ipairs(summs) do
    local specs = Game.getSpectators(summon:getPosition(), false, false, 1, 1, 1, 1)
            for _, mon in pairs(specs) do
                if mon:isMonster() and mon:getMaster() ~= creature then
                    mon:getPosition():sendMagicEffect(CONST_ME_REDSMOKE)
                    mon:castSpell("Ultimate Flame Strike")
                end
            end
        doAreaCombatHealth(summon, COMBAT_HEALINGDAMAGE, summon:getPosition(), area, 0, 0, CONST_ME_MAGIC_RED)
        doCombat(summon, combat, var)
    end
   
return false
end --]]