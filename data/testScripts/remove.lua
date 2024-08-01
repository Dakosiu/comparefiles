local config = {
    id = 3354,
    pos = Position(779,504,7),
}

function onUse(cid, item, fromPosition, items, toPosition)
    local player = Player(cid);
    if not player then return false end
    local tile = Tile(config.pos);
    if tile then
        local stone = tile:getItemById(config.id);
        if stone then
            stone.remove();
            config.pos:sendMagicEffect(3);
            player:sendMessage(MESSAGE_EVENT_ORANGE, "has removide la stone");
        else
            Game.createItem(config.id, 1, config.pos);
            config.pos:sendMagicEffect(3);
            player:sendMessage(MESSAGE_EVENT_ORANGE,"has removide la stone");
        then
    end
    Item(item.uid):transform( () );
    return true;
end