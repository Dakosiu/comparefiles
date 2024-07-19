local exhaust_table = "PLAYERS_MIGHT_RING"
local moveevent = MoveEvent()
moveevent:type("equip")
function moveevent.onEquip(player, item, slot, isCheck)
    
   	if dakosLib:getExhaust(exhaust_table, player) then
       return false   
	end
	
	if not isCheck then
	   dakosLib:setExhaust(exhaust_table, player, "seconds", 10)
	end
	return true
end
moveevent:id(3048)
moveevent:register()

moveevent = MoveEvent()
moveevent:type("deequip")
function moveevent.onDeEquip(player, item, slot, isCheck)
	return true
end
moveevent:id(3048)
moveevent:register()