BOSS_SYSTEM_CONFIG = {
					   ["Bosses"] = {
                                      ["dragon lord"] = { 
									                      ["Boss Position"] = { x = 949, y = 1126, z = 7 },
									                      ["Event Finish"] = { value = 30, type = "minutes", _sendReminder = true },
									                      ["Scheduler"] = { 
														                    ["Monday"] = { "15:00", "17:00" },  --opcje: Monday, Tuesday, Wednesday, Thursday, Friday, Saturday oraz Sunday + Everyday
																		    ["Wednesday"] = { "20:00", "16:00" },
																		    ["Saturday"] = { "12:45", "12:43" },
														                  },																	 
									                   },	
                                      ["demon"] = { 
									                      ["Boss Position"] = { x = 944, y = 1134, z = 7 },
									                      ["Event Finish"] = { value = 30, type = "minutes", _sendReminder = true },
									                      ["Scheduler"] = { 
														                    ["Monday"] = { "15:00", "17:00" },
																		    ["Wednesday"] = { "20:00", "16:00" },
																		    ["Saturday"] = { "12:45", "12:43" },
														                  },																	 
									                   },													   
					               },
					 }

local DEVELOPER_MODE = true --- true =  zamiast czekac 10 minut na start eventu, czeka sie znacznie krocej (bardziej do testow)

if not BOSS_SYSTEM then
   BOSS_SYSTEM = {}
end

-- local talk = TalkAction("/bosstest", "!bosstest") -- tu byla funkcja na wywolanie bossa za pomoca komendy, "!bosstest dragon lord"
-- function talk.onSay(player, words, param)
	-- BOSS_SYSTEM:prepare(param)
	-- return false
-- end
-- talk:separator(" ")
-- talk:register()

function BOSS_SYSTEM:prepare(name)

	local t = BOSS_SYSTEM_CONFIG["Bosses"][name]
	if not t then
	   return nil
	end

	BOSS_SYSTEM:clean(name)
	local minute = 0
	if DEVELOPER_MODE then
	   minute = 60 * 100
	else
	   minute = 60 * 1000
	end
	
    Game.broadcastMessage("[Boss] " .. name .. " will respawn in 10 minutes.")
	BOSS_SYSTEM.canRegister = true
 
    addEvent(function()
		Game.broadcastMessage("[Boss] " .. name .. " will respawn in 5 minutes.")
    end, 5 * minute)
	
    addEvent(function()
		Game.broadcastMessage("[Boss] " .. name .. " will respawn in 3 minutes.")
		Game.broadcastMessage("[Boss] " .. name .. " will respawn in 1 minute.")
    end, 9 * minute)  	
	
    addEvent(function()
    end, 7 * minute)	
	
    addEvent(function()
		Game.broadcastMessage("[Boss] " .. name .. " respawned!. Good Luck.")
		BOSS_SYSTEM:start(name)
		BOSS_SYSTEM.canRegister = false
    end, 10 * minute) 
end

function BOSS_SYSTEM:clean(bossName)
	BOSS_SYSTEM:removeBoss(bossName)
end
	
function BOSS_SYSTEM:timeout(bossName)

    local name = bossName

	local t = BOSS_SYSTEM_CONFIG["Bosses"][name]
	if not t then
	   return nil
	end
	
	if BOSS_SYSTEM:isAlive(bossName) then
	   Game.broadcastMessage("[Boss] " .. name .. " Timeout! The event has ended.")
	   BOSS_SYSTEM:clean(bossName)
	end
end
	
function BOSS_SYSTEM:start(name)
	BOSS_SYSTEM:createBoss(name)
	BOSS_SYSTEM:setTime(name)
end

function BOSS_SYSTEM:finish(name)
    	
   	local t = BOSS_SYSTEM_CONFIG["Bosses"][name]
	if not t then
	   return nil
	end
			
    Game.broadcastMessage("[Boss] " .. name .. " has been defeated. Congratulations!")
	BOSS_SYSTEM:clean(name)
end
	
function BOSS_SYSTEM:setTime(name)    
	local method = BOSS_SYSTEM_CONFIG["Bosses"][name]["Event Finish"].type
	if not method then
	   return nil
	end
	
	local duration = BOSS_SYSTEM_CONFIG["Bosses"][name]["Event Finish"].value
	if not duration then
	   return nil
	end

	if string.find(method, "second") then
	   interval = duration + os.time()
	elseif string.find(method, "minute") then
	   interval = duration * 60 + os.time()
	elseif string.find(method, "hour") then 
	   interval = duration * 60 * 60 + os.time()
	end
	
	if not BOSS_SYSTEM.time then
	   BOSS_SYSTEM.time = {}
	end
	BOSS_SYSTEM.time[name] = interval
end

function BOSS_SYSTEM:getTime(method, name) 
    
	if not BOSS_SYSTEM.time then
	   return -1
	end
	
	local duration = BOSS_SYSTEM.time[name]
	if not duration then
	   return -1
	end
	
	if duration < os.time() then
	   return false
	end
	
	local time_string = ""

    local time_left = duration - os.time()
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
			    
function BOSS_SYSTEM:sendMessage(msg)
   	if not msg then
	   return nil
	end
	Game.broadcastMessage(msg)
end

function BOSS_SYSTEM:isAlive(name)
    
	if not BOSS_SYSTEM.bosses then
	   return false
	end
	
	local id = BOSS_SYSTEM.bosses[name]
	if not id then
	   return false
	end
	
	local monster = Monster(id)
	if monster then
	   return true
	end
	return false
end
	
function BOSS_SYSTEM:removeBoss(bossName)

	if not BOSS_SYSTEM.bosses then
	   return false
	end
	
	local id = BOSS_SYSTEM.bosses[bossName]
	if not id or id == 0 then
	   return false
	end
	local monster = Monster(id)
	if monster then
	   monster:remove()
	   BOSS_SYSTEM.bosses[bossName] = nil
	end
end

function BOSS_SYSTEM:createBoss(name)
    
	local t = BOSS_SYSTEM_CONFIG["Bosses"][name]
	if not t then
	   return nil
	end
	
	
	local bossPosition = t["Boss Position"]
	
	local x = bossPosition.x
	local y = bossPosition.y
	local z = bossPosition.z
	
	local pos = Position(x, y, z)
	if not pos then
	   return nil
	end
	
	if not BOSS_SYSTEM.bosses then
	   BOSS_SYSTEM.bosses = {}
	end
	
	
	BOSS_SYSTEM:removeBoss(name)
	local monster = Game.createMonster(name, pos)
	if monster then
	   monster:registerEvent("BOSS_SYSTEM_onDeath")
	   local id = monster:getId()
	   BOSS_SYSTEM.bosses[name] = id
	end
end

local creatureevent = CreatureEvent("BOSS_SYSTEM_onDeath")
function creatureevent.onDeath(creature, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)
	
	local boss = Monster(creature)
	if boss then
	   BOSS_SYSTEM:finish(boss:getName():lower())
	end

	return true
end
creatureevent:register()


BOSS_SYSTEM.canSendReminder = true
globalevent = GlobalEvent("BOSS_SYSTEM_onThink")
function globalevent.onThink(interval, lastExecution)	
		
	if not BOSS_SYSTEM.canSendReminder then
	   return true
	end
	
	local schedulerTable = BOSS_SYSTEM_CONFIG["Scheduler"]
	local currentTime = os.date("%H:%M")
	local currentDay = os.date("%A")
	
	for bossName, v in pairs(BOSS_SYSTEM_CONFIG["Bosses"]) do
	    for day, timeTable in pairs(v["Scheduler"]) do
			if day == currentDay or day == "Everyday" then
			   if isInArray(timeTable, currentTime) then
			      BOSS_SYSTEM:prepare(bossName)
				  BOSS_SYSTEM.canSendReminder = false
	              addEvent(function()
                     BOSS_SYSTEM.canSendReminder = true
                  end, 1 * 1000 * 60)
                end 
            end				
	    end
	
	if BOSS_SYSTEM:isAlive(bossName) then
       local getTime = BOSS_SYSTEM:getTime(false, bossName) 
	   if getTime then
	      local minutes = BOSS_SYSTEM:getTime(true, bossName)
	      if minutes == "15" or minutes == "10" or minutes == "05" or minutes == "03" or minutes == "01" then
		     local _shouldSend = v["Event Finish"]._sendReminder
		     if not _shouldSend then
		        return true
	         end
		  
	         local str = "[Boss] " .. bossName .. " will end at: " .. getTime .. " hurry up!."
	         BOSS_SYSTEM:sendMessage(str)
	         BOSS_SYSTEM.canSendReminder = false
	         addEvent(function()
                 BOSS_SYSTEM.canSendReminder = true
             end, 1 * 1000 * 60)
	       end
	   else
	      BOSS_SYSTEM:timeout(bossName)
	   end
	  end
	end
	return true
end
globalevent:interval(1000)
globalevent:register()