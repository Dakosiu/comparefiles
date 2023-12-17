if not bossSystem then
    bossSystem = {}
    bossSystem.onDeath = "onDeath_boss"
    bossSystem.onModalBoss = "ModalWindow_Bosses"
    -- bossSystem.onModalGrizzlyBoss = "ModalWindow_GrizzlyBosses"
end

local LEVEL_LOWER = 1
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
	if rewardbag then
		return rewardbag:addItem(itemid, count)
	else
		error("Error in RewardChest")
	end
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

function bossSystem:register(creature)
    if not creature then return nil end

    local MonsterType = MonsterType(creature:getName())
    if not MonsterType then return false end

    local _shouldRegister = false

    if MonsterType:isBoss() then
        if not BOSS_LIST then BOSS_LIST = {} end
        _shouldRegister = true
        local values = {
            ["Name"] = creature:getName(),
            ["Boss Level"] = MonsterType:getBossLevel()
        }
        table.insert(BOSS_LIST, values)
    end

    if _shouldRegister then creature:registerEvent(bossSystem.onDeath) end
end

function bossSystem:getBosses(t)
    if not t then return nil end
    table.sort(t, function(a, b) return a["Boss Level"] < b["Boss Level"] end)
    return t
end

function bossSystem:getTable(creature)

    if not creature then return nil end

    local MonsterType = MonsterType(creature:getName())
    if not MonsterType then return false end

    if MonsterType:isBoss() then if BOSS_LIST then return BOSS_LIST end end
    return false
end

function bossSystem:remove(creature)

    if not creature then return nil end

    local MonsterType = MonsterType(creature:getName())
    if not MonsterType then return false end

    local t = bossSystem:getTable(creature)
    if not t then return false end

    for i, v in pairs(t) do
        local selfName = creature:getName():lower()
        local name = v["Name"]:lower()
        if name == selfName then return table.remove(t, i) end
    end
end

function bossSystem:getBossesCount(t)
    if not t then return nil end

    return #t
end

local creatureevent = CreatureEvent(bossSystem.onDeath)
function creatureevent.onDeath(creature, corpse, killer, mostDamageKiller,
                               lastHitUnjustified, mostDamageUnjustified)
    if not creature or not creature:isMonster() then return true end
    bossSystem:remove(creature)
    return true
end

creatureevent:register()

creatureevent = CreatureEvent(bossSystem.onModalBoss)
function creatureevent.onModalWindow(player, modalWindowId, buttonId, choiceId)

    --if not modalWindowId == 49812 then return true end
	
	if modalWindowId ~= 1788 then
	   return true
	end
    -- player:unregisterEvent(bossSystem.onModalBoss)

    local t = BOSS_LIST
    if buttonId == 100 then
        if t then
            local selectedBoss = t[choiceId]["Name"]
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
                player:sendCancelMessage(
                    "this boss is not spawned at this moment.")
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
            local maxPositionDifference, direction = math.max(math.abs(
                                                                  positionDifference.x),
                                                              math.abs(
                                                                  positionDifference.y))
            if maxPositionDifference >= 5 then
                local positionTangent = positionDifference.x ~= 0 and
                                            positionDifference.y /
                                            positionDifference.x or 10
                if math.abs(positionTangent) < 0.4142 then
                    direction = positionDifference.x > 0 and DIRECTION_WEST or
                                    DIRECTION_EAST
                elseif math.abs(positionTangent) < 2.4142 then
                    direction = positionTangent > 0 and
                                    (positionDifference.y > 0 and
                                        DIRECTION_NORTHWEST or
                                        DIRECTION_SOUTHEAST) or
                                    positionDifference.x > 0 and
                                    DIRECTION_SOUTHWEST or DIRECTION_NORTHEAST
                else
                    direction = positionDifference.y > 0 and DIRECTION_NORTH or
                                    DIRECTION_SOUTH
                end
            end

            local level = positionDifference.z > 0 and LEVEL_HIGHER or
                              positionDifference.z < 0 and LEVEL_LOWER or
                              LEVEL_SAME
            local distance = maxPositionDifference < 5 and DISTANCE_BESIDE or
                                 maxPositionDifference < 101 and DISTANCE_CLOSE or
                                 maxPositionDifference < 275 and DISTANCE_FAR or
                                 DISTANCE_VERYFAR
            local message = messages[distance][level] or messages[distance]
            if distance ~= DISTANCE_BESIDE then
                message = message .. " " .. directions[direction]
            end

            player:sendTextMessage(MESSAGE_INFO_DESCR,
                                   target:getName() .. " " .. message .. ".")
            creaturePosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
        end
    elseif buttonId == 103 then
        if t then
            local selectedBoss = t[choiceId]["Name"]
            local title = "Loot List"
            local str = ""

            local monstertype = MonsterType(selectedBoss)
            if monstertype then
                local loot = monstertype:getLoot()
                for i = 1, #loot do
                    local item = "#" .. i .. " " ..
                                     firstToUpper(getItemName(loot[i]["itemId"]))
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
    elseif buttonId == 104 then
        if t then
            local selectedBoss = t[choiceId]["Name"]
            local title = selectedBoss
            local str = ""
            local monstertype = MonsterType(selectedBoss)
            if monstertype then
                local level = monstertype:getBossLevel()
                local description = monstertype:getDescription()
                if description ~= "empty" then
                    str = str .. description .. "." .. "\n" .. "\n"
                else
                    str = str ..
                              "There is no additional description for this boss." ..
                              "\n" .. "\n"
                end
                str = str .. "Boss Level: " .. level
            end
            local message = str
            local window = ModalWindow(1000, title, message)
            window:addButton(101, "Cancel")
            window:setDefaultEscapeButton(101)
            window:sendToPlayer(player)
        end

    end
end

creatureevent:register()

local talk = TalkAction("/bosses")
function talk.onSay(player, words, param)
    player:registerEvent(bossSystem.onModalBoss)

    local t = BOSS_LIST
    if not bossSystem:getBossesCount(t) or bossSystem:getBossesCount(t) == 0 then
        player:sendCancelMessage("there is no bosses spawned.")
        return true
    end

    local title = "Boss List"
    local message = "There is a list with spawned bosses."
    local window = ModalWindow(1788, title, message)
    window:addButton(100, "Find Boss")
    window:addButton(103, "Loot")
    window:addButton(104, "Description")
    window:addButton(101, "Cancel")

    local bossTable = bossSystem:getBosses(t)
    for i, v in pairs(bossTable) do
        local name = v["Name"]
        local monstertype = MonsterType(name)
        local level = monstertype:getBossLevel()

        -- local name = "                                            " .. v["Name"]
        -- window:addChoice(i, "[" .. level .. "]" .. " " .. name)
        -- window:addChoice(i, "Req Level " .. "[" .. level .. "]" .. " - " .. name)
        window:addChoice(i, "Req Level: " .. level .. "" .. " - " .. name)
    end

    window:setDefaultEnterButton(100)
    window:setDefaultEscapeButton(101)
    window:sendToPlayer(player)
    return true
end

talk:separator(" ")
talk:register()

creatureevent = CreatureEvent("bossDeath")
function creatureevent.onDeath(creature, corpse, killer, mostDamageKiller,
                               lastHitUnjustified, mostDamageUnjustified)

    local MonsterType = MonsterType(creature:getName())
    if not MonsterType then return false end
    if MonsterType:isBoss() then
        local loot = BossLoot:new(creature)
        --[[ if loot then
            creature:setDropLoot(false)
            loot:updateDamage()
            loot:setRewards()
            loot:addRewards()
            corpse:setAttribute('aid', 21584)
        end --]]
    end

    return true
end
creatureevent:register()
