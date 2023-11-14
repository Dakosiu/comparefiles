local passagetofirstdesert = MoveEvent()
passagetofirstdesert:type("stepin")
local tile1 = Position(1042, 1087, 4)
-- local tile2 = Position(79, 2229, 12)  -- Removed tile2
local QuestsStorage = {
   Banshee = { 2337 },
}

function passagetofirstdesert.onStepIn(creature, item, pos, fromPosition)
   local player = Player(creature)
   local BansheeText = " You have to open chest/quest near Orshabaal, on the highest floor, you can use command /bosses to locate this boss! "
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
                player:sendTextMessage(MESSAGE_STATUS_WARNING, "To pass the bridge" .. BansheeText .. ".")
                tile1:sendMagicEffect(50)
                player:teleportTo(fromPosition)
                fromPosition:sendMagicEffect(CONST_ME_POFF)
                return false
             end
             tile1:sendAnimatedText("Welcome Warrior", TEXTCOLOR_ORANGE, player)
          end
      end
   end
end

passagetofirstdesert:aid(6072)
passagetofirstdesert:register()

local globalevent = GlobalEvent("passagetofirstdesertt")
function globalevent.onStartup()
   local tile = Tile(tile1)
   if tile then
      local ground = tile:getGround()
      if ground then
         ground:setAttribute(ITEM_ATTRIBUTE_ACTIONID, 6072)
      end
   end
   -- Removed the tile2 handling
end

globalevent:register()