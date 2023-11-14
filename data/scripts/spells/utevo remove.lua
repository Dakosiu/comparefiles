local spell = Spell("instant")
function spell.onCastSpell(creature, variant)
    local player = Player(creature)
    if player then
        local summons = player:getSummons()
    
        if #summons >= 1 then 
            for _, summon in pairs(summons) do
                summon:getPosition():sendMagicEffect(CONST_ME_POFF)
                summon:castSpell("summon explosion")
                summon:remove()
            end
        end
        player:sendTextMessage(MESSAGE_STATUS_WARNING, "You removed all your summons.")
    end
    return true
end

spell:name("Remove The Summons")
spell:words("utevo res rev")
spell:group("support")
spell:vocation("Summoner", "Barbaric Summoner")
spell:id(243)
spell:cooldown(2 * 1000)
spell:groupCooldown(2 * 500)
spell:level(22)
spell:manaPercent(1)
spell:isAggressive(false)
spell:isSelfTarget(true)
spell:isPremium(false)
spell:needLearn(false)
spell:register()