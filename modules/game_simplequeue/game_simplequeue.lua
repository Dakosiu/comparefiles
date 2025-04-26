local gameMapPanelWidget = nil
local mainWindow = nil
local gamePlayers = nil
local eventName = nil
local opcode = 242

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
	sendRequest()
	mainWindow = g_ui.displayUI('game_simplequeue')
	setWindowPosition()
	mainWindow:setVisible(false)
	--g_keyboard.bindKeyDown('Ctrl+N', toggle)
	ProtocolGame.registerExtendedOpcode(opcode, onReceiveRequest)
	gamePlayers = mainWindow:getChildById('gamePlayers')
	eventName = mainWindow:getChildById('gameId')
	queueEvent()
	sendRequest()
end


function sendRequest(request)
	local protocolGame = g_game.getProtocolGame()
	--print("Wysylam 1")
	if protocolGame then
	    protocolGame:sendExtendedOpcode(opcode, request)
    end
	return true
end

function toggle()
	if mainWindow:isVisible() then
	    mainWindow:setVisible(false)
	else
	    mainWindow:setVisible(true)
	end
end

function terminate()
    mainWindow:setVisible(false)
end
	
function onReceiveRequest(self, opcode, buffer)
    local t = json.decode(buffer)
	if t.buffer == "fetchData" then
	    local data = t.data
		gamePlayers:setText(data.countPlayers .. "/" .. data.maxParticipants)
		return true
	end
	if t.buffer == "displayWindow" then
	    mainWindow:setVisible(true)
		local data = t.data
		local name = data.eventName
		
		if name == "1 v 1" then
		    name = "Rivals"
		end

		-- if name == "Rival" then
		    -- name = "1 v 1"
		-- end
		eventName:setText(name)
		gamePlayers:setText(data.countPlayers .. "/" .. data.maxParticipants)
	end
	if t.buffer == "hideWindow" then
	    mainWindow:setVisible(false)
		return true
	end
end

function removeFromQueue(self)
   local t = {}
   t.buffer = "removeFromQueue"
   sendRequest(json.encode(t))
end
	

function setWindowPosition()   
    mainWindow:addAnchor(AnchorTop, 'gameRootPanel', AnchorTop) -- Anchors yourWidget top on top of gameRootPanel
	mainWindow:addAnchor(AnchorBottom, 'gameRootPanel', AnchorBottom) -- Anchors yourWidget top on top of gameRootPanel
    local mapWidget = modules.game_interface.getMapPanel()
    -- local mainWindowTopMargin = -280
    local mainWindowLeftMargin = 0
    -- local mapWidgetMarginTop = mapWidget:getY() -- Top margin of mapWidget (which is the top menu height)
    local mapWidgetMarginLeft = mapWidget:getX() -- Left margin of mapWidget (which is the left panels width)
    -- local gameScreenAreaMarginTop = math.floor( ( mapWidget:getHeight() - mapWidget:getMapHeight() ) / 2 ) -- Top margin between mapWidget and the game screen area
    local gameScreenAreaMarginLeft = math.floor( ( mapWidget:getWidth() - mapWidget:getMapWidth() ) / 2 ) -- Left margin between mapWidget and the game screen area
    --mainWindow:setMarginTop( mainWindowTopMargin + mapWidgetMarginTop + gameScreenAreaMarginTop )
    mainWindow:setMarginLeft( mainWindowLeftMargin + mapWidgetMarginLeft + gameScreenAreaMarginLeft )
    mainWindow:setMarginTop(47)
    mainWindow:setMarginBottom(770)
end

local queueSpend = 0
function queueEvent()
    local gameStatus = mainWindow:getChildById('gameStatus')
	if queueSpend == 4 then
	    gameStatus:setText("In Queue")
		queueSpend = 0
	end
	gameStatus:setText(gameStatus:getText() .. ".")
	queueSpend = queueSpend + 1

	scheduleEvent(queueEvent, 1000)
end
	
	