local talk = TalkAction("/stuck", "!stuck")

local saveFile = {
    folder = "data/logs/",
    filename = "positionsToFix.txt",
    saveLog = true,
    linesMax = 1000
}

local function isStuck(tile)
    return (tile == nil or tile:getGround() == nil or
               tile:hasProperty(TILESTATE_NONE) or
               tile:hasProperty(TILESTATE_FLOORCHANGE_EAST) or
               isItem(tile:getThing()) and not isMoveable(tile:getThing()))
end

function talk.onSay(player, words, param)
    local tile = Tile(player:getPosition())
    if isStuck(tile) then
        local pos = player:getPosition()
        player:teleportTo(player:getTown():getTemplePosition())
        local file = io.open(saveFile.folder .. saveFile.filename, "a")

        file:write(string.format("\n" .. os.date("%Y-%m-%d %H:%M:%S") ..
                                     " %s was stuck in the position: %d, %d, %d",
                                 player:getName(), pos.x, pos.y, pos.z))
        file:close()
    else
        player:sendCancelMessage("You are not stuck.")
    end
end

talk:register()
