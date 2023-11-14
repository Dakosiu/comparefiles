local healthrunewarriorcoin3 = Spell(SPELL_RUNE)
function healthrunewarriorcoin3.onCastSpell(creature, variant)
    local target = Tile(variant:getPosition()):getTopVisibleCreature(creature)
    if not target or not target:isPlayer() then
        creature:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end
	local mLevel = creature:getMagicLevel()
    local maxHealth = creature:getMaxHealth() / 2
	local min = (mLevel * 300 * 3) + (maxHealth / 1)
	local max = (mLevel * 400 * 4) + (maxHealth / 2)
    target:addHealth(math.random(min, max))
    target:getPosition():sendMagicEffect(313)
    target:getPosition():sendMagicEffect(309)
	target:getPosition():sendMagicEffect(319)
    target:say("Multiverse health hmm...")
    return true
end

healthrunewarriorcoin3:name("third stage warrior health rune")
healthrunewarriorcoin3:isAggressive(false)
healthrunewarriorcoin3:runeId(41179)
healthrunewarriorcoin3:blockWalls(true)
healthrunewarriorcoin3:magicLevel(11)
healthrunewarriorcoin3:level(250)
healthrunewarriorcoin3:group("support")
healthrunewarriorcoin3:id(24)
healthrunewarriorcoin3:cooldown(1 * 1000)
healthrunewarriorcoin3:groupCooldown(1 * 1000)
healthrunewarriorcoin3:isPremium(false)
healthrunewarriorcoin3:charges(1)  -- You can adjust the charges if needed
healthrunewarriorcoin3:register()