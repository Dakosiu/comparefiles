local permanentBuffItems = {
	[21812] = 1000041,
	[42371] = 1000042,
	[21804] = 1000043,
	[21805] = 1000044,
}

local permanentBuffConditions = {
	[1000042] = {
	    description = "You have received permanent bonus for mana and health leeching.",
		conditions = {
			{
				condition = CONDITION_ATTRIBUTES,
				params = {
					{CONDITION_PARAM_TICKS, -1},
					{CONDITION_PARAM_SKILL_MANA_LEECH_CHANCE, 100},
					{CONDITION_PARAM_SKILL_MANA_LEECH_AMOUNT, 3},
					{CONDITION_PARAM_SKILL_LIFE_LEECH_CHANCE, 100},
					{CONDITION_PARAM_SKILL_LIFE_LEECH_AMOUNT, 3},
				},
			},
			{
				condition = CONDITION_SPECIALATTRIBUTES,
				params = {
					{CONDITION_PARAM_ABSORB_ALLPERCENT, 3},
					{CONDITION_PARAM_SPECIAL_ATTACKSPEEDPERCENT, 20},
				},
			},
		},
	},
	[1000043] = {
	    description = "You have received permanent bonus for cirtial hit and chance.",
		conditions		= {
			{
				condition = CONDITION_ATTRIBUTES,
				params = {
					{CONDITION_PARAM_SKILL_CRITICAL_HIT_CHANCE, 5},
					{CONDITION_PARAM_SKILL_CRITICAL_HIT_DAMAGE, 5},
				},
			},
		},
	},
	[1000044] = {
	    description = "You have received permanent bonus for healing and magic level.",
		conditions = {
			{
				condition = CONDITION_ATTRIBUTES,
				params = {
					{CONDITION_PARAM_BUFF_HEALINGRECEIVED, 110},
					{CONDITION_PARAM_BUFF_HEALINGDEALT, 110},
					{CONDITION_PARAM_STAT_MAGICPOINTS, 2},
				},
			},
		},
	},
	[1000041] = {
	    description = "You have received 10% permanent bonus for gain experience.",
		value = 0.1
	},
}

function Player.getPermanentBuffs(player)
	for storage, data in pairs(permanentBuffConditions) do
		if player:getStorageValue(storage) ~= -1 then
		   if data.conditions then
			  for _, conditionData in pairs(data.conditions) do
				local con = Condition(conditionData.condition, CONDITIONID_DEFAULT)
				if not con then
				   return true
				end
				con:setParameter(CONDITION_PARAM_TICKS, -1)
				con:setParameter(CONDITION_PARAM_SUBID, storage)
				for _, param in pairs(conditionData.params) do
					con:setParameter(param[1], param[2])
				end
				player:addCondition(con)
			end
		  end
		end
	end
end

local permanentBuffAction = Action()

function permanentBuffAction.onUse(player, item, fromPosition, itemEx, toPosition, isHotkey)
	local storage = permanentBuffItems[item:getId()]
	if player:getStorageValue(storage) ~= -1 then
		player:sendCancelMessage("You already have this buff")
		item:getPosition():sendMagicEffect(CONST_ME_POFF)
		return true
	end
	item:getPosition():sendMagicEffect(CONST_ME_FIREAREA)
	player:setStorageValue(storage, 1)
	
	local t = permanentBuffItems[item:getId()]	   
	local conditionTable = permanentBuffConditions[t]
	local description = conditionTable.description
	player:sendTextMessage(MESSAGE_INFO_DESCR, description)
	if conditionTable.value then
	   player:addExperienceBonus(conditionTable.value)
	end
	player:getPermanentBuffs()
	item:remove(1)
	return true
end

for itemId, _ in pairs(permanentBuffItems) do
	permanentBuffAction:id(itemId)
end
permanentBuffAction:register()

local permanentBuffLogin = CreatureEvent("permanentBuffLogin")

function permanentBuffLogin.onLogin(player)
	player:getPermanentBuffs()
	return true
end

permanentBuffLogin:register()


local permanentBuffTalkAction = TalkAction("!dungeonbonus")

function permanentBuffTalkAction.onSay(player, words, param)
	local window = ModalWindow {
		title = "Dungeon Bonus",
		message = "Here will you see all the bonuses you have! Good Job!",
	}
	for itemId, storage in pairs(permanentBuffItems) do
		if player:getStorageValue(storage) ~= -1 then
			window:addChoice(ItemType(itemId):getName())
		end
	end
	window:addButton("Close")
	window:sendToPlayer(player)
	return false
end

permanentBuffTalkAction:separator(" ")
permanentBuffTalkAction:register()