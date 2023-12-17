local AID = 12932
local Pos = Position(1135, 1160, 0)

local config = {
   [1] = { Pos = { 1127, 1161, 7 }, onPosEffect = 6 },
   [2] = { Pos = { 1128, 1161, 7 }, onPosEffect = 6 },
   [3] = { Pos = { 1129, 1161, 7 }, onPosEffect = 6 },
   [4] = { Pos = { 1130, 1161, 7 }, onPosEffect = 6 },
   [5] = { Pos = { 1131, 1161, 7 }, onPosEffect = 6 },
   [6] = { Pos = { 1132, 1161, 7 }, onPosEffect = 6 },
   [7] = { Pos = { 1133, 1161, 7 }, onPosEffect = 6 },
   [8] = { Pos = { 1127, 1164, 7 }, onPosEffect = 6 },
   [9] = { Pos = { 1128, 1164, 7 }, onPosEffect = 6 },
   [10] = { Pos = { 1129, 1164, 7 }, onPosEffect = 6 },
   [11] = { Pos = { 1130, 1164, 7 }, onPosEffect = 6 },
   [12] = { Pos = { 1131, 1164, 7 }, onPosEffect = 6 },
   [13] = { Pos = { 1132, 1164, 7 }, onPosEffect = 6 },
   [14] = { Pos = { 1133, 1164, 7 }, onPosEffect = 6 },
   [15] = { Pos = { 1127, 1165, 7 }, onPosEffect = 6 },
   [16] = { Pos = { 1128, 1165, 7 }, onPosEffect = 6 },
   [17] = { Pos = { 1129, 1165, 7 }, onPosEffect = 6 },
   [18] = { Pos = { 1130, 1165, 7 }, onPosEffect = 6 },
   [19] = { Pos = { 1131, 1165, 7 }, onPosEffect = 6 },
   [20] = { Pos = { 1132, 1165, 7 }, onPosEffect = 6 },
   [21] = { Pos = { 1133, 1165, 7 }, onPosEffect = 6 },
   [22] = { Pos = { 1127, 1168, 7 }, onPosEffect = 6 },
   [23] = { Pos = { 1128, 1168, 7 }, onPosEffect = 6 },
   [24] = { Pos = { 1129, 1168, 7 }, onPosEffect = 6 },
   [25] = { Pos = { 1130, 1168, 7 }, onPosEffect = 6 },
   [26] = { Pos = { 1131, 1168, 7 }, onPosEffect = 6 },
   [27] = { Pos = { 1132, 1168, 7 }, onPosEffect = 6 },
   [28] = { Pos = { 1133, 1168, 7 }, onPosEffect = 6 },
}

local randomChair = Action()
function randomChair.onUse(player, item, fromPosition, target, toPosition, isHotkey)
   local a = item.actionid
   local b = math.random(1, #config)
   if a then
      local c = config[b].Pos
      player:teleportTo(Position(c[1], c[2], c[3]))
      player:SME(config[b].onPosEffect)
   end
end

randomChair:aid(AID)
randomChair:register()

local globalevent = GlobalEvent("load_randomChair")
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