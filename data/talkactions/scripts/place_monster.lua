function onSay(player, words, param)
	if not player:getGroup():getAccess() and player:getAccountType() < ACCOUNT_TYPE_GOD  then
		return true
	end
	
	local position = player:getPosition()
	local monster = Game.createMonster(param, position)
	if monster ~= nil then
		--if monster:getType():isRewardBoss() then
		
		
		if monster:getType():useRewardChest() then
		    --print("using reward chest")
			--monster:setReward(true)
		end
		monster:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		position:sendMagicEffect(CONST_ME_MAGIC_RED)
	else
		player:sendCancelMessage("There is not enough room.")
		position:sendMagicEffect(CONST_ME_POFF)
	end
	return false
end
