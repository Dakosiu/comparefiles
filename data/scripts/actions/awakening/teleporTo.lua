local teleportToAutomatic = Action()
local AID = 18300

local config = {
   [1] = { positionToClick = {819, 867, 5}, positionToTeleport = {746,886,4}, MinimumLevel = 25, onPosEffect = 7 },
   [2] = { positionToClick = {1110, 979, 7}, positionToTeleport = {1128,983,7}, MinimumLevel = 55, onPosEffect = 55 },
   [3] = { positionToClick = {845, 870, 5}, positionToTeleport = {844,870,5}, MinimumLevel = 1, onPosEffect = 15 },
   [4] = { positionToClick = {813, 868, 4}, positionToTeleport = {682,2183,7}, MinimumLevel = 1000, onPosEffect = 7 },
   [5] = { positionToClick = {971, 987, 9}, positionToTeleport = {963,989,10}, MinimumLevel = 30, onPosEffect = 21 },
}

function teleportToAutomatic.onUse(player, item, fromPosition, target, toPosition, isHotkey)
   local a = item.actionid
   local b = a - AID
   if  config[b] then
      local c = config[b]
      if c then
         local d = player:getLevel()
         if d >= c.MinimumLevel then
            local e = c.positionToTeleport
            player:SME(CONST_ME_TELEPORT)
            player:teleportTo(Position(e[1], e[2], e[3]))
            player:SME(c.onPosEffect)
            return false
         end
         player:sendTextMessage(MESSAGE_STATUS_WARNING, "You are not strong enough")
         player:SME(CONST_ME_POFF)
      end
   end
end

for v in pairs(config) do
   teleportToAutomatic:aid(AID + v)
end
teleportToAutomatic:register()

local globalevent = GlobalEvent("load_teleportToAutomatic")
function globalevent.onStartup()
   for i in pairs(config) do    
      local a = config[i].positionToClick
      local tile = Tile(Position(a[1], a[2], a[3]))
      if tile then
         local thing = tile:getTopVisibleThing()
         if thing then
            thing:setAttribute(ITEM_ATTRIBUTE_ACTIONID, AID + i)
         end
      end
   end
end

globalevent:register()
