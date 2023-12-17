local Tutorial = MoveEvent()
local AID = 17900
Tutorial:type("stepin")

local tiles = {
    [0] = {P = {2927, 212, 7}, Monster = "Snake"},
    [1] = {P = {2927, 210, 7}, Monster = "Bat"},
    [2] = {P = {2927, 208, 7}, Monster = "Poison Spider"},
    [3] = {P = {2927, 206, 7}, Monster = "Crocodile"},
    [4] = {P = {2927, 204, 7}, Monster = "Wasp"},
    [5] = {P = {2927, 202, 7}, Monster = "Wolf"},
    [6] = {P = {2927, 200, 7}, Monster = "Orc"},
    [7] = {P = {2927, 198, 7}, Monster = "Smuggler"},
    [8] = {P = {2927, 196, 7}, Monster = "Smuggler"},
    [9] = {P = {843, 885, 5}, Monster = "Snake"},
    [10] = {P = {2929, 212, 7}, Monster = "Bug"},
    [11] = {P = {2929, 210, 7}, Monster = "Spider"},
    [12] = {P = {2929, 208, 7}, Monster = "Salamander"},
    [13] = {P = {2929, 206, 7}, Monster = "Swamp Troll"},
    [14] = {P = {2929, 204, 7}, Monster = "Cobra"},
    [15] = {P = {2929, 202, 7}, Monster = "Troll"},
    [16] = {P = {2929, 200, 7}, Monster = "Skeleton"},
    [17] = {P = {2929, 198, 7}, Monster = "Hunter"},
    [18] = {P = {2929, 196, 7}, Monster = "Minotaur"},
	
	--- from here different stuffs is, custom hunt rooms or just...
	
    [19] = {P = {984, 876, 8}, Monster = "Cyclops Smith"},
	[20] = {P = {52, 1975, 7}, Monster = "Crocodile"}, -- 1 hunt room >>
	[21] = {P = {25, 1974, 7}, Monster = "Frost Dragon Hatchling"}, -- 2 hunt room <<
	[22] = {P = {52, 1964, 7}, Monster = "Dragon Lord"}, -- 3 hunt room >>>
	[23] = {P = {25, 1961, 7}, Monster = "Draken Warmaster"}, -- 4 hunt room <<<
	[24] = {P = {52, 1950, 7}, Monster = "Hellhound"}, -- 5 hunt room >>>>
	[25] = {P = {25, 1951, 7}, Monster = "Infected Weeper"}, -- 6 hunt room <<<<
	[26] = {P = {52, 1940, 7}, Monster = "Draken Elite"}, -- 7 hunt room >>>>
	[27] = {P = {25, 1938, 7}, Monster = "Fury"}, -- 8 hunt room <<<<
	[28] = {P = {52, 1927, 7}, Monster = "Grim Reaper"}, -- 9 hunt room
	[29] = {P = {25, 1927, 7}, Monster = "Grave Robber"}, -- 1 hunt room
	[30] = {P = {52, 1916, 7}, Monster = "Inky"}, -- 1 hunt room
	[31] = {P = {25, 1916, 7}, Monster = "Infernatil"}, -- 1 hunt room
	[32] = {P = {37, 1894, 7}, Monster = "Spectre"}, -- 1 hunt room
	[33] = {P = {24, 1892, 7}, Monster = "Ghastly Dragon"}, -- 1 hunt room
	[34] = {P = {51, 1891, 7}, Monster = "Glooth Anemone"}, -- 1 hunt room
	[35] = {P = {812, 872, 3}, Monster = "Fire Devil"}, -- 1 hunt room
}

function Tutorial.onStepIn(creature, item, pos, fromPosition)
    local player = Player(creature)
    local aid = item.actionid
    if player then
        for a in pairs(tiles) do
            local total = AID + a
            if aid == total then
                local b = total - AID
                local b = tiles[b]
                if b then
                    local x
                    if b.P[1] > 2927 then
                        x = b.P[1] + 1
                    else
                        x = b.P[1] - 1
                    end
                    local spawn = Game.createMonster(b.Monster ,Position(x, b.P[2],b.P[3]),false, false)
                    if spawn then return false end
                end
            end
        end
    end
end

for c in pairs(tiles) do Tutorial:aid(AID + c) end
Tutorial:register()

local globalevent = GlobalEvent("load_Tutorial")
function globalevent.onStartup()
    for i in pairs(tiles) do
        local T = tiles[i]
        local tile = Tile(T.P[1], T.P[2], T.P[3])
        if tile then
            local ground = tile:getGround()
            if ground then
                ground:setAttribute(ITEM_ATTRIBUTE_ACTIONID, AID + i)
            end
        end
    end
end

globalevent:register()

local TutorialMiddle = MoveEvent()
local AID = 19742
TutorialMiddle:type("stepin")

local Pos = Position(2928, 206, 7)
local PosStair = Position(2928, 207, 7)

function TutorialMiddle.onStepIn(creature, item, pos, fromPosition)
    local player = Player(creature)
    local id = item.itemid
    local aid = item.actionid
    local uid = item.uniqueid

    if player and aid == AID then
        player:setTown(Town(17))
        player:setStorageValue(99478, 1)
    end
    if player:getStorageValue(99478) == 1 and aid == AID + 1 then
        --player:teleportTo(fromPosition)
        --player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Go forward warrior, you have to move on!")
    end
end

TutorialMiddle:aid(AID, AID + 1)
TutorialMiddle:register()

local globalevent = GlobalEvent("load_TutorialMiddle")
function globalevent.onStartup()
    local tile = Tile(Pos)
    local tile2 = Tile(PosStair)
    if tile then
        local ground = tile:getGround()
        local ground2 = tile2:getGround()
        -- local thing = tile:getTopVisibleThing()
        if ground then
            ground:setAttribute(ITEM_ATTRIBUTE_ACTIONID, AID)
            ground2:setAttribute(ITEM_ATTRIBUTE_ACTIONID, AID + 1)
        end
    end
end

globalevent:register()

local TutorialEnd = MoveEvent()
local AID = 19741
TutorialEnd:type("stepin")

local Pos = Position(2925, 192, 7)
local Pos2 = Position(2931, 192, 7)

function TutorialEnd.onStepIn(creature, item, pos, fromPosition)
    local player = Player(creature)
    local id = item.itemid
    local aid = item.actionid
    local uid = item.uniqueid

    if player and aid then
        player:setTown(Town(1))
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Welcome to Evotronus")
        player:sendTextMessage(MESSAGE_STATUS_DEFAULT,
                               "You are now citizen from Evotronus")
    end
end

TutorialEnd:aid(AID)
TutorialEnd:register()

local globalevent = GlobalEvent("load_TutorialEnd")
function globalevent.onStartup()
    local tile = Tile(Pos)
    local tile2 = Tile(Pos2)
    if tile and tile2 then
        local ground = tile:getGround()
        local ground2 = tile2:getGround()
        -- local thing = tile:getTopVisibleThing()
        if ground and ground2 then
            ground:setAttribute(ITEM_ATTRIBUTE_ACTIONID, AID)
            ground2:setAttribute(ITEM_ATTRIBUTE_ACTIONID, AID)
        end
    end
end

globalevent:register()

function Player:sendInfo(player)
    if not player then return nil end

    player:registerEvent("ModalWindow_Tutorial")

    local title = "---------------Player Info---------------"
    local message =
        "                         Zoom Information\nYou can change your zoom info in options/interface.\nThe value you set there will be your zoom, you will be able to see it moving.\nAlso you can use CTRL + and CTRL - to Zoom In and Out"

    local window = ModalWindow(1001, title, message)
    window:addButton(100, "Okay")
    window:addButton(101, "Close")
    window:setDefaultEnterButton(100)
    window:setDefaultEscapeButton(101)

    return window:sendToPlayer(player)
end

local creaturescript = CreatureEvent("ModalWindow_Tutorial")
function creaturescript.onModalWindow(player, modalWindowId, buttonId, choiceId)

    player:unregisterEvent("ModalWindow_Tutorial")

    if buttonId == 100 or buttonId == 101 then
        local serverName = configManager.getString(configKeys.SERVER_NAME)
        local loginStr = "Please choose your outfit."
        player:sendTextMessage(MESSAGE_STATUS_DEFAULT, loginStr)
        player:sendOutfitWindow()
    end

end

creaturescript:register()

local creatureevent = CreatureEvent("Modal_Tutorial")

function creatureevent.onLogin(player)
    local serverName = configManager.getString(configKeys.SERVER_NAME)
    local loginStr = "Welcome to " .. serverName .. "!"
    if player:getLastLoginSaved() <= 0 then
        local firstItems = {2649, 2461, 2643, 2467, 41720}
        --for i = 1, #firstItems do player:addItem(firstItems[i], 1) end
        player:sendInfo(player)
    else
        if loginStr ~= "" then
            player:sendTextMessage(MESSAGE_STATUS_DEFAULT, loginStr)
        end

        loginStr = string.format("Your last visit in %s: %s.", serverName,
                                 os.date("%d %b %Y %X",
                                         player:getLastLoginSaved()))
    end
    player:sendTextMessage(MESSAGE_STATUS_DEFAULT, loginStr)
    return true
end
creatureevent:register()