local combat = {}
local config = {
                 ["Combo"] = { times = 3, delay = 500 }, 
                 ["Combats"] = { 
				                [1] = { effect = 47, distanceEffect = 15, type = COMBAT_ENERGYDAMAGE, delay = 0 },
								[2] = { effect = 46, distanceEffect = 30, type = COMBAT_HOLYDAMAGE, delay = 200 },
								[3] = { effect = 55, distanceEffect = 15, type = COMBAT_ENERGYDAMAGE, delay = 300 },
								[4] = { effect = 9, distanceEffect = 30, type = COMBAT_ENERGY_DAMAGE, delay = 400 },
								[5] = { effect = 17, distanceEffect = 15, type = COMBAT_EARTHDAMAGE, delay = 500 },
							   }
							   
				}


for i, v in pairs(config["Combats"]) do
    combat[i] = Combat()
	combat[i]:setParameter(COMBAT_PARAM_TYPE, v.type)
    combat[i]:setParameter(COMBAT_PARAM_EFFECT, v.effect)
	combat[i]:setParameter(COMBAT_PARAM_DISTANCEEFFECT, v.distanceEffect)
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
end

spell:group("attack")
spell:id(112)
spell:name("Tera Combo")
spell:words("tera combo")
spell:level(900)
spell:mana(2200)
spell:isPremium(true)
spell:range(3)
spell:needCasterTargetOrDirection(true)
spell:blockWalls(true)
spell:cooldown(7 * 1000)
spell:groupCooldown(1000)
spell:needLearn(false)
spell:vocation("druid;true", "elder druid;true")
spell:register()