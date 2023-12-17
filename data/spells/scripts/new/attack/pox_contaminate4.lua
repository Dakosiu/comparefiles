-- Delay between animations.
local animationDelay = 500
local combat = {}

-- Frames (1 = Area, 2 = Player, 3 = Player + Self Damaging)
local area = {
    {
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 1, 3, 1, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
    },
    {
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0},
    {0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0},
    {0, 0, 0, 1, 0, 3, 0, 1, 0, 0, 0},
    {0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0},
    {0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
    },
    {
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0},
    {0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0},
    {0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0},
    {0, 0, 1, 0, 0, 3, 0, 0, 1, 0, 0},
    {0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0},
    {0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0},
    {0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
    },
    {
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0},
    {0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0},
    {0, 1, 1, 0, 0, 0, 0, 0, 1, 1, 0},
    {0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0},
    {0, 1, 0, 0, 0, 3, 0, 0, 0, 1, 0},
    {0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0},
    {0, 1, 1, 0, 0, 0, 0, 0, 1, 1, 0},
    {0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0},
    {0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0}
    },

}

local condition = Condition(CONDITION_POISON)
condition:setParameter(CONDITION_PARAM_DELAYED, 1)
condition:addDamage(3, 1000, -55000)
condition:addDamage(3, 800, -40000)
condition:addDamage(3, 600, -32000)
condition:addDamage(3, 400, -26000)
condition:addDamage(3, 200, -17000)

for i = 1, #area do
    combat[i] = Combat()
    combat[i]:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
    combat[i]:setParameter(COMBAT_PARAM_EFFECT, 47)
    combat[i]:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 64)
    combat[i]:addCondition(condition)

end

for x, _ in ipairs(area) do
    combat[x]:setArea(createCombatArea(area[x]))
end


local function executeCombat(_combat, player, var) -- Since we execute it only within this script, it can be a local function
	player = Player(player) -- player was cid, then we transform it to player userdata
	if not player then
		 return
	end
	_combat:execute(player, var)
end

function onCastSpell(creature, var)
	local player = creature:getPlayer()
	if not player then
		 return false -- Only players can cast it
	end

	-- Damage formula
	local level = creature:getLevel()
	local maglevel = creature:getMagicLevel()
	local min = (level * 50) + (maglevel * 25) + 9000
	local max = (level * 60) + (maglevel * 30) + 18000

	for i = 1, #area do
		 combat[i]:setFormula(COMBAT_FORMULA_LEVELMAGIC, 0, -min, 0, -max)
		 if i == 1 then
			  combat[i]:execute(player, var)
		 else
			  addEvent(executeCombat, (animationDelay * i) - animationDelay, combat[i], player:getId(), var) -- You should always pass creatures cid, instead userdata (object) within addEvent
		 end
	end

	return true
end