local combat = Combat()
local spell = Spell("instant")

local function getFormula(summon)
    
	if not summon then
	   return 0
	end
	
	local min = 100 + (summon:getLevel() * 0.075)
	local max = 200 + (summon:getLevel() * 0.075)
	
	return math.random(min, max)
end

function spell.onCastSpell(creature, variant)
    
	local player = Player(creature)
	if not player then
	   return false
	end
	
    local summon = getSummonByPlayer(player)
	if not summon then
	   player:sendCancelMessage("You can't use this spell with no summon.")
	   return false
	end
	
	local monster = summon:getCreature()
	if not monster then
	   player:sendCancelMessage("You can't use this spell with no summon.")
	   return false
	end
	
	monster:addHealth(getFormula(summon))	
	creature:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
	return combat:execute(creature, variant)
end

spell:name("Heal Summon")
spell:words("exura summon")
spell:group("healing")
spell:vocation("druid;true", "elder druid;true", "knight;true", "elite knight;true", "paladin;true",
               "royal paladin;true", "sorcerer;true", "master sorcerer;true")
spell:id(666)
spell:cooldown(1000)
spell:groupCooldown(1000)
spell:level(18)
spell:mana(120)
spell:allowOnSelf(false)
spell:isAggressive(false)
spell:isPremium(true)
spell:register()