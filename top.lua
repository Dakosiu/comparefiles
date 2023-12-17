local Config = {
    { BossName = "Draganir", position = { x = 549, y = 558, z = 7 } },
    { monsterName = "Dragon Lord", count = 63, position = { from_x = 542, to_x = 642, from_y = 551, to_y = 602, z = 7 } },
}
local exhaust = {
    storage = 17121212, -- storage of raid (every raid should have a unique storage)
    delay = 98, -- in minutes
}
local function get_date(storage)
    local storageValue = Game.getStorageValue(storage)
    if storageValue and storageValue >= os.time() then
        local time_left = storageValue - os.time()
        local hours = string.format("%02.f", math.floor(time_left / 3600))
        local mins = string.format("%02.f", math.floor(time_left / 60 - (hours * 60)))
        local secs = string.format("%02.f", math.floor(time_left - hours * 3600 - mins * 60))
        local time_string = ""
        if hours == "00" then
            time_string = mins .. " Minutes" .. " and " .. secs .. " Seconds" .. "."
        else
            time_string = hours .. " Hours" .. ", " .. mins .. " Minutes" .. " and " .. secs .. " Seconds" .. "."
        end
        return time_string
    else
        return "No cooldown or invalid storage."
    end
end
local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local exhaustValue = Game.getStorageValue(exhaust.storage)
    if exhaustValue and exhaustValue >= os.time() then
        player:sendTextMessage(MESSAGE_STATUS_WARNING, "You have to wait: " .. get_date(exhaust.storage))
		player:getPosition():sendMagicEffect(843)
        return true
    end
    Game.broadcastMessage("The player " .. player:getName() .. " has used the Draganir Head and triggered the magical ethereal world...", MESSAGE_EVENT_ADVANCE)
    addEvent(function()
        for i = 1, #Config do
            local x = 0
            local y = 0
            local z = 0
            local count = 0
            local pos = nil
            local attempts = 0
            if Config[i].monsterName == nil then
                x = Config[i].position.x
                y = Config[i].position.y
                z = Config[i].position.z
                pos = Position(x, y, z)
                Game.createMonster(Config[i].BossName, pos, false, true)
            else
                for a = 1, Config[i].count do
                    x = math.random(Config[i].position.from_x, Config[i].position.to_x)
                    y = math.random(Config[i].position.from_y, Config[i].position.to_y)
                    z = Config[i].position.z
                    pos = Position(x, y, Config[i].position.z)
                    local monster = Game.createMonster(Config[i].monsterName, pos, false, false)
                    if not monster and attempts < 50 then
                        a = a - 1
                        attempts = attempts + 1
                    end
                end
            end
            Game.broadcastMessage("Dragon Lords and Draganir boss are arriving at Crystal World!", MESSAGE_EVENT_ADVANCE)
        end
    end, 20000)
    addEvent(function()
        Game.broadcastMessage("Many Dragon Lords and Draganir have been seen entering the Crystal World Realm...!", MESSAGE_EVENT_ADVANCE)
    end, 5000)
    addEvent(function()
        Game.broadcastMessage("Many Dragon Lords and Draganir Boss are seen near Crystal World lands, they are very close, be prepared!", MESSAGE_EVENT_ADVANCE)
    end, 10000)
    addEvent(function()
        Game.broadcastMessage("Warriors, loot the boss!!! and protect the Crystal World!", MESSAGE_EVENT_ADVANCE)
    end, 15000)
    item:remove(1)
    Game.setStorageValue(exhaust.storage, os.time() + exhaust.delay * 60)
    player:getPosition():sendMagicEffect(503)
    return true
end

action:id(43728)