local config = {
	range = 5,
	duration = 5000,
	lookTypeEx = 7303,
}

local function getEffectPositions(position)
	return {
		Position(position.x - 1, position.y - 1, position.z),
		Position(position.x + 1, position.y - 1, position.z),
		Position(position.x + 1, position.y + 1, position.z),
		Position(position.x - 1, position.y + 1, position.z),
	}
end

local function unfreezePlayer(playerId)
	local player = Player(playerId)

	if not player then
		return false
	end

	local positions = getEffectPositions(player:getPosition())

	for i = 1, #positions do
		local position = positions[i]

		player:getPosition():sendDistanceEffect(position, CONST_ANI_ICE)
	end

	player:say("UNFROZEN", TALKTYPE_MONSTER_SAY)
	player:setMoveLocked(false)
	player:removeCondition(CONDITION_OUTFIT)
	player:getPosition():sendMagicEffect(CONST_ME_ICEATTACK)

	return true
end

local function freezePlayer(playerId)
	local player = Player(playerId)

	if not player then
		return false
	end

	local positions = getEffectPositions(player:getPosition())

	for i = 1, #positions do
		local position = positions[i]

		position:sendDistanceEffect(player:getPosition(), CONST_ANI_ICE)
	end

	local delay = 100

	addEvent(function()
		local player = Player(playerId)

		if player then
			local condition = Condition(CONDITION_OUTFIT)
			condition:setTicks(config.duration)
			condition:setOutfit({lookTypeEx = config.lookTypeEx})

			player:addCondition(condition)
			player:say("FROZEN", TALKTYPE_MONSTER_SAY)
			player:getPosition():sendMagicEffect(CONST_ME_ICEATTACK)
			player:setMoveLocked(true)

			addEvent(unfreezePlayer, config.duration + delay, playerId)
		end
	end, delay)

	return true
end

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local players = Game.getSpectators(creature:getPosition(), false, true, config.range, config.range, config.range, config.range)

	for i = 1, #players do
		local player = players[i]
		local playerId = player:getId()

		if player:getAccountType() < ACCOUNT_TYPE_GAMEMASTER then
			creature:getPosition():sendDistanceEffect(player:getPosition(), CONST_ANI_ICE)

			addEvent(freezePlayer, 150, playerId)
		end
	end

	return true
end

spell:name("freeze players")
spell:words("###1005")
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(true)
spell:register()