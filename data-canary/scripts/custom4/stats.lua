local talkaction = TalkAction("!stats")
function talkaction.onSay(player, words, param)
    
	local currentHealth = player:getHealth()
	local maxHealth = player:getMaxHealth()
	
	local currentMana = player:getMana()
	local maxMana = player:getMaxMana()
	
	
	player:sendTextMessage(MESSAGE_STATUS_DEFAULT, "You have: " .. "\n" .. "Health: " .. currentHealth .. "/" .. maxHealth .. "\n" .. "Mana: " .. currentMana .. "/" .. maxMana)

	return false
end
talkaction:separator(" ")
talkaction:register()