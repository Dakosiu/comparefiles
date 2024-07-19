local npcName = "Hireling"

local npcType = Game.createNpcType(npcName)
local npcConfig = {}

npcConfig.name = npcName
npcConfig.description = npcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 10

npcConfig.outfit = {
	lookType = 136,
	lookHead = 97,
	lookBody = 34,
	lookLegs = 3,
	lookFeet = 116,
	lookAddons = 0,
	lookMount = 0
}

npcConfig.flags = {
	floorchange = false
}


local hireling = nil
local count = {} -- for banking
local transfer = {} -- for banking

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

-- On buy npc shop message
npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
	npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
end

-- On sell npc shop message
npcType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, name, totalCost)
	player:sendTextMessage(MESSAGE_TRADE, string.format("Sold %ix %s for %i gold.", amount, name, totalCost))
end

-- On check npc shop message (look item)
npcType.onCheckItem = function(npc, player, clientId, subType)
end

-- Function called by the callback "npcHandler:setCallback(CALLBACK_GREET, greetCallback)" in end of file
local function greetCallback(npc, player)
	npcHandler:setMessage(MESSAGE_GREET, "Hello |PLAYERNAME|, you need more info about {canary}?")
	return true
end


local TOPIC = {
	NONE = 1000,
	LAMP = 1001,
	SERVICES = 1100,
	BANK = 1200,
	FOOD = 1300,
	GOODS = 1400
}

local TOPIC_FOOD = {
	SKILL_CHOOSE = 1301
}

local TOPIC_GOODS = {
	VARIOUS = 1401,
	EQUIPMENT = 1402,
	DISTANCE = 1403,
	WANDS = 1404,
	RODS = 1405,
	POTIONS = 1406,
	RUNES = 1407,
	SUPPLIES = 1408,
	TOOLS = 1409,
	POSTAL = 1410
}

local GREETINGS = {
	BANK = "Alright! What can I do for you and your bank business, |PLAYERNAME|?",
	FOOD = "Hmm, yes! A variety of fine food awaits! However, a small expense of 15000 gold is expected to make these delicious masterpieces happen. Shall I?",
	STASH = "Of course, here is your stash! Well-maintained and neatly sorted for your convenience!"
}

local function setTopic(npc, topic)
	npcHandler.topic[npc] = topic
end

local function getHirelingSkills()

	local skills = {}
	if hireling:hasSkill(HIRELING_SKILLS.BANKER) then
		table.insert(skills,HIRELING_SKILLS.BANKER)
	end
	if hireling:hasSkill(HIRELING_SKILLS.COOKING) then
		table.insert(skills,HIRELING_SKILLS.COOKING)
	end
	if hireling:hasSkill(HIRELING_SKILLS.STEWARD) then
		table.insert(skills,HIRELING_SKILLS.STEWARD)
	end
	-- ignoring trader skills as it shows the same message about {goods}
	return skills
end

local function getHirelingServiceString(npc, player)
	local skills = getHirelingSkills()
	local str = "Do you want to see my {goods}"

	for i=1,#skills do
		if i == #skills then
			str = str .. ' or '
		else
			str = str .. ', '
		end

		if skills[i]== HIRELING_SKILLS.BANKER then
			str = str .. 'to access your {bank} account' -- TODO: this setence is not official
		elseif skills[i]== HIRELING_SKILLS.COOKING then
			str = str .. 'to order {food}'
		elseif skills[i]== HIRELING_SKILLS.STEWARD then
			str = str .. 'to open your {stash}'
		end
	end
	str = str .. "?"

	if player:getGuid() == hireling:getOwnerId() then
		str = str .. " If you want, I can go back to my {lamp} or maybe change my {outfit}."
	end
	return str
end

local function getTopic(npc)
	return npcHandler.topic[npc] and npcHandler.topic[npc] > 0 and npcHandler.topic[npc] or TOPIC.SERVICES
end

local function sendSkillNotLearned(npc, SKILL)
	local message = "Sorry, but I do not have mastery in this skill yet."
	local profession
	if SKILL == HIRELING_SKILLS.BANKER then
		profession = "banker"
	elseif SKILL == HIRELING_SKILLS.COOKING then
		profession = "cooker"
	elseif SKILL == HIRELING_SKILLS.STEWARD then
		profession = "steward"
	elseif SKILL == HIRELING_SKILLS.TRADER then
		profession = "trader"
	end

	if profession then
		message = string.format("I'm not a %s and would not know how to help you with that, sorry. I can start a %s apprenticeship if you buy it for me in the store!", profession, profession)
	end

	npcHandler:say(message, npc, player)
end
-- ----------------------[[ END STEWARD FUNCTIONS ]] ------------------------------
--[[
############################################################################
############################################################################
############################################################################
]]
-- ----------------------[[ BANKING FUNCTIONS ]] ------------------------------
-------------------------------- guild bank -----------------------------------------------
local receiptFormat = 'Date: %s\nType: %s\nGold Amount: %d\nReceipt Owner: %s\nRecipient: %s\n\n%s'
local function getReceipt(info)
	local receipt = Game.createItem(info.success and 24301 or 24302)
	receipt:setAttribute(ITEM_ATTRIBUTE_TEXT, receiptFormat:format(os.date('%d. %b %Y - %H:%M:%S'), info.type, info.amount, info.owner, info.recipient, info.message))

	return receipt
end

local function getGuildIdByName(name, func)
	db.asyncStoreQuery('SELECT `id` FROM `guilds` WHERE `name` = ' .. db.escapeString(name),
		function(resultId)
			if resultId then
				func(result.getNumber(resultId, 'id'))
				result.free(resultId)
			else
				func(nil)
			end
		end
	)
end

local function getGuildBalance(id)
	local guild = Guild(id)
	if guild then
		return guild:getBankBalance()
	else
		local balance
		local resultId = db.storeQuery('SELECT `balance` FROM `guilds` WHERE `id` = ' .. id)
		if resultId then
			balance = result.getNumber(resultId, 'balance')
			result.free(resultId)
		end

		return balance
	end
end

local function setGuildBalance(id, balance)
	local guild = Guild(id)
	if guild then
		guild:setBankBalance(balance)
	else
		db.query('UPDATE `guilds` SET `balance` = ' .. balance .. ' WHERE `id` = ' .. id)
	end
end

local function transferFactory(playerName, amount, fromGuildId, info)
	return function(toGuildId)
		if not toGuildId then
			local player = Player(playerName)
			if player then
				info.success = false
				info.message = 'We are sorry to inform you that we could not fulfil your request, because we could not find the recipient guild.'
				local inbox = player:getInbox()
				local receipt = getReceipt(info)
				inbox:addItemEx(receipt, INDEX_WHEREEVER, FLAG_NOLIMIT)
			end
		else
			local fromBalance = getGuildBalance(fromGuildId)
			if fromBalance < amount then
				info.success = false
				info.message = 'We are sorry to inform you that we could not fulfill your request, due to a lack of the required sum on your guild account.'
			else
				info.success = true
				info.message = 'We are happy to inform you that your transfer request was successfully carried out.'
				setGuildBalance(fromGuildId, fromBalance - amount)
				setGuildBalance(toGuildId, getGuildBalance(toGuildId) + amount)
			end

			local player = Player(playerName)
			if player then
				local inbox = player:getInbox()
				local receipt = getReceipt(info)
				inbox:addItemEx(receipt, INDEX_WHEREEVER, FLAG_NOLIMIT)
			end
		end
	end
end
--------------------------------end guild bank-----------------------------------------------
local function handleBankActions(npc, msg, player)
---------------------------- help ------------------------
	if MsgContains(msg, 'bank account') then
		npcHandler:say({
			'Every citizen has one. The big advantage is that you can access your money in every branch of the Global Bank! ...',
			'Would you like to know more about the {basic} functions of your bank account, the {advanced} functions, or are you already bored, perhaps?'
		}, npc, player)
		npcHandler:setTopic(playerId, 1200)
		return true
---------------------------- balance ---------------------
--------------------------------guild bank-----------------------------------------------
	elseif MsgContains(msg, 'guild balance') then
		npcHandler:setTopic(playerId, 1200)
		if not player:getGuild() then
			npcHandler:say('You are not a member of a guild.', npc, player)
			return false
		end
		npcHandler:say('Your guild account balance is ' .. player:getGuild():getBankBalance() .. ' gold.', npc, player)
		return true
--------------------------------guild bank-----------------------------------------------
	elseif MsgContains(msg, 'balance') then
		npcHandler:setTopic(playerId, 1200)
		if player:getBankBalance() >= 100000000 then
			npcHandler:say('I think you must be one of the richest inhabitants in the world! Your account balance is ' .. player:getBankBalance() .. ' gold.', npc, player)
			return true
		elseif player:getBankBalance() >= 10000000 then
			npcHandler:say('You have made ten millions and it still grows! Your account balance is ' .. player:getBankBalance() .. ' gold.', npc, player)
			return true
		elseif player:getBankBalance() >= 1000000 then
			npcHandler:say('Wow, you have reached the magic number of a million gp!!! Your account balance is ' .. player:getBankBalance() .. ' gold!', npc, player)
			return true
		elseif player:getBankBalance() >= 100000 then
			npcHandler:say('You certainly have made a pretty penny. Your account balance is ' .. player:getBankBalance() .. ' gold.', npc, player)
			return true
		else
			npcHandler:say('Your account balance is ' .. player:getBankBalance() .. ' gold.', npc, player)
			return true
		end
---------------------------- deposit ---------------------
--------------------------------guild bank-----------------------------------------------
	elseif MsgContains(msg, 'guild deposit') then
		if not player:getGuild() then
			npcHandler:say('You are not a member of a guild.', npc, player)
			npcHandler:setTopic(playerId, 1200)
			return false
		end
	   -- count[npc] = player:getMoney()
	   -- if count[npc] < 1 then
		   -- npcHandler:say('You do not have enough gold.', npc, player)
		   -- npcHandler:setTopic(playerId, 1200)
		   -- return false
		--end
		if string.match(msg, '%d+') then
			count[npc] = getMoneyCount(msg)
			if count[npc] < 1 then
				npcHandler:say('You do not have enough gold.', npc, player)
				npcHandler:setTopic(playerId, 1200)
				return false
			end
			npcHandler:say('Would you really like to deposit ' .. count[npc] .. ' gold to your {guild account}?', npc, player)
			npcHandler:setTopic(playerId, 1223)
			return true
		else
			npcHandler:say('Please tell me how much gold it is you would like to deposit.', npc, player)
			npcHandler:setTopic(playerId, 1222)
			return true
		end
	elseif npcHandler:getTopic(playerId) == 1222 then
		count[npc] = getMoneyCount(msg)
		if isValidMoney(count[npc]) then
			npcHandler:say('Would you really like to deposit ' .. count[npc] .. ' gold to your {guild account}?', npc, player)
			npcHandler:setTopic(playerId, 1223)
			return true
		else
			npcHandler:say('You do not have enough gold.', npc, player)
			npcHandler:setTopic(playerId, 1200)
			return true
		end
	elseif npcHandler:getTopic(playerId) == 1223 then
		if MsgContains(msg, 'yes') then
			npcHandler:say('Alright, we have placed an order to deposit the amount of ' .. count[npc] .. ' gold to your guild account. Please check your inbox for confirmation.', npc, player)
			local guild = player:getGuild()
			local info = {
				type = 'Guild Deposit',
				amount = count[npc],
				owner = player:getName() .. ' of ' .. guild:getName(),
				recipient = guild:getName()
			}
			local playerBalance = player:getBankBalance()
			if playerBalance < tonumber(count[npc]) then
				info.message = 'We are sorry to inform you that we could not fulfill your request, due to a lack of the required sum on your bank account.'
				info.success = false
			else
				info.message = 'We are happy to inform you that your transfer request was successfully carried out.'
				info.success = true
				guild:setBankBalance(guild:getBankBalance() + tonumber(count[npc]))
				player:setBankBalance(playerBalance - tonumber(count[npc]))
			end

			local inbox = player:getInbox()
			local receipt = getReceipt(info)
			inbox:addItemEx(receipt, INDEX_WHEREEVER, FLAG_NOLIMIT)
		elseif MsgContains(msg, 'no') then
			npcHandler:say('As you wish. Is there something else I can do for you?', npc, player)
		end
		npcHandler:setTopic(playerId, 1200)
		return true
--------------------------------guild bank-----------------------------------------------
	elseif MsgContains(msg, 'deposit') then
		count[npc] = player:getMoney()
		if count[npc] < 1 then
			npcHandler:say('You do not have enough gold.', npc, player)
			npcHandler:setTopic(playerId, 1200)
			return false
		end
		if MsgContains(msg, 'all') then
			count[npc] = player:getMoney()
			npcHandler:say('Would you really like to deposit ' .. count[npc] .. ' gold?', npc, player)
			npcHandler:setTopic(playerId, 1202)
			return true
		else
			if string.match(msg,'%d+') then
				count[npc] = getMoneyCount(msg)
				if count[npc] < 1 then
					npcHandler:say('You do not have enough gold.', npc, player)
					npcHandler:setTopic(playerId, 1200)
					return false
				end
				npcHandler:say('Would you really like to deposit ' .. count[npc] .. ' gold?', npc, player)
				npcHandler:setTopic(playerId, 1202)
				return true
			else
				npcHandler:say('Please tell me how much gold it is you would like to deposit.', npc, player)
				npcHandler:setTopic(playerId, 1201)
				return true
			end
		end
		if not isValidMoney(count[npc]) then
			npcHandler:say('Sorry, but you can\'t deposit that much.', npc, player)
			npcHandler:setTopic(playerId, 1200)
			return false
		end
	elseif npcHandler:getTopic(playerId) == 1201 then
		count[npc] = getMoneyCount(msg)
		if isValidMoney(count[npc]) then
			npcHandler:say('Would you really like to deposit ' .. count[npc] .. ' gold?', npc, player)
			npcHandler:setTopic(playerId, 1202)
			return true
		else
			npcHandler:say('You do not have enough gold.', npc, player)
			npcHandler:setTopic(playerId, 1200)
			return true
		end
	elseif npcHandler:getTopic(playerId) == 1202 then
		if MsgContains(msg, 'yes') then
			if player:depositMoney(count[npc]) then
				npcHandler:say('Alright, we have added the amount of ' .. count[npc] .. ' gold to your {balance}. You can {withdraw} your money anytime you want to.', npc, player)
			else
				npcHandler:say('You do not have enough gold.', npc, player)
			end
		elseif MsgContains(msg, 'no') then
			npcHandler:say('As you wish. Is there something else I can do for you?', npc, player)
		end
		npcHandler:setTopic(playerId, 1200)
		return true
---------------------------- withdraw --------------------
--------------------------------guild bank-----------------------------------------------
	elseif MsgContains(msg, 'guild withdraw') then
		if not player:getGuild() then
			npcHandler:say('I am sorry but it seems you are currently not in any guild.', npc, player)
			npcHandler:setTopic(playerId, 1200)
			return false
		elseif player:getGuildLevel() < 2 then
			npcHandler:say('Only guild leaders or vice leaders can withdraw money from the guild account.', npc, player)
			npcHandler:setTopic(playerId, 1200)
			return false
		end

		if string.match(msg,'%d+') then
			count[npc] = getMoneyCount(msg)
			if isValidMoney(count[npc]) then
				npcHandler:say('Are you sure you wish to withdraw ' .. count[npc] .. ' gold from your guild account?', npc, player)
				npcHandler:setTopic(playerId, 1225)
			else
				npcHandler:say('There is not enough gold on your guild account.', npc, player)
				npcHandler:setTopic(playerId, 1200)
			end
			return true
		else
			npcHandler:say('Please tell me how much gold you would like to withdraw from your guild account.', npc, player)
			npcHandler:setTopic(playerId, 1224)
			return true
		end
	elseif npcHandler:getTopic(playerId) == 1224 then
		count[npc] = getMoneyCount(msg)
		if isValidMoney(count[npc]) then
			npcHandler:say('Are you sure you wish to withdraw ' .. count[npc] .. ' gold from your guild account?', npc, player)
			npcHandler:setTopic(playerId, 1225)
		else
			npcHandler:say('There is not enough gold on your guild account.', npc, player)
			npcHandler:setTopic(playerId, 1200)
		end
		return true
	elseif npcHandler:getTopic(playerId) == 1225 then
		if MsgContains(msg, 'yes') then
			local guild = player:getGuild()
			local balance = guild:getBankBalance()
			npcHandler:say('We placed an order to withdraw ' .. count[npc] .. ' gold from your guild account. Please check your inbox for confirmation.', npc, player)
			local info = {
				type = 'Guild Withdraw',
				amount = count[npc],
				owner = player:getName() .. ' of ' .. guild:getName(),
				recipient = player:getName()
			}
			if balance < tonumber(count[npc]) then
				info.message = 'We are sorry to inform you that we could not fulfill your request, due to a lack of the required sum on your guild account.'
				info.success = false
			else
				info.message = 'We are happy to inform you that your transfer request was successfully carried out.'
				info.success = true
				guild:setBankBalance(balance - tonumber(count[npc]))
				local playerBalance = player:getBankBalance()
				player:setBankBalance(playerBalance + tonumber(count[npc]))
			end

			local inbox = player:getInbox()
			local receipt = getReceipt(info)
			inbox:addItemEx(receipt, INDEX_WHEREEVER, FLAG_NOLIMIT)
			npcHandler:setTopic(playerId, 1200)
		elseif MsgContains(msg, 'no') then
			npcHandler:say('As you wish. Is there something else I can do for you?', npc, player)
			npcHandler:setTopic(playerId, 1200)
		end
		return true
--------------------------------guild bank-----------------------------------------------
	elseif MsgContains(msg, 'withdraw') then
		if string.match(msg,'%d+') then
			count[npc] = getMoneyCount(msg)
			if isValidMoney(count[npc]) then
				npcHandler:say('Are you sure you wish to withdraw ' .. count[npc] .. ' gold from your bank account?', npc, player)
				npcHandler:setTopic(playerId, 1207)
			else
				npcHandler:say('There is not enough gold on your account.', npc, player)
				npcHandler:setTopic(playerId, 1200)
			end
			return true
		else
			npcHandler:say('Please tell me how much gold you would like to withdraw.', npc, player)
			npcHandler:setTopic(playerId, 1206)
			return true
		end
	elseif npcHandler:getTopic(playerId) == 1206 then
		count[npc] = getMoneyCount(msg)
		if isValidMoney(count[npc]) then
			npcHandler:say('Are you sure you wish to withdraw ' .. count[npc] .. ' gold from your bank account?', npc, player)
			npcHandler:setTopic(playerId, 1207)
		else
			npcHandler:say('There is not enough gold on your account.', npc, player)
			npcHandler:setTopic(playerId, 1200)
		end
		return true
	elseif npcHandler:getTopic(playerId) == 1207 then
		if MsgContains(msg, 'yes') then
			if player:getFreeCapacity() >= getMoneyWeight(count[npc]) then
				if not player:withdrawMoney(count[npc]) then
					npcHandler:say('There is not enough gold on your account.', npc, player)
				else
					npcHandler:say('Here you are, ' .. count[npc] .. ' gold. Please let me know if there is something else I can do for you.', npc, player)
				end
			else
				npcHandler:say('Whoah, hold on, you have no room in your inventory to carry all those coins. I don\'t want you to drop it on the floor, maybe come back with a cart!', npc, player)
			end
			npcHandler:setTopic(playerId, 1200)
		elseif MsgContains(msg, 'no') then
			npcHandler:say('The customer is king! Come back anytime you want to if you wish to {withdraw} your money.', npc, player)
			npcHandler:setTopic(playerId, 1200)
		end
		return true
---------------------------- transfer --------------------
--------------------------------guild bank-----------------------------------------------
	elseif MsgContains(msg, 'guild transfer') then
		if not player:getGuild() then
			npcHandler:say('I am sorry but it seems you are currently not in any guild.', npc, player)
			npcHandler:setTopic(playerId, 1200)
			return false
		elseif player:getGuildLevel() < 2 then
			npcHandler:say('Only guild leaders or vice leaders can transfer money from the guild account.', npc, player)
			npcHandler:setTopic(playerId, 1200)
			return false
		end

		if string.match(msg, '%d+') then
			count[npc] = getMoneyCount(msg)
			if isValidMoney(count[npc]) then
				transfer[npc] = string.match(msg, 'to%s*(.+)$')
				if transfer[npc] then
					npcHandler:say('So you would like to transfer ' .. count[npc] .. ' gold from your guild account to guild ' .. transfer[npc] .. '?', npc, player)
					npcHandler:setTopic(playerId, 1228)
				else
					npcHandler:say('Which guild would you like to transfer ' .. count[npc] .. ' gold to?', npc, player)
					npcHandler:setTopic(playerId, 1227)
				end
			else
				npcHandler:say('There is not enough gold on your guild account.', npc, player)
				npcHandler:setTopic(playerId, 1200)
			end
		else
			npcHandler:say('Please tell me the amount of gold you would like to transfer.', npc, player)
			npcHandler:setTopic(playerId, 1226)
		end
		return true
	elseif npcHandler:getTopic(playerId) == 1226 then
		count[npc] = getMoneyCount(msg)
		if player:getGuild():getBankBalance() < count[npc] then
			npcHandler:say('There is not enough gold on your guild account.', npc, player)
			npcHandler:setTopic(playerId, 1200)
			return true
		end
		if isValidMoney(count[npc]) then
			npcHandler:say('Which guild would you like to transfer ' .. count[npc] .. ' gold to?', npc, player)
			npcHandler:setTopic(playerId, 1227)
		else
			npcHandler:say('There is not enough gold on your account.', npc, player)
			npcHandler:setTopic(playerId, 1200)
		end
		return true
	elseif npcHandler:getTopic(playerId) == 1227 then
		transfer[npc] = msg
		if player:getGuild():getName() == transfer[npc] then
			npcHandler:say('Fill in this field with person who receives your gold!', npc, player)
			npcHandler:setTopic(playerId, 1200)
			return true
		end
		npcHandler:say('So you would like to transfer ' .. count[npc] .. ' gold from your guild account to guild ' .. transfer[npc] .. '?', npc, player)
		npcHandler:setTopic(playerId, 1228)
		return true
	elseif npcHandler:getTopic(playerId) == 1228 then
		if MsgContains(msg, 'yes') then
			npcHandler:say('We have placed an order to transfer ' .. count[npc] .. ' gold from your guild account to guild ' .. transfer[npc] .. '. Please check your inbox for confirmation.', npc, player)
			local guild = player:getGuild()
			local balance = guild:getBankBalance()
			local info = {
				type = 'Guild to Guild Transfer',
				amount = count[npc],
				owner = player:getName() .. ' of ' .. guild:getName(),
				recipient = transfer[npc]
			}
			if balance < tonumber(count[npc]) then
				info.message = 'We are sorry to inform you that we could not fulfill your request, due to a lack of the required sum on your guild account.'
				info.success = false
				local inbox = player:getInbox()
				local receipt = getReceipt(info)
				inbox:addItemEx(receipt, INDEX_WHEREEVER, FLAG_NOLIMIT)
			else
				getGuildIdByName(transfer[npc], transferFactory(player:getName(), tonumber(count[npc]), guild:getId(), info))
			end
			npcHandler:setTopic(playerId, 1200)
		elseif MsgContains(msg, 'no') then
			npcHandler:say('Alright, is there something else I can do for you?', npc, player)
		end
		npcHandler:setTopic(playerId, 1200)
--------------------------------guild bank-----------------------------------------------
	elseif MsgContains(msg, 'transfer') then
		npcHandler:say('Please tell me the amount of gold you would like to transfer.', npc, player)
		npcHandler:setTopic(playerId, 1211)
	elseif npcHandler:getTopic(playerId) == 1211 then
		count[npc] = getMoneyCount(msg)
		if player:getBankBalance() < count[npc] then
			npcHandler:say('There is not enough gold on your account.', npc, player)
			npcHandler:setTopic(playerId, 1200)
			return true
		end
		if isValidMoney(count[npc]) then
			npcHandler:say('Who would you like transfer ' .. count[npc] .. ' gold to?', npc, player)
			npcHandler:setTopic(playerId, 1212)
		else
			npcHandler:say('There is not enough gold on your account.', npc, player)
			npcHandler:setTopic(playerId, 1200)
		end
	elseif npcHandler:getTopic(playerId) == 1212 then
		transfer[npc] = msg
		if player:getName() == transfer[npc] then
			npcHandler:say('Fill in this field with person who receives your gold!', npc, player)
			npcHandler:setTopic(playerId, 1200)
			return true
		end
		if playerExists(transfer[npc]) then
		local arrayDenied = {"accountmanager", "rooksample", "druidsample", "sorcerersample", "knightsample", "paladinsample"}
			if isInArray(arrayDenied, string.gsub(transfer[npc]:lower(), " ", "")) then
				npcHandler:say('This player does not exist.', npc, player)
				npcHandler:setTopic(playerId, 1200)
				return true
			end
			npcHandler:say('So you would like to transfer ' .. count[npc] .. ' gold to ' .. transfer[npc] .. '?', npc, player)
			npcHandler:setTopic(playerId, 1213)
		else
			npcHandler:say('This player does not exist.', npc, player)
			npcHandler:setTopic(playerId, 1200)
		end
	elseif npcHandler:getTopic(playerId) == 1213 then
		if MsgContains(msg, 'yes') then
			if not player:transferMoneyTo(transfer[npc], count[npc]) then
				npcHandler:say('You cannot transfer money to this account.', npc, player)
			else
				npcHandler:say('Very well. You have transferred ' .. count[npc] .. ' gold to ' .. transfer[npc] ..'.', npc, player)
				transfer[npc] = nil
			end
		elseif MsgContains(msg, 'no') then
			npcHandler:say('Alright, is there something else I can do for you?', npc, player)
		end
		npcHandler:setTopic(playerId, 1200)
---------------------------- money exchange --------------
	elseif MsgContains(msg, 'change gold') then
		npcHandler:say('How many platinum coins would you like to get?', npc, player)
		npcHandler:setTopic(playerId, 1214)
	elseif npcHandler:getTopic(playerId) == 1214 then
		if getMoneyCount(msg) < 1 then
			npcHandler:say('Sorry, you do not have enough gold coins.', npc, player)
			npcHandler:setTopic(playerId, 1200)
		else
			count[npc] = getMoneyCount(msg)
			npcHandler:say('So you would like me to change ' .. count[npc] * 100 .. ' of your gold coins into ' .. count[npc] .. ' platinum coins?', npc, player)
			npcHandler:setTopic(playerId, 1215)
		end
	elseif npcHandler:getTopic(playerId) == 1215 then
		if MsgContains(msg, 'yes') then
			if player:removeItem(2148, count[npc] * 100) then
				player:addItem(2152, count[npc])
				npcHandler:say('Here you are.', npc, player)
			else
				npcHandler:say('Sorry, you do not have enough gold coins.', npc, player)
			end
		else
			npcHandler:say('Well, can I help you with something else?', npc, player)
		end
		npcHandler:setTopic(playerId, 1200)
	elseif MsgContains(msg, 'change platinum') then
		npcHandler:say('Would you like to change your platinum coins into gold or crystal?', npc, player)
		npcHandler:setTopic(playerId, 1216)
	elseif npcHandler:getTopic(playerId) == 1216 then
		if MsgContains(msg, 'gold') then
			npcHandler:say('How many platinum coins would you like to change into gold?', npc, player)
			npcHandler:setTopic(playerId, 1217)
		elseif MsgContains(msg, 'crystal') then
			npcHandler:say('How many crystal coins would you like to get?', npc, player)
			npcHandler:setTopic(playerId, 1219)
		else
			npcHandler:say('Well, can I help you with something else?', npc, player)
			npcHandler:setTopic(playerId, 1200)
		end
	elseif npcHandler:getTopic(playerId) == 1217 then
		if getMoneyCount(msg) < 1 then
			npcHandler:say('Sorry, you do not have enough platinum coins.', npc, player)
			npcHandler:setTopic(playerId, 1200)
		else
			count[npc] = getMoneyCount(msg)
			npcHandler:say('So you would like me to change ' .. count[npc] .. ' of your platinum coins into ' .. count[npc] * 100 .. ' gold coins for you?', npc, player)
			npcHandler:setTopic(playerId, 1218)
		end
	elseif npcHandler:getTopic(playerId) == 1218 then
		if MsgContains(msg, 'yes') then
			if player:removeItem(2152, count[npc]) then
				player:addItem(2148, count[npc] * 100)
				npcHandler:say('Here you are.', npc, player)
			else
				npcHandler:say('Sorry, you do not have enough platinum coins.', npc, player)
			end
		else
			npcHandler:say('Well, can I help you with something else?', npc, player)
		end
		npcHandler:setTopic(playerId, 1200)
	elseif npcHandler:getTopic(playerId) == 1219 then
		if getMoneyCount(msg) < 1 then
			npcHandler:say('Sorry, you do not have enough platinum coins.', npc, player)
			npcHandler:setTopic(playerId, 1200)
		else
			count[npc] = getMoneyCount(msg)
			npcHandler:say('So you would like me to change ' .. count[npc] * 100 .. ' of your platinum coins into ' .. count[npc] .. ' crystal coins for you?', npc, player)
			npcHandler:setTopic(playerId, 1220)
		end
	elseif npcHandler:getTopic(playerId) == 1220 then
		if MsgContains(msg, 'yes') then
			if player:removeItem(2152, count[npc] * 100) then
				player:addItem(2160, count[npc])
				npcHandler:say('Here you are.', npc, player)
			else
				npcHandler:say('Sorry, you do not have enough platinum coins.', npc, player)
			end
		else
			npcHandler:say('Well, can I help you with something else?', npc, player)
		end
		npcHandler:setTopic(playerId, 1200)
	elseif MsgContains(msg, 'change crystal') then
		npcHandler:say('How many crystal coins would you like to change into platinum?', npc, player)
		npcHandler:setTopic(playerId, 1221)
	elseif npcHandler:getTopic(playerId) == 1221 then
		if getMoneyCount(msg) < 1 then
			npcHandler:say('Sorry, you do not have enough crystal coins.', npc, player)
			npcHandler:setTopic(playerId, 1200)
		else
			count[npc] = getMoneyCount(msg)
			npcHandler:say('So you would like me to change ' .. count[npc] .. ' of your crystal coins into ' .. count[npc] * 100 .. ' platinum coins for you?', npc, player)
			npcHandler:setTopic(playerId, 1222)
		end
	elseif npcHandler:getTopic(playerId) == 1222 then
		if MsgContains(msg, 'yes') then
			if player:removeItem(2160, count[npc])  then
				player:addItem(2152, count[npc] * 100)
				npcHandler:say('Here you are.', npc, player)
			else
				npcHandler:say('Sorry, you do not have enough crystal coins.', npc, player)
			end
		else
			npcHandler:say('Well, can I help you with something else?', npc, player)
		end
		npcHandler:setTopic(playerId, 1200)
	elseif MsgContains(msg, 'money') then
		npcHandler:say('We can {change} money for you. You can also access your {bank account}.', npc, player)
	elseif MsgContains(msg, 'change') then
		npcHandler:say('There are three different coin types in Global Bank: 100 gold coins equal 1 platinum coin, 100 platinum coins equal 1 crystal coin. So if you\'d like to change 100 gold into 1 platinum, simply say \'{change gold}\' and then \'1 platinum\'.', npc, player)
	elseif MsgContains(msg, 'bank') then
		npcHandler:say('We can {change} money for you. You can also access your {bank account}.', npc, player)
	elseif MsgContains(msg, 'advanced') then
		npcHandler:say('Your bank account will be used automatically when you want to {rent} a house or place an offer on an item on the {market}. Let me know if you want to know about how either one works.', npc, player)
	elseif MsgContains(msg, 'help') then
		npcHandler:say('You can check the {balance} of your bank account, {deposit} money or {withdraw} it. You can also {transfer} money to other characters, provided that they have a vocation.', npc, player)
	elseif MsgContains(msg, 'functions') then
		npcHandler:say('You can check the {balance} of your bank account, {deposit} money or {withdraw} it. You can also {transfer} money to other characters, provided that they have a vocation.', npc, player)
	elseif MsgContains(msg, 'basic') then
		npcHandler:say('You can check the {balance} of your bank account, {deposit} money or {withdraw} it. You can also {transfer} money to other characters, provided that they have a vocation.', npc, player)
	elseif MsgContains(msg, 'job') then
		npcHandler:say('I work in this house. I can change money for you and help you with your bank account.', npc, player)
	end
	return true
end
-- ======================[[ END BANKING FUNCTIONS ]] ======================== --
--[[
############################################################################
############################################################################
############################################################################
]]
-- ========================[[ TRADER FUNCTIONS ]] ========================== --

local function getGoodsGreetingMessage()
	local str
	if not hireling:hasSkill(HIRELING_SKILLS.TRADER) then
		str = "While I'm not a trader, I still have a collection of {various} items to sell if you like!"
	else
		str = "I sell a {selection} of {various} items, {equipment}, " ..
			"{distance} weapons, {wands} and {rods}, {potions}, {runes}, " ..
			"{supplies}, {tools} and {postal} goods. Just ask!"
	end
	return str
end

local function getTable(npc)
	local topic = getTopic(npc)
	if topic == TOPIC_GOODS.VARIOUS then
		return HIRELING_GOODS.VARIOUS
	elseif topic == TOPIC_GOODS.EQUIPMENT then
		return HIRELING_GOODS.EQUIPMENT
	elseif topic == TOPIC_GOODS.DISTANCE then
		return HIRELING_GOODS.DISTANCE
	elseif topic == TOPIC_GOODS.WANDS then
		return HIRELING_GOODS.WANDS
	elseif topic == TOPIC_GOODS.RODS then
		return HIRELING_GOODS.RODS
	elseif topic == TOPIC_GOODS.POTIONS then
		return HIRELING_GOODS.POTIONS
	elseif topic == TOPIC_GOODS.RUNES then
		return HIRELING_GOODS.RUNES
	elseif topic == TOPIC_GOODS.SUPPLIES then
		return HIRELING_GOODS.SUPPLIES
	elseif topic == TOPIC_GOODS.TOOLS then
		return HIRELING_GOODS.TOOLS
	elseif topic == TOPIC_GOODS.POSTAL then
		return HIRELING_GOODS.POSTAL
	end
end

local function setNewTradeTable(table)
	local items, item = {}
	for i = 1, #table do
		item = table[i]
		items[item.id] = {itemId = item.id, buyPrice = item.buy, sellPrice = item.sell, subType = item.subType, realName = item.name}
	end
	return items
end

local function onSell(npc, item, subType, amount, ignoreCap, inBackpacks, player)
	local creatureId = Creature(npc):getId()
	local items = setNewTradeTable(getTable(creatureId))

	if items[item].sellPrice and player:removeItem(items[item].itemId, amount) then
		player:addMoney(items[item].sellPrice * amount)
		return player:sendTextMessage(MESSAGE_LOOK, 'Sold '..amount..'x '..items[item].realName..' for '..items[item].sellPrice * amount..' gold coins.')
	end

	npcHandler:say("You don't have item to sell.", npc, player)
	return true
end

local function onBuy(npc, item, subType, amount, ignoreCap, inBackpacks, player)
	local creatureId = Creature(npc):getId()
	local items = setNewTradeTable(getTable(creatureId))
	local itemType = ItemType(items[item].itemId)
	if itemType:getWrapableTo() ~= 0 then
		itemType = ItemType(itemType:getWrapableTo())
	end
	local backpack = player:getSlotItem(CONST_SLOT_BACKPACK)
	if not backpack or backpack:getEmptySlots(true) < 1 then
		player:sendCancelMessage(RETURNVALUE_NOTENOUGHROOM)
		return false
	end
	if not ignoreCap and player:getFreeCapacity() < itemType:getWeight(amount) then
		return player:sendTextMessage(MESSAGE_FAILURE, 'You don\'t have enough cap.')
	end
	if not player:removeMoneyNpc(items[item].buyPrice * amount) then
		npcHandler:say("You don't have enough money.", npc, player)
	else
		player:addItem(itemType:getId(), amount, true, subType)
		return player:sendTextMessage(MESSAGE_LOOK, 'Bought '..amount..'x '..items[item].realName..' for '..items[item].buyPrice * amount..' gold coins.')
	end
	return true
end

local function getTradeMessage(npc)
	local topic = getTopic(npc)
	local msg = "Here you go!"

	if topic == TOPIC_GOODS.EQUIPMENT then
		msg = "Alright, here's all the equipment I can order for you!"
	elseif topic == TOPIC_GOODS.DISTANCE then
		msg = "Great, here are the distance weapons I can order for you!"
	elseif topic == TOPIC_GOODS.WANDS then
		msg = "Ok, here are the wands I can order for you!"
	elseif topic == TOPIC_GOODS.RODS then
		msg = "Nice, here are the rods I can order for you!"
	elseif topic == TOPIC_GOODS.POTIONS then
		msg = "Sure, here are all the potions I can order for you!"
	elseif topic == TOPIC_GOODS.RUNES then
		msg = "With pleasure, here are all the runes I can order for you!"
	elseif topic == TOPIC_GOODS.SUPPLIES then
		msg = "Here are some supplies to get you through the day!"
	elseif topic == TOPIC_GOODS.TOOLS then
		msg = "All the handy tools you'll ever need!"
	elseif topic == TOPIC_GOODS.POSTAL then
		msg = "I have all the necessary items to properly enhance your communication, feel free to browse!"
	end

	return msg
end

local function sendTradeWindow(npc, player)
	openShopWindow(npc, getTable(npc), onBuy, onSell, player)
	local response = getTradeMessage()
	npcHandler:say(response, npc, player)
end


local function handleGoodsActions(npc, msg)
	if MsgContains(msg, "various") then
		setTopic(npc, TOPIC_GOODS.VARIOUS)
	elseif MsgContains(msg, "equipment") then
		setTopic(npc, TOPIC_GOODS.EQUIPMENT)
	elseif MsgContains(msg, "distance") then
		setTopic(npc, TOPIC_GOODS.DISTANCE)
	elseif MsgContains(msg, "wands") then
		setTopic(npc, TOPIC_GOODS.WANDS)
	elseif MsgContains(msg, "rods") then
		setTopic(npc, TOPIC_GOODS.RODS)
	elseif MsgContains(msg, "potions") then
		setTopic(npc, TOPIC_GOODS.POTIONS)
	elseif MsgContains(msg, "runes") then
		setTopic(npc, TOPIC_GOODS.RUNES)
	elseif MsgContains(msg, "supplies") then
		setTopic(npc, TOPIC_GOODS.SUPPLIES)
	elseif MsgContains(msg, "tools") then
		setTopic(npc, TOPIC_GOODS.TOOLS)
	elseif MsgContains(msg, "postal") then
		setTopic(npc, TOPIC_GOODS.POSTAL)
	end


	if table.contains(TOPIC_GOODS, getTopic(npc)) then
		sendTradeWindow(npc, player)
	end
end

-- ======================[[ END TRADER FUNCTIONS ]] ======================== --
--[[
############################################################################
############################################################################
############################################################################
]]
-- ========================[[ COOKER FUNCTIONS ]] ========================== --

local function getDeliveredMessageByFoodId(food_id) -- remove the hardcoded food ids
	local msg = ""


	if food_id == 35172 then
		msg = "Oh yes, a tasty roasted wings to make you even tougher and skilled with the defensive arts."
	elseif food_id == 35173 then
		msg = "Divine! Carrot is a well known nourishment that makes the eyes see even more sharply."
	elseif food_id == 35174 then
		msg = "Magnifique! A tiger meat that has been marinated for several hours in magic spices."
	elseif food_id == 35175 then
		msg = "Aaah, the beauty of the simple dishes! A delicate salad made of selected ingredients, capable of bring joy to the hearts of bravest warriors and their weapons."
	elseif food_id == 35176 then
		msg = "Oh yes, very spicy chilly combined with delicious minced carniphila meat and a side dish of fine salad!"
	elseif food_id == 35177 then
		msg = "Aaah, the northern cuisine! A catch of fresh salmon right from the coast Svargrond is the base of this extraordinary fish dish."
	elseif food_id == 35178 then
		msg = "A traditional and classy meal. A beefy casserole which smells far better than it sounds!"
	elseif food_id == 35179 then
		msg = "A tasty chunk of juicy beef with an aromatic sauce and parsley potatoes, mmh!"
	elseif food_id == 35180 then
		msg = "Oooh, well... that one didn't quite turn out as it was supposed to be, I'm sorry."
	end

	return msg
end

local function deliverFood(npc, food_id, player)
	local itType = ItemType(food_id)
	local inbox = player:getSlotItem(CONST_SLOT_STORE_INBOX)

	if player:getFreeCapacity() < itType:getWeight(1) then
		npcHandler:say("Sorry, but you don't have enough capacity.", npc, player)
	elseif not inbox or inbox:getEmptySlots() == 0 then
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		npcHandler:say("Sorry, you don't have enough room on your inbox", npc, player)
	elseif not player:removeMoneyNpc(15000) then
		npcHandler:say("Sorry, you don't have enough money.", npc, player)
	else
		local msg = getDeliveredMessageByFoodId(food_id)
		npcHandler:say(msg, npc, player)
		inbox:addItem(food_id, 1, INDEX_WHEREEVER, FLAG_NOLIMIT)
	end
	setTopic(npc, TOPIC.SERVICES)
end

local function cookFood(npc, player)
	local random = math.random(6)
	if random == 6 then
		-- ask for preferred skill
		setTopic(npc, TOPIC_FOOD.SKILL_CHOOSE)
		npcHandler:say("Yay! I have the ingredients to make a skill boost dish. Would you rather like to boost your {magic}, {melee}, {shielding} or {distance} skill?", npc, player)
	else -- deliver the random generated index
		deliverFood(npc, HIRELING_FOODS[random], player)
	end
end

local function handleFoodActions(npc, msg, player)
	local topic = getTopic(npc)

	if topic == TOPIC.FOOD then --initial node
		if MsgContains(msg, "yes") then
			cookFood(npc, player)
		elseif MsgContains(msg, "no") then
			setTopic(npc, TOPIC.SERVICES)
			npcHandler:say("Alright then, ask me for other {services}, if you want.", npc, player)
		else --invalid word

		end
	elseif topic == TOPIC_FOOD.SKILL_CHOOSE then
		if MsgContains(msg, "magic") then
			deliverFood(npc, HIRELING_FOODS_BOOST.MAGIC, player)
		elseif MsgContains(msg,"melee") then
			deliverFood(npc, HIRELING_FOODS_BOOST.MELEE, player)
		elseif MsgContains(msg,"shielding") then
			deliverFood(npc, HIRELING_FOODS_BOOST.SHIELDING, player)
		elseif MsgContains(msg,"distance") then
			deliverFood(npc, HIRELING_FOODS_BOOST.DISTANCE, player)
		else
			npcHandler:say("Sorry, but you must choose a valid skill class. Would you like to boost your {magic}, {melee}, {shielding} or {distance} skill?", npc, player)
		end
	end
end

-- On creature say callback
local function creatureSayCallback(npc, player, type, msg)
	local playerId = player:getId()
	if not npcHandler:checkInteraction(npc, player) then
		return false
	end
	
	if not hireling:canTalkTo(player) then
		return false
	end

	-- roleplay
	if MsgContains(msg,"sword of fury") then
		npcHandler:say("In my youth I dreamt to wield it! Now I wield the broom of... brooming. I guess that's the next best thing!", npc, player)
	elseif MsgContains(msg,"rookgaard") then
		npcHandler:say("What an uncivilised place without any culture.", npc, player)
	elseif MsgContains(msg,"excalibug") then
		npcHandler:say("I'll keep an eye open for it when cleaning up the things you brought home!", npc, player)
	-- end roleplay
	elseif(MsgContains(msg, "service")) then
		setTopic(npc,TOPIC.SERVICES)
		local servicesMsg = getHirelingServiceString(npc, player)
		npcHandler:say(servicesMsg, npc, player)
	elseif(getTopic(npc) == TOPIC.SERVICES) then
		if MsgContains(msg, "bank") then
			if hireling:hasSkill(HIRELING_SKILLS.BANKER) then
				setTopic(npc, TOPIC.BANK)
				count[npc], transfer[npc] = nil, nil
				npcHandler:say(GREETINGS.BANK, npc, player)
			else
				sendSkillNotLearned(npc, HIRELING_SKILLS.BANKER)
			end
		elseif MsgContains(msg, "food") then
			if hireling:hasSkill(HIRELING_SKILLS.COOKING) then
				setTopic(npc, TOPIC.FOOD)
				npcHandler:say(GREETINGS.FOOD, npc, player)
			else
				sendSkillNotLearned(npc, HIRELING_SKILLS.COOKING)
			end
		elseif MsgContains(msg, "stash") then
			if hireling:hasSkill(HIRELING_SKILLS.STEWARD) then
				npcHandler:say(GREETINGS.STASH, npc, player)
				player:openStash(true)
			else
				sendSkillNotLearned(npc, HIRELING_SKILLS.STEWARD)
			end
		elseif MsgContains(msg, "goods") or MsgContains(msg, "trade") then
			setTopic(npc, TOPIC.GOODS)
			local goodsMsg = getGoodsGreetingMessage()
			npcHandler:say(goodsMsg, npc, player)
		elseif MsgContains(msg, "lamp") then
			setTopic(npc, TOPIC.LAMP)
			if player:getGuid() == hireling:getOwnerId() then
				npcHandler:say("Are you sure you want me to go back to my lamp?", npc, player)
			else
				return false
			end
		elseif MsgContains(msg, "outfit") then
			if player:getGuid() == hireling:getOwnerId() then
				hireling:requestOutfitChange()
				npcHandler:say("As you wish!", npc, player)
			else
				return false
			end
		end
	elseif(getTopic(npc) == TOPIC.LAMP) then
		if MsgContains(msg, "yes") then
			npcHandler:say("As you wish!", npc, player)
			hireling:returnToLamp(player:getGuid())
		else
			setTopic(npc, TOPIC.SERVICES)
			npcHandler:say("Alright then, I will be here.", npc, player)
		end
	elseif(getTopic(npc) >= TOPIC.BANK and getTopic(npc) < TOPIC.FOOD) then
		handleBankActions(npc, msg, player)
	elseif(getTopic(npc) >= TOPIC.FOOD and getTopic(npc) < TOPIC.GOODS) then
		handleFoodActions(npc, msg, player)
	elseif(getTopic(npc) >= TOPIC.GOODS) then
		if MsgContains(msg, "goods") or MsgContains(msg, "trade") then
			setTopic(npc, TOPIC.GOODS)
			local goodsMsg = getGoodsGreetingMessage()
			npcHandler:say(goodsMsg, npc, player)
		else
			handleGoodsActions(npc, msg)
		end
	end
end

-- Set to local function "greetCallback"
--npcHandler:setCallback(CALLBACK_GREET, greetCallback)

-- Set to local function "creatureSayCallback"
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

-- Bye message
--npcHandler:setMessage(MESSAGE_FAREWELL, "Yeah, good bye and don't come again!")
-- Walkaway message
--npcHandler:setMessage(MESSAGE_WALKAWAY, "You not have education?")

npcHandler:setMessage(MESSAGE_GREET, "Farewell, |PLAYERNAME|, I'll be here if you need me again.")

npcHandler:addModule(FocusModule:new())

-- Register npc
npcType:register(npcConfig)
