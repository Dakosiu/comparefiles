function Creature:onChangeOutfit(outfit)

	if self:isPlayer() then
	   local addonAmmount = outfit.lookAddons
	   self:updateHealthAddonBonus(addonAmmount)
	   self:updateManaAddonBonus(addonAmmount)
	end
	
    if hasEventCallback(EVENT_CALLBACK_ONCHANGEMOUNT) then
        if not EventCallback(EVENT_CALLBACK_ONCHANGEMOUNT, self,
                             outfit.lookMount) then return false end
    end
    if hasEventCallback(EVENT_CALLBACK_ONCHANGEOUTFIT) then
        return EventCallback(EVENT_CALLBACK_ONCHANGEOUTFIT, self, outfit)
    else
        return true
    end

end

function Creature:onAreaCombat(tile, isAggressive)
    if hasEventCallback(EVENT_CALLBACK_ONAREACOMBAT) then
        return EventCallback(EVENT_CALLBACK_ONAREACOMBAT, self, tile,
                             isAggressive)
    else
        return RETURNVALUE_NOERROR
    end
end

function Creature:onTargetCombat(target)
    if not self then return RETURNVALUE_NOERROR end
    local master = self:getMaster()
    if master and master == target then
        return RETURNVALUE_YOUMAYNOTATTACKTHISPLAYER
    end

    if master and target:getMaster() == master then
        return RETURNVALUE_YOUMAYNOTATTACKTHISPLAYER
    end

    if self:isPlayer() and target:getMaster() == self then
        return RETURNVALUE_YOUMAYNOTATTACKTHISPLAYER
    end
    if self:isPlayer() and target:isPlayer() then
        local party = self:getParty()
        if party then
            local targetParty = target:getParty()
            if targetParty and targetParty == party then
                return RETURNVALUE_YOUMAYNOTATTACKTHISPLAYER
            end
        end
    end

    local master = self:getMaster()
    if master and master:isPlayer() and target and target:isPlayer() and
        master:hasSecureMode() then return RETURNVALUE_NOTPOSSIBLE end

    if self and self:isPlayer() and target:getMaster() and target:getMaster():isPlayer() and self:hasSecureMode() then
        return RETURNVALUE_YOUMAYNOTATTACKTHISPLAYER
    end

    if self and self:isPlayer() and target:isPlayer() and self:hasSecureMode() then
        return RETURNVALUE_YOUMAYNOTATTACKTHISPLAYER
    else
        return RETURNVALUE_NOERROR
    end
    if hasEventCallback(EVENT_CALLBACK_ONTARGETCOMBAT) then
        return EventCallback(EVENT_CALLBACK_ONTARGETCOMBAT, self, target)
    end
end

function Creature:onHear(speaker, words, type)
    if hasEventCallback(EVENT_CALLBACK_ONHEAR) then
        EventCallback(EVENT_CALLBACK_ONHEAR, self, speaker, words, type)
    end
end
