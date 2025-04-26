local mainWindow = nil
local opcode = 111

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
end


function toggle()
	if mainWindow:isVisible() then
	    mainWindow:setVisible(false)
	else
	    mainWindow:setVisible(true)
	end
end

function terminate()
	if mainWindow then
	    mainWindow:destroy()
	end
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function onReceiveRequest(self, opcode, buffer)
    local t = json.decode(buffer)
	if t.buffer == "displayRewards" then
	    mainWindow = g_ui.displayUI('openchest')
		local items = t.data
		local itemsPanel = mainWindow:recursiveGetChildById('itemsPanel')
		for i = 1,27 do
            local itemWidget = g_ui.createWidget('Item', itemsPanel)
			itemWidget:setVirtual(true);
            itemWidget:setId('item' .. i)
            itemWidget:setMargin(0)			      
        end
		
		local index = 1
		for i, v in pairs(items) do
		    local itemWidget = itemsPanel:recursiveGetChildById("item" .. index)
			itemWidget:setItemId(v.id)
			itemWidget:setItemCount(v.count)
			itemWidget:setTooltip(v.count .. "x " .. v.name)
			index = index + 1
		end
		return true
	end
end

	