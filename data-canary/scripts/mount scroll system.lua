MOUNT_SCROLL_SYSTEM = {}
MOUNT_SCROLL_SYSTEM.config = {
                                {name = "Widow Queen", id = 1},
                                {name = "Racing Bird", id = 2},
                                {name = "War Bear", id = 3},
                                {name = "Black Sheep", id = 4},
                                {name = "Titanica", id = 7},
                                {name = "Tin Lizzard", id = 8},
                                {name = "Rapid Boar", id = 10},
                                {name = "Stampor", id = 11},
                                {name = "Donkey", id = 13},
                                {name = "Tiger Slug", id = 14},
                                {name = "Uniwheel", id = 15},
                                {name = "War Horse", id = 17},
                                {name = "Kingly Deer", id = 18},
                                {name = "Tamed Panda", id = 19},
                                {name = "Dromedary", id = 20},
                                {name = "Scorpion King", id = 21},
                                {name = "Rented Horse", id = 22},
                                {name = "Rented Horse Gray", id = 25},
                                {name = "Rented Horse Brown", id = 26},
                                {name = "Water Buffalo", id = 35},
                                {name = "Neon Sparkid", id = 98},
                                {name = "Cold Percht Sleigh", id = 132},
                                {name = "Bright Percht Sleigh", id = 133},
                                {name = "Dark Percht Sleigh", id = 134},
                                {name = "Cold Percht Sleigh Variant", id = 147},
                                {name = "Bright Percht Sleigh Variant", id = 148},
                                {name = "Dark Percht Sleigh Variant", id = 149},
                                {name = "Cold Percht Sleigh Final", id = 150},
                                {name = "Bright Percht Sleigh Final", id = 151},
                                {name = "Dark Percht Sleigh Final", id = 152}
						     }

MOUNT_SCROLL_SYSTEM.itemid = 10028
MOUNT_SCROLL_SYSTEM.aid = 5208
MOUNT_SCROLL_SYSTEM.customAttribute = {
                                        index = "MOUNT_SCROLL_INDEX",
										name = "MOUNT_SCROLL_NAME",
									  }


function MOUNT_SCROLL_SYSTEM:getTableByName(name)
    for i, v in ipairs(self.config) do
	    if v.name == name or v.name:lower() == name:lower() then
		   return v
		end
	end
	return false
end

function MOUNT_SCROLL_SYSTEM:generateScroll(name)
    local item = Game.createItem(self.itemid, 1)
	if not item then
	   return false
	end
	item:setAttribute(ITEM_ATTRIBUTE_ACTIONID, self.aid)
	--local index = MOUNT_SCROLL_SYSTEM:getIndexByName(name) 
	item:setAttribute(ITEM_ATTRIBUTE_NAME, "Mount Scroll")
	
	
	local str = name .. " mount."	
	item:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, str)
	--item:setCustomAttribute(self.customAttribute.index, index)
	item:setCustomAttribute(self.customAttribute.name, name)
	return item
end

function MOUNT_SCROLL_SYSTEM:getDescription(item)
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
	   str = str .. name .. " mount."
	end
	return str
end

local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local name = item:getCustomAttribute(MOUNT_SCROLL_SYSTEM.customAttribute.name)
	local t =  MOUNT_SCROLL_SYSTEM:getTableByName(name)
	if not t then
	    print("Table for " .. name .. " mount not exsists (data-canary/scripts/mount scroll system.lua)")
		return false
	end
	local id = t.id
	
	if player:hasMount(id) then
	    player:sendCancelMessage("Sorry, You have already this mount.")
	    return true
	end
    
	local str = "You have received " .. name .. " mount."
	player:addMount(id)
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	player:sendTextMessage(MESSAGE_INFO_DESCR, str)
	item:remove()
    return true
end
action:aid(MOUNT_SCROLL_SYSTEM.aid)
action:register()