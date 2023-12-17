local cfg = {
effect = 14,
_effectDistance = true,
effectDistance = 28,
delay = 300,
repeatTimes = 2,
}


local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, cfg.effectDistance)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, true)

function onGetFormulaValues(player, skill, attack, factor)
	local distanceSkill = player:getEffectiveSkillLevel(SKILL_DISTANCE)
	local min = (player:getLevel() / 2) * distanceSkill + distanceSkill + 2400
	local max = (player:getLevel() / 2) * distanceSkill + distanceSkill + 3000
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

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