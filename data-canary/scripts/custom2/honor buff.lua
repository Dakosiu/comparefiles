local creaturescript = CreatureEvent("HonorBuff_onHealthChange")
function creaturescript.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    	      	  
          if not creature or not attacker then
		     local developer = false
			 if developer then
                if not creature then
				   print("[DEVELOPER_MODE] - [Honor Buff] - [Error] - creature = NILL.")
				end
				if not attacker then
				   print("[DEVELOPER_MODE] - [Honor Buff] - [Error] - attacker = NILL.")
				end
			end
	         return primaryDamage, primaryType, secondaryDamage, secondaryType
	      end

	      local player = Player(creature)
	      if player then
		     if primaryType == COMBAT_HEALING then
			    local buff = player:getHonorBuff("Gold") 
			    if buff then
				   local t = HONOR_BUFF_SYSTEM["Honor Buffs"][buff.Table]
			       local increaseHealing = t.increaseHealing
			       if increaseHealing then
			          local percentage = increaseHealing / 100
			                  local developer = false
			                  if developer then
					  -- print("[DEVELOPER_MODE] - [Honor Buff] - Player: " .. player:getName() .. " Healed Value: " .. primaryDamage)
		              -- primaryDamage = (primaryDamage + (primaryDamage * percentage))
					  -- print("[DEVELOPER_MODE] - [Honor Buff] - Player: " .. player:getName() .. " Increased Healed Value by: " .. percentage * 100 .. "%" .. " Value: " .. primaryDamage)
					  end
				      return primaryDamage, primaryType, secondaryDamage, secondaryType
				   end
				end
			 else
			     local buff = player:getHonorBuff("Gold") 
				 if buff then
				    local t = HONOR_BUFF_SYSTEM["Honor Buffs"][buff.Table]
				    local increaseResist = t.increaseResist
				    if increaseResist then
				       local percentage = increaseResist / 100
				           local developer = false
				           if developer then
					          print("[DEVELOPER_MODE] - [Honor Buff] - Player: " .. player:getName() .. " Received Damage Value: " .. primaryDamage)
						   end
						      primaryDamage = (primaryDamage - (primaryDamage * percentage))
						   if developer then
					          print("[DEVELOPER_MODE] - [Honor Buff] - Player: " .. player:getName() .. " Decreased Damage Value by: " .. percentage * 100 .. "%" .. " Value: " .. primaryDamage)
						   end
				       return primaryDamage, primaryType, secondaryDamage, secondaryType
			        end
				 end
			  end
		   end
		   
		   player = Player(attacker)
		   if player then
		      if primaryType ~= COMBAT_HEALING then
			     local buff = player:getHonorBuff("Gold") 
				 if buff then
				    local t = HONOR_BUFF_SYSTEM["Honor Buffs"][buff.Table]
				    local increaseDamage = t.increaseDamage
				    if increaseDamage then
				       local percentage = increaseDamage / 100
					   local developer = false
					   if developer then
					      print("[DEVELOPER_MODE] - [Honor Buff] - Player: " .. player:getName() .. " Dealt Damage Value: " .. primaryDamage)
					   end
					      primaryDamage = (primaryDamage + (primaryDamage * percentage))
					   if developer then 
                       	  print("[DEVELOPER_MODE] - [Honor Buff] - Player: " .. player:getName() .. " Dealt Increased Damage Value by: " .. percentage * 100 .. "%" .. " Value: " .. primaryDamage)				
					   end
					return primaryDamage, primaryType, secondaryDamage, secondaryType
					end
				 end
			  end
			end
    
	
	return primaryDamage, primaryType, secondaryDamage, secondaryType
end
creaturescript:register()

creaturescript = CreatureEvent("HonorBuff_onRemove")
function creaturescript.onThink(player)
   
   if not player then
      return true
   end

   if not player:getHonorBuff("Gold") then
      player:removeHonorBuffConditions("Gold")
   end
   
   if not player:getHonorBuff("Silver") then
      player:removeHonorBuffConditions("Silver")
   end
   
   if not player:getHonorBuff("Bronze") then
      player:removeHonorBuffConditions("Bronze")
   end
   
   return true
end
creaturescript:register()

creaturescript = CreatureEvent("HonorBuff_onLogin")
function creaturescript.onLogin(player)

player:setHonorSpeed("Silver", true)

player:registerEvent("HonorBuff_onHealthChange")
player:registerEvent("HonorBuff_onRemove")
return true
end
creaturescript:register()

local talkaction = TalkAction("!buffs")
function talkaction.onSay(player, words, param)	
   player:sendHonorBuffModal()
end
talkaction:register()

talkaction = TalkAction("!honor")
function talkaction.onSay(player, words, param)

    player:getPosition():sendMagicEffect(10)
    player:sendTextMessage(MESSAGE_STATUS_DEFAULT, "You have: " .. player:getTournamentCoinsBalance() .. " tournament coins.")
	
    return true

end
talkaction:separator(" ")
talkaction:register()

function Player.sendHonorBuffModal(self)

    if not self then
	   return nil
	end
	
	local player = Player(self)
	
	if not player then 
	  return nil
	end
	
	player:registerEvent("ModalWindow_honorbuffs")
	
	local coins = 5555
	local title = "Honor Buffs"
	local message = "Coins Balance:" .. "\n" .. "You have: " .. coins .. " Coins." .. "\n" .. "-----------------------------------" .. "List of honor buffs."
	local window = ModalWindow(1301, title, message)
	
	local index = 1
	for name, v in pairs(HONOR_BUFF_SYSTEM["Honor Buffs"]) do
	if player:getHonorBuff(name) then
	   window:addChoice(index, "[Active] " .. name)
	else
	   window:addChoice(index, name)
	end
	index = index + 1
	end
	
	window:addButton(100, "Select")
    window:addButton(101, "Cancel")     
    window:setDefaultEnterButton(100)
    window:setDefaultEscapeButton(101)
	window:sendToPlayer(player)
	
	return true
end
	
local function getHonorDescription(player, name)

      if not name or not player then
	     return nil
	  end
	  
	  	   local v = HONOR_BUFF_SYSTEM["Honor Buffs"][name]
		   local str = ""
	  
		   local firstAttribute = true
		   local increaseResist = v.increaseResist 
		   if increaseResist then
				 str = str .. "# Increase Resist by: " .. increaseResist .. "%" .. "\n"
		   end
		   
		   local increaseDamage = v.increaseResist
		   if increaseDamage then
				 str = str .. "# Increase Damage by: " .. increaseDamage .. "%" .. "\n"
		   end
		   
		   local increaseHealing = v.increaseHealing
		   if increaseHealing then
				 str = str .. "# Increase Healing by: " .. increaseHealing .. "%" .. "\n"
		   end
		   
		   local increaseSpeed = v.increaseSpeed
		   if increaseSpeed then
				 str = str .. "# Increase Speed by: " .. increaseSpeed .. "%" .. "\n"
		   end
		   
		   local increaseCap = v.increaseCap
		   if increaseCap then
				 str = str .. "# Increase Cap by: " .. increaseCap .. "%" .. "\n"
		   end
		   
		   local regeneration = v.Regeneration
		   if regeneration then
		         str = str .. "# Health Regeneration: " .. regeneration .. "\n"
				 str = str .. "# Mana Regeneration: " .. regeneration .. "\n"
		   end	
		   
		   str = str .. "-----------------------------------"
		   str = str .. "\n" .. "Buff Cost: " .. v.requiredCoins .. " Coins." .. "\n"
		str = str .. "-----------------------------------"
           local isActive = player:getHonorBuff(name)
		   if isActive then
		      str = str .. "\n" .. "This buff is active: "
              str = str .. "\n" .. "It will end at: " .. "\n" .. isActive["Timeleft"]
           else			  
		      str = str .. "\n" .. "This buff is not active."
		   end
		   
	return str or false
end
	  
local creaturescript = CreatureEvent("ModalWindow_honorbuffs")
function creaturescript.onModalWindow(player, modalWindowId, buttonId, choiceId) 
             
       if modalWindowId == 1301 then
	     if buttonId == 101 then
		    return true
	     end
		 
		 local buffName = nil
		 
		 local index = 1
	     for name, v in pairs(HONOR_BUFF_SYSTEM["Honor Buffs"]) do
		     if choiceId == index then
		        buffName = name
				break
			 end
			 index = index + 1
		 end
		 
		 player:unregisterEvent("ModalWindow_honorbuffs")
		 player:registerEvent("ModalWindow_honorbuffs2")
		 
		 local coins = 1000000
		 local title = "Honor Buff" .. " - " .. buffName
         local message = "Coins Balance:" .. "\n" .. "You have: " .. coins .. " Coins." .. "\n" .. "-----------------------------------" .. "\n" .. "This buff give: " .. "\n" .. getHonorDescription(player, buffName)
		 
		  
		 local window = ModalWindow(1302, title, message)
		 window:addButton(101, "Back")     
         window:setDefaultEnterButton(101)
         window:setDefaultEscapeButton(101)
		 window:sendToPlayer(player)
		
		end 

		 
		 
end
creaturescript:register()
	
local creaturescript = CreatureEvent("ModalWindow_honorbuffs2")
function creaturescript.onModalWindow(player, modalWindowId, buttonId, choiceId) 
     
	 if modalWindowId == 1302 then
        player:unregisterEvent("ModalWindow_honorbuffs2")
	    player:sendHonorBuffModal()
	 end
end
creaturescript:register()
