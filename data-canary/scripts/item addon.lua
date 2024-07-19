local config = {
                 [3239] = { male_id = 136, female_id = 128, addon = 3 },  --- 3 == full addon, 2 secondary addon only, 1 = first addon only
			   }
			   
			   

local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	
	local t = config[item:getId()]
	if not t then
	   return true
	end
	
	
	local male_id = t.male_id
	local female_id = t.female_id
	local addon = t.addon
	
	if player:hasOutfit(male_id, addon) or player:hasOutfit(female_id, addon) then
	   player:sendCancelMessage("You have already this outfit.")
	   return true
	end
	
	player:addOutfitAddon(male_id, addon)
	player:addOutfitAddon(female_id, addon, true)
	
	
	player:sendTextMessage(MESSAGE_INFO_DESCR, "You have received new outfit.")
	return true
end

for i, v in pairs(config) do
action:id(i)
end
action:register()

						  