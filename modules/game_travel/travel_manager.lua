travelButton = nil
moreInfoButton = nil
currentTravelAdd = nil
currentWikiItems = nil
autoTravelWindow = nil
maxTravelSize = 3
textFilter = ""
AUTOTRAVEL_OPCODE = 218
currentDetailedTab = "Quests"
serverList = nil

function init()
    g_ui.loadUI('travel_manager')
    autoTravelWindow = g_ui.createWidget('ServerRoomsWindow', modules.game_interface.getRootPanel())
    autoTravelWindow:setVisible(false)
	serverList = autoTravelWindow:getChildById('servers') 

    connect(g_game, {
        onGameStart = online,
        onGameEnd = offline
    })

  if g_game.isOnline() then
	online()
  end
  
end

function terminate()
    disconnect(g_game, {
        onGameStart = online,
        onGameEnd = offline
    })

	offline()
    travelPanel:destroy()
    ProtocolGame.unregisterExtendedOpcode(AUTOTRAVEL_OPCODE, onTravelJSONOpcode)
end

function online()
    WikiTableValueChange()
    scheduleEvent(function() hide() end,100)
end

function offline()
    hide()
end

function toggle()
	local widget = modules.game_interface.getNewUI():recursiveGetChildById('travel')
	if widget:isOn() then
		widget:setOn(false)
		hide()
	else
		widget:setOn(true)
		show()
	end
end

function show()
    if not g_game.isOnline() then
        return
    end
    autoTravelWindow:show()
    autoTravelWindow:raise()
    autoTravelWindow:focus()
	modules.game_interface.getNewUI():recursiveGetChildById('travel'):setOn(true)
end

function hide()
    autoTravelWindow:hide()
	modules.game_interface.getNewUI():recursiveGetChildById('travel'):setOn(false)
end

local getRooms = {
	"1 vs 1",
	"x4 All vs All",
	"Survival",
	"Rival",
	"Racing",
}

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

function WikiTableValueChange()
	serverList:destroyChildren()
	for i, child in pairs(getRooms) do
		local getRoom = g_ui.createWidget('ServerWidget', serverList)
		local getWidget = getRoom:recursiveGetChildById('server')
		local getTime = getRoom:recursiveGetChildById('time')
		getTime:setText("Estimated search time: 1m 50s")
		getWidget:setText(child)
		getWidget.onClick = function()
			---sendAction(AUTOTRAVEL_OPCODE, "teleportTo", {
			--	room = child,
			--})
			modules.client_entergame.showTravelCharacter(child)
			hide()
		end
	end
	
	local serverListWidth = (#getRooms * 275) - 50
	serverList:setWidth(serverListWidth)
	autoTravelWindow:setWidth(serverListWidth + 100)
end