function onThink(cid, interval, lastExecution)
    
	for c = 9, 11 do
	    
		local interval = 0
		for i, position in pairs(WAVES_CONFIG[c]) do
	       	local pos = Position(position)
			      addEvent(function()
				       pos:sendMagicEffect(WAVES_CONFIG.effects[1])
					   
					   for z = 1, #WAVES_CONFIG.grounds do
					         local ground = Tile(pos):getItemById(WAVES_CONFIG.grounds[z])
					               if ground then
					                  ground:setAttribute(ITEM_ATTRIBUTE_ACTIONID, 8524)
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
	
	for c = 12, 15 do
	    
		local interval = 0
		for i, position in pairs(WAVES_CONFIG[c]) do
	       	local pos = Position(position)
			      addEvent(function()
				       pos:sendMagicEffect(WAVES_CONFIG.effects[2])
					   
					   for z = 1, #WAVES_CONFIG.grounds do
					         local ground = Tile(pos):getItemById(WAVES_CONFIG.grounds[z])
					               if ground then
					                  ground:setAttribute(ITEM_ATTRIBUTE_ACTIONID, 8526)
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
				  --interval = interval + 250	
	    end
	end
	
	for c = 16, 17 do
	    
		local interval = 0
		for i, position in pairs(WAVES_CONFIG[c]) do
	       	local pos = Position(position)
			      addEvent(function()
				       pos:sendMagicEffect(WAVES_CONFIG.effects[2])
					   
					   for z = 1, #WAVES_CONFIG.grounds do
					         local ground = Tile(pos):getItemById(WAVES_CONFIG.grounds[z])
					               if ground then
					                  ground:setAttribute(ITEM_ATTRIBUTE_ACTIONID, 8526)
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
	
		    
	local interval = 0
		for i, position in pairs(WAVES_CONFIG[18]) do
	       	local pos = Position(position)
			      addEvent(function()
				       pos:sendMagicEffect(WAVES_CONFIG.effects[3])
					   
					   --for i = 1, 12 do
					   local pos2 = Position(pos.x, pos.y + i, pos.z)
					   if i == 1 then
					   --pos:sendDistanceEffect(pos2, 32)
					   end
					   --end
					   
					   for z = 1, #WAVES_CONFIG.grounds do
					         local ground = Tile(pos):getItemById(WAVES_CONFIG.grounds[z])
					               if ground then
					                  ground:setAttribute(ITEM_ATTRIBUTE_ACTIONID, 8526)
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
	
	    
	local interval = 0
		for i, position in pairs(WAVES_CONFIG[19]) do
	       	local pos = Position(position)
			      addEvent(function()
				       pos:sendMagicEffect(WAVES_CONFIG.effects[3])
					   
					   local pos2 = Position(pos.x - i, pos.y + i, pos.z)
					   
					   if i == 1 then
					   --pos:sendDistanceEffect(pos2, 32)
					   end
					   
					   for z = 1, #WAVES_CONFIG.grounds do
					         local ground = Tile(pos):getItemById(WAVES_CONFIG.grounds[z])
					               if ground then
					                  ground:setAttribute(ITEM_ATTRIBUTE_ACTIONID, 8526)
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
	
	local interval = 0
		for i, position in pairs(WAVES_CONFIG[20]) do
	       	local pos = Position(position)
			      addEvent(function()
				       pos:sendMagicEffect(WAVES_CONFIG.effects[4])
					   
					   local pos2 = Position(pos.x, pos.y - i, pos.z)
					   ----pos:sendDistanceEffect(pos2, 32)
					   
					   for z = 1, #WAVES_CONFIG.grounds do
					         local ground = Tile(pos):getItemById(WAVES_CONFIG.grounds[z])
					               if ground then
					                  ground:setAttribute(ITEM_ATTRIBUTE_ACTIONID, 8527)
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
	
	local interval = 0
		for i, position in pairs(WAVES_CONFIG[21]) do
	       	local pos = Position(position)
			      addEvent(function()
				       pos:sendMagicEffect(WAVES_CONFIG.effects[3])
					   
					   local pos2 = Position(pos.x - 6, pos.y + 6, pos.z)
					   
					   if i == 1 then
					   --pos:sendDistanceEffect(pos2, 32)
					   end
					   
					   for z = 1, #WAVES_CONFIG.grounds do
					         local ground = Tile(pos):getItemById(WAVES_CONFIG.grounds[z])
					               if ground then
					                  ground:setAttribute(ITEM_ATTRIBUTE_ACTIONID, 8526)
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
	
	local interval = 0
		for i, position in pairs(WAVES_CONFIG[22]) do
	       	local pos = Position(position)
			      addEvent(function()
				       pos:sendMagicEffect(WAVES_CONFIG.effects[3])
					   
					   local pos2 = Position(pos.x - i, pos.y, pos.z)
					   if i == 1 then
					   --pos:sendDistanceEffect(pos2, 32)
					   end
					   
					   for z = 1, #WAVES_CONFIG.grounds do
					         local ground = Tile(pos):getItemById(WAVES_CONFIG.grounds[z])
					               if ground then
					                  ground:setAttribute(ITEM_ATTRIBUTE_ACTIONID, 8526)
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
	
	local interval = 0
	for i, position in pairs(WAVES_CONFIG[23]) do
	       	local pos = Position(position)
			      addEvent(function()
				       pos:sendMagicEffect(WAVES_CONFIG.effects[3])
					   
					   local pos2 = Position(pos.x + i, pos.y + i, pos.z)
					   if i == 1 then
					   --pos:sendDistanceEffect(pos2, 32)
					   end
					   
					   for z = 1, #WAVES_CONFIG.grounds do
					         local ground = Tile(pos):getItemById(WAVES_CONFIG.grounds[z])
					               if ground then
					                  ground:setAttribute(ITEM_ATTRIBUTE_ACTIONID, 8526)
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
	
	local interval = 0
	for i, position in pairs(WAVES_CONFIG[24]) do
	       	local pos = Position(position)
			      addEvent(function()
				       pos:sendMagicEffect(WAVES_CONFIG.effects[3])
					   
					   local pos2 = Position(pos.x + i, pos.y + i, pos.z)
					   if i == 1 then
					   --pos:sendDistanceEffect(pos2, 32)
					   end
					   
					   for z = 1, #WAVES_CONFIG.grounds do
					         local ground = Tile(pos):getItemById(WAVES_CONFIG.grounds[z])
					               if ground then
					                  ground:setAttribute(ITEM_ATTRIBUTE_ACTIONID, 8526)
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
	
	local interval = 0
	for i, position in pairs(WAVES_CONFIG[25]) do
	       	local pos = Position(position)
			      addEvent(function()
				       pos:sendMagicEffect(WAVES_CONFIG.effects[3])
					   
					   local pos2 = Position(pos.x + i, pos.y, pos.z)
					   
					   if i == 1 then
					   --pos:sendDistanceEffect(pos2, 32)
					   end
					   
					   for z = 1, #WAVES_CONFIG.grounds do
					         local ground = Tile(pos):getItemById(WAVES_CONFIG.grounds[z])
					               if ground then
					                  ground:setAttribute(ITEM_ATTRIBUTE_ACTIONID, 8526)
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
	
	local interval = 0
	for i, position in pairs(WAVES_CONFIG[26]) do
	       	local pos = Position(position)
			      addEvent(function()
				       pos:sendMagicEffect(WAVES_CONFIG.effects[3])
					   
					   local pos2 = Position(pos.x + i, pos.y - i, pos.z)
					   if i == 1 then
					   --pos:sendDistanceEffect(pos2, 32)
					   end
					   
					   for z = 1, #WAVES_CONFIG.grounds do
					         local ground = Tile(pos):getItemById(WAVES_CONFIG.grounds[z])
					               if ground then
					                  ground:setAttribute(ITEM_ATTRIBUTE_ACTIONID, 8526)
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
	
	local interval = 0
	for i, position in pairs(WAVES_CONFIG[27]) do
	       	local pos = Position(position)
			      addEvent(function()
				       pos:sendMagicEffect(WAVES_CONFIG.effects[3])
					   
					   local pos2 = Position(pos.x - i, pos.y - i, pos.z)
					   
					   if i == 1 then
					   --pos:sendDistanceEffect(pos2, 32)
					   end
					   
					   for z = 1, #WAVES_CONFIG.grounds do
					         local ground = Tile(pos):getItemById(WAVES_CONFIG.grounds[z])
					               if ground then
					                  ground:setAttribute(ITEM_ATTRIBUTE_ACTIONID, 8526)
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

	
	return true
end