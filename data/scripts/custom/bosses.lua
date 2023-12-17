--[[ local LEVEL_LOWER = 1
local LEVEL_SAME = 2
local LEVEL_HIGHER = 3

local DISTANCE_BESIDE = 1
local DISTANCE_CLOSE = 2
local DISTANCE_FAR = 3
local DISTANCE_VERYFAR = 4
local directions = {
	[DIRECTION_NORTH] = "north",
	[DIRECTION_SOUTH] = "south",
	[DIRECTION_EAST] = "east",
	[DIRECTION_WEST] = "west",
	[DIRECTION_NORTHEAST] = "north-east",
	[DIRECTION_NORTHWEST] = "north-west",
	[DIRECTION_SOUTHEAST] = "south-east",
	[DIRECTION_SOUTHWEST] = "south-west"
}
local messages = {
	[DISTANCE_BESIDE] = {
		[LEVEL_LOWER] = "is below you",
		[LEVEL_SAME] = "is standing next to you",
		[LEVEL_HIGHER] = "is above you"
	},
	[DISTANCE_CLOSE] = {
		[LEVEL_LOWER] = "is on a lower level to the",
		[LEVEL_SAME] = "is to the",
		[LEVEL_HIGHER] = "is on a higher level to the"
	},
	[DISTANCE_FAR] = "is far to the",
	[DISTANCE_VERYFAR] = "is very far to the"
}

function sort_descending(t)
    local tmp = {}
    for k, v in pairs(t) do
        table.insert(tmp, {k, v})
    end
    table.sort(tmp, function(a, b) return a[2] > b[2] end)
    return tmp
end

function table.find(t, v)
    for i,x in pairs(t) do
        if x == v then
            return true
        end
    end
end

function Player:addItemRewardBag(itemid, count)
    local rewardbag = self:getRewardBag()
    return rewardbag:addItem(itemid, count)
end

function MonsterType:getBossReward(chance, unique)
    local ret = {}
    local function randomItem(lootBlock, chance)
        local randvalue = math.random(0, 100000) / (getConfigInfo("rateLoot") * chance)
        if randvalue < lootBlock.chance then
            if (ItemType(lootBlock.itemId):isStackable()) then
                return (randvalue%lootBlock.maxCount) + 1
            else
                return 1
            end
        end
    end
    local lootBlockList = self:getLoot()
    for _, loot in pairs(lootBlockList) do
        local rd = randomItem(loot, chance)
        if rd then
            if loot.uniquedrop then
                if unique then
                    table.insert(ret, {loot, rd})
                end
            else
                table.insert(ret, {loot, rd})
            end
        end
    end
    return ret
end

BossLoot = {}
BossUids = {}

function BossLoot:new(boss)
    if not table.find(BossUids, boss:getId()) then
        table.insert(BossUids, boss:getId())
        return setmetatable({creature=boss}, {__index = BossLoot})
    end
end

function BossLoot:updateDamage()
    if self.creature then
        local tmp = {}
        local totaldmg = 0
        for killer, damage in pairs(self.creature:getDamageMap()) do
            totaldmg = totaldmg+damage.total
            tmp[killer] = damage.total
        end
        self.players = sort_descending(tmp)
        self.totaldmg = totaldmg
    else
        error("Creature not found.")
    end
end

function BossLoot:setRewards()
    if self.totaldmg and self.creature then
        if getConfigInfo("rateLoot") > 0 then
            local mt = MonsterType(self.creature:getName())
            for i, playertab in ipairs(self.players) do
                local loot
                if i == 1 then
                    loot = mt:getBossReward(playertab[2] / self.totaldmg, true)
                else
                    loot = mt:getBossReward(playertab[2] / self.totaldmg, false)
                end
                table.insert(self.players[i], loot)
            end
        end
    else
        error("Error")
    end
end

function BossLoot:addRewards()
    if self.players and self.players[1] and self.players[1][3] then
        for i, playertab in ipairs(self.players) do
            local player = Player(playertab[1])
            if player then
                local str = "The following items are available in your reward chest: "
                for i, lootTable in ipairs(playertab[3]) do
                    local item = player:addItemRewardBag(lootTable[1].itemId, math.ceil(lootTable[2]))
                    if item then
                        str = str .. item:getNameDescription() .. ", "
                    end
                end
                str = str:sub(1, #str-2)
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, str)
            end
        end
    else
        error("Error")
    end
end

local function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

local function removeFromTableByString(tbl, val)
  for i, v in ipairs(tbl) do
    if v == val then
      return table.remove(tbl, i)
    end
  end
end

local globalevent = GlobalEvent("Bosses_onStartUp")
function globalevent.onStartup()
	
	return true
end
globalevent:register()

if not GAME_BOSS_LIST then
   GAME_BOSS_LIST = {}
end

local talk = TalkAction("/bossesa")
function talk.onSay(player, words, param)
		
	player:registerEvent("ModalWindow_Bosses")
	if not GAME_BOSS_LIST or #GAME_BOSS_LIST == 0 then
	   player:sendCancelMessage("there is no bosses spawned.")
	   return true
	end
	
	local title = "Boss List"
	local message = "There is a list with spawned bosses."
	local window = ModalWindow(1000, title, message)
    window:addButton(100, "Find Boss")
	window:addButton(103, "Loot Info")
    window:addButton(101, "Cancel")
	
	for i, v in ipairs(GAME_BOSS_LIST) do
	    --local monster = Monster(
	    window:addChoice(i, firstToUpper(v))
    end
     
    window:setDefaultEnterButton(100)
    window:setDefaultEscapeButton(101)
           		   
    window:sendToPlayer(player)
	
    return true

end

talk:separator(" ")
talk:register()

local creatureevent = CreatureEvent("ModalWindow_Bosses")
function creatureevent.onModalWindow(player, modalWindowId, buttonId, choiceId)  
    player:unregisterEvent("ModalWindow_Bosses")
	
    if modalWindowId == 1000 then
        if buttonId == 100 then
           	if GAME_BOSS_LIST then
			   local selectedBoss = GAME_BOSS_LIST[choiceId]
			   
			   
	local target = Creature(selectedBoss)
	if target then
	   if target:isMonster() then
	      local monstertype = MonsterType(selectedBoss)
		        if not monstertype:isBoss() then
				       player:sendCancelMessage("this monster is not a boss.")
		               player:getPosition():sendMagicEffect(CONST_ME_POFF)
					   return false
			    end
	   else
	      player:sendCancelMessage("you can find only monsters.")
		  player:getPosition():sendMagicEffect(CONST_ME_POFF)
		  return false
		  end
	end
		
	if not target then
		player:sendCancelMessage("this boss is not spawned at this moment.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end


	local targetPosition = target:getPosition()
	local creaturePosition = player:getPosition()
	local positionDifference = {
		x = creaturePosition.x - targetPosition.x,
		y = creaturePosition.y - targetPosition.y,
		z = creaturePosition.z - targetPosition.z
	}

	local maxPositionDifference, direction = math.max(math.abs(positionDifference.x), math.abs(positionDifference.y))
	if maxPositionDifference >= 5 then
		local positionTangent = positionDifference.x ~= 0 and positionDifference.y / positionDifference.x or 10
		if math.abs(positionTangent) < 0.4142 then
			direction = positionDifference.x > 0 and DIRECTION_WEST or DIRECTION_EAST
		elseif math.abs(positionTangent) < 2.4142 then
			direction = positionTangent > 0 and (positionDifference.y > 0 and DIRECTION_NORTHWEST or DIRECTION_SOUTHEAST) or positionDifference.x > 0 and DIRECTION_SOUTHWEST or DIRECTION_NORTHEAST
		else
			direction = positionDifference.y > 0 and DIRECTION_NORTH or DIRECTION_SOUTH
		end
	end

	local level = positionDifference.z > 0 and LEVEL_HIGHER or positionDifference.z < 0 and LEVEL_LOWER or LEVEL_SAME
	local distance = maxPositionDifference < 5 and DISTANCE_BESIDE or maxPositionDifference < 101 and DISTANCE_CLOSE or maxPositionDifference < 275 and DISTANCE_FAR or DISTANCE_VERYFAR
	local message = messages[distance][level] or messages[distance]
	if distance ~= DISTANCE_BESIDE then
		message = message .. " " .. directions[direction]
	end

	player:sendTextMessage(MESSAGE_INFO_DESCR, target:getName() .. " " .. message .. ".")
	creaturePosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
			   
			end
		end
		
		
	if buttonId == 103 then

	   if GAME_BOSS_LIST then
	        local selectedBoss = GAME_BOSS_LIST[choiceId]
	      	local title = "Boss Description"
			local str = ""
						
			local monstertype = MonsterType(selectedBoss)
			if monstertype then
			   local loot = monstertype:getLoot()
			   for i = 1, #loot do
				   local item = "#" .. i .. " " .. firstToUpper(getItemName(loot[i]["itemId"]))
				   if i == #loot then
				      str = str .. item
				   else
				      str = str .. item .. "\n"
				   end
			   end
			end
				
	        local message = "Loot List: " .. "\n" .. str
			
	        local window = ModalWindow(1000, title, message)
            window:addButton(101, "Cancel")
            window:setDefaultEscapeButton(101)    		   
            window:sendToPlayer(player)
	   end
	end
		
		
        end
end
creatureevent:register()

creatureevent = CreatureEvent("bossDeath")
function creatureevent.onDeath(creature, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)

	    local mt = MonsterType(creature:getName())
        if mt then
		   if mt:useRewardChest() then
              local loot = BossLoot:new(creature)
              if loot then
                creature:setDropLoot(false)
                loot:updateDamage()
                loot:setRewards()
                loot:addRewards()
                corpse:setAttribute('aid', 21584)
            end
         end
		 
		 if mt:isBoss() then
		    local name = creature:getName():lower()
		    removeFromTableByString(GAME_BOSS_LIST, name)
		 end
		 
		end
	  
	  return true
end
creatureevent:register()
 -- --]]