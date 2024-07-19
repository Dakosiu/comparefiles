local config = {
	[0] = {
		--club, coat
		items = {{2398, 1}, {2461, 1}, {2467, 1}, {2649, 1}},
		--container rope, shovel, red apple
		container = {{3003, 1}, {2554, 1}, {2674, 2}}
	},	
	[1] = {
		--equipment spellbook, wand of vortex, magician's robe, mage hat, studded legs, leather boots, scarf
		items = {{21400, 1}, {3074, 1}, {7991, 1}, {7992, 1}, {3362, 1}, {3552, 1}, {3572, 1}},
		--container platinum coin, rope, shovel, mana potion
		container = {{3035, 20}, {3003, 1}, {5710, 1}, {266, 5}, {268, 5}}
	},
	[2] = {
		--equipment spellbook, snakebite rod, magician's robe, mage hat, studded legs, leather boots scarf
		items = {{21400, 1}, {3066, 1}, {7991, 1}, {7992, 1}, {3362, 1}, {3552, 1}, {3572, 1}},
		--container platinum coin, rope, shovel, mana potion
		container = {{3035, 20}, {3003, 1}, {5710, 1}, {266, 5}, {268, 5}}
	},
	[3] = {
		--equipment dwarven shield, 5 spear, ranger's cloak, ranger legs scarf, legion helmet
		items = {{3425, 1}, {3277, 1}, {3571, 1}, {8095, 1}, {3374, 1}, {3374, 1}, {3552, 1}, {3572, 1}},
		--container platinum coin, rope, shovel, health potion, mana potion
		container = {{3035, 20}, {3003, 1}, {5710, 1}, {266, 5}, {268, 5}}
	},
	[4] = {
		--equipment dwarven shield, steel axe, brass armor, brass helmet, brass legs scarf
		items = {{3425, 1}, {7773, 1}, {3359, 1}, {3354, 1}, {3372, 1},  {3552, 1}, {3572, 1}},
		--container platinum coin, jagged sword, daramian mace, rope, shovel, health potion, mana potion
		container = {{3035, 20}, {3003, 1}, {5710, 1}, {7774, 1}, {3327, 5}, {266, 5}, {268, 5}}
	}

}

local creatureevent = CreatureEvent("on_Login_firstitems")
function creatureevent.onLogin(player)
	local targetVocation = config[player:getVocation():getId()]
	if not targetVocation then
		return true
	end

	if player:getLastLoginSaved() ~= 0 then
		return true
	end

	if (player:getSlotItem(CONST_SLOT_LEFT)) then
		return true
	end

	for i = 1, #targetVocation.items do
		player:addItem(targetVocation.items[i][1], targetVocation.items[i][2])
	end

	local backpack = player:getVocation():getId() == 0 and player:addItem(2853) or player:addItem(2854)
	if not backpack then
		return true
	end

	for i = 1, #targetVocation.container do
		backpack:addItem(targetVocation.container[i][1], targetVocation.container[i][2])
	end
	return true
end
creatureevent:register()