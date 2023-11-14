local randomTeleport = Action()
local AID = 14321
local Pos = Position(817, 868, 5)

local config = {
   [1] = { Pos = { 813, 857, 9 }, onPosEffect = 6 },
   [2] = { Pos = { 803, 857, 9 }, onPosEffect = 6 },
}

function randomTeleport.onUse(player, item, fromPosition, target, toPosition, isHotkey)
   local a = item.actionid
   local b = math.random(1, #config)
   if a then
      local c = config[b].Pos
      player:teleportTo(Position(c[1], c[2], c[3]))
      player:SME(config[b].onPosEffect)
   end
end

randomTeleport:aid(AID)
randomTeleport:register()

local globalevent = GlobalEvent("load_randomTeleport")
function globalevent.onStartup()
   local tile = Tile(Pos)
   if tile then
      local thing = tile:getTopVisibleThing()
      if thing then
         thing:setAttribute(ITEM_ATTRIBUTE_ACTIONID, AID)
      end
   end
end

globalevent:register()
