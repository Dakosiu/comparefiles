local combat = Combat()
-- local subid = 90

-- local function addBuff(player_id, maxHealth, hpValue, damageValue, damageDuration)
	-- local delay = 0
    -- local condition = Condition(CONDITION_ATTRIBUTES, CONDITIONID_DEFAULT)
	-- condition:setParameter(CONDITION_PARAM_BUFF_DAMAGE, damageValue)
	-- condition:setParameter(CONDITION_PARAM_SUBID, subid)
	-- condition:setTicks(damageDuration)
	-- local c = Player(player_id) 
	-- if c then
	   -- c:addCondition(condition)
	-- end
	-- for i = 1, 10 do
	    -- addEvent(function()
	        -- local player = Player(player_id)
		    -- if player then
			    -- local hp = (maxHealth * hpValue) / 100
				-- local pos = player:getPosition()
			    -- player:addHealth(math.floor(hp))
				-- pos:sendMagicEffect(77)
				-- Game.sendAnimatedText('+++' .. "\n" .. hp, pos, 30)
			-- end
		-- end, delay)
		-- delay = delay + 1000
	-- end
-- end

local function testOutfits(cid)
	local player = Player(cid)
	if not player then
	   return false
	end
	
	local outfit = player:getOutfit()
	local states = { 
	                 [1] = { type = "front", id = 85, delay = 0 },
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

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, 86)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, true)
combat:setParameter(COMBAT_PARAM_USECHARGES, true)
combat:setArea(createCombatArea(AREA_SQUARE1X1))

function onGetFormulaValues(player, skill, attack, factor)
	local min = (player:getLevel() / 5) + (skill * attack * 0.06) + 13
	local max = (player:getLevel() / 5) + (skill * attack * 0.11) + 27
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

local spell = Spell("instant")
function spell.onCastSpell(creature, var)
    local id = creature:getId()	
	-- local maxHealth = creature:getMaxHealth()
	-- local percent = 25
	-- addBuff(id, maxHealth, percent, 20, 10 * 1000)
	testOutfits(id)
	local delay = 500
	for i = 1, 10 do
	    addEvent(function(id)
		   local caster = Creature(id)
		   if caster then
		      --combat:execute(caster, var)
			  caster:castSpell("Berserk")
	       end
		end, delay, id)
		delay = delay + 500
	end
	return true
end

spell:group("support")
spell:id(105)
spell:name("Groundshake")
spell:words("Groundshake")
spell:level(1)
spell:mana(75)
spell:isPremium(false)
spell:needWeapon(false)
spell:cooldown(5 * 1000)
spell:groupCooldown(1 * 1000)
spell:needLearn(false)
spell:vocation("Kokao Warrior")
spell:register()