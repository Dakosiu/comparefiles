local onlinePlayers = GlobalEvent("onlinePlayers")
local Cooldown = 30 * 60 * 1000 -- in minutes

function onlinePlayers.onThink(interval, lastExecution)
    local players = Game.getPlayers()
    if #players > 3 then
        print(("%d players online."):format(#players))
    end
end

onlinePlayers:interval(Cooldown)
onlinePlayers:register()