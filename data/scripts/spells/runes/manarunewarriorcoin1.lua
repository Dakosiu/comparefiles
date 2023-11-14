local warriormanarune1 = Spell(SPELL_RUNE)
function warriormanarune1.onCastSpell(creature, variant)
    local target = Tile(variant:getPosition()):getTopVisibleCreature(creature)
    if not target or not target:isPlayer() then
        creature:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end
	local mLevel = creature:getMagicLevel()
    local maxMana = creature:getMaxMana() / 5
	local min = (mLevel * 30) + (maxMana / 2)
	local max = (mLevel * 90) + (maxMana / 3)
    target:addMana(math.random(min, max))
    target:getPosition():sendMagicEffect(222)
    target:say("etherical mana hm...")
    return true
end

warriormanarune1:name("first stage warrior mana rune")
warriormanarune1:isAggressive(false)
warriormanarune1:runeId(41158)
warriormanarune1:blockWalls(true)
warriormanarune1:magicLevel(75)
warriormanarune1:level(150)
warriormanarune1:group("support")
warriormanarune1:id(24)
warriormanarune1:cooldown(1 * 1000)
warriormanarune1:groupCooldown(1 * 1000)
warriormanarune1:isPremium(false)
warriormanarune1:charges(1)
warriormanarune1:register()