local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	
	local player = Player(cid)
	local level = player:getLevel()
	local name = getCreatureName(getNpcCid())
	local index = SacraficeSystem:getNpcId(name)
	local t = SacraficeSystem:getTable(player, index)
	

	
	if msgcontains(msg, "business") or msgcontains(msg, "mission") or msgcontains(msg, "task") or msgcontains(msg, "sacrafice") then	
	   if not t then
	      npcHandler:say("Sorry, I dont have anymore {sacrafices} for you.", cid)
	      return true
	   end
	   
	   local requiredLevel = t.requiredLevel
	   
	   if level < requiredLevel then
	      npcHandler:say("You need " .. requiredLevel .. " level to process {Sacrafice}.", cid) 
	      return true
	   end
	   
	   local rewardString = ""
	   
	   local method_name = t.method.name
	   local value = t.method.value
	   local str = "not set"
	   
	   if method_name == "sacrafice level" then
	      str = "levels"
	   elseif method_name == "sacrafice capacity" then
	      str = "capacity"
	   end
	   
	   local rewardsTable = t.rewards
	   local rewardString = SacraficeSystem:addReward(player, rewardsTable, false, true, true)
		  
	   npcHandler:say("Okay, you have to sacrafice " .. value .. " " .. str .. ". And i will give you " ..  rewardString .. " Are you sure?", cid) 
	   npcHandler.topic[cid] = 2
	   return true
	end
	
	if msgcontains(msg, "yes") then
	   if npcHandler.topic[cid] == 2 then
	   	  local method_name = t.method.name
	      local value = t.method.value
	      local str = "not set"
	      local isCapacity = false
		  if method_name == "sacrafice level" then
	         str = "levels"
	      elseif method_name == "sacrafice capacity" then
	         str = "capacity"
			 isCapacity = true
	      end

		  if isCapacity then
		     if not SacraficeSystem:sacraficeCapacity(player, value) then
			    npcHandler:say("Sorry, You dont have enough free capacity.", cid) 
				 npcHandler.topic[cid] = 0
				 return true
		     end  
		  else
	         SacraficeSystem:sacraficeLevels(player, value)
	      end		  
		  
		  local rewardsTable = t.rewards
		  local rewardString = SacraficeSystem:addReward(player, rewardsTable, false, true, true)
		  SacraficeSystem:addReward(player, rewardsTable, false, false, true)
		  npcHandler:say("Lets be it! " .. rewardString .. " for sacrafice " .. value .. " " .. str .. ".", cid) 

		  
		  
		  

		  SacraficeSystem:processMission(player, index)
		  npcHandler.topic[cid] = 0
	      return true
	   end
	end
	
	if msgcontains(msg, "no") then
	   if npcHandler.topic[cid] == 2 then
	      npcHandler:say("Then no..", cid)
		  npcHandler.topic[cid] = 0
		  return true
	   end
	end
	
    return true
end


npcHandler:setCallback(CALLBACK_ONADDFOCUS, onAddFocus)
npcHandler:setCallback(CALLBACK_ONRELEASEFOCUS, onReleaseFocus)
--npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(MESSAGE_GREET, "Hey tasty looking |PLAYERNAME| do you want to give me a taste of you ? lets do {business}.")
npcHandler:addModule(FocusModule:new())
	
	

