local secondhuntspotexlusive = MoveEvent()
secondhuntspotexlusive:type("stepin")
local tile1 = Position(93, 1113, 5)
-- local tile2 = Position(79, 2229, 12)  -- Removed tile2
local QuestsStorage = {
   Banshee = { 2466 },
}

function secondhuntspotexlusive.onStepIn(creature, item, pos, fromPosition)
   local player = Player(creature)
   local BansheeText = " You Have To Complete Backpack Of Bookworm Qeust! "
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
             tile1:sendAnimatedText("Welcome Thirsty Warrior", TEXTCOLOR_ORANGE, player)
          end
      end
   end
end

secondhuntspotexlusive:aid(6075)
secondhuntspotexlusive:register()

local globalevent = GlobalEvent("secondhuntspotexlusivee")
function globalevent.onStartup()
   local tile = Tile(tile1)
   if tile then
      local ground = tile:getGround()
      if ground then
         ground:setAttribute(ITEM_ATTRIBUTE_ACTIONID, 6075)
      end
   end
   -- Removed the tile2 handling
end

globalevent:register()