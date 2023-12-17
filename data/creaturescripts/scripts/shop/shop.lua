local SHOP_EXTENDED_OPCODE = 222
local SHOP_OFFERS = {}
local SHOP_CALLBACKS = {}
local SHOP_CATEGORIES = nil
local SHOP_BUY_URL = "https://awakeningots.online/awaken/" -- can be empty
local SHOP_AD = { -- can be nil
  image = "https://cdn.discordapp.com/attachments/1000399645714940054/1004777237578522744/market.png",
  url = "https://awakeningots.online/awaken/",
  text = "AwakenOT"
}
local MAX_PACKET_SIZE = 65500

function init()
  --  print(json.encode(g_game.getLocalPlayer():getOutfit())) -- in console in otclient, will print current outfit and mount

  SHOP_CATEGORIES = {}

  --[[ local category1 = addCategory({
    type = "item",
    item = ItemType(35969):getClientId(),
    count = 1,
    name = "Items"
  }) --]]
  local category1 = addCategory({
    type = "outfit",
    name = "Outfits",
    outfit = {
      mount = 0,
      feet = 114,
      legs = 114,
      body = 116,
      type = 1873,
      auxType = 0,
      addons = 1,
      head = 2,
      rotating = false
    }
  })
  local category2 = addCategory({
    type = "outfit",
    name = "Mounts",
    outfit = {
      mount = 0,
      feet = 114,
      legs = 114,
      body = 116,
      type = 392,
      auxType = 0,
      addons = 3,
      head = 2,
      rotating = false
    }
  })
  --[[ local category4 = addCategory({
    type = "item",
    item = ItemType(2471):getClientId(),
    count = 1,
    name = "Equipaments"
  }) --]]
  --[[ local category5 = addCategory({
    type = "image",
    image = "/data/images/game/states/electrified.png",
    name = "Buffs"
  }) --]]
  local category3 = addCategory({
    type = "outfit",
    name = "Auras",
    outfit = {
      mount = 0,
      feet = 114,
      legs = 114,
      body = 116,
      type = 1858,
      auxType = 0,
      addons = 3,
      head = 2,
      rotating = false
    }
  })
  local category4 = addCategory({
    type = "outfit",
    name = "Wings",
    outfit = {
      mount = 0,
      feet = 114,
      legs = 114,
      body = 116,
      type = 1851,
      auxType = 0,
      addons = 3,
      head = 2,
      rotating = false
    }
  })
  local category5 = addCategory({
    type = "outfit",
    name = "Shaders",
    outfit = {
      mount = 0,
      feet = 114,
      legs = 114,
      body = 116,
      type = 1874,
      auxType = 0,
      addons = 1,
      head = 2,
      rotating = false
    }
  })

  --! Items

  -- Price // ID // Quantity
  --category1.addItem(12, 35969, 100, "100  Warrior Coin", "A really rare coin used for a lot of trades")

  --! Outfits

  category1.addOutfit(25, {
    mount = 0,
    feet = 114,
    legs = 114,
    body = 116,
    type = 1947, --Barbarian Male
    typeF = 1948, --Barbarian Female
    auxType = 0,
    addons = 3,
    head = 2,
    rotating = true,
    mountID = 0,
  }, "Swordsman Outfit", "Buff: 1000HP + 1000MP + 0.1% Protection All + 0.2% Extra Healing.(Stackable)\nBuffs are applied when you are using any outfit with full addon")
  category1.addOutfit(25, {
    mount = 0,
    feet = 114,
    legs = 114,
    body = 116,
    type = 1939, --Knight Male
    typeF = 1940, --Knight Female
    auxType = 0,
    addons = 3,
    head = 2,
    rotating = true,
    mountID = 0,
  }, "Paladin Outfit", "Buff: 1000HP + 1000MP + 0.1% Protection All + 0.2% Extra Healing.(Stackable)\nBuffs are applied when you are using any outfit with full addon")
  category1.addOutfit(25, {
    mount = 0,
    feet = 114,
    legs = 114,
    body = 116,
    type = 1922,
    typeF = 1923,
    auxType = 0,
    addons = 3,
    head = 2,
    rotating = true,
    mountID = 0,
  }, "Warrior Outfit ", "Buff: 1000HP + 1000MP + 0.1% Protection All + 0.2% Extra Healing.(Stackable)\nBuffs are applied when you are using any outfit with full addon")
  category1.addOutfit(25, {
    mount = 0,
    feet = 20,
    legs = 40,
    body = 80,
    type = 1916,
    typeF = 1917,
    auxType = 0,
    addons = 3,
    head = 110,
    rotating = true,
    mountID = 0,
  }, "Climber Outfit ", "Buff: 1000HP + 1000MP + 0.1% Protection All + 0.2% Extra Healing.(Stackable)\nBuffs are applied when you are using any outfit with full addon")
  category1.addOutfit(25, {
    mount = 0,
    feet = 20,
    legs = 40,
    body = 80,
    type = 1909,
    typeF = 1910,
    auxType = 0,
    addons = 3,
    head = 110,
    rotating = true,
    mountID = 0,
  }, "Fireman Outfit ", "Buff: 1000HP + 1000MP + 0.1% Protection All + 0.2% Extra Healing.(Stackable)\nBuffs are applied when you are using any outfit with full addon")
  category1.addOutfit(25, {
    mount = 0,
    feet = 20,
    legs = 40,
    body = 80,
    type = 1872,
    typeF = 1873,
    auxType = 0,
    addons = 3,
    head = 110,
    rotating = true,
    mountID = 0,
  }, "Explorer Outfit ", "Buff: 1000HP + 1000MP + 0.1% Protection All + 0.2% Extra Healing.(Stackable)\nBuffs are applied when you are using any outfit with full addon")
  category1.addOutfit(25, {
    mount = 0,
    feet = 20,
    legs = 40,
    body = 80,
    type = 1371,
    typeF = 1372,
    auxType = 0,
    addons = 3,
    head = 110,
    rotating = true,
    mountID = 0,
  }, "Forest Outfit ", "Buff: 1000HP + 1000MP + 0.1% Protection All + 0.2% Extra Healing.(Stackable)\nBuffs are applied when you are using any outfit with full addon")
  category1.addOutfit(25, {
    mount = 0,
    feet = 20,
    legs = 40,
    body = 80,
    type = 1210,
    typeF = 1211,
    auxType = 0,
    addons = 3,
    head = 110,
    rotating = true,
    mountID = 0,
  }, "Golden Outfit ", "Buff: 1000HP + 1000MP + 0.1% Protection All + 0.2% Extra Healing.(Stackable)\nBuffs are applied when you are using any outfit with full addon")
  category1.addOutfit(25, {
    mount = 0,
    feet = 20,
    legs = 40,
    body = 80,
    type = 1243,
    typeF = 1244,
    auxType = 0,
    addons = 3,
    head = 110,
    rotating = true,
    mountID = 0,
  }, "Shimano Outfit ", "Buff: 1000HP + 1000MP + 0.1% Protection All + 0.2% Extra Healing.(Stackable)\nBuffs are applied when you are using any outfit with full addon")
  category1.addOutfit(25, {
    mount = 0,
    feet = 20,
    legs = 40,
    body = 80,
    type = 1202,
    typeF = 1203,
    auxType = 0,
    addons = 3,
    head = 110,
    rotating = true,
    mountID = 0,
  }, "Praman Outfit ", "Buff: 1000HP + 1000MP + 0.1% Protection All + 0.2% Extra Healing.(Stackable)\nBuffs are applied when you are using any outfit with full addon")
  category1.addOutfit(25, {
    mount = 0,
    feet = 20,
    legs = 40,
    body = 80,
    type = 1204,
    typeF = 1205,
    auxType = 0,
    addons = 3,
    head = 110,
    rotating = true,
    mountID = 0,
  }, "Exero Outfit ", "Buff: 1000HP + 1000MP + 0.1% Protection All + 0.2% Extra Healing.(Stackable)\nBuffs are applied when you are using any outfit with full addon")
  category1.addOutfit(25, {
    mount = 0,
    feet = 20,
    legs = 40,
    body = 80,
    type = 1384,
    typeF = 1385,
    auxType = 0,
    addons = 3,
    head = 110,
    rotating = true,
    mountID = 0,
  }, "Shumeric Outfit ", "Buff: 1000HP + 1000MP + 0.1% Protection All + 0.2% Extra Healing.(Stackable)\nBuffs are applied when you are using any outfit with full addon")

  --! Mounts

  category2.addOutfit(25, {
    mount = 0,
    feet = 0,
    legs = 0,
    body = 0,
    type = 1929,
    auxType = 0,
    addons = 0,
    head = 0,
    rotating = true,
    mountID = 116,
  }, "Fox Mount", "Each mount give 10 Speed Mount Bonus.(Stackable)\nOnly active when using a mount.")
  category2.addOutfit(25, {
    mount = 0,
    feet = 0,
    legs = 0,
    body = 0,
    type = 1913,
    auxType = 0,
    addons = 0,
    head = 0,
    rotating = true,
    mountID = 119,
  }, "War Horse", "Each mount give 10 Speed Mount Bonus.(Stackable)\nOnly active when using a mount.")
  category2.addOutfit(25, {
    mount = 0,
    feet = 0,
    legs = 0,
    body = 0,
    type = 1933,
    auxType = 0,
    addons = 0,
    head = 0,
    rotating = true,
    mountID = 113,
  }, "Leaf", "Each mount give 10 Speed Mount Bonus.(Stackable)\nOnly active when using a mount.")
  category2.addOutfit(25, {
    mount = 0,
    feet = 0,
    legs = 0,
    body = 0,
    type = 1936,
    auxType = 0,
    addons = 0,
    head = 0,
    rotating = true,
    mountID = 110,
  }, "Dragon", "Each mount give 10 Speed Mount Bonus.(Stackable)\nOnly active when using a mount.")
  category2.addOutfit(25, {
    mount = 0,
    feet = 0,
    legs = 0,
    body = 0,
    type = 1941,
    auxType = 0,
    addons = 0,
    head = 0,
    rotating = true,
    mountID = 107,
  }, "Bird", "Each mount give 10 Speed Mount Bonus.(Stackable)\nOnly active when using a mount.")
  category2.addOutfit(25, {
    mount = 0,
    feet = 0,
    legs = 0,
    body = 0,
    type = 1944,
    auxType = 0,
    addons = 0,
    head = 0,
    rotating = true,
    mountID = 104,
  }, "Thing", "Each mount give 10 Speed Mount Bonus.(Stackable)\nOnly active when using a mount.")
  category2.addOutfit(25, {
    mount = 0,
    feet = 0,
    legs = 0,
    body = 0,
    type = 902,
    auxType = 0,
    addons = 0,
    head = 0,
    rotating = true,
    mountID = 101,
  }, "Shadow Claw", "Each mount give 10 Speed Mount Bonus.(Stackable)\nOnly active when using a mount.")
  category2.addOutfit(25, {
    mount = 0,
    feet = 0,
    legs = 0,
    body = 0,
    type = 903,
    auxType = 0,
    addons = 0,
    head = 0,
    rotating = true,
    mountID = 102,
  }, "Snow Pelt", "Each mount give 10 Speed Mount Bonus.(Stackable)\nOnly active when using a mount.")
  category2.addOutfit(25, {
    mount = 0,
    feet = 0,
    legs = 0,
    body = 0,
    type = 901,
    auxType = 0,
    addons = 0,
    head = 0,
    rotating = true,
    mountID = 100,
  }, "Ivory Fang", "Each mount give 10 Speed Mount Bonus.(Stackable)\nOnly active when using a mount.")

  --! Equipaments

  --[[ category4.addItem(4, 2514, 1, "Mastermind Shield", "Rare Shield\nDef: 37\nBoost your early game.")
  category4.addItem(25, 41542, 1, "Water Sword", "Good Sword\nDamage: +8000\nBoost your early game.")
  category4.addItem(25, 41545, 1, "Gods Ring",
    "Its a God Item\nYou can buy it\nBuy can only use if u already killed enough Gods")
  category4.addItem(25, 41546, 1, "Gods Amulet",
    "Its a God Item\nYou can buy it\nBuy can only use if u already killed enough Gods") --]]

  --! Spells // Buffs

  --[[ category5.addImage(8, "http://otclient.ovh/images/freezing.png", "999x Buff Exp",
    "Increase Exp Rate\nGet a lot of levels fast")
  category5.addImage(8, "/data/images/game/states/slowed.png", "999x Loot Exp",
    "Increase Loot Chance\nGet a lot of better Loots") --]]

  --! Auras

  category3.addOutfit(120, {
    mount = 0,
    feet = 114,
    legs = 114,
    body = 116,
    type = 1864,
    auxType = 0,
    addons = 3,
    head = 2,
    rotating = false,
    auraID = 10,
    -- Title -- Body
  }, "Aura", "No buffs for now.\nOnly Cosmetic.")
  category3.addOutfit(120, {
    mount = 0,
    feet = 114,
    legs = 114,
    body = 116,
    type = 1833,
    auxType = 0,
    addons = 3,
    head = 2,
    rotating = false,
    auraID = 3,
    -- Title -- Body
  }, "Aura", "No buffs for now.\nOnly Cosmetic.")
  category3.addOutfit(120, {
    mount = 0,
    feet = 114,
    legs = 114,
    body = 116,
    type = 1866,
    auxType = 0,
    addons = 3,
    head = 2,
    rotating = false,
    auraID = 12,
    -- Title -- Body
  }, "Aura", "No buffs for now.\nOnly Cosmetic.")
  category3.addOutfit(120, {
    mount = 0,
    feet = 114,
    legs = 114,
    body = 116,
    type = 1858,
    auxType = 0,
    addons = 3,
    head = 2,
    rotating = false,
    auraID = 4,
    -- Title -- Body
  }, "Aura", "No buffs for now.\nOnly Cosmetic.")
  category3.addOutfit(120, {
    mount = 0,
    feet = 114,
    legs = 114,
    body = 116,
    type = 1859,
    auxType = 0,
    addons = 3,
    head = 2,
    rotating = false,
    auraID = 5,
    -- Title -- Body
  }, "Aura", "No buffs for now.\nOnly Cosmetic.")
  category3.addOutfit(120, {
    mount = 0,
    feet = 114,
    legs = 114,
    body = 116,
    type = 1860,
    auxType = 0,
    addons = 3,
    head = 2,
    rotating = false,
    auraID = 6,
    -- Title -- Body
  }, "Aura", "No buffs for now.\nOnly Cosmetic.")
  category3.addOutfit(120, {
    mount = 0,
    feet = 114,
    legs = 114,
    body = 116,
    type = 1861,
    auxType = 0,
    addons = 3,
    head = 2,
    rotating = false,
    auraID = 7,
    -- Title -- Body
  }, "Aura", "No buffs for now.\nOnly Cosmetic.")
  category3.addOutfit(120, {
    mount = 0,
    feet = 114,
    legs = 114,
    body = 116,
    type = 1862,
    auxType = 0,
    addons = 3,
    head = 2,
    rotating = false,
    auraID = 8,
    -- Title -- Body
  }, "Aura", "No buffs for now.\nOnly Cosmetic.")
  category3.addOutfit(120, {
    mount = 0,
    feet = 114,
    legs = 114,
    body = 116,
    type = 1863,
    auxType = 0,
    addons = 3,
    head = 2,
    rotating = false,
    auraID = 9,
    -- Title -- Body
  }, "Aura", "No buffs for now.\nOnly Cosmetic.")

  --! Wings

  category4.addOutfit(120, {
    mount = 0,
    feet = 114,
    legs = 114,
    body = 116,
    type = 1834,
    auxType = 0,
    addons = 3,
    head = 2,
    rotating = false,
    wingID = 3,
  }, "Normal Wings", "No buffs for now.\nOnly Cosmetic.") --
  category4.addOutfit(120, {
    mount = 0,
    feet = 114,
    legs = 114,
    body = 116,
    type = 1854,
    auxType = 0,
    addons = 3,
    head = 2,
    rotating = false,
    wingID = 23,
  }, "Dark Wings", "No buffs for now.\nOnly Cosmetic.")
  category4.addOutfit(120, {
    mount = 0,
    feet = 114,
    legs = 114,
    body = 116,
    type = 1856,
    auxType = 0,
    addons = 3,
    head = 2,
    rotating = false,
    wingID = 25,
  }, "Hellfire Wings", "No buffs for now.\nOnly Cosmetic.") 
  category4.addOutfit(120, {
    mount = 0,
    feet = 114,
    legs = 114,
    body = 116,
    type = 1830,
    auxType = 0,
    addons = 3,
    head = 2,
    rotating = false,
    wingID = 27,
  }, "Butterfly Wings", "No buffs for now.\nOnly Cosmetic.") 

  --! Shaders

  category5.addOutfit(200, {
    mount = 0,
    feet = 114,
    legs = 114,
    body = 116,
    type = 1864,
    auxType = 0,
    addons = 3,
    head = 2,
    rotating = false,
    shaderID = 1,
  }, "Rainbow Shader", "no Buffs for now.\nOnly Cosmetic.")
  category5.addOutfit(200, {
    mount = 0,
    feet = 114,
    legs = 114,
    body = 116,
    type = 1864,
    auxType = 0,
    addons = 3,
    head = 2,
    rotating = false,
    shaderID = 2,
  }, "Glitch Shader", "no Buffs for now.\nOnly Cosmetic.")
  category5.addOutfit(200, {
    mount = 0,
    feet = 114,
    legs = 114,
    body = 116,
    type = 1864,
    auxType = 0,
    addons = 3,
    head = 2,
    rotating = false,
    shaderID = 3,
  }, "Blue Galaxy Shader", "no Buffs for now.\nOnly Cosmetic.")
  category5.addOutfit(200, {
    mount = 0,
    feet = 114,
    legs = 114,
    body = 116,
    type = 1864,
    auxType = 0,
    addons = 3,
    head = 2,
    rotating = false,
    shaderID = 4,
  }, "Galaxy Shader", "no Buffs for now.\nOnly Cosmetic.")
  category5.addOutfit(200, {
    mount = 0,
    feet = 114,
    legs = 114,
    body = 116,
    type = 1864,
    auxType = 0,
    addons = 3,
    head = 2,
    rotating = false,
    shaderID = 5,
  }, "Brazil Shader", "no Buffs for now.\nOnly Cosmetic.")
  category5.addOutfit(200, {
    mount = 0,
    feet = 114,
    legs = 114,
    body = 116,
    type = 1864,
    auxType = 0,
    addons = 3,
    head = 2,
    rotating = false,
    shaderID = 6,
  }, "Lithuania Shader", "no Buffs for now.\nOnly Cosmetic.")
  category5.addOutfit(200, {
    mount = 0,
    feet = 114,
    legs = 114,
    body = 116,
    type = 1864,
    auxType = 0,
    addons = 3,
    head = 2,
    rotating = false,
    shaderID =8,
  }, "Pulse Shader", "no Buffs for now.\nOnly Cosmetic.")
  category5.addOutfit(200, {
    mount = 0,
    feet = 114,
    legs = 114,
    body = 116,
    type = 1864,
    auxType = 0,
    addons = 3,
    head = 2,
    rotating = false,
    shaderID =10,
  }, "Stars Shader", "no Buffs for now.\nOnly Cosmetic.")
  category5.addOutfit(200, {
    mount = 0,
    feet = 114,
    legs = 114,
    body = 116,
    type = 1864,
    auxType = 0,
    addons = 3,
    head = 2,
    rotating = false,
    shaderID =12,
  }, "Sweden Shader", "no Buffs for now.\nOnly Cosmetic.")
  category5.addOutfit(200, {
    mount = 0,
    feet = 114,
    legs = 114,
    body = 116,
    type = 1864,
    auxType = 0,
    addons = 3,
    head = 2,
    rotating = false,
    shaderID =14,
  }, "Night Shader", "no Buffs for now.\nOnly Cosmetic.")

end

function addCategory(data)
  data['offers'] = {}
  table.insert(SHOP_CATEGORIES, data)
  table.insert(SHOP_CALLBACKS, {})
  local index = #SHOP_CATEGORIES
  return {
    addItem = function(cost, itemId, count, title, description, callback)
      if not callback then
        callback = defaultItemBuyAction
      end
      table.insert(SHOP_CATEGORIES[index]['offers'], {
        cost = cost,
        type = "item",
        item = ItemType(itemId):getClientId(), -- displayed
        itemId = itemId,
        count = count,
        title = title,
        description = description
      })
      table.insert(SHOP_CALLBACKS[index], callback)
    end,
    addOutfit = function(cost, outfit, title, description, mountID, wingID, auraID, shaderID, callback)
      if not callback then
        callback = defaultOutfitBuyAction
      end
      table.insert(SHOP_CATEGORIES[index]['offers'], {
        cost = cost,
        type = "outfit",
        typeF = "outfit",
        outfit = outfit,
        outfitF = outfit,
        title = title,
        description = description,
        mountID = mountID,
        wingID = wingID,
        auraID = auraID,
        shaderID = shaderID
      })
      table.insert(SHOP_CALLBACKS[index], callback)
    end,
    addImage = function(cost, image, title, description, callback)
      if not callback then
        callback = defaultImageBuyAction
      end
      table.insert(SHOP_CATEGORIES[index]['offers'], {
        cost = cost,
        type = "image",
        image = image,
        title = title,
        description = description
      })
      table.insert(SHOP_CALLBACKS[index], callback)
    end
  }
end

function getPoints(player)
  local points = 0
  local resultId = db.storeQuery("SELECT `premium_points` FROM `accounts` WHERE `id` = " .. player:getAccountId())
  if resultId ~= false then
    points = result.getDataInt(resultId, "premium_points")
    result.free(resultId)
  end
  return points
end

function getStatus(player)
  local status = {
    ad = SHOP_AD,
    points = getPoints(player),
    buyUrl = SHOP_BUY_URL
  }
  return status
end

function sendJSON(player, action, data, forceStatus)
  local status = nil
  if not player:getStorageValue(1150001) or player:getStorageValue(1150001) + 10 < os.time() or forceStatus then
    status = getStatus(player)
  end
  player:setStorageValue(1150001, os.time())


  local buffer = json.encode({ action = action, data = data, status = status })
  local s = {}
  for i = 1, #buffer, MAX_PACKET_SIZE do
    s[#s + 1] = buffer:sub(i, i + MAX_PACKET_SIZE - 1)
  end
  local msg = NetworkMessage()
  if #s == 1 then
    msg:addByte(50)
    msg:addByte(SHOP_EXTENDED_OPCODE)
    msg:addString(s[1])
    msg:sendToPlayer(player)
    return
  end
  -- split message if too big
  msg:addByte(50)
  msg:addByte(SHOP_EXTENDED_OPCODE)
  msg:addString("S" .. s[1])
  msg:sendToPlayer(player) --
  for i = 2, #s - 1 do
    msg = NetworkMessage()
    msg:addByte(50)
    msg:addByte(SHOP_EXTENDED_OPCODE)
    msg:addString("P" .. s[i])
    msg:sendToPlayer(player)
  end
  msg = NetworkMessage()
  msg:addByte(50)
  msg:addByte(SHOP_EXTENDED_OPCODE)
  msg:addString("E" .. s[#s])
  msg:sendToPlayer(player)
end

function sendMessage(player, title, msg, forceStatus)
  sendJSON(player, "message", { title = title, msg = msg }, forceStatus)
end

function onExtendedOpcode(player, opcode, buffer)
  --print('data/creaturescripts/scripts/shop/shop.lua')
  if opcode ~= SHOP_EXTENDED_OPCODE then
    return false
  end
  local status, json_data = pcall(function() return json.decode(buffer) end)
  if not status then
    return false
  end

  local action = json_data['action']
  local data = json_data['data']
  if not action or not data then
    return false
  end

  if SHOP_CATEGORIES == nil then
    init()
  end

  if action == 'init' then
    sendJSON(player, "categories", SHOP_CATEGORIES)
  elseif action == 'buy' then
    processBuy(player, data)
  elseif action == "history" then
    sendHistory(player)
  end
  return true
end

function processBuy(player, data)
  local categoryId = tonumber(data["category"])
  local offerId = tonumber(data["offer"])
  local offer = SHOP_CATEGORIES[categoryId]['offers'][offerId]
  local callback = SHOP_CALLBACKS[categoryId][offerId]
  if not offer or not callback or data["title"] ~= offer["title"] or data["cost"] ~= offer["cost"] then
    sendJSON(player, "categories", SHOP_CATEGORIES) -- refresh categories, maybe invalid
    return sendMessage(player, "Error!", "Invalid offer")
  end
  local points = getPoints(player)
  if not offer['cost'] or offer['cost'] > points or points < 1 then
    return sendMessage(player, "Error!", "You don't have enough points to buy " .. offer['title'] .. "!", true)
  end
  local status = callback(player, offer)
  if status == true then
    db.query("UPDATE `accounts` set `premium_points` = `premium_points` - " ..
      offer['cost'] .. " WHERE `id` = " .. player:getAccountId())
    --[[ db.asyncQuery("INSERT INTO `shop_history` (`account`, `player`, `date`, `title`, `cost`, `details`) VALUES ('" ..
      player:getAccountId() ..
      "', '" ..
      player:getGuid() ..
      "', NOW(), " ..
      db.escapeString(offer['title']) ..
      ", " .. db.escapeString(offer['cost']) .. ", " .. db.escapeString(json.encode(offer)) .. ")") --]]
    return sendMessage(player, "Success!", "You bought " .. offer['title'] .. "!", true)
  end
  if status == nil or status == false then
    status = "Unknown error while buying " .. offer['title']
  end
  sendMessage(player, "Error!", status)
end

function sendHistory(player)
  if player:getStorageValue(1150002) and player:getStorageValue(1150002) + 10 > os.time() then
    return -- min 10s delay
  end
  player:setStorageValue(1150002, os.time())

  local history = {}
  local resultId = db.storeQuery("SELECT * FROM `shop_history` WHERE `account` = " ..
    player:getAccountId() .. " order by `id` DESC")

  if resultId ~= false then
    repeat
      local details = result.getDataString(resultId, "details")
      local status, json_data = pcall(function() return json.decode(details) end)
      if not status then
        json_data = {
          type = "image",
          title = result.getDataString(resultId, "title"),
          cost = result.getDataInt(resultId, "cost")
        }
      end
      table.insert(history, json_data)
      history[#history]["description"] = "Bought on " ..
          result.getDataString(resultId, "date") .. " for " .. result.getDataInt(resultId, "cost") .. " points."
    until not result.next(resultId)
    result.free(resultId)
  end

  sendJSON(player, "history", history)
end

-- BUY CALLBACKS
-- May be useful: print(json.encode(offer))

function defaultItemBuyAction(player, offer)
  -- todo: check if has capacity
  if player:addItem(offer["itemId"], offer["count"], false) then
    return true
  end
  return "Can't add item! Do you have enough space?"
end

function defaultOutfitBuyAction(player, offer)
  if offer["outfit"].mountID ~= 0 and offer["outfit"].mountID ~= nil then
    player:addMount(offer["outfit"].mountID)
    return true
  end
  
  if offer["outfit"].auraID ~= 0 and offer["outfit"].auraID  ~= nil then
    player:addAura(offer["outfit"].auraID)
    return true
  end
  
  if offer["outfit"].wingID ~= 0 and offer["outfit"].wingID  ~= nil then
    player:addWing(offer["outfit"].wingID)
    return true
  end
  
  if offer["outfit"].shaderID ~= 0 and offer["outfit"].shaderID  ~= nil then
    player:addShader(offer["outfit"].shaderID)
    return true
  end
  if player:addOutfit(offer["outfit"].type) or player:addOutfitAddon(offer["outfit"].typeF, 3) then
    player:addOutfitAddon(offer["outfit"].type, 3)
    player:addOutfitAddon(offer["outfit"].typeF, 3)
    return true
  end

  return "Error Outfit"
end

function defaultImageBuyAction(player, offer)
  return "default image buy action is not implemented"
end

function customImageBuyAction(player, offer)
  return "custom image buy action is not implemented. Offer: " .. offer['title']
end
