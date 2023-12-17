local config = {
    type = COMBAT_DEATHDAMAGE,
    effect = 39,
    effect2 = 18,
    distance = 11,
    rounds = 4,
    time = 250
}

local combat = Combat()
local combat2 = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, config.type)
combat:setParameter(COMBAT_PARAM_EFFECT, config.effect2)
combat2:setParameter(COMBAT_PARAM_TYPE, config.type)
combat2:setParameter(COMBAT_PARAM_EFFECT, config.effect)

local area = {
{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
{ 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0 },
{ 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0 },
{ 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0 },
{ 0, 0, 1, 0, 0, 3, 0, 0, 1, 0, 0 },
{ 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0 },
{ 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0 },
{ 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0 },
{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
}

local area2 = {
{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
{ 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0 },
{ 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0 },
{ 0, 0, 0, 1, 1, 3, 1, 1, 0, 0, 0 },
{ 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0 },
{ 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0 },
{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
}

combat:setArea(createCombatArea(area))
combat2:setArea(createCombatArea(area2))

function onGetFormulaValues(player, skill, attack, factor)
	local level = player:getLevel()
	
	local min = (level / 5) + (skill + 25) / 3
	local max = (level / 5) + skill + 25

	return -min, -max
end

function onGetFormulaValues2(player, skill, attack, factor)
	local level = player:getLevel()
	
	local min = (level / 5) + (skill + 25) / 3
	local max = (level / 5) + skill + 25

	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")
combat2:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues2")

local function effecto(cid, variant)
    local player = Player(cid)
    if player then
        local pos = player:getPosition()
        Position(pos.x+3, pos.y+1, pos.z):sendDistanceEffect(Position(pos.x+3, pos.y-1, pos.z), config.distance)
        Position(pos.x+3, pos.y-1, pos.z):sendDistanceEffect(Position(pos.x+1, pos.y-3, pos.z), config.distance)
        Position(pos.x+1, pos.y-3, pos.z):sendDistanceEffect(Position(pos.x-1, pos.y-3, pos.z), config.distance)
        Position(pos.x-1, pos.y-3, pos.z):sendDistanceEffect(Position(pos.x-3, pos.y-1, pos.z), config.distance)
        Position(pos.x-3, pos.y-1, pos.z):sendDistanceEffect(Position(pos.x-3, pos.y+1, pos.z), config.distance)
        Position(pos.x-3, pos.y+1, pos.z):sendDistanceEffect(Position(pos.x-1, pos.y+3, pos.z), config.distance)
        Position(pos.x-1, pos.y+3, pos.z):sendDistanceEffect(Position(pos.x+1, pos.y+3, pos.z), config.distance)
        Position(pos.x+1, pos.y+3, pos.z):sendDistanceEffect(Position(pos.x+3, pos.y+1, pos.z), config.distance)
        combat:execute(player, variant)
        combat2:execute(player, variant)
    end
end


local spell = Spell("instant")
function spell.onCastSpell(creature, var)
    local cid = creature:getId()
    for i = 1, config.rounds do
        addEvent(effecto, config.time * (i -1), cid, var)
    end
    return true
end


spell:group("attack")
spell:id(112)
spell:name("Mortal Explosion")
spell:words("mortal explosion")
spell:level(950)
spell:mana(2200)
spell:isPremium(true)
spell:blockWalls(true)
spell:cooldown(1000)
spell:groupCooldown(1000)
spell:needLearn(false)
spell:vocation("sorcerer;true", "master sorcerer;true")
spell:register()