local opcode = 204

if not hotkeys then
    hotkeys = {
		items = {860, 861, 862, 863}
	}
end

function hotkeys:sendUpdate(player)
	
	local items = {}
	for _, itemId in ipairs(hotkeys.items) do
		local count = player:getItemCount(itemId)
		items[itemId] = count	
	end

	local msg = NetworkMessage()
	msg:addByte(50)
	msg:addByte(opcode)
	msg:addString(json.encode({action = "updateCounts", data = items}))
	msg:sendToPlayer(player)
end

local hotkeysOpcode = CreatureEvent("hotkeysOpcode")
function hotkeysOpcode.onExtendedOpcode(player, opcode, buffer)
    if opcode == opcode then
        --
    end
end
hotkeysOpcode:register()
    
	