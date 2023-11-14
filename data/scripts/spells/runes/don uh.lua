local runeTest = Spell(SPELL_RUNE)
function runeTest.onCastSpell(creature, variant)
    local target = Tile(variant:getPosition()):getTopVisibleCreature(creature)
    if not target or not target:isPlayer() then
        creature:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end
	local mLevel = creature:getMagicLevel()
    local maxHealth = creature:getMaxHealth() / 100
	local min = (mLevel * 3) + (maxHealth * 55)
	local max = (mLevel * 6) + (maxHealth * 72)
    target:addHealth(math.random(min, max))
    target:getPosition():sendMagicEffect(CONST_ME_HITBYPOISON)
	target:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
    target:say("don uh...")
    return true
end

runeTest:name("donation uh rune")
runeTest:isAggressive(false)
runeTest:runeId(2270)
runeTest:blockWalls(true)
runeTest:magicLevel(1)
runeTest:level(250)
runeTest:group("support")
runeTest:id(24)
runeTest:cooldown(1 * 500)
runeTest:groupCooldown(1 * 500)
runeTest:isPremium(false)
runeTest:register()