local addonItemId = 8982
local outfits = {
	[1] = { ["Citizen"] = {136, 128} }, -- female, male
	[2] = { ["Hunter"] = {137, 129} },
	[3] = { ["Knight"] = {139, 131} },
	[4] = { ["Nobleman"] = {140, 132} },
	[5] = { ["Summoner"] = {141, 133} },
	[6] = { ["Warrior"] = {142, 134} },
	[7] = { ["Barbarian"] = {147, 143} },
	[8] = { ["Druid"] = {148, 144} },
	[9] = { ["Pirate"] = {155, 151} },
	[10] = { ["Assassin"] = {156, 152} },
	[11] = { ["Beggar"] = {157, 153} },
	[12] = { ["Shaman"] = {158, 154} },
	[13] = { ["Norseman"] = {252, 251} },
	[14] = { ["Nightmare"] = {269, 268} },
	[15] = { ["Jester"] = {270, 273} },
	[16] = { ["Brotherhood"] = {279, 278} },
	[17] = { ["Demon Hunter"] = {288, 289} },
	[18] = { ["Yalaharian"] = {324, 325} },
	[19] = { ["Newly Wed"] = {329, 328} },
	[20] = { ["Warmaster"] = {336, 335} },
	[21] = { ["Wayfarer"] = {366, 367} },
	[22] = { ["Afflicted"] = {431, 430} },
	[23] = { ["Elementalist"] = {433, 432} },
	[24] = { ["Deepling"] = {464, 463} },
	[25] = { ["Insectoid"] = {466, 465} },
	[26] = { ["Entrepreneur"] = {471, 472} },
	[27] = { ["Crystal Warlord"] = {513, 512} },
	[28] = { ["Soil Guardian"] = {514, 516} },
	[29] = { ["Demon Outfit"] = {542, 541} },
	[30] = { ["Cave Explorer"] = {575, 574} },
	[31] = { ["Dream Warden"] = {578, 577} },
	[32] = { ["Glooth Engineer"] = {618, 610} },
	[33] = { ["Jersey"] = {620, 619} },
	[34] = { ["Champion"] = {632, 633} },
	[35] = { ["Conjurer"] = {635, 634} },
	[36] = { ["Beastmaster"] = {636, 637} },
	[37] = { ["Chaos Acolyte"] = {664, 665} },
	[38] = { ["Death Herald"] = {666, 667} },
	[39] = { ["Ranger"] = {683, 684} },
	[40] = { ["Ceremonial Garb"] = {694, 695} },
	[41] = { ["Puppeteer"] = {696, 697} },
	[42] = { ["Spirit Caller"] = {698, 699} },
	[43] = { ["Evoker"] = {724, 725} },
	[44] = { ["Seaweaver"] = {732, 733} },
	[45] = { ["Recruiter"] = {745, 746} },
	[46] = { ["Sea Dog"] = {749, 750} },
	[47] = { ["Royal Pumpkin"] = {759, 760} },
	[48] = { ["Rift Warrior"] = {845, 846} },
	[49] = { ["Winter Warden"] = {852, 853} },
	[50] = { ["Philosopher"] = {874, 873} },
	[51] = { ["Arena Champion"] = {885, 884} },
	[52] = { ["Lupine Warden"] = {900, 899} },
	[53] = { ["Beast Slayer"] = {1445, 1444} },
	[54] = { ["Royal Blood"] = {1437, 1436} },
	[55] = { ["Ancient Dryad"] = {1416, 1415} },
	[56] = { ["Explorer"] = {1317, 1316} },
	[57] = { ["Brainwashed"] = {1252, 1251} }
}

local function check(player)

    local container = player:getSlotItem(CONST_SLOT_BACKPACK)
	
    local containers = {}
	
	local items = {}
	if container and container:isContainer() then
        table.insert(containers, container)
    end
    while #containers > 0 do
		for i = (containers[1]:getSize() - 1), 0, -1 do
			local it = containers[1]:getItem(i)
			if it:isContainer() then
                table.insert(containers, it)
			else
			    table.insert(items, it.uid)
            end
        end
        table.remove(containers, 1)
    end
    return items
end

local players = { }
local function findOutfitTable(index)
	for i = 1, #outfits do
	    for name, t in pairs(outfits[i]) do
		    if i == index then
			   local values = { ["Table"] = outfits[i][name], ["Outfit Name"] = name }
		       return values
			end
		end
	end
	return false
end

local function sendOutfitList(player)
   
   if not player then
      return nil
   end
   
   player:registerEvent("ModalWindow_outfits")
	  
   local title = "Addon Manager"
   local message = "Outfit List: "
   
   local window = ModalWindow(1201, title, message)
   window:addButton(100, "Select") 
   window:addButton(101, "Cancel")     
   window:setDefaultEnterButton(100)
   window:setDefaultEscapeButton(101)
   
   for i = 1, #outfits do
	   for name, t in pairs(outfits[i]) do
	       local selectOutfit = 0
	       local gender = player:getSex()
	       if gender == 1 then
		   selectOutfit = 2
		   else
		   selectOutfit = 1
		   end
		   
		   if player:hasOutfit(t[selectOutfit], 1) and player:hasOutfit(t[selectOutfit], 2) then
		      window:addChoice(i, "[x] " .. name)
		   else
		      window:addChoice(i, "[ ] " .. name)
		   end
	   end
   end
   return window:sendToPlayer(player)
 
end

local function getOutfitTable(player)

      if not player then
	  return nil
	  end
	  
	  local t = players[player:getId()]["Table"]
	  if not t then
	  return nil
	  end
	  
	  local gender = player:getSex()
	  
	  if gender == 1 then
	     return t[2]
	  else
	     return t[1]
	  end
	  
end

local function sendAddonList(player, id)
	  
	  player:registerEvent("ModalWindow_addonList")
	  local title = "Addon Manager"
	  local message = "Addon List: "
	  local window = ModalWindow(1202, title, message)
	  window:addButton(100, "Select") 
      window:addButton(101, "Cancel")
      window:setDefaultEnterButton(100)	  
      window:setDefaultEscapeButton(101)
	  
	  local outfit = getOutfitTable(player)
	  	  
	  if player:hasOutfit(outfit, 1) then
	     window:addChoice(1, "[x] First Addon")
	  else
	     window:addChoice(1, "[ ] First Addon")
	  end
	  
	  if player:hasOutfit(outfit, 2) then
	     window:addChoice(2, "[x] Second Addon")
	  else
	     window:addChoice(2, "[ ] Second Addon")
	  end

      return window:sendToPlayer(player)
end	  

local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    
	local pos = player:getPosition()
	if not isInArray(check(player), item.uid) then
	player:sendTextMessage(MESSAGE_STATUS_WARNING, "this item cannot be used from ground.")
	pos:sendMagicEffect(CONST_ME_POFF)
	return true
	end
    sendOutfitList(player)
	return true
end
action:id(addonItemId)
action:register()

local creaturescript = CreatureEvent("ModalWindow_outfits")
function creaturescript.onModalWindow(player, modalWindowId, buttonId, choiceId) 

		 if modalWindowId == 1201 then
			if buttonId == 101 then
			   return
			end
			
			if buttonId == 100 then	 
		       local t = findOutfitTable(choiceId)
		       local values = { ["Table"] = t["Table"], ["Outfit Name"] = t["Outfit Name"] }
		       players[player:getId()] = values
		       sendAddonList(player)
			end
		 
		 end
end
creaturescript:register()

local creaturescript = CreatureEvent("ModalWindow_addonList")
function creaturescript.onModalWindow(player, modalWindowId, buttonId, choiceId) 
         
		 player:unregisterEvent("ModalWindow_addonList")
		 
		 if modalWindowId == 1202 then
		 
	     if buttonId == 101 then
		    sendOutfitList(player)
		    return true
	     end
		 
		if buttonId == 100 then
		 
		--local outfit = getOutfitTable(player)
		local outfit = players[player:getId()]["Table"]
		local name = players[player:getId()]["Outfit Name"]
		if choiceId == 1 then
		
		   if player:hasOutfit(outfit[1], 1) or player:hasOutfit(outfit[2], 1) then
		      player:sendCancelMessage("You have already this addon.")
			  return true
		   end
		   
		   if not player:removeItem(addonItemId, 1) then
		      player:sendCancelMessage("You dont have required item.")
			  return true
		   end
		   
		   player:addOutfitAddon(outfit[1], 1)
		   player:addOutfitAddon(outfit[2], 1)
		   player:sendTextMessage(MESSAGE_INFO_DESCR, "Congratulations!, you got a first addon for " .. name:lower() .. ".")
		   
		elseif choiceId == 2 then
		
		   if player:hasOutfit(outfit[1], 2) or player:hasOutfit(outfit[2], 2) then
		      player:sendCancelMessage("You have already this addon.")
			  return true
		   end
		   
		   if not player:removeItem(addonItemId, 1) then
		      player:sendCancelMessage("You dont have required item.")
			  return true
		   end
		   
		   
		   player:addOutfitAddon(outfit[1], 2)
		   player:addOutfitAddon(outfit[2], 2)
		   player:sendTextMessage(MESSAGE_INFO_DESCR, "Congratulations!, you got a second addon for " .. name:lower() .. ".")
		
		end
		
		local pos = player:getPosition()
		pos:sendMagicEffect(CONST_ME_MAGIC_GREEN)
		
		
		end
		
		end

end
creaturescript:register()