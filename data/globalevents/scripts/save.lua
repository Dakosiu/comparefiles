local cleaningMap = false
local function serverSave()
    if cleaningMap then
        cleanMap()
    end
    saveServer()
    broadcastMessage("Server save has been completed.", MESSAGE_STATUS_WARNING)
end

local function secondServerSaveWarning()
    broadcastMessage("Evotronus is saving game in one minute.", MESSAGE_STATUS_WARNING)
    addEvent(serverSave, 60000)
end

local function firstServerSaveWarning()
    broadcastMessage("Evotronus is saving game in 3 minutes.", MESSAGE_STATUS_WARNING)
    addEvent(secondServerSaveWarning, 120000)
end


function onThink(interval)

    broadcastMessage("Evotronus is saving game in 5 minutes.", MESSAGE_STATUS_WARNING)
    addEvent(firstServerSaveWarning, 120000)
    return true
end
	