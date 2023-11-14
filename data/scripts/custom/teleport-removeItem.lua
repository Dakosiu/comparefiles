--!Script 1 (Teleport to X position onClick)
local config0 = {
   TeleportFrom = Position(817, 868, 5),
   TeleportTo = Position(813, 857, 9),
   EffectBefore = 306,
   EffectAfter = 313,
}
--!Script 1 (Teleport to X position onClick)

--?Script 2 (Remove X item onClick)
local config = {
   ClickPosition = Position(313, 2551, 11),
   RemovePosition = Position(297, 2552, 11), --- You dont need to create item in RME this part will create the item onStartup too
   RemoveEffect = 330,
   AppearEffect = 330,
   Stone = 1355, --ID
   Seconds = 60, -- Seconds until the stone spawn again
   WallText = "Something seems to have happened",
   WallCancelText = "Nothing seems to have happened",
}
--?Script 2 (Remove X item onClick)

local teleportOnClick = Action()

function teleportOnClick.onUse(player, item, fromPosition, target, toPosition, isHotkey)
   player:getPosition():sendMagicEffect(config0.EffectBefore)
   player:teleportTo(config0.TeleportTo)
   player:say("I got teleported")
   player:getPosition():sendMagicEffect(config0.EffectAfter)
end

teleportOnClick:aid(10101)
teleportOnClick:register()

local revertTime = (config.Seconds * 1000)

local function revertItem()
   Game.createItem(config.Stone, 1, config.RemovePosition)
   config.RemovePosition:sendMagicEffect(config.AppearEffect)
end

local removeStone = Action()
function removeStone.onUse(player, item, fromPosition, target, toPosition, isHotkey)
   local item = Tile(config.RemovePosition):getItemById(config.Stone)
   if item then
      item:remove()
      config.RemovePosition:sendMagicEffect(config.RemoveEffect)
      player:say(config.WallText, TALKTYPE_MONSTER_SAY, false, nil, config.ClickPosition)
      player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The stone has been removed for " .. config.Seconds .. " seconds")
      addEvent(revertItem, revertTime)
   else
      player:say(config.WallCancelText, TALKTYPE_MONSTER_SAY, false, nil, config.ClickPosition)
      player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Theres nothing blocking the way")
   end
   return true
end

removeStone:aid(20201)
removeStone:register()

local globalevent = GlobalEvent("load_Tiles")

function globalevent.onStartup()
   local tile = Tile(config.ClickPosition)
   if tile then
      local thing = tile:getTopVisibleThing()
      if thing then
         attributeID = 20201
         thing:setAttribute(ITEM_ATTRIBUTE_ACTIONID, attributeID)
      end
   end
   local tile = Tile(config0.TeleportFrom)
   if tile then
      local ground = tile:getGround()
      if ground then
         teleportTile = 10101
         ground:setAttribute(ITEM_ATTRIBUTE_ACTIONID, teleportTile)
      end
   end
   revertItem()
end

globalevent:register()
