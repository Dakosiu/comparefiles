local config = {
    itemId = 27705, -- ID of the item that activates the regeneration
    healthRegen = 10, -- life gain/interval
    manaRegen = 10, -- mana gain/interval
    soulRegen = 1, -- soul gain/interval
    interval = 2 -- interval in seconds
}

local function regeneratePlayer(player)
    if player and Tile(player:getPosition()):getItemById(config.itemId) then
        player:addHealth(config.healthRegen)
        player:addMana(config.manaRegen)
        player:addSoul(config.soulRegen)
        player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
        addEvent(regeneratePlayer, config.interval * 1000, player)
    end
end

local moveevent = MoveEvent()
function moveevent.onStepIn(creature, item, position, fromPosition)
    if creature:isPlayer() and item:getId() == config.itemId then
        addEvent(regeneratePlayer, config.interval * 1000, creature)
    end
    return true
end
moveevent:id(config.itemId)
moveevent:register()