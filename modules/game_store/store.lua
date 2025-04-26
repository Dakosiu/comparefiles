local window
local listCategory
local shopButton
local listProduct
local pointBalance
local acceptWindow
local transferPointsWindow 
local CS_SHOP_CLIENTSIDE = 202
local CS_SHOP_SERVERSIDE = 203
local WEBSITE_GETCOINS = ""
local IMAGES_URL = Services.website.."/store"
local debugMode = false
local localImageMode = true
local changeNamePrice
local PLAYER_GENDER = 0
local shrinkCategoryList = true
local getOutfitFix = {}
local function formatNumbers(number)
	local ret = number
	while true do  
		ret, k = string.gsub(ret, "^(-?%d+)(%d%d%d)", '%1,%2')
		if k == 0 then
			break
		end
	end
return ret
end

function init()	
	g_ui.importStyle('assets/ui')
	g_ui.importStyle('assets/acceptwindow')

	
	connect(g_game, { 
		onGameStart = check,
		onGameEnd = onCloseStore
	})
    
	window = g_ui.displayUI('assets/store')
  shopButton = modules.client_topmenu.addLeftButton('shopButton', tr('Shop'),
    '/images/topbuttons/logout', toggle, true)
      
	listCategory = window:recursiveGetChildById('listCategory')
	listProduct  = window:recursiveGetChildById('listProduct')
	pointBalance  = window:recursiveGetChildById('lblPoints')
	transferHistory  = window:recursiveGetChildById('transferHistoryPanel')
	btnBuy = window:recursiveGetChildById('btnBuy')
	btnGift = window:recursiveGetChildById('btnBuyGift')
	transferPointsWindow = g_ui.displayUI('assets/transferpoints')
	transferPointsWindow:setVisible(false)
	
	changeNameWindow = g_ui.displayUI('assets/changename')
	changeNameWindow:setVisible(false)
	
	transferHistory:setVisible(false)			
	
	listProduct.onChildFocusChange = function(self, focusedChild)
		if (not focusedChild) then return end
		local product = focusedChild.product
		local panel = window:getChildById('panelItem')
		
		--panel:getChildById('lblPrice'):setText(formatNumbers(product.price))
		if (getPointsBalance() < product.price) then
			--panel:getChildById('lblPrice'):setColor("#d33c3c")
			btnBuy:disable()
			btnGift:disable()
		else
			--panel:getChildById('lblPrice'):setColor("white")
			btnBuy:enable()
			btnGift:enable()
		end
		
		btnBuy.onClick = function(widget)
			if acceptWindow then
				acceptWindow:raise()
				acceptWindow:focus()
				return true
			end
		
			local acceptFunc = function()
				local unformatted = pointBalance:getText():gsub(',', '')
				local unformatted2 = unformatted:gsub('Alpha Coins: ', '')
				local balanceInfo = tonumber(unformatted2)
				if balanceInfo >= product.price and product.price > 0 then
					if product.type == 5 then
						changeName(product.price)
					else
						if (product.type == 4) or (product.type == 11) then
							sendAction("buyItem", {price = product.price, secondPrice = product.secondPrice, type = product.type, count = product.count, name = product.name, id = product.sexId, addons = 0, shopCall=true, packageId=product.packageId, actionId=product.actionId})
						else
							sendAction("buyItem", {price = product.price, secondPrice = product.secondPrice, type = product.type, count = product.count, name = product.name, id = product.id, shopCall=true, packageId=product.packageId, actionId=product.actionId})
						end
					end
					
					if acceptWindow then
						acceptWindow:destroy()
						acceptWindow = nil
					end
				else
					displayErrorBox(window:getText(), tr("You don't have enough points"))
					acceptWindow:destroy()
					acceptWindow = nil
				end
			end
		
			local cancelFunc = function() acceptWindow:destroy() acceptWindow = nil end
			acceptWindow = displayGeneralBox(
			tr('Confirmation of Purchase'), 'Do you want to buy the product "'..product.name..'"?', { 
				{text=tr('Buy'), callback=acceptFunc},
				{text=tr('Cancel'), callback=cancelFunc},
				anchor=AnchorHorizontalCenter 
			}, acceptFunc, cancelFunc)
		end
	end  

  shopButton = modules.client_topmenu.addRightGameToggleButton('shopButton', tr('Shop'), '/images/topbuttons/shop', toggle, false, 8)

    ProtocolGame.registerExtendedOpcode(CS_SHOP_SERVERSIDE, onStoreJSONOpcode)
end

function terminate()
	disconnect(g_game, { 
		onGameStart = check,
		onGameEnd = onCloseStore
	})
	
	window:destroy()
end

function getPointsWebsite()
	if WEBSITE_GETCOINS ~= "" then
		g_platform.openUrl(WEBSITE_GETCOINS)
	else
		sendMessageBox("Error", "No data for store URL.")
	end
end

function getPointsBalance()
	local unformatted = pointBalance:getText():gsub(',', '')
	local unformatted2 = unformatted:gsub('Alpha Points: ', '')
	local balanceInfo = tonumber(unformatted2)
return balanceInfo
end

function createHistoryEntries(buffer)
	-- Clearing the history
	while transferHistory:getChildById('transferHistory'):getChildCount() > 0 do
		local child = transferHistory:getChildById('transferHistory'):getLastChild()
		transferHistory:getChildById('transferHistory'):destroyChildren(child)
	end
	
	local data = buffer[1]
	-- Filling it
	for i = 1, #data do
		local row = g_ui.createWidget('HistoryEntry', transferHistory:getChildById('transferHistory'))	  
		row.index = i
		row:getChildById('historyDate'):setText(data[i].date)
		row:getChildById('historyDescription'):setText(data[i].description)
		row:getChildById('historyBalance'):setText(data[i].balance)
		
		if tonumber(row:getChildById('historyBalance'):getText()) < 0 then
			--row:getChildById('historyBalance'):setColor("#d33c3c")
		else
			row:getChildById('historyBalance'):setMarginLeft(200)
			--row:getChildById('historyBalance'):setColor("#00ff00")
		end
		
		
		if (i > 1) then
			row:setMarginTop(28 + ((i-1) * 15))
		end
		
		if (i % 2 == 0) then
			row:setBackgroundColor("#414141")
		end
	end
end

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

function toggleTransferHistory()
	if transferHistory:isVisible() then
		transferHistory:setVisible(false)
	else
		transferHistory:setVisible(true)
		listCategory:getFocusedChild():focus(false)
		sendAction("getHistoryData", nil)
	end
end

local parsingTables = {}

function onStoreJSONOpcode(protocol, code, json_data_convert)
    local json_data = json.decode(json_data_convert)
    local action = json_data['action']
    local data = json_data['data']
    if not action or not data then
        return false
    end

	if data['opcodeData'] then
		if data['opcodeDataFirst'] and data['opcodeDataFirst'] == "true" then
			if not parsingTables[code] then parsingTables[code] = {} end
			parsingTables[code][action] = {data={},collect=""}
		end
		
		parsingTables[code][action].collect = parsingTables[code][action].collect ..""..data['opcodeData']
		if data['opcodeDataLast'] and data['opcodeDataLast'] == "true" then
			local getData = json.decode(parsingTables[code][action].collect)
			for i,child in pairs(getData) do
				parsingTables[code][action].data[i] = child
			end
			data = json.decode(json.encode(parsingTables[code][action].data))
			if not action or not data then
				return false
			end
			
	if action == 'sendPoints' then
		pointBalance:setText("Alpha Points: "..formatNumbers(data.points))
	elseif action == "sendStoreData" then
		getStoreCategories(data.data)
	elseif action == "sendHistory" then
		createHistoryEntries(data.history)
	elseif action == "sendStoreURL" then
		changeStoreUrl(data.url)
	elseif action == "sendImagesURL" then
		changeImagesUrl(data.url)
	elseif action == "sendMessage" then
		sendMessageBox(data.title, data.message)
	elseif action == "sendHideStore" then
		window:hide()
	elseif action == "sendPlayerSex" then
		updatePlayerSex(data)
	end
end
end
end



function updatePlayerSex(data)
	PLAYER_GENDER = data.sex
end

function changeStoreUrl(url)
	WEBSITE_GETCOINS = url
end

function changeImagesUrl(url)
	IMAGES_URL = url
end

local letterWidth = {  -- New line (10) and Space (32) have width 1 because they are printed and not replaced with spacer
  [10] = 1, [32] = 1, [33] = 3, [34] = 6, [35] = 8, [36] = 7, [37] = 13, [38] = 9, [39] = 3, [40] = 5, [41] = 5, [42] = 6, [43] = 8, [44] = 4, [45] = 5, [46] = 3, [47] = 8,
  [48] = 7, [49] = 6, [50] = 7, [51] = 7, [52] = 7, [53] = 7, [54] = 7, [55] = 7, [56] = 7, [57] = 7, [58] = 3, [59] = 4, [60] = 8, [61] = 8, [62] = 8, [63] = 6,
  [64] = 10, [65] = 9, [66] = 7, [67] = 7, [68] = 8, [69] = 7, [70] = 7, [71] = 8, [72] = 8, [73] = 5, [74] = 5, [75] = 7, [76] = 7, [77] = 9, [78] = 8, [79] = 8,
  [80] = 7, [81] = 8, [82] = 8, [83] = 7, [84] = 8, [85] = 8, [86] = 8, [87] = 12, [88] = 8, [89] = 8, [90] = 7, [91] = 5, [92] = 8, [93] = 5, [94] = 9, [95] = 8,
  [96] = 5, [97] = 7, [98] = 7, [99] = 6, [100] = 7, [101] = 7, [102] = 5, [103] = 7, [104] = 7, [105] = 3, [106] = 4, [107] = 7, [108] = 3, [109] = 11, [110] = 7,
  [111] = 7, [112] = 7, [113] = 7, [114] = 6, [115] = 6, [116] = 5, [117] = 7, [118] = 8, [119] = 10, [120] = 8, [121] = 8, [122] = 6, [123] = 7, [124] = 4, [125] = 7, [126] = 8,
  [127] = 1, [128] = 7, [129] = 6, [130] = 3, [131] = 7, [132] = 6, [133] = 11, [134] = 7, [135] = 7, [136] = 7, [137] = 13, [138] = 7, [139] = 4, [140] = 11, [141] = 6, [142] = 6,
  [143] = 6, [144] = 6, [145] = 4, [146] = 3, [147] = 7, [148] = 6, [149] = 6, [150] = 7, [151] = 10, [152] = 7, [153] = 10, [154] = 6, [155] = 5, [156] = 11, [157] = 6, [158] = 6,
  [159] = 8, [160] = 4, [161] = 3, [162] = 7, [163] = 7, [164] = 7, [165] = 8, [166] = 4, [167] = 7, [168] = 6, [169] = 10, [170] = 6, [171] = 8, [172] = 8, [173] = 16, [174] = 10,
  [175] = 8, [176] = 5, [177] = 8, [178] = 5, [179] = 5, [180] = 6, [181] = 7, [182] = 7, [183] = 3, [184] = 5, [185] = 6, [186] = 6, [187] = 8, [188] = 12, [189] = 12, [190] = 12,
  [191] = 6, [192] = 9, [193] = 9, [194] = 9, [195] = 9, [196] = 9, [197] = 9, [198] = 11, [199] = 7, [200] = 7, [201] = 7, [202] = 7, [203] = 7, [204] = 5, [205] = 5, [206] = 6,
  [207] = 5, [208] = 8, [209] = 8, [210] = 8, [211] = 8, [212] = 8, [213] = 8, [214] = 8, [215] = 8, [216] = 8, [217] = 8, [218] = 8, [219] = 8, [220] = 8, [221] = 8, [222] = 7,
  [223] = 7, [224] = 7, [225] = 7, [226] = 7, [227] = 7, [228] = 7, [229] = 7, [230] = 11, [231] = 6, [232] = 7, [233] = 7, [234] = 7, [235] = 7, [236] = 3, [237] = 4, [238] = 4,
  [239] = 4, [240] = 7, [241] = 7, [242] = 7, [243] = 7, [244] = 7, [245] = 7, [246] = 7, [247] = 9, [248] = 7, [249] = 7, [250] = 7, [251] = 7, [252] = 7, [253] = 8, [254] = 7, [255] = 8
}
function changePrice(row,price)
						row:getChildById('lblPrice'):setText('Alpha Points: '..formatNumbers(price))
						row.product.price = price
						if getPointsBalance() < price then
							--row:getChildById('lblPrice'):setColor("#FF7377")
						else
							--row:getChildById('lblPrice'):setColor("#90EE90")
						end
		end
function getStoreCategories(buffer)
	clearCategories()
	
	local storeIndex = buffer
	local countCategory = 0
	local countCategoryWidth = 0
	for i, store in ipairs(storeIndex) do
		local category = g_ui.createWidget('MenuCategoryStore', listCategory)
			category.index  = i
			
			if localImageMode then
				category:setIcon("images/"..store.icon)
			else
				local iconURL = IMAGES_URL.."/"..store.icon..".png"
				HTTP.downloadImage(iconURL, function(path, err) 
					if err and debugMode then 
						g_logger.warning("HTTP error: " .. err)
					return end
					
					if path then
						category:setIcon(path)
					end
				end)
			end
			local namer = storeIndex[i].name
			if namer:lower() == "premium time" then
			namer = "Premium"
			end
			category:setText(tr(namer))
			local getWidth = 0
			local categoryString = category:getText()
			for i = 1,#categoryString do
			getWidth = getWidth + letterWidth[string.byte(categoryString,i,i+1)]
			end
			category:setWidth(32+getWidth)
	
		category.onClick = function(self)	
			listProduct:destroyChildren()
			
			for i,child in pairs(listCategory:getChildren()) do
				child:setColor("white")
			end
			self:setColor("green")
			local storeProducts = store.offers
			if storeProducts then
				for i, product in ipairs(storeProducts) do
					if tostring(self.index) == product.category_id then
						local row = g_ui.createWidget('RowStore', listProduct)
						row:recursiveGetChildById('buyButton').onClick = function(widget)
							if acceptWindow then
								acceptWindow:raise()
								acceptWindow:focus()
								return true
							end
						
							local acceptFunc = function()
								local unformatted = pointBalance:getText():gsub(',', '')
								local unformatted2 = unformatted:gsub('Alpha Points: ', '')
								local balanceInfo = tonumber(unformatted2)
								if balanceInfo >= product.price and product.price > 0 then
									if product.type == 5 then
										changeName(product.price)
									else
										if (product.type == 4) or (product.type == 11) then
											sendAction("buyItem", {price = product.price, secondPrice = product.secondPrice, type = product.type, count = product.count, name = product.name, id = product.sexId, addons = 0, shopCall=true, packageId=product.packageId, actionId=product.actionId})
										else
											sendAction("buyItem", {price = product.price, secondPrice = product.secondPrice, type = product.type, count = product.count, name = product.name, id = product.id, shopCall=true, packageId=product.packageId, actionId=product.actionId})
										end
									end
									
									if acceptWindow then
										acceptWindow:destroy()
										acceptWindow = nil
									end
								else
									displayErrorBox(window:getText(), tr("You don't have enough points"))
									acceptWindow:destroy()
									acceptWindow = nil
								end
							end
						
							local cancelFunc = function() acceptWindow:destroy() acceptWindow = nil end
							acceptWindow = displayGeneralBox(
							tr('Confirmation of Purchase'), 'Do you want to buy the product "'..product.name..'"?', { 
								{text=tr('Buy'), callback=acceptFunc},
								{text=tr('Cancel'), callback=cancelFunc},
								anchor=AnchorHorizontalCenter 
							}, acceptFunc, cancelFunc)
						end
					
						row.store = store
						row.product = product	
						row.storePrice = product.price
						row.type = product.type		
						if product.description then
							row:getChildById('lblBackground'):setTooltip(product.description)
						end
						local renderImage = (type(product.id) == "number" and product.id) or (product.image and type(product.image) == "number" and product.image)
						if renderImage then
							row:getChildById('item'):setItemId(renderImage)
						end
						if product.type == 1 or product.type == 2 then
							row:getChildById('lblName'):setText("x"..product.count.." "..product.name)
						else
							row:getChildById('lblName'):setText(product.name)
						end
					
							row:getChildById('lblName'):setTextAlign(AlignCenter)
							row:getChildById('lblName'):setMarginRight(10)
							changePrice(row,product.price)
							if row.product.type == 4 then
								changePrice(row,0)
							end
						if product.image and type(product.image) == "table" and (product.image["female"] or product.image["male"]) then
						local localPlayer = g_game.getLocalPlayer()
						getOutfitFix[row:getId()] = localPlayer:getOutfit()
							getOutfitFix[row:getId()].wings = 0
							getOutfitFix[row:getId()].aura = 0
							getOutfitFix[row:getId()].shader = ""
							if PLAYER_GENDER == 0 then
								if type(product.image["female"]) == "table" then
									getOutfitFix[row:getId()] = product.image["female"]
								else
									getOutfitFix[row:getId()].type = tonumber(product.image["female"])
								end
								row:getChildById('image'):setVisible(false)
								else
									if type(product.image["male"]) == "table" then
										getOutfitFix[row:getId()] = product.image["male"]
									else
									getOutfitFix[row:getId()].type = tonumber(product.image["male"])
									end
								row:getChildById('image'):setVisible(false)
								end
						if (product.type == 12) then
							getOutfitFix[row:getId()].wings = getOutfitFix[row:getId()].type
							getOutfitFix[row:getId()].type = localPlayer:getOutfit().type
						elseif (product.type == 13) then
							getOutfitFix[row:getId()].aura = getOutfitFix[row:getId()].type
							getOutfitFix[row:getId()].type = localPlayer:getOutfit().type
						elseif (product.type == 14) then
							getOutfitFix[row:getId()].shader = product.image["female"]
							getOutfitFix[row:getId()].type = localPlayer:getOutfit().type
						elseif (product.type == 11) then
							--getOutfitFix[row:getId()].addons = 7
						elseif (product.type == 4) then
							--getOutfitFix[row:getId()].addons = 0
						end
						
							row:getChildById('outfit'):setAutoRotating(true)
							row:getChildById('outfit'):setOutfit(getOutfitFix[row:getId()])
							row:getChildById('outfit'):setAutoRotating(true)

						else
								row:getChildById('outfit'):setVisible(false)
						if product.image and type(product.image) == "table" then
							local productImage = product.image[1]
							if (product.type == 3) or (product.type == 13) then
								if PLAYER_GENDER == 0 then
									productImage = product.image[2]
								end
							end
							
							if productImage then
								if localImageMode then
									local getSize = productImage
									if string.find(productImage, "64/") then
									row:getChildById('image'):setHeight(64)
									row:getChildById('image'):setWidth(64)
									elseif string.find(productImage, "32/") then
									row:getChildById('image'):setHeight(32)
									row:getChildById('image'):setWidth(32)
									elseif string.find(productImage, "128/") then
									row:getChildById('image'):setHeight(128)
									row:getChildById('image'):setWidth(128)
									end
									row:getChildById('image'):setImageSource("images/"..productImage)
								else
									local imageURL = IMAGES_URL.."/"..productImage..".png"
									HTTP.downloadImage(imageURL, function(path, err) 
										if err and debugMode then 
											g_logger.warning("HTTP error: " .. err)
										return end
										
										if (path ~= nil) then
											row:getChildById('image'):setImageSource(path)
										end
									end)
								end
							end
						end
					end
				end
			end
			end
			if transferHistory:isVisible() then
				transferHistory:setVisible(false)
			end
			
			listProduct:focusChild(listProduct:getFirstChild())  
		end
	
	countCategoryWidth = countCategoryWidth + category:getWidth()
	countCategory = countCategory + 1
end
	if shrinkCategoryList then
	listCategory:setWidth(15 + countCategoryWidth + (countCategory * 5 ))
	--window:setWidth(50 + (countCategory * 80) + (countCategory * 5 ))
	end
	listCategory:focusChild(listCategory:getFirstChild())  
	listCategory:getFirstChild().onClick(listCategory:getFirstChild())
	storeDataSent = true
end

function downloadImages()

end

function clearOffers()
	while listProduct:getChildCount() > 0 do
		local child = listProduct:getLastChild()
		listProduct:destroyChildren(child)
	end
end

function clearCategories()
	clearOffers()
	while listCategory:getChildCount() > 0 do
		local child = listCategory:getLastChild()
		listCategory:destroyChildren(child)
	end
end

function onCloseStore()
  modules.game_interface.getNewUI():recursiveGetChildById('store'):setOn(false)
	window:hide()
	transferPointsWindow:setVisible(false)
	
	if acceptWindow then
		acceptWindow:destroy()
		acceptWindow = nil
	end
end

function openStoreWindow()
	window:setVisible(true)
  	modules.game_interface.getNewUI():recursiveGetChildById('store'):setOn(true)
end

function transferPoints()
	window:hide()
	
	if getPointsBalance() <= 0 then
		return sendMessageBox("Gifting not possible", "You don't have enough points to gift.", true)
	end
	
	local value = transferPointsWindow:getChildById('transferPointsValue')
	value:setText(tr('0'))

	local balanceInfo = window:getChildById('lblPoints'):getText()
	local balance = transferPointsWindow:getChildById('pointBalance2')
	balance:setText(formatNumbers(balanceInfo))
	transferPointsWindow:setVisible(true)
	
	transferPointsWindow:focus()
	transferPointsWindow:raise()
	
	if acceptWindow then
		acceptWindow:destroy()
		acceptWindow = nil
	end
end

function changeName(price)
	local newName = changeNameWindow:getChildById('transferPointsText')
	newName:setText(tr(''))
	
	changeNameWindow:setVisible(true)
	changeNameWindow:focus()
	changeNameWindow:raise()
	
	-- Internal Variable
	changeNamePrice = price
	
	if acceptWindow then
		acceptWindow:destroy()
		acceptWindow = nil
	end
end

function changeNameAccept()
	local newName = changeNameWindow:getChildById('transferPointsText')
	sendAction("changeName", {name = newName:getText(), price = changeNamePrice})
	
	changeNameWindow:setVisible(false)
	newName:setText("")
	window:setVisible(true)
end

function changeNameCancel()
	local newName = changeNameWindow:getChildById('transferPointsText')
	newName:setText("")
				
	changeNameWindow:setVisible(false)
	window:setVisible(true)
end

function transferAccept()
	local unformatted = pointBalance:getText():gsub(',', '')
	local unformatted2 = unformatted:gsub('Alpha Points: ', '')
	local balanceInfo = tonumber(unformatted2)
	local nickname = transferPointsWindow:getChildById('transferPointsText')
	local value = transferPointsWindow:getChildById('transferPointsValue')
	if not value then return true end
	
	transferPointsWindow:getChildById('buttonOk').onClick = function(widget)
		local transferableAmountSet = tonumber(value:getText())
		if transferableAmountSet > balanceInfo then
			displayErrorBox(window:getText(), tr("You don't have enough points"))
			return true
		end
		
		if tonumber(transferableAmountSet) <= 0 then
			return true
		end
		
		if acceptWindow then
			acceptWindow:raise()
			acceptWindow:focus()
			return true
		end
		
		local cancelFunc = function() acceptWindow:destroy() acceptWindow = nil end
		local acceptFunc = function()
			if balanceInfo >= transferableAmountSet then
				-- Send the action to transfer the points.
				sendAction("transferPoints", {name = nickname:getText(), amount = transferableAmountSet})
				
				-- Destroy accept window
				acceptWindow:destroy()
				acceptWindow = nil
				
				-- Cleaning
				nickname:setText("")
				value:setText("0")
				
				-- Removing the window
				transferPointsWindow:setVisible(false)
				window:setVisible(true)
				
				-- Getting points balance
				sendAction("getPoints", nil)
			else
				displayErrorBox(window:getText(), tr("You don't have enough points"))
				acceptWindow:destroy()
				acceptWindow = nil
			end
		end
		
		acceptWindow = displayGeneralBox(tr('Gift Tibia Points'), tr("Do you want to transfer "..transferableAmountSet.." to "..nickname:getText().."?"),
		{ { text=tr('Yes'), callback=acceptFunc },
		{ text=tr('Cancel'), callback=cancelFunc },
		anchor=AnchorHorizontalCenter }, acceptFunc, cancelFunc)
			
	end
end

function transferCancel()
	local nickname = transferPointsWindow:getChildById('transferPointsText')
	local value = transferPointsWindow:getChildById('transferPointsValue')
	nickname:setText("")
	value:setText("0")
				
	transferPointsWindow:setVisible(false)
	transferHistory:setVisible(false)
	window:setVisible(true)
end

function sendMessageBox(title, message, specialCallback)
if messageBox then
messageBox:destroy()
messageBox = nil
end
	local okFunc = function() messageBox:destroy() messageBox = nil if specialCallback then openStoreWindow() end end
	messageBox = displayGeneralBox(title, message, {{text=tr('Ok'), callback=okFunc}, anchor=AnchorHorizontalCenter}, okFunc)
end
function check()
	sendAction("getPoints", nil)
	sendAction("getGender", nil)
	sendAction("getStoreData", nil)
	sendAction("getStoreUrl", nil)
	sendAction("getImagesUrl", nil)
end
function toggle()
  local widget = modules.game_interface.getNewUI():recursiveGetChildById('store')
	if window:isVisible() then
		window:hide()
		widget:setOn(false)
	else
		show()
		widget:setOn(true)
	end
end

function show() 
		-- Opcodes
		sendAction("getPoints", nil)
		sendAction("getGender", nil)
		
		-- The rest
		window:show()
		window:raise()
		window:focus()
end
