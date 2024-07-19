local rewards = {
	{ id = 42338, name = "Tree Staff" },
	{ id = 42337, name = "Tree Slingshot" },
	{ id = 42334, name = "tree mace" },
	{ id = 42335, name = "tree axe" },
	{ id = 42328, name = "Tree Ring" },
	{ id = 42327, name = "Leaf Ring" },
	{ id = 42326, name = "Tree Amulet" },
	{ id = 42332, name = "Leaf Legs" },
	{ id = 42324, name = "Tree Legs" },
	{ id = 42329, name = "Leaf Hood" },
	{ id = 42321, name = "Tree Helmet" },
	{ id = 42333, name = "Leaf Boots" },
	{ id = 42325, name = "Tree Boots" },
	{ id = 42330, name = "Leaf Armor" },
	{ id = 42322, name = "Tree Armor" },
	{ id = 42331, name = "Leaf Spellbook" },
	{ id = 42323, name = "Tree Shield" },
	{ id = 42336, name = "tree sword" },
}

local bagyouDesire = Action()

function bagyouDesire.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local randId = math.random(1, #rewards)
	local rewardItem = rewards[randId]

	player:addItem(rewardItem.id, 1)
	item:remove(1)

	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You received a " .. rewardItem.name .. ".")
	return true
end

bagyouDesire:id(23488)
bagyouDesire:register()
