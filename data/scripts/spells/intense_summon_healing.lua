local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
    local player = Player(creature)
    local summons = player:getSummons()
    local mxMana, ml, lvl = player:getMaxMana(), player:getMagicLevel(), player:getLevel()
    local formula = math.floor(lvl * ml / 2)

    if #summons >= 1 then 
        for _, summon in pairs(summons) do
            player:SME(15)
            summon:getPosition():sendMagicEffect(15)
            summon:addHealth(formula)
        end
        return true
      else
         player:sendTextMessage(MESSAGE_STATUS_WARNING, "You can't use this spell without summons.")
        return false
    end
end

spell:name("Heal Your Summons")
spell:words("exura summon vita")
spell:group("support")
spell:vocation("Summoner", "Barbaric Summoner")
spell:id(244)
spell:cooldown(2 * 1000)
spell:groupCooldown(2 * 500)
spell:level(22)
spell:manaPercent(2)
spell:isAggressive(false)
spell:isSelfTarget(true)
spell:isPremium(false)
spell:needLearn(false)
spell:register()