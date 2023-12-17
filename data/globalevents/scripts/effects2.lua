function onThink(cid, interval, lastExecution)

	local tp = Position(WAVES_CONFIG.teleportDestination.x, WAVES_CONFIG.teleportDestination.y, WAVES_CONFIG.teleportDestination.z)
	
	for c = 1, #WAVES_CONFIG do
	
		for i, position in pairs(WAVES_CONFIG[c]) do
		    local pos = Position(position)					   
				  for z = 1, #WAVES_CONFIG.grounds do
					  local ground = Tile(pos):getItemById(WAVES_CONFIG.grounds[z])
					        if ground then
					           if ground:getAttribute(ITEM_ATTRIBUTE_ACTIONID) > 0 then
							      local tile = Tile(pos)
		                          local topCreature = tile:getTopCreature()
		                                if topCreature and topCreature:isPlayer() then
										   
										    local specialNames = { "Dakos", "Vanagas" }
										   
										    if isInArray(specialNames, topCreature:getName()) then
										      topCreature:say("This sqm is working!")
										    else
			                                  topCreature:getPosition():sendMagicEffect(67)
			                                  topCreature:teleportTo(tp)
											    if ground:getAttribute(ITEM_ATTRIBUTE_ACTIONID) == 8525 then
											        topCreature:addHealth(WAVES_CONFIG.damage[1])
												elseif ground:getAttribute(ITEM_ATTRIBUTE_ACTIONID) == 8524 then
												    topCreature:addHealth(WAVES_CONFIG.damage[2])
												elseif ground:getAttribute(ITEM_ATTRIBUTE_ACTIONID) == 8526 then
												    topCreature:addHealth(WAVES_CONFIG.damage[3])
												elseif ground:getAttribute(ITEM_ATTRIBUTE_ACTIONID) == 8527 then
												    if WAVES_CONFIG.damage[4] then
												       topCreature:addHealth(WAVES_CONFIG.damage[4])
												    end
											    end
												
												topCreature:say("You warrior better no run in my caves or i will take your blood from you")
												
												-- local condition = Condition(CONDITION_BLEEDING, 233)
												
												      -- if topCreature:hasCondition(CONDITION_BLEEDING, 233) then
													      
													     -- topCreature:removeCondition(condition)
													  -- end
													  
                                                      -- condition:setParameter(CONDITION_PARAM_DELAYED, 1)
                                                      -- condition:addDamage(50, 1000, 60 * 1000 * 10)
                                                      -- topCreature:addCondition(condition)
											end
		                                end
					           end
					   end
				  end
		end
				  
	end
			  
		return true
end