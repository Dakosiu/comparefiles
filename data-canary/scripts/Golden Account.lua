-- ALTER TABLE `accounts`
   -- ADD COLUMN `goldenlastday` int(10) NOT NULL DEFAULT 0 AFTER `lastday`,
   -- ADD COLUMN `goldendays` int(11) NOT NULL DEFAULT 0 AFTER `lastday`;

GOLDEN_ACCOUNT_CONFIG = {
                          useTeleport = true,
                          expirationPosition = Position(95, 114, 7),
                          useMessage = true,
                          expirationMessage = 'Golden Account expired.',
                          expirationMessageType = MESSAGE_STATUS_WARNING,
						  ["Features"] = {
						                   _HousesOnlyForGoldenAccount = true,
										   _increaseExperience = { value = 0.1, enabled = true },
										   _increaseStaminaRegeneration = { value = 0.50, enabled = true }
										 }, 
						  ["Scrolls"] = {
						                  [8176] = { days = 30, onUseEffect = CONST_ME_GIFT_WRAPS, enabled = true },
										  [8175] = { days = 15, onUseEffect = CONST_ME_GIFT_WRAPS, enabled = true },
										}
                        }

if not GoldenAccountData then
    GoldenAccountData = { }
end

if not GOLDEN_ACCOUNT_FEATURES then
   GOLDEN_ACCOUNT_FEATURES = {}
end


function GOLDEN_ACCOUNT_FEATURES:getExperienceBonus()
	local t = GOLDEN_ACCOUNT_CONFIG["Features"]._increaseExperience
	local enabled = t.enabled
	local value = t.value
	if enabled then
	   return value
	end
	return 0
end

function GOLDEN_ACCOUNT_FEATURES:getStaminaRegeneration()
   local t = GOLDEN_ACCOUNT_CONFIG["Features"]._increaseStaminaRegeneration
   local enabled = t.enabled
   local value = t.value
   if enabled then
      return value
   end
   return 0
end

function GOLDEN_ACCOUNT_FEATURES:Houses()
    
	local enabled = GOLDEN_ACCOUNT_CONFIG["Features"]._HousesOnlyForGoldenAccount
	if enabled then
	   return true
	end
	return false
end

function Player.onRemoveGoldenAccount(self)
    if GOLDEN_ACCOUNT_CONFIG.useTeleport then
        self:teleportTo(GOLDEN_ACCOUNT_CONFIG.expirationPosition)
        GOLDEN_ACCOUNT_CONFIG.expirationPosition:sendMagicEffect(CONST_ME_TELEPORT)
    end

    if GOLDEN_ACCOUNT_CONFIG.useMessage then
        self:sendTextMessage(GOLDEN_ACCOUNT_CONFIG.expirationMessageType, GOLDEN_ACCOUNT_CONFIG.expirationMessage)
    end
	self:setGrindingXpBoost(0)
end

function Player.getGoldenAccountDays(self)
    return GoldenAccountData[self:getId()].days
end

function Player.isGoldenAccount(self)
    if self:getGoldenAccountDays() > 0 then
	   return true
	end
	return false
end

function Player.getLastGoldenAccountDay(self)
    return GoldenAccountData[self:getId()].lastDay
end

function Player.addInfiniteGoldenAccount(self)
    local data = GoldenAccountData[self:getId()]
    data.days = 0xFFFF
    data.lastDay = 0

    db.query(string.format('UPDATE `accounts` SET `goldendays` = %i, `goldenlastday` = %i WHERE `id` = %i;', 0xFFFF, 0, self:getAccountId()))
end

function Player.addGoldenAccountDays(self, amount)
    local data = GoldenAccountData[self:getId()]
    local amount = math.min(0xFFFE - data.days, amount)
    if amount > 0 then
        if data.days == 0 then
            local time = os.time()
            db.query(string.format('UPDATE `accounts` SET `goldendays` = `goldendays` + %i, `goldenlastday` = %i WHERE `id` = %i;', amount, time, self:getAccountId()))
            data.lastDay = time
        else
            db.query(string.format('UPDATE `accounts` SET `goldendays` = `goldendays` + %i WHERE `id` = %i;', amount, self:getAccountId()))
        end
        data.days = data.days + amount
    end
	
	
	--self:setGrindingXpBoost(GOLDEN_ACCOUNT_FEATURES:getExperienceBonus() * 100)

    return true
end

function Player.removeGoldenAccountDays(self, amount)
    local data = GoldenAccountData[self:getId()]
    if data.days == 0xFFFF then
        return false
    end

    local amount = math.min(data.days, amount)
    if amount > 0 then
        db.query(string.format('UPDATE `accounts` SET `goldendays` = `goldendays` - %i WHERE `id` = %i;', amount, self:getAccountId()))
        data.days = data.days - amount

        if data.days == 0 then
            self:onRemoveGoldenAccount()
        end
    end

    return true
end

function Player.removeGoldenAccount(self)
    local data = GoldenAccountData[self:getId()]
    if data.days == 0 then
        return
    end

    data.days = 0
    data.lastDay = 0

    self:onRemoveGoldenAccount()

    db.query(string.format('UPDATE `accounts` SET `goldendays` = 0, `goldenlastday` = 0 WHERE `id` = %i;', self:getAccountId()))
end

function Player.loadGoldenAccountData(self)
    
    local resultId = db.storeQuery(string.format('SELECT `goldendays`, `goldenlastday` FROM `accounts` WHERE `id` = %i;', self:getAccountId()))
    if resultId then
        GoldenAccountData[self:getId()] = {
            days = result.getDataInt(resultId, 'goldendays'),
            lastDay = result.getDataInt(resultId, 'goldenlastday')
        }

        result.free(resultId)
        return true
    end

    GoldenAccountData[self:getId()] = { days = 0, lastDay = 0 }
    return false
end

function Player.updateGoldenAccountTime(self)
    local save = false

    local data = GoldenAccountData[self:getId()]
    local days, lastDay = data.days, data.lastDay
    local daysBefore = days
    if days == 0 or days == 0xFFFF then
        if lastDay ~= 0 then
            lastDay = 0
            save = true
        end
    elseif lastDay == 0 then
        lastDay = os.time()
        save = true
    else
        local time = os.time()
        local elapsedDays = math.floor((time - lastDay) / 86400)
        if elapsedDays > 0 then
            if elapsedDays >= days then
                days = 0
                lastDay = 0
            else
                days = days - elapsedDays
                lastDay = time - ((time - lastDay) % 86400)
            end
            save = true
        end
    end

    if save then
        if daysBefore > 0 and days == 0 then
		    --self:setGrindingXpBoost(0)
            self:onRemoveGoldenAccount()
        end

        db.query(string.format('UPDATE `accounts` SET `goldendays` = %i, `goldenlastday` = %i WHERE `id` = %i;', days, lastDay, self:getAccountId()))
        data.days = days
        data.lastDay = lastDay
    end
	if days > 0 then
	   --self:setGrindingXpBoost(GOLDEN_ACCOUNT_FEATURES:getExperienceBonus() * 100)
	end
end

local creatureevent = CreatureEvent("GoldenAccount_onLogin")
function creatureevent.onLogin(player)
	player:loadGoldenAccountData()
    player:updateGoldenAccountTime()
	--player:setGrindingXpBoost(0)
	-- if player:getGoldenAccountDays() > 1 then
	   -- player:setGrindingXpBoost(GOLDEN_ACCOUNT_FEATURES:getExperienceBonus() * 100)
	-- end
	return true
end
creatureevent:register()

local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local t = GOLDEN_ACCOUNT_CONFIG["Scrolls"][item:getId()]
	if not t then
	   return true
	end
	
	local days = t.days
	local effect = t.onUseEffect
	player:addGoldenAccountDays(days)
	
	player:getPosition():sendMagicEffect(effect)
	player:sendTextMessage(MESSAGE_INFO_DESCR, "You got " .. days .. " golden account days.")
	item:remove(1)
	return true
end
for i,v in pairs(GOLDEN_ACCOUNT_CONFIG["Scrolls"]) do
    if v.enabled then
       action:id(i)
	end
end
action:register()


local talkaction = TalkAction("!goldenaccount")
function talkaction.onSay(player, words, param)
	if player:isGoldenAccount() then
	   player:popupFYI("You have " .. player:getGoldenAccountDays() .. " golden account days left.")
	else
	   player:popupFYI("You dont have golden account.")
	end
	return false
end
talkaction:separator(" ")
talkaction:register()

