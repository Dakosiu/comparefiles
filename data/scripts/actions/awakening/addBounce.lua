local addBounce = Action()
addBounce:id(41147)

function addBounce.onUse(player, item, fromPosition, target, toPosition, isHotkey)
   local T = ItemType(target.itemid)
   if not T:isContainer() then
      target:addExplosion(100)
      target:addBounce(100)
      target:addChain(100)
      target:addBlow(100)
   end
   --print(target:getWeaponType())
end

addBounce:register()
