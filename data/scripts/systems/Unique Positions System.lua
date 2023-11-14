if not UNIQUE_POSITIONS_SYSTEM then
   UNIQUE_POSITIONS_SYSTEM = {}
end


UNIQUE_POSITIONS_SYSTEM.config = {
                                   [1] = {
								           position = { x = 838, y = 863, z = 3 },
								           requiredLevel = 42,
										   needPremium = true
										 },
								   [2] = {
								           position = { x = 336, y = 2181, z = 10 },
								           requiredLevel = 450,
										   needPremium = true
										 },
								   [3] = {
								           position = { x = 839, y = 863, z = 3 },
								           requiredLevel = 42,
										   needPremium = true
										 },
								   [4] = {
								           position = { x = 1150, y = 1037, z = 8 },
								           requiredLevel = 1,
										   needPremium = true
										 },
								   [5] = {
								           position = { x = 1150, y = 1039, z = 8 },
								           requiredLevel = 1,
										   needPremium = true
										 },
								 }
								 
								 
								 
UNIQUE_POSITIONS_SYSTEM.actionid = 7772
UNIQUE_POSITIONS_SYSTEM.attribute = "UNIQUE_POSITIONS_INDEX"

function UNIQUE_POSITIONS_SYSTEM:prepare()
    for i, v in ipairs(self.config) do
        local x = v.position.x
	    local y = v.position.y
	    local z = v.position.z
        local pos = Position(x, y,z)
	    if pos then
	        local tile = Tile(pos)
		    if tile then
		        local ground = tile:getGround()
			    if ground then
				   ground:setAttribute(ITEM_ATTRIBUTE_ACTIONID, self.actionid)
				   ground:setCustomAttribute(UNIQUE_POSITIONS_SYSTEM.attribute, i)
				end
			end    
	    end
	end
end

local globalevent = GlobalEvent("load_UNIQUE_POSITIONS_SYSTEM")
function globalevent.onStartup()
	UNIQUE_POSITIONS_SYSTEM:prepare()
end
globalevent:register()	

local moveevent = MoveEvent()
moveevent:type("stepin")
function moveevent.onStepIn(creature, item, position, fromPosition)
    local player = Player(creature)
    if not player or player:isInGhostMode() then 
	   return true 
	end
	
	local index = item:getCustomAttribute(UNIQUE_POSITIONS_SYSTEM.attribute)
	if not index or index < 1 then
	   return true
	end
	
	local t = UNIQUE_POSITIONS_SYSTEM.config[index]
	if not t then
	   return true
	end
	
	local premium = t.needPremium 
	if premium then
	    if not player:isPremium() then
	       player:sendTextMessage(MESSAGE_STATUS_WARNING, "You need premium account to access this place.")
		   fromPosition:sendMagicEffect(1093)
		   player:teleportTo(fromPosition)
		   return true
		end
	end
	
	local level = t.requiredLevel
	if level then
	    if player:getLevel() < level then
		   player:sendTextMessage(MESSAGE_STATUS_WARNING, "Your level is too low. To access this place you need to be " .. level .. " level atleast.")
		   player:teleportTo(fromPosition)
		   fromPosition:sendMagicEffect(1093)
		   return true
        end		   
	end
	position:sendMagicEffect(CONST_ME_MAGIC_GREEN)
	return true
end
moveevent:aid(UNIQUE_POSITIONS_SYSTEM.actionid)
moveevent:register()