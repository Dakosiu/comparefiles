LEVER_SYSTEM_BUY_CONFIG = {		
                            [1] = {
							        ["Position"] = { x = 998, y = 742, z = 7 },
                                    ["Cost"] = 50000,
									["Items"] = {
									              { type = "item", itemid = 3081, count = 20, backpack_id = 5926 } -- with backpack example
												  --{ type = "item", itemid = 3191, count = 3 }, -- without backpack example
												}
								  },
							[2] = {
							        ["Position"] = { x = 944, y = 1122, z = 7 },
                                    ["Cost"] = 25000,
									["Items"] = {
									              --{ type = "item", itemid = 3155, count = 100, backpack_id = 10346 }, -- with backpack example
												  { type = "item", itemid = 3191, count = 3 } -- without backpack example
												}
								  },
							[3] = {
							        ["Position"] = { x = 945, y = 1122, z = 7 },
                                    ["Cost"] = 25000,
									["Items"] = {
									              --{ type = "item", itemid = 3155, count = 100, backpack_id = 10346 }, -- with backpack example
												  -- with charge example (like might ring)
												  { type = "item", itemid = 3048, count = 10, charge = 20, backpack_id = 5926 } -- without backpack example
												}
								  }
						  }

									


leverBuySystem = { }
leverBuySystem.__newindex = leverBuySystem
leverBuySystem.aid = 7677

function leverBuySystem:prepare()
    for index, v in ipairs(LEVER_SYSTEM_BUY_CONFIG) do
	    local pos = Position(v["Position"])
        if pos then
	        local tile = Tile(pos)
	        local items = tile:getItems()
	        local _found = false
	        if items then
	            for i, item in pairs(items) do
		            item:setAttribute(ITEM_ATTRIBUTE_ACTIONID, leverBuySystem.aid)
			        item:setCustomAttribute("LEVER_SYSTEM_INDEX", index)
			        item:setCustomAttribute("LEVER_SYSTEM_ID", item:getId())
			        --_found = true
		        end
	        end
	        if not _found then
	            local item = Game.createItem(39512, 1, pos)
		        if item then
		           item:setAttribute(ITEM_ATTRIBUTE_ACTIONID, leverBuySystem.aid)
			       item:setCustomAttribute("LEVER_SYSTEM_INDEX", index)
			       item:setCustomAttribute("LEVER_SYSTEM_ID", item:getId())	
                end
            end	
		end
    end
end

-- for index, v in ipairs(LEVER_SYSTEM_BUY_CONFIG2) do
    -- local posTable = v["Position"]
	-- local x = posTable.x
	-- local y = posTable.y
	-- local z = posTable.z
	
	-- print("Index: " .. index)
	-- print("X: " .. x)
	-- print("Y: " .. y)
	-- print("Z: " .. z)
	
	-- local pos = Position(x, y, z)
	

	-- if pos then
	   -- print("Found Pos: " .. print(dump(pos)))
	   -- -- local tile = Tile(pos)
	   -- -- local items = tile:getItems()
	   -- -- local _found = false
	   -- -- if items then
	      -- -- for i, item in pairs(items) do
		      -- -- item:setAttribute(ITEM_ATTRIBUTE_ACTIONID, leverBuySystem.aid)
			  -- -- item:setCustomAttribute("LEVER_SYSTEM_INDEX", index)
			  -- -- item:setCustomAttribute("LEVER_SYSTEM_ID", item:getId())
			  -- -- _found = true
		  -- -- end
	   -- -- end
	   -- -- if not _found then
	      -- -- local item = Game.createItem(39512, 1, pos)
		  -- -- if item then
		     -- -- item:setAttribute(ITEM_ATTRIBUTE_ACTIONID, leverBuySystem.aid)
			 -- -- item:setCustomAttribute("LEVER_SYSTEM_INDEX", index)
			 -- -- item:setCustomAttribute("LEVER_SYSTEM_ID", item:getId())	
          -- -- end
       -- -- end		  
	      
	-- end
-- end

-- end


function leverBuySystem:canGetItem(player, items)
    for i = 1, #items do
	    local id = items[i].itemid
		local count = items[i].count
        local charge = items[i].charge   
		if charge then
		    for z = 1, count do
			    local item = Game.createItem(id, charge)
				if player:addItemEx(item) ~= RETURNVALUE_NOERROR then
				    return false
				end
				item:remove()
			end
		end
	end
	return true
end
	
	
    
	

function leverBuySystem:buyItems(player, t)
    
	local playerMoney = player:getMoney()
	local cost = t["Cost"] 
	if playerMoney < cost then
	   player:sendCancelMessage("You still need " .. cost - playerMoney .. " money to buy this.")
	   return false
	end
		
	local itemsTable = t["Items"]
	
	local items = {}
	
	local items2 = {}
	
	
	local str = "You have bought "
	for i, v in pairs(itemsTable) do
	    if v.type == "item" then
		   table.insert(items, v)
		end
    end
	
	if #items > 0 then
	   for i = 1, #items do
	       local id = items[i].itemid
		   local count = items[i].count
		   local bp = items[i].backpack_id
		   local charge = items[i].charge
		   if bp then
		      local container = Game.createItem(bp, 1)
			  if container then
                 if charge then
				    for z = 1, count do
			            container:addItem(id, charge)
					end
				    else
				    container:addItem(id, count)
				end
			  end
			  if player:addItemEx(container) ~= RETURNVALUE_NOERROR then
		         local weight = container:getWeight()
                 if player:getFreeCapacity() < weight then
                    --return player:sendCancelMessage(string.format('You have found %s weighing %.2f oz. You have no capacity.', getItemName(id), (weight / 100)))
					return player:sendCancelMessage('You have no empty space in backpack or not enough capacity.')
                 else
                    return player:sendCancelMessage('You have no empty space in backpack or not enough capacity.')
                 end
			  end
			  str = str .. count .. "x " .. getItemName(id)
			  if i == #items then
			     --str = str .. "."
			  else
			     str = str .. ", "
			  end
		   else
		      table.insert(items2, items[i])
			end
		      -- local item = Game.createItem(id, count)
		      -- if player:addItemEx(item) ~= RETURNVALUE_NOERROR then
		         -- local weight = item:getWeight() * count
                 -- if player:getFreeCapacity() < weight then
                    -- return player:sendCancelMessage(string.format('You have found %s weighing %.2f oz. You have no capacity.', getItemName(id), (weight / 100)))
                 -- else
                    -- return player:sendCancelMessage('You have no empty space in backpack.')
                 -- end			     
		      -- end
			  -- str = str .. count .. "x " .. getItemName(id)
			  -- if i == #items then
			     -- --str = str .. "."
			  -- else
			     -- str = str .. ", "
			  -- end
		end	
	end
	
	if #items2 > 0 then
	   if not leverBuySystem:canGetItem(player, items2) then
	        return player:sendCancelMessage('You have no empty space in backpack or not enough capacity.')
		end
	        for i = 1, #items2 do
	            local id = items2[i].itemid
		        local count = items2[i].count
                local charge = items2[i].charge
				if charge then
				    for z = 1, count do
					    player:addItem(id, charge)
					end
				else
				    player:addItem(id, count)
				end
			  str = str .. count .. "x " .. getItemName(id)
			  if i == #items then
			     --str = str .. "."
			  else
			     str = str .. ", "
			  end
			end
	end
            		   
	str = str .. " for " .. cost .. " money."
	player:removeMoney(cost)
	player:sendTextMessage(MESSAGE_INFO_DESCR, str)
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
end		
	
	
	
	
	
local globalevent = GlobalEvent("load_leverBuySystem")
function globalevent.onStartup()
	leverBuySystem:prepare()
end
globalevent:register()	


local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
      
	  local index = item:getCustomAttribute("LEVER_SYSTEM_INDEX")
	  if not index then
	     return true
	  end
	   
	  local t = LEVER_SYSTEM_BUY_CONFIG[index]
	  if not t then
	     print("TABLE NOT FOUND")
	     return true
	  end
	  leverBuySystem:buyItems(player, t)
return true
end
action:aid(leverBuySystem.aid)
action:register()