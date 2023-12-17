local fridayquest = MoveEvent()
fridayquest:type("stepin")
local tile1 = Position(808, 871, 5)
-- local tile2 = Position(79, 2229, 12)  -- Removed tile2
local QuestsStorage = {
   Banshee = { 2018 },
}

function fridayquest.onStepIn(creature, item, pos, fromPosition)
   local player = Player(creature)
   local BansheeText = " have to complete 100cc quest in quest room, to step here! "
   local doneQuests = {
      BansheeDone = true,
   }
   for k, v in pairs(QuestsStorage.Banshee) do
      if player:getStorageValue(v) ~= 1 then
         doneQuests.BansheeDone = false
      end
   end
   if doneQuests.BansheeDone then
      BansheeText = ""
   end

   if creature:isPlayer() then
      if player then
         if pos == tile1 then  -- Removed the tile2 condition
            if not doneQuests.BansheeDone then
               player:sendTextMessage(MESSAGE_STATUS_WARNING,
                  "You" .. BansheeText .. ".")
               tile1:sendMagicEffect(150)
               player:teleportTo(fromPosition)
               fromPosition:sendMagicEffect(CONST_ME_POFF)
               return false
            end

            tile1:sendAnimatedText("Welcome Warrior", TEXTCOLOR_ORANGE, player)
         end
      end
   end
end

fridayquest:aid(6073)
fridayquest:register()

local globalevent = GlobalEvent("fridayquestt")
function globalevent.onStartup()
   local tile = Tile(tile1)
   if tile then
      local ground = tile:getGround()
      if ground then
         ground:setAttribute(ITEM_ATTRIBUTE_ACTIONID, 6073)
      end
   end
   -- Removed the tile2 handling
end

globalevent:register()