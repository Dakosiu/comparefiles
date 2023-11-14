-- Delay between animations in milliseconds.
local animationDelay = 100
local combat = {}

-- Frames (1 = Area, 2 = Player, 3 = Player + Self Damaging)
local area = {
    {
        {0,0,0},
        {0,2,0},
        {1,0,0}
    },
    {
        {0,0,0},
        {1,2,0},
        {0,0,0}
    },
    {
        {1,0,0},
        {0,2,0},
        {0,0,0}
    },
    {
        {0,1,0},
        {0,2,0},
        {0,0,0}
    },
    {
        {0,0,1},
        {0,2,0},
        {0,0,0}
    },
    {
        {0,0,0},
        {0,2,1},
        {0,0,0}
    },
    {
        {0,0,0},
        {0,2,0},
        {0,0,1}
    },
    {
        {0,0,0},
        {0,2,0},
        {0,1,0}
    },
    {
        {0,0,0},
        {0,2,0},
        {1,0,0}
    }
}

-- Create a new Combat object for each frame and set its parameters
for i = 1, #area do
    combat[i] = Combat()
    combat[i]:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
    combat[i]:setParameter(COMBAT_PARAM_EFFECT, 176)
end

-- Set the area of effect for each Combat object using the area tables
for x, _ in ipairs(area) do
    combat[x]:setArea(createCombatArea(area[x]))
end

-- Function to execute a Combat object in a given frame
function executeCombat(p, i)
    -- Make sure the target is a player
    if not p.player or not p.player:isPlayer() then
        return false
    end

    -- Execute the Combat object
    p.combat[i]:execute(p.player, p.var)
end

function onCastSpell(player, var)
    -- Create a table to store player and variable data for use in the executeCombat function
    local p = {player = player, var = var, combat = combat}

    -- Damage formula
    local level = player:getLevel()
    local maglevel = player:getMagicLevel()
    local min = (level * 10) + (maglevel * maglevel) + 3000
	local max = (level * 10) + (maglevel * maglevel) + 3500

    -- Execute the Combat object for each frame, with a delay between each frame
    for i = 1, #area do
        -- Set the damage formula for the Combat object
        combat[i]:setFormula(COMBAT_FORMULA_LEVELMAGIC, 0, -min, 0, -max)
        if i == 1 then
            combat[i]:execute(player, var)
        else
            addEvent(executeCombat, (animationDelay * i) - animationDelay, p, i)
        end
    end

    return true
end