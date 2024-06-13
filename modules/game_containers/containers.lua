local gameStart = 0

function init()
  connect(Container, { onOpen = onContainerOpen,
                       onClose = onContainerClose,
                       onSizeChange = onContainerChangeSize,
                       onUpdateItem = onContainerUpdateItem })
  connect(g_game, {
    onGameStart = markStart,
    onGameEnd = clean
  })

  reloadContainers()
end

function terminate()
  disconnect(Container, { onOpen = onContainerOpen,
                          onClose = onContainerClose,
                          onSizeChange = onContainerChangeSize,
                          onUpdateItem = onContainerUpdateItem })
  disconnect(g_game, { 
    onGameStart = markStart,
    onGameEnd = clean
  })
end

function reloadContainers()
  clean()
  for _,container in pairs(g_game.getContainers()) do
    onContainerOpen(container)
  end
end

function clean()
  for containerid,container in pairs(g_game.getContainers()) do
    destroy(container)
  end
end

function markStart()
  gameStart = g_clock.millis()
end

function destroy(container)
  if container.window then
    container.window:destroy()
    container.window = nil
    container.itemsPanel = nil
  end
end

function refreshContainerItems(container)
  for slot=0,container:getCapacity()-1 do
    local itemWidget = container.itemsPanel:getChildById('item' .. slot)
    itemWidget:setItem(container:getItem(slot))
  end

  if container:hasPages() then
    refreshContainerPages(container)
  end
end

function toggleContainerPages(containerWindow, hasPages)
  if hasPages == containerWindow.pagePanel:isOn() then
    return
  end
  containerWindow.pagePanel:setOn(hasPages)
  if hasPages then
    containerWindow.miniwindowScrollBar:setMarginTop(containerWindow.miniwindowScrollBar:getMarginTop() + containerWindow.pagePanel:getHeight())
    containerWindow.contentsPanel:setMarginTop(containerWindow.contentsPanel:getMarginTop() + containerWindow.pagePanel:getHeight())  
  else  
    containerWindow.miniwindowScrollBar:setMarginTop(containerWindow.miniwindowScrollBar:getMarginTop() - containerWindow.pagePanel:getHeight())
    containerWindow.contentsPanel:setMarginTop(containerWindow.contentsPanel:getMarginTop() - containerWindow.pagePanel:getHeight())
  end
end

function refreshContainerPages(container)
  local currentPage = 1 + math.floor(container:getFirstIndex() / container:getCapacity())
  local pages = 1 + math.floor(math.max(0, (container:getSize() - 1)) / container:getCapacity())
  container.window:recursiveGetChildById('pageLabel'):setText(string.format('Page %i of %i', currentPage, pages))

  local prevPageButton = container.window:recursiveGetChildById('prevPageButton')
  if currentPage == 1 then
    prevPageButton:setEnabled(false)
  else
    prevPageButton:setEnabled(true)
    prevPageButton.onClick = function() g_game.seekInContainer(container:getId(), container:getFirstIndex() - container:getCapacity()) end
  end

  local nextPageButton = container.window:recursiveGetChildById('nextPageButton')
  if currentPage >= pages then
    nextPageButton:setEnabled(false)
  else
    nextPageButton:setEnabled(true)
    nextPageButton.onClick = function() g_game.seekInContainer(container:getId(), container:getFirstIndex() + container:getCapacity()) end
  end
  
  local pagePanel = container.window:recursiveGetChildById('pagePanel')
  if pagePanel then
    pagePanel.onMouseWheel = function(widget, mousePos, mouseWheel)
      if pages == 1 then return end
      if mouseWheel == MouseWheelUp then
        return prevPageButton.onClick()
      else
        return nextPageButton.onClick()
      end
    end
  end
end

local CS_SHOP_CLIENTSIDE = 202

function sendAction(action, data)
	if not g_game.getFeature(GameExtendedOpcode) then return end
	local protocolGame = g_game.getProtocolGame()
	if data == nil then
		data = {}
	end
	
	if protocolGame then
	
    local msg = OutputMessage.create()
    msg:addU8(50)
    msg:addU8(CS_SHOP_CLIENTSIDE)
    msg:addString(json.encode({action = action, data = data}))
    protocolGame:send(msg)
	end  
end

local getRewards = {
	{rangePoints={1,2}, value={
					}
				},
				{rangePoints={100,999999}, value={
						["BRONZE CHEST"] = {2160,1},
					}
				},
				{rangePoints={1000,999999}, value={
						["BRONZE CHEST"] = {2160,2},
					}
				},
				{rangePoints={5000,999999}, value={
						["BRONZE CHEST"] = {2160,5},
					}
				},
				{rangePosition={5,9}, value={
						["ALPHA POINTS"] = {2160,12},
						["PREMIUM DAYS"] = {2160,30},
					}
				},
				{rangePosition={2,5}, value={
						["ALPHA POINTS"] = {2160,24},
						["PREMIUM DAYS"] = {2160,90},
					}
				},
				{rangePosition={1}, value={
						["MAP STATUE"] = {2160,1},
						["ALPHA POINTS"] = {2160,50},
						["PREMIUM DAYS"] = {2160,360},
					}
	},
}

function onMainContainerOpen(container, previousContainer)
  modules.game_interface.getNewUI():recursiveGetChildById('inventory'):setOn(true)
  local containerWindow
  if previousContainer then
    containerWindow = previousContainer.window
    previousContainer.window = nil
    previousContainer.itemsPanel = nil
  else
    containerWindow = g_ui.createWidget('ContainerInventoryWindow', rootWidget)

    -- white border flash effect
    containerWindow:setBorderWidth(2)
    containerWindow:setBorderColor("#FFFFFF")
    scheduleEvent(function() 
      if containerWindow then
        containerWindow:setBorderWidth(0)
      end
    end, 300)
  end
  
  containerWindow:setId('container' .. container:getId())
  
  local containerPanel = containerWindow:recursiveGetChildById('containerPanel')
  local containerItemWidget = containerWindow:getChildById('containerItemWidget')
  containerWindow:recursiveGetChildById('alphaPoints'):setText(modules.game_creatureinfo.returnCharacterInfo(g_game.getLocalPlayer():getId()).pointsBalance)
  containerWindow.onClose = function()
    g_game.close(container)
    containerWindow:hide()
  end
  
  containerWindow.onDrop = function(container, widget, mousePos)
    if containerPanel:getChildByPos(mousePos) then
      return false
    end
    local child = containerPanel:getChildByIndex(-1)
    if child then
      child:onDrop(widget, mousePos, true)        
    end
  end
  
  containerWindow.onMouseRelease = function(widget, mousePos, mouseButton)
    if mouseButton == MouseButton4 then
      if container:hasParent() then
        return g_game.openParent(container)
      end
    elseif mouseButton == MouseButton5 then
      for i, item in ipairs(container:getItems()) do
        if item:isContainer() then
          return g_game.open(item, container)
        end
      end
    end
  end

  -- this disables scrollbar auto hiding
  local scrollbar = containerWindow:getChildById('miniwindowScrollBar')
  scrollbar:mergeStyle({ ['$!on'] = { }})

  local upButton = containerWindow:getChildById('upButton')
  upButton.onClick = function()
    g_game.openParent(container)
  end
  upButton:setVisible(container:hasParent())

  local name = container:getName()
  name = name:sub(1,1):upper() .. name:sub(2)
  --containerWindow:setText(name)

  containerItemWidget:setItem(container:getContainerItem())

  containerPanel:destroyChildren()
  
  for i = 0,63 do
    local itemWidget = g_ui.createWidget('Item', containerPanel)
    itemWidget:setId('item' .. i)
    itemWidget:setItem(container:getItem(i))
    itemWidget:setMargin(0)
    itemWidget.position = container:getSlotPosition(i)
	
    if not container:isUnlocked() then
      itemWidget:setBorderColor('red')
    end
  end
  
  for i,child in pairs(getRewards) do
	if child.rangePoints then
	--	local getInfo = 
	end
  end
  
  for i = 0,15 do
    local itemWidget2 = g_ui.createWidget('Item', containerWindow:recursiveGetChildById('rewardsPanel'))
    itemWidget2:setId('item' .. i)
    itemWidget2:setItem(container:getItem(i))
    itemWidget2:setMargin(0)
    itemWidget2.position = container:getSlotPosition(i)
	
    if not container:isUnlocked() then
      itemWidget2:setBorderColor('red')
    end
  end
  
  local getChestPanel = containerWindow:recursiveGetChildById('panelChests')
  getChestPanel:destroyChildren()
	local getPlayer = g_game.getLocalPlayer()
  local getInfo = modules.game_creatureinfo.returnCharacterInfo(getPlayer:getId())
  for i,child in pairs(getInfo.chests) do
	local getChest = g_ui.createWidget('ChestReward', getChestPanel) 
	getChest:getChildById('background'):setImageSource(child.icon)
	getChest:getChildById('ammount'):setText("Amount: "..child.ammount)
	getChest:getChildById('button').onClick = function()
		sendAction('openChest', {
			chestId = i,
		})
	end
  end
  
  container.window = containerWindow
  container.itemsPanel = containerPanel

  toggleContainerPages(containerWindow, container:hasPages())
  refreshContainerPages(container)

  if container:hasPages() then
    local height = containerWindow.miniwindowScrollBar:getMarginTop() + containerWindow.pagePanel:getHeight()+17
    if containerWindow:getHeight() < height then
      containerWindow:setHeight(height)
    end
  end

end

BACKPACK_PREMIUM_BAG = 1987
function onContainerOpen(container, previousContainer)
  if container:getContainerItem():getId() == BACKPACK_PREMIUM_BAG then
		onMainContainerOpen(container, previousContainer)
		return
  end
  local containerWindow
  if previousContainer then
    containerWindow = previousContainer.window
    previousContainer.window = nil
    previousContainer.itemsPanel = nil
  else
    containerWindow = g_ui.createWidget('ContainerWindow', modules.game_interface.getContainerPanel())

    -- white border flash effect
    containerWindow:setBorderWidth(2)
    containerWindow:setBorderColor("#FFFFFF")
    scheduleEvent(function() 
      if containerWindow then
        containerWindow:setBorderWidth(0)
      end
    end, 300)
  end
  
  containerWindow:setId('container' .. container:getId())
  if gameStart + 1000 < g_clock.millis() then
    containerWindow:clearSettings()
  end
  
  local containerPanel = containerWindow:getChildById('contentsPanel')
  local containerItemWidget = containerWindow:getChildById('containerItemWidget')
  containerWindow.onClose = function()
    g_game.close(container)
    containerWindow:hide()
  end
  containerWindow.onDrop = function(container, widget, mousePos)
    if containerPanel:getChildByPos(mousePos) then
      return false
    end
    local child = containerPanel:getChildByIndex(-1)
    if child then
      child:onDrop(widget, mousePos, true)        
    end
  end
  
  containerWindow.onMouseRelease = function(widget, mousePos, mouseButton)
    if mouseButton == MouseButton4 then
      if container:hasParent() then
        return g_game.openParent(container)
      end
    elseif mouseButton == MouseButton5 then
      for i, item in ipairs(container:getItems()) do
        if item:isContainer() then
          return g_game.open(item, container)
        end
      end
    end
  end

  -- this disables scrollbar auto hiding
  local scrollbar = containerWindow:getChildById('miniwindowScrollBar')
  scrollbar:mergeStyle({ ['$!on'] = { }})

  local upButton = containerWindow:getChildById('upButton')
  upButton.onClick = function()
    g_game.openParent(container)
  end
  upButton:setVisible(container:hasParent())

  local name = container:getName()
  name = name:sub(1,1):upper() .. name:sub(2)
  containerWindow:setText(name)

  containerItemWidget:setItem(container:getContainerItem())

  containerPanel:destroyChildren()
  for slot=0,container:getCapacity()-1 do
    local itemWidget = g_ui.createWidget('Item', containerPanel)
    itemWidget:setId('item' .. slot)
    itemWidget:setItem(container:getItem(slot))
    itemWidget:setMargin(0)
    itemWidget.position = container:getSlotPosition(slot)

    if not container:isUnlocked() then
      itemWidget:setBorderColor('red')
    end
  end

  container.window = containerWindow
  container.itemsPanel = containerPanel

  toggleContainerPages(containerWindow, container:hasPages())
  refreshContainerPages(container)

  local layout = containerPanel:getLayout()
  local cellSize = layout:getCellSize()
  containerWindow:setContentMinimumHeight(cellSize.height)
  containerWindow:setContentMaximumHeight(cellSize.height*layout:getNumLines())

  if container:hasPages() then
    local height = containerWindow.miniwindowScrollBar:getMarginTop() + containerWindow.pagePanel:getHeight()+17
    if containerWindow:getHeight() < height then
      containerWindow:setHeight(height)
    end
  end

  if not previousContainer then
    local filledLines = math.max(math.ceil(container:getItemsCount() / layout:getNumColumns()), 1)
    containerWindow:setContentHeight(filledLines*cellSize.height)
  end

  containerWindow:setup()
end


function onContainerClose(container)
  destroy(container)
  modules.game_interface.getNewUI():recursiveGetChildById('inventory'):setOn(false)
end

function onContainerChangeSize(container, size)
  if not container.window then return end
  refreshContainerItems(container)
end

function onContainerUpdateItem(container, slot, item, oldItem)
  if not container.window then return end
  local itemWidget = container.itemsPanel:getChildById('item' .. slot)
  itemWidget:setItem(item)
end
