local questroompremiummashin2 = MoveEvent()
questroompremiummashin2:type("stepin")
local tile1 = Position(39, 2135, 9)
-- local tile2 = Position(79, 2229, 12)  -- Removed tile2
local QuestsStorage = {
   Banshee = { 2019 },
}

function questroompremiummashin2.onStepIn(creature, item, pos, fromPosition)
   local player = Player(creature)
   local BansheeText = " You have to complete 25 Amber Coins quest in quests room, to step here! "
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

questroompremiummashin2:aid(6070)
questroompremiummashin2:register()

local globalevent = GlobalEvent("questroompremiummashine2")
function globalevent.onStartup()
   local tile = Tile(tile1)
   if tile then
      local ground = tile:getGround()
      if ground then
         ground:setAttribute(ITEM_ATTRIBUTE_ACTIONID, 6070)
      end
   end
   -- Removed the tile2 handling
end

globalevent:register()