local combat = Combat()
local subid = 65

local function sendEffect(player_id, effect)
	local player = Player(player_id)
	if not player then
	    return false
	end
	if not player:getCondition(CONDITION_ATTRIBUTES, CONDITIONID_DEFAULT, subid) then
	    return false
	end
	
	local pos = player:getPosition()
	pos:sendMagicEffect(effect)
	
    addEvent(sendEffect, 1000, player_id, effect)
end
	
	
local function testOutfits(cid)
	local player = Player(cid)
	if not player then
	   return false
	end
	
	local outfit = player:getOutfit()
	local states = { 
	                 [1] = { type = "front", id = 92, delay = 0 },
					 [2] = { type = "front", id = 93, delay = 1000 },
					 [3] = { type = "front", id = 94, delay = 9900 },
					 [4] = { type = "back", id = 89, delay = 0 },
					 [5] = { type = "back", id = 90, delay = 1000 },
					 [6] = { type = "back", id = 91, delay = 9900 },
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
	end, states[#states].delay + 1000) 
	 
end
	


local function addBuff(player, hpValue, reflectValue, interval)
    local condition = Condition(CONDITION_ATTRIBUTES, CONDITIONID_DEFAULT)
	--condition:setParameter(CONDITION_PARAM_STAT_MAXHITPOINTS, hpValue)
	condition:setParameter(CONDITION_PARAM_BUFF_REFLECT, reflectValue)
	condition:setParameter(CONDITION_PARAM_SUBID, subid)
	condition:setTicks(interval)
	player:addCondition(condition)
	player:setShield(400)
	player:sendProgressBar(-1, true)
	
	
	
	local player_id = player:getId()
	addEvent(function(id)
	   local p = Player(id)
	   if p then
	      p:setShield(0)
		  p:sendProgressBar(0, true)
	   end
	end, interval, player_id)
	
	
	--sendEffect(player_id, 55)
	testOutfits(player_id)
	--player:addHealth(hpValue)
end



local spell = Spell("instant")
function spell.onCastSpell(creature, var)
    addBuff(creature, 400, 15, 10 * 1000)
	--print("Creature: " .. creature:getName() .. "Reflect: " .. creature:getBuff(BUFF_REFLECT))
	return combat:execute(creature, var)
end

spell:group("support")
spell:id(105)
spell:name("Kaer Armouring")
spell:words("Kaer Armouring")
spell:level(1)
spell:mana(350)
spell:isPremium(false)
spell:needWeapon(false)
spell:cooldown(20 * 1000)
spell:groupCooldown(1 * 1000)
spell:needLearn(false)
spell:vocation("kaer disciple")
spell:register()