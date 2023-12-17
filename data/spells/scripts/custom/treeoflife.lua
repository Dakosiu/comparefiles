AREA1 = {
    {0, 0, 0},
    {0, 3, 0},
    {0, 0, 0}
}
 
local function sendHealingEffect(cid, position, loopCount)
    local player = Player(cid)
    if not player then
        return
    end
 
    position:sendDistanceEffect(player:getPosition(), CONST_ANI_SMALLHOLY)
    player:addHealth(math.max(100, 150))
    player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
    if loopCount == 0 then
        player:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
    end
end
 
function onCastSpell(creature, var)
    local playerPos = creature:getPosition()
    local loopCount = 12
 
    creature:say('Heal me my brothers!', TALKTYPE_MONSTER_SAY)
   
    for i = 1, loopCount do
        local position = Position(playerPos.x + math.random(-4, 3), playerPos.y + math.random(-3, 2), playerPos.z)
        addEvent(doAreaCombatHealth, i * 75, creature:getId(), COMBAT_PHYSICALDAMAGE, position, createCombatArea(AREA1), 0, 0, CONST_ME_ASSASSIN)
        addEvent(sendHealingEffect, i * 75, creature:getId(), position, loopCount - i)
    end
    return false
end