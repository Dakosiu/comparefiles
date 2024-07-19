function canJoin(player)
	return player:getStorageValue(hungerGamesStorages.playerJoinedEvent) == 1
end

function onSpeak(player, type, message)
	return false
end
