local runeTest = Spell(SPELL_RUNE)
function runeTest.onCastSpell(creature, variant)
    local target = Tile(variant:getPosition()):getTopVisibleCreature(creature)
    if not target or not target:isPlayer() then
        creature:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end
	local mLevel = creature:getMagicLevel()
    local maxHealth = creature:getMaxHealth() / 100
	local min = (mLevel * 2) + (maxHealth * 50)
	local max = (mLevel * 5) + (maxHealth * 65)
    target:addHealth(math.random(min, max))
    target:getPosition():sendMagicEffect(CONST_ME_SOUND_GREEN)
	target:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
    target:say("ughh health...")
    return true
end

runeTest:name("quest uhrune")
runeTest:isAggressive(false)
runeTest:runeId(2284)
runeTest:blockWalls(true)
runeTest:magicLevel(0)
runeTest:level(1)
runeTest:group("support")
runeTest:id(24)
runeTest:cooldown(1 * 500)
runeTest:groupCooldown(1 * 500)
runeTest:isPremium(false)
runeTest:register()