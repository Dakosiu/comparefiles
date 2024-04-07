print("------------------")
print("------------------")
print("------------------")
print("death_effect.lua INIT")


monstersSystem = {
    [1] = {name = "Drunken Gladiator"},
    [2] = {name = "Gladiator Fisherman"},
    [3] = {name = "Bully Gladiator"},
    [4] = {name = "Helmet Gladiator"}
}

for _, monster in pairs(monstersSystem) do
    local creature = Creature(monster.name)
    if creature then
        local creatureevent = CreatureEvent(creature)
        function creatureevent.onDeath(creatureLocal, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)
            -- Your code here. This will be executed when any creature dies.
            creatureLocal:getPosition():sendMagicEffect(83) -- replace CONST_ME_MAGIC_RED with the effect you want
        
            return true
        end
        
        creatureevent:register()

    end
end

function addEvent(creatureName)
    -- local creature = Creature(creatureName)
    if creature then
        local creatureevent = CreatureEvent(creature)
        function creatureevent.onDeath(creatureLocal, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)
            -- Your code here. This will be executed when any creature dies.
            creatureLocal:getPosition():sendMagicEffect(83) -- replace CONST_ME_MAGIC_RED with the effect you want
        
            return true
        end
        
        creatureevent:register()

    end
end


print("death_effect.lua END")