local npcName = "Able Hunter"

local npcType = Game.createNpcType(npcName)
local npcConfig = {}

npcConfig.name = npcName
npcConfig.description = npcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 10

npcConfig.outfit = {
	lookType = 1449,
	lookHead = 124,
	lookBody = 114,
	lookLegs = 114,
	lookFeet = 124,
	lookAddons = 3,
	lookMount = 1335
}

npcConfig.flags = {
	floorchange = false
}

-- Create keywordHandler and npcHandler
local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)

-- onThink
npcType.onThink = function(npc, interval)
	npcHandler:onThink(npc, interval)
end

-- onAppear
npcType.onAppear = function(npc, creature)
	npcHandler:onAppear(npc, creature)
end

-- onDisappear
npcType.onDisappear = function(npc, creature)
	npcHandler:onDisappear(npc, creature)
end

-- onMove
npcType.onMove = function(npc, creature, fromPosition, toPosition)
	npcHandler:onMove(npc, creature, fromPosition, toPosition)
end

-- onSay
npcType.onSay = function(npc, creature, type, message)
	npcHandler:onSay(npc, creature, type, message)
end

-- onPlayerCloseChannel
npcType.onCloseChannel = function(npc, player)
	npcHandler:onCloseChannel(npc, player)
end

-- Function called by the callback "npcHandler:setCallback(CALLBACK_GREET, greetCallback)" in end of file
local function greetCallback(npc, player)
	npcHandler:setMessage(MESSAGE_GREET, "Witaj |PLAYERNAME|! Mozesz u mnie wziac {daily task} lub {task}. Jesli chcesz anulowac lub odebrac nagrode, wpisz odpowiednio {cancel daily}/{cancel task} lub {report daily}/{report task}.")
	return true
end

PLAYER_TASK = {}

local storages = {
                   active = 5555,
				   kils = 6666,
				   finished = 7777,
				 }

-- On creature say callback
local function creatureSayCallback(npc, player, type, msg)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, player) then
		return false
	end

	local dailyTask = player:getDailyTask()
	local tasks = player:getTasks()

	if msg == 'task' then
		if not player:canGetNewTask() then
			npcHandler:say('Mozesz wziac tylko jednego taska na raz.', npc, player)

			return
		end

		npcHandler:say('Oto dostepne taski: ' .. tasks .. '.', npc, player)
		npcHandler:setTopic(playerId, 2)

		return
	end

	if msg == 'daily task' then
		if not dailyTask then
			npcHandler:say('Nie mam chwilowo dla Ciebie zadnego dostepnego daily taska.', npc, player)

			return
		end

		if not player:canGetNewDailyTask() then
			npcHandler:say('Mozesz wziac tylko jednego daily taska na dzien. Wroc jutro.', npc, player)

			return
		end

		npcHandler:say('Mam dla Ciebie daily taska. Nazwa: {' .. dailyTask.name .. '}. Ilosc potworow do zabicia: {' .. dailyTask.count[1] .. '}-{' .. dailyTask.count[2] .. '}. Czy chcesz go przyjac?', npc, player)
		npcHandler:setTopic(playerId, 1)

		PLAYER_TASK[playerId] = dailyTask

		return
	end

	if npcHandler:getTopic(playerId) == 1 and msg == 'yes' then
		local task = PLAYER_TASK[playerId]
		local monstersToKills = math.random(task.count[1], task.count[2])

		player:setDailyTask(task.id, monstersToKills)

		npcHandler:say('Daily Task na {' .. task.name .. '} zostal aktywowany. Idz i zabij ' .. monstersToKills .. ' potworow.', npc, player)
		npcHandler:setTopic(playerId, 0)

		return
	end

	if npcHandler:getTopic(playerId) == 2 then
		local taskByName = player:getTaskByName(msg)

		if not taskByName then
			npcHandler:say('Nie ma takiego taska.', npc, player)

			return
		end

		player:setTask(taskByName)
		npcHandler:say('Task na ' .. taskByName.name .. ' zostal aktywowany. Lista potworow wliczajacych sie do taska: ' .. table.concat(taskByName.monsters, ', ') .. '. Idz i zabij ' .. taskByName.count .. ' potworow.', npc, player)
		npcHandler:setTopic(playerId, 0)

		return
	end

	if msg == 'cancel daily' or msg == 'cancel daily task' then
		if player:cancelDailyTask() then
			npcHandler:say('Daily task zostal anulowany.', npc, player)
		else
			npcHandler:say("Nie masz aktywnego daily taska.", npc, player)
		end
		
		return
	end

	if msg == 'cancel task' then
		if player:cancelTask() then
			npcHandler:say('Task zostal anulowany.', npc, player)
		else
			npcHandler:say("Nie masz aktywnego taska.", npc, player)
		end
		
		return
	end

	if msg == 'report daily' or msg == 'report daily task' then
		if player:getCurrentDailyTask() > 0 then
			if player:getStorageValue(Storage.dailyTaskState) == 1 then
				local rewards = player:addDailyTaskRewards()

				npcHandler:say("Gratulacje. Oto twoje nagrody: " .. rewards .. '.', npc, player)

				return
			end

			local currentTask = player:getCurrentDailyTaskInfo()
			npcHandler:say("Aktualny daily task: " .. currentTask.name .. ". Pozostalo do zabicia: " .. currentTask.count .. " potworow.", npc, player)
		else
			npcHandler:say("Nie masz aktywnego zadnego daily taska.", npc, player)
		end

		return
	end

	if msg == 'report task' then
		if player:getCurrentTask() > 0 then
			if player:getStorageValue(storages.finished) == 1 then
				local rewards = player:addTaskRewards()

				npcHandler:say("Gratulacje. Oto twoje nagrody: " .. rewards .. '.', npc, player)

				return
			end

			local currentTask = player:getCurrentTaskInfo()
			npcHandler:say("Aktualny task: " .. currentTask.name .. ". Pozostalo do zabicia: " .. currentTask.count .. " potworow.", npc, player)
		else
			npcHandler:say("Nie masz aktywnego taska.", npc, player)
		end

		return
	end

	return true
end

-- Set to local function "greetCallback"
npcHandler:setCallback(CALLBACK_GREET, greetCallback)
-- Set to local function "creatureSayCallback"
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

-- Bye message
npcHandler:setMessage(MESSAGE_FAREWELL, "Yeah, good bye and don't come again!")
-- Walkaway message
npcHandler:setMessage(MESSAGE_WALKAWAY, "Yeah, good bye and don't come again!")

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- Register npc
npcType:register(npcConfig)
