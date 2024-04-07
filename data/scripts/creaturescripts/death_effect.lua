local creatureevent = CreatureEvent("DeathAnimationEvent")
local CONST_DEATH_EFFECT = 83; -- Replace with the effect you want
local CONST_DEATH_ITEM = 889; -- Replace with the item you want to create
function creatureevent.onDeath(creature, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)
    -- Your code here
    local deathPosition = creature:getPosition()
    deathPosition:sendMagicEffect(CONST_DEATH_EFFECT)

    addEvent(Game.createItem, 850, CONST_DEATH_ITEM, 1, deathPosition)
    return true
end

creatureevent:register()