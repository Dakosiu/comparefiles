local Base = MoveEvent()
local AID = 10000
Base:type("stepin")

local Pos = Position(32382, 32181, 7)

function Base.onStepIn(creature, item, pos, fromPosition)
   local player = Player(creature)
   local id = item.itemid
   local aid = item.actionid
   local uid = item.uniqueid
end

Base:aid(AID)
Base:register()

local globalevent = GlobalEvent("load_Base")
function globalevent.onStartup()
   addEvent(function() 
      Game.reload(RELOAD_TYPE_WEAPONS)
      print("> Fixed Weapons")
      addEvent(function() 
         Game.reload(RELOAD_TYPE_SPELLS)
         print("> Fixed Spells")
      end, 500)
   end, 1500)
   local tile = Tile(Pos)
   if tile then
      local ground = tile:getGround()
      --local thing = tile:getTopVisibleThing()
      if ground then
         ground:setAttribute(ITEM_ATTRIBUTE_ACTIONID, AID)
      end
   end
end

globalevent:register()
--[[ 
MESSAGE_STATUS_CONSOLE_RED = 18, /*Red message in the console*/
MESSAGE_EVENT_ORANGE = 19, /*Orange message in the console*/
MESSAGE_STATUS_CONSOLE_ORANGE = 20,  /*Orange message in the console*/
MESSAGE_STATUS_WARNING = 21, /*Red message in game window and in the console*/
MESSAGE_EVENT_ADVANCE = 22, /*White message in game window and in the console*/
MESSAGE_EVENT_DEFAULT = 23, /*White message at the bottom of the game window and in the console*/
MESSAGE_STATUS_DEFAULT = 24, /*White message at the bottom of the game window and in the console*/
MESSAGE_INFO_DESCR = 25, /*Green message in game window and in the console*/
MESSAGE_STATUS_SMALL = 26, /*White message at the bottom of the game window"*/
MESSAGE_STATUS_CONSOLE_BLUE = 27, /*FIXME Blue message in the console*/ 
--]]