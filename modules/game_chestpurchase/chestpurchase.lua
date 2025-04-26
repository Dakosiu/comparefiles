local opcode = 113


local chestImage = nil
local chestDescription = nil

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
    mainWindow:setVisible(false)
	-- if mainWindow then
	    -- mainWindow:destroy()
	-- end
end
	
function displayReward(text, image)
	mainWindow = g_ui.displayUI('chestpurchase')
	chestImage = mainWindow:recursiveGetChildById('chestImage')
	chestDescription = mainWindow:recursiveGetChildById('chestDescription')
	print("Image Path: " .. image)
    chestImage:setImageSource(image)
	chestDescription:setText(text)
	mainWindow:setVisible(true)
end

function onReceiveRequest(self, opcode, buffer)
    local t = json.decode(buffer)
	if t.buffer == "displayClaimedChest" then
	    print("Tu jestem?")
	    local data = t.data
		local text = data.text
		local image = data.image
		displayReward(text, image)
	end
end

	