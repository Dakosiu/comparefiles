local avatars = {
	WheelOfDestiny.Revelation.Avatar_Of_Light,
	WheelOfDestiny.Revelation.Avatar_Of_Steel,
	WheelOfDestiny.Revelation.Avatar_Of_Nature,
	WheelOfDestiny.Revelation.Avatar_Of_Storm
}

for _, avatar in pairs(avatars) do
	local spell = Spell("instant")

	function spell.onCastSpell(player, var)
		local level = player:getWheelOfDestinyRevelationLevel(avatar.SIDE)
		if level then
			local data = avatar[level]
			
			local outfitCondition = Condition(CONDITION_OUTFIT)
			outfitCondition:setParameter(CONDITION_PARAM_TICKS, data.duration)
			outfitCondition:setParameter(CONDITION_PARAM_SUBID, avatar.SPELLID)
			outfitCondition:setOutfit(avatar.OUTFIT)
			
			local buffCondition = Condition(CONDITION_ATTRIBUTES)
			buffCondition:setParameter(CONDITION_PARAM_TICKS, data.duration)
			buffCondition:setParameter(CONDITION_PARAM_SUBID, avatar.SPELLID)
			buffCondition:setParameter(CONDITION_PARAM_SKILL_CRITICAL_HIT_CHANCE, data.criticalChance)
			buffCondition:setParameter(CONDITION_PARAM_SKILL_CRITICAL_HIT_DAMAGE, data.criticalDamage)
			buffCondition:setParameter(CONDITION_PARAM_BUFF_DAMAGERECEIVED, data.damageReduction)
			
			player:getPosition():sendMagicEffect(avatar.EFFECT)
			player:addCondition(outfitCondition)
			player:addCondition(buffCondition)
			return true
		end
		return false
	end

	function getCooldown(player)
		local cooldown = avatar.FIRST_LEVEL.cooldown
		local level = player:getWheelOfDestinyRevelationLevel(avatar.SIDE)
		if level then
			return avatar[level].cooldown
		end
		return cooldown
	end

	spell:name(avatar.SPELL)
	spell:words(avatar.WORDS)
	spell:group("support")
	spell:vocation(avatar.VOCATIONS[1], avatar.VOCATIONS[2])
	--spell:castSound(SOUND_EFFECT_TYPE_SPELL_SWIFT_FOOT)
	spell:id(avatar.SPELLID)
	spell:cooldown(avatar.FIRST_LEVEL.cooldown)
	spell:setCallback(CALLBACK_SPELL_COOLDOWN, "getCooldown")
	spell:groupCooldown(2 * 1000)
	spell:level(300)
	spell:mana(avatar.MANA)
	spell:isSelfTarget(true)
	spell:isAggressive(false)
	spell:isPremium(true)
	spell:needLearn(true)
	spell:register()
end
