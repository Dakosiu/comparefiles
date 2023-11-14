CHECKPOINTS_SYSTEM = {
	[1] = { name = "Evotronus main house (no protection zone)", position = { 819, 872, 3 } },
	[2] = { name = "Evotronus training palace (no protection zone)", position = { 979, 882, 5 } },
	[3] = { name = "First desert, safe house", position = { 1155, 1040, 7 } },
	[4] = { name = "First Dragon way, safe house", position = { 893, 1048, 6 } },
	[5] = { name = "Grasslands, safe house", position = { 882, 672, 4 } },
	[6] = { name = "Explorer lands, safe house", position = { 1170, 993, 2 } },
	[7] = { name = "The 5 elements lands, safe house", position = { 1069, 1232, 7 } },
}


local players = {}


Checkpoints = {}
Checkpoints.__newindex = Checkpoints

CHECKPOINTS_SYSTEM.ActionID = 52334
CHECKPOINTS_SYSTEM.ItemID = 27604


CHECKPOINTS_SYSTEM.showInvitedHouses = true

if not CHECKPOINTS_SYSTEM.invitedHouses then
   CHECKPOINTS_SYSTEM.invitedHouses = {}
end

function Checkpoints:updateHouses()
    if not CHECKPOINTS_SYSTEM.showInvitedHouses then
	   return
	end
    if not CHECKPOINTS_SYSTEM.invitedHouses["List"] then
       CHECKPOINTS_SYSTEM.invitedHouses["List"] = {}
    end
    
	local houses = Game.getHouses()
	for _, house in ipairs(Game.getHouses()) do
	    CHECKPOINTS_SYSTEM.invitedHouses["List"][house:getId()] = house:getAccessList(GUEST_LIST)
	end
end

function Checkpoints:updateInvitedHouse(id, text)
    if not CHECKPOINTS_SYSTEM.showInvitedHouses then
	   return
	end
	
	if not CHECKPOINTS_SYSTEM.invitedHouses then
	   return
	end
	CHECKPOINTS_SYSTEM.invitedHouses["List"][id] = name
end

function Checkpoints:getInvitedHouses(player)
    if not CHECKPOINTS_SYSTEM.showInvitedHouses then
	   return
	end
    if not CHECKPOINTS_SYSTEM.invitedHouses["List"] then
       CHECKPOINTS_SYSTEM.invitedHouses["List"] = {}
    end
	
    local t = {}
	for i, v in pairs(CHECKPOINTS_SYSTEM.invitedHouses["List"]) do
	    if string.find(v, player:getName()) then
		   table.insert(t, i)
		end
	end
	return t
end

 


local players = {}


function Checkpoints:setActionId()
	for i = 1, #CHECKPOINTS_SYSTEM do
		local pos = Position(CHECKPOINTS_SYSTEM[i].position[1], CHECKPOINTS_SYSTEM[i].position[2],
			CHECKPOINTS_SYSTEM[i].position[3])
		local tile = Tile(pos)
		if tile then
			local ground = tile:getGround()
			if ground then
				local id = ground:getId()
				local item = tile:getItemById(id)
				if item then
					item:setAttribute(ITEM_ATTRIBUTE_ACTIONID, CHECKPOINTS_SYSTEM.ActionID)
				end
			end
		end
	end
end

function Checkpoints:getIndex(player)

	if not player then
		return nil
	end


	for i = 1, #CHECKPOINTS_SYSTEM do
		local pos = Position(CHECKPOINTS_SYSTEM[i].position[1], CHECKPOINTS_SYSTEM[i].position[2],
			CHECKPOINTS_SYSTEM[i].position[3])
		if pos == player:getPosition() then
			return i
		end
	end

	return 0

end

function Checkpoints:add(player)

	if not player then
		return nil
	end

	local index = Checkpoints:getIndex(player)
	local storage = CHECKPOINTS_SYSTEM.ActionID + index


	if player:getStorageValue(storage) > 0 then
		return false
	end

	player:setStorageValue(storage, 1)
	local pos = player:getPosition()
	pos:sendMagicEffect(CONST_ME_MAGIC_GREEN)
	local name = CHECKPOINTS_SYSTEM[index].name
	player:sendTextMessage(MESSAGE_INFO_DESCR, "You have discovered a " .. name .. " checkpoint.")
	return true

end

function Checkpoints:getFight(player)

	if not player then
		return true
	end

	if player:hasCondition(CONDITION_INFIGHT) then
		return true
	end

	return false
end

function Checkpoints:Check(player)

	local container = nil
	local containers = {}
	local items = {}

	local check_count = 0

	while check_count < 4 do

		if check_count == 0 then
			container = player:getSlotItem(CONST_SLOT_BACKPACK)
		elseif check_count == 1 then
			container = player:getSlotItem(CONST_SLOT_RIGHT)
		elseif check_count == 2 then
			container = player:getSlotItem(CONST_SLOT_LEFT)
		elseif check_count == 3 then
			container = player:getSlotItem(CONST_SLOT_AMMO)
		end

		if container and container:isContainer() then
			table.insert(containers, container)
		end
		if container then
			table.insert(items, container.uid)
		end

		while #containers > 0 do
			for i = (containers[1]:getSize() - 1), 0, -1 do
				local it = containers[1]:getItem(i)
				if it:isContainer() then
					table.insert(containers, it)
				else
					table.insert(items, it.uid)
				end
			end
			table.remove(containers, 1)
		end

		check_count = check_count + 1
	end


	return items
end

function Checkpoints:setBlockItemMove(player, method)

	if not player then
		return nil
	end

	if not method then
		return player:setStorageValue(CHECKPOINTS_SYSTEM.ActionID, 0)
	end
	player:setStorageValue(CHECKPOINTS_SYSTEM.ActionID, 1)
end

function Checkpoints:getBlockItemMove(player)

	if not player then
		return nil
	end

	if player:getStorageValue(CHECKPOINTS_SYSTEM.ActionID) > 0 then
		return true
	end
	return false
end


function Checkpoints:getNameByGuid(id)
    
	local resultId = db.storeQuery("SELECT `name` FROM `players` WHERE `id` = " .. id)
    if resultId ~= false then
        local name = result.getString(resultId, "name")
        result.free(resultId)
        return name
    end
    return false
end


function Checkpoints:sendList(player)

	if not player then
		return nil
	end

	player:registerEvent("ModalWindow_checkpoints")

	local title = "Checkpoints - Teleporter"
	local message = "Avaible Places: "

	local window = ModalWindow(1001, title, message)
	window:addButton(100, "Select")
	window:addButton(101, "Cancel")
	window:setDefaultEnterButton(100)
	window:setDefaultEscapeButton(101)

	players[player:getId()] = {}

	local index = 0

	local house = player:getHouse()
	if house then
		index = index + 1
		local housePosition = house:getExitPosition()
		local pos = { housePosition.x, housePosition.y, housePosition.z }
		local values = { ["position"] = pos, ["name"] = "Home" }
		table.insert(players[player:getId()], values)
		window:addChoice(index, players[player:getId()][index]["name"])
	end

	for i = 1, #CHECKPOINTS_SYSTEM do
		if player:getStorageValue(CHECKPOINTS_SYSTEM.ActionID + i) > 0 then
			index = index + 1
			local pos = CHECKPOINTS_SYSTEM[i].position
			local name = CHECKPOINTS_SYSTEM[i].name
			local values = { ["position"] = pos, ["name"] = name }
			table.insert(players[player:getId()], values)
			window:addChoice(index, players[player:getId()][index]["name"])
		end
	end
	
	Checkpoints:updateHouses()
    local houseTable = Checkpoints:getInvitedHouses(player)
	for i, v in ipairs(houseTable) do
	    index = index + 1
	    local house = House(v)
		
		--local name = house:getName()
		
		local guid = house:getOwnerGuid()
		local name = Checkpoints:getNameByGuid(guid)
		name = name .. " House"
		
		--local name = house:getOwner
		local housePosition = house:getExitPosition()
		local pos = { housePosition.x, housePosition.y, housePosition.z }
		local values = { ["position"] = pos, ["name"] = name }
		table.insert(players[player:getId()], values)
		window:addChoice(index, name)
    end

	if index == 0 then
		player:sendCancelMessage("You didnt discoreved any checkpoint yet.")
		player:sendTextMessage(MESSAGE_STATUS_WARNING, "You didnt discoreved any checkpoint yet.")
		player:getPosition():sendMagicEffect(236)
		return
	end

	return window:sendToPlayer(player)
end

-- local talk = TalkAction("/teleportt", "!teleport")
-- function talk.onSay(player, words, param)
-- Checkpoints:setActionId()
-- Checkpoints:sendList(player)
-- return false
-- end
-- talk:separator(" ")
-- talk:register()

local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	if not isInArray(Checkpoints:Check(player), item.uid) then
		player:sendTextMessage(MESSAGE_STATUS_WARNING, "this item cannot be used from ground.")
		return true
	end
	Checkpoints:sendList(player)
	return true
end

action:id(CHECKPOINTS_SYSTEM.ItemID)
action:register()

local moveevent = MoveEvent()
moveevent:type("stepin")
function moveevent.onStepIn(creature, item, position, fromPosition)
	local player = Player(creature)
	if not player or player:isInGhostMode() then
		return true
	end

	Checkpoints:add(player)
end

moveevent:aid(CHECKPOINTS_SYSTEM.ActionID)
moveevent:register()

local creaturescript = CreatureEvent("ModalWindow_checkpoints")
function creaturescript.onModalWindow(player, modalWindowId, buttonId, choiceId)

	player:unregisterEvent("ModalWindow_checkpoints")

	if buttonId == 101 then
		return false
	end

	local t = players[player:getId()][choiceId]
	local pos = Position(t.position[1], t.position[2], t.position[3])

	if player:getPosition() == pos then
		player:sendCancelMessage("You are already on this place.")
		Checkpoints:sendList(player)
		return true
	end

	if Checkpoints:getFight(player) then
		player:sendCancelMessage("You can't use teleporter while fighting.")
		return true
	end

	local times = 15
	local interval = 1000
	local delay = 0

	for i = 1, times do
		if i == 1 then
			delay = 0
		else
			delay = delay + interval
		end

		local teleportEvent = addEvent(function()
			local user = Player(player:getId())

			if not user then
				return false
			end

			Checkpoints:setBlockItemMove(player, true)

			if Checkpoints:getFight(user) then
				Checkpoints:setBlockItemMove(user, false)
				stopEvent(teleportEvent)
				return user:sendCancelMessage("You got into fight, so your teleportation powers have been lost.")
			end

			if user:getItemCount(CHECKPOINTS_SYSTEM.ItemID) < 1 then
				Checkpoints:setBlockItemMove(user, false)
				stopEvent(teleportEvent)
				return user:sendCancelMessage("You have lost magic item, so your teleportation powers have been lost.")
			end


			local colours = {
				TEXTCOLOR_BLUE,
				TEXTCOLOR_LIGHTGREEN,
				TEXTCOLOR_LIGHTBLUE,
				TEXTCOLOR_MAYABLUE,
				TEXTCOLOR_DARKRED,
				TEXTCOLOR_LIGHTGREY,
				TEXTCOLOR_SKYBLUE,
				TEXTCOLOR_PURPLE,
				TEXTCOLOR_ELECTRICPURPLE,
				TEXTCOLOR_RED,
				TEXTCOLOR_PASTELRED,
				TEXTCOLOR_ORANGE,
				TEXTCOLOR_YELLOW,
				TEXTCOLOR_WHITE_EXP
			}

			local color = math.random(1, #colours)

			Game.sendAnimatedText(times - i, user:getPosition(), colours[color])

			if i == times then
				user:getPosition():sendMagicEffect(194)
			else
				user:getPosition():sendMagicEffect(368)
				user:sendCancelMessage("You will be teleported in " .. times - i .. " seconds.")
			end

			if i == times then
				user:sendCancelMessage("You have been teleported.")
				user:teleportTo(pos)
				pos:sendMagicEffect(380)
				user:removeItem(CHECKPOINTS_SYSTEM.ItemID, 1)
				Checkpoints:setBlockItemMove(user, false)
				players[user:getId()] = {}
			end

		end, delay)

	end


	return true

end

creaturescript:register()

-- Checkpoints = {}
-- Checkpoints.__newindex = Checkpoints

-- CHECKPOINTS_SYSTEM.ActionID = 52334
-- CHECKPOINTS_SYSTEM.ItemID = 27604


-- function Checkpoints:setActionId()
	-- for i = 1, #CHECKPOINTS_SYSTEM do
		-- local pos = Position(CHECKPOINTS_SYSTEM[i].position[1], CHECKPOINTS_SYSTEM[i].position[2],
			-- CHECKPOINTS_SYSTEM[i].position[3])
		-- local tile = Tile(pos)
		-- if tile then
			-- local ground = tile:getGround()
			-- if ground then
				-- local id = ground:getId()
				-- local item = tile:getItemById(id)
				-- if item then
					-- item:setAttribute(ITEM_ATTRIBUTE_ACTIONID, CHECKPOINTS_SYSTEM.ActionID)
				-- end
			-- end
		-- end
	-- end
-- end

-- function Checkpoints:getIndex(player)

	-- if not player then
		-- return nil
	-- end


	-- for i = 1, #CHECKPOINTS_SYSTEM do
		-- local pos = Position(CHECKPOINTS_SYSTEM[i].position[1], CHECKPOINTS_SYSTEM[i].position[2],
			-- CHECKPOINTS_SYSTEM[i].position[3])
		-- if pos == player:getPosition() then
			-- return i
		-- end
	-- end

	-- return 0

-- end

-- function Checkpoints:add(player)

	-- if not player then
		-- return nil
	-- end

	-- local index = Checkpoints:getIndex(player)
	-- local storage = CHECKPOINTS_SYSTEM.ActionID + index


	-- if player:getStorageValue(storage) > 0 then
		-- return false
	-- end

	-- player:setStorageValue(storage, 1)
	-- local pos = player:getPosition()
	-- pos:sendMagicEffect(CONST_ME_MAGIC_GREEN)
	-- local name = CHECKPOINTS_SYSTEM[index].name
	-- player:sendTextMessage(MESSAGE_INFO_DESCR, "You have discovered a " .. name .. " checkpoint.")
	-- return true

-- end

-- function Checkpoints:getFight(player)

	-- if not player then
		-- return true
	-- end

	-- if player:hasCondition(CONDITION_INFIGHT) then
		-- return true
	-- end

	-- return false
-- end

-- function Checkpoints:Check(player)

	-- local container = nil
	-- local containers = {}
	-- local items = {}

	-- local check_count = 0

	-- while check_count < 4 do

		-- if check_count == 0 then
			-- container = player:getSlotItem(CONST_SLOT_BACKPACK)
		-- elseif check_count == 1 then
			-- container = player:getSlotItem(CONST_SLOT_RIGHT)
		-- elseif check_count == 2 then
			-- container = player:getSlotItem(CONST_SLOT_LEFT)
		-- elseif check_count == 3 then
			-- container = player:getSlotItem(CONST_SLOT_AMMO)
		-- end

		-- if container and container:isContainer() then
			-- table.insert(containers, container)
		-- end
		-- if container then
			-- table.insert(items, container.uid)
		-- end

		-- while #containers > 0 do
			-- for i = (containers[1]:getSize() - 1), 0, -1 do
				-- local it = containers[1]:getItem(i)
				-- if it:isContainer() then
					-- table.insert(containers, it)
				-- else
					-- table.insert(items, it.uid)
				-- end
			-- end
			-- table.remove(containers, 1)
		-- end

		-- check_count = check_count + 1
	-- end


	-- return items
-- end

-- function Checkpoints:setBlockItemMove(player, method)

	-- if not player then
		-- return nil
	-- end

	-- if not method then
		-- return player:setStorageValue(CHECKPOINTS_SYSTEM.ActionID, 0)
	-- end
	-- player:setStorageValue(CHECKPOINTS_SYSTEM.ActionID, 1)
-- end

-- function Checkpoints:getBlockItemMove(player)

	-- if not player then
		-- return nil
	-- end

	-- if player:getStorageValue(CHECKPOINTS_SYSTEM.ActionID) > 0 then
		-- return true
	-- end
	-- return false
-- end

-- function Checkpoints:sendList(player)

	-- if not player then
		-- return nil
	-- end

	-- player:registerEvent("ModalWindow_checkpoints")

	-- local title = "Checkpoints - Teleporter"
	-- local message = "Avaible Places: "

	-- local window = ModalWindow(1001, title, message)
	-- window:addButton(100, "Select")
	-- window:addButton(101, "Cancel")
	-- window:setDefaultEnterButton(100)
	-- window:setDefaultEscapeButton(101)

	-- players[player:getId()] = {}

	-- local index = 0

	-- local house = player:getHouse()
	-- if house then
		-- index = index + 1
		-- local housePosition = house:getExitPosition()
		-- local pos = { housePosition.x, housePosition.y, housePosition.z }
		-- local values = { ["position"] = pos, ["name"] = "Home" }
		-- table.insert(players[player:getId()], values)
		-- window:addChoice(index, players[player:getId()][index]["name"])
	-- end

	-- for i = 1, #CHECKPOINTS_SYSTEM do
		-- if player:getStorageValue(CHECKPOINTS_SYSTEM.ActionID + i) > 0 then
			-- index = index + 1
			-- local pos = CHECKPOINTS_SYSTEM[i].position
			-- local name = CHECKPOINTS_SYSTEM[i].name
			-- local values = { ["position"] = pos, ["name"] = name }
			-- table.insert(players[player:getId()], values)
			-- window:addChoice(index, players[player:getId()][index]["name"])
		-- end
	-- end

	-- if index == 0 then
		-- player:sendCancelMessage("You didnt discoreved any checkpoint yet.")
		-- player:sendTextMessage(MESSAGE_STATUS_WARNING, "You didnt discoreved any checkpoint yet.")
		-- player:getPosition():sendMagicEffect(371)
		-- return
	-- end

	-- return window:sendToPlayer(player)
-- end

-- -- local talk = TalkAction("/teleportt", "!teleport")
-- -- function talk.onSay(player, words, param)
-- -- Checkpoints:setActionId()
-- -- Checkpoints:sendList(player)
-- -- return false
-- -- end
-- -- talk:separator(" ")
-- -- talk:register()

-- local action = Action()
-- function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	-- if not isInArray(Checkpoints:Check(player), item.uid) then
		-- player:sendTextMessage(MESSAGE_STATUS_WARNING, "this item cannot be used from ground.")
		-- return true
	-- end
	-- Checkpoints:sendList(player)
	-- return true
-- end

-- action:id(CHECKPOINTS_SYSTEM.ItemID)
-- action:register()

-- local moveevent = MoveEvent()
-- moveevent:type("stepin")
-- function moveevent.onStepIn(creature, item, position, fromPosition)

	-- local player = Player(creature)
	-- if not player or player:isInGhostMode() then
		-- return true
	-- end

	-- Checkpoints:add(player)
-- end

-- moveevent:aid(CHECKPOINTS_SYSTEM.ActionID)
-- moveevent:register()

-- local creaturescript = CreatureEvent("ModalWindow_checkpoints")
-- function creaturescript.onModalWindow(player, modalWindowId, buttonId, choiceId)

	-- player:unregisterEvent("ModalWindow_checkpoints")

	-- if buttonId == 101 then
		-- return false
	-- end

	-- local t = players[player:getId()][choiceId]
	-- local pos = Position(t.position[1], t.position[2], t.position[3])

	-- if player:getPosition() == pos then
		-- player:sendCancelMessage("You are already on this place.")
		-- Checkpoints:sendList(player)
		-- return true
	-- end

	-- if Checkpoints:getFight(player) then
		-- player:sendCancelMessage("You can't use teleporter while fighting.")
		-- return true
	-- end

	-- local times = 15
	-- local interval = 1000
	-- local delay = 0

	-- for i = 1, times do
		-- if i == 1 then
			-- delay = 0
		-- else
			-- delay = delay + interval
		-- end

		-- local teleportEvent = addEvent(function()
			-- local user = Player(player:getId())

			-- if not user then
				-- return false
			-- end

			-- Checkpoints:setBlockItemMove(player, true)

			-- if Checkpoints:getFight(user) then
				-- Checkpoints:setBlockItemMove(user, false)
				-- stopEvent(teleportEvent)
				-- return user:sendCancelMessage("You got into fight, so your teleportation powers have been lost.")
			-- end

			-- if user:getItemCount(CHECKPOINTS_SYSTEM.ItemID) < 1 then
				-- Checkpoints:setBlockItemMove(user, false)
				-- stopEvent(teleportEvent)
				-- return user:sendCancelMessage("You have lost magic item, so your teleportation powers have been lost.")
			-- end


			-- local colours = {
				-- TEXTCOLOR_BLUE,
				-- TEXTCOLOR_LIGHTGREEN,
				-- TEXTCOLOR_LIGHTBLUE,
				-- TEXTCOLOR_MAYABLUE,
				-- TEXTCOLOR_DARKRED,
				-- TEXTCOLOR_LIGHTGREY,
				-- TEXTCOLOR_SKYBLUE,
				-- TEXTCOLOR_PURPLE,
				-- TEXTCOLOR_ELECTRICPURPLE,
				-- TEXTCOLOR_RED,
				-- TEXTCOLOR_PASTELRED,
				-- TEXTCOLOR_ORANGE,
				-- TEXTCOLOR_YELLOW,
				-- TEXTCOLOR_WHITE_EXP
			-- }

			-- local color = math.random(1, #colours)

			-- Game.sendAnimatedText(times - i, user:getPosition(), colours[color])

			-- if i == times then
				-- user:getPosition():sendMagicEffect(194)
			-- else
				-- user:getPosition():sendMagicEffect(368)
				-- user:sendCancelMessage("You will be teleported in " .. times - i .. " seconds.")
			-- end

			-- if i == times then
				-- user:sendCancelMessage("You have been teleported.")
				-- user:teleportTo(pos)
				-- pos:sendMagicEffect(380)
				-- user:removeItem(CHECKPOINTS_SYSTEM.ItemID, 1)
				-- Checkpoints:setBlockItemMove(user, false)
				-- players[user:getId()] = {}
			-- end

		-- end, delay)

	-- end


	-- return true

-- end

-- creaturescript:register()
