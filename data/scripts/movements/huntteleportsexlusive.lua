local firsthuntspotexlusive = MoveEvent()
firsthuntspotexlusive:type("stepin")
local tile1 = Position(80, 1113, 5)
-- local tile2 = Position(79, 2229, 12)  -- Removed tile2
local QuestsStorage = {
   Banshee = { 2412 },
}

function firsthuntspotexlusive.onStepIn(creature, item, pos, fromPosition)
   local player = Player(creature)
   local BansheeText = " You Need Complete Newbie Surprise Box Quest! "
   local doneQuests = {
      BansheeDone = true,
   }
   
   if creature:isPlayer() then
      if player then
         for k, v in pairs(QuestsStorage.Banshee) do
             if player:getStorageValue(v) ~= 1 then
                doneQuests.BansheeDone = false
             end
          end
          if doneQuests.BansheeDone then
             BansheeText = ""
          end
     
	      if pos == tile1 then  -- Removed the tile2 condition
             if not doneQuests.BansheeDone then
                player:sendTextMessage(MESSAGE_STATUS_WARNING, "To Go Down" .. BansheeText .. ".")
                tile1:sendMagicEffect(50)
                player:teleportTo(fromPosition)
                fromPosition:sendMagicEffect(CONST_ME_POFF)
                return false
             end
             tile1:sendAnimatedText("Welcome Young Soul", TEXTCOLOR_ORANGE, player)
          end
      end
   end
end

firsthuntspotexlusive:aid(6074)
firsthuntspotexlusive:register()

local globalevent = GlobalEvent("firsthuntspotexlusivee")
function globalevent.onStartup()
   local tile = Tile(tile1)
   if tile then
      local ground = tile:getGround()
      if ground then
         ground:setAttribute(ITEM_ATTRIBUTE_ACTIONID, 6074)
      end
   end
   -- Removed the tile2 handling
end

globalevent:register()