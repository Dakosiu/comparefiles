local MISSION_BONUS_STORAGE = 305568

function Player.addMissionBonusCondition(player)
	local value = player:getMissionBonus()
	if value == 0 then return false end
	local condition = Condition(CONDITION_ATTRIBUTES)
	condition:setParameter(CONDITION_PARAM_SUBID, MISSION_BONUS_STORAGE)
	condition:setParameter(CONDITION_PARAM_STAT_MAXHITPOINTS, value * 50)
	condition:setParameter(CONDITION_PARAM_STAT_MAXMANAPOINTS, value * 50)
	condition:setParameter(CONDITION_PARAM_TICKS, -1)
	player:addCondition(condition)
	return true
end

function Player.getMissionBonus(player)
	return math.max(0, player:getStorageValue(MISSION_BONUS_STORAGE))
end

function Player.addMissionBonus(player, value)
	player:setStorageValue(MISSION_BONUS_STORAGE, player:getMissionBonus() + value)
	player:addMissionBonusCondition()
	return true
end

local loginMissionBonus = CreatureEvent("loginMissionBonus")

function loginMissionBonus.onLogin(player)
	player:addMissionBonusCondition()
	return true
end

loginMissionBonus:register()

local missionBonusTalkaction = TalkAction("!missionbonus")

function missionBonusTalkaction.onSay(player, words, param)
	local value = player:getMissionBonus()
	player:popupFYI("You actually have completed " .. value .. " quests.\n\nYou have " .. value * 50 .. "hp and " .. value * 50 .. "mp extra.")
	return false
end

missionBonusTalkaction:separator(" ")
missionBonusTalkaction:register()