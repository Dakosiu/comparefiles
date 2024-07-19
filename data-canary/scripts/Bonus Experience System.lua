-- ALTER TABLE  `players` ADD  `points` DOUBLE NOT NULL DEFAULT  '0'


-- BONUS_EXPERIENCE_SYSTEM = {}

-- function BONUS_EXPERIENCE_SYSTEM:getBonus(player)
   -- if not player then
      -- return 0
   -- end
   
   -- local guid = player:getGuid()
   -- local resultx = db.storeQuery("SELECT `experience_bonus` FROM `players` WHERE `id` = " .. guid)
   -- if resultx ~= false then
      -- --local value = result.getDataInt(resultx, "experience_bonus")
	  -- local value = result.getNumber(resultx, "experience_bonus")
	  -- result.free(resultx)
      -- return value
   -- end
   
   -- return 0
-- end

-- function BONUS_EXPERIENCE_SYSTEM:addBonus(player, value)
    
	-- if not player or not value then
	   -- return
	-- end
	-- local guid = player:getGuid()
	-- local bonus = BONUS_EXPERIENCE_SYSTEM:getBonus(player)
	-- return db.query("UPDATE `players` SET `experience_bonus` = " .. bonus + value .. " WHERE `id` = " .. guid)
-- end
    
	
    