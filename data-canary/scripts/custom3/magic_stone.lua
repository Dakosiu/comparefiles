local magicPotionHp = Condition(CONDITION_ATTRIBUTES)
magicPotionHp:setParameter(CONDITION_PARAM_SUBID, 30000)
magicPotionHp:setParameter(CONDITION_PARAM_TICKS, 60 * 60 * 1000)
magicPotionHp:setParameter(CONDITION_PARAM_STAT_MAXHITPOINTS, 400)

local magicPotionMp = Condition(CONDITION_ATTRIBUTES)
magicPotionMp:setParameter(CONDITION_PARAM_SUBID, 30001)
magicPotionMp:setParameter(CONDITION_PARAM_TICKS, 60 * 60 * 1000)
magicPotionMp:setParameter(CONDITION_PARAM_STAT_MAXMANAPOINTS, 400)

local data = {
	[20139] = {magicPotionHp, CONST_ME_MAGIC_RED, "Health Magic Potion"},
	[20138] = {magicPotionMp, CONST_ME_MAGIC_BLUE, "Mana Magic Potion"},
}

local magicPotionAction = Action()

function magicPotionAction.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local itemData = data[item:getId()]
	if not itemData then return false end
	if not target or target ~= player then
		player:sendCancelMessage("You must use this on yourself.")
		return true
	end
	if player:getCondition(itemData[1]:getType(), CONDITIONID_COMBAT, itemData[1]:getSubId()) then
		player:sendCancelMessage("You already are under the effects of this magic potion")
		item:getTopParent():getPosition():sendMagicEffect(CONST_ME_POFF)
	else
		player:sendCancelMessage("The magic potion vanishes as it empowers you. Use the command !magicpotion to check the remaining time")
		player:getPosition():sendMagicEffect(itemData[2])
		player:addCondition(itemData[1])
		item:remove(1)
	end
	return true
end

for itemId, _ in pairs(data) do
	magicPotionAction:id(itemId)
end

magicPotionAction:register()

local magicPotionTalkAction = TalkAction("!magicpotion")

function magicPotionTalkAction.onSay(player, words, param)
	local underEffects = ""
	for _, info in pairs(data) do
		local condition = player:getCondition(info[1]:getType(), CONDITIONID_COMBAT, info[1]:getSubId())
		if condition then
			local ticks = condition:getTicks()/1000
			local hours = math.floor(ticks/3600)
			ticks = ticks - hours * 3600
			local minutes = math.floor(ticks/60)
			ticks = ticks - minutes * 60
			underEffects = underEffects .. "\n" .. info[3] .. " : " .. hours .. "h " .. minutes .. "m " .. ticks .. "s"
		end
	end
	if underEffects ~= "" then
		player:popupFYI("You are under the following effects:\n" .. underEffects)
	else
		player:popupFYI("You are not under the effects of any magic potion")
	end
	return false
end

magicPotionTalkAction:separator(" ")
magicPotionTalkAction:register()