local spell = Spell("instant")
function spell.onCastSpell(creature, variant)
    	
	local player = Player(creature)
	if player then
	   if player:getMana() <= 0 then
	      return true
	   end
	   player:addManaSpent(player:getMana())
	   player:addMana(-player:getMana())
	end
	return true
end

spell:name("Release Mana")
spell:words("release mana")
spell:group("healing")
--spell:vocation("elite knight;true")
spell:id(3)
spell:cooldown(1000)
spell:groupCooldown(1000)
spell:level(0)
spell:mana(0)
spell:isSelfTarget(true)
spell:isAggressive(false)
spell:needLearn(false)
spell:register()