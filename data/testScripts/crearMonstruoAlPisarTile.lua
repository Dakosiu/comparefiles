local config ={
    key = 99999,
    monsterName ="Demon",
    area = {fromx=151,tox=12, fromy=57, toy=59, fromz, toz}
}

function onStepIn(cid, item, fromPos, toPos)

    local player = isPlayer(cid);
    if player then
        local xx = math.random(config.area.fromx,config.area.tox);
        local yy = math.random(config.area.fromy,config.area.toy);
        local position = {x = xx, y = yy}
        doCreateMonster(config.name, position)
        doSendMagicEffect(position, 10);
    end
    return true;
end