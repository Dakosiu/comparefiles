local spells = {WheelOfDestiny.Revelation.Ice_Burst, WheelOfDestiny.Revelation.Terra_Burst}
for _, data in pairs(spells) do
	local combat = Combat()
	combat:setParameter(COMBAT_PARAM_EFFECT, data.EFFECT)
	combat:setArea(createCombatArea(AREA_RING4X4))

	function onTargetCreature(creature, target)
		local player = creature:getPlayer()
		local min = ((player:getLevel() / 5) + (player:getMagicLevel() * 3.5) + 6)
		local max = ((player:getLevel() / 5) + (player:getMagicLevel() * 7) + 30)
	
		if player and player:getVocation():getBaseId() == data.VOCATION then
			local level = player:getWheelOfDestinyRevelationLevel(data.SIDE)
			if level then
				local data = data[level]
				if (target:getHealth() / target:getMaxHealth()) <= data.minHp then
					min = min * data.amplification
					max = max * data.amplification
				end
			end
		end

		doTargetCombatHealth(player, target, data.TYPE, min, max, CONST_ME_NONE, ORIGIN_SPELL)
		return true
	end

	combat:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

	function getCooldown(player)
		local cooldown = data.FIRST_LEVEL.cooldown
		local level = player:getWheelOfDestinyRevelationLevel(data.SIDE)
		if level then
			cooldown = data[level].cooldown
		end
		return cooldown
	end

	function getSecondaryCooldown(player)
		local cooldown = data.FIRST_LEVEL.cooldown
		local level = player:getWheelOfDestinyRevelationLevel(data.SIDE)
		if level then
			cooldown = data[level].cooldown
		end
		return cooldown
	end

	local spell = Spell("instant")

	function spell.onCastSpell(creature, variant)
		return combat:execute(creature, variant)
	end

	spell:group("attack", "burstsofnature")
	spell:id(data.ID)
	spell:name(data.SPELL)
	spell:words(data.WORDS)
	spell:level(300)
	spell:mana(230)
	spell:isSelfTarget(true)
	spell:isPremium(true)
	spell:cooldown(data.FIRST_LEVEL.cooldown)
	spell:setCallback(CALLBACK_SPELL_COOLDOWN, "getCooldown")
	spell:groupCooldown(2 * 1000, data.FIRST_LEVEL.cooldown)
	spell:setCallback(CALLBACK_SPELL_SECONDARY_GROUP_COOLDOWN, "getSecondaryCooldown")
	spell:needLearn(true)
	spell:vocation("druid;true", "elder druid;true")
	spell:register()
end
