-- CREATE TABLE `players_special_attributes` (
    -- `id` int(11) NOT NULL AUTO_INCREMENT,
    -- `name` varchar(32) NOT NULL,
	-- `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin CHECK (json_valid(`data`)),
  -- PRIMARY KEY (id)
-- )
-- ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

if not KING_NPC_SYSTEM then
    KING_NPC_SYSTEM = {}
	KING_NPC_SYSTEM.customers = {}
	KING_NPC_SYSTEM.players = {}
end

KING_NPC_SYSTEM.config = {
                            ["Attributes"] = {
							                    ["Stats"] = {
												                [1] = { name = "Health", value = 0.01 },
																[2] = { name = "Mana", value = 0.01 }
														    },
												["Leeching"] = {
												                 [1] = { name = "Life Leech", value = 0.1 },
																 [2] = { name = "Mana Leech", value = 0.1 },
															   },
												["Resistance"] = {
												                    [1] = { name = "Physical Defense", value = 0.025 },
																	[2] = { name = "Energy Defense", value = 0.025 },
																	[3] = { name = "Earth Defense", value = 0.025 },
																	[4] = { name = "Fire Defense", value = 0.025 },
																	[5] = { name = "Ice Defense", value = 0.025 },
																	[6] = { name = "Death Defense", value = 0.025 },
																 },
												["Damage"] = {
												                    [1] = { name = "Physical Damage", value = 0.1 },
																	[2] = { name = "Energy Damage", value = 0.1 },
																	[3] = { name = "Earth Damage", value = 0.1 },
																	[4] = { name = "Fire Damage", value = 0.1 },
																	[5] = { name = "Ice Damage", value = 0.1 },
																	[6] = { name = "Death Damage", value = 0.1 },
															 },																 
											},
							["Shop"] = {
							              [1] = { type = "outfit scroll", name = "Summoner", addon = 1, required_coins = 100 },
			                              [2] = { type = "mount scroll", name = "Scorpion King", required_coins = 100 },
						                  [3] = { type = "item", id = 3079, count = 1, required_coins= 200 },
							           }
							             
						 }

KING_NPC_SYSTEM.removerID = 3366

KING_NPC_SYSTEM.maxAttributes = 10

KING_NPC_SYSTEM.ModalWindows = {
                                 ["Stats"] = 600,
								 ["Leeching"] = 601,
								 ["Resistance"] = 602,
								 ["Damage"] = 603,
								 ["Remover 1"] = 604,
								 ["Remover 2"] = 605,
							   }


KING_NPC_SYSTEM.attributeCost = 10

KING_NPC_SYSTEM.SubID = {
                           ["Health"] = 50,							   
                           ["Mana"] = 51,
						   ["Life Leech"] = 52,
						   ["Mana Leech"] = 53,
						   ["Physical Defense"] = 54,
						   ["Energy Defense"] = 55,
						   ["Eearth Defense"] = 56,
						   ["Fire Defense"] = 57,
						   ["Ice Defense"] = 58,
						   ["Death Defense"] = 59,
						   ["Physical Damage"] = 60,
						   ["Energy Damage"] = 61,
						   ["Eearth Damage"] = 62,
						   ["Fire Damage"] = 63,
						   ["Ice Damage"] = 64,
						   ["Death Damage"] = 65,						   
						}
						
KING_NPC_SYSTEM.Params = {
                            ["Health"] = CONDITION_PARAM_STAT_MAXHITPOINTSPERCENT,
							["Mana"] = CONDITION_PARAM_STAT_MAXMANAPOINTSPERCENT,
							["Life Leech"] = CONDITION_PARAM_SKILL_LIFE_LEECH_CUSTOM,
							["Mana Leech"] = CONDITION_PARAM_SKILL_MANA_LEECH_CUSTOM,
                            ["Physical Defense"] = CONDITION_PARAM_BUFF_PHYSICAL_DEFENSE,
							["Energy Defense"] = CONDITION_PARAM_BUFF_ENERGY_DEFENSE,
							["Eearth Defense"] = CONDITION_PARAM_BUFF_EARTH_DEFENSE,
							["Fire Defense"] = CONDITION_PARAM_BUFF_FIRE_DEFENSE,
							["Ice Defense"] = CONDITION_PARAM_BUFF_ICE_DEFENSE,
							["Death Defense"] = CONDITION_PARAM_BUFF_DEATH_DEFENSE,
                            ["Physical Damage"] = CONDITION_PARAM_BUFF_PHYSICAL_DAMAGE,
							["Energy Damage"] = CONDITION_PARAM_BUFF_ENERGY_DAMAGE,
							["Eearth Damage"] = CONDITION_PARAM_BUFF_EARTH_DAMAGE,
							["Fire Damage"] = CONDITION_PARAM_BUFF_FIRE_DAMAGE,
							["Ice Damage"] = CONDITION_PARAM_BUFF_ICE_DAMAGE,
							["Death Damage"] = CONDITION_PARAM_BUFF_DEATH_DAMAGE							
                         }							
		
KING_NPC_SYSTEM.sql = "players_special_attributes"



function KING_NPC_SYSTEM:getCacheConfig()
    if self.cacheConfig then
	    return self.cacheConfig
	end
	self.cacheConfig = {}
	self.cacheConfig[1] = KING_NPC_SYSTEM.config["Attributes"]["Stats"]
	self.cacheConfig[1].name = "Stats"
	self.cacheConfig[2] = KING_NPC_SYSTEM.config["Attributes"]["Leeching"]
	self.cacheConfig[2].name = "Leeching"	
	self.cacheConfig[3] = KING_NPC_SYSTEM.config["Attributes"]["Resistance"]
	self.cacheConfig[3].name = "Resistance"	
	self.cacheConfig[4] = KING_NPC_SYSTEM.config["Attributes"]["Damage"]
	self.cacheConfig[4].name = "Damage"	
    return self.cacheConfig
end

function KING_NPC_SYSTEM:getAvaibleGroups()
    if self.avaibleGroups then
	    return self.avaibleGroups
	end
	self.avaibleGroups = ""
	for i, v in ipairs(self:getCacheConfig()) do
	    if i > 1 then
		    self.avaibleGroups = self.avaibleGroups .. ", "
		end
		self.avaibleGroups = self.avaibleGroups .. "{" .. v.name .. "}"
	end
	self.avaibleGroups = self.avaibleGroups .. "."
	return self.avaibleGroups
end

function KING_NPC_SYSTEM:sendWindowByName(player, name)
    for i, v in pairs(self:getCacheConfig()) do
	    if string.find(v.name:lower(), name:lower()) then
		    KING_NPC_SYSTEM:sendModalWindow(player, v.name)
			return true
		end
	end
end
	
function KING_NPC_SYSTEM:sendRemoverWindow1(player)
	local id = KING_NPC_SYSTEM.ModalWindows["Remover 1"]
	local title = "Special Attributes"
    --local message = self:getActiveBonusesString(player)
	local message = ""
	message = message .. "Select Group Attribute"
	
	local window = ModalWindow(id, title, message)
	-- local t = self.config["Attributes"]
	
	local t = KING_NPC_SYSTEM:getCacheConfig()
	for i, v in ipairs(t) do
	    window:addChoice(i, v.name)
	end
	
	
	-- for i, v in ipairs(t) do
	    -- window:addChoice(i, "" .. v.name .. " +" .. v.value * 100 .. "%" .. "")
	-- end
	
	
	window:addButton(100, "Select") 
    window:addButton(101, "Cancel")     
    window:setDefaultEnterButton(100)
    window:setDefaultEscapeButton(101)
	player:registerEvent('KING_NPC_SYSTEM_onModalWindow_Remover1')
    return window:sendToPlayer(player)
end

function KING_NPC_SYSTEM:sendRemoverWindow2(player, t)
	local id = KING_NPC_SYSTEM.ModalWindows["Remover 2"]
	local title = "Special Attributes"
	local message = ""
	message = message .. "Select Attribute"
	
	local window = ModalWindow(id, title, message)
    

	
	for i, v in ipairs(t) do
	    window:addChoice(i, v.name)
	end
	-- local t = KING_NPC_SYSTEM:getCacheConfig()
	-- for i, v in ipairs(t) do
	    -- window:addChoice(i, v.name)
	-- end
	
	
	-- for i, v in ipairs(t) do
	    -- window:addChoice(i, "" .. v.name .. " +" .. v.value * 100 .. "%" .. "")
	-- end
	
	
	window:addButton(100, "Select") 
    window:addButton(101, "Cancel")     
    window:setDefaultEnterButton(100)
    window:setDefaultEscapeButton(101)
	player:registerEvent('KING_NPC_SYSTEM_onModalWindow_Remover2')
	
	if not KING_NPC_SYSTEM.playersModal then
	    KING_NPC_SYSTEM.playersModal = {}
	end
	KING_NPC_SYSTEM.playersModal[player:getName()] = t
	
    return window:sendToPlayer(player)
end

function KING_NPC_SYSTEM:getActiveAttributes(player)
	local id = 12341
	local isFirst = true
	local title = "Special Attributes"
	local message = "You dont have any active attribute."
	
	local name = player:getName()
	if not name then
	    return false
	end
	local playerTable = self.players[name]
	if playerTable then
	    local attributesTable = self.players[name]["Attributes"]
	    if attributesTable then
	        for group, attributeTable in pairs(attributesTable) do
	            for i, v in pairs(attributeTable) do
		            if isFirst then
			            message = "Active Attributes:"
                        message = message .. "\n"						
         				isFirst = false
                    end
                    if v > 0 then
                        message = message .. "\n"
                        message = message .. "-------------------------"
						message = message .. "\n"
                        message = message .. i .. ": " .. v .. "%"						
			        end
		        end
	        end
	    end
	end
	
	if not isFirst then
	   message = message .. "\n"
	   message = message .. "-------------------------"
	end
	
	local window = ModalWindow(id, title, message)
    window:addButton(101, "Cancel")     
    window:setDefaultEnterButton(100)
    window:setDefaultEscapeButton(101)
	return window:sendToPlayer(player)
end


local action = TalkAction("!attributes", "/attributes")
function action .onSay(player, words, param)	
	KING_NPC_SYSTEM:getActiveAttributes(player)
end
action :register()



local creaturescript = CreatureEvent("KING_NPC_SYSTEM_onModalWindow_Remover1")
function creaturescript.onModalWindow(player, modalWindowId, buttonId, choiceId) 
	if modalWindowId ~= KING_NPC_SYSTEM.ModalWindows["Remover 1"] then
		return false
	end
	if buttonId == 101 then
	    return false
	end
	local index = choiceId
	local t = KING_NPC_SYSTEM:getCacheConfig()
	local attrTable = t[index]
	KING_NPC_SYSTEM:sendRemoverWindow2(player, attrTable)
	return true
end
creaturescript:register()

local creaturescript = CreatureEvent("KING_NPC_SYSTEM_onModalWindow_Remover2")
function creaturescript.onModalWindow(player, modalWindowId, buttonId, choiceId) 
	if modalWindowId ~= KING_NPC_SYSTEM.ModalWindows["Remover 2"] then
		return false
	end
	
	if buttonId == 101 then
	    return false
	end
	
    if KING_NPC_SYSTEM:getAttributesCount(player) < 1 then
	    player:popupFYI("You dont have this attribute.")
		return false
	end
	
	if player:getItemCount(KING_NPC_SYSTEM.removerID) < 1 then
	    player:popupFYI("You dont have restarter item.")
		return false
	end

	local index = choiceId
	local players = KING_NPC_SYSTEM.playersModal
	if not players then
	    return false
	end
	
	local playerTable = KING_NPC_SYSTEM.playersModal[player:getName()]
	if not playerTable then
	    player:popupFYI("You dont have this attribute.")
	    return false
	end
	
	local group = playerTable.name
	local t = playerTable[choiceId]
	if not t then
	    player:popupFYI("You dont have this attribute.")
	    return false
	end
	local attributeName = t.name
	
	if not KING_NPC_SYSTEM:removeAtribute(player, group, index, value) then
	    player:popupFYI("You dont have this attribute.")
		return false
	end
	local subid = KING_NPC_SYSTEM.SubID[attributeName]
	KING_NPC_SYSTEM:removeCondition(player, subid)
	
	
	player:sendTextMessage(MESSAGE_INFO_DESCR, "You have sucessfully removed " .. attributeName:lower() .. " attribute.")
	player:removeItem(KING_NPC_SYSTEM.removerID, 1)
	player:setTournamentCoinsBalance(player:getTournamentCoinsBalance() + KING_NPC_SYSTEM.attributeCost)
	return true
end
creaturescript:register()

function KING_NPC_SYSTEM:sendModalWindow(player, group)
	local id = self.ModalWindows[group]
	local title = "Special Attributes"
	
    local message = "Each attribute cost " .. self.attributeCost .. " tournaments coins."
	message = message .. "\n"
	message = message .. "\n"
	message = message .. "-------------------"
	message = message .. "\n"
	message = message .. "Select Attributes:"
	
	local window = ModalWindow(id, title, message)
	local t = self.config["Attributes"][group]
	for i, v in ipairs(t) do
	    window:addChoice(i, "" .. v.name .. " +" .. v.value .. "%")
	end
	window:addButton(100, "Select") 
    window:addButton(101, "Cancel")     
    window:setDefaultEnterButton(100)
    window:setDefaultEscapeButton(101)
	player:registerEvent('KING_NPC_SYSTEM_onModalWindow' .. "_" .. group)
    return window:sendToPlayer(player)
end

local creaturescript = CreatureEvent("KING_NPC_SYSTEM_onModalWindow_Stats")
function creaturescript.onModalWindow(player, modalWindowId, buttonId, choiceId) 
	if modalWindowId ~= KING_NPC_SYSTEM.ModalWindows["Stats"] then
		return false
	end
	if buttonId == 101 then
	    return false
	end
	local index = choiceId
	local t = KING_NPC_SYSTEM.config["Attributes"]["Stats"][index]
	local value = t.value
	KING_NPC_SYSTEM:addAtribute(player, "Stats", index, value)
	KING_NPC_SYSTEM:updateAttribute(player, "Stats", t.name)
	player:sendTextMessage(MESSAGE_INFO_DESCR, "You have got " .. "+" .. value * 100 .. "% " .. t.name:lower() .. " special attribute.")  
	return true
end
creaturescript:register()

local creaturescript = CreatureEvent("KING_NPC_SYSTEM_onModalWindow_Leeching")
function creaturescript.onModalWindow(player, modalWindowId, buttonId, choiceId) 
	if not modalWindowId ~= KING_NPC_SYSTEM.ModalWindows["Leeching"] then
		return false
	end
	if buttonId == 101 then
	    return false
	end
	local index = choiceId
	local t = KING_NPC_SYSTEM.config["Attributes"]["Leeching"][index]
	local value = t.value
	KING_NPC_SYSTEM:addAtribute(player, "Leeching", index, value)
	KING_NPC_SYSTEM:updateAttribute(player, "Leeching", t.name)
	player:sendTextMessage(MESSAGE_INFO_DESCR, "You have got " .. "+" .. value * 100 .. "% " .. t.name:lower() .. " special attribute.")  
	return true
end
creaturescript:register()

local creaturescript = CreatureEvent("KING_NPC_SYSTEM_onModalWindow_Resistance")
function creaturescript.onModalWindow(player, modalWindowId, buttonId, choiceId) 
	if modalWindowId ~= KING_NPC_SYSTEM.ModalWindows["Resistance"] then
		return false
	end
	if buttonId == 101 then
	    return false
	end
	local index = choiceId
	local t = KING_NPC_SYSTEM.config["Attributes"]["Resistance"][index]
	local value = t.value
	KING_NPC_SYSTEM:addAtribute(player, "Resistance", index, value)
	KING_NPC_SYSTEM:updateAttribute(player, "Resistance", t.name)
	player:sendTextMessage(MESSAGE_INFO_DESCR, "You have got " .. "+" .. value * 100 .. "% " .. t.name:lower() .. " special attribute.")  
	return true
end
creaturescript:register()

local creaturescript = CreatureEvent("KING_NPC_SYSTEM_onModalWindow_Damage")
function creaturescript.onModalWindow(player, modalWindowId, buttonId, choiceId) 
	if modalWindowId ~= KING_NPC_SYSTEM.ModalWindows["Damage"] then
		return false
	end
	if buttonId == 101 then
	    return false
	end
	local cost = KING_NPC_SYSTEM.attributeCost
	--player:setTournamentCoinsBalance(player:getTournamentCoinsBalance() + rewardTable.value)
	if player:getTournamentCoinsBalance() < cost then
	    player:popupFYI("You dont have enough tournament coins.")
		return false
	end
	
	player:setTournamentCoinsBalance(player:getTournamentCoinsBalance() - cost)
	
	local index = choiceId
	local t = KING_NPC_SYSTEM.config["Attributes"]["Damage"][index]
	local value = t.value
	KING_NPC_SYSTEM:addAtribute(player, "Damage", index, value)
	KING_NPC_SYSTEM:updateAttribute(player, "Damage", t.name)
	player:sendTextMessage(MESSAGE_INFO_DESCR, "You have got " .. "+" .. value * 100 .. "% " .. t.name:lower() .. " special attribute.")  
	return true
end
creaturescript:register()

creaturescript = CreatureEvent("KING_NPC_SYSTEM_onLogin")
function creaturescript.onLogin(player)
    KING_NPC_SYSTEM:updateAttributes(player)
	return true
end
creaturescript:register()

function KING_NPC_SYSTEM:getAttribute(player, group, attribute)
    local name = player:getName()
	if not self.players[name] then
	    return 0
	end
	if not self.players[name]["Attributes"] then
	    return 0
	end
	if not self.players[name]["Attributes"][group] then
	    return 0
	end
	
	local value = self.players[name]["Attributes"][group][attribute]
	if not value then
	    return 0
	end
	return value
end

function KING_NPC_SYSTEM:getAttributesCount(player)
    local name = player:getName()
	if not self.players[name] then
	    return 0
	end
	
	local count = self.players[name].attributeCount
	if not count then
	    return 0
	end
	return count
end
	  
function KING_NPC_SYSTEM:updateAttribute(player, group, attribute)
	local value = KING_NPC_SYSTEM:getAttribute(player, group, attribute)
	if value == 0 then
	    return false
	end
	value = value * 100
	if value < 1 then
	    return false
	end
	
	local subid = self.SubID[attribute]
	local param = self.Params[attribute]
	
	local condition = Condition(CONDITION_ATTRIBUTES, CONDITIONID_DEFAULT)
	condition:setParameter(CONDITION_PARAM_SUBID, subid)
	if attribute == "Mana" or attribute == "Health" then
	   condition:setParameter(param, 100 + value)
	else
	   condition:setParameter(param, value) 
	end
	condition:setParameter(CONDITION_PARAM_TICKS, -1)
	player:addCondition(condition)
end

function KING_NPC_SYSTEM:updateAttributes(player)
    local name = player:getName()
	if not name then
	    return false
	end
	local playerTable = self.players[name]
	if not playerTable then
	    return false
	end
	
	local attributesTable = self.players[name]["Attributes"]
	if not attributesTable then
	    return false
	end
	
	for group, attributeTable in pairs(attributesTable) do
	    for i, v in pairs(attributeTable) do
			KING_NPC_SYSTEM:updateAttribute(player, group, i)
		end
	end
end
	
function KING_NPC_SYSTEM:addAtribute(player, group, index, value)
    local name = player:getName()
	local attributesTable = self.config["Attributes"]
	local groupTable = attributesTable[group]
	local t = groupTable[index]
	if not self.players[name] then
	    self.players[name] = {}
	end
	if not self.players[name].attributeCount then
	    self.players[name].attributeCount = 0
	end
	self.players[name].attributeCount = self.players[name].attributeCount + 1
	
	
    if not self.players[name]["Attributes"] then
	    self.players[name]["Attributes"] = {}
	end

	if not self.players[name]["Attributes"][group] then
	    self.players[name]["Attributes"][group] = {}
	end
	
	local attributeName = t.name
	if not self.players[name]["Attributes"][group][attributeName] then
	    self.players[name]["Attributes"][group][attributeName] = 0
	end
	
	self.players[name]["Attributes"][group][attributeName] = self.players[name]["Attributes"][group][attributeName] + value
	self:savePlayer(player)
end

function KING_NPC_SYSTEM:removeAtribute(player, group, index, value)
    local name = player:getName()
	local attributesTable = self.config["Attributes"]
	local groupTable = attributesTable[group]
	local t = groupTable[index]
	if not self.players[name] then
	    return false
	end
	if not self.players[name].attributeCount then
	    return false
	end
		
    if not self.players[name]["Attributes"] then
	    return false
	end

	if not self.players[name]["Attributes"][group] then
	    return false
	end
	
	local attributeName = t.name
	if not self.players[name]["Attributes"][group][attributeName] then
	    return false
	end
	
	self.players[name]["Attributes"][group][attributeName] = nil
	self.players[name].attributeCount = self.players[name].attributeCount - 1
	self:savePlayer(player)
	return true
end

function KING_NPC_SYSTEM:fetchDatabase()
    if not self.players then
	    self.players = {}
	end
	local resultQuery = db.storeQuery("SELECT `name`, `data` FROM " .. self.sql)
	if resultQuery ~= false then
	    repeat
            local name = result.getDataString(resultQuery, "name")
		    local data = result.getDataString(resultQuery, "data")
		    if data then
		        data = json.decode(data)
		    end
			self.players[name] = data
        until not result.next(resultQuery)	
	end
end
	
function KING_NPC_SYSTEM:savePlayer(player)
    local name = player:getName()
	local data = self.players[name]
	data = json.encode(data)
	local resultQuery = db.storeQuery("SELECT `data` FROM " .. self.sql .. " WHERE `name` = " .. db.escapeString(name))
	local sql = nil
	if resultQuery then
	    sql = "UPDATE " .. self.sql .. " SET"
	    sql = sql .. " `data` = " .. db.escapeString(data)
	    sql = sql .. " WHERE " .. "`name` = " .. db.escapeString(name)
        db.query(sql)
	    result.free(resultQuery)
	    return true
	end
	sql = "INSERT INTO " .. self.sql .. " (`name`, `data`)"
    sql = sql .. " VALUES " 
    sql = sql .. "("
    sql = sql .. db.escapeString(name)
	sql = sql .. ", "
	sql = sql .. db.escapeString(data)
	sql = sql .. ")"
	return db.query(sql)
end	

function KING_NPC_SYSTEM:removeCondition(player, subid)
	if player:getCondition(CONDITION_ATTRIBUTES, CONDITIONID_DEFAULT, subid) then
	    player:removeCondition(CONDITION_ATTRIBUTE, subid)
	end
	return true
end
	
local globalevent = GlobalEvent("KING_NPC_SYSTEM_onStartUp")
function globalevent.onStartup()
	KING_NPC_SYSTEM:fetchDatabase()
	return true
end
globalevent:register()

local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)	
    KING_NPC_SYSTEM:sendRemoverWindow1(player)
    return true
end
action:id(KING_NPC_SYSTEM.removerID)
action:register()