--[[

        * Alternative "Mana Waste" Spell *
       
        Author:         Guitar Freak.
        Optimizations:  Evil Hero, Hermes.
       
]]--

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, 0)

function onCastSpell(cid, var)
    local playerMana = getPlayerMana(cid)
    local inFight = getCreatureCondition(cid, CONDITION_INFIGHT)
   
    if playerMana > 0 then
        doPlayerAddSpentMana(cid, playerMana)
        doCreatureAddMana(cid, -playerMana)
        doCombat(cid, combat, var)  
        if not inFight then
            doRemoveCondition(cid, CONDITION_INFIGHT)
        end
    else
        doPlayerSendCancel(cid, "You don't have any mana.")
        doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
    end
end