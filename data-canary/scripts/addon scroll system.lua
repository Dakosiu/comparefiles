ADDON_SCROLL_SYSTEM = {}
ADDON_SCROLL_SYSTEM.config = {
                               [1] = { 
							           name = "Veteran Paladin",
									   male = 1204,
									   female = 1205
									 },
								[2] = {
								        name = "Summoner",
										male = 133,
										female = 141
									  }
						     }

ADDON_SCROLL_SYSTEM.itemid = 10028
ADDON_SCROLL_SYSTEM.aid = 5007
ADDON_SCROLL_SYSTEM.customAttribute = {
                                        index = "ADDON_SCROLL_INDEX",
										addons = "ADDON_SCROLL_VALUE",
										name = "ADDON_SCROLL_NAME",
									  }


function ADDON_SCROLL_SYSTEM:getIndexByName(name)
    for i, v in ipairs(self.config) do
	    if v.name == name or v.name:lower() == name:lower() then
		   return i
		end
	end
	return false
end

function ADDON_SCROLL_SYSTEM:generateScroll(name, thing, addons)
    local item = Game.createItem(self.itemid, 1)
	if not item then
	   return false
	end
	item:setAttribute(ITEM_ATTRIBUTE_ACTIONID, self.aid)
	local index = ADDON_SCROLL_SYSTEM:getIndexByName(name) 
	item:setAttribute(ITEM_ATTRIBUTE_NAME, "Outfit Scroll")
	
	
	local str = ""
	name = name:lower()
	if addons == 0 then
	   str = str .. name .. " outfit."
	elseif addons == 1 then
	   str = str .. "first addon for " .. name .. " outfit."
	elseif addons == 2 then
	   str = str .. "second addon for " .. name .. " outfit."
	elseif addons == 3 then
	   str = str .. "full addon for " .. name .. " outfit."	   
	end
	
	item:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, str)
	item:setCustomAttribute(self.customAttribute.index, index)
	item:setCustomAttribute(self.customAttribute.addons, addons)
	item:setCustomAttribute(self.customAttribute.name, name)
	return item
end

function ADDON_SCROLL_SYSTEM:getDescription(item)
    if not item:getId() == self.itemid then
	   return false
	end
	
	local index = item:getCustomAttribute(self.customAttribute.index) 
	if not index then
	   return false
	end
	
	local name = self.config[index].name:lower()
	local addons = item:getCustomAttribute(self.customAttribute.addons) 
	local str = "It Contains: " .. "\n"
	if addons == 0 then
	   str = str .. name .. " outfit."
	elseif addons == 1 then
	   str = str .. "first addon for " .. name .. " outfit."
	elseif addons == 2 then
	   str = str .. "second addon for " .. name .. " outfit."
	elseif addons == 3 then
	   str = str .. "full addon for " .. name .. " outfit."	   
	end
	return str
end

local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    
	local index = item:getCustomAttribute(ADDON_SCROLL_SYSTEM.customAttribute.index)
	local t = ADDON_SCROLL_SYSTEM.config[index]
	local male = t.male
	local female = t.female
	local addons = item:getCustomAttribute(ADDON_SCROLL_SYSTEM.customAttribute.addons)
	local name = t.name
	
	if addons == 0 then
	   if player:hasOutfit(male) or player:hasOutfit(female) then
	      player:sendCancelMessage("Sorry, You have already this outfit.")
		  return true
	   end
	   
	elseif addons > 0 then    
	   if player:hasOutfit(male, addons) or player:hasOutfit(female, addons) then
	      player:sendCancelMessage("Sorry, You have already this addon for this outfit.")
		  return true
	   end
	end
    
	local str = "You have received "
	if addons == 0 then
	   str = str .. name .. " outfit."
	   player:addOutfit(male)
	   player:addOutfit(female)
	elseif addons == 1 then
	   str = str .. name .. " first addon."
	   player:addOutfitAddon(male, 1)
	   player:addOutfitAddon(female, 1)
	elseif addons == 2 then
	   str = str .. name .. " second addon."
	   player:addOutfitAddon(male, 2)
	   player:addOutfitAddon(female, 2)
	elseif addons == 3 then
 	   str = str .. name .. " full addon."
	   player:addOutfitAddon(male, 3)
	   player:addOutfitAddon(female, 3)      	
	end
	
	
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	player:sendTextMessage(MESSAGE_INFO_DESCR, str)
	item:remove()
    return true
end
action:aid(ADDON_SCROLL_SYSTEM.aid)
action:register()