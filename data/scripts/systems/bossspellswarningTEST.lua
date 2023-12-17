--[[local area = createCombatArea(AREA_SQUARE1X1)

local effect = {
    CONST_ANI_METEORITE,
    CONST_ME_METEORITE
}

local config = {
    ['Hide'] = {500, 1000},
    ['Rorc'] = {5000, 10000},
}

local function spawnFire(position, cid)
    if not isCreature(cid) then
        return true
    end
   
    doSendMagicEffect(position, CONST_ME_SQUARE, 0, 300)
    doSendMagicEffect(position, CONST_ME_EXCLAMATION, 0, 150)
   
    addEvent(function()
        if not isCreature(cid) then
            return true
        end
       
        doSendDistanceShoot({x = position.x - 5, y = position.y - 5, z = position.z}, position, effect[1])
        addEvent(function()
            if not isCreature(cid) then
                return true
            end
           
            local var = config[getCreatureName(cid)] or {80, 100}
            doCombatAreaHealth(cid, COMBAT_FIREDAMAGE, position, area, -var[1], -var[2], CONST_ME_NONE)
            doSendMagicEffect({x = position.x + 1, y = position.y + 1, z = position.z}, effect[2])
        end, 250)
    end, 2000)
end

local function spawnNewFire(cid, pos, count)
    local width, height = 12, 8
    for i = 1, count do
        local position = {x = pos.x + math.random(-width, width), y = pos.y + math.random(-height, height), z = pos.z}
        if isWalkable(position, false, true) then
            addEvent(spawnFire, i * 150, position, cid)
        end
    end
end

function onCastSpell(cid, var, iconId, spellLevel, direction, effectId)
    local pos = getThingPos(cid)x
    for i = 0, 5 do
        addEvent(spawnNewFire, 1000 * i, cid, pos, 15 - i)
    end
   
    return true
end

--]]