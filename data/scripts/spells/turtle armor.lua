local combat = Combat()
local subid = 66

local function testOutfits(cid)
	local player = Player(cid)
	if not player then
	   return false
	end
	
	local outfit = player:getOutfit()
	local states = { 
	                 [1] = { type = "back", id = 41, delay = 0 },
					 [2] = { type = "back", id = 42, delay = 1000 },
					 [3] = { type = "back", id = 43, delay = 9900 },
					 [4] = { type = "front", id = 44, delay = 0 },
					 [5] = { type = "front", id = 45, delay = 1000 },
					 [6] = { type = "front", id = 46, delay = 9900 },
				   }
	for i, v in ipairs(states) do
		addEvent(function()
		   if v.type == "back" then
		      outfit.lookAuraBack = v.id
		   else
		      outfit.lookAuraFront = v.id
		   end
		   player:setOutfit(outfit)
		end, v.delay)
	end
	
	addEvent(function()
	    outfit.lookAuraBack = 0
		outfit.lookAuraFront = 0
		player:setOutfit(outfit)
	end, states[#states].delay + 500) 
	 
end

local function sendEffect(player_id, effect)
	local player = Creature(player_id)
	if not player then
	    return false
	end
	if not player:getCondition(CONDITION_ATTRIBUTES, CONDITIONID_DEFAULT, subid) then
	    return false
	end
	
	local pos = player:getPosition()
	pos:sendMagicEffect(effect)
	
    --addEvent(sendEffect, 1000, player_id, effect)
end
	
	


local function addBuff(player, value, interval)
    local condition = Condition(CONDITION_ATTRIBUTES, CONDITIONID_DEFAULT)
	condition:setParameter(CONDITION_PARAM_BUFF_DEFENSE, value)
	condition:setParameter(CONDITION_PARAM_SUBID, subid)
	condition:setTicks(interval)
	player:addCondition(condition)
	local player_id = player:getId()
	testOutfits(player_id)
	--sendEffect(player_id, 77)
end



local spell = Spell("instant")
function spell.onCastSpell(creature, var)	
	local target = creature:getTarget()
	if target then
	    --print("Target: " .. target:getName())
		addBuff(target, 80, 10 * 1000)
		combat:execute(target, var)
		return true
	end
	addBuff(creature, 80, 10 * 1000)
	combat:execute(creature, var)
	return true
end

spell:group("support")
spell:id(105)
spell:name("Turtle Armor")
spell:words("turtle armor")
spell:level(1)
spell:mana(350)
spell:isPremium(false)
spell:needWeapon(false)
spell:cooldown(20 * 1000)
spell:groupCooldown(1 * 1000)
spell:needLearn(false)
spell:vocation("jade mystic")
spell:register()