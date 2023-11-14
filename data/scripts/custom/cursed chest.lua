-- local cfg = {
             -- chance = 0.1,
			-- }
			
-- if not CURSED_CHESTS_SPAWNS then
-- CURSED_CHESTS_SPAWNS = { }
-- end
-- CURSED_CHESTS_AID = 9534


-- local creatureevent = CreatureEvent("system_CursedChest")

-- function creatureevent.onDeath(creature, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)

    -- if not creature or not creature:isMonster() then
	   -- return true
	-- end
	
	-- local chance = cfg.chance * 100
	-- --local number = math.random(0, 10000)
	-- local number = math.random(0, 10000)
    -- if number <= chance then
	-- local values = {
                      -- pos = Position(creature:getPosition().x, creature:getPosition().y, creature:getPosition().z),
				      -- size = 6,
				      -- chests = {1, 2},
			       -- }
				   
			-- table.insert(CURSED_CHESTS_SPAWNS, values)
			
			-- local data = CURSED_CHESTS_SPAWNS[#CURSED_CHESTS_SPAWNS]
			-- if not data.spawned then
			
			-- local from = Position(data.pos.x - data.size, data.pos.y - data.size, data.pos.z)
			-- local to = Position(data.pos.x + data.size, data.pos.y + data.size, data.pos.z)
			-- local chestId = math.random(1, #data.chests)
			-- local spawnPos = Position(math.random(from.x, to.x), math.random(from.y, to.y), data.pos.z)
			-- local tile = Tile(spawnPos)
			-- local spawnTest = 0

			-- while spawnTest < 100 do
				-- if isBadTile(tile) then
					-- spawnPos = Position(math.random(from.x, to.x), math.random(from.y, to.y), data.pos.z)
					-- tile = Tile(spawnPos)
					-- spawnTest = spawnTest + 1
				-- else
					-- break
				-- end
			-- end

			-- if spawnTest < 100 then
				-- local rarity = nil
				-- for i = #CURSED_CHESTS_TIERS, 1, -1 do
					-- rarity = CURSED_CHESTS_TIERS[i]
					-- if math.random(1, 100) <= rarity.chance then
						-- break
					-- end
				-- end
				-- if rarity ~= nil then
					-- local chest = Game.createItem(rarity.item, 1, spawnPos)
					-- chest:setActionId(CURSED_CHESTS_AID)
					-- spawnPos:sendMagicEffect(CONST_ME_GROUNDSHAKER)
					-- local chestData = {}
					-- chestData.pos = spawnPos
					-- chestData.spawnId = spawnId
					-- chestData.wave = 0
					-- chestData.monsters = {}
					-- chestData.active = 0
					-- chestData.finished = false
					-- chestData.container = chest
					-- chestData.chest = CURSED_CHESTS_CONFIG[chestId]
					-- chestData.rarity = rarity
					-- CURSED_CHESTS_DATA[#CURSED_CHESTS_DATA + 1] = chestData
					-- data.spawned = true
				-- end
			-- end

		-- end
		
	-- end
				   

	-- return true
-- end
-- creatureevent:register()