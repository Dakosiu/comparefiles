LEVER_SYSTEM_CONFIG = {
                 [1] = {
				         ["Lever"] = { 724, 847, 7 },
						 ["Stone"] = { 728, 815, 7, id = 1355 },
						 ["Time"] = 120 --- w sekundach
                       },
                 [2] = {
				         ["Lever"] = { 743, 844, 7 },
						 ["Stone"] = { 728, 814, 7, id = 1355 },
						 ["Time"] = 120 --- w sekundach
                       },
					   
			   }
                 					   
				          


leverSystem = { }
leverSystem.__newindex = leverSystem
leverSystem.aid = 1677

function leverSystem:prepare()

for index, v in pairs(LEVER_SYSTEM_CONFIG) do
    local x = v["Lever"][1]
	local y = v["Lever"][2]
	local z = v["Lever"][3]
	local pos = Position(x, y, z)
	
	if pos then
	   local tile = Tile(pos)
	   local items = tile:getItems()
	   if items then
	      for i, item in pairs(items) do
		      item:setAttribute(ITEM_ATTRIBUTE_ACTIONID, leverSystem.aid)
			  item:setCustomAttribute("LEVER_SYSTEM_INDEX", index)
			  item:setCustomAttribute("LEVER_SYSTEM_ID", item:getId())
		  end
	   end
	end
end

end
   
local globalevent = GlobalEvent("load_leverSystem")
function globalevent.onStartup()
	leverSystem:prepare()
end
globalevent:register()	
	
local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
      
	  local index = item:getCustomAttribute("LEVER_SYSTEM_INDEX")
	  if not index then
	     return true
	  end
	   
	  local t = LEVER_SYSTEM_CONFIG[index]
	  if not t then
	     print("TABLE NOT FOUND")
	     return true
	  end
	 
	 local lever_position = Position(fromPosition.x, fromPosition.y, fromPosition.z)
	 
     local x = t["Stone"][1]
     local y = t["Stone"][2]
     local z = t["Stone"][3]
     local id = t["Stone"].id
	 
	 local pos = Position(x, y, z)
	 if not pos then
	    print("POS NOT FOUND")
	    return true
     end
	 
	 local stoneTile = Tile(pos)
	 if not stoneTile then
	    print("STONE TILE NOT FOUND")
	    return true
     end
	 
	 	 
	 local lever_id = item:getCustomAttribute("LEVER_SYSTEM_ID")
	 if not lever_id then
	    print("LEVER ID NOT FOUND")
	    return true
     end
	 
	 local stone = stoneTile:getItemById(id)
	 
	 if not stone then
		player:sendCancelMessage("There is no stone to remove.")
		return true
	 end
	 
     stone:remove()
	 
	 if item:getId() == lever_id then
	    item:transform(lever_id + 1)
	 else
	    item:transform(lever_id)
	 end
	 
	 local interval = t["Time"]
	 
	 
	 addEvent(function(position)
            Game.createItem(id, 1, position)
            position:sendMagicEffect(CONST_ME_POFF)
			
			local tile = Tile(fromPosition)
			if not tile then
			   print("TILE NOT FOUND ADD EVENT")
			   return false
			end
			
            local thing = tile:getItemById(lever_id + 1)

			if not thing then
			   print("THING NOT FOUN ADD EVENT")
			   return false
			end
		
			thing:transform(lever_id)
    end, interval * 1000, stoneTile:getPosition())
	  
return true
end

action:aid(leverSystem.aid)
action:register()