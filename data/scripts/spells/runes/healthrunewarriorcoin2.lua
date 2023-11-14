local healthrunewarriorcoin2 = Spell(SPELL_RUNE)
function healthrunewarriorcoin2.onCastSpell(creature, variant)
    local target = Tile(variant:getPosition()):getTopVisibleCreature(creature)
    if not target or not target:isPlayer() then
        creature:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end
	local mLevel = creature:getMagicLevel()
    local maxHealth = creature:getMaxHealth() / 3
	local min = (mLevel * 200 * 2) + (maxHealth / 1)
	local max = (mLevel * 300 * 3) + (maxHealth / 2)
    target:addHealth(math.random(min, max))
    target:getPosition():sendMagicEffect(36)
    target:getPosition():sendMagicEffect(329)
    target:say("Duality health hmm...")
    return true
end

healthrunewarriorcoin2:name("second stage warrior health rune")
healthrunewarriorcoin2:isAggressive(false)
healthrunewarriorcoin2:runeId(41178)
healthrunewarriorcoin2:blockWalls(true)
healthrunewarriorcoin2:magicLevel(9)
healthrunewarriorcoin2:level(200)
healthrunewarriorcoin2:group("support")
healthrunewarriorcoin2:id(24)
healthrunewarriorcoin2:cooldown(1 * 1000)
healthrunewarriorcoin2:groupCooldown(1 * 1000)
healthrunewarriorcoin2:isPremium(false)
healthrunewarriorcoin2:charges(1)  -- You can adjust the charges if needed
healthrunewarriorcoin2:register()