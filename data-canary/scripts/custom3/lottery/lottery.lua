LOTTERY_SYSTEM_CONFIG = {
                          minLevel = 100,
                          ["Scheduler"] = { type = "minutes", interval = 6 },						  
                          ["Avaible Rewards"] = {
						                          { type = "item", itemid = "3032", count = 1, chance = 0.10 },
						                          { type = "item", itemid = "3043", count = 1, chance = 0.15 },
												  { type = "item", itemid = "3035", count = 1, chance = 0.05 },
												  { type = "item", itemid = "3029", count = 1, chance = 0.50 },
												  { type = "item", itemid = "5957", count = 1, chance = 0.50 },
										        }
				        }

if not Lottery then
   Lottery = {}
end
Lottery.storage = 332321

function Lottery:prepare()
    
	local minute = 60 * 1000
    Game.broadcastMessage('[Lottery] Lottery Started, to join the lottery type "!lottery", winner will be drawn in 5 minutes.')
	Lottery:setRegister(true)
 
    addEvent(function()
		Game.broadcastMessage('[Lottery] winner will be drawn in 4 minutes, to join the lottery type "!lottery"')
    end, 1 * minute)
	
    addEvent(function()
		Game.broadcastMessage('[Lottery] winner will be drawn in 3 minutes, to join the lottery type "!lottery"')
    end, 2 * minute)  	
		
    addEvent(function()
		Game.broadcastMessage('[Lottery] winner will be drawn in 2 minutes, to join the lottery type "!lottery"')
    end, 3 * minute)  
	
	addEvent(function()
		Game.broadcastMessage('[Lottery] winner will be drawn in 1 minutes, to join the lottery type "!lottery"')
    end, 4 * minute) 
	
	addEvent(function()
	    Lottery:setRegister(false)
		Lottery:finish()
    end, 5 * minute) 
	
end
	
function Lottery:isParticipant(player)
    
	if not player then
	   return nil
	end
	
	if not Lottery.participants then
	   return false
	end
	
	local id = player:getId()
	for i, v in pairs(Lottery.participants) do
	    if v == id then
		   return true
		end
    end

	return false
end
	
function Lottery:addParticipant(player)
    
	if not Lottery.participants then
	   Lottery.participants = {}
	end
	
	local id = player:getId()
	Lottery.participants[#Lottery.participants + 1] = id
end

function Lottery:getParticipants()
    
	local participants = {}
	
	if not Lottery.participants then
	   return participants
	end
	
	for i, v in pairs(Lottery.participants) do
	    local player = Player(v)
		if player then
		   local id = player:getId()
		   participants[#participants + 1] = id
		end   
	end	
	
	return participants 
end

function Lottery:getScheduler()  
    
    local t = LOTTERY_SYSTEM_CONFIG["Scheduler"]
	
	local method = t.type
	if not method then
	   return nil
	end
	
	local duration = t.interval
	if not duration then
	   return nil
	end
	
	if string.find(method, "second") then
	   interval = duration
	elseif string.find(method, "minute") then
	   interval = duration * 60
	elseif string.find(method, "hour") then 
	   interval = duration * 60 * 60
	end
	return interval * 1000
end

function Lottery:finish()
    Lottery:setRegister(false)
    local participants = Lottery:getParticipants()
		
	if #participants == 0 then
	   Game.broadcastMessage('[Lottery]: Lottery ended, no participants', MESSAGE_GAME_HIGHLIGHT)
       return
    end

    local winnerId = participants[math.random(#participants)]
	local winner = Player(winnerId)
	if winner then
	   local t = LOTTERY_SYSTEM_CONFIG["Avaible Rewards"]
	   local rewardTable = dakosLib:getSingleReward(t)
	   
	   local id = tonumber(rewardTable["itemid"])
	   local count = tonumber(rewardTable["count"])
	   winner:addItem(id, count)
	   winner:getPosition():sendMagicEffect(CONST_ME_HEARTS)
	   Game.broadcastMessage("[Lottery] " .. winner:getName() .. " won the lottery and received " .. count .. "x " .. getItemName(id) .. " as reward. Congratulations!", MESSAGE_GAME_HIGHLIGHT)  
	end
	Lottery.participants = {}
end

function Lottery:canRegister()
	if not Lottery.enabled then
	   return false
	end
	return true
end

function Lottery:setRegister(bool)
	if bool then
	   Lottery.enabled = true
	else
	   Lottery.enabled = false
	end
end

local talkaction = TalkAction("!lottery")
function talkaction.onSay(player, words, param)
    
	local minLevel = LOTTERY_SYSTEM_CONFIG.minLevel
	   if player:getLevel() < minLevel then
	      player:sendCancelMessage("You need to be atleast " .. minLevel .. " level to join the lottery.")
		  return false
	   end
	   if Lottery:isParticipant(player) then
	      player:sendCancelMessage("You already participating the lottery.")
		  return false
	   end
	   if not Lottery:canRegister() then
	      player:sendCancelMessage("register is closed.")
		  return false
	   end
	   Lottery:addParticipant(player)
	   player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
	   player:sendTextMessage(MESSAGE_INFO_DESCR, "You have joined to the lottery.")
	
	return false
end
talkaction:separator(" ")
talkaction:register()

local globalevent = GlobalEvent("Lottery_onThink")
function globalevent.onThink(interval)
   Lottery:prepare()
   return true
end
globalevent:interval(Lottery:getScheduler())
globalevent:register()
	
	