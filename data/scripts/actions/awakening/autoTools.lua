local autoRope = Action()

function autoRope.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:getItemCount(2120) > 0 then return onUseRope(player, item, fromPosition, target, toPosition, isHotkey) end
end
for v, k in pairs(ropeSpots) do
    autoRope:id(ropeSpots[v])
end

autoRope:register()

local autoShovel = Action()

function autoShovel.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:getItemCount(2554) > 0 then return onUseShovel(player, item, fromPosition, target, toPosition, isHotkey) end
end
local holes = {468, 481, 483, 23712}
for v, k in pairs(holes) do
    autoShovel:id(holes[v])
end

autoShovel:register()
