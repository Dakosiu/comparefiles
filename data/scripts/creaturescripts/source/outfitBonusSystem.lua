local ec = EventCallback
bonusMount = 99937
function ec.onChangeOutfit(creature, outfit)
    local player = Player(creature)
    if not player then return true end
    local previousOutfit = player:getOutfit().lookType
    local look = outfit.lookType
    if player and player:hasOutfit(look, 3) then
      if previousOutfit == look then
         return true
      end
        player:updateHealthAddonBonus(3)
        player:updateManaAddonBonus(3)
    end
    return true
end

ec:register( --[[0]] )

local ec = EventCallback

function ec.onChangeMount(creature, mount)
   local player = Player(creature)
   if not player then return true end
    if mount > 0 and player:getStorageValue(bonusMount) == 0 then
        player:setMountBonusSpeed()
        player:setStorageValue(bonusMount, 1)
    elseif mount == 0 and player:getStorageValue(bonusMount) == 1 then
        player:changeSpeed(-player:getSpeedMountBonus() * 2)
        player:setStorageValue(bonusMount, 0)
    end
    return true
end

ec:register( --[[0]] )
