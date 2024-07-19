GROUND_EFFECT_CONFIG = {
	[1] = {
	    ["Positions"] = { 
                          { 949, 1120, 7 },	
		                  { 950, 1121, 7 },
		                  { 951, 1122, 7 },
		                  { 952, 1123, 7 },
		                  { 953, 1124, 7 },
		                  { 954, 1125, 7 },
						},
		["Damage"] = { value = -1, type = COMBAT_DEATHDAMAGE },   -- -1 mean player will die instantly.
		["Effect"] = CONST_ME_MORTAREA
	},
}

local globalevent = GlobalEvent("onThink_damageEffects")
function globalevent.onThink(cid, interval, lastExecution)

	local interval = 0
	
	for index, configTable in pairs(GROUND_EFFECT_CONFIG) do
	    for i, positions in pairs(configTable["Positions"]) do
		    local effect = configTable["Effect"]
		    local x = positions[1]
			local y = positions[2]
			local z = positions[3]
		    local pos = Position(x, y, z)
			if pos then
			      addEvent(function()
				       pos:sendMagicEffect(effect)
					   local tile = Tile(pos)
					   if tile then
                          local ground = Tile(pos):getGround()
					      if ground then
							 local player = tile:getTopCreature()
		                     if player and player:isPlayer() then
						        local dmg = configTable["Damage"].value
						        if dmg == -1 then
						           dmg = player:getMaxHealth()
						        end
								local damageType = configTable["Damage"].type
								doTargetCombatHealth(0, player, damageType, -dmg, -dmg, CONST_ME_NONE)
                             end
							 
					      end
						end
				  end, interval)
				interval = interval + 250	
		   end
		end
	end
		
				  
	return true
end
globalevent:interval(2000)
globalevent:register()