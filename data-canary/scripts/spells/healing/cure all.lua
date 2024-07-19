local conditions = {
CONDITION_DROWN,
CONDITION_PARALYZE,
CONDITION_CURSED,
CONDITION_POISON,
CONDITION_BLEEDING,
CONDITION_FIRE,
CONDITION_ENERGY
}
local combat = {}
for i = 1, #conditions do
    combat[i] = Combat()
    combat[i]:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
    combat[i]:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
    combat[i]:setParameter(COMBAT_PARAM_DISPEL, conditions[i])
end
local function dispel(creature, var)
    for x = 1, #conditions do
        combat[x]:execute(creature, var)
    end
    return true
end

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
    return dispel(creature, var)
end

spell:name("Cure All")
spell:words("exana all")
spell:group("healing")
spell:vocation("druid;true", "elder druid;true", "knight;true", "elite knight;true")
spell:id(29)
spell:cooldown(60000)
spell:groupCooldown(1000)
spell:level(45)
spell:mana(30)
spell:isSelfTarget(true)
spell:isAggressive(false)
spell:needLearn(true)
spell:isPremium(false)
spell:register()



local scrollConfig = {
                       itemid = 28461,
					   spellName = "Cure All"
					 }
local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    
	if player:hasLearnedSpell(scrollConfig.spellName) then
	   player:sendCancelMessage("You have already learned this spell.")
	   return true
	end
	
	player:learnSpell(scrollConfig.spellName)
	player:sendTextMessage(MESSAGE_INFO_DESCR, 'You have learned Cure All("Exana All") spell.')
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	item:remove(1)
	
	return true
end
action:id(scrollConfig.itemid)
action:register()