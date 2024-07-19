FRAG_REMOVER_CONFIG = {
                        [37335] = {
						            _removeSkulls = true,
									_removeFrags = true,
								    exhaust = { type = "minutes", value = 2 },
									skullList = { SKULL_RED, SKULL_BLACK }
								  }
					  }

local exhaust_key = "FRAG_REMOVER_EXHAUST"					  

local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    
	local t = FRAG_REMOVER_CONFIG[item:getId()]
	if not t then
	   return true
	end
		
	local tile = Tile(player:getPosition()):hasFlag(TILESTATE_PROTECTIONZONE)
    if not tile then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You must be in protection zone to use this item.")
        return true
    end
	
	if #player:getKills() < 1 then
	   player:sendTextMessage(MESSAGE_STATUS_WARNING, "You dont have any frag to remove.")
	   return true
	end
	-- if player:getSkull() == 0 then
	   -- player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You dont have any skull to remove.")
	   -- return true
	-- end
	   
	-- if not isInArray(t.skullList, player:getSkull()) then
	   -- player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You can't remove this skull with this remover.")
	   -- return true
	-- end
	
	local key = exhaust_key .. item:getId()
	if dakosLib:getExhaust(key, player) then
	   player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You are exhausted. You have to wait: " .. dakosLib:getExhaustString(key, player))
	   return true
	end
	
	dakosLib:setExhaust(key, player, t.exhaust.type, t.exhaust.value)

	
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have removed all your frags.")
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	item:remove(1)
	if t._removeFrags then
	   player:setKills({})
	end
	player:setSkullTime(0)
	if t._removeSkulls then
	   player:setSkull(SKULL_NONE)
	end
	
	-- if t._removeFrags then
	   -- local name = player:getName()
	   -- local id = player:getGuid()
	   -- player:remove()
	   -- db.query("UPDATE player_deaths SET unjustified = 0 WHERE unjustified = 1 AND killed_by = " .. db.escapeString(name))

	   -- addEvent(db.query, 10, "DELETE FROM `player_kills` WHERE `player_id` = " .. id)
	   -- player:setSkullTime(0)
	-- end
	


return true
end

for i, v in pairs(FRAG_REMOVER_CONFIG) do
    action:id(i)
end
action:register()					  

local talkaction = TalkAction("!frags", "!kills")
function talkaction.onSay(player, words, param)

	local fragTime = configManager.getNumber(configKeys.FRAG_TIME)
	if fragTime <= 0 then
		player:sendTextMessage(MESSAGE_STATUS_WARNING, "You do not have any unjustified kill.")
		return false
	end

	local skullTime = player:getSkullTime()
	
	if skullTime <= 0 then
		player:sendTextMessage(MESSAGE_STATUS_WARNING, "You do not have any unjustified kill.")
		return false
	end

	local kills = #player:getKills() --math.ceil(skullTime / fragTime)
	local remainingSeconds = math.floor(skullTime % fragTime)

	local hours = math.floor(remainingSeconds / 3600)
	local minutes = math.floor((remainingSeconds % 3600) / 60)
	local seconds = remainingSeconds % 60

	local message = "You have " .. kills .. " unjustified kill" .. (kills > 1 and "s" or "") .. ". The amount of unjustified kills will decrease after: "
	if hours ~= 0 then
		if hours == 1 then
			message = message .. hours .. " hour, "
		else
			message = message .. hours .. " hours, "
		end
	end

	if hours ~= 0 or minutes ~= 0 then
		if minutes == 1 then
			message = message .. minutes .. " minute and "
		else
			message = message .. minutes .. " minutes and "
		end
	end

	if seconds == 1 then
		message = message .. seconds .. " second."
	else
		message = message .. seconds .. " seconds."
	end

	player:sendTextMessage(MESSAGE_STATUS_WARNING, message)
	return false
end
talkaction:register()
