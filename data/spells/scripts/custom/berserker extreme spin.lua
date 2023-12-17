<<<<<<< HEAD
-- Delay between animations.
local animationDelay = 300
local combat = {}

-- Frames (1 = Area, 2 = Player, 3 = Player + Self Damaging)
local area = {
    {
        {0,0,1,0,0},
        {0,0,1,0,0},
        {0,0,2,0,0},
        {0,0,1,0,0},
        {0,0,1,0,0}
    },
    {
        {0,0,0,0,1},
        {0,0,0,1,0},
        {0,0,2,0,0},
        {0,1,0,0,0},
        {1,0,0,0,0}
    },
    {
	    {0,0,0,0,0},
        {0,0,0,0,0},
        {1,1,2,1,1},
        {0,0,0,0,0},
        {0,0,0,0,0}
    },
	{
	    {1,0,0,0,0},
        {0,1,0,0,0},
        {0,0,2,0,0},
        {0,0,0,1,0},
        {0,0,0,0,1}
    },
	{
        {0,0,1,0,0},
        {0,0,1,0,0},
        {0,0,2,0,0},
        {0,0,1,0,0},
        {0,0,1,0,0}
    },
	{
        {0,0,0,0,1},
        {0,0,0,1,0},
        {0,0,2,0,0},
        {0,1,0,0,0},
        {1,0,0,0,0}
    },
	{
        {0,0,0,0,0},
        {0,0,0,0,0},
        {1,1,2,1,1},
        {0,0,0,0,0},
        {0,0,0,0,0}
    }
}

for i = 1, #area do
    combat[i] = Combat()
    combat[i]:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
    combat[i]:setParameter(COMBAT_PARAM_EFFECT, 35)
end

for x, _ in ipairs(area) do
    combat[x]:setArea(createCombatArea(area[x]))
end

function executeCombat(p, i)
    if not p.player then
        return false
    end
    if not p.player:isPlayer() then
            return false
    end
    p.combat[i]:execute(p.player, p.var)
end

function onCastSpell(player, var)

    local p = {player = player, var = var, combat = combat}

   -- Damage formula
    local level = player:getLevel()
    local maglevel = player:getMagicLevel()
    local melee = player:getMeleeSkill()
    local min = (level * 40) + (melee * 40) + 5000
    local max = (level * 60) + (melee * 60) + 6000
    for i = 1, #area do
        combat[i]:setFormula(COMBAT_FORMULA_LEVELMAGIC, 0, -min, 0, -max)
        if i == 1 then
            combat[i]:execute(player, var)
        else
            addEvent(executeCombat, (animationDelay * i) - animationDelay, p, i)
        end
    end

    return true
=======
-- Delay between animations.
local animationDelay = 300
local combat = {}

-- Frames (1 = Area, 2 = Player, 3 = Player + Self Damaging)
local area = {
    {
        {0,0,1,0,0},
        {0,0,1,0,0},
        {0,0,2,0,0},
        {0,0,1,0,0},
        {0,0,1,0,0}
    },
    {
        {0,0,0,0,1},
        {0,0,0,1,0},
        {0,0,2,0,0},
        {0,1,0,0,0},
        {1,0,0,0,0}
    },
    {
	    {0,0,0,0,0},
        {0,0,0,0,0},
        {1,1,2,1,1},
        {0,0,0,0,0},
        {0,0,0,0,0}
    },
	{
	    {1,0,0,0,0},
        {0,1,0,0,0},
        {0,0,2,0,0},
        {0,0,0,1,0},
        {0,0,0,0,1}
    },
	{
        {0,0,1,0,0},
        {0,0,1,0,0},
        {0,0,2,0,0},
        {0,0,1,0,0},
        {0,0,1,0,0}
    },
	{
        {0,0,0,0,1},
        {0,0,0,1,0},
        {0,0,2,0,0},
        {0,1,0,0,0},
        {1,0,0,0,0}
    },
	{
        {0,0,0,0,0},
        {0,0,0,0,0},
        {1,1,2,1,1},
        {0,0,0,0,0},
        {0,0,0,0,0}
    }
}

for i = 1, #area do
    combat[i] = Combat()
    combat[i]:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
    combat[i]:setParameter(COMBAT_PARAM_EFFECT, 35)
end

for x, _ in ipairs(area) do
    combat[x]:setArea(createCombatArea(area[x]))
end

function executeCombat(p, i)
    if not p.player then
        return false
    end
    if not p.player:isPlayer() then
            return false
    end
    p.combat[i]:execute(p.player, p.var)
end

function onCastSpell(player, var)

    local p = {player = player, var = var, combat = combat}

   -- Damage formula
    local level = player:getLevel()
    local maglevel = player:getMagicLevel()
    local melee = player:getMeleeSkill()
    local min = (level * 40) + (melee * 40) + 5000
    local max = (level * 60) + (melee * 60) + 6000
    for i = 1, #area do
        combat[i]:setFormula(COMBAT_FORMULA_LEVELMAGIC, 0, -min, 0, -max)
        if i == 1 then
            combat[i]:execute(player, var)
        else
            addEvent(executeCombat, (animationDelay * i) - animationDelay, p, i)
        end
    end

    return true
>>>>>>> 8900eb460efeecbd5e68adf2d4e6fc52d6346528
end