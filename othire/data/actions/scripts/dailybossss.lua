-- CONFIG --
    local playersOnly = "no"
    local questLevel = 1
    local STORAGE_BOSS_CD = 22497
    local cdtime = 20 * 60 * 60 -- exhaust in seconds

    local room = {     -- boss room
        fromX = 1006,
        fromY = 904,
        fromZ = 2,
        --------------
        toX = 1026,
        toY = 921,
        toZ = 2
    }

    local monster_pos = {
        [1] = {pos = {1045, 918, 2}, monster = "Dyzmumbras"}
    }

    local players_pos = {
        {x = 990, y = 909, z = 1, stackpos = 253},
        {x = 990, y = 910, z = 1, stackpos = 253},
        {x = 990, y = 911, z = 1, stackpos = 253}
    }

    local new_player_pos = {
        {x = 1044, y = 906, z = 2},
        {x = 1045, y = 906, z = 2},
        {x = 1046, y = 906, z = 2}
    }
-- CONFIG END --

function onUse(cid, item, fromPosition, itemEx, toPosition)
    local all_ready, monsters, player, level = 0, 0, {}, 0

    if item.itemid == 1946 then
        for i = 1, #players_pos do
            table.insert(player, 0)
        end
        for i = 1, #players_pos do
            player[i] = getThingfromPos(players_pos[i])
            if player[i].itemid > 0 then
                if string.lower(playersOnly) == "yes" then
                    if isPlayer(player[i].uid) == true then
                        all_ready = all_ready+1
                    else
                        monsters = monsters+1
                    end
                else
                    all_ready = all_ready+1
                end
            end
        end
        if all_ready == #players_pos then
            for i = 1, #players_pos do
                player[i] = getThingfromPos(players_pos[i])
                if isPlayer(player[i].uid) == true then
                    if getPlayerStorageValue(player[i].uid,STORAGE_BOSS_CD) > os.time() then
                        doPlayerSendCancel(cid,"On cooldown for at least one player.")
                        return false
                    end
                    if getPlayerLevel(player[i].uid) >= questLevel then
                        level = level+1
                    end
                else
                    level = level+1
                end
            end
            if level == #players_pos then
                if string.lower(playersOnly) == "yes" and monsters == 0 or string.lower(playersOnly) == "no" then
                    for _, area in pairs(monster_pos) do
                        doSummonCreature(area.monster,{x=area.pos[1],y=area.pos[2],z=area.pos[3]})
                    end
                    for i = 1, #players_pos do
                        doSendMagicEffect(players_pos[i], CONST_ME_POFF)
                        doTeleportThing(player[i].uid, new_player_pos[i])
                        doSendMagicEffect(new_player_pos[i], CONST_ME_ENERGYAREA)
                        setPlayerStorageValue(player[i].uid,STORAGE_BOSS_CD,os.time() + cdtime)
                    end
                    doTransformItem(item.uid,1945)
                else
                    doPlayerSendTextMessage(cid,19,"Only players can do this quest.")
                    return false
                end
            else
                doPlayerSendTextMessage(cid,19,"All Players have to be level "..questLevel.." to do this quest.")
                return false
            end
        else
            doPlayerSendCancel(cid,"You need "..table.getn(players_pos).." players to do this quest.")
            return false
        end
    elseif item.itemid == 1945 then
        local player_room = 0
        for x = room.fromX, room.toX do
            for y = room.fromY, room.toY do
                for z = room.fromZ, room.toZ do
                    local pos = {x=x, y=y, z=z,stackpos = 253}
                    local thing = getThingfromPos(pos)
                    if thing.itemid > 0 then
                        if isPlayer(thing.uid) == true then
                            player_room = player_room+1
                        end
                    end
                end
            end
        end
        if player_room >= 1 then
            doPlayerSendTextMessage(cid,19,"There is already a team in the quest room.")
            return false
        elseif player_room == 0 then
            for x = room.fromX, room.toX do
                for y = room.fromY, room.toY do
                    for z = room.fromZ, room.toZ do
                        local pos = {x=x, y=y, z=z,stackpos = 253}
                        local thing = getThingfromPos(pos)
                        if thing.itemid > 0 then
                            doRemoveCreature(thing.uid)
                        end
                    end
                end
            end
            doTransformItem(item.uid,1946)
        end
    end

    return true
end