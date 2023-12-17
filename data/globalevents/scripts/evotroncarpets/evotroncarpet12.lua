-- config
local carpetPositions = {
    { x = 839, y = 882, z = 4 },
    { x = 839, y = 881, z = 4 },
    { x = 839, y = 880, z = 4 },
    { x = 839, y = 879, z = 4 },
    { x = 839, y = 878, z = 4 },
    { x = 839, y = 877, z = 4 },
    { x = 839, y = 876, z = 4 },
    { x = 839, y = 875, z = 4 },
    { x = 839, y = 874, z = 4 },
    { x = 839, y = 873, z = 4 },
    { x = 839, y = 872, z = 4 },
    { x = 839, y = 871, z = 4 },
    { x = 839, y = 870, z = 4 },
    { x = 838, y = 870, z = 4 },
}
local carpetItemId = 3166

-- script variables
local CARPET_DIRECTION_FORWARD = 1
local CARPET_DIRECTION_BACKWARD = 2
local currentDirection = CARPET_DIRECTION_FORWARD

local function comparePositions(position1, position2)
    return position1.x == position2.x and position1.y == position2.y and position1.z == position2.z
end

local function isCarpetPosition(position)
    local tile = Tile(position)
    if tile then
        local carpet = tile:getItemById(carpetItemId)
        if carpet then
            return true
        end
    end

    return false
end

local function getCarpetPosition()
    for _, position in pairs(carpetPositions) do
        if isCarpetPosition(position) then
            return position
        end
    end
    return nil
end

local function moveCarpet(fromPosition, toPosition)
    -- remove old item
    local fromTile = Tile(fromPosition)
    fromTile:getItemById(carpetItemId):remove()
    -- create new item

    local tile = Game.createItem(carpetItemId, 1, toPosition)
    tile:setAttribute(ITEM_ATTRIBUTE_ACTIONID, CantThrash)
    -- move creatures
    local creatures = fromTile:getCreatures()
    for _, creature in pairs(creatures) do
        creature:teleportTo(toPosition, false)
    end
end

local function getNextCarpetPosition(carpetPosition)
    -- find carpet position key in table
    local carpetPositionKey = 1
    for i, position in pairs(carpetPositions) do
        if comparePositions(position, carpetPosition) then
            carpetPositionKey = i
            break
        end
    end

    if carpetPositionKey == 1 then
        -- carpet at first positions, move forward, get next position
        currentDirection = CARPET_DIRECTION_FORWARD
        return carpetPositions[carpetPositionKey + 1]
    elseif carpetPositionKey == #carpetPositions then
        -- carpet at last position, move backward, get previous position
        currentDirection = CARPET_DIRECTION_BACKWARD
        return carpetPositions[carpetPositionKey - 1]
    else
        -- carpet between first and last position, check move direction
        if currentDirection == CARPET_DIRECTION_FORWARD then
            return carpetPositions[carpetPositionKey + 1]
        else
            return carpetPositions[carpetPositionKey - 1]
        end
    end
end

local function createCarpet(position)
    Game.createItem(carpetItemId, 1, position)
end

function onThink()
    -- get or create carpet
    local currentCarpetPosition = getCarpetPosition()
    if not currentCarpetPosition then
        -- carpet does not exist, create one
        currentCarpetPosition = carpetPositions[1]
        createCarpet(currentCarpetPosition)
    end

    -- get next carpet position
    local nextCarpetPosition = getNextCarpetPosition(currentCarpetPosition)
    -- move carpet to next position
    moveCarpet(currentCarpetPosition, nextCarpetPosition)

    return true
end
