local healthrunewarriorcoin1 = Spell(SPELL_RUNE)
function healthrunewarriorcoin1.onCastSpell(creature, variant)
    local target = Tile(variant:getPosition()):getTopVisibleCreature(creature)
    if not target or not target:isPlayer() then
        creature:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end
	local mLevel = creature:getMagicLevel()
    local maxHealth = creature:getMaxHealth() / 6
	local min = (mLevel * 100 * 2) + (maxHealth / 1)
	local max = (mLevel * 200 * 3) + (maxHealth / 2)
    target:addHealth(math.random(min, max))
    target:getPosition():sendMagicEffect(199)
    target:getPosition():sendMagicEffect(244)
    target:say("Etherical health hmm...")
    return true
end

healthrunewarriorcoin1:name("first stage warrior health rune")
healthrunewarriorcoin1:isAggressive(false)
healthrunewarriorcoin1:runeId(41181)
healthrunewarriorcoin1:blockWalls(true)
healthrunewarriorcoin1:magicLevel(8)
healthrunewarriorcoin1:level(150)
healthrunewarriorcoin1:group("support")
healthrunewarriorcoin1:id(24)
healthrunewarriorcoin1:cooldown(1 * 1000)
healthrunewarriorcoin1:groupCooldown(1 * 1000)
healthrunewarriorcoin1:isPremium(false)
healthrunewarriorcoin1:charges(1)  -- You can adjust the charges if needed
healthrunewarriorcoin1:register()