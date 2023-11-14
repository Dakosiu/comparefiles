local storage = { value = 500, reset = -1, set = "has already been reset"}

function onSay(player, words, param)
    local data = {
        level = player:getLevel(),
        magic = player:getMagicLevel(),
        mana = {
            min = player:getMana(),
            max = player:getMaxMana()
        },
        health = {
            min = player:getHealth(),
            max = player:getMaxHealth()
        }
    }
    if player:getStorageValue(storage.value) ~= storage.reset  then
        player:setStorageValue(storage.value, storage.reset)
        storage.set = "has been reset"
    end
    player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE,
    "Player Level:"..(data.level)
    .." STORAGE ("..(storage.value)..") "..(storage.set)
    .." Player MAGICLEVEL:"..(data.magic)
    .." Player Mana:"..(data.mana.min).."/"..(data.mana.max)
    .." Player Health:"..(data.health.min).."/"..(data.health.max))

    return true
end