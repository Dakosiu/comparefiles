local shutdownAtServerSave = false
local cleanMapAtServerSave = false

local function serverSave()
    if shutdownAtServerSave then
        Game.setGameState(GAME_STATE_SHUTDOWN)
    else
        Game.setGameState(GAME_STATE_CLOSED)

        if cleanMapAtServerSave then
            cleanMap()
        end

        Game.setGameState(GAME_STATE_NORMAL)
    end
end

local function secondServerSaveWarning()
    broadcastMessage("Evotronus is saving game in one minute.", MESSAGE_STATUS_WARNING)
    addEvent(serverSave, 60000)
end

local function firstServerSaveWarning()
    broadcastMessage("Evotronus is saving game in 3 minutes.", MESSAGE_STATUS_WARNING)
    addEvent(secondServerSaveWarning, 120000)
end

function onSay(cid, words)
    broadcastMessage("Evotronus is saving game in 5 minutes.", MESSAGE_STATUS_WARNING)
    Game.setGameState(GAME_STATE_STARTUP)
    addEvent(firstServerSaveWarning, 120000)
    return not shutdownAtServerSave
end