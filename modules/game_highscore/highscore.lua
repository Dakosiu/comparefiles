highscoreButton = nil
window = nil
seasonEndTextList = nil
seasonEndLabel = nil
seasonTitleTextList = nil
seasonTitleLabel = nil
HIGHSCORE_OPCODE = 151
local refreshMemoryTime = 60

function init()
	highscoreButton = modules.client_topmenu.addLeftGameButton('highscoreButton', tr('highscore'), '/images/topbuttons/highscore', toggle, false, 8)
	
	g_ui.importStyle('highscorewindow')

	window = g_ui.createWidget('HighscoreWindowRanking', rootWidget)
	window:hide()
	windowResult = g_ui.createWidget('HighscoreWindow', rootWidget)
	windowResult:hide()
	
	seasonEndTextList = window:recursiveGetChildById('SeasonSchedulerTextList')
	seasonEndLabel = seasonEndTextList:recursiveGetChildById('SeasonEndLabel')
	seasonTitleTextList = window:recursiveGetChildById('TitleTextList')
	seasonTitleLabel = seasonTitleTextList:recursiveGetChildById('seasonTitleLabel')
	
	  connect(g_game, { 
		onGameEnd = offline 
	  })
    ProtocolGame.registerExtendedOpcode(HIGHSCORE_OPCODE, onHighscoreJSONOpcode)
	
end

function terminate()
  if highscoreButton then
    highscoreButton:destroy()
  end
  disconnect(g_game, { 
    onGameEnd = offline 
  })
    ProtocolGame.unregisterExtendedOpcode(HIGHSCORE_OPCODE, onHighscoreJSONOpcode)
end

highscoreInfo = {}
highscoreRefresh = 0

local parsingTables = {}

function printTable(t, indent)
    indent = indent or 0
    for key, value in pairs(t) do
        if type(value) == "table" then
            print(string.rep("  ", indent) .. key .. " = {")
            printTable(value, indent + 1)
            print(string.rep("  ", indent) .. "}")
        else
            print(string.rep("  ", indent) .. key .. " = " .. tostring(value))
        end
    end
end

function onHighscoreJSONOpcode(protocol, code, json_data_convert)
	-- print("----------------------")
	-- print("----------------------")
	-- print("----------------------")
	-- print("onHighscoreJSONOpcode") 
    local json_data = json.decode(json_data_convert)
	printTable(json_data)
    local action = json_data['action']
    local data = json_data['data']
    if not action or not data or not data['opcodeData'] then return false end	
	
	
	
	
	
	local getData
	if data['opcodeDataFirst'] and data['opcodeDataFirst'] == "true" then
		if not parsingTables[code] then parsingTables[code] = {} end
		parsingTables[code][action] = {data={},collect=""}
	end
	parsingTables[code][action].collect = parsingTables[code][action].collect ..""..data['opcodeData']
	if data['opcodeDataLast'] and data['opcodeDataLast'] == "true" then
		getData = json.decode(parsingTables[code][action].collect)
	end
	
if not getData then return end	
    if action == 'refreshHighscore' then
	    seasonEndLabel:setText(getData["time_end"])
		seasonTitleLabel:setText(getData["title"])
		for i, v in pairs(getData['info']) do
		    local t = {}
			--print("Name: " .. v.name)
			for b, z in pairs(v.info) do
			    local points = v.points
				if not points then
				    points = v.value
				end
				z.points = points
			    table.insert(t, z)
			end
			table.sort(t, function(a, b) return a.value > b.value end)
			
			
			v.info = t
			
		end		
        highscoreInfo = getData['info']
        highscoreRefresh = getData['refresh']
		show()
	elseif action == 'messageBox' then
		sendMessageBox(getData.title, getData.message)
	elseif action == 'eventResult' then
		showEventResult(getData['rewards'],getData['result'],getData['members'])
	end
end

function toggle()
  local widget = modules.game_interface.getNewUI():recursiveGetChildById('highscore')
  if window:isVisible() then
    hideWindow()
	widget:setOn(false)
  else
	if os.time() - highscoreRefresh > refreshMemoryTime then
		sendAction(HIGHSCORE_OPCODE, "openHighscore", {})
	else
		show()
	end
	widget:setOn(true)
  end
end
subList = nil
function hideList()
	if not subList then return end
	local hide = true
	for iPos,childPos in pairs(rootWidget:recursiveGetChildrenByPos(g_window.getMousePosition())) do
		if string.find(childPos:getId(), "subListCategory") then 
			hide = false
		end
	end
	if hide then
		subList:destroy()
		subList = nil
	else
		scheduleEvent(hideList,100)
	end
end
function offline()
	hideWindow()
	hideResultWindow()
end
function refreshHighscoreCategory()
	if not highscoreInfo then return end
		local caregoryPanel = window:recursiveGetChildById('buttonCreate')
		
		local windowSize = 0
		caregoryPanel:destroyChildren()
		for i,child in pairs(highscoreInfo) do	
			local button = g_ui.createWidget('categoryButton', caregoryPanel)
			button:setText(child.name)
			local getIcon = child.icon or child.name
			button:setIcon("icons/"..getIcon)
			button:setId("subListCategory")
			button.marginGet = windowSize
			local getButtonSize = button:getTextSize().width + 35
			windowSize = windowSize + getButtonSize + 25
			button:setWidth(getButtonSize)
			if child.disable then
				button:setEnabled(false)
			end
			if child.subCategory then
				button.onClick = function ()
				if subList then
					subList:destroy()
					subList = nil
				end
				subList = g_ui.createWidget('subCategoryList', window)
					subList:addAnchor(AnchorTop, 'buttonCreate', AnchorBottom)
					subList:addAnchor(AnchorLeft, 'buttonCreate', AnchorLeft)
					subList:setWidth(100)
					subList:setId("subListCategory")
					hideList()
				local subHeight = 0
				local subWidth = 0
				for _i,_child in pairs(child.subCategory) do
				subHeight = subHeight + 16
					local subListCategory = g_ui.createWidget('subListCategory', subList)
						subListCategory:setId("subListCategory")
						subListCategory:setText(_child.name)
						subWidth = subListCategory:getTextSize().width > subWidth and subListCategory:getTextSize().width or subWidth
						local getIcon = _child.icon or _child.name
						subListCategory:setIcon("icons/"..getIcon)
						subListCategory.onClick = function ()
							subList:destroy()
							subList = nil
							refreshHighscorePanel(_child.name, _child.info)
						end
				
					end
				subList:setHeight(subHeight)
				subList:setWidth(subWidth + 35)
				subList:setMarginLeft(button.marginGet - (((subWidth + 35) - (button:getTextSize().width + 35))/2))
				end
			else
				button.onClick = function ()
					refreshHighscorePanel(button, child.name, child.info)
				end
			end
		end
	window:setWidth(windowSize+30)
	if #window:recursiveGetChildById('availableHighscore'):getChildren() < 1 and highscoreInfo[1] then
		refreshHighscorePanel(highscoreInfo[1].name, highscoreInfo[1].info)
	end
	end

function showEventResult(rewards,result,members)
	if not highscoreInfo then return end
	
	local caregoryPanel = windowResult:recursiveGetChildById('availableHighscore')
	caregoryPanel:destroyChildren()
	for i,child in pairs(members) do	
		local button = g_ui.createWidget('HighscoreRankLabel', caregoryPanel)
		button:setText(i.. ". "..child)
		local localPlayer = g_game.getLocalPlayer()
		if localPlayer and localPlayer:getName():lower() == child:lower() then
			button:setChecked(true)
		end
	end
	
	local caregoryPoints = windowResult:recursiveGetChildById('availablePoints')
	caregoryPoints:destroyChildren()
	for i,child in ipairs(result) do	
		local button = g_ui.createWidget('HighscoreDetailLabel', caregoryPoints)
		button:recursiveGetChildById('label'):setText(child[1])
		button:recursiveGetChildById('points'):setText(child[2])
		if i == 4 then
			button:setChecked(true)
		end
	end
	
	local caregoryRewards = windowResult:recursiveGetChildById('availableRewards')
	caregoryRewards:destroyChildren()
	for i,child in pairs(rewards) do	
		local button = g_ui.createWidget('HighscoreRewardLabel', caregoryRewards)
		button:recursiveGetChildById('label'):setImageSource("/images/newUI/hp")
		button:recursiveGetChildById('points'):setText(child.." "..i)
		button:setTextAlign(AlignCenter)
	end
	windowResult:setVisible(true)
	end
	
function refreshHighscorePanel(button, valueName, refreshInfo)
	local highscoreList = window:recursiveGetChildById('availableHighscore')
	if not highscoreList then return end
	--button:setOn(true)	
	highscoreList:destroyChildren()
	local marginValue = 5
	local first = true
	for i,child in pairs(refreshInfo) do	
		local highscore = g_ui.createWidget('HighscorePanel', highscoreList)
		if first then
		    highscore:setMarginTop(marginValue + 15)
		    first = false
		else
		    highscore:setMarginTop(marginValue)
			marginValue = marginValue + 5
		end
		-- if i == 1 then
			-- highscore:getChildById('numberLogo'):getChildById('value'):setText(i.."st")
		-- elseif i == 2 then
			-- highscore:getChildById('numberLogo'):getChildById('value'):setText(i.."nd")
		-- elseif i == 3 then
			-- highscore:getChildById('numberLogo'):getChildById('value'):setText(i.."rd")
		-- else
			-- highscore:getChildById('numberLogo'):getChildById('value'):setText(i.."th")
		-- end
		-- highscore:getChildById('rank'):setText(i .. ". " .. child.name)
		-- highscore:getChildById('value'):setText(child.value)
		-- if not child.looktype then
			-- highscore:getChildById('rank'):setTextOffset(topoint('10 0'))
		-- else
			-- highscore:getChildById('rank'):setTextOffset(topoint('10 0'))
		-- end
		
		local nameWidget = highscore:getChildById("scoreName")
		nameWidget:setText(i .. ". " .. child.name)
		
		local pointsWidget = highscore:getChildById("value")
		pointsWidget:setText(child.value)
		
		
		
		local localPlayer = g_game.getLocalPlayer()
		if localPlayer and localPlayer:getName():lower() == child.name:lower() then
		    highscore:setBackgroundColor("#b3bda5")
			highscore:setOpacity(1)
			--window:recursiveGetChildById('availableHighscoreLabel'):setText("\nYOUR POSITION\n\n"..highscore:getChildById('numberLogo'):getChildById('value'):getText())
		end
	end
end

function switchPanel(visiblePanel)
	for i,child in pairs(allPanels) do
		window:recursiveGetChildById(child):setVisible(false)
	end
	window:recursiveGetChildById(visiblePanel):setVisible(true)
end

function sendMessageBox(title, message)
	if confirmWindow then
	confirmWindow:destroy() 
	end
	local okFunc = function() confirmWindow:destroy() confirmWindow = nil end
	confirmWindow = displayGeneralBox(title, message, {{text=tr('Ok'), callback=okFunc}, anchor=AnchorHorizontalCenter}, okFunc)
end

confirmWindow = nil

function show()
	refreshHighscoreCategory()
    window:raise()
    window:show()
    window:focus()
	 modules.game_interface.getNewUI():recursiveGetChildById('highscore'):setOn(true)
end

function hideWindow()
      window:hide()
	 modules.game_interface.getNewUI():recursiveGetChildById('highscore'):setOn(false)
end
function hideResultWindow()
      windowResult:hide()
	modules.game_interface.getNewUI():recursiveGetChildById('highscore'):setOn(false)
end
function sendAction(opcode, action, data)

    local protocolGame = g_game.getProtocolGame()
    if data == nil then
        data = {}
    end


    if protocolGame then
        protocolGame:sendExtendedOpcode(opcode, json.encode({
            action = action,
            data = data
        }))
    end

end