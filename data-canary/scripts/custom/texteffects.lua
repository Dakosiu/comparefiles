local config = {
    interval = 2000,
    texts = {
        -- { pos = Position(934, 1117, 7), text = "Task!", effects = {  } },
        { pos = Position(929, 1113, 4), text = "Dungeon!", effects = { CONST_ME_ICEAREA } },
        { pos = Position(929, 1115, 4), text = "Dungeon!", effects = { CONST_ME_FIREAREA } },
	    { pos = Position(1022, 731, 7), text = "Traning", effects = { CONST_ME_ICEAREA } },
		{ pos = Position(1021, 722, 7), text = "Exp", effects = { CONST_ME_ICEAREA } },
	    { pos = Position(984, 709, 7), text = "Boss Event!", effects = { CONST_ME_ICEAREA } },
		{ pos = Position(1012, 733, 7), text = "Quest", effects = { CONST_ME_ICEAREA } },
	    { pos = Position(1025, 726, 7), text = "Shop", effects = { CONST_ME_ICEAREA } },
		{ pos = Position(929, 1113, 4), text = "Dungeon!", effects = { CONST_ME_ICEAREA } },
		{ pos = Position(1024, 723, 6), text = "Boss", effects = { CONST_ME_ICEAREA } },
		{ pos = Position(1015, 721, 6), text = "Events", effects = { CONST_ME_ICEAREA } },
		{ pos = Position(981, 701, 6), text = "Fortress War", effects = { CONST_ME_ICEAREA } },
		{ pos = Position(1014, 725, 7), text = "Temple", effects = { CONST_ME_ICEAREA } },
		{ pos = Position(992, 719, 7), text = "Back", effects = { CONST_ME_ICEAREA } },
		{ pos = Position(884, 1044, 7), text = "+1", effects = { CONST_ME_ICEAREA } },
		{ pos = Position(890, 1044, 7), text = "+2", effects = { CONST_ME_ICEAREA } }
    }
}

local textOnMap = GlobalEvent("TextOnMap")

function textOnMap.onThink(interval)
    local player = Game.getPlayers()[1]
    if not player then
        return true
    end

    for k, info in pairs(config.texts) do
        player:say(info.text, TALKTYPE_MONSTER_SAY, false, nil, info.pos)
        info.pos:sendMagicEffect(info.effects[math.random(1, #info.effects)])
    end
    return true
end

textOnMap:interval(config.interval)
textOnMap:register()