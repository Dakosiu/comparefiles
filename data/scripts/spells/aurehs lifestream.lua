local combat = Combat()
local subid = 66

-- local function sendEffect(player_id, effect)
	-- local player = Creature(player_id)
	-- if not player then
	    -- return false
	-- end
	-- if not player:getCondition(CONDITION_ATTRIBUTES, CONDITIONID_DEFAULT, subid) then
	    -- return false
	-- end
	
	-- local pos = player:getPosition()
	-- pos:sendMagicEffect(effect)
	
    -- addEvent(sendEffect, 1000, player_id, effect)
-- end
	

-- Front coming in animation (OB n. 79 "Outfits")
-- Front loop animation (the spell is ON) (OB n. 80 "Outfits")
-- Front going away animation (OB n. 81 "Outfits")

-- Back coming in animation (OB n. 82 "Outfits")
-- Back loop animation (the spell is ON) (OB n. 83 "Outfits")
-- Back going away animation (OB n. 84 "Outfits")

local function testOutfits(cid)
	local player = Player(cid)
	if not player then
	   return false
	end
	
	local outfit = player:getOutfit()
	local states = { 
	                 [1] = { type = "back", id = 82, delay = 0 },
					 [2] = { type = "back", id = 83, delay = 1000 },
					 [3] = { type = "back", id = 84, delay = 3000 },
					 [4] = { type = "front", id = 79, delay = 0 },
					 [5] = { type = "front", id = 80, delay = 1000 },
					 [6] = { type = "front", id = 81, delay = 3000 },
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


local function addBuff(player_id, maxHealth, hpValue)
	local delay = 1000
	testOutfits(player_id)
	for i = 1, 3 do
	    addEvent(function()
	        local player = Player(player_id)
		    if player then
			    local hp = (maxHealth * hpValue) / 100
				local pos = player:getPosition()
			    player:addHealth(math.floor(hp))
				Game.sendAnimatedText('+++' .. "\n" .. hp, pos, 30)
				--pos:sendMagicEffect(77)
			end
		end, delay)
		delay = delay + 1000
	end
end



local spell = Spell("instant")
function spell.onCastSpell(creature, var)
    local id = creature:getId()	
	local maxHealth = creature:getMaxHealth()
	local percent = 22
	addBuff(id, maxHealth, percent)
	combat:execute(creature, var)
	return true
end

spell:group("support")
spell:id(105)
spell:name("Aurehs Lifestream")
spell:words("aurehs lifestream")
spell:level(1)
spell:mana(350)
spell:isPremium(false)
spell:needWeapon(false)
spell:cooldown(20 * 1000)
spell:groupCooldown(1 * 1000)
spell:needLearn(false)
spell:vocation("shepherd of aureh")
spell:register()