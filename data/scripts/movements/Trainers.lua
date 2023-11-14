local config = {
    leftTopCorner = {x = 41, y = 29},
    rightDownCorner = {x = 7827, y = 29},
    zPos = 6,
    tileItemId = 473
}

local Trainers = MoveEvent()
local AID = 12000
local Pos = Position(819, 870, 5)
Trainers:type("stepin")

local function findFirstEmpty()
    for x = config.leftTopCorner.x, config.rightDownCorner.x do
        for y = config.leftTopCorner.y, config.rightDownCorner.y do
            local tmpPos = {x = x, y = y, z = config.zPos};
            local t = Tile(tmpPos)
            if t ~= nil then
                if (t:getThing():getId() == config.tileItemId and
                    not t:getTopCreature()) then return tmpPos end
            end
        end
    end
    return false
end

function Trainers.onStepIn(creature, item, pos, fromPosition)
    local availableTrainingSlot = findFirstEmpty()
    if (availableTrainingSlot) then
        creature:teleportTo(availableTrainingSlot)
        creature:sendTextMessage(MESSAGE_INFO_DESCR, "Welcome.")
    else
        creature:sendTextMessage(MESSAGE_INFO_DESCR, "No available slots.")
    end
    return true
end

Trainers:aid(AID)
Trainers:register()

local globalevent = GlobalEvent("load_Trainers")
function globalevent.onStartup()
    local tile = Tile(Pos)
    if tile then
        local ground = tile:getGround()
        if ground then ground:setAttribute(ITEM_ATTRIBUTE_ACTIONID, AID) end
    end
end

globalevent:register()