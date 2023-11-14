local combat = Combat()
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 88)
combat:setParameter(COMBAT_PARAM_CREATEITEM, 41104)

function onCastSpell(creature, variant, isHotkey)
    if combat:execute(creature, variant) then
        local item = variant:getPosition(variant)
        local tile = item:getTile()
        local top = tile:getTopVisibleThing()
        top:setCustomAttribute("PlayerName", creature:getName())
    end
	 return true
end
