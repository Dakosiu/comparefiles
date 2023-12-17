local spiritrunewarriorcoin3 = Spell(SPELL_RUNE)

function spiritrunewarriorcoin3.onCastSpell(creature, variant)
    local target = Tile(variant:getPosition()):getTopVisibleCreature(creature)
    if not target or not target:isPlayer() then
        creature:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end
    
    local mLevel = creature:getMagicLevel()
    local maxHealth = creature:getMaxHealth() / 2
    local maxMana = creature:getMaxMana() / 3
    
    local healthMin = (mLevel * 200) + (maxHealth / 1)
    local healthMax = (mLevel * 300) + (maxHealth / 2)
    local manaMin = (mLevel * 200) + (maxMana / 1)
    local manaMax = (mLevel * 300) + (maxMana / 2)
    
    target:addHealth(math.random(healthMin, healthMax))
    target:addMana(math.random(manaMin, manaMax))
    
    target:getPosition():sendMagicEffect(57)
    target:getPosition():sendMagicEffect(273)
    
    target:say("Multiverse spirit hm...")
    
    return true
end

spiritrunewarriorcoin3:name("third stage warrior spirit rune")
spiritrunewarriorcoin3:isAggressive(false)
spiritrunewarriorcoin3:runeId(41193)  -- Use the appropriate rune ID here
spiritrunewarriorcoin3:blockWalls(true)
spiritrunewarriorcoin3:magicLevel(35)
spiritrunewarriorcoin3:level(200)
spiritrunewarriorcoin3:group("support")
spiritrunewarriorcoin3:id(24)
spiritrunewarriorcoin3:cooldown(1 * 1000)
spiritrunewarriorcoin3:groupCooldown(1 * 1000)
spiritrunewarriorcoin3:isPremium(false)
spiritrunewarriorcoin3:charges(1)  -- You can adjust the charges if needed
spiritrunewarriorcoin3:register()