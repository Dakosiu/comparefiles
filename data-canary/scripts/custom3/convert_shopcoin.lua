local convertStoreCoins = Action()
local coinsToAdd = 1
local message = string.format("Added %d coins to your account.", coinsToAdd)
local effect = CONST_ME_MAGIC_BLUE

function convertStoreCoins.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local itemPos = item:getPosition()

    if item:remove(1) then
        player:addTibiaCoins(coinsToAdd)
        player:say(message, TALKTYPE_MONSTER_SAY, false, player, itemPos)
        player:getPosition():sendMagicEffect(effect)
        return true
    end
    
    return false
end

convertStoreCoins:id(22118)
convertStoreCoins:register()