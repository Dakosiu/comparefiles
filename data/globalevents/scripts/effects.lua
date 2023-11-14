function onThink(cid, interval, lastExecution)

	local interval = 0
	for c = 1, 8 do
	    local _selectedInterval = false
		for i, position in pairs(WAVES_CONFIG[c]) do
	       	local pos = Position(position)
			

			
			      addEvent(function()
				       pos:sendMagicEffect(WAVES_CONFIG.effects[2])
					   
					   for z = 1, #WAVES_CONFIG.grounds do
					         local ground = Tile(pos):getItemById(WAVES_CONFIG.grounds[z])
					               if ground then
					                  ground:setAttribute(ITEM_ATTRIBUTE_ACTIONID, 8525)
					               end
					   end
				  end, interval)
				  
				 addEvent(function()
					   for z = 1, #WAVES_CONFIG.grounds do
					         local ground = Tile(pos):getItemById(WAVES_CONFIG.grounds[z])
					               if ground then
					                  ground:setAttribute(ITEM_ATTRIBUTE_ACTIONID, 0)
					               end
					   end
				  end, interval + 500)
				  

				interval = interval + 250	
	    end
    end
				  
		return true
end