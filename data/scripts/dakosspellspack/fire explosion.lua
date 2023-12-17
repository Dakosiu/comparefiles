local animationDelay = 100
local combat = {}
local formulas = {}


local area = {
    {
        {0,0,0,1,1,1,0,0,0},
        {0,0,1,1,0,1,1,0,0},
        {0,1,1,0,0,0,1,1,0},
        {1,1,0,0,0,0,0,1,1},
        {1,0,0,0,2,0,0,0,1},
        {1,1,0,0,0,0,0,1,1},
        {0,1,1,0,0,0,1,1,0},
        {0,0,1,1,0,1,1,0,0},
        {0,0,0,1,1,1,0,0,0}
    },
    {
        {0,0,0,1,0,0,0},
        {0,0,1,0,1,0,0},
        {0,1,0,0,0,1,0},
        {1,0,0,2,0,0,1},
        {0,1,0,0,0,1,0},
        {0,0,1,0,1,0,0},
        {0,0,0,1,0,0,0}
    },
    {
        {0,0,1,0,0},
        {0,1,0,1,0},
        {1,0,2,0,1},
        {0,1,0,1,0},
        {0,0,1,0,0}
    },
    {
        {0,1,0},
        {1,2,1},
        {0,1,0}
    },
    {
        {3}
    }

}
function onGetFormulaValues1(player, level, magicLevel)
	local min = (level / 5) + (magicLevel * 5.5) + 25
	local max = (level / 5) + (magicLevel * 11) + 50
	return -min, -max
end

function onGetFormulaValues2(player, level, magicLevel)
	local min = (level / 5) + (magicLevel * 5.5) + 25
	local max = (level / 5) + (magicLevel * 11) + 50
	return -min, -max
end

function onGetFormulaValues3(player, level, magicLevel)
	local min = (level / 5) + (magicLevel * 5.5) + 25
	local max = (level / 5) + (magicLevel * 11) + 50
	return -min, -max
end

function onGetFormulaValues4(player, level, magicLevel)
	local min = (level / 5) + (magicLevel * 5.5) + 25
	local max = (level / 5) + (magicLevel * 11) + 50
	return -min, -max
end

function onGetFormulaValues5(player, level, magicLevel)
	local min = (level / 5) + (magicLevel * 5.5) + 25
	local max = (level / 5) + (magicLevel * 11) + 50
	return -min, -max
end

for i = 1, #area do
    combat[i] = Combat()
    combat[i]:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
    combat[i]:setParameter(COMBAT_PARAM_EFFECT,  16)		
	combat[i]:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues" .. i)
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




local spell = Spell("instant")
function spell.onCastSpell(creature, var)
	local player = Player(creature)	
    local p = {player = player, var = var, combat = combat}

    for i = 1, #area do
        if i == 1 then
            combat[i]:execute(player, var)
        else
            addEvent(executeCombat, (animationDelay * i) - animationDelay, p, i)
        end
    end
end
spell:group("attack")
spell:id(112)
spell:name("Fire Explosion")
spell:words("fire explosion")
spell:level(150)
spell:mana(300)
spell:isPremium(true)
spell:blockWalls(true)
spell:cooldown(1000)
spell:groupCooldown(1000)
spell:needLearn(false)
spell:vocation("sorcerer;true", "master sorcerer;true")
spell:register()