function onDeath(creature, corpse, killer, mostDamage, unjustified, mostDamage_unjustified)


if creature:getName() == FLAME_EVENT.monster.name then
Game.broadcastMessage("Player " .. mostDamage:getName() .. " dealt most damage to Fafnar. CONGRATULATIONS! PARTICIPANTS", MESSAGE_STATUS_WARNING)
local statue = Game.createItem(FLAME_EVENT.statue.itemid, 1, FLAME_EVENT.statue.position)

local basin = Tile(FLAME_EVENT.basin.position):getItemById(FLAME_EVENT.basin.itemid)
if basin then
basin:setAttribute(ITEM_ATTRIBUTE_ACTIONID, FLAME_EVENT.basin.actionid)
end
end


function getTileItems(pos)
    pos.stackpos = 0
    local v = getTileThingByPos(pos)
    local items = {}
    repeat
        pos.stackpos = pos.stackpos + 1
        v = getTileThingByPos(pos)
        table.insert(items, v)
    until v.itemid == 0
    pos.stackpos = pos.stackpos - 1
    return items
end

for _, item in pairs(getTileItems(FLAME_EVENT.statue.position)) do
  if (isMoveable(item.uid) == 1) then
       print("Itemid "..item.itemid.." is movable")
  end
end

return true
end
