local config = {
                 [35450] = 6,
				 [35423] = 12,
				 [36442] = 24,
				 [35424] = 48
			   }


local action = Action()
local hour = 3600
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)    
	local value = config[item:getId()]
	if not value then
	   return true
	end
	
	
    local pos = player:getPosition()
    local skullTime = math.floor(player:getSkullTime() / hour)
	
	if player:getSkullTime() <= 0 or player:getSkullTime() < (hour * value) then
        pos:sendMagicEffect(CONST_ME_POFF)
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, "You have less than " .. value .. " hour frag time.")
        return true
    end
	
	
	player:setSkullTime(player:getSkullTime() - (value * hour))
    skullTime = math.floor(player:getSkullTime() / hour)
   
    if skullTime <= 0 then
       player:setSkullTime(1)
    end

    if player:getSkullTime() <= 1 then
        if player:getSkull() == SKULL_RED or SKULL_BLACK then
	       player:setSkull(0)
	    end
    end

    pos:sendMagicEffect(1)
    player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "You have decreased frag time.")
    item:remove(1)
return true
end

for i, v in pairs(config) do
    action:id(i)
end
action:register()