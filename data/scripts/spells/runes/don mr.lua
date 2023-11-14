local runeTest = Spell(SPELL_RUNE)
function runeTest.onCastSpell(creature, variant)
    local target = Tile(variant:getPosition()):getTopVisibleCreature(creature)
    if not target or not target:isPlayer() then
        creature:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end
	local mLevel = creature:getMagicLevel()
    local maxMana = creature:getMaxMana() / 100
	local min = (mLevel * 3) + (maxMana * 48)
	local max = (mLevel * 7) + (maxMana * 72)
    target:addMana(math.random(min, max))
	target:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
    target:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
    target:say("don mr...")
    return true
end

runeTest:name("donation manarune")
runeTest:isAggressive(false)
runeTest:runeId(2294)
runeTest:blockWalls(true)
runeTest:magicLevel(1)
runeTest:level(250)
runeTest:group("support")
runeTest:id(24)
runeTest:cooldown(1 * 500)
runeTest:groupCooldown(1 * 500)
runeTest:isPremium(false)
runeTest:register()