local AccPorIp = 7

local creatureevent = CreatureEvent("onLogin_mc")
function creatureevent.onLogin(player) 

    local mc = 0
    for _, verificar in ipairs(Game.getPlayers()) do
        if player:getIp() == verificar:getIp() then
            mc = mc + 1
            if mc > AccPorIp then return false end
        end
    end
 
    return true
end
creatureevent:register()