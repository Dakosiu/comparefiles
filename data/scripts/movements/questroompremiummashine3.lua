local questroompremiummashin3 = MoveEvent()
questroompremiummashin3:type("stepin")
local tile1 = Position(29, 2139, 9)
-- local tile2 = Position(79, 2229, 12)  -- Removed tile2
local QuestsStorage = {
   Banshee = { 2021 },
}

function questroompremiummashin3.onStepIn(creature, item, pos, fromPosition)
   local player = Player(creature)
   local BansheeText = " You have to complete Pair Of Soft Boots quest, to step here! "
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
                  "You still need to complete the following quests:" .. BansheeText .. ".")
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

questroompremiummashin3:aid(6071)
questroompremiummashin3:register()

local globalevent = GlobalEvent("questroompremiummashine3")
function globalevent.onStartup()
   local tile = Tile(tile1)
   if tile then
      local ground = tile:getGround()
      if ground then
         ground:setAttribute(ITEM_ATTRIBUTE_ACTIONID, 6071)
      end
   end
   -- Removed the tile2 handling
end

globalevent:register()