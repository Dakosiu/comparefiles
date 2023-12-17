REGENERATION_CONFIG = {
                        [7009] =   {
								     addExtraHealthRegenerationPoints = 1,
								     addExtraManaRegenerationPoints = 1,
								   },
                        [7008] =   {
								     addExtraHealthRegenerationPoints = 1,
								     addExtraManaRegenerationPoints = 1,
								   },
                        [7007] =   {
								     addExtraHealthRegenerationPoints = 1, --- 100 lvl free quests
								     addExtraManaRegenerationPoints = 1,
								   },
                        [7006] =   {
								     addExtraHealthRegenerationPoints = 1, --- 220 lvl free quests
								     addExtraManaRegenerationPoints = 1,
								   },
                        [7005] =   {
								     addExtraHealthRegenerationPoints = 2, --- 720 lvl quests in quest room/inside tp
								     addExtraManaRegenerationPoints = 2,
								   },
                        [7004] =   {
								     addExtraHealthRegenerationPoints = 2,
								     addExtraManaRegenerationPoints = 2,
								   },
                        [7003] =   {
								     addExtraHealthRegenerationPoints = 2,
								     addExtraManaRegenerationPoints = 2,
								   },
                        [7002] =   {
								     addExtraHealthRegenerationPoints = 1,
								     addExtraManaRegenerationPoints = 1,
								   },
                        [7001] =   {
								     addExtraHealthRegenerationPoints = 1,
								     addExtraManaRegenerationPoints = 1,
								   },
                        [7000] =   {
								     addExtraHealthRegenerationPoints = 1,
								     addExtraManaRegenerationPoints = 1,
								   },
					    [6744] = {
									 addExtraHealthRegenerationPoints = 1,
									 addExtraManaRegenerationPoints = 1,
								   },
					    [6745] = {
									 addExtraHealthRegenerationPoints = 1,
									 addExtraManaRegenerationPoints = 1,
								   },
					    [6746] = {
									 addExtraHealthRegenerationPoints = 1,
									 addExtraManaRegenerationPoints = 1,
								   },
					    [6747] = {
									 addExtraHealthRegenerationPoints = 1,
									 addExtraManaRegenerationPoints = 1,
								   },
					    [6748] = {
									 addExtraHealthRegenerationPoints = 1,
									 addExtraManaRegenerationPoints = 1,
								   },
					    [6749] = {
									 addExtraHealthRegenerationPoints = 1,
									 addExtraManaRegenerationPoints = 1,
								   },
					    [6750] = {
									 addExtraHealthRegenerationPoints = 1,
									 addExtraManaRegenerationPoints = 1,
								   },
					    [6751] = {
									 addExtraHealthRegenerationPoints = 1,
									 addExtraManaRegenerationPoints = 1,
								   },
					    [6752] = {
									 addExtraHealthRegenerationPoints = 1,
									 addExtraManaRegenerationPoints = 1,
								   },
					    [6753] = {
									 addExtraHealthRegenerationPoints = 1,
									 addExtraManaRegenerationPoints = 1,
								   },
					    [6754] = {
									 addExtraHealthRegenerationPoints = 1,
									 addExtraManaRegenerationPoints = 1,
								   },
					    [6755] = {
									 addExtraHealthRegenerationPoints = 1,
									 addExtraManaRegenerationPoints = 1,
								   },
					    [6756] = {
									 addExtraHealthRegenerationPoints = 1,
									 addExtraManaRegenerationPoints = 1,
								   },
					    [6757] = {
									 addExtraHealthRegenerationPoints = 1,
									 addExtraManaRegenerationPoints = 1,
								   },
					    [6758] = {
									 addExtraHealthRegenerationPoints = 1,
									 addExtraManaRegenerationPoints = 1,
								   },
					    [6759] = {
									 addExtraHealthRegenerationPoints = 1,
									 addExtraManaRegenerationPoints = 1,
								   },
					    [6760] = {
									 addExtraHealthRegenerationPoints = 1,
									 addExtraManaRegenerationPoints = 1,
								   },
					    [6761] = {
									 addExtraHealthRegenerationPoints = 1,
									 addExtraManaRegenerationPoints = 1,
								   },
					    [6762] = {
									 addExtraHealthRegenerationPoints = 1,
									 addExtraManaRegenerationPoints = 1,
								   },
					    [6763] = {
									 addExtraHealthRegenerationPoints = 1,
									 addExtraManaRegenerationPoints = 1,
								   },
					    [6764] = {
									 addExtraHealthRegenerationPoints = 1,
									 addExtraManaRegenerationPoints = 1,
								   },
					    [6765] = {
									 addExtraHealthRegenerationPoints = 1,
									 addExtraManaRegenerationPoints = 1,
								   },
					    [6766] = {
									 addExtraHealthRegenerationPoints = 1,
									 addExtraManaRegenerationPoints = 1,
								   },
					    [6767] = {
									 addExtraHealthRegenerationPoints = 1,
									 addExtraManaRegenerationPoints = 1,
								   },
					    [6768] = {
									 addExtraHealthRegenerationPoints = 1,
									 addExtraManaRegenerationPoints = 1,
								   },
					  }
					  
EXTRA_INCREASE_HEALTH_STORAGE = 1343353							   
for index, v in pairs(REGENERATION_CONFIG) do
    v.storage = EXTRA_INCREASE_HEALTH_STORAGE + index
end
								 
local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    	
	local v = REGENERATION_CONFIG[item:getUniqueId()]
	
	if not v then
	   return true
	end
	
	if player:getStorageValue(v.storage) >= 1 then
	   player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "You can't use this item anymore.")
	   player:getPosition():sendMagicEffect(3)
	   return true
	end
	
	local hp = v.addExtraHealthRegenerationPoints
	local mp = v.addExtraManaRegenerationPoints
	
	player:addHealthRegeneratePoint(hp)
	player:addManaRegeneratePoint(mp)
	player:getPosition():sendMagicEffect(357)
	
	local hp_value = hp * HEALTH_REGENERATION_CONFIG.value
	local mp_value = mp * MANA_REGENERATION_CONFIG.value
	
	player:sendTextMessage(MESSAGE_INFO_DESCR, "Your Health Regenerate 1/s has been increase by " .. hp_value .. "." .. "\n" .. "Your Mana Regenerate 2/s has been increase by " .. mp_value .. ".")
	player:setStorageValue(v.storage, 1)
	
    return true
end

for id, v in pairs(REGENERATION_CONFIG) do
action:uid(id)
end
action:register()				               