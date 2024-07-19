local exhaust_table = "EXP_POTION_PLAYERS_EXHAUST"

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

local ItemExp = Action()
function ItemExp.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	if not isInArray(check(player), item.uid) then
	   player:sendTextMessage(MESSAGE_STATUS_WARNING, "this item cannot be used from ground.")
	   player:getPosition():sendMagicEffect(CONST_ME_POFF)
	   return true
	end
	
    if not player:getTile():hasFlag(TILESTATE_PROTECTIONZONE) then
	   player:sendCancelMessage("You have to be in protection zone to use this item.")
	   return true
	end
	
	if dakosLib:getExhaust(exhaust_table, player) then
	   player:sendCancelMessage("You are exhausted. You have to wait: " ..dakosLib:getExhaustString(exhaust_table, player))
	   return true
	end
	
    if player:getLevel(cid) >= 300 then
       player:addExperience(6000000)
	   player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	   item:remove(1)
       player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You have received the 6M Exp!')
       dakosLib:setExhaust(exhaust_table, player, "hours", 1)
    else
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Only people higher level 300 can use it!')
    end
	
    return true
end

ItemExp:id(33928) -- the item is a scythe
ItemExp:register()