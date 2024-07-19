dungeonQuestStorage = 45549
dungeonData = {
	[1] = {
		name = "Dungeon I", 
		level = 100, 
		tpPos = Position(923, 874, 6), 
		accessStorage = 45550, 
		questTrackerInfo = {
			[1] = function(player)
				return string.format(
							"You are hunting Black Knights for the access.\nYou currently have killed %d / "..dungeonData[45550].requiredKills,
							(math.max(player:getStorageValue(45551), 0)))
			end,
			[2] = "You got a key from the Black Knights, you should return it to get the Access to the First Dungeon.",
			[3] = "You completed the access to the Dungeon.",
		},
		startAccessMessage = "Ok, I need you to slain 1 Black Knights, and they should drop you a key, give it to me and you shall get access.",
		accessCompletedMessage = "Nice, this key will allow us to access that dungeon. You can enter the portal now.",
		
		-- Task Data Start
		taskStorage = 45551, 
		monsters = {"Black Knight"}, 
		requiredKills = 100, 
		itemDropped = {28477, 1}, 
		taskMessage = "It seems that last monster had some kind of key, you should hand it over for the access to the first dungeon.",
	},
	[2] = {
		name = "Dungeon II", 
		level = 200, 
		tpPos = Position(943, 896, 6),
		accessStorage = 45552, 
		questTrackerInfo = {
			[1] = "You are searching for the wife of the dungeon master. She was last seen at the Nightmares.",
			[2] = "You found the corpse of the dungeon master's wife. You took her necklace as proof.",
			[3] = "You completed the access to the dungeon.",
		},
		startAccessMessage = "My wife has been kidnapped, I need her back, and quick. Find her and bring her home, and I shall grant you access to the Second Dungeon. She was last seen at the Nightmares.",
		accessCompletedMessage = "So this is how it is... I give you permission to use the portal, go ahead and get revenge for me, for my wife.",
		
		itemDropped = {4834, 1},
		corpseMessage = "This is the corpse of the Dungeon Master's wife... You took a necklace as proof of her demise, better return it to him as proof.",	
	},
	[3] = {
		name = "Dungeon III", 
		level = 200, 
		tpPos = Position(923, 895, 6),
		accessStorage = 45553, 
		questTrackerInfo = {
			[1] = "You have to bring a map that can be looted from boss The Unwelcome in Dungeon II",
			[2] = "You completed the access to the dungeon.",
		},
		startAccessMessage = "Ahh Pirate Dungeon?. bring me the {map} from boss {The Unwelcome}.",
		accessCompletedMessage = "You have my permission to enter Dungeon III",
		requiredItem = 9205,
		-- itemDropped = {4834, 1},
		-- corpseMessage = "This is the corpse of the Dungeon Master's wife... You took a necklace as proof of her demise, better return it to him as proof.",	
	},
}