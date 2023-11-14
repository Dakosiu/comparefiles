health = { -- 5, 2, 1
	[1] = { abv = "Newbie", minHP = 500, maxHP = 5000, effect = 50 }, -- Abv = "Tier Name"
	[2] = { abv = "Weak", minHP = 5001, maxHP = 12000, effect = 51 },
	[3] = { abv = "Medium", minHP = 12001, maxHP = 50000, effect = 52 },
	[4] = { abv = "Hard", minHP = 50001, maxHP = 120000, effect = 53 }, -- ! Check if creature Health is good for u (Remember that it decides his Tier (U can check creature health in Monsters.xml))
	[5] = { abv = "Worthy", minHP = 120001, maxHP = 300000, effect = 54 }, --! Effect can be activated or deactived its only if u want to show some effect on ALL Creatures u kill from each tier
	[6] = { abv = "Epic", minHP = 300001, maxHP = 350000, effect = 55 },
	[7] = { abv = "Legendary", minHP = 350001, maxHP = 450000, effect = 56 },
	[8] = { abv = "Bosly", minHP = 450001, maxHP = 500000, effect = 57 },
	[9] = { abv = "Godly", minHP = 500001, maxHP = 999999999, effect = 58 },
}

--! WHAT TO DO:
--[[
[1] = See if the health for creatures/Tier is fine for u (From line 1 to 10)
[2] = Check chances (Remember its in percentage) [["Rare"] = { chance = "This Value Here, its in percentage", effect = 55, items = {]
[3] = Add the loot for each table (All you have to remember is that Legendary loot will be better than Epic and Epic better than Rare
[4] = As it decides a item randomly from the Table u can put for example Rare, Crystal Coin, Awaken Coin, Epic put only Awaken Coin and Legendary 100 Awaken Coin, something like that
--]]

local cfg = {
	["Rare"] = { chance = 20, effect = 55, items = { --! Decide chances, its in Percentage so no big problem
		["Newbie"] = { --! Effect here is always when u get the loot from this Tier
			{ 35962, 1 }, -- Item, Quantity
		},
		["Weak"] = {
			{ 35962, 1 }, -- Item, Quantity
		},
		["Medium"] = {
			{ 35961, 1 }, -- Item, Quantity
		},
		["Hard"] = {
			{ 35961, 1 }, -- Item, Quantity
		},
		["Worthy"] = {
			{ 35966, 1 }, -- Item, Quantity
		},
		["Epic"] = {
			{ 35965, 1 }, -- Item, Quantity
		},
		["Legendary"] = {
			{ 35965, 1 }, -- Item, Quantity
		},
		["Bosly"] = {
			{ 35959, 1 }, -- Item, Quantity
		},
		["Godly"] = {
			{ 35959, 1 }, -- Item, Quantity
		},
	} },
	["Epic"] = { chance = 15, effect = 56, items = {
		["Newbie"] = { -- ! The item is randomly chosed so u can decrease item amount in higher tiers to make Legendary always get one item
			{ 35961, 2 }, -- Item, Quantity
		},
		["Weak"] = {
			{ 35961, 2 }, -- Item, Quantity
		},
		["Medium"] = {
			{ 35961, 2 }, -- Item, Quantity
		},
		["Hard"] = {
			{ 35965, 2 }, -- Item, Quantity
		},
		["Worthy"] = {
			{ 35965, 2 }, -- Item, Quantity
		},
		["Epic"] = {
			{ 35960, 2 }, -- Item, Quantity
		},
		["Legendary"] = {
			{ 35960, 2 }, -- Item, Quantity
		},
		["Bosly"] = {
			{ 35967, 2 }, -- Item, Quantity
		},
		["Godly"] = {
			{ 35967, 2 }, -- Item, Quantity
		},
	} },
	["Legendary"] = { chance = 5, effect = 57, items = {
		["Newbie"] = {
			{ 35966, 3 }, -- Item, Quantity
		},
		["Weak"] = {
			{ 35966, 3 }, -- Item, Quantity
		},
		["Medium"] = {
			{ 35960, 3 }, -- Item, Quantity
		},
		["Hard"] = {
			{ 35960, 3 }, -- Item, Quantity
		},
		["Worthy"] = {
			{ 35960, 3 }, -- Item, Quantity
		},
		["Epic"] = {
			{ 35964, 3 }, -- Item, Quantity
		},
		["Legendary"] = {
			{ 35964, 3 }, -- Item, Quantity
		},
		["Bosly"] = {
			{ 35964, 3 }, -- Item, Quantity
		},
		["Godly"] = {
			{ 35963, 3 }, -- Item, Quantity
		},
	} }
}

function onKill(creature, target)
	local targetMonster = target:getMonster()
	if not targetMonster then
		return true
	end

	local player = Player(creature)
	if not player then
		return true
	end

	local targetMonster = target:getMonster()
	local targetPosition = targetMonster:getPosition()
	local monsterHP = targetMonster:getMaxHealth()
	local monsterStrongness
	_G.monsterStrongness = monsterHP
	 --[[ if monsterHP >= 150 then
		if monsterHP >= health[1].minHP and monsterHP < health[1].maxHP then
			monsterStrongness = health[1].abv
			--targetMonster:getPosition():sendMagicEffect(health.Weak.effect)
			--position:sendAnimatedText("Simple Test!", TEXTCOLOR_GREEN, player)
			--targetPosition:sendAnimatedText(monsterStrongness, TEXTCOLOR_BROWN, player)
		elseif monsterHP >= health[2].minHP and monsterHP < health[2].maxHP then
			monsterStrongness = health[2].abv
		elseif monsterHP >= health[3].minHP and monsterHP < health[3].maxHP then
			monsterStrongness = health[3].abv
		elseif monsterHP >= health[4].minHP and monsterHP < health[4].maxHP then
			monsterStrongness = health[4].abv
		elseif monsterHP >= health[5].minHP and monsterHP < health[5].maxHP then
			monsterStrongness = health[5].abv
			targetPosition:sendAnimatedText(monsterStrongness, 215, player)
		elseif monsterHP >= health[6].minHP and monsterHP < health[6].maxHP then
			monsterStrongness = health[6].abv
			targetPosition:sendAnimatedText(monsterStrongness, 215, player)
		elseif monsterHP >= health[7].minHP and monsterHP < health[7].maxHP then
			monsterStrongness = health[7].abv
			targetPosition:sendAnimatedText(monsterStrongness, 215, player)
		elseif monsterHP >= health[8].minHP and monsterHP < health[8].maxHP then
			monsterStrongness = health[8].abv
			targetPosition:sendAnimatedText(monsterStrongness, 215, player)
		elseif monsterHP >= health[9].minHP and monsterHP < health[9].maxHP then
			monsterStrongness = health[9].abv
			targetPosition:sendAnimatedText(monsterStrongness, 215, player)
		end
	else
		monsterStrongness = nil
	end ]]
end

--[[ local chance = math.random(1, 100)

local legendary = cfg["Legendary"]
local epic = cfg["Epic"]
local rare = cfg["Rare"] --]]

--[[ if monsterStrongness ~= nil then
		if legendary then
			if chance <= legendary.chance then
				local randItem = math.random(1, #legendary.items[monsterStrongness])

				local id = legendary.items[monsterStrongness][randItem][1]
				local count = legendary.items[monsterStrongness][randItem][2]
				player:addItem(id, count)
				targetMonster:getPosition():sendMagicEffect(cfg.Legendary.effect)
				return true
			end
		end

		if epic then
			if chance <= epic.chance then
				local randItem = math.random(1, #epic.items[monsterStrongness])

				local id = epic.items[monsterStrongness][randItem][1]
				local count = epic.items[monsterStrongness][randItem][2]
				player:addItem(id, count)
				targetMonster:getPosition():sendMagicEffect(cfg.Epic.effect)
				return true
			end
		end

		if rare then
			if chance <= rare.chance then
				local randItem = math.random(1, #rare.items[monsterStrongness])

				local id = rare.items[monsterStrongness][randItem][1]
				local count = rare.items[monsterStrongness][randItem][2]
				player:addItem(id, count)
				targetMonster:getPosition():sendMagicEffect(cfg.Rare.effect)
				return true
			end
		end
		return true
	end
end --]]
