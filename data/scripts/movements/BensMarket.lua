local FridayQuest = MoveEvent()
FridayQuest:type("stepin")
local tile1 = Position(814, 875, 4)
local tile2 = Position(814, 876, 4)
local QuestsStorage = {
   Banshee = { 2494 },
   Desert = { 2495 },
   Warlock = { 39027 },
   Behemoth = { 99956 },
}

function FridayQuest.onStepIn(creature, item, pos, fromPosition)
   local day = "Saturday"
   local date = os.date('%A')
   local player = Player(creature)
   local BansheeText = " You have to make all missions at npc Ghuga Ghi and npc Pek! "
   local DesertText = " You have to eat 5x books of dryads! , "
   local WarlockText = " You have to make all missions at npc Syndra! "
   local BehemothText = " You have to eat 2x scrolls of stat points grade 2! "
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
   if doneQuests.BansheeDone == true then
      BansheeText = ""
   end
   if doneQuests.BehemothDone == true then
      BehemothText = ""
   end
   if doneQuests.DesertDone == true then
      DesertText = ""
   end
   if doneQuests.WarlockDone == true then
      WarlockText = ""
   end

   if creature:isPlayer() then
      if player then
         if pos == tile1 or pos == tile2 then
            if doneQuests.BansheeDone == false or doneQuests.BehemothDone == false or doneQuests.DesertDone == false or
                doneQuests.WarlockDone == false then
               player:sendTextMessage(MESSAGE_STATUS_WARNING,
                  "You still need to complete the following quests:" ..
                  BansheeText .. BehemothText .. DesertText .. WarlockText .. ".")
               if pos == tile1 then
                  tile1:sendMagicEffect(150)
                  if date ~= day then
                     tile1:sendAnimatedText("Its not " .. day .. ".", TEXTCOLOR_YELLOW, player)
                  end
                  player:teleportTo(fromPosition)
                  fromPosition:sendMagicEffect(CONST_ME_POFF)
               end
               if pos == tile2 then
                  tile2:sendMagicEffect(156)
                  if date ~= day then
                     tile2:sendAnimatedText("Its not " .. day .. ".", TEXTCOLOR_YELLOW, player)
                  end
                  player:teleportTo(fromPosition)
                  fromPosition:sendMagicEffect(CONST_ME_POFF)
               end
               return false
            end

            if date ~= day then
               if pos == tile1 then
                  fromPosition:sendMagicEffect(140)
                  if date ~= day then
                     tile1:sendAnimatedText("Its not " .. day .. ".", TEXTCOLOR_YELLOW, player)
                     player:sendCancelMessage("Bens market is open only at saturdays, please come back at " .. day .. ".")
                     player:sendTextMessage(MESSAGE_EVENT_DEFAULT,
                        "Bens market is open only at " .. day .. ", please come back saturday.")
                  end
                  player:teleportTo(fromPosition)
                  return true
               end
               if pos == tile2 then
                  fromPosition:sendMagicEffect(130)
                  if date ~= day then
                     tile2:sendAnimatedText("Its not " .. day .. ".", TEXTCOLOR_YELLOW, player)
                     player:sendCancelMessage("Bens market is open only at saturdays, please come back at " .. day .. ".")
                     player:sendTextMessage(MESSAGE_EVENT_DEFAULT,
                        "Bens market is open only at " .. day .. ", please come back saturday.")
                  end
                  player:teleportTo(fromPosition)
                  return true
               end
               return false
            end

            tile1:sendAnimatedText("Welcome to", TEXTCOLOR_ORANGE, player)
            tile2:sendAnimatedText("Bens Market", TEXTCOLOR_PURPLE, player)
         end
      end
   end
end

FridayQuest:aid(6066)
FridayQuest:register()

local globalevent = GlobalEvent("load_DayRewards")
function globalevent.onStartup()
   local tile = Tile(tile1)
   if tile then
      local ground = tile:getGround()
      if ground then
         ground:setAttribute(ITEM_ATTRIBUTE_ACTIONID, 6066)
      end
   end
   local tile = Tile(tile2)
   if tile then
      local ground = tile:getGround()
      if ground then
         ground:setAttribute(ITEM_ATTRIBUTE_ACTIONID, 6066)
      end
   end
end

globalevent:register()
