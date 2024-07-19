local waterIds = {629, 630, 631, 632, 633, 634, 4597, 4598, 4599, 4600, 4601, 4602, 4609, 4610, 4611, 4612, 4613, 4614, 7236, 9582, 12560, 12562, 12561, 12563, 13988, 13989}
local FISHING_SYSTEM_CONFIG = {
                                ["Fishes"] = {
                                               { id = 32045, chance = 0.1, requiredSkill = 1 },
											   { id = 32044, chance = 0.05, requiredSkill = 50 },
											   { id = 32043, chance = 0.5, requiredSkill = 100 },
											 },
								["Rods"] = {
								             [3483] = {
											            additionalChance = 0,
														worms = { id = 3492, enabled = true },
												      },
								             [9306] = {
											            additionalChance = 0.3,
														worms = { id = 3492, enabled = true },
												      },													  
										   }
							  }
							  
							  



if not FISHING_SYSTEM then						  
   FISHING_SYSTEM = {}
end

function FISHING_SYSTEM:generateFish(player, boosted)
    
	local avaibleFishes = {}
	
	for i, v in pairs(FISHING_SYSTEM_CONFIG["Fishes"]) do
	    if player:getSkillLevel(SKILL_FISHING) >= v.requiredSkill then
		   table.insert(avaibleFishes, v)
		end
	end
	
	local playerChance = math.min(math.max(10 + (player:getEffectiveSkillLevel(SKILL_FISHING) - 10) * 0.597, 10), 50)
	print("Player Chance: " .. playerChance)
	if boosted then
	   playerChance = playerChance + (playerChance * boosted)
	end
	print("Player Chance: " .. playerChance)
	
	local randFishing = math.random(1,100)
	print("Wylosowalo: " .. randFishing)
	
	if (randFishing > playerChance) then
	   print("Nie powinno wylosowac ryby.")
	   return false
	end
	print("powinno wylosowac rybe.")
	
	table.sort(avaibleFishes, function(a, b) return a.chance < b.chance end)
	
	local fishes = {}
	local rand = math.random(1, 100)
	local lastChance = 0
	for i, v in pairs(avaibleFishes) do
		local chance = v.chance
		if not chance then
		   chance = 100
		end
		if chance < 1 then
		   chance = chance * 100
		end	
		print("Rand na rybke: " .. rand)
		print("Szansa: " .. chance)
		chance = chance + playerChance
		print("Szansa2: " .. chance)
		if rand <= chance then
		   print("Powinno wybrac rybke")
		   if lastChance == 0 or v.chance <= lastChance then
			      fishes[#fishes + 1] = v
				  lastChance = v.chance
		   end
		end
	end
	if #fishes == 0 then
	   return false
	end
	
	table.sort(fishes, function(a, b) return a.chance < b.chance end)
	
	local rewardTable = fishes[math.random(#fishes)]
	local id = rewardTable.id
	player:addItem(id, 1)
	return true
end

local fishing = Action()
function fishing.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not table.contains(waterIds, target.itemid) then
		return false
	end

    local t = FISHING_SYSTEM_CONFIG["Rods"][item:getId()]
	if not t then
	   return false
	end
	
	if target.itemid ~= 7236 then
		toPosition:sendMagicEffect(CONST_ME_LOSEENERGY)
	end
    
	local wormsTable = t.worms
	if wormsTable.enabled then
	   if player:getItemCount(wormsTable.id) < 1 then
	      return true
       end
	end
	player:addSkillTries(SKILL_FISHING, 1)
	
	local playerChance = math.min(math.max(10 + (player:getEffectiveSkillLevel(SKILL_FISHING) - 10) * 0.597, 10), 50)
	local chance = math.random(1, 100)
	local boosted = false
	
	if t.additionalChance then
	   boosted = t.additionalChance
	end
	
	if FISHING_SYSTEM:generateFish(player, boosted) then
	   player:removeItem(wormsTable.id, 1)
	end
	return true
end
	
	
	
for i, v in pairs(FISHING_SYSTEM_CONFIG["Rods"]) do
    fishing:id(i)
end
fishing:allowFarUse(true)
fishing:register()
