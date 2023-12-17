---- movements.xml
--- <movevent event="StepIn" actionid="5543215" script="ROOKGARD_SYSTEM/onStepIn.lua"/>


function onStepIn(creature, item, position, fromPosition)
    

	if not creature:isPlayer() then
		return false
	end

	
	if item.actionid == cfg.storage and creature:getStorageValue(cfg.storage) ~= 1 then
	creature:sendTextMessage(ROOKGARD_SYSTEM.messages.pass.type, ROOKGARD_SYSTEM.messages.pass.value)
	creature:setStorageValue(ROOKGARD_SYSTEM.storage, 1)
	creature:setTown(Town(ROOKGARD_SYSTEM.TownID))
	end
	
	return true
end
	
	