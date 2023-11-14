local spiritrunewarriorcoin1 = Spell(SPELL_RUNE)

function spiritrunewarriorcoin1.onCastSpell(creature, variant)
    local target = Tile(variant:getPosition()):getTopVisibleCreature(creature)
    if not target or not target:isPlayer() then
        creature:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end
    
    local mLevel = creature:getMagicLevel()
    local maxHealth = creature:getMaxHealth() / 3
    local maxMana = creature:getMaxMana() / 6
    
    local healthMin = (mLevel * 30) + (maxHealth / 1)
    local healthMax = (mLevel * 90) + (maxHealth / 2)
    local manaMin = (mLevel * 30) + (maxMana / 1)
    local manaMax = (mLevel * 90) + (maxMana / 2)
    
    target:addHealth(math.random(healthMin, healthMax))
    target:addMana(math.random(manaMin, manaMax))
    
    target:getPosition():sendMagicEffect(32)
    target:getPosition():sendMagicEffect(40)
    
    target:say("Etherical spirit hm...")
    
    return true
end

spiritrunewarriorcoin1:name("first stage warrior spirit rune")
spiritrunewarriorcoin1:isAggressive(false)
spiritrunewarriorcoin1:runeId(41174)  -- Use the appropriate rune ID here
spiritrunewarriorcoin1:blockWalls(true)
spiritrunewarriorcoin1:magicLevel(20)
spiritrunewarriorcoin1:level(150)
spiritrunewarriorcoin1:group("support")
spiritrunewarriorcoin1:id(24)
spiritrunewarriorcoin1:cooldown(1 * 1000)
spiritrunewarriorcoin1:groupCooldown(1 * 1000)
spiritrunewarriorcoin1:isPremium(false)
spiritrunewarriorcoin1:charges(1)  -- You can adjust the charges if needed
spiritrunewarriorcoin1:register()