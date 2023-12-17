local warriormanarune3 = Spell(SPELL_RUNE)
function warriormanarune3.onCastSpell(creature, variant)
    local target = Tile(variant:getPosition()):getTopVisibleCreature(creature)
    if not target or not target:isPlayer() then
        creature:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end
	local mLevel = creature:getMagicLevel()
    local maxMana = creature:getMaxMana() / 2
	local min = (mLevel * 90) + (maxMana / 2)
	local max = (mLevel * 150) + (maxMana / 3)
    target:addMana(math.random(min, max))
    target:getPosition():sendMagicEffect(303)
    target:say("Multiverse mana ohh yeah...")
    return true
end

warriormanarune3:name("third stage warrior mana rune")
warriormanarune3:isAggressive(false)
warriormanarune3:runeId(41156)
warriormanarune3:blockWalls(true)
warriormanarune3:magicLevel(105)
warriormanarune3:level(250)
warriormanarune3:group("support")
warriormanarune3:id(24)
warriormanarune3:cooldown(1 * 1000)
warriormanarune3:groupCooldown(1 * 1000)
warriormanarune3:isPremium(false)
warriormanarune3:charges(1)
warriormanarune3:register()