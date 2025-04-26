--dofile('data/Niide Spell System.lua')

function NIIDE_SPELLS:registerSpells()
    local spellid = 1
    for spellName, spellTable in pairs(self.spellList) do
	    if spellTable["spell_type"] == "instant" then
		    local spell = Spell("instant")
			function spell.onCastSpell(creature, variant, isHotkey)
                --spellcast_castSpell(creature, child.word, nil)
				return NIIDE_SPELLS:castSpell(creature, spellName)
			end
			spell:isAggressive(false) --- tests only
			spell:name(spellName)
			spell:group(spellTable["spellGroup"])
			spell:words(spellTable["spell_words"])
			spell:mana(spellTable["manaCost"])
			local vocations = NIIDE_SPELLS:getVocationsString(spellName)
			spell:vocation(vocations)
			--spell:vocation(spellTable["vocations"])
			---
		    spell:register()
        elseif spellTable["spell_type"] == "rune" then
		    local spell = Spell("rune")
			
			
			
			
			--local area = spellTable["area"]
			spell:group(spellTable["spellGroup"])
			spell:words(spellTable["spell_words"])
			spell:mana(spellTable["manaCost"])
            spell:runeId(spellTable["spell_itemid"])
            spell:allowFarUse(true)	
            function spell.onCastSpell(creature, var, isHotkey)			
		        NIIDE_SPELLS:castRune(creature, var, spellName) 
			end
			spell:register()
		end    
	end
end

local globalevent = GlobalEvent("load_NIIDE_SPELLS")
function globalevent.onStartup()
    NIIDE_SPELLS:registerSpells()
end
globalevent:register()






