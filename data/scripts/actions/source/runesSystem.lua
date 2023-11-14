local config = {
   Runes = {
      --! Mana Runes
      { runeID = 41266, manaMin = 4600, manaMax = 6200, effect = 170 },
      { runeID = 41265, manaMin = 6200, manaMax = 7800, effect = 226 },
      { runeID = 41189, manaMin = 7800, manaMax = 9400, effect = 275 },
      --! Spitit Runes
      { runeID = 41169, manaMin = 2800, manaMax = 4000, healthMin = 4640, healthMax = 5920, effect = 168 },
      { runeID = 41168, manaMin = 4000, manaMax = 5200, healthMin = 5920, healthMax = 7200, effect = 225 },
      { runeID = 41195, manaMin = 5200, manaMax = 6400, healthMin = 7200, healthMax = 8480, effect = 267 },
      --! Health Runes
      { runeID = 41177, healthMin = 9900,  healthMax = 13000, effect = 167 },
      { runeID = 41176, healthMin = 13000, healthMax = 17000, effect = 223 },
      { runeID = 41203, healthMin = 17000, healthMax = 21000, effect = 288 },
   },
   
   
   
   Cooldown = 3, -- in Seconds
}

local action = Action()
function action.onUse(player, item, fromPos, target, toPos, isHotkey)

    for i, v in ipairs(config.Runes) do
	    if v.runeID == item:getId() then
            if player:getStorageValue(runesStorage - 1 + i) > os.time() then
               local message = string.format("You still need to wait: %s", timeLeft(player:getStorageValue(runesStorage -1 + i) - os.time(), true))
               player:sendCancelMessage(message)
               player:sendMagicEffect(CONST_ME_POFF)
               return true
            end		
			if v.manaMin then
			   local value = math.random(v.manaMin, v.manaMax)
			   if not target then
			      target = player
			   end
			   doTargetCombat(player, target, COMBAT_MANADRAIN, value, value)
			end
            
            if v.healthMin then
                local value = math.random(v.healthMin, v.healthMax)			
			    if not target then
			       target = player
			    end			    
			    doTargetCombat(player, target, COMBAT_HEALING, value, value)
			end
			player:sendMagicEffect(v.effect)
			player:setStorageValue(runesStorage - 1 + i, os.time() + config.Cooldown)
		    item:remove(1)
		    return true
		end
	end
	
	return true
end
	
   -- for i, items in ipairs(config.Runes) do
      -- local it = items
      -- if it.runeID == item.itemid then
         -- if player:getStorageValue(runesStorage - 1 + i) > os.time() then
            -- local message = string.format("You still need to wait: %s", timeLeft(player:getStorageValue(runesStorage -1 + i) - os.time(), true))
            -- player:sendCancelMessage(message)
            -- player:sendMagicEffect(CONST_ME_POFF)
            -- return true
         -- end
         -- if it.manaMax then
		    -- local value = math.random(it.
            -- doTargetCombat(player, target, COMBAT_MANADRAIN, it.manaMin, it.manaMax)
         -- end
         -- if it.healthMax then
            -- doTargetCombat(player, target, COMBAT_HEALING, it.healthMin, healthMax)
         -- end
         -- player:sendMagicEffect(it.effect)
         -- player:setStorageValue(runesStorage - 1 + i, os.time() + config.Cooldown)
         -- item:remove(1)
         -- break
      -- end
   -- end
   
   
   -- return true
-- end

for _, items in pairs(config.Runes) do
   action:id(items.runeID)
end
action:register()
