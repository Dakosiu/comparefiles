highscoreButton = nil
window = nil
seasonEndTextList = nil
seasonEndLabel = nil
HIGHSCORE_OPCODE = 151
local refreshMemoryTime = 60
local windowResult = nil
function init()
	highscoreButton = modules.client_topmenu.addLeftGameButton('highscoreButton', tr('highscore'), '/images/topbuttons/highscore', toggle, false, 8)
	
	g_ui.importStyle('highscorewindow')

	window = g_ui.createWidget('HighscoreWindowRanking', rootWidget)
	window:hide()
	windowResult = g_ui.createWidget('HighscoreWindow', rootWidget)
	windowResult:hide()
	
	seasonEndTextList = window:recursiveGetChildById('SeasonSchedulerTextList')
	seasonEndLabel = seasonEndTextList:recursiveGetChildById('SeasonEndLabel')
	--seasonTitleTextList = window:recursiveGetChildById('TitleTextList')
	--seasonTitleLabel = seasonTitleTextList:recursiveGetChildById('seasonTitleLabel')
	
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
	--printTable(json_data)
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
	
	    local divisionData = getData['division']
		local points_string = getData['pointsString']
		
		local divisionLabel = window:recursiveGetChildById('divisionText')
	    divisionLabel:setText(divisionData)
	    local pointsLabel = window:recursiveGetChildById('divisionPoints')
	    pointsLabel:setText(points_string)
		
	
	
	
	    seasonEndLabel:setText(getData["time_end"])
		--seasonTitleLabel:setText(getData["title"])
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
		showEventResult(getData['rewards'],getData['result'],getData['members'], getData['division'])
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
				if child.name:lower() == "survival" then
					refreshHighscorePanel(button, child.name, child.info)
				end
			end
		end
	window:setWidth(windowSize+30)
	if #window:recursiveGetChildById('availableHighscore'):getChildren() < 1 and highscoreInfo[1] then
		refreshHighscorePanel(highscoreInfo[1].name, highscoreInfo[1].info)
	end
	end

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

function showEventResult(rewards,result,members, division)
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
	
	local divisionTable = division
	local divisionLabel = windowResult:recursiveGetChildById('divisionText')
	divisionLabel:setText(divisionTable.value)
	local pointsLabel = windowResult:recursiveGetChildById('divisionPoints')
	pointsLabel:setText(divisionTable.str)
	
	-- local bar = windowResult:recursiveGetChildById('fillBar')
	-- bar:setMarginRight(160)
	-- bar:setMarginLeft(20)
	--bar:setWidth(5 + 100)
	--bar:setMarginLeft(24)
	
	
	
	
	
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
	
	local categoryRewards = windowResult:recursiveGetChildById('availableRewards')
	
	local alphaCoinsPanel = categoryRewards:recursiveGetChildById('alphaPointsRewards')
	alphaCoinsPanel:setBackgroundColor("#b3bda5")
	alphaCoinsPanel:setOpacity(1)
	
	local coinValue = 0
	for i,v in pairs(rewards) do
	    if v.type == "alpha points" then
		    coinValue = coinValue + v.count
		end
	end
	
	if coinValue > 0 then
		local text = alphaCoinsPanel:recursiveGetChildById('coinValue')
		text:setText(coinValue .. " Alpha Points")
		alphaCoinsPanel:setVisible(true)
	end
	-- for i,v in pairs(rewards) do
	    -- if v.type == "alpha points" then
		    -- local count = v.count
			-- print("Jest " .. count .. " alpha coinow.")
		    -- local widget = g_ui.createWidget('alphaPointsRewards', categoryRewards)
			-- if widget then
			    -- print("Widze widget?")
			-- end
		    -- widget:setBackgroundColor("#b3bda5")
			-- widget:setOpacity(1)
		-- end
	-- end
	--caregoryRewards:destroyChildren()
	
	-- for i = 0,11 do
         -- local itemWidget2 = g_ui.createWidget('Item', caregoryRewards)
         -- itemWidget2:setId('item' .. i)
         -- itemWidget2:setMargin(0)
    -- end
  
  
	-- for i,child in pairs(rewards) do	
		-- local button = g_ui.createWidget('HighscoreRewardLabel', caregoryRewards)
		-- button:recursiveGetChildById('label'):setImageSource("/images/newUI/hp")
		-- button:recursiveGetChildById('points'):setText(child.." "..i)
		-- button:setTextAlign(AlignCenter)
	-- end
	
	
	-- if rewards then
	    -- local itemSize = 0
	    -- for i, v in pairs(rewards) do
		    -- if v.type == "alpha points" then
			    -- if v.count > 0 then
			        -- setItem(itemSize, nil, v.count, "aP")
					-- itemSize = itemSize + 1
				-- end
			-- elseif v.type == "item" then
			    -- setItem(itemSize, v.id, v.count)
				-- itemSize = itemSize + 1
		    -- end
		-- end
	-- end
	
	--setItem(0, nil, 15, "aP")
	
	windowResult:setVisible(true)
end


function setItem(index, id, count, text)
    if not count then
	    count = 1
	end
	local panel = windowResult:recursiveGetChildById('availableRewards')
	local itemWidget = panel:recursiveGetChildById("item" .. index)
	
	if id then
	    itemWidget:setItemId(id)
	end
	
	if text then
	    itemWidget:setFont('terminus-14px-bold')
	    itemWidget:setText(text)
	    itemWidget:setColor("#9F3548")
	    itemWidget:setTooltip(count .. " Alpha Points")
	end
	itemWidget:setItemCount(count)
	
end


function refreshHighscorePanel(button, valueName, refreshInfo)
	local highscoreList = window:recursiveGetChildById('availableHighscore')
	if not highscoreList then return end
	--button:setOn(true)	
	
	
	--print("HIGHSCORE INFO: " .. dump(refreshInfo))
	highscoreList:destroyChildren()
	local marginValue = 5
	local first = true
	for i,child in pairs(refreshInfo) do	
		local highscore = g_ui.createWidget('HighscorePanel22', highscoreList)
		if first then
		    highscore:setMarginTop(marginValue + 15)
		    first = false
		end		
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