local spiritrunewarriorcoin2 = Spell(SPELL_RUNE)

function spiritrunewarriorcoin2.onCastSpell(creature, variant)
    local target = Tile(variant:getPosition()):getTopVisibleCreature(creature)
    if not target or not target:isPlayer() then
        creature:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end
    
    local mLevel = creature:getMagicLevel()
    local maxHealth = creature:getMaxHealth() / 2
    local maxMana = creature:getMaxMana() / 4
    
    local healthMin = (mLevel * 90) + (maxHealth / 1)
    local healthMax = (mLevel * 150) + (maxHealth / 2)
    local manaMin = (mLevel * 90) + (maxMana / 1)
    local manaMax = (mLevel * 150) + (maxMana / 2)
    
    target:addHealth(math.random(healthMin, healthMax))
    target:addMana(math.random(manaMin, manaMax))
    
    target:getPosition():sendMagicEffect(79)
    target:getPosition():sendMagicEffect(50)
    
    target:say("Duality spirit hm...")
    
    return true
end

spiritrunewarriorcoin2:name("second stage warrior spirit rune")
spiritrunewarriorcoin2:isAggressive(false)
spiritrunewarriorcoin2:runeId(41200)  -- Use the appropriate rune ID here
spiritrunewarriorcoin2:blockWalls(true)
spiritrunewarriorcoin2:magicLevel(25)
spiritrunewarriorcoin2:level(200)
spiritrunewarriorcoin2:group("support")
spiritrunewarriorcoin2:id(24)
spiritrunewarriorcoin2:cooldown(1 * 1000)
spiritrunewarriorcoin2:groupCooldown(1 * 1000)
spiritrunewarriorcoin2:isPremium(false)
spiritrunewarriorcoin2:charges(1)  -- You can adjust the charges if needed
spiritrunewarriorcoin2:register()