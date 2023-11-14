local warriormanarune2 = Spell(SPELL_RUNE)
function warriormanarune2.onCastSpell(creature, variant)
    local target = Tile(variant:getPosition()):getTopVisibleCreature(creature)
    if not target or not target:isPlayer() then
        creature:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end
	local mLevel = creature:getMagicLevel()
    local maxMana = creature:getMaxMana() / 3
	local min = (mLevel * 60) + (maxMana / 2)
	local max = (mLevel * 120) + (maxMana / 3)
    target:addMana(math.random(min, max))
    target:getPosition():sendMagicEffect(290)
    target:say("Duality mana hm...")
    return true
end

warriormanarune2:name("second stage warrior mana rune")
warriormanarune2:isAggressive(false)
warriormanarune2:runeId(41155)
warriormanarune2:blockWalls(true)
warriormanarune2:magicLevel(90)
warriormanarune2:level(200)
warriormanarune2:group("support")
warriormanarune2:id(24)
warriormanarune2:cooldown(1 * 1000)
warriormanarune2:groupCooldown(1 * 1000)
warriormanarune2:isPremium(false)
warriormanarune2:charges(1)
warriormanarune2:register()