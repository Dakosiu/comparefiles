function canJoin(player)
	return player:getStorageValue(dungeonStorages.inDungeon) ~= -1
end

function onSpeak(player, type, message)
	return false
end
