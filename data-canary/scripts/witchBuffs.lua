function Player.addWitchBuff(player)
	local value = player:getStorageValue(30002)
	if value < 8 then return false end
	local condition = Condition(CONDITION_ATTRIBUTES)
	if value >= 8 then
		condition:setParameter(CONDITION_PARAM_SKILL_CRITICAL_HIT_DAMAGE, 3)
	end
	if value >= 9 then
		condition:setParameter(CONDITION_PARAM_MANAGAIN, 10)
		condition:setParameter(CONDITION_PARAM_MANATICKS, 4000)
	end
	condition:setParameter(CONDITION_PARAM_TICKS, -1)
	condition:setParameter(CONDITION_PARAM_SUBID, 30002)
	player:addCondition(condition)
	return true
end

function Player.addWitchProgress(self)
	local key = 52423
	local value = self:getWitchProgress()
	if value >= 10 then
	   return
	end
	return self:setStorageValue(key, value + 1)
end

function Player.getWitchProgress(self)
    local key = 52423
	local value = self:getStorageValue(key)
	if value < 0 then
	   value = 0
	end
	return value
end

function Player.canUseKettle(self)
	if self:getWitchProgress() >= 10 then
	   return true
	end
	return false
end

function Player.sendWitchKettleProgress(self)

    local value = self:getWitchProgress()
	if value >= 10 then
	   return "You have won all games with witch, you can use kettle already"
	end
	
	return "You need to win " .. 10 - value .. " more games to unlock the kettle."
end

	

local witchBuffs = CreatureEvent("witchBuffs")
function witchBuffs.onLogin(player)
	player:addWitchBuff()
	return true
end
witchBuffs:register()


local CRAFTABLE_PotionS = {
	[1] = {itemObtained = {20139, 1}, name = "Magic Potion HP", requiredItems = {{42373, 1}}},
	[2] = {itemObtained = {20138, 1}, name = "Magic Potion MP", requiredItems = {{42373, 1}}},
}

function confirmCraft(player, id)
	local data = CRAFTABLE_PotionS[id]
	if not data then return false end
	local notEnough = false
	for _, item in pairs(data.requiredItems) do
		if player:getItemCount(item[1]) < item[2] then
			notEnough = true
			break
		end
	end
	local window
	if notEnough then
		window = ModalWindow {
			title = "Error",
			message = "You don't have the required materials.",
		}
		window:addButton("Back", function() witchSoupKettle(player) end)
	else
		for _, item in pairs(data.requiredItems) do
			player:removeItem(item[1], item[2])
		end
		window = ModalWindow {
			title = "Witch's Soup Kettle",
			message = "The magic Potion crafting was a success!"
		}
		player:addItem(data.itemObtained[1], data.itemObtained[2])
		window:addButton("Back", function() openCraftDialog(player, id) end)
	end
	window:sendToPlayer(player)
	return true
end

function openCraftDialog(player, id)
	local data = CRAFTABLE_PotionS[id]
	if not data then return false end
	local text = "You are crafting " .. data.itemObtained[2] .. "x " .. data.name .. ", to do so you will need:"
	for _, item in pairs(data.requiredItems) do
		text = text .. "\n" .. item[2] .. "x " .. ItemType(item[1]):getName()
	end
	
	local window = ModalWindow {
		title = "Witch's Soup Kettle",
		message = text .. "\n\nDo you wish to proceed?",
	}
	window:addButton("Craft", function() confirmCraft(player, id) end)
	window:addButton("Back", function() witchSoupKettle(player) end)
	window:sendToPlayer(player)
	return true
end
function witchSoupKettle(player)
	local window = ModalWindow {
		title = "Witch's Soup Kettle",
		message = "The witch has allowed you to craft magic Potions in her soup kettle. \n\nWhich will it be?"
	}
	for _, data in ipairs(CRAFTABLE_PotionS) do
		window:addChoice(data.name)
	end
	window:addButton("Craft", function(button, choice) openCraftDialog(player, choice.id) end)
	window:addButton("Exit")
	window:sendToPlayer(player)
	return true
end

local witchSoupKettleAction = Action()

function witchSoupKettleAction.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	-- if player:getStorageValue(30001) ~= 1 then
		-- player:sendCancelMessage("You have not been allowed by the witch to use her soup kettle.")
	-- else
		-- witchSoupKettle(player)
	-- end
	
	if not player:canUseKettle() then
	   player:sendCancelMessage("You have not been allowed by the witch to use her soup kettle.")
	   return true
	end
	
	witchSoupKettle(player)
	return true
end

witchSoupKettleAction:id(11811)
witchSoupKettleAction:register()