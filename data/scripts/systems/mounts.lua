--ALTER TABLE  `players` ADD  `extraHealthMount` INT( 11 ) NOT NULL DEFAULT  '0'
--ALTER TABLE  `players` ADD  `extraManaMount` INT( 11 ) NOT NULL DEFAULT  '0'

MOUNTS_BONUS_CONFIG = {
						increaseSpeed = 10,
                      }
MOUNTS_BONUS_STORAGE_COUNT = 1235525
STORAGE_MOUNT_BONUS = 666653

function Player.getBonusSpeedValue(self)
    local value = self:getFullMountsCount() * MOUNTS_BONUS_CONFIG.increaseSpeed
	return value
end

function Player.addMount(self, id)
       
	    if not self or not id then
           return nil
        end
        
        self:addMountEx(id)
        
        if self:hasMount(id) then
           if self:getStorageValue(STORAGE_MOUNT_BONUS + id) >= 1 then
              return true
           end
		   self:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
		   self:setStorageValue(STORAGE_MOUNT_BONUS + id, 1)
		   local mountsCounts = self:getFullMountsCount()
		   self:setStorageValue(MOUNTS_BONUS_STORAGE_COUNT, mountsCounts + 1)
		   self:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "You have received " .. MOUNTS_BONUS_CONFIG.increaseSpeed .. " Speed for obtaining this mount")
		   local bonus = self:getBonusSpeedValue()
		   self:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Bonus Speed Mount: " .. bonus .. ".")
		   self:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Bonuss will activate when u wear any mount.")
		   
		   local mount = self:getOutfit().lookMount
		   if mount > 0 then
		      self:changeSpeed(MOUNTS_BONUS_CONFIG.increaseSpeed * 2)
			  self:saveSpeedMountBonus(bonus + MOUNTS_BONUS_CONFIG.increaseSpeed)
		   end
        end
        
	return true
end

function Player.getFullMountsCount(self)
    local value = self:getStorageValue(MOUNTS_BONUS_STORAGE_COUNT)
	if value < 0 then
	   value = 0
	end
	
	return value
end

function Player.saveSpeedMountBonus(self, value)
	local storage = MOUNTS_BONUS_STORAGE_COUNT + 1
	return self:setStorageValue(storage, value)
end

function Player.getSpeedMountBonus(self)
    
	local storage = MOUNTS_BONUS_STORAGE_COUNT + 1
	
	local value = self:getStorageValue(storage)
	if value <= 0 then
	   return 0
	end
	
	return value
end

function Player.loadSpeedMountBonus(self)
    
	local storage = MOUNTS_BONUS_STORAGE_COUNT + 1
    local value = self:getStorageValue(storage)
	
	if value <= 0 then
	   return
	end

	self:changeSpeed(-value * 2)
end
	
function Player.setMountBonusSpeed(self)
    
	local multiplier = MOUNTS_BONUS_CONFIG.increaseSpeed
	local value = self:getFullMountsCount() * multiplier
	if value <= 0 then
	   return
	end


    self:saveSpeedMountBonus(value)
	--local delta = value + self:getBaseSpeed()
    --self:changeSpeed(-self:getSpeed() + ((delta <= 220) and 220 or delta))

	self:changeSpeed(value * 2)
end

creatureevent = CreatureEvent("mountBonus_onLogin")
function creatureevent.onLogin(player)
    player:saveSpeedMountBonus()
	local mount = player:getOutfit().lookMount
	if mount > 0 then
	   player:setMountBonusSpeed()
	end
	return true
end
creatureevent:register()