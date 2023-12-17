local config = {
                 ["Area"] = {
				              {
                                {0, 1, 0},
                                {1, 3, 1},
                                {0, 1, 0}
                              },
                              {
                                {1, 0, 1},
                                {0, 3, 0},
                                {1, 0, 1}
                              },
                              {
                                {0, 1, 1, 1, 0},
                                {1, 0, 0, 0, 1},
                                {1, 0, 3, 0, 1},
                                {1, 0, 0, 0, 1},
                                {0, 1, 1, 1, 0}
                              },
                              {
                                {1, 0, 0, 0, 1},
                                {0, 0, 0, 0, 0},
                                {0, 0, 3, 0, 0},
                                {0, 0, 0, 0, 0},
                                {1, 0, 0, 0, 1}							    
                              },							  
                              {
                                {0, 0, 0, 0, 0},
                                {0, 0, 1, 0, 0},
                                {0, 1, 3, 1, 0},
                                {0, 0, 1, 0, 0},
                                {0, 0, 0, 0, 0}							    
                              },	
				              {
                                {1, 0, 1, 0, 1},
                                {0, 0, 0, 0, 0},
                                {1, 0, 3, 0, 1},
								{0, 0, 0, 0, 0},
								{1, 0, 1, 0, 1},
                              },							  
				              {
							    {1, 1, 1, 1, 1, 1, 1, 1, 1},
                                {1, 1, 1, 1, 1, 1, 1, 1, 1},
                                {1, 1, 1, 1, 1, 1, 1, 1, 1},
                                {1, 1, 1, 1, 1, 1, 1, 1, 1},
								{1, 1, 1, 1, 3, 1, 1, 1, 1},
								{1, 1, 1, 1, 1, 1, 1, 1, 1},
								{1, 1, 1, 1, 1, 1, 1, 1, 1},
								{1, 1, 1, 1, 1, 1, 1, 1, 1},
                              },	
				              {
							    {1, 1, 1, 1, 1, 1, 1, 1, 1},
                                {1, 1, 1, 1, 1, 1, 1, 1, 1},
                                {1, 1, 1, 1, 1, 1, 1, 1, 1},
                                {1, 1, 1, 1, 1, 1, 1, 1, 1},
								{1, 1, 1, 1, 3, 1, 1, 1, 1},
								{1, 1, 1, 1, 1, 1, 1, 1, 1},
								{1, 1, 1, 1, 1, 1, 1, 1, 1},
								{1, 1, 1, 1, 1, 1, 1, 1, 1},
                              },	
				              {
							    {1, 1, 1, 1, 1, 1, 1, 1, 1},
                                {1, 1, 1, 1, 1, 1, 1, 1, 1},
                                {1, 1, 1, 1, 1, 1, 1, 1, 1},
                                {1, 1, 1, 1, 1, 1, 1, 1, 1},
								{1, 1, 1, 1, 3, 1, 1, 1, 1},
								{1, 1, 1, 1, 1, 1, 1, 1, 1},
								{1, 1, 1, 1, 1, 1, 1, 1, 1},
								{1, 1, 1, 1, 1, 1, 1, 1, 1},
                              },								  
							  
                            },
                 ["Combats"] = {
				                 [1] = { effect = 37, type = COMBAT_EARTHDAMAGE, delay = 0 },
								 [2] = { effect = 45, type = COMBAT_EARTHDAMAGE, delay = 100 },
								 [3] = { effect = 37, type = COMBAT_EARTHDAMAGE, delay = 200 },
								 [4] = { effect = 45, type = COMBAT_ICEDAMAGE, delay = 300 },
								 [5] = { effect = 37, type = COMBAT_WATERDAMAGE, delay = 400 },
								 [6] = { effect = 45, type = COMBAT_ICEDAMAGE, delay = 500 },
								 [7] = { effect = 37, type = COMBAT_ICEDAMAGE, delay = 600 },
								 [8] = { effect = 45, type = COMBAT_ICEDAMAGE, delay = 700 },
								 [9] = { effect = 16, type = COMBAT_ICEDAMAGE, delay = 800 },
							   }
				}

local custom_combat = {}
function onGetFormulaValues(player, level, maglevel)
	local min = (level / 2) + (maglevel * 8) + 300
	local max = (level / 5) + (maglevel * 11) + 600
	return -min, -max
end							   
							   

for i, v in pairs(config["Combats"]) do
    custom_combat[i] = Combat()
	custom_combat[i]:setParameter(COMBAT_PARAM_TYPE, v.type)
    custom_combat[i]:setParameter(COMBAT_PARAM_EFFECT, v.effect)
	--custom_combat[i]:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")
end

for i, _ in ipairs(config["Area"]) do
    custom_combat[i]:setArea(createCombatArea(config["Area"][i]))
end

local spell = Spell("instant")

function spell.onCastSpell(creature, var)

    local delay = 0
	local player = Player(creature)
	local level = player:getLevel()
    local maglevel = player:getMagicLevel()
    local min = (level / 5) + (maglevel * 1.4) + 8
    local max = (level / 5) + (maglevel * 2.2) + 14
	
	
	for i, v in pairs(config["Combats"]) do
	    if i < 4 or i == #config["Combats"] then
	       custom_combat[i]:setFormula(COMBAT_FORMULA_LEVELMAGIC, 0, -min, 0, -max)
		end
	    addEvent(function()
		   custom_combat[i]:execute(player, var)
        end, v.delay)
	end
	return false
end

spell:group("attack", "focus")
spell:id(119)
spell:name("Fire Shower")
spell:words("fire shower")
spell:level(450)
spell:mana(600)
--spell:isSelfTarget(true)
spell:isPremium(true)
spell:cooldown(1000)
spell:groupCooldown(1000)
spell:needLearn(false)
spell:vocation("sorcerer;true", "master sorcerer;true")
spell:register()

