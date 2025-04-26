local mainWindow = nil
local mainPanel = nil
local opcode = 112


local comboPanel1 = nil
local comboPanel2 = nil
local comboPanel3 = nil

local comboKillPanel1 = nil
local comboKillPanel2 = nil
local comboKillPanel3 = nil

local comboImage1 = nil
local comboImage2 = nil
local comboImage3 = nil




local descriptionLabel = nil

local dailyPanel = nil
local dailyProgressWidget = nil


local weeklyPanel = nil
local weeklyProgressWidget = nil

local dailyPercentage = 0
local weeklyPercentage = 0


local dailyChestPanel1 = nil
local dailyChestPanel2 = nil

local weeklyChestPanel1 = nil
local weeklyChestPanel2 = nil


local categoryPanel = nil
local dailyButton = nil
local weeklyButton = nil
local comboButton = nil


local mainButton = nil

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

function init()
	connect(g_game, {onGameEnd = terminate})
	ProtocolGame.registerExtendedOpcode(opcode, onReceiveRequest)
	mainWindow = g_ui.displayUI('dailyrewards')
	
	-- mainButton = modules.client_topmenu.addLeftButton('shopButton', tr('Shop'),
    -- '/images/topbuttons/logout', toggle, true)
	--mainButton = modules.client_topmenu.addLeftGameToggleButton('missionButton', tr('Arena Rewards'), '/images/topbuttons/logout', toggle)
	mainButton = modules.client_topmenu.addRightGameToggleButton('missionButton', tr('Arena Rewards'), '/images/topbuttons/shop', toggle, false, 8)
	
	mainWindow:setVisible(false)
	
	
	mainPanel = mainWindow:recursiveGetChildById('panel2')
	
	comboPanel1 = mainPanel:recursiveGetChildById('comboPanel1')
	comboPanel2 = mainPanel:recursiveGetChildById('comboPanel2')
	comboPanel3 = mainPanel:recursiveGetChildById('comboPanel3')

	comboKillPanel1 = comboPanel1:recursiveGetChildById('comboKill')
	comboKillPanel2 = comboPanel2:recursiveGetChildById('comboKill')
	comboKillPanel3 = comboPanel3:recursiveGetChildById('comboKill')
	
	comboImage1 = comboPanel1:recursiveGetChildById('chestImage')
	comboImage2 = comboPanel2:recursiveGetChildById('chestImage')
	comboImage3 = comboPanel3:recursiveGetChildById('chestImage')
	
	categoryPanel = mainWindow:recursiveGetChildById('categoryPanel')
	dailyButton = categoryPanel:recursiveGetChildById('dailyButton')
	weeklyButton = categoryPanel:recursiveGetChildById('weeklyButton')
	comboButton = categoryPanel:recursiveGetChildById('comboKillsButton')
	
	descriptionLabel = mainPanel:recursiveGetChildById('categoryDescription')
	
	dailyPanel = mainPanel:recursiveGetChildById('dailyPanel')
	dailyProgressWidget = dailyPanel:recursiveGetChildById('progressCount')
	weeklyPanel = mainPanel:recursiveGetChildById('weeklyPanel')
	weeklyProgressWidget = weeklyPanel:recursiveGetChildById('progressCount')
	
	
	dailyChestPanel1 = dailyPanel:recursiveGetChildById('dailyChestPanel1')
	dailyChestPanel2 = dailyPanel:recursiveGetChildById('dailyChestPanel2')
	
	dailyChestImage1 = dailyChestPanel1:recursiveGetChildById('chestImage')
	dailyChestImage2 = dailyChestPanel2:recursiveGetChildById('chestImage')
	
	weeklyChestPanel1 = weeklyPanel:recursiveGetChildById('weeklyChestPanel1')
	weeklyChestPanel2 = weeklyPanel:recursiveGetChildById('weeklyChestPanel2')
	
	weeklyChestImage1 = weeklyChestPanel1:recursiveGetChildById('chestImage')
	weeklyChestImage2 = weeklyChestPanel2:recursiveGetChildById('chestImage')
	
	
	
	
	
	updateImages()
	updateKills()
end

function updateKills()
	local title1 = comboKillPanel1:recursiveGetChildById('title')
	title1:setText("COMBO 4-5 KILLS")
	local title2 = comboKillPanel2:recursiveGetChildById('title')
	title2:setText("COMBO 6-7 KILLS")	
	local title3 = comboKillPanel3:recursiveGetChildById('title')
	title3:setText("COMBO 8-9 KILLS")	
end	
	
function askForWindow()
    local t = {}
	t.buffer = "displayWindow"
    sendRequest(json.encode(t))
end

function toggle()
	if mainWindow:isVisible() then
	    mainWindow:setVisible(false)
		mainButton:setEnabled(true)
	else
		mainButton:setEnabled(false)
		askForWindow()
	end
end

function terminate()
    mainWindow:setVisible(false)
	-- if mainWindow then
	    -- mainWindow:destroy()
	-- end
end

local dailyConfig = {
                        startValue = 13,
						endValue = 11,
						percentageValue = 15
					}
local weeklyConfig = {
                        startValue = 27,
						endValue = 10,
						percentageValue = 13
					 }					
				
function addProgressDaily()
    local progressBar = dailyPanel:recursiveGetChildById('progressBar')
	local fillBar = progressBar:recursiveGetChildById('fill')
	local currentBar = fillBar:getMarginRight()
	local value = dailyConfig.startValue
	if dailyPercentage > dailyConfig.percentageValue then
	    value = dailyConfig.endValue
	end
	fillBar:setMarginRight(currentBar - value)
	dailyPercentage = dailyPercentage + 1
end

function loadProgressDaily(count)
    local progressBar = dailyPanel:recursiveGetChildById('progressBar')
	local fillBar = progressBar:recursiveGetChildById('fill')
	fillBar:setMarginRight(435)
	local value = dailyConfig.startValue
	if count > 30 then
	    count = 30
	end
	dailyProgressWidget:setText(count .. "/" .. 30)
    for i = 1, count do
        local currentBar = fillBar:getMarginRight() 
        if i > dailyConfig.percentageValue then
	        value = dailyConfig.endValue
	    end
	    fillBar:setMarginRight(currentBar - value)
    end
	dailyPercentage = count
end

function addProgressWeekly()
    local progressBar = weeklyPanel:recursiveGetChildById('progressBar')
	local fillBar = progressBar:recursiveGetChildById('fill')
	local currentBar = fillBar:getMarginRight()
	local value = weeklyConfig.startValue
	if weeklyPercentage >= weeklyConfig.percentageValue then
	    value = weeklyConfig.endValue
	end
	if weeklyPercentage == 6 then
	    value = value + 5
	end
	fillBar:setMarginRight(currentBar - value)
	weeklyPercentage = weeklyPercentage + 1
end

function sendRequest(request)
	local protocolGame = g_game.getProtocolGame()
	if protocolGame then
	    protocolGame:sendExtendedOpcode(opcode, request)
    end
	return true
end

function sendClaimChestRequest(type, id, name)
    local t = {}
	t.buffer = "sendClaimChest"
	t.type = type
	t.id = id
	t.name = name
    sendRequest(json.encode(t))
	return true
end

local openChestsTable = {
                            ["Bronze Chest"] = "/images/newUI/chests/Bronze-Chest-open",
							["Wooden Chest"] = "/images/newUI/chests/Wooden-Chest-open",
							["Artifact Chest"] = "/images/newUI/chests/Chest-Artifact-open"
					    }

-- function getCategoryButtonById(id)
    
	
	
	
	

local unclaimedChests = {}


function updateChestBackground(type, id, status, name, requiredProgress, currentProgress)
    print("Type: " .. type .. ", Status: " .. status .. ", ID: " .. id)
    -- if status ~= 1 then
	    -- return
	-- end
	
	if currentProgress < requiredProgress then
	    return
	end
	
	local panel = nil
	local imageWidget = nil
	
	local button = nil
	if type == "Daily" then
	    button = dailyButton
	    if id == 1 then
		    panel = dailyChestPanel1
			imageWidget = dailyChestImage1
			
		elseif id == 2 then
		    panel = dailyChestPanel2
			imageWidget = dailyChestImage2
		end
	elseif type == "Weekly" then
	    button = weeklyButton
	    if id == 1 then
		    panel = weeklyChestPanel1
			imageWidget = weeklyChestImage1
		elseif id == 2 then
		    panel = weeklyChestPanel2
			imageWidget = weeklyChestImage2
		end	    
	end
	
	if status == 2 then
	    imageWidget:setImageSource(openChestsTable[name])
	end
	
	if status == 1 then
	    local redDot = button:recursiveGetChildById('redDot')
		redDot:setVisible(true)
	    panel:setBackgroundColor("#f7c643d9")
        panel.onClick = function()
        if currentProgress < requiredProgress then
	        return
	    end
        panel:setBackgroundColor("#90a969d9")
		imageWidget:setImageSource(openChestsTable[name])
		sendClaimChestRequest(type, id, name)
		unclaimedChests[type][id] = nil
		if #unclaimedChests[type] == 0 then
		    local redDot = button:recursiveGetChildById('redDot')
		    redDot:setVisible(false)
		end
		--sendOpenChest(chestType, id)
        end		
	end
	

end

function updateChestCombo(type, id, status, name, requiredCombo, currentCombo)
    -- if status == 0 then
	    -- --button:setChecked(false)
	    -- return
	-- end
	
	status = 0
	
	local panel = nil
	local image = nil
	if id == 1 then
	    panel = comboPanel1
		image = comboImage1
	elseif id == 2 then
	    panel = comboPanel2
		image = comboImage2
	elseif id == 3 then
	    panel = comboPanel3
		image = comboImage3
	end
	local buttonCategory = comboButton
	local button = panel:recursiveGetChildById('claimCombo')
	
	if currentCombo > 0 and status < 2 then
	    button:setText('(' .. currentCombo .. ')' .. " " .. "CLAIM")
		
	end
	if status == 2 then
		button:setText("CLAIMED")
	    image:setImageSource(openChestsTable[name])
		button:setImageSource("/images/ui/disabled button")
		button:setChecked(false)
		button:setEnabled(false)
		--button:setEnabled(false)
		--updateButton(button, false)
	--elseif status == 1 then
	elseif currentCombo > 0 then
		button:setChecked(true)
		button:setText("CLAIM")
		button:setImageSource("/images/ui/claim button")
		button:setEnabled(true)
		
		local redDot = buttonCategory:recursiveGetChildById('redDot')
		redDot:setVisible(true)		
		button.onClick = function()
            if currentCombo < requiredCombo then
	            return
	        end
		    button:setText("CLAIMED")
			button:setEnabled(false)
		    image:setImageSource(openChestsTable[name])
		    sendClaimChestRequest(type, id, name)
			unclaimedChests[type][id] = nil
			if #unclaimedChests[type] == 0 then
			    local redDot = buttonCategory:recursiveGetChildById('redDot')
		        redDot:setVisible(false)	
			end
		end
    end
end
	--if status == 1 then
	    
	
	


function loadProgressWeekly(count)
    local progressBar = weeklyPanel:recursiveGetChildById('progressBar')
	local fillBar = progressBar:recursiveGetChildById('fill')
	fillBar:setMarginRight(435)
	local value = weeklyConfig.startValue
	if count > 14 then
	    count = 14
	end
	weeklyProgressWidget:setText(count .. "/" .. 14)
    for i = 1, count do
        local currentBar = fillBar:getMarginRight() 
        if i > weeklyConfig.percentageValue then
	        value = weeklyConfig.endValue
	    end
		if i == 6 then
			value = value + 2
		end		
	    fillBar:setMarginRight(currentBar - value)
    end
	weeklyPercentage = count
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function updateImages()
    comboImage1:setImageSource("/images/newUI/chest_wooden")
	comboImage2:setImageSource("/images/newUI/chest_bronze")
	comboImage3:setImageSource("/images/newUI/chest_artifact")
end
	
function displayCombo(bool)
    if bool then 
	   descriptionLabel:setText("PERFORM A COMBO KILL IN SURVIVAL MODE AND EARN INCREDIBLE PRIZES")
	end
	comboPanel1:setVisible(bool)
	comboPanel2:setVisible(bool)
	comboPanel3:setVisible(bool)
end

function displayDaily(bool)
    if bool then
       descriptionLabel:setText("PLAY RIVALS OR SURVIVAL TO OBTAIN DAILY REWARDS!")
	end
	dailyPanel:setVisible(bool)
end

function displayWeekly(bool)
    if bool then
       descriptionLabel:setText("COMPLETE THE DAILY QUESTS TO ACQUIRE THE WEEKLY REWARDS!")
	end
	weeklyPanel:setVisible(bool)
end

local focusedButton = nil
function displayCategory(self, id)
    if not id then
       id = self:getId()
	end
	
	if self then
	    if focusedButton then
		    focusedButton:setChecked(false)
	    end
	
	    focusedButton = self
	    focusedButton:setChecked(true)
	end
	
    if id == "comboKillsButton" then
		displayDaily(false)
		displayWeekly(false)
	    displayCombo(true)	
		return true
	end
	if id == "dailyButton" then
	    displayCombo(false)
		displayWeekly(false)
		displayDaily(true)
	    return true
	end
	if id == "weeklyButton" then
	    displayCombo(false)
		displayDaily(false)
		displayWeekly(true)
	    return true
	end

end

function updateProgress(t)
    local dailyProgress = t["Daily"]
	local weeklyProgress = t["Weekly"]
	loadProgressDaily(dailyProgress)
	loadProgressWeekly(weeklyProgress)
end
	
function onReceiveRequest(self, opcode, buffer)
    local t = json.decode(buffer)
	if t.buffer == "send_Informations" then
		updateProgress(t.data["Progress"])
		displayCategory(nil, "dailyButton")
		--print(dump(t.data["Combo"]))
        for i, v in pairs(t.data["Chests"]) do
            --print("I:" .. i)
		    for z, b in pairs(v) do
			    if b.claimed == 1 then
                    if not unclaimedChests[i] then
					    unclaimedChests[i] = {}
					end
					unclaimedChests[i][z] = true
				end
			    --print("Z: " .. z)
			    if b.requiredProgress then
				    local currentProgress = t.data["Progress"][i]
				    updateChestBackground(i, z, b.claimed, b.name, b.requiredProgress, currentProgress)
				end
				if b.requiredCombo then
				    
				    local currentCombo = t.data["Combo"][z]
					--print("Current Combo: " .. currentCombo)
				    updateChestCombo(i, z, b.claimed, b.name, b.requiredCombo, currentCombo)
				end
			end
		end
		if not mainWindow:isVisible() then
		   mainWindow:setVisible(true)
		end
	end
end

	