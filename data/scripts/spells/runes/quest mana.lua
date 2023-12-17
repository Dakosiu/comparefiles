local runeTest = Spell(SPELL_RUNE)
function runeTest.onCastSpell(creature, variant)
    local target = Tile(variant:getPosition()):getTopVisibleCreature(creature)
    if not target or not target:isPlayer() then
        creature:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end
	local mLevel = creature:getMagicLevel()
    local maxMana = creature:getMaxMana() / 100
	local min = (mLevel * 3) + (maxMana * 47)
	local max = (mLevel * 5) + (maxMana * 59)
    target:addMana(math.random(min, max))
	target:getPosition():sendMagicEffect(CONST_ME_SOUND_RED)
    target:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
    target:say("ughh mana...")
    return true
end

runeTest:name("quest manarune")
runeTest:isAggressive(false)
runeTest:runeId(2296)
runeTest:blockWalls(true)
runeTest:magicLevel(0)
runeTest:level(1)
runeTest:group("support")
runeTest:id(24)
runeTest:cooldown(1 * 500)
runeTest:groupCooldown(1 * 500)
runeTest:isPremium(false)
runeTest:register()