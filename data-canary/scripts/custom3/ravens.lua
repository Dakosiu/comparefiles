RAVEN_SYSTEM_CONFIG = {
                        [1] = {
						        ["Position"] = { 932, 1112, 4 },
								["Coins"] = 5,
							  },
                        [2] = {
						        ["Position"] = { 931, 1112, 4 },
								["Coins"] = 10,
							  },
                        [3] = {
						        ["Position"] = { 930, 1112, 4 },
								["Coins"] = 15,
							  },
                       }


RAVEN_SYSTEM = {}
RAVEN_SYSTEM.attribute = "RAVEN_SYSTEM_INDEX"
RAVEN_SYSTEM.aid = 4331
RAVEN_SYSTEM.storages = {
                         exhaust = 10595,
                         usage = 20595,
                        }						 


function RAVEN_SYSTEM:prepare()
    
	local t = RAVEN_SYSTEM_CONFIG
	for i = 1, #t do
	    local posTable = t[i]["Position"]
		if posTable then
		   local pos = Position(posTable[1], posTable[2], posTable[3])
		   if pos then
		      local tile = Tile(pos)
			  if tile then
			     local items = tile:getItems()
				 if items and #items > 0 then
				    for _, item in pairs(items) do
					    item:setCustomAttribute(RAVEN_SYSTEM.attribute, i)
						item:setAttribute(ITEM_ATTRIBUTE_ACTIONID, RAVEN_SYSTEM.aid)
					end
				end
			  end
			end
		end
	end
end

function RAVEN_SYSTEM:getIndex(item)
	return item:getCustomAttribute(RAVEN_SYSTEM.attribute) or false
end

local globalevent = GlobalEvent("load_RAVEN_SYSTEM")
function globalevent.onStartup()
	RAVEN_SYSTEM:prepare()
end
globalevent:register()
	
	
	
local ravenAction = Action()

function ravenAction.onUse(player, item, fromPosition, itemEx, toPosition, isHotkey)
    
	local index = RAVEN_SYSTEM:getIndex(item)
	if not index then
	   return true
	end
	
	local t = RAVEN_SYSTEM_CONFIG[index]
	if not t then
	   return true
	end
	
	if player:getStorageValue(RAVEN_SYSTEM.storages.exhaust + index) > os.time() then 
	   return true
	end
	player:setStorageValue(RAVEN_SYSTEM.storages.exhaust + index, os.time() + 2)
	
	if player:getStorageValue(RAVEN_SYSTEM.storages.usage + index) ~= -1 or player:getAccountStorage(player:getAccountId(), RAVEN_SYSTEM.storages.usage + index) ~= false then
	   player:say("There's nothing more to do here.", TALKTYPE_MONSTER_SAY, false, nil, item:getPosition())
	   player:getPosition():sendMagicEffect(CONST_ME_POFF)
	   return true
	end
	
	local coins = t["Coins"]
	player:addTournamentCoinsBalance(coins, true)
	player:say("Here, take this " .. coins .. " tournament coins", TALKTYPE_MONSTER_SAY, false, nil, item:getPosition())
	player:getPosition():sendMagicEffect(CONST_ME_FIREAREA)
	player:setStorageValue(RAVEN_SYSTEM.storages.usage + index, 1)
	return true
end

ravenAction:aid(RAVEN_SYSTEM.aid)
ravenAction:register()