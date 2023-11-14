local StaminaTile = MoveEvent()
StaminaTile:type("stepin")

local config = {
   ["Free"] = { staminaMinutes = 2 },
   ["Premium"] = { staminaMinutes = 3 },
}
local timeToAdd = 1 --in Minutes


timeToAdd = timeToAdd * 10000
local addingStamina

local function addStamina(cid)
   local player = Player(cid)
   local j
   if not player then
      stopEvent(addStamina)
      return false
   end
   if player then
      local Pos = player:getPosition()
      if Pos then
         j = Tile(Pos):getItemById(41543)
         if j then
            if player then
               if player:isPremium() then
                  player:setStamina(player:getStamina() + config["Premium"].staminaMinutes)
               else
                  player:setStamina(player:getStamina() + config["Free"].staminaMinutes)
               end
               addingStamina = addEvent(addStamina, timeToAdd, player:getId())
            end
         end
      end
   end
end

function StaminaTile.onStepIn(creature, item, pos, fromPosition)
   local player = Player(creature)
   if creature:isPlayer() then
      if player:isPremium() then
         player:sendTextMessage(MESSAGE_EVENT_ADVANCE,
            "You will now receive " ..
            config["Premium"].staminaMinutes .. " stamina minutes every " .. timeToAdd / 10000 .. " minutes")
      else
         player:sendTextMessage(MESSAGE_EVENT_ADVANCE,
            "You will now receive " ..
            config["Free"].staminaMinutes .. " stamina minutes every " .. timeToAdd / 10000 .. " minutes")
      end
      addingStamina = addEvent(addStamina, timeToAdd, player:getId())
   end
end

StaminaTile:id(41543)
StaminaTile:register()

local StaminaTileLeave = MoveEvent()
StaminaTileLeave:type("stepout")

function StaminaTileLeave.onStepOut(creature, item, pos, fromPosition)
   local player = Player(creature)
   if player then
      stopEvent(addingStamina)
   end
end

StaminaTileLeave:id(41543)
StaminaTileLeave:register()