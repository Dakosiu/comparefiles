
local function addPlayerEvent(callable, delay, playerId, ...)
	local player = Player(playerId)
	if not player then
		return false
	end

	addEvent(function(callable, playerId, ...)
		local player = Player(playerId)
		if player then
			pcall(callable, player, ...)
		end
	end, delay, callable, player.uid, ...)
end


local shopOpcode = CreatureEvent("shopOpcode")
function shopOpcode.onExtendedOpcode(player, opcode, buffer)
    if opcode == CS_SHOP_RECEIVE then
        onShopCallback(player, opcode, buffer)
    end
end
shopOpcode:register()
local shopLogin = CreatureEvent("shopLogin")
function shopLogin.onLogin(player)
    player:registerEvent("shopOpcode")
    return true
end
shopLogin:register()

function onShopCallback(player, opcode, buffer)
	local status, json_data = pcall(function() return json.decode(buffer) end)
	if not status then return false end
	local action = json_data['action']
	local data = json_data['data']
	
	if GameStore.debug then
		print("Opcode "..opcode.." sent with value "..buffer)
	end
	
	if action == "getPoints" then
		player:sendShopBalance()
	elseif action == "buyItem" then
		player:storeBuyItem(data)
	elseif action == "changeName" then
		player:parseNameChange(data)
	elseif action == "getStoreData" then
		player:getShopData()
	elseif action == "getHistoryData" then
		player:getHistoryData()
	elseif action == "transferPoints" then
		player:transferPoints(data)
	elseif action == "getStoreUrl" then
		player:sendStoreURL()
	elseif action == "getImagesUrl" then
		player:sendImagesURL()
	elseif action == "getGender" then
		player:sendPlayerGender()
	elseif action == "openChest" then
		player:openChest(data.id, data.count)
		player:sendAttributes(player)
	end
end


function Player.addRewards(self, t)
    for i, v in pairs(t) do
		if v.type == "alpha points" then
			if v.count > 0 then
			    local vocation = v.vocation
				local t = POINTS_SYSTEM.earnPoints[vocation]
				print("POINTS TABLE: " .. dump(t))
				POINTS_SYSTEM:generatePoints(self, v.count, t)
			    --self:setPointsBalance(self:getPointsBalance() + v.count)
			end
		elseif v.type == "item" then
		    self:addToInventory(v.id, v.count)
		end
	end
end



function Player.addToInventory(self, id, count)
	local inventory = self:getStoreInbox()
	inventory:addItem(id, count, INDEX_WHEREEVER, FLAG_NOLIMIT)
	--inventory:addItem(id, count)
	return true
end
	
function Player.sendChestRewards(self, items)
    local packet = NetworkMessage()
	local t = {}
	t.buffer = "displayRewards"
	t.data = items
    packet:addByte(0x32)
    packet:addByte(0x6F) 
	packet:addString(json.encode(t))
	packet:sendToPlayer(self)
	packet:delete()
end

function Player.openChest(self, index, count)
    local t = storeIndex[1].offers[index]
	
	if not t then
	    print("This chest has no table yet, return.")
		return
	end
	
	local player_count = self:getChestCount(t.id)
	if player_count < 1 then
	    return
	end
	
	if not self:removeChestCount(index, count) then
	    return
	end
	
	
	local rewards = {}
	
	for i = 1, count do
	    local rewardTable = POINTS_SYSTEM:generateRewards(self, t)
		--print("Reward Table: " .. dump(rewardTable))
		
		
		for i, v in pairs(rewardTable) do
		    if not rewards[i] then
			    rewards[i] = {}
			    rewards[i].count = 0
				rewards[i].name = v.name
			    rewards[i].id = v.id
			end
			rewards[i].count = rewards[i].count + v.count
		end
		--self:sendChestRewards(rewardTable)
		--print(dump(rewardTable))
	end
	self:sendChestRewards(rewards)
	self:sendAttributes(self)
	
	-- local materialsTable = t.materials
	-- if not materialsTable  then
	    -- return
	-- end
	
	-- for i, v in ipairs(materialsTable) do
	    -- self:addToInventory(v.id, v.count)
		
	-- end
	
    

end

function Player.parseNameChange(self, data)
	local newName = data.name
	local tile = Tile(self:getPosition())
	local playerId = self:getId()
	
	if (tile) then
		if (not tile:hasFlag(TILESTATE_PROTECTIONZONE)) then
			return addPlayerEvent(sendMessageBox, 350, playerId, "Error", "You can change name only in Protection Zone.")
		end
	end
	
	local resultId = db.storeQuery("SELECT * FROM `players` WHERE `name` = " .. db.escapeString(newName) .. "")
	if resultId ~= false then
		return addPlayerEvent(sendMessageBox, 350, playerId, "Error", "This name is already used, please try again!")
	end
		
	local result = GameStore.canChangeToName(newName)
	if not result.ability then
		return addPlayerEvent(sendMessageBox, 350, playerId, "Error", result.reason)
	end
	
	local offerPrice = data.price
	self:removePointsBalance(offerPrice)
	GameStore.insertHistory(self:getAccountId(), "Character Name Change", (offerPrice) * -1)
	
	newName = newName:lower():gsub("(%l)(%w*)", function(a, b) return string.upper(a) .. b end)
	db.query("UPDATE `players` SET `name` = " .. db.escapeString(newName) .. " WHERE `id` = " .. self:getGuid())
	message = "You have successfully changed you name, relogin!"
	
	-- We hide the store
	self:sendHideStore()
	
	addEvent(function()
		local self = Player(playerId)
		if not self then
			return false
		end

		self:remove()
	end, 1000)
end

GameStore.canChangeToName = function(name)
	local result = {
		ability = false
	}
	
	if name:len() < 3 or name:len() > 14 then
		result.reason = "The length of your new name must be between 3 and 14 characters."
		return result
	end

	local match = name:gmatch("%s+")
	local count = 0
	for v in match do
		count = count + 1
	end

	local matchtwo = name:match("^%s+")
	if (matchtwo) then
		result.reason = "Your new name can't have whitespace at begin."
		return result
	end

	if (count > 1) then
		result.reason = "Your new name have more than 1 whitespace."
		return result
	end

	-- just copied from znote aac.
	local words = { "owner", "gamemaster", "hoster", "admin", "staff", "tibia", "account", "god", "anal", "ass", "fuck", "sex", "hitler", "pussy", "dick", "rape", "adm", "cm", "gm", "tutor", "counsellor" }
	local split = name:split(" ")
	for k, word in ipairs(words) do
		for k, nameWord in ipairs(split) do
			if nameWord:lower() == word then
				result.reason = "You can't use word \"" .. word .. "\" in your new name."
				return result
			end
		end
	end

	local tmpName = name:gsub("%s+", "")
	for i = 1, #words do
		if (tmpName:lower():find(words[i])) then
			result.reason = "You can't use word \"" .. words[i] .. "\" with whitespace in your new name."
			return result
		end
	end

	if MonsterType(name) then
		result.reason = "Your new name \"" .. name .. "\" can't be a monster's name."
		return result
	elseif Npc(name) then
		result.reason = "Your new name \"" .. name .. "\" can't be a npc's name."
		return result
	end

	local letters = "{}|_*+-=<>0123456789@#%^&()/*'\\.,:;~!\"$"
	for i = 1, letters:len() do
		local c = letters:sub(i, i)
		for i = 1, name:len() do
			local m = name:sub(i, i)
			if m == c then
				result.reason = "You can't use this letter \"" .. c .. "\" in your new name."
				return result
			end
		end
	end
	result.ability = true
	return result
end

function sendJSONEvent(playerId, opcode, action, data)
	local getPlayer = Player(playerId)
	if not getPlayer then return end
	
	local msg = NetworkMessage()
	msg:addByte(50)
	msg:addByte(opcode)
	msg:addString(json.encode({action = action, data = data}))
	msg:sendToPlayer(getPlayer)
end

function repetitiveSend(player,opcode,action,data)
	local getBuffer = json.encode(data)
	local lastGroup = math.ceil(string.len(getBuffer)/5000)
	local actualI=0
	for i = 1,lastGroup do
		local sendData = string.sub(getBuffer, ((i-1)*5000)+1, i*5000)
		local sendFirst = "false"
		local sendLast = "false"
		actualI = (actualI+1)
		if i == lastGroup then
			sendLast = "true"
		end
		if i == 1 then
			sendFirst = "true"
		end
        addEvent(sendJSONEvent,(actualI*60), player:getId(), opcode, action, {opcodeDataFirst = sendFirst,opcodeDataLast = sendLast,opcodeData = sendData} )
	end
end

function Player.sendPlayerGender(self)
	repetitiveSend(self, CS_SHOP_SERVERSIDE, "sendPlayerSex", {sex = self:getSex()})
end

function Player.sendMessageBox(self, t, m)
	repetitiveSend(self, CS_SHOP_SERVERSIDE, "sendMessage", {title = t, message = m})
end

function Player.sendShopBalance(self)
	repetitiveSend(self, CS_SHOP_SERVERSIDE, "sendPoints", {points=self:getPointsBalance()})
end

function Player.getShopData(self)
	local filterData = deepCopy(storeIndex)
	
	for i,child in pairs(storeIndex) do
		local newOffers = {}
		for _i,_child in pairs(child.offers) do
			if not _child.vocationId or self:isVocation(_child.vocationId) then
				table.insert(newOffers,_child)
			end
		end
		filterData[i].offers = newOffers
	end
	
	--print("Filter Data: " .. dump(filterData))
	repetitiveSend(self, CS_SHOP_SERVERSIDE, "sendStoreData", {data=filterData})
end

function Player.getHistoryData(self)
	local finalOutput = {}
	local historyList = GameStore.retrieveHistoryEntries(self:getAccountId())
	
	for i = 1, #historyList do
		finalOutput[i] = {date = timestampToDate(historyList[i].date), balance = historyList[i].balance, description = historyList[i].description}
	end
	
	repetitiveSend(self, CS_SHOP_SERVERSIDE, "sendHistory", {history=finalOutput})
end

function Player.sendStoreURL(self)
	repetitiveSend(self, CS_SHOP_SERVERSIDE, "sendStoreURL", {url = GameStore.storeUrl})
end

function Player.sendImagesURL(self)
	repetitiveSend(self, CS_SHOP_SERVERSIDE, "sendImagesURL", {url = GameStore.imagesUrl})
end

function Player.sendHideStore(self)
	repetitiveSend(self, CS_SHOP_SERVERSIDE, "sendHideStore", {})
end

function Player.transferPoints(self, data)
	local player = Player(self)
	if not player then
		return false
	end
	
	local playerId = player:getId()
	local receiver = data.name
	local amount = data.amount
	
	if (player:getPointsBalance() < amount) then
		return addPlayerEvent(sendMessageBox, 350, playerId, "Error", "You don't have this amount of points.")
	end

	if receiver:lower() == player:getName():lower() then
		return addPlayerEvent(sendMessageBox, 350, playerId, "Error", "You can't transfer points to yourself.")
	end

	local resultId = db.storeQuery("SELECT `id` FROM `players` WHERE `name` = " .. db.escapeString(receiver:lower()) .. "")
	if not resultId then
		return addPlayerEvent(sendMessageBox, 350, playerId, "Error", "We couldn't find that player.")
	end

	local accountId = result.getDataInt(resultId, "id")
	if accountId == player:getAccountId() then
		return addPlayerEvent(sendMessageBox, 350, playerId, "Error", "You cannot transfer point to a character in the same account.")
	end
	
	db.query("UPDATE `"..GameStore.table.."` SET `"..GameStore.tableName.."` = `"..GameStore.tableName.."` + " .. amount .. " WHERE `id` = " .. accountId)
	player:removePointsBalance(amount)
	addPlayerEvent(sendMessageBox, 350, playerId, "Transfer Successfull", "You have transfered " .. amount .. " points to " .. receiver .. " successfully")

	-- Adding history for both receiver/sender
	GameStore.insertHistory(accountId, player:getName() .. " transfered you this amount.", amount)
	GameStore.insertHistory(player:getAccountId(), "You transfered this amount to "..receiver, -1 * amount) -- negative
end

local shopBagConfig = {
	[3456] = {{2152,50},{2160,5}},
	[3459] = {{2152,50},{2160,5}},
}

local shopOpenBag = Action()

function shopOpenBag.onUse(player, item, fromPosition, target, toPosition, isHotkey)
--storage inventory chest
	for i,child in pairs(storeIndex) do
		for _i,_child in pairs(child.offers) do
			if _child.actionId and item:getActionId() == _child.actionId then
				local getData = deepCopy(_child)
				getData.packageId = nil
				getData.actionId = nil
				if player:storeBuyItem(getData) then
					item:remove()
					return true
				end
			end
		end
	end
	
	return false
end

for i,child in pairs(storeIndex) do
	for _i,_child in pairs(child.offers) do
		if _child.actionId then
			shopOpenBag:aid(_child.actionId)
		end
	end
end
shopOpenBag:register()

function Player.getChestCount(self, index)
	local key = Wikipedia.storageTable["Chest"..index]
	local value = self:getStorageValue(key)
	if value < 0 then
	    value = 0
	end
	return value
end

function Player.sendClaimedChest(self, name, image)
    local t = {}
	t.buffer = "displayClaimedChest"
	t.data = {}
	local text = "YOU'VE EARNED A"
	if name:lower() == "artifact chest" then
	    text = text .. "N"
	end
	text = text .. " " .. name
	t.data.text = text
	t.data.image = image
	local packet = NetworkMessage()
	packet:addByte(0x32)
    packet:addByte(0x71) 
	packet:addString(json.encode(t))
	packet:sendToPlayer(self)
	packet:delete()
end
	
	
	
function Player.addChestCount(self, index, count)
    local key = Wikipedia.storageTable["Chest"..index]
	local value = self:getChestCount(index)
	local t = storeIndex[1].offers[index]
	self:sendClaimedChest(t.name, t.image2)
	self:sendAttributes(self)
	return self:setStorageValue(key, value + count)
end

function Player.removeChestCount(self, index, count)
    local key = Wikipedia.storageTable["Chest"..index]
	local value = self:getChestCount(index)
	if value < 1 then
	    return false
	end
	self:setStorageValue(key, value - count)
	self:sendAttributes(self)
	return true
end


function Player.storeBuyItem(self, data)
	local playerId = self:getId()	
	if (table.contains(GameStore_OfferTypes, data.type) == false)                    -- we've got an invalid offer type
		or (not self)                                                                -- player not found
		or (not data)                                                                  -- we could not find the offer
		or (data.type == GameStore_OfferTypes.OFFER_TYPE_NONE)                        -- offer is disabled
		or not data.id then
		return addPlayerEvent(sendMessageBox, 350, playerId, "Error", "This offer is unavailable [1].")
	end
	
		local offerSexIdTable = data.id
		if type(offerSexIdTable) == "table" then
			if self:getSex() == PLAYERSEX_MALE then
				looktype = offerSexIdTable.male
			elseif self:getSex() == PLAYERSEX_FEMALE then
				looktype = offerSexIdTable.female
			end
		end
		if data.shopCall then
			if not self:canRemovePoints(data.price) then
				return addPlayerEvent(sendMessageBox, 350, playerId, "Error", "You don't have enough points. Your purchase has been cancelled.")
			end
		end
		
		if not data.packageId and not data.actionId then 
			if data.type == GameStore_OfferTypes.OFFER_TYPE_ITEM then
				if self:getFreeCapacity() < ItemType(data.id):getWeight(data.count) then
					return addPlayerEvent(sendMessageBox, 350, playerId, "Error", "Please make sure you have free capacity to hold this item.")
				end
				local slotNeeded = data.count
				local itemCounter = data.count
				if ItemType(data.id):isStackable() then
					slotNeeded = math.ceil(data.count / 100)
				end
				
				local backpack = self:getStoreInbox()
				
				if backpack and backpack:getEmptySlots(true) >= slotNeeded then
					if ItemType(data.id):isStackable() then
						for i = 1,slotNeeded do
							local valueLeft = itemCounter >= 100 and 100 or itemCounter 
							self:addItem(data.id, valueLeft)
							itemCounter = itemCounter - valueLeft
						end
					else
						backpack:addItem(data.id, slotNeeded)
					end
				else
					return addPlayerEvent(sendMessageBox, 350, playerId, "Error", "Please make sure you have free slots in your backpack.")
				end
			elseif data.type == GameStore_OfferTypes.OFFER_TYPE_MESSAGE then
				local logFormat = "[%s] %s: %s"
				local file = io.open("data/logs/premiumMessages.log", "a")
				if not file then
					return
				end

				io.output(file)
				io.write(logFormat:format(os.date("%d/%m/%Y %H:%M"), self:getName(), data.name):trim() .. "\n")
				io.close(file)
			elseif data.type == GameStore_OfferTypes.OFFER_TYPE_STORAGE then
			    self:addChestCount(data.id, data.count, data.name, data.image)
				
			    --print("Dodao skrzynke")
			    --print("Reward type storage")
				-- if type(data.id) == "string" then 
					-- if not Wikipedia.storageTable[data.id] then
						-- return addPlayerEvent(sendMessageBox, 350, playerId, "Error", "Bad storage id in config.")
					-- end
					-- local count = self:getChestCount(data.id)
					-- self:addChestCount(data.id, data.count)
					-- --print("Tu jestem?")
					-- --self:setStorageValue(Wikipedia.storageTable[data.id], math.max(0, self:getStorageValue(Wikipedia.storageTable[data.id])) + data.count)
					-- --self:sendAttributes(self)
				-- else
				    -- --print("Tu jestem? 2")
					-- --self:setStorageValue(data.id, math.max(0, self:getStorageValue(data.id)) + data.count)
				-- end
				--self:sendAttributes(self)
				
			elseif data.type == GameStore_OfferTypes.OFFER_TYPE_OUTFIT then

				if not looktype then
					return addPlayerEvent(sendMessageBox, 350, playerId, "Error", "This outfit seems not to suit your sex, we are sorry for that!")
				elseif self:hasOutfit(looktype) then
					return addPlayerEvent(sendMessageBox, 350, playerId, "Error", "You already own this outfit.")
				else
				
						self:addOutfit(offerSexIdTable.male)
						self:addOutfit(offerSexIdTable.female)
			
			end
			elseif data.type == GameStore_OfferTypes.OFFER_TYPE_FULLOUTFIT then
				if not looktype then
					return addPlayerEvent(sendMessageBox, 350, playerId, "Error", "This outfit seems not to suit your sex, we are sorry for that!")
				elseif self:hasOutfit(looktype, 7) then
					return addPlayerEvent(sendMessageBox, 350, playerId, "Error", "You already own this outfit.")
				else
				
						self:addOutfit(offerSexIdTable.male)
						self:addOutfitAddon(offerSexIdTable.male, 7)
						
						self:addOutfit(offerSexIdTable.female)
						self:addOutfitAddon(offerSexIdTable.female, 7)
		end
			elseif data.type == GameStore_OfferTypes.OFFER_TYPE_OUTFIT_ADDON then
				if not looktype then
					return addPlayerEvent(sendMessageBox, 350, playerId, "Error", "This outfit seems not to suit your sex, we are sorry for that!")
				elseif (not data.addons) then
					return addPlayerEvent(sendMessageBox, 350, playerId, "Error", "You don't picked any addons!")
				elseif self:hasOutfit(looktype, data.addons) then
					return addPlayerEvent(sendMessageBox, 350, playerId, "Error", "You already own this outfit.")
				else
				
				self:addOutfitAddon(looktype, data.addons)
			end
			elseif data.type == GameStore_OfferTypes.OFFER_TYPE_SEXCHANGE then
				local currentSex = self:getSex()
				local playerOutfit = self:getOutfit()

				playerOutfit.lookAddons = 0
				if currentSex == PLAYERSEX_FEMALE then
					self:setSex(PLAYERSEX_MALE)
					playerOutfit.lookType = 128
				else
					self:setSex(PLAYERSEX_FEMALE)
					playerOutfit.lookType = 136
				end
				
				self:setOutfit(playerOutfit)
				self:sendHideStore()
			elseif data.type == GameStore_OfferTypes.OFFER_TYPE_TEMPLE then
				if self:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT) or self:isPzLocked() then
					return addPlayerEvent(sendMessageBox, 350, playerId, "Error", "You can't use temple teleport in fight!")
				end

				self:teleportTo(self:getTown():getTemplePosition())
				self:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				self:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You have been teleported to your hometown.')
			elseif data.type == GameStore_OfferTypes.OFFER_TYPE_PREMIUM then
				self:addPremiumDays(data.count)
			elseif data.type == GameStore_OfferTypes.OFFER_TYPE_BLESSINGS then
				if not self:hasBlessing(data.id) then
					self:addBlessing(data.id)
				else
					return addPlayerEvent(sendMessageBox, 350, playerId, "Error", "Sorry, you already posses this blessing.")
				end
			elseif data.type == GameStore_OfferTypes.OFFER_TYPE_ALLBLESSINGS then
				if (self:getBlessingCount() >= 5) then
					return addPlayerEvent(sendMessageBox, 350, playerId, "Error", "Sorry, you already posses all blessing.")
				end
				
				for i = 1, 5 do
					self:addBlessing(i)
				end
			
			elseif data.type == GameStore_OfferTypes.OFFER_TYPE_SHADER then
				if self:hasShader(data.id) then
					return addPlayerEvent(sendMessageBox, 350, playerId, "Error", "You already own this shader!")
				end
				self:addShader(data.id)
			elseif data.type == GameStore_OfferTypes.OFFER_TYPE_MOUNT then
				if self:hasMount(data.id) then
					return addPlayerEvent(sendMessageBox, 350, playerId, "Error", "You already own this kinto!")
				end
				self:addMount(data.id)
			elseif data.type == GameStore_OfferTypes.OFFER_TYPE_AURA then
				if self:hasAura(data.id) then
					return addPlayerEvent(sendMessageBox, 350, playerId, "Error", "You already own this aura!")
				end
				self:addAura(data.id)
			elseif data.type == GameStore_OfferTypes.OFFER_TYPE_WINGS then
				if self:hasWings(data.id) then
					return addPlayerEvent(sendMessageBox, 350, playerId, "Error", "You already own this wings!")
				end
				self:addWings(data.id)
			
			else
			print("Shop unsupported data.type!")
			end
		else
			if self:getFreeCapacity() < ItemType(data.packageId):getWeight(1) then
				return addPlayerEvent(sendMessageBox, 350, playerId, "Error", "Please make sure you have free capacity to hold this item.")
			end
			
			local backpack = self:getStoreInbox()
			if backpack and backpack:getEmptySlots(true) >= 1 then
				local createItem = backpack:addItem(data.packageId, 1)
			if not createItem then return addPlayerEvent(sendMessageBox, 350, playerId, "Error", "Please make sure item have store attribute.") end
				createItem:setActionId(data.actionId)
			else
				return addPlayerEvent(sendMessageBox, 350, playerId, "Error", "Please make sure you have free slots in your premium bag.")
			end
		
		end
	if data.shopCall then
		self:removePointsBalance(data.price)
		self:sendShopBalance()
		self:sendHideStore()
		GameStore.insertHistory(self:getAccountId(), data.name, (data.price) * -1)
		--local message = string.format("You have purchased %s for %d points.", data.name, data.price)
		--addPlayerEvent(sendMessageBox, 350, playerId, "Purchase Successfull", message)
	end
	return true
end

-- History Related Functions
GameStore.insertHistory = function(accountId, description, amount)
	return db.query(string.format("INSERT INTO `znote_shop_logs`(`account_id`, `type`, `description`, `points`, `time`) VALUES (%s, %s, %s, %s, %s)", accountId, 0, db.escapeString(description), amount, os.time()))
end

GameStore.retrieveHistoryTotalEntries = function (accountId) 
	local resultId = db.storeQuery("SELECT count(id) as total FROM znote_shop_logs WHERE account_id = " .. accountId)
	if resultId == false then
		return 0
	end

	local totalPages = result.getDataInt(resultId, "total")
	result.free(resultId)
	return totalPages
end

GameStore.retrieveHistoryEntries = function(accountId)
	local entries = {}
	
	local resultId = db.storeQuery("SELECT * FROM `znote_shop_logs` WHERE `account_id` = " .. accountId .. " ORDER BY `time` DESC LIMIT " .. GameStore.historyMaxRows .. ";")
	if resultId ~= false then
		repeat
			local entry = {
				description = result.getDataString(resultId, "description"),
				balance = result.getDataInt(resultId, "point_amount"),
				date = result.getDataInt(resultId, "time"),
			}
			table.insert(entries, entry)
		until not result.next(resultId)
		result.free(resultId)
	end
	
	return entries
end

-- Points related functions

-- Special Functions
function sendMessageBox(self, title, message)
	local player = Player(self)
	if not player then return true end
	
	player:sendMessageBox(title, message)
return true
end

function Player.getBlessingCount(self)
	local t = 0
	for i = 1, 5 do
		if self:hasBlessing(i) then
			t = t + 1
		end
	end
return t
end

local function addPlayerEvent(callable, delay, playerId, ...)
	local player = Player(playerId)
	if not player then
		return false
	end

	addEvent(function(callable, playerId, ...)
		local player = Player(playerId)
		if player then
			pcall(callable, player, ...)
		end
	end, delay, callable, player.uid, ...)
end

function timestampToDate(timestamp)
    local day_count, year, days, month = function(yr) return (yr % 4 == 0 and (yr % 100 ~= 0 or yr % 400 == 0)) and 366 or 365 end, 1970, math.ceil(timestamp/86400)
    while days >= day_count(year) do
        days = days - day_count(year) year = year + 1
    end
	
    local tab_overflow = function(seed, table) for i = 1, #table do if seed - table[i] <= 0 then return i, seed end seed = seed - table[i] end end
    month, days = tab_overflow(days, {31,(day_count(year) == 366 and 29 or 28),31,30,31,30,31,31,30,31,30,31})
    local hours, minutes, seconds = math.floor(timestamp / 3600 % 24), math.floor(timestamp / 60 % 60), math.floor(timestamp % 60)
    hours = hours > 12 and hours - 12 or hours == 0 and 12 or hours
    return string.format("%d-%d-%d, %02d:%02d:%02d", year, month, days, hours, minutes, seconds)
end