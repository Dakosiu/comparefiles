local openTeleport = Action()
local AID = 14322
local Pos = Position(812, 867, 3)
local createPos = Position(810, 869, 3)
local toPos = Position(813, 869, 3)
local Storage = 88421
local cdtime = 6 * 60 * 60 -- 6 Hours

local config = {
   [1] = { AreaName = "Starter Area", Pos = { 746, 886, 4 } },
   [2] = { AreaName = "Not Starter Area", Pos = { 833, 904, 4 } },
}

local e
local b
local c
function openTeleport.onUse(player, item, fromPosition, target, toPosition, isHotkey)
   local a = player:getLevel()
   if a >= 120 then
      if player:getStorageValue(Storage) < os.time() then -- if player:getStorageValue(Storage) < os.time() then
         local teleport = Game.createItem(1387, 1, createPos)
         player:SME(40)
         if teleport then
            b = math.random(1, #config)
            c = config[b]
            local d = c.Pos
            e = Position(d[1], d[2], d[3])
            teleport:setDestination(e)
            teleport:setAttribute(ITEM_ATTRIBUTE_ACTIONID, 23142)
            for i = 1, 10 do
               addEvent(function()
                  createPos:sendAnimatedText(11 - i, 165)
               end, i * 1000)
            end
            addEvent(function()
               local tile = Tile(createPos)
               if tile then
                  local teleport = tile:getItemById(1387)
                  if teleport then
                     teleport:remove()
                     createPos:sendMagicEffect(CONST_ME_POFF)
                  end
               end
            end, 11000)
         end
         player:setStorageValue(Storage, os.time() + cdtime)
      elseif player:getStorageValue(Storage) > os.time() then
         player:sendTextMessage(MESSAGE_STATUS_WARNING, "You can't do it now")
         player:SME(CONST_ME_POFF)
      end
      if a <= 120 then
         player:sendTextMessage(MESSAGE_STATUS_WARNING, "You are not strong enough")
         player:SME(CONST_ME_POFF)
      end
   end
end

openTeleport:aid(AID)
openTeleport:register()

local onSteponOpenTeleport = MoveEvent()
onSteponOpenTeleport:type("stepin")

function onSteponOpenTeleport.onStepIn(creature, item, pos, fromPosition)
   local player = Player(creature)
   if player:getPosition() == e then
      player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have been teleported to: " .. c.AreaName .. ".")
   end
end

onSteponOpenTeleport:aid(23142)
onSteponOpenTeleport:register()

local globalevent = GlobalEvent("load_openTeleport")
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
