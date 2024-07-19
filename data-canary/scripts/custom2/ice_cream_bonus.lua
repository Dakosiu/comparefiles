local hpCone = Condition(CONDITION_ATTRIBUTES)
hpCone:setParameter(CONDITION_PARAM_TICKS, 60 * 60 * 1000)
hpCone:setParameter(CONDITION_PARAM_SUBID, 55501)
hpCone:setParameter(CONDITION_PARAM_STAT_MAXHITPOINTS, 500)

local mpCone = Condition(CONDITION_ATTRIBUTES)
mpCone:setParameter(CONDITION_PARAM_TICKS, 60 * 60 * 1000)
mpCone:setParameter(CONDITION_PARAM_SUBID, 55502)
mpCone:setParameter(CONDITION_PARAM_STAT_MAXMANAPOINTS, 500)

local skillCone = Condition(CONDITION_ATTRIBUTES)
skillCone:setParameter(CONDITION_PARAM_TICKS, 60 * 60 * 1000)
skillCone:setParameter(CONDITION_PARAM_SUBID, 55503)
skillCone:setParameter(CONDITION_PARAM_SKILL_MELEE, 5)
skillCone:setParameter(CONDITION_PARAM_SKILL_DISTANCE, 5)
skillCone:setParameter(CONDITION_PARAM_STAT_MAGICPOINTS, 2)

local regenCone = Condition(CONDITION_REGENERATION)
regenCone:setParameter(CONDITION_PARAM_TICKS, 60 * 60 * 1000)
regenCone:setParameter(CONDITION_PARAM_SUBID, 55504)
regenCone:setParameter(CONDITION_PARAM_HEALTHGAIN, 25)
regenCone:setParameter(CONDITION_PARAM_HEALTHTICKS, 1000)
regenCone:setParameter(CONDITION_PARAM_MANAGAIN, 25)
regenCone:setParameter(CONDITION_PARAM_MANATICKS, 1000)

local cones = {
	[7375] = {name = "Health Cone", condition = hpCone, effect = 222},
	[7377] = {name = "Mana Cone", condition = mpCone, effect = 226},
	[7372] = {name = "Skills Cone", condition = skillCone, effect = 225},
	[7376] = {name = "Regeneration Cone", condition = regenCone, effect = 224},
}

local conesAction = Action()

function conesAction.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local data = cones[item:getId()]
	if not data then return false end
	if player:getCondition(data.condition:getType(), CONDITIONID_COMBAT, data.condition:getSubId()) then
		player:sendCancelMessage("You are already under the effects of this cone.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return true
	end
	item:remove(1)
	player:addCondition(data.condition)
	player:getPosition():sendMagicEffect(data.effect)
	player:sendCancelMessage("You have eaten a " .. data.name .. ".")
	return true
end

for itemId, _ in pairs(cones) do
	conesAction:id(itemId)
end

conesAction:register()

local conesTalkAction = TalkAction("!icebonus")

function conesTalkAction.onSay(player, words, param)
	local effects = ""
	for _, data in pairs(cones) do
		local condition = player:getCondition(data.condition:getType(), CONDITIONID_COMBAT, data.condition:getSubId())
		if condition then
			local ticks = condition:getTicks()/1000
			local hours = math.floor(ticks/3600)
			ticks = ticks - hours * 3600
			local minutes = math.floor(ticks/60)
			ticks = ticks - minutes * 60
			effects = effects .. "\n" .. data.name .. " : " .. hours .. "h " .. minutes .. "m " .. ticks .. "s"
		end
	end
	player:popupFYI(effects == "" and "You are not under the effect of any ice cream cones." or ("You are under the effects of the following ice cream cones:\n" .. effects))
	return false
end

conesTalkAction:separator(" ")
conesTalkAction:register()
	