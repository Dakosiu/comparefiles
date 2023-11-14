local addSlot = Action()
addSlot:id(21401)

function addSlot.onUse(player, item, fromPosition, target, toPosition, isHotkey)
   local targetItemType = ItemType(target.itemid)
   if not targetItemType:isContainer() then
      player:say("Its not a backpack")
      return false
   end
   local getQuantity = target:getCustomAttribute("Quantity")
   if targetItemType and targetItemType:isContainer() and targetItemType:isMovable() and target:getTopParent() == player
       and not getQuantity then
      target:setCustomAttribute("Quantity", 1)
      target:setAttribute(ITEM_ATTRIBUTE_SLOTS, 1)
      player:say("I increased the backpack size to + 1")
      item:remove(1)
      return false
   end
   if targetItemType and targetItemType:isContainer() and targetItemType:isMovable() and target:getTopParent() == player
       and getQuantity < 100 then
      target:setAttribute(ITEM_ATTRIBUTE_SLOTS, getQuantity + 1)
      target:setCustomAttribute("Quantity", getQuantity + 1)
      player:say("I increased the backpack size to + " .. (getQuantity + 1))
      item:remove(1)
   elseif targetItemType and targetItemType:isContainer() and targetItemType:isMovable() and
       target:getTopParent() == player and getQuantity >= 100 then
      player:say("I already maxed the slots of this backpack")
   elseif targetItemType and targetItemType:isContainer() and targetItemType:isMovable() and
       target:getTopParent() ~= player then
      player:say("I need to have the item with me")
   else
      player:say("Its not a backpack")
   end
end

addSlot:register()

local TestStuff = Action()
TestStuff:id(2571)

function TestStuff.onUse(player, item, fromPosition, target, toPosition, isHotkey)
   local pk = player:getPosition()
   local effect = 251
   for i = 1, 8 do
      Position(pk.x - 1, pk.y - 1, pk.z):sendMagicEffect(effect) -- Top Left
      Position(pk.x, pk.y - 1, pk.z):sendMagicEffect(effect) -- Top
      Position(pk.x + 1, pk.y - 1, pk.z):sendMagicEffect(effect) --Top Right
      Position(pk.x - 1, pk.y, pk.z):sendMagicEffect(effect) -- Left
      Position(pk.x + 1, pk.y, pk.z):sendMagicEffect(effect) -- Right
      Position(pk.x - 1, pk.y + 1, pk.z):sendMagicEffect(effect) -- Bottom Left
      Position(pk.x, pk.y + 1, pk.z):sendMagicEffect(effect) -- Bottom
      Position(pk.x + 1, pk.y + 1, pk.z):sendMagicEffect(effect) -- Bottom Right
   end
   player:setReflect(0)
   player:setExtraHealingBase(0)
   player:setProtectionAllBase(0)
   for i = 1, 6 do
      player:removeBlessing(i)
   end
end

TestStuff:register()

local TestStuff2 = Action()
TestStuff2:id(2572)

function TestStuff2.onUse(player, item, fromPosition, target, toPosition, isHotkey)
   local pk = player:getPosition()
   local effect = 253
   for i = 1, 8 do
      Position(pk.x - 1, pk.y - 1, pk.z):sendMagicEffect(effect) -- Top Left
      Position(pk.x, pk.y - 1, pk.z):sendMagicEffect(effect) -- Top
      Position(pk.x + 1, pk.y - 1, pk.z):sendMagicEffect(effect) --Top Right
      Position(pk.x - 1, pk.y, pk.z):sendMagicEffect(effect) -- Left
      Position(pk.x + 1, pk.y, pk.z):sendMagicEffect(effect) -- Right
      Position(pk.x - 1, pk.y + 1, pk.z):sendMagicEffect(effect) -- Bottom Left
      Position(pk.x, pk.y + 1, pk.z):sendMagicEffect(effect) -- Bottom
      Position(pk.x + 1, pk.y + 1, pk.z):sendMagicEffect(effect) -- Bottom Right
   end
end

TestStuff2:register()

local onUse = Action()
onUse:id(2800)

function onUse.onUse(player, item, fromPosition, target, toPosition, isHotkey)
   --[[ local pk = player:getPosition()
   local effect = 259
   for i = 1, 8 do
      Position(pk.x - 1, pk.y - 1, pk.z):sendMagicEffect(effect) -- Top Left
      Position(pk.x, pk.y - 1, pk.z):sendMagicEffect(effect) -- Top
      Position(pk.x + 1, pk.y - 1, pk.z):sendMagicEffect(effect) --Top Right
      Position(pk.x - 1, pk.y, pk.z):sendMagicEffect(effect) -- Left
      Position(pk.x + 1, pk.y, pk.z):sendMagicEffect(effect) -- Right
      Position(pk.x - 1, pk.y + 1, pk.z):sendMagicEffect(effect) -- Bottom Left
      Position(pk.x, pk.y + 1, pk.z):sendMagicEffect(effect) -- Bottom
      Position(pk.x + 1, pk.y + 1, pk.z):sendMagicEffect(effect) -- Bottom Right
   end --]]
   player:say("Hi")
   local offsets = {
      Position(1,0,1),
      Position(0,1,0),
      Position(1,0,1),
      } -- etc
      
      --position:sendDistanceEffect(positionEx, distanceEffect[, player = nullptr])
      for _, offset in pairs(offsets) do
          local pos = fromPosition
          pos = pos + offset 
          pos:sendDistanceEffect(fromPosition, 31)
      end
end

onUse:register()