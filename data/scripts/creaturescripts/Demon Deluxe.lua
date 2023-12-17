local config = {
	{chance = 10, monster = "Demon", message = "The white deer summons all his strength and turns to fight!"},
	{chance = 100, monster = "Demon Deluxe", message = "HUH YOU THINK IM DONE WITH YOU ?????!!!!!!"}
}

local creatureevent = CreatureEvent("demondeluxe")

function creatureevent.onDeath(creature, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)
	local targetMonster = creature:getMonster()
	if not targetMonster or targetMonster:getMaster() then
		return true
	end

	local chance = math.random(100)
	for i = 1, #config do
		if chance <= config[i].chance then
			local spawnMonster = Game.createMonster(config[i].monster, targetMonster:getPosition(), true, true)
			if spawnMonster then
				spawnMonster:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				targetMonster:say(config[i].message, TALKTYPE_MONSTER_SAY)
			end
			break
		end
	end
	return true
end

creatureevent:register()
