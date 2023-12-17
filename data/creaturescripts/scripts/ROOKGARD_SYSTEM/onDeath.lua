function onDeath(player, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)

    print("Does it work?")
    if player:getStorageValue(ROOKGARD_SYSTEM.storage) < 2 then
    player:setVocation(0)
    player:setStorageValue(ROOKGARD_SYSTEM.storage, 1)
    
    end
return true
end