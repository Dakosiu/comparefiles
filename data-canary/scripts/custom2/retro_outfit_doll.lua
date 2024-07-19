local possibleOutfits = {
	{female = 963, male = 962, name = "Retro Warrior"},
	{female = 965, male = 964, name = "Retro Summoner"},
	{female = 967, male = 966, name = "Retro Noble"},
	{female = 969, male = 968, name = "Retro Mage"},
	{female = 971, male = 970, name = "Retro Knight"},
	{female = 973, male = 972, name = "Retro Hunter"},
	{female = 975, male = 974, name = "Retro Citizen"},
}

local outfitDollID = 9145

function Player.pickOutfit(player, data)
	if player:removeItem(outfitDollID, 1) then
		player:addOutfit(player:getSex() == PLAYERSEX_FEMALE and data.female or data.male)
		player:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
		player:sendCancelMessage("You got the " .. data.name .. "!")
		return true
	end
end

local retroOutfitAction = Action()

function retroOutfitAction.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local window = ModalWindow {
		title = "Retro Outfit Doll",
		message = "Choose an outfit for receiving it"
	}
	local usedOutfits = {}
	for _, data in pairs(possibleOutfits) do
		if not player:hasOutfit(player:getSex() == PLAYERSEX_FEMALE and data.female or data.male) then
			usedOutfits[#usedOutfits + 1] = data
			window:addChoice(data.name)
		end
	end
	window:addButton("Close")
	if #usedOutfits == 0 then
		window:addChoice("You have all the outfits.")
	else
		window:addButton("Choose", function(button, choice) 
			player:pickOutfit(usedOutfits[choice.id])
		end)
	end
	window:sendToPlayer(player)
	return true
end

retroOutfitAction:id(outfitDollID)
retroOutfitAction:register()