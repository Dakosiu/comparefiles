local combat = {}
local config = {
                 ["Combo"] = { times = 1, delay = 100 }, 
                 ["Combats"] = { 
				                [1] = { 
								        effect = 18, 
								        distanceEffect = 94, 
										type = COMBAT_PHYSICALDAMAGE, 
										delay = 0, 
										condition = { 
										                type = CONDITION_CURSED, 
														rounds = { 
														            [1] = { ticks = 1, delay = 1000, damage = -500 },
																	[2] = { ticks = 1, delay = 1000, damage = -400 },
																	[3] = { ticks = 1, delay = 1000, damage = -300 },
																	[4] = { ticks = 1, delay = 1000, damage = -200 },
																	[5] = { ticks = 1, delay = 1000, damage = -100 }
																 },
								                    }
									  },
								[2] = { effect = 333, distanceEffect = 94, type = COMBAT_PHYSICALDAMAGE, delay = 250 },
							   }
							   
				}


for i, v in pairs(config["Combats"]) do
    combat[i] = Combat()
	combat[i]:setParameter(COMBAT_PARAM_TYPE, v.type)
    combat[i]:setParameter(COMBAT_PARAM_EFFECT, v.effect)
	combat[i]:setParameter(COMBAT_PARAM_DISTANCEEFFECT, v.distanceEffect)
	local conditionTable = v.condition
	if conditionTable then
	    local condition = Condition(conditionTable.type)
	    condition:setParameter(CONDITION_PARAM_DELAYED, 1)
	    for i, v in ipairs(conditionTable.rounds) do
	        condition:addDamage(v.ticks, v.delay, v.damage)
		end
	combat[i]:addCondition(condition)
	end
end

local function getPositions(creature, direction)
   
   if not creature then
      return nil
   end
   
   local position = creature:getPosition()
   local y = position.y
   local x = position.x
   local z = position.z
   
   local positionTable = {
   		                   [1] = { 
							             ["From"] = Position(x, y - 1, z),
										 ["To"] = Position(x, y + 1, z)
									   },
   		                   [2] = { 
							             ["From"] = Position(x + 1, y, z),
										 ["To"] = Position(x - 1, y, z)
									   },
   		                   [3] = { 
							             ["From"] = Position(x, y + 1, z),
										 ["To"] = Position(x, y - 1, z)
									   },
   		                   [4] = { 
							             ["From"] = Position(x - 1, y, z),
										 ["To"] = Position(x + 1, y, z)
									   },									   
						 }
	
	
    return positionTable
end

local function sendEffect(positionTable, id)

	for i, v in pairs(positionTable) do
		local from = v["From"]
		local to = v["To"]
		from:sendDistanceEffect(to, id)
	end
end

local function sendSpell(creature_id, target_id, var)
	       local target = Creature(target_id)
		   local self = Creature(creature_id)
		   if not target or not self then
		      return false
		   end
	       for i, v in pairs(config["Combats"]) do
	          addEvent(function(creature_id, target_id)
	             local target = Creature(target_id)
		         local self = Creature(creature_id)
		         if not target or not self then
		            return false
		         end
		         combat[i]:execute(self, var)
		         local positionTable = getPositions(target)
		         local effect = v.distanceEffect
		         local id = v.distanceEffect
		         --sendEffect(positionTable, id)
              end, v.delay, self:getId(), target:getId())
		   end
end

function onGetFormulaValues(player, skill, attack, factor)
	local level = player:getLevel()
	
	local min = (level / 5) + (skill + 25) / 3
	local max = (level / 5) + skill + 25

	return -min, -max
end

combat[1]:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")
	
	
local spell = Spell("instant")

function spell.onCastSpell(creature, var)

    local player = Player(creature)
	local target = Creature(var.number)
	if not target then
	   return false
	end
		
	local delay = 0
	for z = 1, config["Combo"].times do
	    addEvent(function(creature_id, target_id)
        sendSpell(creature_id, target_id, var)
	    end, delay, player:getId(), target:getId()) 
	delay = delay + config["Combo"].delay
	end
	return true
end

spell:group("attack, special")
spell:id(1122)
spell:name("Cursed shot")
spell:words("cursed shot")
spell:level(650)
spell:mana(1300)
spell:isPremium(true)
spell:range(5)
spell:needCasterTargetOrDirection(true)
spell:blockWalls(true)
spell:cooldown(7 * 1000)
spell:groupCooldown(1000)
spell:needLearn(false)
spell:vocation("sorcerer;true", "master sorcerer;true")
spell:register()