local Sofa = MoveEvent()
local AID = 13000
Sofa:type("stepin")

local config = {
   [1] = { Pos = { x = 817, y = 868, z = 3 }, Message = " Oh, this sofa is comfortable!", chance = 33 },
   [2] = { Pos = { x = 818, y = 868, z = 3 }, Message = " Oh, this sofa is comfortable!", chance = 33 },
   [3] = { Pos = { x = 821, y = 872, z = 3 }, Message = " Oh, this sofa is comfortable!", chance = 33 },
   [4] = { Pos = { x = 821, y = 873, z = 3 }, Message = " Oh, this sofa is comfortable!", chance = 33 },
   [5] = { Pos = { x = 821, y = 874, z = 3 }, Message = " Oh, this sofa is comfortable!", chance = 33 },
   [6] = { Pos = { x = 821, y = 875, z = 3 }, Message = " Oh, this sofa is comfortable!", chance = 33 },
   [7] = { Pos = { x = 818, y = 872, z = 4 }, Message = " Oh, this sofa is comfortable!", chance = 33 },
   [8] = { Pos = { x = 818, y = 873, z = 4 }, Message = " Oh, this sofa is comfortable!", chance = 33 },
   [9] = { Pos = { x = 821, y = 872, z = 4 }, Message = " Oh, this sofa is comfortable!", chance = 33 },
   [10] = { Pos = { x = 821, y = 873, z = 4 }, Message = " Oh, this sofa is comfortable!", chance = 33 },
}

function Sofa.onStepIn(creature, item, pos, fromPosition)
   local player = Player(creature)
   if not player then return true end
   local aid = item.actionid
   for a in pairs(config) do
      local total = (AID + a)
      if aid == total then
         local t = (total - AID)
         t = config[t]
         if t then
            local chance = math.random(1, 100)
            if chance <= t.chance then
               player:getPosition():sendAnimatedText(t.Message, 171)
            end
         end
      end
   end
end

for i in pairs(config) do
   Sofa:aid(AID + i)
end
Sofa:register()

local globalevent = GlobalEvent("load_Sofa")
function globalevent.onStartup()
   for i in pairs(config) do
      local tile = Tile(Position(config[i].Pos.x, config[i].Pos.y, config[i].Pos.z))
      if tile then
         local thing = tile:getTopVisibleThing()
         if thing then
            thing:setAttribute(ITEM_ATTRIBUTE_ACTIONID, AID + i)
         end
      end
   end
end

globalevent:register()