-- -- CREATE TABLE `player_familiars` (
-- -- `id` int(11) NOT NULL AUTO_INCREMENT,
-- -- `player_id` int(11) NOT NULL,
-- -- `name` varchar(30) NOT NULL,
-- -- `real_name` varchar(30) NOT NULL,
-- -- `looktype` int(11) NOT NULL,
-- -- `experience` bigint(20) NOT NULL,
-- -- `level` int(11) NOT NULL,
-- -- `stamina` bigint(20) NOT NULL,
-- -- `points` int(11) NOT NULL,
-- -- `increase_damage_points` int(11) NOT NULL,
-- -- `resist_damage_points` int(11) NOT NULL,
-- -- `healing_points` int(11) NOT NULL,
-- -- `health_points` int(11) NOT NULL,
-- -- `current_health` int(11) NOT NULL,
-- -- `max_health` int(11) NOT NULL,
-- -- `alive` int(11) NOT NULL,
-- -- PRIMARY KEY (`id`)
-- -- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- if not FAMILIAR_SYSTEM then
   -- FAMILIAR_SYSTEM = {}
-- end

-- Familiar = {
             -- id = -1,
			 -- player_id = -1,
			 -- master_id = -1,
			 -- cid = -1,
			 -- name = "",
			 -- real_name = "",
			 -- level = 0,
			 -- experience = 0,
			 -- stamina = 100,
			 -- points = 0,
			 -- increase_damage_points = 0,
			 -- resist_damage_points = 0,
			 -- healing_points = 0,
			 -- health_points = 0,
			 -- lookType = 0,
			 -- currentHealth = 0,
			 -- maxHealth = 0,
			 -- alive = 1,
		   -- }

-- FAMILIAR_SYSTEM.looktypes = { 
                             -- [991] = "Knight Familiar",
                             -- [1365] = "Snowbash Familiar",
					         -- [992] = "Paladin Familiar",
					         -- [1366] = "Sandscourge Familiar",
					         -- [993] = "Druid Familiar",
					         -- [1364] = "Mossmasher Familiar",
					         -- [994] = "Sorcerer Familiar",
					         -- [1367] = "Bladespark Familiar",
                            -- }

-- FAMILIAR_SYSTEM.experienceTable = {
                                    -- [1] = 50,
									-- [2] = 200,
									-- [3] = 400,
									-- [4] = 600,
									-- [5] = 800,
									-- [6] = 1000,
									-- [7] = 1200,
									-- [8] = 1300,
									-- [9] = 1600,
									-- [10] = 2000,
								  -- }

-- FAMILIAR_SYSTEM.abilities = {
							  -- increaseDamage = 0.01, --- 1% większy dmg co każdy punkt
							  -- increaseResistDamage = 0.01, --- 1% wieksza obrona co każdy punkt
							  -- increaseHealing = 0.01, --- 1% każdy punkt
							  -- addHealth = 10 -- 10 hp co każdy punkt.
							-- }

-- FAMILIAR_SYSTEM.stamina = {
                            -- ratio = { value = 20, type = "seconds" },
							-- recoveryItems = {
							                  -- [3029] = {
											             -- recoveryPoints = 10,
													   -- },
											-- }
						  -- }
-- FAMILIAR_SYSTEM.revive = {
                           -- ["Required"] = { 
						                    -- { type = "money", value = 900000 } 
										  -- }
						 -- }
							
-- -- FAMILIAR_SYSTEM.storages = {
                             -- -- isFamiliar = 444,
						   -- -- }

-- if not FAMILIAR_SYSTEM.database then
   -- FAMILIAR_SYSTEM.database = {}
-- end

-- if not FAMILIARS then
   -- FAMILIARS = {}
-- end

-- if not PLAYER_FAMILIARS then
   -- PLAYER_FAMILIARS = {}
-- end

-- if not FAMILIAR_SELECTED then
   -- FAMILIAR_SELECTED = {}
-- end

-- if not FAMILIAR_ABILITIES then
   -- FAMILIAR_ABILITIES = {}
-- end

-- function Familiar:new(o)
	-- o = o or {}
	-- setmetatable(o, self)
	-- self.__index = self
	-- return o
-- end

-- function Familiar:getOwnerId()
	-- return self.player_id
-- end

-- function Familiar:getCreature()
   -- local id = self.cid
   -- local creature = Creature(id)
   -- if creature then
      -- return creature
   -- end
   -- return false
-- end

-- function Familiar:getMasterId()
    -- return self.master_id
-- end

-- function Familiar:getMaster()

    -- local master = nil
	-- master = Player(self:getMasterId())
	-- if master then
	   -- return master
	-- end
	-- local guid = self:getOwnerId()
	-- master = Player(FAMILIAR_SYSTEM:getPlayerByGuid(guid))
	-- if master then
	   -- return master
	-- end
	-- return false
-- end

-- function Familiar:getId()
	-- return self.cid
-- end

-- function Familiar:getCid()
  -- return self.cid
-- end

-- function Familiar:getName()
    -- if self.name == "" then
	   -- return self.real_name
	-- end
	-- return self.name
-- end

-- function Familiar:setName(value)
    -- self.name = value
	-- local creature = self:getCreature()
	-- if creature then
	   -- local level = self:getLevel()
	   -- local name = self:getName()
	   -- creature:setName("[" .. level .. "] " .. name)
	-- end
	-- self:save()
-- end

-- function Familiar:getRealName()
    -- return self.real_name
-- end

-- function Familiar:getLevel()
    -- return self.level
-- end

-- function Familiar:getExperience()
    -- return self.experience
-- end

-- function Familiar:getMaxExperience()
   
    -- local level = self:getLevel()

	-- local level = self:getLevel()
	-- if level >= #FAMILIAR_SYSTEM.experienceTable then
	   -- return FAMILIAR_SYSTEM.experienceTable[#FAMILIAR_SYSTEM.experienceTable]
	-- end
	
	-- return FAMILIAR_SYSTEM.experienceTable[level + 1]
-- end
	
-- function Familiar:getExperienceToNextLevel()
    
	-- local level = self:getLevel()
	-- if level >= #FAMILIAR_SYSTEM.experienceTable then
	   -- return 0
	-- end
	
	-- local requiredExperience = FAMILIAR_SYSTEM.experienceTable[level + 1]
	-- local experience = self:getExperience()
	
	-- if requiredExperience <= experience then
	   -- return 0
	-- end
	-- return requiredExperience - experience
-- end
	   
-- function Familiar:isAlive()
    -- return self.alive
-- end

-- function Familiar:setAlive(boolean)
   
   -- if boolean then
      -- self.alive = 1
	  -- return
   -- end
   
   -- self.currentHealth = 0
   -- self.alive = 0
   -- local summon = self:getCreature()
   -- if summon then
      -- summon:getPosition():sendMagicEffect(CONST_ME_POFF)
      -- summon:remove()
	  -- self:sendMessage(MESSAGE_STATUS_CONSOLE_RED, "Your summon is dead.")
   -- end
   -- self:save()
-- end

-- function Familiar:getlookType()
    -- return self.lookType
-- end

-- function Familiar:getPoints(type)
    
	-- if not type then
	   -- return self.points
	-- end
	
	-- if type == "increase damage" then
	   -- return self.increase_damage_points
	-- elseif type == "resist damage" then
	   -- return self.resist_damage_points
	-- elseif type == "healing" then
	   -- return self.healing_points
	-- elseif type == "health" then
	   -- return self.health_points
	-- end
-- end

-- function Familiar:addPoints(type, value, loop)
    
	-- if not type then
	   -- self.points = self.points + 1
	   -- return
	-- end
	
	-- if not value then
	   -- value = 1
	-- end
	
	-- local points = self.points
	-- if points < value then
	   -- local id = self:getOwnerId()
	   -- local owner = Player(id)
	   -- if owner then
	      -- local text = "Familiar dont have enough points."
	      -- return owner:popupFYI(text)
	   -- end
	   -- return
	-- end

	-- if type == "increase damage" then
	   -- self.increase_damage_points = self.increase_damage_points + value
	   -- self.points = self.points - value
	   -- self:sendMagicEffect(CONST_ME_MAGIC_GREEN)
	   -- self:sendMessage(MESSAGE_INFO_DESCR, "Successfully added 1 point to increase damage.")
	   -- self:save()
	   -- return
	-- elseif type == "resist damage" then
	   -- self.resist_damage_points = self.resist_damage_points + value
	   -- self.points = self.points - value
	   -- self:sendMagicEffect(CONST_ME_MAGIC_GREEN)
	   -- self:sendMessage(MESSAGE_INFO_DESCR, "Successfully added 1 point to increase resist damage.")
	   -- self:save()
	   -- return
	-- elseif type == "healing" then
	   -- self.healing_points = self.healing_points + value
	   -- self.points = self.points - value
	   -- self:sendMagicEffect(CONST_ME_MAGIC_GREEN)
	   -- self:sendMessage(MESSAGE_INFO_DESCR, "Successfully added 1 point to increase healing.")
	   -- self:save()
	   -- return
	-- elseif type == "health" then
	   -- self.health_points = self.health_points + value
	   -- self.points = self.points - value
	   -- local ratio = FAMILIAR_SYSTEM.abilities.addHealth * value
	   -- self:setMaxHealth(self:getMaxHealth() + ratio)
	   -- self:updateHealth()
	   -- self:sendMagicEffect(CONST_ME_MAGIC_GREEN)
	   -- self:sendMessage(MESSAGE_INFO_DESCR, "Successfully added 1 point to increase health.")
	   -- self:save()
	   -- return
	-- end
-- end

-- function Familiar:getAbilityRatio(type)
	-- if not type then
	   -- return 0
	-- end
	
	-- if type == "increase damage" then
	   -- return self.increase_damage_points * FAMILIAR_SYSTEM.abilities.increaseDamage
	-- elseif type == "resist damage" then
	   -- return self.resist_damage_points * FAMILIAR_SYSTEM.abilities.increaseResistDamage
	-- elseif type == "healing" then
	   -- return self.healing_points * FAMILIAR_SYSTEM.abilities.increaseHealing
	-- elseif type == "health" then
	   -- return self.health_points * FAMILIAR_SYSTEM.abilities.addHealth
	-- end
-- end

-- function Familiar:getHealth()
   -- return self.currentHealth
-- end

-- function Familiar:getMaxHealth()
   -- return self.maxHealth
-- end

-- function Familiar:setHealth(value)
   -- self.currentHealth = value
   -- self:save()
-- end

-- function Familiar:setMaxHealth(value)
   -- self.maxHealth = value
   -- self:save()
-- end

-- function Familiar:updateHealth(value)
   -- local creature = self:getCreature()
   -- if creature then
      -- creature:setMaxHealth(self:getMaxHealth())
   -- end
-- end

-- function Familiar:sendMagicEffect(id)
	-- local creature = self:getCreature()
	-- if not creature then
	   -- return
	-- end
	-- local pos = creature:getPosition()
	-- return pos:sendMagicEffect(id)
-- end

-- function Familiar:save()
    
	-- if not FAMILIAR_SYSTEM.database:getFamiliar(self) then
	   -- return
	-- end

	-- local sql = "UPDATE `player_familiars` SET"
	-- --sql = sql .. " `player_id`=" .. self:getOwnerId()
	-- sql = sql .. " `name`=" .. db.escapeString(self:getName()) 
	-- sql = sql .. ", `real_name`=" .. db.escapeString(self:getRealName()) 
	-- --sql = sql .. " `looktype`=" .. tonumber(self:getlookType())
	-- sql = sql .. ", `experience`=" .. tonumber(self:getExperience())
	-- sql = sql .. ", `level`=" .. tonumber(self:getLevel())
	-- sql = sql .. ", `stamina`=" .. tonumber(self:getStaminaPoints())
	-- sql = sql .. ", `points`=" .. tonumber(self:getPoints())
	-- sql = sql .. ", `increase_damage_points`=" .. tonumber(self:getPoints("increase damage"))
	-- sql = sql .. ", `resist_damage_points`=" .. tonumber(self:getPoints("resist damage"))
	-- sql = sql .. ", `healing_points`=" .. tonumber(self:getPoints("healing"))
	-- sql = sql .. ", `health_points`=" .. tonumber(self:getPoints("health"))
	-- sql = sql .. ", `current_health`=" .. tonumber(self:getHealth())
	-- sql = sql .. ", `max_health`=" .. tonumber(self:getMaxHealth())
	-- sql = sql .. ", `alive`=" .. tonumber(self:isAlive())
	-- sql = sql .. " WHERE `player_id`=" .. tonumber(self:getOwnerId()) .. " AND " .. "`looktype`=" .. tonumber(self:getlookType())

	-- db.query(sql)
-- end

-- function Familiar:addLevel(_shouldSave)
    
	-- local max_experience = FAMILIAR_SYSTEM.experienceTable[#FAMILIAR_SYSTEM.experienceTable]
	-- local max_level = #FAMILIAR_SYSTEM.experienceTable
	
	-- if self:getLevel() >= max_level then
	   -- if self:getExperience() > max_experience then
	      -- self.experience = max_experience
		  -- self:save()
		  -- return
	   -- end
	   -- return
	-- end

	-- local currentExperience = self:getExperience()
	-- local needExperience = FAMILIAR_SYSTEM.experienceTable[self:getLevel() +1]
	-- if self:getExperience() < needExperience then
	   -- self.experience = needExperience
	-- end
	
	-- local oldLevel = self:getLevel()
	-- self.level = self.level + 1
	

	
	-- self:sendMessage(MESSAGE_INFO_DESCR, "Your familiar advanced from " .. oldLevel .. " level to " .. self.level .. " level.")
	-- if self:getLevel() >= max_level then
	   -- self:sendMessage(MESSAGE_INFO_DESCR, "Congratulations! Your familiar reached max level.")
	-- end	
	
	-- local creature = self:getCreature()
	-- if creature then
	   -- local level = self:getLevel()
	   -- local name = self:getName()
	   -- creature:setName("[" .. level .. "] " .. name)
	-- end
	   
	-- self:addPoints()
	-- if _shouldSave then
	   -- self:save()
	-- end
	
-- end

-- function Familiar:updateLevel()		
	-- for i, v in pairs(FAMILIAR_SYSTEM.experienceTable) do
	    -- local requiredExperience = FAMILIAR_SYSTEM.experienceTable[i]
		-- if self:getLevel() < i then
		   -- if self:getExperience() >= requiredExperience then
		      -- self:addLevel(false)
		   -- end
		-- end
	-- end
	-- self:save()
-- end
	    
-- function Familiar:sendMessage(type, string)
    
	-- local master = self:getMaster()
	-- if master then
	   -- return master:sendTextMessage(type, string)
	-- end
-- end

-- function Familiar:addExperience(value)
    
	-- local max_experience = FAMILIAR_SYSTEM.experienceTable[#FAMILIAR_SYSTEM.experienceTable]
	-- local max_level = #FAMILIAR_SYSTEM.experienceTable
	-- local required_experience = self:getExperienceToNextLevel()
		
	-- if self:getExperience() >= max_experience then
       -- return
    -- end
    
    -- if self:getLevel() >= max_level then
       -- return
    -- end
    
    -- if self:getLevel() >= max_level - 1 then
       -- if value > required_experience then	
	      -- value = required_experience
	   -- end
	-- end

	-- self.experience = self.experience + value
	
	-- local master = self:getMaster()
	-- local summon = self:getCreature()
	-- if master then
	   -- if summon then
	      -- color = TEXTCOLOR_WHITE_EXP
	      -- pos = summon:getPosition()
	      -- master:sendTextMessage(MESSAGE_EXPERIENCE_OTHERS, "Your familiar gained " .. value .. " experience.", pos, value, color, value, color)
	   -- else
	      -- master:sendTextMessage(MESSAGE_EXPERIENCE_OTHERS, "Your familiar gained " .. value .. " experience.")
	   -- end
	-- end
	
	-- self:updateLevel()
-- end

-- function Familiar:getStaminaPoints()   
   -- return self.stamina
-- end

-- function Familiar:removeStaminaPoints(value)
   
   -- if not value then
      -- value = 1
   -- end
      
   -- self.stamina = self.stamina - value
   -- self:save()
-- end

-- function Familiar:addStaminaPoints(value)
   
   -- if not value then
      -- value = 1
   -- end
   
   -- if self:getStaminaPoints() >= 100 then
	  -- return false
   -- end
      
   -- self.stamina = self.stamina + value
   -- self:save()
   -- return true
-- end

-- function Familiar:setDecay()

   -- local delay = 1000 * FAMILIAR_SYSTEM:getStaminaRatio()
   -- local function decay(familiar)
	  -- local _stop = false
      -- local cid = familiar:getCid()
      -- local summon = familiar:getCreature()
      -- if not summon then
         -- return false
      -- end
      
	  -- if familiar:getStaminaPoints() <= 0 then
	     -- if familiar:isAlive() == 1 then
		    -- familiar:setAlive(false)
			-- familiar:sendMessage(MESSAGE_STATUS_WARNING, "Your familiar was hungry, lost his power and died. You have to revive him.")
	        -- _stop = true
		 -- end
	  -- end
	  -- familiar:removeStaminaPoints(1)
	  -- if not _stop then
         -- addEvent(decay, delay, familiar)
	  -- end
    -- end

   -- addEvent(decay, delay, self)
-- end
   
-- function Player.addNewFamiliar(self, looktype)
    
	-- local familiar = Familiar:new()
	-- local id = self:getGuid()
	-- familiar.lookType = looktype
	-- familiar.player_id = id
	
	-- local name = FAMILIAR_SYSTEM.looktypes[looktype]
	-- local monstertype = MonsterType(name)
	-- local health = monstertype:maxHealth()
	
	-- familiar.currentHealth = health
	-- familiar.maxHealth = health
	
	-- if FAMILIAR_SYSTEM.database:getFamiliar(familiar) then
	   -- return
	-- end
	
	-- local name = FAMILIAR_SYSTEM.looktypes[looktype]
	-- if not name then
	   -- return
	-- end
	-- familiar.real_name = name
	
	-- if not PLAYER_FAMILIARS[id] then
	   -- PLAYER_FAMILIARS[id] = {}
	-- end
	
	-- table.insert(PLAYER_FAMILIARS[id], familiar)
	-- table.insert(FAMILIARS, familiar)
	-- FAMILIAR_SYSTEM.database:addFamiliar(familiar)
-- end

-- function getFamiliarByLooktype(player, looktype)
    
	-- if not looktype then
	   -- looktype = player:getFamiliarLooktype()
	-- end
	
	-- local familiar = nil
	-- local id = player:getGuid()
	
	-- for i = 1, #FAMILIARS do
		-- familiar = FAMILIARS[i]
		-- if familiar:getOwnerId() == id and familiar:getlookType() == looktype then
			-- return familiar
		-- end
	-- end
	-- return nil
-- end

-- function Player.addFamiliar(self, looktype)
	-- self:addFamiliar2(looktype)
	-- self:addNewFamiliar(looktype)
	-- return true
-- end

-- function Player.getFamiliarVocation(self)

  -- if not self then
  -- return
  -- end
  
  -- local t = nil
  -- local str = self:getVocation():getName():lower()
  -- local voc = nil
  
  -- if string.find(str, "knight") then
     -- voc = "knight"
  -- elseif string.find(str, "paladin") then
     -- voc = "paladin"
  -- elseif string.find(str, "druid") then
     -- voc = "druid"
  -- elseif string.find(str, "sorcerer") then
     -- voc = "sorcerer"
  -- end
  
  -- return voc or false
-- end

-- function Monster.isFamiliar(self)
    
	-- local name = self:getRealName()
	-- local monstertype = MonsterType(name)
	-- if not monstertype then
	   -- return false
	-- end
	
	-- if monstertype:familiar() then
	   -- return true
	-- end
	-- return false
-- end

-- function FAMILIAR_SYSTEM:getFamiliar(player)
    -- if not player then
	   -- return false
	-- end
	
	-- for index, summon in ipairs(player:getSummons()) do
        -- if summon then
		   -- if summon:isFamiliar() then
              -- return summon
           -- end
        -- end
    -- end
	
	-- return false
-- end

-- function FAMILIAR_SYSTEM:getFamiliarLooktype(owner)
   
    -- if not owner then
       -- return false
	-- end
	
	-- local summon = FAMILIAR_SYSTEM:getFamiliar(owner)
	-- if not summon then
	   -- return owner:getFamiliarLooktype()
	-- end
	-- return summon:getOutfit().lookType
-- end	
    
-- function FAMILIAR_SYSTEM.database:getFamiliar(familiar)
    
	-- if not familiar then
	   -- return nil
	-- end
	
	-- local guid = familiar:getOwnerId()
	-- local looktype = familiar:getlookType()
	
	-- local resultx = db.storeQuery("SELECT `player_id` FROM `player_familiars` WHERE `player_id` = " .. guid .. " AND `looktype` = " .. looktype)
	-- if resultx then
	   -- result.free(resultx)
	   -- return true
	-- end
	-- result.free(resultx)
	-- return false
-- end

-- function FAMILIAR_SYSTEM.database:addFamiliar(familiar)

	-- if not familiar then
	   -- return
	-- end
	
	-- if FAMILIAR_SYSTEM.database:getFamiliar(familiar) then
	   -- return
	-- end
	
	-- local player_id = familiar:getOwnerId()
	-- local name = familiar:getName()
	-- local real_name = familiar:getRealName()
	-- local looktype = familiar:getlookType()
	-- local experience = familiar:getExperience()
	-- local level = familiar:getLevel()
	-- local stamina = familiar:getStaminaPoints()
	-- local points = familiar:getPoints()
	-- local damage_points = familiar:getPoints("increase damage")
	-- local resist_points = familiar:getPoints("resist damage")
	-- local healing_points = familiar:getPoints("healing")
	-- local health_points = familiar:getPoints("health")
	-- local current_health = familiar:getHealth()
	-- local max_health = familiar:getMaxHealth()
	-- local alive = familiar:isAlive()

	-- return db.query("INSERT INTO `player_familiars` (`player_id`, `name`, `real_name`, `looktype`, `experience`, `level`, `stamina`, `points`, `increase_damage_points`, `resist_damage_points`, `healing_points`, `health_points`, `current_health`, `max_health`, `alive`) VALUES " .. "(" .. player_id .. ", " .. db.escapeString(name) .. ", " .. db.escapeString(real_name) .. ", " .. looktype .. ", " .. experience .. ", " .. level .. ", " .. stamina .. ", " .. points .. ", " .. damage_points .. ", " .. resist_points .. ", " .. healing_points .. ", " .. health_points .. ", " .. current_health .. ", " .. max_health .. ", " .. alive ..")" .. ";")
-- end	

-- function FAMILIAR_SYSTEM:createFamiliar(player, pos)
    
	-- if not player then
	   -- return nil
	-- end
	
	-- if FAMILIAR_SYSTEM:getFamiliar(player) then
	   -- return
	-- end
	
	-- local looktype = player:getFamiliarLooktype()
	-- local familiar = getFamiliarByLooktype(player, looktype)
	-- if not familiar then
	   -- return
	-- end
	
	-- if familiar:isAlive() == 0 then
	   -- familiar:sendMessage(MESSAGE_STATUS_DEFAULT, "Your familiar is dead, you have to revive him.")
	   -- return
	-- end
	
	-- local name = familiar:getName()
	-- local level = familiar:getLevel()
    -- local summon = nil
	-- if pos then
	   -- summon = Game.createMonsterCustom(name, "[" .. level .. "] " .. name, pos, true, false)
	-- else
	   -- summon = Game.createMonsterCustom(name, "[" .. level .. "] " .. name, player:getPosition(), true, false)
	-- end
	
	-- if summon then
	   -- --summon:setStorageValue(FAMILIAR_SYSTEM.storages.isFamiliar, 1)
	   -- summon:setOutfit({lookType = player:getFamiliarLooktype()})
	   -- summon:registerEvent("FAMILIAR_SYSTEM_onHealthChange")
	   -- player:addSummon(summon)
	   -- familiar.cid = summon:getId()
	   -- familiar.master_id = player:getId()
	   -- local health_ratio = familiar:getAbilityRatio("health")
	   -- if health_ratio > 0 then
	      -- summon:setMaxHealth(summon:getMaxHealth() + health_ratio)
	   -- end
	   
	   -- local currentHealth = familiar.currentHealth
	   -- if currentHealth > 0 then
	      -- summon:setHealth(currentHealth)
	   -- else 
	      -- if health_ratio > 0 then
		     -- summon:addHealth(summon:getMaxHealth())
			 -- familiar:setHealth(summon:getHealth())
		  -- end
	   -- end
	   -- familiar:setMaxHealth(summon:getMaxHealth())
	   -- familiar:setDecay()
	   -- return summon
	-- end
	
	-- return false
-- end

-- function FAMILIAR_SYSTEM:init()

    -- for i, v in pairs(FAMILIAR_SYSTEM.abilities) do
	   -- local name = i:lower()
	   -- local values = { name, v }
       -- table.insert(FAMILIAR_ABILITIES, values)
    -- end
	
	-- local rows = db.storeQuery("SELECT * FROM `player_familiars`")
	-- if rows then
		-- repeat
			-- local player_id = result.getNumber(rows, "player_id")

			-- if not PLAYER_FAMILIARS[player_id] then
				-- PLAYER_FAMILIARS[player_id] = {}
			-- end

			-- local familiar = Familiar:new()
			-- familiar.player_id = player_id
			-- familiar.name = result.getString(rows, "name")
			-- familiar.real_name = result.getString(rows, "real_name")
			-- familiar.lookType = result.getNumber(rows, "looktype")
			-- familiar.level = result.getNumber(rows, "level")
			-- familiar.experience = result.getNumber(rows, "experience")
			-- familiar.stamina = result.getNumber(rows, "stamina")
			-- familiar.points = result.getNumber(rows, "points")
			-- familiar.increase_damage_points = result.getNumber(rows, "increase_damage_points")
			-- familiar.resist_damage_points = result.getNumber(rows, "resist_damage_points")
			-- familiar.healing_points = result.getNumber(rows, "healing_points")
			-- familiar.health_points = result.getNumber(rows, "health_points")
			-- familiar.currentHealth = result.getNumber(rows, "current_health")
			-- familiar.maxHealth = result.getNumber(rows, "max_health")
			-- familiar.alive = result.getNumber(rows, "alive")
			-- table.insert(PLAYER_FAMILIARS[player_id], familiar)
			-- table.insert(FAMILIARS, familiar)
		-- until not result.next(rows)
		-- result.free(rows)
	-- end
-- end

-- function FAMILIAR_SYSTEM:getPlayerByGuid(guid)
	-- for _, player in ipairs(Game.getPlayers()) do
		-- if player:getGuid() == guid then
			-- return player:getId()
		-- end
	-- end
	-- return nil
-- end

-- function FAMILIAR_SYSTEM:getStaminaRatio()
    
	-- local duration = FAMILIAR_SYSTEM.stamina.ratio.value
	-- local method =  FAMILIAR_SYSTEM.stamina.ratio.type
	
	-- local interval = 0
	
	-- if string.find(method, "second") then
	   -- interval = duration
	-- elseif string.find(method, "minute") then
	   -- interval = duration * 60
	-- elseif string.find(method, "hour") then 
	   -- interval = duration * 60 * 60
	-- end
	
	-- return interval
-- end

-- function FAMILIAR_SYSTEM:modalWindow(player, value, summon)
    -- if not player then
	   -- return nil
	-- end
	
	-- local id = player:getGuid()
	-- if not PLAYER_FAMILIARS[id] then
	   -- return player:sendCancelMessage("You dont have any familiar yet.")
	-- end
		
	-- if value == 1 then
	   -- player:registerEvent("FAMILIAR_SYSTEM_onModalWindow")
	   -- local title = "Familiar Manager"
	   -- local message = "Select your familiar: "
	   -- local window = ModalWindow(30 + value, title, message)
	   -- window:addButton(100, "Select") 
       -- window:addButton(101, "Cancel")
       -- window:setDefaultEnterButton(100)	  
       -- window:setDefaultEscapeButton(101)
	   -- for i, familiar in pairs(PLAYER_FAMILIARS[id]) do
	      -- local real_name = familiar:getRealName()
		  -- local level = familiar:getLevel()
		  -- window:addChoice(i, "[" .. level .. "] " .. real_name)
       -- end
	   -- return window:sendToPlayer(player)
	-- end

	-- if value == 2 then
	   -- player:registerEvent("FAMILIAR_SYSTEM_onModalWindow")
	   -- local title = "Familiar Manager"
	   
	   -- local familiar = summon
	   -- if not familiar then
	      -- return
	   -- end
	   
	   -- local level = familiar:getLevel()
	   -- local experience = familiar:getExperience()
	   -- local max_experience = familiar:getMaxExperience()
	   -- local required_experience = familiar:getExperienceToNextLevel()
	   -- local increase_damage_ratio = familiar:getAbilityRatio("increase damage") * 100
	   -- local increase_resist_ratio = familiar:getAbilityRatio("resist damage") * 100
	   -- local increase_healing = familiar:getAbilityRatio("healing") * 100
	   -- local health = familiar:getAbilityRatio("health")
	   -- local currentHealth = familiar:getHealth()
	   -- local maxHealth = familiar:getMaxHealth()
	   -- local points = familiar:getPoints()
	   -- local max_points = #FAMILIAR_SYSTEM.experienceTable
	   -- local alive = familiar:isAlive()
	   -- local message = "-----------------------------------                                        " .. "\n"
	   -- message = message .. "Informations about familiar: " .. "\n"
	   -- message = message .. "-----------------------------------                                        " .. "\n"
	   -- message = message .. "Level: " .. level .. "\n"
	   -- message = message .. "Experience: " .. experience .. "/" .. max_experience .. "\n"
	   -- message = message .. "Health: " .. currentHealth .. "/" .. maxHealth .. "\n"
	   -- if alive == 1 then
	      -- message = message .. "Status: " .. "Alive" .. "\n"
	   -- else
	      -- message = message .. "Status: " .. "Dead" .. "\n"
	   -- end
	   -- --message = message .. "Experience to next level: " .. required_experience .. "\n"
	   -- message = message .. "-----------------------------------                                        " .. "\n"
	   -- message = message .. "Increase Damage by: " .. increase_damage_ratio .. "%" .. "\n"
	   -- message = message .. "-----------------------------------                                        " .. "\n"
       -- message = message .. "Increase Resist Damage by: " .. increase_resist_ratio .. "%" .. "\n"
	   -- message = message .. "-----------------------------------                                        " .. "\n"
	   -- message = message .. "Increase Healing by: " .. increase_healing .. "%" .. "\n"
	   -- message = message .. "-----------------------------------                                        " .. "\n"
	   -- message = message .. "Increase Health by: " .. health .. " hitpoints" .. "\n"
	   -- message = message .. "-----------------------------------                                        " .. "\n"
	   -- message = message .. "You have " .. points .. " points left to add."
	   -- local window = ModalWindow(1600 + value, title, message)
	   -- window:addButton(100, "Ability")
	   -- window:addButton(101, "Back") 
	   -- window:addButton(102, "Cancel") 
       -- window:setDefaultEnterButton(100)	  
       -- window:setDefaultEscapeButton(101)
	   -- return window:sendToPlayer(player)
	-- end
	-- if value == 3 then
	   -- player:registerEvent("FAMILIAR_SYSTEM_onModalWindow")
	   -- local familiar = summon
	   -- if not familiar then
	      -- return
	   -- end
	   -- local increase_damage_ratio = FAMILIAR_SYSTEM.abilities.increaseDamage * 100
	   -- local resist_damage_ratio = FAMILIAR_SYSTEM.abilities.increaseResistDamage * 100
	   -- local healing_ratio = FAMILIAR_SYSTEM.abilities.increaseHealing * 100
	   -- local health = FAMILIAR_SYSTEM.abilities.addHealth
	   -- local points = familiar:getPoints()
	   -- local title = "Familiar Manager"
	   -- local message = "-----------------------------------                                        " .. "\n"
	   -- message = message .. "Informations about abilities: " .. "\n"
       -- message = message .. "-----------------------------------                                        " .. "\n"
	   -- message = message .. "Increase Damage: " .. "\n" .. "1 point give " .. increase_damage_ratio .. "% more damage." .. "\n"
	   -- message = message .. "-----------------------------------                                        " .. "\n"
	   -- message = message .. "Resist Damage: " .. "\n" .. "1 point give " .. resist_damage_ratio .. "% more defense." .. "\n"
	   -- message = message .. "-----------------------------------                                        " .. "\n"
	   -- message = message .. "Increase Healing: " .. "\n" .. "1 point give " .. healing_ratio .. "% more healing." .. "\n"
	   -- message = message .. "-----------------------------------                                        " .. "\n"	
	   -- message = message .. "Increase Health: " .. "\n" .. "1 point give " .. health .. " hitpoints." .. "\n"
	   -- message = message .. "-----------------------------------                                        " .. "\n"		   
	   -- message = message .. "You have " .. points .. " points left to add."
	   -- local window = ModalWindow(1600 + value, title, message)
	   -- window:addChoice(1, "Increase Damage")
	   -- window:addChoice(2, "Increase Resist Damage")
	   -- window:addChoice(3, "Increase Healing")
	   -- window:addChoice(4, "Increase Health")
	   -- window:addButton(101, "1 Point")
	   -- window:addButton(102, "3 Point")
	   -- window:addButton(103, "5 Point")
	   -- window:addButton(104, "Back") 
       -- --window:setDefaultEnterButton(100)	  
       -- window:setDefaultEscapeButton(104)	   
	   -- return window:sendToPlayer(player)
	-- end
	   
	
	
-- end

-- function FAMILIAR_SYSTEM:storeExperience(familiar, target, value)
    
	-- if not familiar or not target or not value then
	   -- return nil
	-- end
	
	-- if not FAMILIAR_SYSTEM.storeExperienceTable then
	   -- FAMILIAR_SYSTEM.storeExperienceTable = {}
	-- end
	
	-- local cid = familiar:getCid()
	-- if not FAMILIAR_SYSTEM.storeExperienceTable[cid] then
	   -- FAMILIAR_SYSTEM.storeExperienceTable[cid] = {}
	-- end
	
	-- if not FAMILIAR_SYSTEM.storeExperienceTable[cid][target:getId()] then
	   -- FAMILIAR_SYSTEM.storeExperienceTable[cid][target:getId()] = 0
	-- end
	
	-- local maxValue = target:getMaxHealth()
	-- if value >= maxValue then
	   -- FAMILIAR_SYSTEM.storeExperienceTable[cid][target:getId()] = maxValue
	   -- return
	-- end
	
	-- local t = FAMILIAR_SYSTEM.storeExperienceTable[cid][target:getId()]
	-- if t >= maxValue then
	   -- FAMILIAR_SYSTEM.storeExperienceTable[cid][target:getId()] = maxValue
	   -- return
	-- end
	
	-- if t + value >= maxValue then
	   -- FAMILIAR_SYSTEM.storeExperienceTable[cid][target:getId()] = maxValue
	   -- return
	-- end
	-- FAMILIAR_SYSTEM.storeExperienceTable[cid][target:getId()] = FAMILIAR_SYSTEM.storeExperienceTable[cid][target:getId()] + value
-- end

-- function FAMILIAR_SYSTEM:getExperience(familiar, target)

	-- if not familiar or not target then
	   -- return 0
	-- end
	
	-- local storeExperience = FAMILIAR_SYSTEM.storeExperienceTable
	-- if not storeExperience then
	   -- return 0
	-- end	
	-- local cid = familiar:getCid()
	-- if not storeExperience[cid] then
	   -- return 0
	-- end
	-- local experience = storeExperience[cid][target:getId()]
	-- if not experience then
	   -- return 0
	-- end
	-- return experience
-- end
	
	
	
-- local globalevent = GlobalEvent("FAMILIAR_SYSTEM_onStartUp")
-- function globalevent.onStartup()
	-- FAMILIAR_SYSTEM:init()
	-- return true
-- end
-- globalevent:register()

-- local talkaction = TalkAction("/fam")
-- function talkaction.onSay(player, words, param)	
    
	-- if param == "level" then
	   -- local looktype = FAMILIAR_SYSTEM:getFamiliarLooktype(player)
	   -- if looktype then
	      -- local familiar = getFamiliarByLooktype(player, looktype)
	      -- familiar:addLevel()
	   -- end
	   -- return false
	-- end
	
	-- if param == "exp" then
	   -- local looktype = FAMILIAR_SYSTEM:getFamiliarLooktype(player)
	   -- if looktype then
	      -- local familiar = getFamiliarByLooktype(player, looktype)
	      -- familiar:addExperience(1457)
	   -- end
	   -- return false
	-- end	
	
	-- if param == "get" then
	   -- FAMILIAR_SYSTEM:modalWindow(player, 1)
	   -- return false
	-- end
	
	-- if param == "name" then
	   -- local looktype = FAMILIAR_SYSTEM:getFamiliarLooktype(player)
	   -- if looktype then
	      -- local familiar = getFamiliarByLooktype(player, looktype)
	      -- if familiar then
		     -- local summon = familiar:getCreature()
			 -- if summon then
			    -- summon:setName("Tescik")
		     -- end
		   -- end
	   -- end
	   -- return false
    -- end	   
	
	-- if param == "dead" then
	   -- local looktype = FAMILIAR_SYSTEM:getFamiliarLooktype(player)
	   -- if looktype then
		  -- local familiar = getFamiliarByLooktype(player, looktype)
	      -- if familiar then
		     -- familiar:setAlive(false)
		  -- end
	   -- end
	   -- return false
	-- end
	
	-- if param == "ratio" then
	   -- return false
	-- end

	-- if param == "stamina" then
	   -- local looktype = FAMILIAR_SYSTEM:getFamiliarLooktype(player)
	   -- if looktype then
		  -- local familiar = getFamiliarByLooktype(player, looktype)
	      -- if familiar then
		  -- end
	   -- end
	   -- return false
	-- end
	
	-- if param == "decay" then
	   -- local looktype = FAMILIAR_SYSTEM:getFamiliarLooktype(player)
	   -- if looktype then
		  -- local familiar = getFamiliarByLooktype(player, looktype)
	      -- if familiar then
		     -- familiar:setDecay()
		  -- end
	   -- end
	   -- return false
	-- end
	
	-- if param == "summon" then
	   -- local level = 666
	   -- local name = "Orc Warrior"
	   -- local summon = Game.createMonsterCustom(name, "[" .. level .. "] " .. name, player:getPosition(), true, false)
	   -- summon:registerEvent("FAMILIAR_SYSTEM_onHealthChange")
	   -- return false
	-- end
	
	-- if param == "test" then
	   
	   -- return false
	-- end
	  
	
	-- FAMILIAR_SYSTEM:createFamiliar(player)
    -- return false
-- end
-- talkaction:separator(" ")
-- talkaction:register()

-- local DEBUG_MODE = true

-- creatureevent = CreatureEvent("FAMILIAR_SYSTEM_onHealthChange")
-- function creatureevent.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)    
	-- if not attacker or not creature then
	   -- return primaryDamage, primaryType, secondaryDamage, secondaryType
	-- end
    
	-- local value = 0
	
	-- if creature:isFamiliar() then
	   -- return primaryDamage, primaryType, secondaryDamage, secondaryType
	-- end
	
	-- if primaryType == COMBAT_HEALING then
	
	   -- local master = creature:getMaster()
	   -- if not master then
	      -- return primaryDamage, primaryType, secondaryDamage, secondaryType
	   -- end
	   -- local looktype = creature:getOutfit().lookType
	   -- local familiar = getFamiliarByLooktype(master, looktype)
	   -- if not familiar then
	      -- return primaryDamage, primaryType, secondaryDamage, secondaryType
	   -- end
	   -- local ratio = familiar:getAbilityRatio("healing")
	   -- if ratio and ratio > 0 then
	      -- -- print("Healing increased by: " .. ratio * 100 .. "%")
		  -- -- print("Value Before: " .. primaryDamage)
	      -- primaryDamage = primaryDamage + (primaryDamage * ratio)
		  -- secondaryDamage = secondaryDamage + (secondaryDamage * ratio)
		  -- -- print("Value After: " .. primaryDamage)
	   -- end
	   -- return primaryDamage, primaryType, secondaryDamage, secondaryType  
	-- else
	   -- if creature:isMonster() and creature:isFamiliar() then
	   -- local master = creature:getMaster()
	   -- if not master then
	      -- return primaryDamage, primaryType, secondaryDamage, secondaryType
	   -- end
	   -- local looktype = creature:getOutfit().lookType
	   -- local familiar = getFamiliarByLooktype(master, looktype)
	   -- if not familiar then
	      -- return primaryDamage, primaryType, secondaryDamage, secondaryType
	   -- end
		  -- local ratio = familiar:getAbilityRatio("resist damage")
		  -- if ratio and ratio > 0 then
		     -- if DEBUG_MODE then
			    -- print("Increase Resist ratio by " .. ratio * 100 .. "%")
				-- print("Value Before: " .. primaryDamage)
			 -- end
			 -- primaryDamage = primaryDamage - (primaryDamage + ratio)
			 -- secondaryDamage = secondaryDamage - (secondaryDamage + ratio)
			 -- if DEBUG_MODE then
			    -- print("Value After: " .. primaryDamage)
		     -- end
	      -- end
		  -- return primaryDamage, primaryType, secondaryDamage, secondaryType
	   -- end
	   -- if attacker:isMonster() and attacker:isFamiliar() then
	   	   -- local master = attacker:getMaster()
	       -- if not master then
	          -- return primaryDamage, primaryType, secondaryDamage, secondaryType
	       -- end
	   -- local looktype = attacker:getOutfit().lookType
	   -- local familiar = getFamiliarByLooktype(master, looktype)
	   -- if not familiar then
	      -- return primaryDamage, primaryType, secondaryDamage, secondaryType
	   -- end
		  -- local ratio = familiar:getAbilityRatio("increase damage")
		  -- if ratio and ratio > 0 then
		     -- if DEBUG_MODE then
			    -- print("Increase Damage ratio by " .. ratio * 100 .. "%")
			    -- print("Value Before: " .. primaryDamage)
			  -- end
			  -- primaryDamage = primaryDamage + (primaryDamage + ratio)
			  -- secondaryDamage = secondaryDamage + (secondaryDamage + ratio)
			  -- if DEBUG_MODE then
			     -- print("Value After: " .. primaryDamage)
		      -- end
	      -- end
		  -- ---store exp
		  -- local damage = primaryDamage + secondaryDamage
		  -- if damage > creature:getMaxHealth() then
		     -- damage = creature:getMaxHealth()
		  -- end
		  -- FAMILIAR_SYSTEM:storeExperience(familiar, creature, damage)
		  
		  
		   -- return primaryDamage, primaryType, secondaryDamage, secondaryType	
        -- end	
   -- end		
   -- return primaryDamage, primaryType, secondaryDamage, secondaryType
-- end
-- creatureevent:register()

-- creatureevent = CreatureEvent("FAMILIAR_SYSTEM_onModalWindow")
-- function creatureevent.onModalWindow(player, modalWindowId, buttonId, choiceId) 
   
   -- if modalWindowId == 31 then
      
      -- local familiar = PLAYER_FAMILIARS[player:getGuid()][choiceId]
      -- if not familiar then
         -- return
      -- end
	  
	  -- if buttonId == 100 then
	     -- if not FAMILIAR_SELECTED[player:getId()] then
	        -- FAMILIAR_SELECTED[player:getId()] = {}
	     -- end
	     -- FAMILIAR_SELECTED[player:getId()] = familiar
	     -- FAMILIAR_SYSTEM:modalWindow(player, 2, familiar)
      -- elseif buttonId == 101 then
	     -- --player:unregisterEvent("FAMILIAR_SYSTEM_onModalWindow")
	  -- end
	  
   -- elseif modalWindowId == 1602 then
      -- local familiar = FAMILIAR_SELECTED[player:getId()]
      -- if not familiar then
         -- return
      -- end
	  -- if buttonId == 100 then
	     -- FAMILIAR_SYSTEM:modalWindow(player, 3, familiar)
	  -- elseif buttonId == 101 then
	     -- FAMILIAR_SYSTEM:modalWindow(player, 1, familiar)
	  -- elseif buttonid == 102 then
	     -- --player:unregisterEvent("FAMILIAR_SYSTEM_onModalWindow")
	  -- end
    -- elseif modalWindowId == 1603 then 
        -- local familiar = FAMILIAR_SELECTED[player:getId()]
        -- if not familiar then
           -- return
        -- end	
	    -- local type = ""
		-- if choiceId == 1 then
		   -- type = "increase damage"
		-- elseif choiceId == 2 then
		   -- type = "resist damage"
		-- elseif choiceId == 3 then
		   -- type = "healing"
		-- elseif choiceId == 4 then
           -- type = "health"		
		-- end
		-- if buttonId == 101 then
		   -- familiar:addPoints(type)
		   -- FAMILIAR_SYSTEM:modalWindow(player, 3, familiar)	
		-- elseif buttonId == 102 then
		   -- local value = 3
		   -- for i = 1, value do
		       -- familiar:addPoints(type)
		   -- end
		   -- FAMILIAR_SYSTEM:modalWindow(player, 3, familiar)
		-- elseif buttonId == 103 then
		   -- local value = 5
		   -- for i = 1, value do
		       -- familiar:addPoints(type)
		   -- end
		   -- FAMILIAR_SYSTEM:modalWindow(player, 3, familiar)
		-- elseif buttonId == 104 then  
           -- FAMILIAR_SYSTEM:modalWindow(player, 2, familiar)	
		-- -- elseif buttonId == 105 then  
           -- -- player:unregisterEvent("FAMILIAR_SYSTEM_onModalWindow")
		-- end
	-- end  
-- end
-- creatureevent:register()


-- local talk = TalkAction("/name", "name")
-- function talk.onSay(player, words, param)
	-- local familiar = getFamiliarByLooktype(player)
	-- if not familiar then
	   -- return true
	-- end
    -- familiar:setName(param)	
	-- return false
-- end
-- talk:separator(" ")
-- talk:register()

-- local action = Action()
-- function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	
	-- local t = FAMILIAR_SYSTEM.stamina.recoveryItems[item:getId()]
	-- if not t then
	   -- return true
	-- end

	-- local points = t.recoveryPoints
	-- local familiar = getFamiliarByLooktype(player)
	-- if not familiar then
	   -- return true
	-- end
	
	-- if familiar:getStaminaPoints() >= 100 then
	   -- player:sendTextMessage(MESSAGE_STATUS_WARNING, "Your familiar has already max stamina.")
	   -- return true
	-- end
	
	-- local addedPoints = 0
	-- for i = 1, points do
		-- if familiar:addStaminaPoints(1) then 
		   -- addedPoints = addedPoints + 1
		-- end
    -- end
	
	-- player:sendTextMessage(MESSAGE_INFO_DESCR, "You have added " .. addedPoints .. " stamina points to " .. familiar:getName() .. ".")
	-- if familiar:getStaminaPoints() >= 100 then
	   -- player:sendTextMessage(MESSAGE_INFO_DESCR, "Your familiar is fully recovered.")
	-- end
	-- item:remove(1)
	-- return true
-- end
-- for i, v in pairs(FAMILIAR_SYSTEM.stamina.recoveryItems) do
    -- action:id(i)
-- end
-- action:register()


-- local figures = {
                  -- storage = 9237317,
                  -- ["knight"] = { id = 35589, looktype = 1365 },
				  -- ["paladin"] = { id = 35590, looktype = 1366 },
				  -- ["druid"] = { id = 35591, looktype = 1364 },
				  -- ["sorcerer"] = { id = 35592, looktype = 1367 },
				-- }
				
-- local action = Action()
-- function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    
	-- local vocation = player:getFamiliarVocation()
		
	-- if item.itemid ~= figures[vocation].id then
	   -- player:sendCancelMessage("Your vocation can't use this figure.")
	   -- --return true
	-- end

	-- if player:getStorageValue(figures.storage) > 0 then
	   -- player:sendCancelMessage("You have already new familiar monster.")
	   -- --return true
	-- end

    -- player:addFamiliar(figures[vocation].looktype)
	-- player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	-- player:sendTextMessage(MESSAGE_INFO_DESCR, "You have got a new familiar monster!.")
	-- player:setStorageValue(figures.storage, 1)
	-- --item:remove(1)

    -- return true
-- end

-- for _, v in pairs(figures) do
    -- if type(v) == "table" then
	   -- local id = v.id
	   -- if id then
	      -- action:id(id)
	   -- end
	-- end
-- end
-- action:register()


