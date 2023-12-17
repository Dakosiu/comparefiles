local endofquest = MoveEvent()
endofquest:type("stepin")

local endingtile = Position(957, 1049, 6)

function endofquest.onStepIn(creature, item, pos, fromPosition)
   local player = Player(creature)
   if player then
      if player:getPosition() == endingtile then
            if player:getStorageValue(3231) == 1 then
            player:setStorageValue(rookgardSystem.storage, false)
            player:setStorageValue(3231, -1)
            player:setStorageValue(22223, -1)
            player:saveStatement()
            player:remove()
            player:say("You finished the Rook Quest")
         end
      end
   end
end

endofquest:aid(9959)
endofquest:register()

local globalevent = GlobalEvent("load_endofRook")
function globalevent.onStartup()
   local tile = Tile(endingtile)
   if tile then
      local ground = tile:getGround()
      if ground then
         ground:setAttribute(ITEM_ATTRIBUTE_ACTIONID, 9959)
      end
   end
end

globalevent:register()