local config = {
    type = COMBAT_DEATHDAMAGE,
    effect = 0, --
    distance = 32, -- Distance effect
    rounds = 5, -- How many rounds
    time = 250 -- How fast it should be
}

local combat = Combat()
local combat2 = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, config.type)
combat2:setParameter(COMBAT_PARAM_TYPE, config.type)
combat:setParameter(COMBAT_PARAM_EFFECT, 0)
combat2:setParameter(COMBAT_PARAM_EFFECT, config.effect)

local area = {
{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
{ 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 },
{ 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0 },
{ 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0 },
{ 0, 0, 1, 0, 0, 3, 0, 0, 1, 0, 0 },
{ 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0 },
{ 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0 },
{ 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 },
{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
}

local area2 = {
{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
{ 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 },
{ 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0 },
{ 0, 0, 0, 1, 1, 3, 1, 1, 0, 0, 0 },
{ 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0 },
{ 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 },
{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
}

combat:setArea(createCombatArea(area))
combat2:setArea(createCombatArea(area2))

function onGetFormulaValues(player, level, magicLevel) -- DISTANCE EFFECT FORMULAS
    local min = (level / 5) + (magicLevel * 5) + 25
    local max = (level / 5) + (magicLevel * 6.2) + 45
    return -min, -max
end

function onGetFormulaValues2(player, level, magicLevel) -- INSIDE OF AURA EFFECT FORMULAS
    local min = (level / 5) + (magicLevel * 5) + 25
    local max = (level / 5) + (magicLevel * 6.2) + 45
    return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")
combat2:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues2")

local function castSpellTo(cid, variant)
    local player = Player(cid)
    if player then
        local pos = player:getPosition()
        Position(pos.x+2, pos.y+2, pos.z):sendDistanceEffect(Position(pos.x+3, pos.y, pos.z), config.distance)
        Position(pos.x+3, pos.y, pos.z):sendDistanceEffect(Position(pos.x+2, pos.y-2, pos.z), config.distance)
        Position(pos.x+2, pos.y-2, pos.z):sendDistanceEffect(Position(pos.x, pos.y-3, pos.z), config.distance)
        Position(pos.x, pos.y-3, pos.z):sendDistanceEffect(Position(pos.x-2, pos.y-2, pos.z), config.distance)
        Position(pos.x-2, pos.y-2, pos.z):sendDistanceEffect(Position(pos.x-3, pos.y, pos.z), config.distance)
        Position(pos.x-3, pos.y, pos.z):sendDistanceEffect(Position(pos.x-2, pos.y+2, pos.z), config.distance)
        Position(pos.x-2, pos.y+2, pos.z):sendDistanceEffect(Position(pos.x, pos.y+3, pos.z), config.distance)
        Position(pos.x, pos.y+3, pos.z):sendDistanceEffect(Position(pos.x+2, pos.y+2, pos.z), config.distance)
        combat:execute(player, variant)
        combat2:execute(player, variant)
    end
end

local spell = Spell(SPELL_INSTANT)

function spell.onCastSpell(creature, variant)
    local cid = creature:getId()
    for i = 1, config.rounds do
        addEvent(castSpellTo, config.time * (i -1), cid, variant)
    end
    return true
end

spell:name("aura")
spell:words("exura aura")
spell:group("attack")
spell:vocation("sorcerer", "master sorecerer")
spell:id(1)
spell:cooldown(1000)
spell:level(2000)
spell:manaPercent(1)
spell:blockWalls(true)
spell:register()