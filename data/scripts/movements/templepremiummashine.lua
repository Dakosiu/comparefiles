local FirstPtMashine = MoveEvent()
FirstPtMashine:type("stepin")
local tile1 = Position(845, 872, 5)
local tile2 = Position(844, 872, 5)
local QuestsStorage = {
   Banshee = { 2494 },
   Desert = {  },
   Warlock = {  },
   Behemoth = {  },
}

function FirstPtMashine.onStepIn(creature, item, pos, fromPosition)
   local player = Player(creature)
   local BansheeText = " You have to complete WOI and Hailstorm rod Quest, to step here! "
   local DesertText = "  "
   local WarlockText = "  "
   local BehemothText = "  "
   local doneQuests = {
      BansheeDone = true,
      DesertDone = true,
      WarlockDone = true,
      BehemothDone = true,
   }
   for k, v in pairs(QuestsStorage.Banshee) do
      if player:getStorageValue(v) ~= 1 then
         doneQuests.BansheeDone = false
      end
   end
   for k, v in pairs(QuestsStorage.Desert) do
      if player:getStorageValue(v) ~= 1 then
         doneQuests.DesertDone = false
      end
   end
   for k, v in pairs(QuestsStorage.Warlock) do
      if player:getStorageValue(v) ~= 1 then
         doneQuests.WarlockDone = false
      end
   end
   for k, v in pairs(QuestsStorage.Behemoth) do
      if player:getStorageValue(v) ~= 1 then
         doneQuests.BehemothDone = false
      end
   end
   if doneQuests.BansheeDone then
      BansheeText = ""
   end
   if doneQuests.BehemothDone then
      BehemothText = ""
   end
   if doneQuests.DesertDone then
      DesertText = ""
   end
   if doneQuests.WarlockDone then
      WarlockText = ""
   end

   if creature:isPlayer() then
      if player then
         if pos == tile1 or pos == tile2 then
            if not doneQuests.BansheeDone or not doneQuests.BehemothDone or not doneQuests.DesertDone or not doneQuests.WarlockDone then
               player:sendTextMessage(MESSAGE_STATUS_WARNING,
                  "You still need to complete the following quests:" ..
                  BansheeText .. BehemothText .. DesertText .. WarlockText .. ".")
               if pos == tile1 then
                  tile1:sendMagicEffect(150)
                  player:teleportTo(fromPosition)
                  fromPosition:sendMagicEffect(CONST_ME_POFF)
               end
               if pos == tile2 then
                  tile2:sendMagicEffect(156)
                  player:teleportTo(fromPosition)
                  fromPosition:sendMagicEffect(CONST_ME_POFF)
               end
               return false
            end

            tile1:sendAnimatedText("Warrior", TEXTCOLOR_PURPLE, player)
            tile2:sendAnimatedText("Welcome", TEXTCOLOR_ORANGE, player)
         end
      end
   end
end

FirstPtMashine:aid(6067)
FirstPtMashine:register()

local globalevent = GlobalEvent("load_DayRewardsTEMPLEPACCPT")
function globalevent.onStartup()
   local tile = Tile(tile1)
   if tile then
      local ground = tile:getGround()
      if ground then
         ground:setAttribute(ITEM_ATTRIBUTE_ACTIONID, 6067)
      end
   end
   local tile = Tile(tile2)
   if tile then
      local ground = tile:getGround()
      if ground then
         ground:setAttribute(ITEM_ATTRIBUTE_ACTIONID, 6067)
      end
   end
end

globalevent:register()