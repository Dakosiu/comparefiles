local cfg = {
effect = 40,
_effectDistance = true,
effectDistance = 31,
delay = 300,
repeatTimes = 2,
}


local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, cfg.effectDistance)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, true)

function onGetFormulaValues(player, level, magicLevel)
	local min = (level * 7) + (magicLevel * magicLevel) + 800
	local max = (level * 11) + (magicLevel * magicLevel) + 1000
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(creature, variant)

        local delay = 0

    for i = 1, cfg.repeatTimes do
        if i == 1 then
        delay = 0
        else
        delay = delay + cfg.delay
        end

        addEvent(function()
        if creature:isPlayer() then
              combat:execute(creature, variant)
              local pos = creature:getPosition()
              pos:sendMagicEffect(cfg.effect)
           end
        end, delay)

    end


    return true
end