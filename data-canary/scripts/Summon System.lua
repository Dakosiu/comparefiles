-- CREATE TABLE `summons` (
-- `id` int(11),
-- `name` varchar(30) NOT NULL,
-- `real_name` varchar(30) NOT NULL,
-- `kill` bigint(20) NOT NULL,
-- `level` int(11) NOT NULL,
-- `stamina` bigint(20) NOT NULL,
-- `staminaTime` bigint(20) NOT NULL,
-- `points` int(11) NOT NULL,
-- `increase_damage_points` int(11) NOT NULL,
-- `resist_damage_points` int(11) NOT NULL,
-- `healing_points` int(11) NOT NULL,
-- `health_points` int(11) NOT NULL,
-- `current_health` int(11) NOT NULL,
-- `max_health` int(11) NOT NULL,
-- `alive` int(11) NOT NULL,
-- `itemid` int(11) NOT NULL,
-- PRIMARY KEY (`id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

SUMMON_SYSTEM_CONFIG = {
                               ["Summons"] = { 
                                               [35589] = {
											               levelRequired = 300,
							                               name = "Snowbash",
														   spells = {
														              ["Attack"] =  { 
																	                  	{name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -200},
	                                                                                    --{name ="Sudden Death", level = 1, interval = 2000, chance = 17, minDamage = -300, maxDamage = -350, range = 7, target = false},
	                                                                                    --{name ="Death Strike", level = 2, interval = 2000, chance = 15, type = COMBAT_DEATHDAMAGE, minDamage = -200, maxDamage = -250, range = 6, radius = 2, effect = CONST_ME_MORTAREA, target = true},
	                                                                                    {name ="combat", customName = "Death Explosion", level = 2, interval = 3000, chance = 25, type = COMBAT_DEATHDAMAGE, minDamage = -180, maxDamage = -250, range = 5, radius = 3, effect = CONST_ME_MORTAREA, target = true},
	                                                                                    {name ="combat", customName = "Icycle Shower", level = 3, interval = 3000, chance = 25, type = COMBAT_ICEDAMAGE, minDamage = -180, maxDamage = -250, range = 5, radius = 3, effect = CONST_ME_ICEAREA, target = true},
	                                                                                    {name ="combat", customName = "Ice Tornado", level = 3, interval = 2000, chance = 15, type = COMBAT_ICEDAMAGE, minDamage = -200, maxDamage = -250, range = 6, radius = 2, effect = CONST_ME_ICETORNADO, target = true},
	                                                                                    {name ="Ice Strike", interval = 2000, chance = 17, minDamage = -300, maxDamage = -350, range = 5, target = true}
																		            },
																	  ["Defense"] = {
																	                  {name ="combat", customName = "Healing", level = 4, interval = 2000, chance = 75, type = COMBAT_HEALING, minDamage = 400, maxDamage = 400, effect = CONST_ME_MAGIC_GREEN, target = false}
																					}
																	}
														               
										                 },
                                               [35590] = {
											               levelRequired = 300,
							                               name = "Sandscourge",
														   spells = {
														              ["Attack"] =  { 
																	                  	{name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -200},
	                                                                                    {name ="combat", customName = "Holy Explosion", level = 1, interval = 2000, chance = 18, type = COMBAT_HOLYDAMAGE, minDamage = -200, maxDamage = -270, range = 5, radius = 3, shootEffect = CONST_ANI_HOLY, effect = CONST_ME_HOLYAREA, target = true},
	                                                                                    {name ="combat", customName = "Fire", level = 2, interval = 2000, chance = 18, type = COMBAT_FIREDAMAGE, minDamage = -200, maxDamage = -270, range = 5, radius = 3, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREATTACK, target = true},
	                                                                                    {name ="combat", customName = "Fire Strike", level = 4, interval = 2000, chance = 18, type = COMBAT_FIREDAMAGE, minDamage = -170, maxDamage = -230, range = 5, radius = 5, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREATTACK, target = true},
	                                                                                    {name ="combat", customName = "Holy Strike", level = 3, interval = 2000, chance = 18, type = COMBAT_HOLYDAMAGE, minDamage = -170, maxDamage = -230, range = 5, radius = 5, shootEffect = CONST_ANI_HOLY, effect = CONST_ME_HOLYAREA, target = true}
																		            },
																	  ["Defense"] = {
																	                  {name ="combat", customName = "Healing", level = 4, interval = 2000, chance = 75, type = COMBAT_HEALING, minDamage = 380, maxDamage = 380, effect = CONST_ME_MAGIC_GREEN, target = false}
																					}
																	}
														               
										                 },
                                               [35592] = {
											               levelRequired = 300,
							                               name = "Bladespark",
														   spells = {
														              ["Attack"] =  { 
																	                  	{name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -200},
	                                                                                    {name ="combat", customName = "Life Drain", level = 1, interval = 2000, chance = 25, type = COMBAT_LIFEDRAIN, minDamage = -90, maxDamage = -150, length = 2, spread = 0, target = false},
	                                                                                    {name ="combat", customName = "Energy Hit", level = 2, interval = 2000, chance = 25, type = COMBAT_ENERGYDAMAGE, minDamage = -190, maxDamage = -210, length = 2, spread = 0, effect = CONST_ME_ENERGYHIT, target = false},
	                                                                                    {name ="Summon Challenge", level = 3, interval = 2000, chance = 40, target = false}
																		            },
																	  ["Defense"] = {
																	                  {name ="combat", customName = "Healing", level = 4, interval = 2000, chance = 75, type = COMBAT_HEALING, minDamage = 600, maxDamage = 600, effect = CONST_ME_MAGIC_GREEN, target = false}
																					}
																	}
														               
										                 },
                                               [35591] = {
											               levelRequired = 300,
							                               name = "Mossmasher",
														   spells = {
														              ["Attack"] =  { 
																	                  --{name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -300},
	                                                                                  {name ="combat", customName = "Earth Strike", level = 1, interval = 1000, chance = 100, type = COMBAT_EARTHDAMAGE, minDamage = -100, maxDamage = -100, range = 5, shootEffect = CONST_ANI_EARTH, effect = CONST_ME_STONES, target = true},
	                                                                                 -- {name ="combat", customName = "Earth", level = 2, interval = 2000, chance = 25, type = COMBAT_EARTHDAMAGE, minDamage = -90, maxDamage = -150, length = 2, spread = 0, effect = CONST_ME_GROUNDSHAKER, target = false},
	                                                                                  --{name ="Summon Challenge", interval = 2000, chance = 40, target = false}
																		            },
																	  ["Defense"] = {
																	                  {name ="combat", customName = "Healing", level = 4, interval = 2000, chance = 75, type = COMBAT_HEALING, minDamage = 600, maxDamage = 600, effect = CONST_ME_MAGIC_GREEN, target = false}
																					}
																	}
														               
										                 },														 
														 
														 
														 
														 
												
										     }
	                   }
							 
							 
SUMMON_SYSTEM_CONFIG.customAttributes = {
                                          id = "SUMMON_SYSTEM_ID",
						                }
							

SUMMON_SYSTEM_CONFIG.KillsTable = {
                                    [1] = 1,
									[2] = 2,
									[3] = 3,
									[4] = 4,
									[5] = 5,
									[6] = 1,
									[7] = 2,
									[8] = 3,
									[9] = 4,
									[10] = 5,
                                    [11] = 1,
									[12] = 2,
									[13] = 3,
									[14] = 4,
									[15] = 5,
									[16] = 1,
									[17] = 2,
									[18] = 3,
									[19] = 4,
									[20] = 5,	
                                    [21] = 1,
									[22] = 2,
									[23] = 3,
									[24] = 4,
									[25] = 5,
									[26] = 1,
									[27] = 2,
									[28] = 3,
									[29] = 4,
									[30] = 5,
                                    [31] = 1,
									[32] = 2,
									[33] = 3,
									[34] = 4,
									[35] = 5,
									[36] = 1,
									[37] = 2,
									[38] = 3,
									[39] = 4,
									[40] = 5,									
								  }

SUMMON_SYSTEM_CONFIG.abilities = {
							       increaseDamage = 0.01, --- 1% większy dmg co każdy punkt
							       increaseResistDamage = 0.01, --- 1% wieksza obrona co każdy punkt
							       increaseHealing = 0.01, --- 1% każdy punkt
							       addHealth = 10 -- 10 hp co każdy punkt.
							     }

SUMMON_SYSTEM_CONFIG.stamina = {
                                ratio = { value = 20, type = "seconds" },
							    recoveryItems = {
							                     [32045] = {
											                recoveryPoints = 3,
													      },
											     [32044] = {
											                recoveryPoints = 6,
													      },
												 [32043] = {
											                recoveryPoints = 9,
													      },
											    }
						       }
							   
SUMMON_SYSTEM_CONFIG.revive = {
                               ["Required"] = { 
						                        { type = "money", value = 900000 } 
										      }
						      }	

SUMMON_SYSTEM_CONFIG.potions = {
                                 [3032] = { min = 100, max = 250 },
                               }								 

if not SUMMON_SYSTEM_CONFIG.PLAYERS_EXHAUST then
   SUMMON_SYSTEM_CONFIG.PLAYERS_EXHAUST = {}
end
		  
if not SUMMON_SYSTEM then
   SUMMON_SYSTEM = {}
end

if not SUMMONS then
   SUMMONS = {}
end

local Summon = nil

Summon = {
             id = -1,
			 master_id = -1,
			 cid = -1,
			 name = "",
			 real_name = "",
			 level = 0,
			 kill = 0,
			 stamina = 100,
			 staminaTime = 0,
			 points = 0,
			 increase_damage_points = 0,
			 resist_damage_points = 0,
			 healing_points = 0,
			 health_points = 0,
			 currentHealth = 0,
			 maxHealth = 0,
			 alive = 1,
			 itemid = -1,
			 hidden = false,
		  }

function Summon:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

function Summon:getMasterId()
	return self.master_id
end

function Summon:getCreature()
   local id = self.cid
   local creature = Monster(id)
   if creature then
      return creature
   end
   return false
end

function Summon:getMaster()

    local master = nil
	master = Player(self:getMasterId())
	if master then
	   return master
	end
	return false
	
end

function Summon:getId()
	return self.id
end

function Summon:getItemId()
    return self.itemid
end

function Summon:getCid()
   return self.cid
end

function Summon:getDatabase()
	local resultx = db.storeQuery("SELECT `id` FROM `summons` WHERE `id` = " .. self:getId())
	if resultx then
	   result.free(resultx)
	   return true
	end
	result.free(resultx)
	return false
end

function Summon:getName()
    if self.name == "" then
	   return self.real_name
	end
	return self.name
end

function Summon:setName(value)
    self.name = value
	local creature = self:getCreature()
	if creature then
	   local level = self:getLevel()
	   local name = self:getName()
	   creature:setName("[" .. level .. "] " .. name)
	end
	self:save()
end

function Summon:getRealName()
    return self.real_name
end

function Summon:getLevel()
    return self.level
end

function Summon:getKills()
    return self.kill
end

function Summon:getKillsToNextLevel()
   
	local level = self:getLevel()
	if level >= #SUMMON_SYSTEM_CONFIG.KillsTable then
	   return 0
	end

    local requiredKills = SUMMON_SYSTEM_CONFIG.KillsTable[level + 1]
	local kills = self:getKills()
	
	if requiredKills <= kills then
	   return 0
	end
	return requiredKills - kills
end
	
function Summon:isAlive()
    return self.alive
end

-- function Summon:getStaminaString()
    
	-- SUMMON_SYSTEM:getStaminaRatio() 

function Summon:setStaminaTime()

	local duration = SUMMON_SYSTEM_CONFIG.stamina.ratio.value
	local method =  SUMMON_SYSTEM_CONFIG.stamina.ratio.type
	
	local interval = 0
	
	if string.find(method, "second") then
	   interval = duration
	elseif string.find(method, "minute") then
	   interval = duration * 60
	elseif string.find(method, "hour") then 
	   interval = duration * 60 * 60
	end
	
	interval = interval * 100
	
	self.staminaTime = interval
end

function Summon:getStaminaTime() 
    	
	local duration = self.staminaTime
	if not duration or druation == 0 then
	   return 0
	end
	
	
	local time_string = ""

    local time_left = duration
    local hours = string.format("%02.f", math.floor(time_left / 3600))
    local mins = string.format("%02.f", math.floor(time_left / 60 - (hours * 60)))
    local secs = string.format("%02.f", math.floor(time_left  - hours * 3600 - mins * 60))

    if hours == "00" then
       time_string = mins .. " Minutes" .. " and " .. secs .. " Seconds" .. "."
    else
       time_string = hours .. " Hours" .. ", " .. mins .. " Minutes" .. " and " .. secs .. " Seconds" .. "."
    end
	
	if method then
	   if hours == "00" and secs == "00" then
	      return mins
	   end
	   return false
	end
	  
	return time_string
end

    
function Summon:setAlive(boolean)
   
   if boolean then
      self.alive = 1
	  return
   end
   
   self.currentHealth = 0
   self.alive = 0
   local summon = self:getCreature()
   if summon then
      summon:getPosition():sendMagicEffect(CONST_ME_POFF)
      summon:remove()
	  self:sendMessage(MESSAGE_STATUS_CONSOLE_RED, "Summon is dead.")
   end
   self:save()
end

function Summon:getPoints(type)
    
	if not type then
	   return self.points
	end
	
	if type == "increase damage" then
	   return self.increase_damage_points
	elseif type == "resist damage" then
	   return self.resist_damage_points
	elseif type == "healing" then
	   return self.healing_points
	elseif type == "health" then
	   return self.health_points
	end
end

function Summon:addPoints(type, value, loop)
    
	if not type then
	   self.points = self.points + 1
	   return
	end
	
	if not value then
	   value = 1
	end
	
	local points = self.points
	if points < value then
	   -- local owner = self:getMaster()
	   -- if owner then
	      -- local text = "Summon dont have enough points."
	      -- return owner:popupFYI(text)
	   -- end
	   -- return
	   return false
	end

	if type == "increase damage" then
	   self.increase_damage_points = self.increase_damage_points + value
	   self.points = self.points - value
	   self:sendMagicEffect(CONST_ME_MAGIC_GREEN)
	   --self:sendMessage(MESSAGE_INFO_DESCR, "Successfully added 1 point to increase damage.")
	   self:save()
	   return true
	elseif type == "resist damage" then
	   self.resist_damage_points = self.resist_damage_points + value
	   self.points = self.points - value
	   self:sendMagicEffect(CONST_ME_MAGIC_GREEN)
	   --self:sendMessage(MESSAGE_INFO_DESCR, "Successfully added 1 point to increase resist damage.")
	   self:save()
	   return true
	elseif type == "healing" then
	   self.healing_points = self.healing_points + value
	   self.points = self.points - value
	   self:sendMagicEffect(CONST_ME_MAGIC_GREEN)
	  -- self:sendMessage(MESSAGE_INFO_DESCR, "Successfully added 1 point to increase healing.")
	   self:save()
	   return true
	elseif type == "health" then
	   self.health_points = self.health_points + value
	   self.points = self.points - value
	   local ratio = SUMMON_SYSTEM_CONFIG.abilities.addHealth * value
	   self:setMaxHealth(self:getMaxHealth() + ratio)
	   self:updateHealth()
	   self:sendMagicEffect(CONST_ME_MAGIC_GREEN)
	   --self:sendMessage(MESSAGE_INFO_DESCR, "Successfully added 1 point to increase health.")
	   self:save()
	   return true
	end
end

function Summon:getAbilityRatio(type)
	if not type then
	   return 0
	end
	
	if type == "increase damage" then
	   return self.increase_damage_points * SUMMON_SYSTEM_CONFIG.abilities.increaseDamage
	elseif type == "resist damage" then
	   return self.resist_damage_points * SUMMON_SYSTEM_CONFIG.abilities.increaseResistDamage
	elseif type == "healing" then
	   return self.healing_points * SUMMON_SYSTEM_CONFIG.abilities.increaseHealing
	elseif type == "health" then
	   return self.health_points * SUMMON_SYSTEM_CONFIG.abilities.addHealth
	end
end

function Summon:getHealth()
   return self.currentHealth
end

function Summon:getMaxHealth()
   return self.maxHealth
end

function Summon:setHealth(value)
   self.currentHealth = value
   self:save()
end

function Summon:setMaxHealth(value)
   self.maxHealth = value
   self:save()
end

function Summon:updateHealth(value)
   local creature = self:getCreature()
   if creature then
      creature:setMaxHealth(self:getMaxHealth())
   end
end

function Summon:sendMagicEffect(id)
	local creature = self:getCreature()
	if not creature then
	   return
	end
	local pos = creature:getPosition()
	return pos:sendMagicEffect(id)
end

function Summon:isHidden()
    if self.hidden == true then
	   return true
	end
	return false
end

function Summon:hide(bool)
   if bool then
      self.hidden = true
	  return
   end
   self.hidden = false
end

function Summon:save()
    
	if not self:getDatabase() then
	   return
	end

	local sql = "UPDATE `summons` SET"
	sql = sql .. " `name`=" .. db.escapeString(self:getName()) 
	sql = sql .. ", `real_name`=" .. db.escapeString(self:getRealName()) 
	sql = sql .. ", `kill`=" .. tonumber(self:getKills())
	sql = sql .. ", `level`=" .. tonumber(self:getLevel())
	sql = sql .. ", `stamina`=" .. tonumber(self:getStaminaPoints())
	sql = sql .. ", `staminaTime`=" .. tonumber(self.staminaTime)
	sql = sql .. ", `points`=" .. tonumber(self:getPoints())
	sql = sql .. ", `increase_damage_points`=" .. tonumber(self:getPoints("increase damage"))
	sql = sql .. ", `resist_damage_points`=" .. tonumber(self:getPoints("resist damage"))
	sql = sql .. ", `healing_points`=" .. tonumber(self:getPoints("healing"))
	sql = sql .. ", `health_points`=" .. tonumber(self:getPoints("health"))
	sql = sql .. ", `current_health`=" .. tonumber(self:getHealth())
	sql = sql .. ", `max_health`=" .. tonumber(self:getMaxHealth())
	sql = sql .. ", `alive`=" .. tonumber(self:isAlive())
	sql = sql .. " WHERE `id`=" .. tonumber(self:getId())

	db.query(sql)
end

function Summon:addLevel(_shouldSave)
    
	local max_level = #SUMMON_SYSTEM_CONFIG.KillsTable
	
	if self:getLevel() >= max_level then
	   return
	end

	
	local oldLevel = self:getLevel()
	self.level = self.level + 1
	self.kill = 0
	

	
	self:sendMessage(MESSAGE_INFO_DESCR, "Your summon advanced from " .. oldLevel .. " level to " .. self.level .. " level.")
	if self:getLevel() >= max_level then
	   self:sendMessage(MESSAGE_INFO_DESCR, "Congratulations! Your summon reached max level.")
	end	
	
	local master = self:getMaster()
	if master then
	   self:sendChannelMessage("Your summon advanced from " .. oldLevel .. " level to " .. self.level .. " level.")
    end
	
	local creature = self:getCreature()
	if creature then
	   local level = self:getLevel()
	   local name = self:getName()
	   creature:setName("[" .. level .. "] " .. name)
	   creature:addLevel()
	   creature:changeSpeed(10)
	end
	   
	self:addPoints()
	if _shouldSave then
	   self:save()
	end
	
end

function Summon:sendMessage(type, string)
    
	local master = self:getMaster()
	if master then
	   return master:sendTextMessage(type, string)
	end
end

function Summon:sendChannelMessage(string)
    
	local master = self:getMaster()
	if master then
	   master:openChannel(16)
	   master:sendChannelMessage(master:getName(), string, TALKTYPE_CHANNEL_O, 16)
	end
end

function Summon:addKill(value)
    
	local max_level = #SUMMON_SYSTEM_CONFIG.KillsTable
	local level = self:getLevel()
	
	if level >= max_level then
	   return
	end
	
	self.kill = self.kill + 1
	
	if self:getKills() >= self:getRequiredKills() then
	   self:addLevel(1)
	end
	
end

function Summon:getMaxKills()
   
    local level = self:getLevel()

	if level >= #SUMMON_SYSTEM_CONFIG.KillsTable then
	   return SUMMON_SYSTEM_CONFIG.KillsTable[#SUMMON_SYSTEM_CONFIG.KillsTable]
	end
	
	return SUMMON_SYSTEM_CONFIG.KillsTable[level + 1]
end

function Summon:getRequiredKills() 
	local level = self:getLevel()
	return SUMMON_SYSTEM_CONFIG.KillsTable[level + 1]
end

function Summon:getStaminaPoints()   
   return self.stamina
end

function Summon:removeStaminaPoints(value)
   
   if not value then
      value = 1
   end
      
   self.stamina = self.stamina - value
   self:save()
end

function Summon:addStaminaPoints(value)
   
   if not value then
      value = 1
   end
   
   if self:getStaminaPoints() >= 100 then
	  return false
   end
      
   self.stamina = self.stamina + value
   self:save()
   return true
end

function Summon:setStaminaPoints(value)
   self.stamina = value
end

function Summon:setDecay()

   local delay = 1000 * SUMMON_SYSTEM:getStaminaRatio()
   local function decay(summon)
	  local _stop = false
      local cid = summon:getCid()
      local monster = summon:getCreature()
      if not monster then
         return false
      end
      
	  if summon:getStaminaPoints() <= 0 then
	     if summon:isAlive() == 1 then
		    summon:setAlive(false)
			summon:sendMessage(MESSAGE_STATUS_WARNING, "Your summon was hungry, lost his power and died. You have to revive him.")
			summon:setStaminaPoints(0)
			summon.staminaTime = 0
	        _stop = true
		 end
	  end
	  summon:removeStaminaPoints(1)
	  summon.staminaTime = summon.staminaTime - SUMMON_SYSTEM:getStaminaRatio() 
	  if not _stop then
         addEvent(decay, delay, summon)
	  end
    end

   addEvent(decay, 4000, self)
end

function Summon:checkPz()
    
	local delay = 100
	local function check(summon)
	   local creature = summon:getCreature()
	   if not creature then
	      return false
	   end
		     local player = summon:getMaster()
			 if not player then
			    return false
		     end
			 if player:getTile():hasFlag(TILESTATE_PROTECTIONZONE) or creature:getTile():hasFlag(TILESTATE_PROTECTIONZONE) then
			    summon:releaseCreature()
				summon:hide(true)
				player:sendTextMessage(MESSAGE_INFO_DESCR, "Your summon dissapear cause entered in protection zone")
			 end
			 
			 if player:isPzLocked() or not player:hasSecureMode() then
			    summon:releaseCreature()
				summon:hide(true)
	            player:sendTextMessage(MESSAGE_INFO_DESCR, "Your summon dissapear cause you are fighting with players")
			 end
			 
			    
	   addEvent(check, delay, summon)
    end
	check(self)
end

function Summon:checkItem()
	   local creature = self:getCreature()
	   if not creature then
	      return false
	   end
	   local master = self:getMaster()
	   if not master then
	      return false
	   end
	   local backpack = master:getSlotItem(CONST_SLOT_BACKPACK)
       if not backpack then
	      self:releaseCreature()
          return false
       end
	   local id = self:getId()
	   if not backpack:getSummonInside(id) then
	      self:releaseCreature()
		  return false
	   end
end

function Summon:createCreature(player)

    if self:isAlive() == 0 then
	   player:sendCancelMessage("Your summon is dead, you have to revive him.")
	   return true
	end
	
   	local name = self:getName()
	local level = self:getLevel()
	local monster = self:getCreature()
	if monster then
	   return
	end
	monster = Game.createMonsterCustom(name, "[" .. level .. "] " .. name, player:getPosition(), false, false)
	if monster then
	   monster:registerEvent("SUMMON_SYSTEM_onHealthChange")
	   monster:registerEvent("SUMMON_SYSTEM_onDeath")
	   monster:setLevel(level)
	   for i = 1, level do
	       monster:changeSpeed(10)
	   end
	   monster:setFamiliar(true)
	   player:addSummon(monster)
	   self.cid = monster:getId()
	   self.master_id = player:getId()
	   local health_ratio = self:getAbilityRatio("health")
	   if health_ratio > 0 then
	      monster:setMaxHealth(monster:getMaxHealth() + health_ratio)
	   end
	   
	   local currentHealth = self.currentHealth
	   if currentHealth > 0 then
	      monster:setHealth(currentHealth)
	   else 
	      if health_ratio > 0 then
		     monster:addHealth(monster:getMaxHealth())
			 self:setHealth(monster:getHealth())
		  end
	   end
	   self:setMaxHealth(monster:getMaxHealth())
	   self:setDecay()
	   self:hide(false)
	   self:checkPz()
	   self:checkItem()
	   player:sendTextMessage(MESSAGE_INFO_DESCR, "You have summoned your summon.")
   end
end

function Summon:releaseCreature()
	local creature = self:getCreature()
	if creature then
	   self:setHealth(creature:getHealth())
	   creature:remove()
	end
end

function TableConcat(t1,t2)
    for i=1,#t2 do
        t1[#t1+1] = t2[i]
    end
    return t1
end

-- function Container.getSummonInside(self, id)
    -- if self:isContainer() then
        -- local size = self:getSize()
        -- for slot=0, size-1 do
            -- local item = self:getItem(slot)
            -- if (item) then
                -- if(item:isContainer()) then
                    -- itemList = TableConcat(itemList, item:getSummonInside())
                -- end
				-- local summon_id = item:getCustomAttribute(SUMMON_SYSTEM_CONFIG.customAttributes.id)
				-- if summon_id then
				   -- if summon_id == id then
                      -- return true
				   -- end
				-- end
            -- end
        -- end
    -- end
	-- return false
-- end


function Container.getSummonInside(self, id) -- by Musztang
    local slots = 0
    local containers = {}

    if self:isContainer() then
	   local size = self:getSize()
	   for slot=0, size-1 do
	       local item = self:getItem(slot)
	       if item then
	          if item:isContainer() then
		         table.insert(containers, item)
		      else
		         local summon_id = item:getCustomAttribute(SUMMON_SYSTEM_CONFIG.customAttributes.id)
			     if summon_id then
			        if summon_id == id then
				       return true
			        end
		         end
	          end
	        end
	    end
	end
	
	local tries = 0
	while #containers > 0 and tries < 200 do
	    local firstContainer = containers[1]
		if firstContainer then
		   local size = firstContainer:getSize()
	       for slot=0, size-1 do
		       local item = firstContainer:getItem(slot)
	           if item then
	              if item:isContainer() then
		             table.insert(containers, item)
		          else
		             local summon_id = item:getCustomAttribute(SUMMON_SYSTEM_CONFIG.customAttributes.id)
			         if summon_id then
			            if summon_id == id then
				           return true
			            end
		             end
	             end
	          end
			end
		end
		tries = tries + 1
		table.remove(containers, 1)
	end
			      
		   
	return false
end

function Container.getAllSummonsInside(self)
    local itemList = {}
    if self:isContainer() then
        local size = self:getSize()
        for slot=0, size-1 do
            local item = self:getItem(slot)
            if (item) then
                if(item:isContainer()) then
                    itemList = TableConcat(itemList, item:getAllSummonsInside())
                end
				local summon_id = item:getCustomAttribute(SUMMON_SYSTEM_CONFIG.customAttributes.id)
				if summon_id then
				   local summon = getSummonByItem(item)
				   if summon then
                      itemList[#itemList+1] = summon
				   end
				end
            end
        end
    end
    return itemList
end

function Player.getAllSummonsInBackpack(self)
	local backpack = self:getSlotItem(CONST_SLOT_BACKPACK)
	if backpack then
	   return backpack:getAllSummonsInside()
	end
	return {}
end

function SUMMON_SYSTEM:addSpells()
	
	local t = SUMMON_SYSTEM_CONFIG["Summons"]
	for _, summonTable in pairs(t) do
	    local name = summonTable.name
		local mType = MonsterType(name)
		if mType then
	       local spellsTable = summonTable.spells
		   if spellsTable then
		      local attackTable = spellsTable["Attack"]
			  if attackTable then
		         for _, v in pairs(attackTable) do
			         mType:addAttack(readSpell(v))
			     end
			  end
			  local defenseTable = spellsTable["Defense"]
			  if defenseTable then
		         for _, v in pairs(defenseTable) do
			         mType:addDefense(readSpell(v))
			     end
			  end
		  end
		end
	end
	
end

function SUMMON_SYSTEM:getItemTable(item)
    
	for i, v in pairs(SUMMON_SYSTEM_CONFIG["Summons"]) do
	    if i == item:getId() then
		   return v
		end
	end
	return false
end
	
function SUMMON_SYSTEM:displayItem(item)
    
	local itemTable = SUMMON_SYSTEM:getItemTable(item)
	if not itemTable then
	   return false
	end
	
	local str = ""
	
	local summon = getSummonByItem(item)
	if summon then
	   str = "It Contains " .. summon:getName() .. " with " .. summon:getLevel() .. " level."
	else
	  str = "It Contains " .. itemTable.name .. " with 0 level."
	end
	
	return str
end
	
    	
function SUMMON_SYSTEM:modalWindow(player, value, summon)
	player:registerEvent("SUMMON_SYSTEM_onModalWindow")
	
    if value == 1 then
	   player:registerEvent("SUMMON_SYSTEM_onModalWindow")
	   local title = "Summon Manager"
	   local message = "Select your summon: "
	   local window = ModalWindow(30 + value, title, message)
	   window:addButton(100, "Select") 
       window:addButton(101, "Cancel")
       window:setDefaultEnterButton(100)	  
       window:setDefaultEscapeButton(101)
	   for i, summon in pairs(player:getAllSummonsInBackpack()) do
	      local name = summon:getName()
		  local level = summon:getLevel()
		  window:addChoice(i, "[" .. level .. "] " .. name)
       end
	   return window:sendToPlayer(player)
	end

	if value == 2 then
	   player:registerEvent("SUMMON_SYSTEM_onModalWindow")
	   local title = "Summon Manager"	   
	   local level = summon:getLevel()
	   local kills = summon:getKills()
	   local max_kills = summon:getMaxKills()
	   --local required_experience = summon:getExperienceToNextLevel()
	   local increase_damage_ratio = summon:getAbilityRatio("increase damage") * 100
	   local increase_resist_ratio = summon:getAbilityRatio("resist damage") * 100
	   local increase_healing = summon:getAbilityRatio("healing") * 100
	   local health = summon:getAbilityRatio("health")
	   local currentHealth = summon:getHealth()
	   local maxHealth = summon:getMaxHealth()
	   local points = summon:getPoints()
	   local max_points = #SUMMON_SYSTEM_CONFIG.KillsTable
	   local stamina_points = summon:getStaminaPoints()
	   local stamina_string = summon:getStaminaTime()
	   local alive = summon:isAlive()
	   
	   local creature = summon:getCreature()
	   if creature then
	      currentHealth = creature:getHealth()
	   end
	   local message = "-----------------------------------                                        " .. "\n"
	   message = message .. "Informations about summon: " .. "\n"
	   message = message .. "-----------------------------------                                        " .. "\n"
	   message = message .. "Level: " .. level .. "\n"
	   message = message .. "Kills: " .. kills .. "/" .. max_kills .. "\n"
	   message = message .. "Health: " .. currentHealth .. "/" .. maxHealth .. "\n"
	   message = message .. "Stamina Points: " .. stamina_points .. "\n"
	   if alive == 1 then
	      message = message .. "summon will die after: " .. stamina_string .. "\n"
	      message = message .. "Status: " .. "Alive" .. "\n"
	   else
	      message = message .. "Status: " .. "Dead" .. "\n"
	   end
	   
	   
	   --message = message .. "Experience to next level: " .. required_experience .. "\n"
	   message = message .. "-----------------------------------                                        " .. "\n"
	   message = message .. "Increase Damage by: " .. increase_damage_ratio .. "%" .. "\n"
	   message = message .. "-----------------------------------                                        " .. "\n"
       message = message .. "Increase Resist Damage by: " .. increase_resist_ratio .. "%" .. "\n"
	   message = message .. "-----------------------------------                                        " .. "\n"
	   message = message .. "Increase Healing by: " .. increase_healing .. "%" .. "\n"
	   message = message .. "-----------------------------------                                        " .. "\n"
	   message = message .. "Increase Health by: " .. health .. " hitpoints" .. "\n"
	   message = message .. "-----------------------------------                                        " .. "\n"
	   message = message .. "You have " .. points .. " points left to add."
	   local window = ModalWindow(30 + value, title, message)
	   window:addButton(100, "Ability")
	   window:addButton(101, "Spells")
	   window:addButton(102, "Back") 
	   window:addButton(103, "Cancel") 
       window:setDefaultEnterButton(100)	  
       window:setDefaultEscapeButton(103)
	   return window:sendToPlayer(player)
	end
	
	if value == 3 then
	   player:registerEvent("SUMMON_SYSTEM_onModalWindow")
	   local summon = summon
	   if not summon then
	      return
	   end
	   local increase_damage_ratio = SUMMON_SYSTEM_CONFIG.abilities.increaseDamage * 100
	   local resist_damage_ratio = SUMMON_SYSTEM_CONFIG.abilities.increaseResistDamage * 100
	   local healing_ratio = SUMMON_SYSTEM_CONFIG.abilities.increaseHealing * 100
	   local health = SUMMON_SYSTEM_CONFIG.abilities.addHealth
	   local points = summon:getPoints()
	   local title = "Summon Manager"
	   local message = "-----------------------------------                                        " .. "\n"
	   message = message .. "Informations about abilities: " .. "\n"
       message = message .. "-----------------------------------                                        " .. "\n"
	   message = message .. "Increase Damage: " .. "\n" .. "1 point give " .. increase_damage_ratio .. "% more damage." .. "\n"
	   message = message .. "-----------------------------------                                        " .. "\n"
	   message = message .. "Resist Damage: " .. "\n" .. "1 point give " .. resist_damage_ratio .. "% more defense." .. "\n"
	   message = message .. "-----------------------------------                                        " .. "\n"
	   message = message .. "Increase Healing: " .. "\n" .. "1 point give " .. healing_ratio .. "% more healing." .. "\n"
	   message = message .. "-----------------------------------                                        " .. "\n"	
	   message = message .. "Increase Health: " .. "\n" .. "1 point give " .. health .. " hitpoints." .. "\n"
	   message = message .. "-----------------------------------                                        " .. "\n"		   
	   message = message .. "You have " .. points .. " points left to add."
	   local window = ModalWindow(30 + value, title, message)
	   window:addChoice(1, "Increase Damage")
	   window:addChoice(2, "Increase Resist Damage")
	   window:addChoice(3, "Increase Healing")
	   window:addChoice(4, "Increase Health")
	   window:addButton(101, "1 Point")
	   window:addButton(102, "3 Point")
	   window:addButton(103, "5 Point")
	   window:addButton(104, "Back") 
       --window:setDefaultEnterButton(100)	  
       window:setDefaultEscapeButton(104)	   
	   return window:sendToPlayer(player)
	end
	
	if value == 4 then
	   local title = "Revive Summon Manager"
	   local message = "Avaible Summons: "
	   local window = ModalWindow(30 + value, title, message)
	   window:addButton(100, "Select") 
       window:addButton(101, "Cancel")
       window:setDefaultEnterButton(100)	  
       window:setDefaultEscapeButton(101)
	   local summonTable = player:getAllSummonsInBackpack()
	   local _shouldSend = false
	   for i, summon in pairs(summonTable) do
		   if summon:isAlive() == 0 then
		      _shouldSend = true
		      window:addChoice(i, "[" .. summon:getLevel() .. "] " .. summon:getName())
		   end
	   end
	   if not _shouldSend then
	      return false
	   end
	   return window:sendToPlayer(player)
	end
	
	if value == 5 then
	   local title = "Summon Manager"
	   local message = ""
	   message = message .. "Attack Spells: "
	   message = message .. "-----------------------------------                                        "
	   local attackTable = SUMMON_SYSTEM_CONFIG["Summons"][summon:getItemId()].spells["Attack"]
	   if attackTable then
	      for _, v in pairs(attackTable) do
		     local name = v.name
			 local level = v.level
			 if not level then
			    level = 0
		     end
			 local customName = v.customName
			 if customName then
			    name = customName
		     end
			 if name ~= "combat" and name ~= "melee" then
		        message = message .. "\n"
				message = message .. "Name: " .. name .. "\n"
				message = message .. "Required Level: " .. level .. "\n"
			    message = message .. "-----------------------------------                                        "
		     end
		  end
	   end
	   message = message .. "\n"
	   message = message .. "\n"
	   message = message .. "Defense Spells: "
	   message = message .. "-----------------------------------                                        "	   
	   local defenseTable = SUMMON_SYSTEM_CONFIG["Summons"][summon:getItemId()].spells["Defense"]
	   if defenseTable then
	      for _, v in pairs(defenseTable) do
		     local name = v.name
			 local level = v.level
			 if not level then
			    level = 0
		     end
			 local customName = v.customName
			 if customName then
			    name = customName
		     end
			 if name ~= "combat" and name ~= "melee" then
		        message = message .. "\n"
				message = message .. "Name: " .. name .. "\n"
				message = message .. "Required Level: " .. level .. "\n"
			    message = message .. "-----------------------------------                                        "
		     end
		  end
        end		  
	-- local t = SUMMON_SYSTEM_CONFIG["Summons"]
	-- for _, summonTable in pairs(t) do
	    -- local name = summonTable.name
		-- local mType = MonsterType(name)
		-- if mType then
	       -- local spellsTable = summonTable.spells
		   -- if spellsTable then
		      -- local attackTable = spellsTable["Attack"]
			  -- if attackTable then
		         -- for _, v in pairs(attackTable) do
			         -- mType:addAttack(readSpell(v))
			     -- end
			  -- end
			  -- local defenseTable = spellsTable["Defense"]
			  -- if defenseTable then
		         -- for _, v in pairs(defenseTable) do
			         -- mType:addDefense(readSpell(v))
			     -- end
			  -- end
		  -- end
		-- end
	-- end
	
	
	   
	   local window = ModalWindow(30 + value, title, message)
	   window:addButton(100, "Back") 
       window:setDefaultEnterButton(100)	  
       window:setDefaultEscapeButton(100)
	   return window:sendToPlayer(player)
	end
end

local function getRequiredMoney()
    local reviveTable = SUMMON_SYSTEM_CONFIG.revive["Required"]
	local cost = 0
	
	for i, v in pairs(reviveTable) do
	    if v.type == "money" then
		   cost = cost + v.value
		end
	end
	return cost
end

creatureevent = CreatureEvent("SUMMON_SYSTEM_onModalWindow")
function creatureevent.onModalWindow(player, modalWindowId, buttonId, choiceId) 
   
   if modalWindowId == 31 then
      
	  local summonTable = player:getAllSummonsInBackpack()
	  local summon = summonTable[choiceId]
      if not summon then
         return
      end
	  
	  if buttonId == 100 then
	     if not SUMMON_SELECTED then
		    SUMMON_SELECTED = {}
	     end
	     if not SUMMON_SELECTED[player:getId()] then
	        SUMMON_SELECTED[player:getId()] = {}
	     end
	     SUMMON_SELECTED[player:getId()] = summon
	     SUMMON_SYSTEM:modalWindow(player, 2, summon)
      elseif buttonId == 101 then
	     --player:unregisterEvent("SUMMON_SYSTEM_onModalWindow")
	  end
	  
   elseif modalWindowId == 32 then
      local summon = SUMMON_SELECTED[player:getId()]
      if not summon then
         return
      end
	  if buttonId == 100 then
	     SUMMON_SYSTEM:modalWindow(player, 3, summon)
	  elseif buttonId == 101 then
	     SUMMON_SYSTEM:modalWindow(player, 5, summon)
	  elseif buttonid == 102 then
	     SUMMON_SYSTEM:modalWindow(player, 1, summon)
	     --player:unregisterEvent("SUMMON_SYSTEM_onModalWindow")
	  end
    elseif modalWindowId == 33 then 
        local summon = SUMMON_SELECTED[player:getId()]
        if not summon then
           return
        end	
	    local type = ""
		if choiceId == 1 then
		   type = "increase damage"
		elseif choiceId == 2 then
		   type = "resist damage"
		elseif choiceId == 3 then
		   type = "healing"
		elseif choiceId == 4 then
           type = "health"		
		end
		if buttonId == 101 then
		   SUMMON_SYSTEM:modalWindow(player, 3, summon)
		   if not summon:addPoints(type) then
	          local text = "Summon dont have enough points."
	          player:popupFYI(text)
           else
		      summon:sendChannelMessage("You have added to summon " .. summon:getName() .. " " .. 1 .. " points to " .. type .. ".")
			  player:sendTextMessage(MESSAGE_INFO_DESCR, "You have added to summon " .. summon:getName() .. " " .. 1 .. " points to " .. type .. ".")
		   end
		   	
		elseif buttonId == 102 then
		   local value = 3
		   local added = 0
		   for i = 1, value do
		       if summon:addPoints(type) then
			      added = added + 1
			   end
		   end
		   SUMMON_SYSTEM:modalWindow(player, 3, summon)
		   if added < value then
	          local text = "Summon dont have enough points."
	          player:popupFYI(text)
	       end
		   if added > 0 then
		      summon:sendChannelMessage("You have added to summon " .. summon:getName() .. " " .. added .. " points to " .. type .. ".")
			  player:sendTextMessage(MESSAGE_INFO_DESCR, "You have added to summon " .. summon:getName() .. " " .. added .. " points to " .. type .. ".")
		   end

		elseif buttonId == 103 then
		   local value = 5
		   local added = 0
		   for i = 1, value do
		       if summon:addPoints(type) then
			      added = added + 1
			   end
		   end
		   SUMMON_SYSTEM:modalWindow(player, 3, summon)
		   if added < value then
	          local text = "Summon dont have enough points."
	          player:popupFYI(text)
	       end
		   if added > 0 then
		      summon:sendChannelMessage("You have added to summon " .. summon:getName() .. " " .. added .. " points to " .. type .. ".")
			  player:sendTextMessage(MESSAGE_INFO_DESCR, "You have added to summon " .. summon:getName() .. " " .. added .. " points to " .. type .. ".")
		   end
		elseif buttonId == 104 then  
           SUMMON_SYSTEM:modalWindow(player, 2, summon)	
		-- elseif buttonId == 105 then  
           -- player:unregisterEvent("SUMMON_SYSTEM_onModalWindow")
		end
	elseif modalWindowId == 34 then
	    local summonTable = player:getAllSummonsInBackpack()
   	    local summon = summonTable[choiceId]
	    if summon then
	       if player:removeMoney(getRequiredMoney()) then
		      player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	          summon:setAlive(true)
			  summon:setStaminaPoints(100)
			  summon:setStaminaTime()
			  player:sendTextMessage(MESSAGE_INFO_DESCR, "Your summon is revived and fully recovered.")
	       end
	    end
	
	elseif modalWindowId == 35 then
	  local summon = SUMMON_SELECTED[player:getId()]
      if not summon then
         return
      end
	  if buttonId == 100 then
	     SUMMON_SYSTEM:modalWindow(player, 2, summon)
	  end

	end
end
creatureevent:register()
	   
	
local talkaction = TalkAction("/summon")
function talkaction.onSay(player, words, param)	
    
	   
	local summonList = player:getAllSummonsInBackpack()
	if #summonList == 0 then
	   player:sendCancelMessage("You dont have any summon yet.")
	   return true
	end
   
	SUMMON_SYSTEM:modalWindow(player, 1)	
    return false
end
talkaction:separator(" ")
talkaction:register()
		 
	
	

function SUMMON_SYSTEM:getStaminaRatio()
    
	local duration = SUMMON_SYSTEM_CONFIG.stamina.ratio.value
	local method =  SUMMON_SYSTEM_CONFIG.stamina.ratio.type
	
	local interval = 0
	
	if string.find(method, "second") then
	   interval = duration
	elseif string.find(method, "minute") then
	   interval = duration * 60
	elseif string.find(method, "hour") then 
	   interval = duration * 60 * 60
	end
	
	return interval
end

function SUMMON_SYSTEM:addToDatabase(summon)
    
	if not summon then
	   return
	end
	
	if summon:getDatabase() then
	   return
	end
	
	local id = summon:getId()
	local name = summon:getName()
	local real_name = summon:getRealName()
	local kill = summon:getKills()
	local level = summon:getLevel()
	local stamina = summon:getStaminaPoints()
	local staminaTime = summon.staminaTime
	local points = summon:getPoints()
	local damage_points = summon:getPoints("increase damage")
	local resist_points = summon:getPoints("resist damage")
	local healing_points = summon:getPoints("healing")
	local health_points = summon:getPoints("health")
	local current_health = summon:getHealth()
	local max_health = summon:getMaxHealth()
	local alive = summon:isAlive()
	local itemid = summon:getItemId()
	
	return db.query("INSERT INTO `summons` (`id`, `name`, `real_name`, `kill`, `level`, `stamina`, `staminaTime`, `points`, `increase_damage_points`, `resist_damage_points`, `healing_points`, `health_points`, `current_health`, `max_health`, `alive`, `itemid`) VALUES " .. "(" .. id .. ", " .. db.escapeString(name) .. ", " .. db.escapeString(real_name) .. ", " .. kill .. ", " .. level .. ", " .. stamina .. ", " .. staminaTime .. ", " .. points .. ", " .. damage_points .. ", " .. resist_points .. ", " .. healing_points .. ", " .. health_points .. ", " .. current_health .. ", " .. max_health .. ", " .. alive .. ", " .. itemid .. ")" .. ";")
end

function SUMMON_SYSTEM:addSummon(item, monstername)

    local summon = getSummonByItem(item)
	local id = nil
	
	if summon then
	   return false
	end
	
	summon = Summon:new()
	if not summon:getDatabase() then
	   local monstertype = MonsterType(monstername)
	   if not monstertype then
	      return
	   end
	   local health = monstertype:maxHealth()
	   local id = #SUMMONS + 1
	   summon.currentHealth = health
	   summon.maxHealth = health
	   summon.real_name = monstername
	   summon.id = id
	   summon.itemid = item:getId()
	   Summon:setStaminaTime()
	   table.insert(SUMMONS, summon)
	   SUMMON_SYSTEM:addToDatabase(summon)
	end
	SUMMON_SYSTEM:addSummonToItem(item, summon)
end

function SUMMON_SYSTEM:addSummonToItem(item, summon)
    
	if not summon then
	   return
	end
	
	if not item then
	   return
	end
	
	local id = item:getCustomAttribute(SUMMON_SYSTEM_CONFIG.customAttributes.id)
	
	if not id or id ~= summon:getId() then
	   item:setCustomAttribute(SUMMON_SYSTEM_CONFIG.customAttributes.id, summon:getId())
	end
end

function getSummonByItem(item)
    if not item then
	   return false
	end
	
	local id = item:getCustomAttribute(SUMMON_SYSTEM_CONFIG.customAttributes.id)
	
	if not id then
	   return false
	end
	
	local summon = nil
	for i, v in pairs(SUMMONS) do
	    summon = SUMMONS[i]
		if summon then
		   if summon:getId() == id then
		      return summon
		   end
		end
	end
	
	return false
end

function getSummonByCreature(creature)
    
    if not creature then
	   return false
	end
	
	local id = creature:getId()	
	local summon = nil
	for i, v in pairs(SUMMONS) do
	    summon = SUMMONS[i]
		if summon then
		   if summon:getCid() == id then
		      return summon
		   end
		end
	end
	
	return false
end
	
function getSummonByPlayer(player)
    
	if not player then
	   return false
	end
	
	local creatures = player:getSummons()
	if not creatures or #creatures == 0 then
	   return false
	end
	
	for _, monster in pairs(creatures) do
	   local summon = getSummonByCreature(monster)
	   if summon then
	      return summon
	   end
	end
	return false
end

function SUMMON_SYSTEM:getExhaust(player)
  local currentTime = os.time()
  
  if not SUMMON_SYSTEM_CONFIG.PLAYERS_EXHAUST[player:getId()] then
     return false
  end
  
  if SUMMON_SYSTEM_CONFIG.PLAYERS_EXHAUST[player:getId()] > currentTime then
     return true
  end
  
  return false
end

function SUMMON_SYSTEM:setExhaust(player, value)
  
  if not SUMMON_SYSTEM_CONFIG.PLAYERS_EXHAUST[player:getId()] then
     SUMMON_SYSTEM_CONFIG.PLAYERS_EXHAUST[player:getId()] = {}
  end
  
  SUMMON_SYSTEM_CONFIG.PLAYERS_EXHAUST[player:getId()] = os.time() + value
end



function SUMMON_SYSTEM:init()
	
	local rows = db.storeQuery("SELECT * FROM `summons`")
	if rows then
		repeat
			local summon = Summon:new()
			summon.id = result.getNumber(rows, "id")
			summon.name = result.getString(rows, "name")
			summon.real_name = result.getString(rows, "real_name")
			summon.level = result.getNumber(rows, "level")
			summon.kill = result.getNumber(rows, "kill")
			summon.stamina = result.getNumber(rows, "stamina")
			summon.staminaTime = result.getNumber(rows, "staminaTime")
			summon.points = result.getNumber(rows, "points")
			summon.increase_damage_points = result.getNumber(rows, "increase_damage_points")
			summon.resist_damage_points = result.getNumber(rows, "resist_damage_points")
			summon.healing_points = result.getNumber(rows, "healing_points")
			summon.health_points = result.getNumber(rows, "health_points")
			summon.currentHealth = result.getNumber(rows, "current_health")
			summon.maxHealth = result.getNumber(rows, "max_health")
			summon.alive = result.getNumber(rows, "alive")
			summon.itemid = result.getNumber(rows, "itemid")
			table.insert(SUMMONS, summon)
		until not result.next(rows)
		result.free(rows)
	end
end

local globalevent = GlobalEvent("SUMMON_SYSTEM_onStartUp")
function globalevent.onStartup()
	SUMMON_SYSTEM:init()
	SUMMON_SYSTEM:addSpells()
	return true
end
globalevent:register()

local creatureevent = CreatureEvent("SUMMON_SYSTEM_onDeath")
function creatureevent.onDeath(creature, corpse, killer, mostDamage, unjustified, mostDamage_unjustified)
    
	if creature:isPlayer() then
	   local summon = getSummonByPlayer(creature)
	   if summon then
	      local monster = summon:getCreature()
		  if monster then
		     summon:releaseCreature()
	      end
	   end
	   return true
	end
	
    if creature and creature:isMonster() then
	   local creatureSummon = getSummonByCreature(creature)
	   if creatureSummon then
	      creatureSummon:setAlive(false)
		  creatureSummon:setStaminaPoints(0)
		  return true
	   end
	
	local player = Player(mostDamage)
	if player then
	   local party = player:getParty() 
	   if party then
	      if party:isSharedExperienceEnabled() then
	         local members = party:getMembers()
		     if members then
			    for _, member in pairs(members) do
				   local summon = getSummonByPlayer(member)
				   if summon then
				      summon:addKill(1)
					  local kills = summon:getKills()	
					  summon:sendChannelMessage("Your summon gained a kill. " .. "[" .. kills .. "/" .. summon:getRequiredKills() .. "]" .. " to advance level.")
				   end
			    end
		     end
		     local leader = party:getLeader() 
		     if leader then
		        local summon = getSummonByPlayer(leader)
				if summon then
				   summon:addKill(1)
				   local kills = summon:getKills()	
				   summon:sendChannelMessage("Your summon gained a kill. " .. "[" .. kills .. "/" .. summon:getRequiredKills() .. "]" .. " to advance level.")
				end				
		     end
			 return true
	     end
	   end 
       local summon = getSummonByPlayer(player)  
	   if summon then
		  summon:addKill(1)
		  local kills = summon:getKills()	
		  summon:sendChannelMessage("Your summon gained a kill. " .. "[" .. kills .. "/" .. summon:getRequiredKills() .. "]" .. " to advance level.")
	   end		   
	   return true
	end
		   
		   
	local summon = getSummonByCreature(mostDamage)
    if summon then 
       local master = summon:getMaster()
       if master then
          local party = master:getParty() 
	      if party then
		     if party:isSharedExperienceEnabled() then
		     local members = party:getMembers()
			 if members then
			    for _, member in pairs(members) do
				   local summon = getSummonByPlayer(member)
	               if summon then
		              summon:addKill(1)
					  local kills = summon:getKills()	
		              summon:sendChannelMessage("Your summon gained a kill. " .. "[" .. kills .. "/" .. summon:getRequiredKills() .. "]" .. " to advance level.")
	               end	
				end
			 end
			 local leader = party:getLeader() 
		     if leader then
		        local summon = getSummonByPlayer(leader)
				if summon then
				   summon:addKill(1)
				   local kills = summon:getKills()	
				   summon:sendChannelMessage("Your summon gained a kill. " .. "[" .. kills .. "/" .. summon:getRequiredKills() .. "]" .. " to advance level.")
				end				
		     end
			    return true
			 end
          end
       local summon = getSummonByPlayer(master)  
	   if summon then
		  summon:addKill(1)
		  local kills = summon:getKills()	
		  summon:sendChannelMessage("Your summon gained a kill. " .. "[" .. kills .. "/" .. summon:getRequiredKills() .. "]" .. " to advance level.")
	   end		  
	  end
    end	 
	      
		   
		   
	end
	return true
end
creatureevent:register()

creatureevent = CreatureEvent("SUMMON_SYSTEM_onLogin")
function creatureevent.onLogin(player)
   player:registerEvent("SUMMON_SYSTEM_onDeath")
   return true
end
creatureevent:register()

creatureevent = CreatureEvent("SUMMON_SYSTEM_onLogout")
function creatureevent.onLogout(player)
	   local summon = getSummonByPlayer(player)
	   if summon then
	      local monster = summon:getCreature()
		  if monster then
		     summon:releaseCreature()
	      end
	   end
   return true
end
creatureevent:register()

local DEBUG_MODE = true

creatureevent = CreatureEvent("SUMMON_SYSTEM_onHealthChange")
function creatureevent.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)    
	if not attacker or not creature then
	   return primaryDamage, primaryType, secondaryDamage, secondaryType
	end
	
    
	local value = 0
		
	if primaryType == COMBAT_HEALING then
	   local summon = getSummonByCreature(creature)
	   if not summon then
	      return primaryDamage, primaryType, secondaryDamage, secondaryType
	   end
	   local ratio = summon:getAbilityRatio("healing")
	   if ratio and ratio > 0 then
	      primaryDamage = primaryDamage + (primaryDamage * ratio)
		  secondaryDamage = secondaryDamage + (secondaryDamage * ratio)
	   end
	   return primaryDamage, primaryType, secondaryDamage, secondaryType  
	end
	
	local summon = getSummonByCreature(creature)
	if summon then
	   local ratio = summon:getAbilityRatio("resist damage")
	   if ratio and ratio > 0 then
	      if DEBUG_MODE then
		     print("Increase Resist ratio by " .. ratio * 100 .. "%")
		     print("Value Before: " .. primaryDamage)
	      end
		  primaryDamage = primaryDamage - (primaryDamage * ratio)
		  secondaryDamage = secondaryDamage - (secondaryDamage * ratio)
		  if DEBUG_MODE then
			 print("Value After: " .. primaryDamage)
		  end
	   end
	end

	if attacker:isMonster() and attacker:isFamiliar() then
	   local summon = getSummonByCreature(attacker)
	   if summon then
		  local ratio = summon:getAbilityRatio("increase damage")
		  if ratio and ratio > 0 then
		     if DEBUG_MODE then
			    print("Increase Damage ratio by " .. ratio * 100 .. "%")
			    print("Value Before: " .. primaryDamage)
			  end
			  primaryDamage = primaryDamage + (primaryDamage * ratio)
			  secondaryDamage = secondaryDamage + (secondaryDamage * ratio)
			  if DEBUG_MODE then
			     print("Value After: " .. primaryDamage)
		      end
	      end
        end	
   end		
   return primaryDamage, primaryType, secondaryDamage, secondaryType
end
creatureevent:register()

-- local figures = {
                  -- storage = 9237317,
                  -- ["knight"] = { id = 35589, looktype = 1365 },
				  -- ["paladin"] = { id = 35590, looktype = 1366 },
				  -- ["druid"] = { id = 35591, looktype = 1364 },
				  -- ["sorcerer"] = { id = 35592, looktype = 1367 },
				-- }
				
local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
   
    local t = SUMMON_SYSTEM_CONFIG["Summons"][item:getId()]
	if not t then 
       return true
	end
		
	if t.levelRequired then
	   if player:getLevel() < t.levelRequired then
	      player:sendCancelMessage("Sorry, you need atleast " .. t.levelRequired .. " level to summon this creature.")
		  return true
	   end
	end
		 
	local summon = getSummonByItem(item)
	if not summon then
	   local name = t. name
	   SUMMON_SYSTEM:addSummon(item, name)
	   summon = getSummonByItem(item)
	end
	
	local playerSummon = getSummonByPlayer(player)
	if playerSummon then
	   if summon ~= playerSummon then
	      player:sendCancelMessage("You can have only one summon summoned.")
		  return true
	   end
	   if player:hasCondition(CONDITION_INFIGHT) then
	      player:sendCancelMessage("You can't release summon with pz.")
		  return true
	   end
	   summon:releaseCreature()
	   return true
	end
	
	if summon then
	    if player:getTile():hasFlag(TILESTATE_PROTECTIONZONE) then
		   player:sendCancelMessage("You can't use summon in protection zone.")
		   return true
		end
		
		if player:isPzLocked() then
		   player:sendCancelMessage("You can't use summon while fighting with players.")
		   return true
		end
		
		if not player:hasSecureMode() then
		   player:sendCancelMessage("You can't use summon while pvp mode is turned on.")
		   return true
		end
		
		
	   local backpack = player:getSlotItem(CONST_SLOT_BACKPACK)
	   if not backpack then
	      player:sendCancelMessage("You can't use summon from ground.")
	      return true
	   end
	   if not backpack:getSummonInside(summon:getId()) then
	      player:sendCancelMessage("You can't use summon from ground.")
	      return true
	   end
	   if SUMMON_SYSTEM:getExhaust(player) then
	      player:sendCancelMessage("You are exhausted.")
	      return true
	   end
	   summon:createCreature(player)
	   SUMMON_SYSTEM:setExhaust(player, 10)
	end
	return true
end
for i, v in pairs(SUMMON_SYSTEM_CONFIG["Summons"]) do
action:id(i)
end
action:register()


action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	
	local t = SUMMON_SYSTEM_CONFIG.stamina.recoveryItems[item:getId()]
	if not t then
	   return true
	end

	local points = t.recoveryPoints
	
	if not target then
	   return true
	end
	
	local summon = getSummonByPlayer(player)
	if not summon then
	   return true
	end
	
	local creature = summon:getCreature()
	if not creature:getId() == target:getId() then
	   return true
	end
	
	
	if summon:getStaminaPoints() >= 100 then
	   player:sendTextMessage(MESSAGE_STATUS_WARNING, "Your summon has already max stamina.")
	   return true
	end
	
	local addedPoints = 0
	for i = 1, points do
		if summon:addStaminaPoints(1) then 
		   addedPoints = addedPoints + 1
		   summon.staminaTime = summon.staminaTime + SUMMON_SYSTEM:getStaminaRatio() 
		end
    end
	
	creature:say("Munch")
	
	player:sendTextMessage(MESSAGE_INFO_DESCR, "You have added " .. addedPoints .. " stamina points to " .. summon:getName() .. ".")
	if summon:getStaminaPoints() >= 100 then
	   player:sendTextMessage(MESSAGE_INFO_DESCR, "Your summon is fully recovered.")
	end
	item:remove(1)
	return true
end
for i, v in pairs(SUMMON_SYSTEM_CONFIG.stamina.recoveryItems) do
    action:id(i)
	action:allowFarUse(true)
end
action:register()


action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	
	local t = SUMMON_SYSTEM_CONFIG.potions[item:getId()]
	if not t then
	   return true
	end
	
	if not target then
	   return true
	end
	
	local summon = getSummonByPlayer(player)
	if not summon then
	   return true
	end
	
	local creature = summon:getCreature()
	if not creature:getId() == target:getId() then
	   return true
	end
		
	local value = math.random(t.min, t.max)
	creature:addHealth(value)
	creature:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
	
	item:remove(1)
	return true
end
for i, v in pairs(SUMMON_SYSTEM_CONFIG.potions) do
    action:id(i)
	action:allowFarUse(true)
end
action:register()

