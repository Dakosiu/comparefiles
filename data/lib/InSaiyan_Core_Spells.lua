-- CONDITIONS | CONDITION ENUMS
HASTE = CONDITION_HASTE
SLOW = CONDITION_PARALYZE
REGEN = CONDITION_REGENERATION
ATTRIBUTES = CONDITION_ATTRIBUTES
INVISIBLE = CONDITION_INVISIBLE
DOT_FIRE = CONDITION_FIRE
DOT_ICE = CONDITION_ICE
DOT_ENERGY = CONDITION_ENERGY
DOT_EARTH = CONDITION_POISON
DOT_DEATH = CONDITION_CURSED
DOT_PHYSICAL = CONDITION_BLEEDING

-- PARAMS | PARAM ENUMS
SPEED = CONDITION_PARAM_SPEED
TICKS = CONDITION_PARAM_TICKS
HEALTHGAIN = CONDITION_PARAM_HEALTHGAIN
HEALTHTICKS = CONDITION_PARAM_HEALTHTICKS
MANAGAIN = CONDITION_PARAM_MANAGAIN
MANATICKS = CONDITION_PARAM_MANATICKS
MAXMANAPOINTS = CONDITION_PARAM_STAT_MAXMANAPOINTS
MAXHEALTHPOINTS = CONDITION_PARAM_STAT_MAXHITPOINTS
MAXHPPERCENT = CONDITION_PARAM_STAT_MAXHITPOINTSPERCENT
MAXMPPERCENT = CONDITION_PARAM_STAT_MAXMANAPOINTSPERCENT
MAGIC_LEVEL = CONDITION_PARAM_STAT_MAGICPOINTS
P_SKILL_FIST = CONDITION_PARAM_SKILL_FIST
P_SKILL_CLUB = CONDITION_PARAM_SKILL_CLUB
P_SKILL_SWORD = CONDITION_PARAM_SKILL_SWORD
P_SKILL_AXE = CONDITION_PARAM_SKILL_AXE
P_SKILL_FISHING = CONDITION_PARAM_SKILL_FISHING
P_SKILL_SHIELD = CONDITION_PARAM_SKILL_SHIELD
P_SKILL_DISTANCE = CONDITION_PARAM_SKILL_DISTANCE
DOT = CONDITION_PARAM_PERIODICDAMAGE
INTERVAL = CONDITION_PARAM_TICKINTERVAL
SUBID = CONDITION_PARAM_SUBID

-- COMBAT TYPE | damType
PHYSICAL = COMBAT_PHYSICALDAMAGE
ICE = COMBAT_ICEDAMAGE
FIRE = COMBAT_FIREDAMAGE
ENERGY = COMBAT_ENERGYDAMAGE
EARTH = COMBAT_EARTHDAMAGE
DEATH = COMBAT_DEATHDAMAGE
LD = COMBAT_LIFEDRAIN
HOLY = COMBAT_HOLYDAMAGE
SPELL = COMBAT_ENERGYDAMAGE

-- COLORS | COLOR ENUMS
GREEN = MESSAGE_INFO_DESCR
ORANGE = TALKTYPE_MONSTER_SAY -- not working
BLUE = MESSAGE_STATUS_CONSOLE_BLUE
YELLOW = TALKTYPE_SAY
WHITE = MESSAGE_STATUS_SMALL
RED2 = MESSAGE_STATUS_CONSOLE_RED
RED = MESSAGE_STATUS_WARNING

-- SLOTS | SLOT ENUMS
SLOT_HEAD = CONST_SLOT_HEAD
SLOT_NECKLACE = CONST_SLOT_NECKLACE
SLOT_BACKPACK = CONST_SLOT_BACKPACK
SLOT_ARMOR = CONST_SLOT_ARMOR
SLOT_RIGHT = CONST_SLOT_RIGHT
SLOT_LEFT = CONST_SLOT_LEFT
SLOT_LEGS = CONST_SLOT_LEGS
SLOT_FEET = CONST_SLOT_FEET
SLOT_RING = CONST_SLOT_RING
SLOT_AMMO = CONST_SLOT_AMMO

-- damage origins
O_player_weapons = 11
O_player_spells = 12
O_player_proc = 13
O_monster_spells = 14
O_monster_procs = 15
O_environment = 16

compass1 = {"E", "S", "W", "N"}
compass2 = {"NW", "NE", "SW", "SE"}
compass3 = {"N", "NE", "E", "SE", "S", "SW", "W", "NW"}

function getDamTypeStr(object)
    if type(object) == "string" then
        return object:upper()
    end
    if type(object) == "number" then
        return getEleTypeByEnum(object)
    end
end

function getEleTypeByEnum(enum)
    if enum == 1 then
        return "PHYSICAL"
    end
    if enum == 2 then
        return "ENERGY"
    end
    if enum == 4 then
        return "EARTH"
    end
    if enum == 8 then
        return "FIRE"
    end
    if enum == 16 then
        return "LD"
    end
    if enum == 32 then
        return "LD"
    end
    if enum == 512 then
        return "ICE"
    end
    if enum == 1024 then
        return "HOLY"
    end
    if enum == 2048 then
        return "DEATH"
    end
    print("missing [" .. enum .. "] IN getEleTypeByEnum()")
    return 1
end

function textToLineT(text)
    local t = {}
    local function helper(line)
        return "", table.insert(t, line)
    end
    helper((text:gsub("(.-)\r?\n", helper)))
    return t
end

function stringIfMore(string, INT, needINT)
    local needINT = needINT or 1
    local INT = tonumber(INT) or 1
    return INT > needINT and string or ""
end

function getTimeText(seconds, noSeconds) -- custom version
    local seconds = math.floor(seconds)
    if seconds < 1 then
        return (0) .. " sec"
    end
    local str = ""

    if seconds > 86400 then
        local days = math.floor(seconds / 86400)
        str = days .. " day" .. stringIfMore("s", days)
        seconds = seconds % 86400
    end
    local hour = math.floor(seconds / 3600)
    seconds = seconds % 3600
    local min = math.floor(seconds / 60)
    local sec = seconds % 60

    if hour >= 1 then
        str = str .. " " .. hour .. " hour" .. stringIfMore("s", hour)
    end
    if min >= 1 then
        str = str .. " " .. min .. " minute" .. stringIfMore("s", hour)
    end
    str = not noSeconds and str .. " " .. sec .. " sec" or str
    return str
end

function printTable(table, spaces)
    local newSpaces = spaces .. "  "

    for k, v in pairs(table) do
        if type(v) == "table" then
            if type(k) == "table" then
                local Tstr = "{"
                for k2, v2 in pairs(k) do
                    Tstr = Tstr .. "[" .. k2 .. "] = " .. v2 .. ", "
                end
                print(Tstr .. "} = {")
                printTable(v, "  " .. spaces)
            else
                print(newSpaces .. k .. " = {")
                printTable(v, "  " .. spaces)
            end
        else
            if type(k) == "table" then
                local Tstr = newSpaces .. "{"
                for k2, v2 in pairs(k) do
                    Tstr = Tstr .. "[" .. k2 .. "] = " .. v2 .. ", "
                end
                print(Tstr .. "} = " .. tostring(v))
            else
                print(newSpaces .. k .. " = " .. tostring(v))
            end
        end
    end
    print(spaces .. "}")
end

function Uprint(table, printName)
    if type(table) == "userdata" then
        table = getmetatable(table)
    end
    if not printName then
        printName = "table"
    end
    print()
    print(" ---==| " .. printName .. " |==---")
    print("{")
    if table then
        printTable(table, "")
    end
    print("---==|___________|==---")
    print()
end

function Vprint(variable, variableName)
    local n = variableName or "variable"
    print(n .. ": " .. tostring(variable))
end

function getHighestDamageDealerFromDamageT(damageT, object)
    local highestDam = 0
    local mostDamPlayer
    local object = object or "player"

    local function update(creatureID, damage)
        if damage <= highestDam then
            return
        end
        local creature = Creature(creatureID)
        if not creature then
            return
        end
        if not targetIsCorrect(creature, object) then
            return
        end
        highestDam = damage
        mostDamPlayer = creature
    end

    for creatureID, t in pairs(damageT) do
        update(creatureID, t.total)
    end
    return mostDamPlayer
end

function targetIsCorrect(creature, object)
    if object == "creature" then
        return true
    end
    if object == "player" then
        return creature:isPlayer()
    end
    if object == "monster" then
        return creature:isMonster()
    end
    if object == "npc" then
        return creature:isNpc()
    end
end

function Player.getPartyMembers(player, distance)
    return getPartyMembers(player, distance)
end

function getPartyMembers(player, distance)
    local party = player:getParty()
    if not party then
        return {
            [player:getGuid()] = player:getId()
        }
    end
    local playerPos = player:getPosition()
    local entireParty = party:getMembers()
    local partyMembers = {}

    table.insert(entireParty, party:getLeader())
    for _, member in pairs(entireParty) do
        if distance then
            if getDistanceBetween(playerPos, member:getPosition()) < distance then
                partyMembers[member:getGuid()] = member:getId()
            end
        else
            partyMembers[member:getGuid()] = member:getId()
        end
    end
    return partyMembers
end

function addLetterIf1(string, number)
    if number == 1 then
        return ""
    end
    return string
end

function tableCount(t)
    local count = 0

    if not t or type(t) ~= "table" then
        return count
    end
    for _, v in pairs(t) do
        count = count + 1
    end
    return count
end

function broadCast(message, messageType)
    if not messageType then
        messageType = RED
    end
    print("BROADCAST: " .. message .. "  -- [color:" .. messageType .. "]")

    for _, player in pairs(Game.getPlayers()) do
        player:sendTextMessage(messageType, message)
    end
end

function createSquare(startPos, endPos)
    if not startPos.x then
        return print("You might be missing x,y,z values from the startPosT IN createSquare()")
    end
    local function getStartAndEnd(pos1, pos2)
        if pos1 > pos2 then
            return pos2, pos1
        else
            return pos1, pos2
        end
    end
    local positions = {}
    local xStart, xEnd = getStartAndEnd(startPos.x, endPos.x)
    local yStart, yEnd = getStartAndEnd(startPos.y, endPos.y)
    local zPos = startPos.z
    local index = 0

    for i = xStart, xEnd do
        for j = yStart, yEnd do
            index = index + 1
            positions[index] = {
                x = i,
                y = j,
                z = zPos
            }
        end
    end
    return positions
end

msgSpamFilter = {}
function doSendTextMessage(playerID, messageType, message, spamTime)
    local player = Player(playerID)

    if not player then
        return
    end
    if spamTime then
        if not msgSpamFilter[message] then
            msgSpamFilter[message] = {}
        end
        if msgSpamFilter[message][playerID] then
            return
        end
        msgSpamFilter[message][playerID] = true
        addEvent(setTableVariable, spamTime, msgSpamFilter[message], playerID, false)
    end

    player:sendTextMessage(messageType, message)
end

function getPlayerFromDamageMap(creature)
    local highestDam = 0
    local mostDamPlayer

    for cid, t in pairs(creature:getDamageMap()) do
        local player = Player(cid)
        if player and t.total > highestDam then
            highestDam = t.total
            mostDamPlayer = player
        end
    end
    return mostDamPlayer
end

function findItem(itemID, pos, itemAID)
    local tile = Tile(pos)
    if not tile then
        return
    end
    if itemID then
        local item = tile:getItemById(itemID)
        if not item then
            return
        end
        if not itemAID then
            return item
        end
        if item:getActionId() == itemAID then
            return item
        end
        return
    end
    if not itemAID then
        return
    end
    local itemTable = tile:getItems() or {}

    for _, item in pairs(itemTable) do
        local foundItemAID = item:getActionId()
        if itemAID == foundItemAID then
            return item
        end
    end
end

function getAreaAround(pos, distance)
    distance = distance or 1
    local tempPosX = pos.x
    local tempPosY = pos.y
    local tempPosZ = pos.z
    local positions = {}

    if distance == 1 then
        table.insert(positions, {
            x = tempPosX - distance,
            y = tempPosY - distance,
            z = tempPosZ
        })
        table.insert(positions, {
            x = tempPosX - (distance - 1),
            y = tempPosY - distance,
            z = tempPosZ
        })
        table.insert(positions, {
            x = tempPosX + distance,
            y = tempPosY - distance,
            z = tempPosZ
        })
        table.insert(positions, {
            x = tempPosX + distance,
            y = tempPosY - (distance - 1),
            z = tempPosZ
        })
        table.insert(positions, {
            x = tempPosX + distance,
            y = tempPosY + distance,
            z = tempPosZ
        })
        table.insert(positions, {
            x = tempPosX + (distance - 1),
            y = tempPosY + distance,
            z = tempPosZ
        })
        table.insert(positions, {
            x = tempPosX - distance,
            y = tempPosY + distance,
            z = tempPosZ
        })
        table.insert(positions, {
            x = tempPosX - distance,
            y = tempPosY + (distance - 1),
            z = tempPosZ
        })
    else
        for x = tempPosX - distance, tempPosX + distance do
            for y = tempPosY - distance, tempPosY + distance do
                table.insert(positions, {
                    x = x,
                    y = y,
                    z = tempPosZ
                })
            end
        end
        local radius = distance * 2 + 1
        local middleKey = math.floor((radius * radius) / 2) + 1
        table.remove(positions, middleKey)
    end
    return positions
end



function newRandom(D20,D40,A1,A2)
local X1, X2 = 0, 10000
    local U = X2*A2
    local V = (X1*A2 + X2*A1) % D20
	D40 = os.mtime()
    V = (V*D20 + U) % D40
    X1 = math.floor(V/D20)
    X2 = V - X1*D20
	local getValue = tostring(V/D40)
	local newValue = string.sub(getValue,string.len(getValue)-3, string.len(getValue))
    return tonumber(newValue)
end



function samePositions(startPos, endPos)
    if not startPos or not endPos then
        return
    end
    if not startPos.x or not endPos.x or not startPos.y or not endPos.y then
        return
    end
    if startPos.x == endPos.x and startPos.y == endPos.y and startPos.z == endPos.z then
        return true
    end
end

function createItem(ID, pos, count, AID, fluidType)
    local item
    count = count or 1

    if not fluidType then
        item = Game.createItem(ID, count, pos)

        if not item then
            return
        end
        item:setActionId(AID)

        if count > 1 and not item:isStackable() then
            for x = 1, count - 1 do
                Game.createItem(ID, 1, pos):setActionId(AID)
            end
        end
    else
        for x = 1, count do
            item = Game.createItem(ID, fluidType, pos)
            if not item then
                return
            end
            item:setActionId(AID)
        end
    end
    return item
end

function Container.getItems(container)
    local items = {}

    for i = 0, container:getSize() - 1 do
        local item = container:getItem(i)
        if not item then
            break
        end
        table.insert(items, item)
    end
    return items
end

function MWTitle(str)
    local strLength = str:len()
    local maxLength = 86
    if strLength > maxLength then
        return str
    end
    local spaceMaxDistance = 110
    local spaces = createSpaces(str, spaceMaxDistance)
    local spaceLength = spaces:len()

    if strLength < 10 then
        spaceLength = spaceLength + 60
    elseif strLength < 20 then
        spaceLength = spaceLength + 50
    elseif strLength < 40 then
        spaceLength = spaceLength + 30
    end
    local halfSpacesAmount = math.floor(spaceLength / 2)
    if halfSpacesAmount < 1 then
        return str
    end
    local halfSpacesStr = ""

    for x = 1, halfSpacesAmount do
        halfSpacesStr = halfSpacesStr .. " "
    end
    return halfSpacesStr .. str .. halfSpacesStr
end

function createSpaces(str, stringDistance)
    local nameLength = str:len()
    local neededSpaces = stringDistance - nameLength
    local s = " "

    for w in str:gmatch(" ") do
        s = s .. "  "
    end
    for w in str:gmatch("j") do
        s = s .. "  "
    end
    for w in str:gmatch("t") do
        s = s .. " "
    end
    for w in str:gmatch("i") do
        s = s .. "  "
    end
    for w in str:gmatch("l") do
        s = s .. "  "
    end
    if neededSpaces < 2 then
        return s
    end
    for x = 1, neededSpaces do
        s = s .. " "
    end
    return s
end

function Player.getBag(player)
    return player:getSlotItem(SLOT_BACKPACK)
end

function Creature.isVocation(player, neededVocation)
    if not neededVocation then
        return true
    end
    if type(neededVocation) == "string" and neededVocation == "Voc_All" then
        return true
    end
	if player:isMonster() then
		if type(neededVocation) == "string" and neededVocation == "monster" then
			return true
		end
		return false
	end
	
    if type(neededVocation) ~= "table" then
        neededVocation = {neededVocation}
    end
	local fullVocations = {}
	for i,child in pairs(neededVocation) do
		for _i,_child in pairs(VocationTable[child] or {child}) do
			table.insert(fullVocations, _child:lower())
		end
	end
    local playerVocation = player:getVocation():getName():lower()
    return isInArray(fullVocations, playerVocation)
end

function Player.getAttack(player)
    local item = player:getSlotItem(SLOT_LEFT)

    return item and ItemType(item:getId()):getAttack() or 0
end

function Player.getArmor(player, slot)
    if slot then
        local item = player:getSlotItem(slot)
        return item and ItemType(item:getId()):getArmor() or 0
    end
    local armor = 0

    for _, slot in ipairs({SLOT_HEAD, SLOT_FEET, SLOT_ARMOR, SLOT_LEGS}) do
        local item = player:getSlotItem(slot)
        if item then
            armor = armor + ItemType(item:getId()):getArmor()
        end
    end
    return armor
end

function Player.getDefence(player, weaponDef, shieldDef)
    local defence = 0

    if weaponDef or weaponDef == nil then
        local item = player:getSlotItem(SLOT_LEFT)
        if item then
            defence = defence + ItemType(item:getId()):getDefense()
        end
    end

    if shieldDef or shieldDef == nil then
        local item = player:getSlotItem(SLOT_RIGHT)
        if item then
            defence = defence + ItemType(item:getId()):getDefense()
        end
    end
    return defence
end

function Player.getShieldingLevel(player)
    return player:getEffectiveSkillLevel(SKILL_MELEE_DEFENSE)
end
function Player.getDistanceLevel(player)
    return player:getEffectiveSkillLevel(SKILL_MOVEMENT_SPEED)
end
function Player.getSwordLevel(player)
    return player:getEffectiveSkillLevel(SKILL_SWORD)
end
function Player.getAxeLevel(player)
    return player:getEffectiveSkillLevel(SKILL_ATTACK_SPEED)
end
function Player.getClubLevel(player)
    return player:getEffectiveSkillLevel(SKILL_KI_DEFENSE)
end
function Player.getHandcombatLevel(player)
    return player:getEffectiveSkillLevel(SKILL_MELEE)
end

function Player.getWeaponSkill(player)
    local item = player:getSlotItem(SLOT_LEFT)
	if not item then return player:getHandcombatLevel() end
	
	local weaponType = ItemType(item:getId()):getWeaponType()

	if weaponType == WEAPON_SWORD then
      return player:getSwordLevel()
    elseif weaponType == WEAPON_CLUB then
      return player:getClubLevel()
    elseif weaponType == WEAPON_AXE then
      return player:getAxeLevel()
    elseif weaponType == WEAPON_DISTANCE then
      return player:getDistanceLevel()
    elseif weaponType == WEAPON_WAND then
      return player:getDistanceLevel()
    end
	return 1
end


function converFormulaToNumbers(player, formula, variables)
	local getMonster = false
	if player:isMonster() then
		getMonster = true
	end
	if not getWorldTime then
		getMonster = true
	end
	if spellBalanceDmgNames then
		for i,child in pairs(spellBalanceDmgNames) do
			formula = formula:gsub(i, child)
		end
	end
	variables = variables or {}
	for i = 1,5 do
		for i,child in pairs(variables) do
			if child.value then
				formula = formula:gsub(child.name, child.value)
			end
		end
	end
    if getMonster then
        formula = formula:gsub("|CRITICAL_CHANCE|",  0)
        formula = formula:gsub("|percentHp|",  (player:getHealth()/player:getMaxHealth())*100)
        formula = formula:gsub("|hp|",  player:getHealth())
        formula = formula:gsub("|maxHp|",  player:getMaxHealth())
        formula = formula:gsub("|level|",  1)
		
        formula = formula:gsub("|mL|", 1)
        formula = formula:gsub("|mLevel|", 1)
		
        formula = formula:gsub("|sL|", 1)
        formula = formula:gsub("|dL|", 1)
        formula = formula:gsub("|aL|", 1)
        formula = formula:gsub("|swL|", 1)
        formula = formula:gsub("|wS|", 1)
        formula = formula:gsub("|weaponSkill|", 1)
        formula = formula:gsub("|ki_defL|", 1)
        formula = formula:gsub("|fL|", 1)

        formula = formula:gsub("|attack|", 1)
        formula = formula:gsub("|atk|", 1)
        formula = formula:gsub("|def_w|", 1)
        formula = formula:gsub("|def_s|", 1)
        formula = formula:gsub("|def|", 1)
        formula = formula:gsub("|armor_head|", 1)
        formula = formula:gsub("|armor_feet|", 1)
        formula = formula:gsub("|armor_body|", 1)
        formula = formula:gsub("|armor_legs|", 1)
		formula = formula:gsub("|distanceL|", 1)
        formula = formula:gsub("|armor|", getWorldTime and MonsterType(player:getName()):armor() or 0)
        formula = formula:gsub("|100prc|", player:getMaxHealth())
    formula = formula:gsub("|kiL|", 1)

    else
        formula = formula:gsub("|CRITICAL_CHANCE|",  player:getSpecialSkill(SPECIALSKILL_CRITICALHITCHANCE))
        formula = formula:gsub("|percentHp|",  (player:getHealth()/player:getMaxHealth())*100)
        formula = formula:gsub("|hp|",  player:getHealth())
        formula = formula:gsub("|maxHp|",  player:getMaxHealth())
        formula = formula:gsub("|level|",  player:getLevel())
	
    formula = formula:gsub("|mL|", player:getMagicLevel())
    formula = formula:gsub("|kiL|", player:getMagicLevel())
    formula = formula:gsub("|sL|", player:getShieldingLevel())
    formula = formula:gsub("|dL|", player:getDistanceLevel())
    formula = formula:gsub("|distanceL|", player:getDistanceLevel())
    formula = formula:gsub("|aL|", player:getAxeLevel())
    formula = formula:gsub("|swL|",player:getSwordLevel())
    formula = formula:gsub("|ki_defL|", player:getClubLevel())
    formula = formula:gsub("|fL|", player:getHandcombatLevel())
        formula = formula:gsub("|mLevel|", player:getMagicLevel())

        formula = formula:gsub("|attack|", player:getAttack())
    formula = formula:gsub("|atk|", player:getAttack())
    formula = formula:gsub("|wS|", player:getWeaponSkill())
    formula = formula:gsub("|weaponSkill|", player:getWeaponSkill())
    formula = formula:gsub("|def_w|", player:getDefence(true, false))
    formula = formula:gsub("|def_s|", player:getDefence(false, true))
    formula = formula:gsub("|def|", player:getDefence())
    formula = formula:gsub("|armor_head|", player:getArmor(SLOT_HEAD))
    formula = formula:gsub("|armor_feet|", player:getArmor(SLOT_FEET))
    formula = formula:gsub("|armor_body|", player:getArmor(SLOT_ARMOR))
    formula = formula:gsub("|armor_legs|", player:getArmor(SLOT_LEGS))
    formula = formula:gsub("|armor|", player:getArmor())
        formula = formula:gsub("|100prc|", player:getMaxHealth())
		
		
    end
    return formula
end


function calculate(player, formula)
    if not formula then
        return 0
    end
    if player then
        formula = converFormulaToNumbers(player, formula)
    end
    return math.floor(load("return " .. formula)())
end

allEvents = {}
function registerAddEvent(creatureID, key, duration, eventData) -- currently eventData holds 5 values.
    if not allEvents[creatureID] then
        allEvents[creatureID] = {}
    end
    local ET = allEvents[creatureID]

    ET[key] = {}
    ET[key].eventID = addEvent(eventData[1], duration, eventData[2], eventData[3], eventData[4], eventData[5])
    ET[key].regTime = os.mtime()
    ET[key].duration = duration -- milliseconds
    ET[key].eventData = eventData
end

function stopAddEvent(ID, key, entireTree) -- entireTree = all the addevents under the same ID
    local ET = allEvents[ID]
    if not ET then
        return
    end

    if entireTree then
        for _, eventT in pairs(ET) do
            stopEvent(eventT.eventID)
        end
        allEvents[ID] = nil
        return
    end

    local eventT = ET[key]
    if not eventT then
        return
    end
    local eventID = eventT.eventID
    local previousDuration = math.floor(eventT.duration / 1000)
    local timePassed = os.mtime() - eventT.regTime

    if timePassed < previousDuration then
        stopEvent(eventID)
    end
    ET[key] = nil
end

function getAddEvent(ID, key)
    local ET = allEvents[ID]

    return ET and ET[key]
end

function percentage(value, percent, ceil)
    if not value then
        return 0
    end
    if not percent or percent <= 0 then
        return 0
    end
    local result = value * percent / 100
    return ceil and math.ceil(result) or math.floor(result)
end

function doSendMagicEffect(pos, effectT, interval)
    if not effectT then
        return
    end

    if interval then
        if type(effectT) == "number" then
            return addEvent(doSendMagicEffect, interval, pos, effectT)
        end
        for i, effect in ipairs(effectT) do
            addEvent(doSendMagicEffect, (i - 1) * interval, pos, effect)
        end
    else
        local position = Position(pos)
        if type(effectT) == "number" then
            return position:sendMagicEffect(effectT)
        end
        for _, effect in ipairs(effectT) do
            position:sendMagicEffect(effect)
        end
    end
    return true
end

function doSendDistanceEffect(startPos, endPos, effect)
	local tile = Tile(endPos)
	if not tile or tile:isPzLocked() then return end
	return Position(startPos):sendDistanceEffect(endPos, effect)
end
local damageMap = {}
local function noMoreDMG(cid, creature, origin)
    if cid > 0 and origin >= 100 then
        local cid2 = creature:getId()
        if damageMap[cid2] then return true end
        damageMap[cid2] = true
        addEvent(setTableVariable, 900, damageMap, cid2, nil)
    end
end

function setTableVariable(table, key, newValue) table[key] = newValue end

function dealDamagePos(cid, pos, damType, damage, effectOnHit, origin, spellEffect, effectOnMiss)
local tile = Tile(pos)
    if not tile then return end
	if tile:isPzLocked() then return end
	if hasObstacle(pos, "solid") then return end
local attacker = Creature(cid)
local cid = attacker and attacker:getId() or 0
local creature = tile:getBottomCreature()
    
    if spellEffect then doSendMagicEffect(pos, spellEffect) end
    if not creature then return false, doSendMagicEffect(pos, effectOnMiss) end
local targetID =  creature:getId()

    if targetID == cid then return end
    origin = origin or O_environment
    if origin == O_monster_spells and creature:isMonster() then return end

    if not noMoreDMG(cid, creature, origin) then
        if attacker and attacker:isMonster() and creature:isMonster() then cid = 0 end
        if not effectOnHit then effectOnHit = 1 end
        return doTargetCombatHealth(cid, targetID, damType, -damage, -damage, effectOnHit, origin)
    end
end

function doSendDistanceEffectCustom(cid, startPos, endPos, adaptDirection,forceDirection)
    local effect = (endPos.effect and endPos.effect[3]) or 0
    local effectOnHit = (endPos.effect and endPos.effect[4]) or 0
    local ignoreList = endPos.ignoreList or {}
	local attacker = Creature(cid)
		
	if not attacker then return true end
	
	local sendPos = {
        x = endPos.x,
        y = endPos.y,
        z = endPos.z
    }
	if endPos.targetId and Creature(endPos.targetId) then
		sendPos.x = Creature(endPos.targetId):getPosition().x
		sendPos.y = Creature(endPos.targetId):getPosition().y
		sendPos.z = Creature(endPos.targetId):getPosition().z
	end   
	
		if adaptDirection then
        startPos = attacker:getPosition()
        local actualPos = attacker:getPosition()
        local xDiff = startPos.x - sendPos.x
        local yDiff = startPos.y - sendPos.y
        local zDiff = startPos.z - sendPos.z
		local forceDirection = forceDirection or attacker:getDirection()
        sendPos.x = actualPos.x + xDiff
        sendPos.y = actualPos.y + yDiff
		
		if adaptDirection == 4 or adaptDirection == 5 then
			adaptDirection = 1
		end
		if adaptDirection == 6 or adaptDirection == 7 then
			adaptDirection = 3
		end
		if forceDirection == 4 or forceDirection == 5 then
			forceDirection = 1
		end
		if forceDirection == 6 or forceDirection == 7 then
			forceDirection = 3
		end
        if (adaptDirection == forceDirection) then
            sendPos.x = actualPos.x + (-1 * xDiff)
            sendPos.y = actualPos.y + (-1 * yDiff)
        elseif ((adaptDirection == 0 and forceDirection == 2) or
            (adaptDirection == 2 and forceDirection == 0) or
            (adaptDirection == 1 and forceDirection == 3) or
            (adaptDirection == 3 and forceDirection == 1)) then
            sendPos.x = actualPos.x + xDiff
            sendPos.y = actualPos.y + yDiff
        elseif ((adaptDirection == 0 and forceDirection == 1) or
            (adaptDirection == 1 and forceDirection == 2) or
            (adaptDirection == 2 and forceDirection == 3) or
            (adaptDirection == 3 and forceDirection == 0)) then
            sendPos.x = actualPos.x + yDiff
            sendPos.y = actualPos.y + (-1 * xDiff)
        elseif ((adaptDirection == 0 and forceDirection == 3) or
            (adaptDirection == 1 and forceDirection == 0) or
            (adaptDirection == 2 and forceDirection == 1) or
            (adaptDirection == 3 and forceDirection == 2)) then
            sendPos.x = actualPos.x + (-1 * yDiff)
            sendPos.y = actualPos.y + xDiff
        end
        sendPos.z = actualPos.z + zDiff
        local tile = Tile(sendPos)
        if not tile or tile:isPzLocked() then
            return
        end
        if effectOnHit and effectOnHit > 0 and tile:getCreatures() and #tile:getCreatures() > 0 then
            Position(actualPos):sendDistanceEffect(sendPos, effectOnHit)
        elseif effect and effect > 0 then
            Position(actualPos):sendDistanceEffect(sendPos, effect)
        end
        return true
    end
 
 local tile = Tile(sendPos)
    if not tile or tile:isPzLocked() then
        return
    end
    if effectOnHit and effectOnHit > 0 and tile:getBottomCreature() then
	for i,child in pairs(ignoreList) do
	if child == "caster" then
	if tile:getBottomCreature():getId() == cid then
       return false
	end
	end
	end
        Position(startPos):sendDistanceEffect(sendPos, effectOnHit)
    elseif effect and effect > 0 then
        Position(startPos):sendDistanceEffect(sendPos, effect)
    end
    return true
end

function Player.frontPos(player, yards)
    local playerPos = player:getPosition()
    local direction = player:getDirection()
    local tempPosX = playerPos.x
    local tempPosY = playerPos.y
    local tempPosZ = playerPos.z
    local yards = yards or 1
	
	if direction == 4 or direction == 5 then
		direction = 1
	end
	if direction == 6 or direction == 7 then
		direction = 3
	end
		
    if direction == 0 then
        return {
            x = tempPosX,
            y = tempPosY - yards,
            z = tempPosZ
        }
    end
    if direction == 1 then
        return {
            x = tempPosX + yards,
            y = tempPosY,
            z = tempPosZ
        }
    end
    if direction == 2 then
        return {
            x = tempPosX,
            y = tempPosY + yards,
            z = tempPosZ
        }
    end
    if direction == 3 then
        return {
            x = tempPosX - yards,
            y = tempPosY,
            z = tempPosZ
        }
    end
end

function doDamage(creatureID, damType, damage, effectOnHit, origin)
    local target = Creature(creatureID)
    if not target then
        return
    end
    local targetPos = target:getPosition()
    local tile = Tile(targetPos)

    if tile:isPzLocked() then
        return
    end
    if hasObstacle(targetPos, "solid") then
        return
    end
    doTargetCombatHealth(0, creatureID, damType, -damage, -damage, effectOnHit, origin)
end

function dealDamage(attacker, target, damType, damage, effectOnHit, origin, maxRange, flyingEffect)
    if not attacker or type(attacker) == "number" and attacker == 0 then
        return doDamage(target, damType, damage, effectOnHit, origin)
    end
    attacker = Creature(attacker)
    target = Creature(target)
    if not attacker or not target then
        return
    end
    local attackerPos = attacker:getPosition()
    local targetPos = target:getPosition()
    local range = maxRange or 10
    local tile = Tile(targetPos)

    if tile:isPzLocked() then
        return
    end
    if hasObstacle(targetPos, "solid") then
        return
    end
    if getDistanceBetween(attackerPos, targetPos) > range then
        return
    end
    local attackerID = attacker:getId()
    local targetID = target:getId()

    origin = origin or O_monster_spells
    if origin == O_monster_spells and attacker:isPlayer() then
        origin = O_player_spells
    end
    if target:isMonster() and attacker:isMonster() then
        attackerID = 0
    end
    if not effectOnHit then
        effectOnHit = 1
    end
    damage = -damage

    if range > 2 then
        local pathOpen = true -- getPath(attackerPos, targetPos, {"blockThrow"})

        if pathOpen then
            if flyingEffect then
                attackerPos:sendDistanceEffect(targetPos, flyingEffect)
            end
            doTargetCombatHealth(attackerID, targetID, damType, damage, damage, effectOnHit, origin)
        end
    else
        if flyingEffect then
            attackerPos:sendDistanceEffect(targetPos, flyingEffect)
        end
        doTargetCombatHealth(attackerID, targetID, damType, damage, damage, effectOnHit, origin)
    end
    return true
end

local damageMap = {}
local function noMoreDMG(cid, creature, origin)
    if cid > 0 and origin >= 100 then
        local cid2 = creature:getId()
        if damageMap[cid2] then
            return true
        end
        damageMap[cid2] = true
        addEvent(setTableVariable, 900, damageMap, cid2, nil)
    end
end

function setTableVariable(table, key, newValue)
    table[key] = newValue
end

local sendEvent = nil
function dealDamagePosCustom(cid, timePassed, spellT, pos, dmgTable, origin, adaptPos, adaptDirection,forceDirection,forcePosition)
--	local spellConfig = spellT
--	local spellObject = generate cast info
--	local spellManipulation = generate single timeZone and postproccess
	adaptDirection = adaptDirection
    local damType = pos.type or SPELL
    local overrideOrigin = pos.origin or origin
    local conditionAdd = pos.attributes or {}
    local ignoreList = pos.ignoreList or {}
    local damage = dmgTable and dmgTable[pos.dmg] or 0
	
    local attacker = Creature(cid)
    if not attacker then
        return
    end
	
    if pos.cast and pos.cast == "caster" then
		pos.x = attacker:getPosition().x
		pos.y = attacker:getPosition().y
		pos.z = attacker:getPosition().z
		if attacker:isMonster() and attacker:getMaster() then
			pos.x = attacker:getMaster():getPosition().x
			pos.y = attacker:getMaster():getPosition().y
			pos.z = attacker:getMaster():getPosition().z
		end
	end
	
	if damage > 0 then
	table.insert(ignoreList,"caster")
	end
	
    local adaptCreature = Creature(cid)
	if pos.targetId and Creature(pos.targetId) then
		adaptCreature = Creature(pos.targetId)
	end
	local effectOnHit = (pos.effect and pos.effect[2] and (tonumber(pos.effect[2]) or (type(pos.effect[2]) == "table" and adaptCreature and pos.effect[2][adaptCreature:getDirection()+1])) ) or 0
    local spellEffect = (pos.effect and pos.effect[1] and (tonumber(pos.effect[1]) or (type(pos.effect[1]) == "table" and adaptCreature and pos.effect[1][adaptCreature:getDirection()+1])) ) or 0
    
	
	if spellT.aggressive and Tile(attacker:getPosition()):isPzLocked() then
		return
	end
	
    local cid = attacker and attacker:getId() or 0
    local sendPos = {
        x = pos.x,
        y = pos.y,
        z = pos.z
    }
	local getDirection = forceDirection or attacker:getDirection()
    if adaptPos and adaptCreature then
        local actualPos = forcePosition or adaptCreature:getPosition()
        local xDiff = adaptPos.x - pos.x
        local yDiff = adaptPos.y - pos.y
        local zDiff = adaptPos.z - pos.z
		forceDirection = forceDirection or adaptCreature:getDirection()
		if adaptDirection == 4 or adaptDirection == 5 then
			adaptDirection = 1
		end
		if adaptDirection == 6 or adaptDirection == 7 then
			adaptDirection = 3
		end
		if forceDirection == 4 or forceDirection == 5 then
			forceDirection = 1
		end
		if forceDirection == 6 or forceDirection == 7 then
			forceDirection = 3
		end
        if (adaptDirection == getDirection) then
            sendPos.x = actualPos.x + (-1 * xDiff)
            sendPos.y = actualPos.y + (-1 * yDiff)
        elseif ((adaptDirection == 0 and getDirection == 2) or
            (adaptDirection == 2 and getDirection == 0) or
            (adaptDirection == 1 and getDirection == 3) or
            (adaptDirection == 3 and getDirection == 1)) then
            sendPos.x = actualPos.x + xDiff
            sendPos.y = actualPos.y + yDiff
        elseif ((adaptDirection == 0 and getDirection == 1) or
            (adaptDirection == 1 and getDirection == 2) or
            (adaptDirection == 2 and getDirection == 3) or
            (adaptDirection == 3 and getDirection == 0)) then
            sendPos.x = actualPos.x + yDiff
            sendPos.y = actualPos.y + (-1 * xDiff)
        elseif ((adaptDirection == 0 and getDirection == 3) or
            (adaptDirection == 1 and getDirection == 0) or
            (adaptDirection == 2 and getDirection == 1) or
            (adaptDirection == 3 and getDirection == 2)) then
            sendPos.x = actualPos.x + (-1 * yDiff)
            sendPos.y = actualPos.y + xDiff
        end
        sendPos.z = actualPos.z + zDiff
    end

			if pos.castDirections then
			--print(getDirection .." ".. attacker:getDirection())
	local passed = false
	for i,child in pairs(pos.castDirections) do
	if child == getDirection then
	passed = true
	end
	end
	if not passed then	return 	end
  end
  
   local tile = Tile(sendPos)
    if not tile then
        return
    end
	
    if tile:isPzLocked() then
        return
    end
	
    if spellEffect and spellEffect > 0 then
        doSendMagicEffect(sendPos, spellEffect)
    end
    if hasObstacle(sendPos, "solid") then
        return
    end
	
    if pos.spawn then
        if tonumber(pos.spawn[1]) then
            Game.createItem(pos.spawn[1], 1, {
                x = sendPos.x,
                y = sendPos.y,
                z = sendPos.z
            })
            if pos.spawn[2] then
                local getTimer = pos.spawn[3] or 1
                addEvent(spell_onSpawn, (getTimer - timePassed) * 100, cid, spellT, pos.spawn[2], {
                    x = sendPos.x,
                    y = sendPos.y,
                    z = sendPos.z
                })
            end
        else
            Game.createMonster(pos.spawn[1], 1, {
                x = sendPos.x,
                y = sendPos.y,
                z = sendPos.z
            })
        end
    end
    if pos.remove then
        local getTimer = pos.remove[3] or 1
        if timePassed == getTimer then
            addEvent(function()
                local getPoser = {
                    x = sendPos.x,
                    y = sendPos.y,
                    z = sendPos.z
                }
                local tile = Tile(getPoser)
                if tile then
                    if tonumber(pos.remove[1]) then
                        local removeItem = tile:getItemById(pos.remove[1])
                        if removeItem then
                            if pos.remove[2] and pos.remove[2] > 0 then
                                removeItem:remove(pos.remove[2])
                            else
                                removeItem:remove()
                            end
                        end
                    else
                        local creature = tile:getBottomCreature()
						if pos.targetId and Creature(pos.targetId) then
						creature = Creature(pos.targetId)
						end
                        if creature then
                            if pos.remove[1] == "all" or creature:getName() == pos.remove[1] then
                                creature:remove()
                            end
                        end
                    end
                end
            end, (getTimer - timePassed) * 100)
        end
    end


  local creature = tile:getBottomCreature()
						--if pos.targetId and Creature(pos.targetId) then
						--creature = Creature(pos.targetId)
						--end
				
    if conditionAdd then
	
        for i, child in pairs(conditionAdd) do
            local passed = true
			
            if creature then
				if creature:getCustomAttribute(child.attr) then
                local getAttr = json.decode(creature:getCustomAttribute(child.attr))
                if getAttr.immuneTimer and getAttr.immuneTimer > os.mtime() then
                    passed = false
                end
            end
				if child.attr ~= "heal" and attacker:canAttack(creature) ~= RETURNVALUE_NOERROR then passed = false end
				if child.attr == "heal" and creature ~= attacker and attacker:canAttack(creature) == RETURNVALUE_NOERROR then passed = false end
					for i,child in pairs(ignoreList) do
					if child == "caster" then
					if creature:getId() == cid then
					   passed = false
					end
					if getAttr and getAttr.casterId and getAttr.casterId == creature:getId() then
						passed = false
					end
					end
					end		
			end
                local getAttr = deepCopy(child)
            if (creature and passed) or (not creature and getAttr.emptyTargetCast) then
                if getAttr.condition then
                    local getCondition = getAttr.condition
                    if getCondition.name == "timeDuration" then
                        getAttr.timer = os.mtime() + getCondition.duration
                        if getCondition.immune then
                            getAttr.immuneTimer = os.mtime() + getCondition.immune
                        end
                    elseif getCondition.name == "onHit" then
                        getCondition.hitCounter = 0
                        getCondition.repetitiveCounter = 0
                    end
                    if getAttr.attr == "damage" then
						if type(getAttr.value) == "string" then
							getAttr.value = dmgTable[getAttr.value] or getAttr.value
						end
                        getAttr.immuneTimer = 0

						if creature and creature:getCustomAttribute("damage") then
							local getActiveAction = json.decode(creature:getCustomAttribute("damage"))
							getAttr.immuneTimer = getActiveAction.immuneTimer and getActiveAction.immuneTimer > os.mtime() or os.mtime() + getCondition.immune
						end
					end
                        getAttr.casterId = cid
						getAttr.castTime = os.mtime()
					if creature then
                        getAttr.targetId = creature:getId()
					end

                        getAttr.targetPos = sendPos
						getAttr.spellSV = spellT.spellSV
						getAttr.spellName = spellT.spellName
                    local marks = {"playerMark", "monsterMark"}
			if creature then
                        local getObject = creature:changeCustomAttribute(getAttr.attr, json.encode(getAttr))
						if getObject and type(getObject) == "table" and getObject.newDmg then
							damage = dmgTable[getObject.newDmg] or damage
						end
elseif getAttr.emptyTargetCast then
                        local getObject = adaptCreature:changeCustomAttribute(getAttr.attr, json.encode(getAttr))
						if getObject and type(getObject) == "table" and getObject.newDmg then
							damage = dmgTable[getObject.newDmg] or damage
						end
end
                end
            end
        end
    end
	
      if ( not creature ) then
	--doSendMagicEffect(sendPos, effectOnMiss)
       return false
	 else
	   refreshHpConditions(creature)
    end

				if attacker:canAttack(creature) ~= RETURNVALUE_NOERROR then return end
					for i,child in pairs(ignoreList) do
						if child == "caster" and creature:getId() == cid then return end
						if child == "monsters" and creature:getId() == cid then return end
						if child == "players" and creature:getId() == cid then return end
						if child == "enemy" and creature:getId() == cid then return end
						if child == "party" and creature:getId() == cid then return end
						if child == "npc" and creature:getId() == cid then return end
						if child == "summons" and creature:getId() == cid then return end
					end
   overrideOrigin = overrideOrigin or O_environment
    if overrideOrigin == O_monster_spells and creature:isMonster() then
        return
    end
    if effectOnHit and effectOnHit > 0 then
        doSendMagicEffect(sendPos, effectOnHit)
    end
    if not noMoreDMG(cid, creature, overrideOrigin) then
        if not effectOnHit then
            effectOnHit = 0
        end
		
					if spellT.levelsAttributes then
						if attacker:getStorageValue(spellT.spellSV) > 0 then
									local getCollect = (spellT.levelsCombine and 1) or (not spellT.levelsCombine and attacker:getStorageValue(spellT.spellSV))
									for it = getCollect,attacker:getStorageValue(spellT.spellSV) do
						if spellT.levelsAttributes[it] and spellT.levelsAttributes[it].bonusAttributes then
						for i,child in pairs(spellT.levelsAttributes[it].bonusAttributes) do
						if child.attr == "spellDamage" and child.condition and child.condition.name == "spellCast" then
						damage = damage + (child.value or 0)
						damage = ((child.percent and (damage * (child.percent/100))) or damage)
						end
						end
						end
						end
						end
					end
					
        return doTargetCombatHealth(cid, creature:getId(), damType, -damage, -damage, 1)
    end

end
local function checkForObstacles(pos, obstacle)
    local tile = Tile(pos)

    if not tile then
        return obstacle == "noTile"
    end
    if obstacle == "noTile" then
        return false
    end
    if obstacle == "noGround" then
        return not tile:getGround()
    end
    if obstacle == "solid" then
        return tile:hasProperty(CONST_PROP_BLOCKSOLID)
    end
    if obstacle == "blockThrow" then
        return tile:hasProperty(CONST_PROP_BLOCKPROJECTILE)
    end
    if obstacle == "creature" then
        return tile:getBottomCreature()
    end
    Vprint(obstacle, "This obstacle does not exist in hasObstacle()")
end

function hasObstacle(pos, obstacleT)
    if type(obstacleT) ~= "table" then
        obstacleT = {obstacleT}
    end

    for _, obstacle in pairs(obstacleT) do
        if checkForObstacles(pos, obstacle) then
            return true
        end
    end
end

function removeItemFromPos(itemID, position, count, itemAID)
    local tile = Tile(position)
    if not tile then
        return
    end
    local items = findItems(itemID, position, itemAID)

    for _, item in ipairs(items) do
        if not count then
            return item:remove(1)
        end

        if tostring(count) == "all" then
            item:remove()
        else
            local itemCount = item:getCount()
            if itemCount >= count then
                return item:remove(count)
            end
            count = count - itemCount
            item:remove()
        end
    end
end

function findItems(itemID, pos, itemAID)
    local tile = Tile(pos)
    if not tile then
        return {}
    end
    local itemTable = tile:getItems() or {}
    local itemList = {}
    local indexID = 0

    local function addItem(item)
        indexID = indexID + 1
        itemList[indexID] = item
    end

    for _, item in pairs(itemTable) do
        local itemID_passed = not itemID or item:getId() == itemID
        local itemAID_passed = not itemAID or item:getActionId() == itemAID

        if itemID_passed and itemAID_passed then
            addItem(item)
        end
    end
    return itemList
end

-- getAreaPos()
local function biggestMatrixLength(area) -- RETURNS area biggest row or column length
    local length = 0

    for a = 1, #area do
        for x = 1, 20 do
            if x > length and area[a][x] then
                length = x
            end
        end
    end
    return length
end

local function replaceStrWithValue(area, newValue)
    local biggestLength = biggestMatrixLength(area)

    for i = 1, #area do
        for j = 1, biggestLength do
            if area[i] then
                if not area[i][j] then
                    area[i][j] = newValue
                elseif type(area[i][j]) == "string" then
                    area[i][j] = newValue
                end
            end
        end
    end
    return area
end

local function reverseAreaTable(unsortedTable)
    local sortedTable = {}
    local matrixL = isMatrix(unsortedTable)
    local amountOfTables = #unsortedTable

    if matrixL == 0 then
        return unsortedTable
    end

    for i, t in pairs(unsortedTable) do
        local valueCount = #t
        local tableKey = amountOfTables - (i - 1)
        sortedTable[tableKey] = {}

        for j, v in pairs(t) do
            local valueKey = valueCount - (j - 1)
            sortedTable[tableKey][valueKey] = v
        end
    end
    return sortedTable
end

local function reconstructAreaTable(area, direction)
    if direction == "S" or direction == "SE" then
        return reverseAreaTable(area)
    end
    local newArea = {}

    for j = 1, #area[1] do
        newArea[j] = {}
    end

    if direction == "W" or direction == "SW" then
        area = reverseAreaTable(area)

        for i = 1, #area do
            for j = 1, #area[i] do
                newArea[j][#area - (i - 1)] = area[i][j]
            end
        end
    elseif direction == "E" or direction == "NE" then
        for i = 1, #area do
            for j = 1, #area[i] do
                newArea[j][#area - (i - 1)] = area[i][j]
            end
        end
    end
    return newArea
end

local function lookForIndex(area)
    for i = 1, #area do
        for j = 1, #area[i] do
            if type(area[i][j]) ~= "string" and area[i][j] ~= "x" and area[i][j] == 0 then
                return i, j
            end
        end
    end

    Uprint(area, "ERROR in lookForIndex")
end

local function createAreaMatrix(area)
    local biggestNumber = 0
    local matrix = {}

    local function updateValue(v)
        if v > biggestNumber then
            biggestNumber = v
        end
    end

    for _, t in ipairs(area) do
        for _, v in ipairs(t) do
            if type(v) == "table" then
                for _, _v in ipairs(v) do
                    if type(_v) == "table" then
                        for __, __v in ipairs(_v) do
                            if type(__v) == "table" then
                                for ___, ___v in ipairs(__v) do
                                    updateValue(___v)
                                end
                            end
                        end
                    end
                end
            else
                updateValue(v)
            end
        end
    end

    for x = 1, biggestNumber do
        table.insert(matrix, {})
    end
    return matrix
end

function getAreaPosCustom(startPos, spellT, direction, player, area)
    local areaName = area or "Default"
    area = spellT.areas[areaName]
					if spellT.levelsAttributes then
						if player:getStorageValue(spellT.spellSV) > 0 then
									local getCollect = (spellT.levelsCombine and 1) or (not spellT.levelsCombine and player:getStorageValue(spellT.spellSV))
									for it = getCollect,player:getStorageValue(spellT.spellSV) do
						if spellT.levelsAttributes[it] and spellT.levelsAttributes[it].areas and spellT.levelsAttributes[it].areas[areaName] then
							area = spellT.areas[spellT.levelsAttributes[it].areas[areaName]]
						end
						end
						end
					end
    if not area then
        return
    end
    if not startPos.x then
        return
    end
    if not direction then
        direction = "N"
    end
    direction = dirToStr(direction)
    if direction ~= "N" and direction ~= "NW" then
        area = reconstructAreaTable(area, direction)
    end
    local index_I, index_J = lookForIndex(area)

    local recreateArea = {}
    for i, child in ipairs(area) do
        local finalTable = {}
        for _i, _child in ipairs(child) do
            if type(_child) == "string" then
                if _child == "x" then
                    finalTable[_i] = 0
                else
                    finalTable[_i] = spellT.areaVariables[_child]
					if spellT.levelsAttributes then
						if player:getStorageValue(spellT.spellSV) > 0 then
									local getCollect = (spellT.levelsCombine and 1) or (not spellT.levelsCombine and player:getStorageValue(spellT.spellSV))
									for it = getCollect,player:getStorageValue(spellT.spellSV) do
						if spellT.levelsAttributes[it] and spellT.levelsAttributes[it].areaVariables and spellT.levelsAttributes[it].areaVariables[_child] then
                    finalTable[_i] = spellT.levelsAttributes[it].areaVariables[_child]
						end
						end
						end
					end
                end
            else
                if spellT.areaVariables[areaName .. "0"] then
                    finalTable[_i] = spellT.areaVariables[areaName .. "0"]
					if spellT.levelsAttributes then
						if player:getStorageValue(spellT.spellSV) > 0 then
									local getCollect = (spellT.levelsCombine and 1) or (not spellT.levelsCombine and player:getStorageValue(spellT.spellSV))
									for it = getCollect,player:getStorageValue(spellT.spellSV) do
						if spellT.levelsAttributes[it] and spellT.levelsAttributes[it].areaVariables and spellT.levelsAttributes[it].areaVariables[areaName .. "0"] then
                    finalTable[_i] = spellT.levelsAttributes[it].areaVariables[areaName .. "0"]
						end
						end
						end
					end
                else
                    finalTable[_i] = _child
                end
            end
   
		if not finalTable[_i] then finalTable[_i] = 0 end
   end
        recreateArea[i] = finalTable
    end
    local positions = createAreaMatrix(recreateArea)

    area = recreateArea
    for i, child in ipairs(area) do
        local finalTable = {}
        for j, _child in ipairs(child) do
            local xPos = j - index_J
            local yPos = i - index_I
            if type(area[i][j]) == "table" then
                for x = 1, #area[i][j] do
                    if area[i][j][x] and area[i][j][x].timeZones then
                        local getTable = area[i][j][x]
                        local newPos = deepCopy(getTable)
                        if newPos.timeZones then
                            local y = newPos.timeZones
                            if y[1] > 0 then
                                local secondSeconds = y[1]
                                local thirdSeconds = 100
                                if y[2] then
                                    secondSeconds = y[2]
                                end
                                if y[3] then
                                    thirdSeconds = y[3]
                                end
                                newPos.x = startPos.x + xPos
                                newPos.y = startPos.y + yPos
                                newPos.z = startPos.z
                                newPos.attributes = {}
                                if newPos.attr then
                                    for i, child in pairs(newPos.attr) do
									local getAttr = spellT.bonusAttributes[child]
								if spellT.levelsAttributes then
									if player:getStorageValue(spellT.spellSV) > 0 then
									local getCollect = (spellT.levelsCombine and 1) or (not spellT.levelsCombine and player:getStorageValue(spellT.spellSV))
									for it = getCollect,player:getStorageValue(spellT.spellSV) do
									if spellT.levelsAttributes[it] and spellT.levelsAttributes[it].bonusAttributes and spellT.levelsAttributes[it].bonusAttributes[child] then
										getAttr = spellT.levelsAttributes[it].bonusAttributes[child]
									end
									end
									end
								end
                                        table.insert(newPos.attributes, getAttr)
                                    end
                                end
                                for a = y[1], secondSeconds do
								local getNumber = math.random(268435426,268435456)
								if type(player) ~= "nil" then
								getNumber = player:getId()
								end
								local getChance = 100
								--getChance = newRandom(((os.mtime()+math.floor(a/10))/1000)*(((os.mtime()+math.floor(a/10))/100000) * (a-math.floor(a/10))),getNumber,newPos.x,newPos.y)
                                    if getChance <= thirdSeconds *100 then
                                        if not positions[a] then
                                            positions[a] = {}
                                        end
                                        table.insert(positions[a], newPos)
                                    end
                                end
                            end
                        end
                    end
                end
            elseif area[i][j] and area[i][j] > 0 then
                local areaValue = area[i][j]
                table.insert(positions[areaValue], newPos)
            end
        end
    end
    return positions
end

function getAreaPos(startPos, area, direction)
    if not area then
        return
    end
    if not startPos.x then
        return
    end
    if not direction then
        direction = "N"
    end
    direction = dirToStr(direction)
    if direction ~= "N" and direction ~= "NW" then
        area = reconstructAreaTable(area, direction)

    end
    local index_I, index_J = lookForIndex(area)

    local recreateArea = {}
    for i, child in pairs(area) do
        local finalTable = {}
        for _i, _child in pairs(child) do
            if type(_child) == "string" then
                table.insert(finalTable, spellT.areaVariables[_child])
            else
                table.insert(finalTable, _child)
            end
        end
        table.insert(recreateArea, finalTable)
    end
    local positions = createAreaMatrix(recreateArea)

    for i = 1, #area do
        for j = 1, #area[i] do
            local xPos = j - index_J
            local yPos = i - index_I
            local newPos = {
                x = startPos.x + xPos,
                y = startPos.y + yPos,
                z = startPos.z
            }

            if type(area[i][j]) == "table" then
                for x = 1, #area[i][j] do
                    if area[i][j][x] then
                        local areaValue = area[i][j][x]
                        local y = areaValue[1]
                        if y[1] > 0 then
                            local secondSeconds = y[1]
                            if y[2] then
                                secondSeconds = y[2]
                            end
                            newPos.cast = areaValue[2]
                            newPos.effect = areaValue[3]
                            newPos.dmg = areaValue[4]
                            newPos.type = areaValue[5]
                            for a = y[1], secondSeconds do
                                table.insert(positions[a], newPos)
                            end
                        end
                    end
                end
            elseif area[i][j] and area[i][j] > 0 then
                local areaValue = area[i][j]
                table.insert(positions[areaValue], newPos)
            end
        end
    end
    return positions
end

function getDistanceBetween(fromPos, toPos, ignoreFloors)
    if not fromPos.x or not toPos.x then
        return 100
    end
    local xDif = math.abs(fromPos.x - toPos.x)
    local yDif = math.abs(fromPos.y - toPos.y)
    local posDif = math.max(xDif, yDif)

    if ignoreFloors then
        return posDif
    end
    return fromPos.z ~= toPos.z and posDif + 100 or posDif
end

function dirToStr(direction)
    if type(direction) == "string" then
        return direction
    end
	if direction == 4 or direction == 5 then
        return "E"
	end
	if direction == 6 or direction == 7 then
        return "W"
	end
    if direction == 0 then
        return "N"
    end
    if direction == 1 then
        return "E"
    end
    if direction == 2 then
        return "S"
    end
    if direction == 3 then
        return "W"
    end
    return 0, print("dirToStr() has wrong dir input: [" .. direction .. "]")
end

function isMatrix(table)
    if not table then
        return 0
    end
    local layer = 0

    local function checkNewTable()
        for _, t in pairs(table) do
            if type(t) == "table" then
                table = t
                return true
            end
        end
    end

    while checkNewTable() do
        layer = layer + 1
    end
    return layer
end

function eventRemove(cid, name)
    local creature = Creature(cid)
    return creature and creature:unregisterEvent(name)
end

function getDirectionPos(position, direction, distance)
    distance = distance or 1
    if direction == "W" then
        return {
            x = position.x - distance,
            y = position.y,
            z = position.z
        }
    end
    if direction == "E" then
        return {
            x = position.x + distance,
            y = position.y,
            z = position.z
        }
    end
    if direction == "N" then
        return {
            x = position.x,
            y = position.y - distance,
            z = position.z
        }
    end
    if direction == "S" then
        return {
            x = position.x,
            y = position.y + distance,
            z = position.z
        }
    end
    if direction == "NW" then
        return {
            x = position.x - distance,
            y = position.y - distance,
            z = position.z
        }
    end
    if direction == "NE" then
        return {
            x = position.x + distance,
            y = position.y - distance,
            z = position.z
        }
    end
    if direction == "SW" then
        return {
            x = position.x - distance,
            y = position.y + distance,
            z = position.z
        }
    end
    if direction == "SE" then
        return {
            x = position.x + distance,
            y = position.y + distance,
            z = position.z
        }
    end
    print("ERROR - getDirectionPos | direction: " .. tostring(direction))
end

function Player.getItemCount2(player, itemID, itemAID, fluidType, dontCheckPlayer)
    local bag = player:getBag()
    local itemsFound = 0

    if not dontCheckPlayer then
        for x = 0, 13 do
            local item = player:getSlotItem(x)

            if item then
                if compare(item:getId(), itemID) and compare(item:getActionId(), itemAID) and
                    compare(item:getFluidType(), fluidType) then
                    itemsFound = itemsFound + item:getCount()
                end
            end
        end
    end

    if not bag then
        return itemsFound
    end
    for x = 0, bag:getSize() do
        local item = bag:getItem(x)

        if not item then
            break
        end
        if compare(item:getId(), itemID) and compare(item:getActionId(), itemAID) and
            compare(item:getFluidType(), fluidType) then
            itemsFound = itemsFound + item:getCount()
        end
    end
    return itemsFound
end

function Tile.isPzLocked(tile)
    return tile:hasFlag(TILESTATE_PROTECTIONZONE) or tile:hasProperty(TILESTATE_PROTECTIONZONE) or
               tile:hasProperty(TILESTATE_NOPVPZONE)
end

function Player.removeItem2(player, itemID, count, itemAID, fluidType, dontCheckPlayer)
    if not count then
        count = 1
    end
    if count == 0 then
        return true
    end
    local bag = player:getBag()
    if not bag then
        return
    end
    local itemCount = player:getItemCount2(itemID, itemAID, fluidType, dontCheckPlayer)
    if type(count) == "string" and count == "all" then
        count = itemCount
    end
    if itemCount < count then
        return
    end
    local itemsRemoved = 0
    local movedCylinder = 0

    for x = 0, bag:getSize() do
        local item = bag:getItem(x - movedCylinder)

        if itemsRemoved >= count then
            if itemsRemoved > count then
                local leftovers = itemsRemoved - count
                local item = player:addItem(itemID, leftovers)
                if itemAID then
                    item:setActionId(itemAID)
                end
            end
            return true
        end

        if item then
            if compare(item:getId(), itemID) and compare(item:getActionId(), itemAID) and
                compare(item:getFluidType(), fluidType) then
                itemsRemoved = itemsRemoved + item:getCount()
                movedCylinder = movedCylinder + 1
                item:remove()
            end
        end
    end

    if not dontCheckPlayer then
        for x = 0, 13 do
            local item = player:getSlotItem(x)

            if item then
                if compare(item:getId(), itemID) and compare(item:getActionId(), itemAID) and
                    compare(item:getFluidType(), fluidType) then
                    itemsRemoved = itemsRemoved + item:getCount()
                    item:remove()
                end
            end
        end
    end

    if itemsRemoved < count then
        print("removeItem2, got somehow passed even though player didnt have enough items..")
        return false, player:sendTextMessage(BLUE,
            "If you see this message then report this to me(Whitevo) and tell me to look console, because one of the scripts is FUCKED UP")
    end
end

function compare(v1, v2)
    if not v1 or not v2 then
        return true
    end
    if v1 == v2 then
        return true
    end
end

function Creature.isGod(creature)
    if not creature:isPlayer() then
        return
    end
    return creature:getGroup():getAccess()
end

antispamT = {}
function antiSpam(ID, tableKey, msTime)
    local tableKey = tableKey or 0
    if not antispamT[tableKey] then
        antispamT[tableKey] = {}
    end
    local spamT = antispamT[tableKey]

    if not spamT[ID] then
        local msTime = msTime or 500
        spamT[ID] = true
        addEvent(setTableVariable, msTime, spamT, ID, nil)
        return true
    end
end

function sortIpairsT(t, string)
    if string == "high" then
        table.sort(t, function(a, b)
            return b < a
        end)
    elseif string == "low" then
        table.sort(t, function(a, b)
            return b > a
        end)
    end
    return t
end

function sorting(unsortedTable, string)
    local sortedTable = {}
    local loopID = 0

    for k, v in pairs(unsortedTable) do
        loopID = loopID + 1
        sortedTable[loopID] = k
    end
    return sortIpairsT(sortedTable, string)
end

function deepCopy(object)

    local lookup_table = {}

    local function _copy(object)
        local new_table = {}

        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end

        lookup_table[object] = new_table

        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end

        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end

function chanceSuccess(percent)
    if not percent or percent <= 0 then
        return false
    end
    if percent >= 100 then
        return true
    end
    local baseValue = 10000
    local randomNumber = math.random(1, baseValue)
    local requiredValue = percentage(baseValue, percent)

    return randomNumber <= requiredValue
end



function spell_tripleHit(playerID, spellT)
    local player = Creature(playerID)
    if not player then
        return
    end

end

function spell_heal(playerID, spellT)
    local player = Creature(playerID)
    if not player then
        return
    end
    local calculationT = spellcast_calculateFormula(player, spellT)
    local healAmount = calculationT.heal
    local effect = spellT.other and spellT.other.spellEffect or 14

    if healAmount < 1 then
        return player:sendTextMessage(GREEN, "The heal amount is less than 1")
    end
    doSendMagicEffect(player:getPosition(), effect)
    player:addHealth(healAmount)
end

function spell_shiver(playerID, spellT)
    local player = Creature(playerID)
    if not player then
        return
    end
    local calculationT = spellcast_calculateFormula(player, spellT)
    local damage = calculationT.damage
    local otherT = spellT.other
    local damType = otherT.damType
    local effect = otherT.spellEffect
    local target = player:getTarget()
    local frontPos = player:frontPos()

    if not target then
        return dealDamagePos(player, frontPos, damType, damage, effect, O_player_spells, effect)
    end
    local targetPos = target:getPosition()
    local playerPos = player:getPosition()

    if getDistanceBetween(playerPos, targetPos) > otherT.range then
        return dealDamagePos(player, frontPos, damType, damage, effect, O_player_spells, effect)
    end
    dealDamage(playerID, target, damType, damage, effect, O_player_spells)
    playerPos:sendDistanceEffect(targetPos, otherT.distanceEffect)
end

function spell_trap(playerID, spellT)
    local player = Creature(playerID)
    if not player then
        return
    end
    local otherT = spellT.other

    createItem(otherT.itemID, player:getPosition())
    -- createItem(2579, pos, 1, AID.other.hunterTrap, nil, player:getId())
    addEvent(removeItemFromPos, otherT.msDuration, otherT.itemID, pos)
end

function spell_trap_onStep(target, item)
    local player = Player(tonumber(item:getAttribute(TEXT)))
    local itemPos = item:getPosition()

    item:remove()
    if not player then
        return itemPos:sendMagicEffect(3)
    end
    -- damage
end

function spell_explosion(playerID, spellT)
    local player = Creature(playerID)
    if not player then
        return
    end
    local calculationT = spellcast_calculateFormula(player, spellT)
    local otherT = spellT.other
    local playerID = player:getId()
    local damage = calculationT.damage
    local positions = getAreaPos(player:getPosition(), otherT.area)

    for i, posT in pairs(positions) do
        for _, pos in pairs(posT) do
            addEvent(dealDamagePos, i * otherT.speed, playerID, pos, otherT.damType, damage, otherT.effectOnHit,
                O_player_spells, otherT.spellEffect, otherT.effectOnMiss)
        end
    end
end

function spell_onSpawn(playerID, spellT, spawnArea, centerPos)
    local player = Creature(playerID)
    if not player then
        return false
    end
    local calcT = spellcast_calculateFormula(player, spellT)
    local xDiff = centerPos.x - player:getPosition().x
    local yDiff = centerPos.y - player:getPosition().y
    local playerPos = centerPos
    local origin = O_player_spells
    local explosionPosT = getAreaPosCustom(playerPos, spellT, 0,player, spawnArea)

    for i, posT in pairs(explosionPosT) do
        for _, pos in pairs(posT) do
            local getCast = pos.cast or "adapt"
            local getDmg = {}
            if calcT and calcT[pos.dmg] then
                getDmg = calcT
            end
            if getCast == "adapt" then
			    --print(dump(spellT))
			    ---magic effect, even if no creature found.
				if spellT._sendEffectOnTile and spellT._sendEffectOnTile.enabled then
				    Position(pos.x, pos.y, pos.z):sendMagicEffect(spellT._sendEffectOnTile.id)
				end
				------------------------------------------------
                addEvent(doSendDistanceEffectCustom, (i - 1) * 100, playerID, playerPos, pos, player:getDirection())
                addEvent(dealDamagePosCustom, (i - 1) * 100, playerID, i, spellT, pos, getDmg, origin, playerPos, player:getDirection(),nil,playerPos)
			elseif getCast == "staticDirection" then
			                addEvent(doSendDistanceEffectCustom, (i - 1) * 100, playerID, playerPos, pos, player:getDirection(),0)
                addEvent(dealDamagePosCustom, (i - 1) * 100, playerID, i, spellT, pos, getDmg, origin, playerPos, player:getDirection(),0,playerPos)
            elseif getCast == "static" then
                addEvent(doSendDistanceEffectCustom, (i - 1) * 100, playerID, playerPos, pos, player:getDirection(), player:getDirection())
                addEvent(dealDamagePosCustom, (i - 1) * 100, playerID, i, spellT, pos, getDmg, origin, playerPos, player:getDirection(), player:getDirection(),playerPos)
                        elseif getCast == "caster" then
						pos.x = player:getPosition().x
						pos.y = player:getPosition().y
						pos.z = player:getPosition().z
                addEvent(doSendDistanceEffectCustom, (i - 1) * 100, playerID, player:getPosition(), pos)
                addEvent(dealDamagePosCustom, (i - 1) * 100, playerID, i, spellT, pos, getDmg, origin)
            end
        end
    end
return true
end

function spell_aoe(playerID, spellT)
    local player = Creature(playerID)
    if not player then
        return false
    end
    local getCopy = deepCopy(spellT)
    local calcT = spellcast_calculateFormula(player, getCopy)
    local playerPos = player:getPosition()
    local origin = O_player_spells
    local explosionPosT = getAreaPosCustom(playerPos, getCopy, player:getDirection(),player)
    for i, posT in pairs(explosionPosT) do
        for _, pos in pairs(posT) do
            local getCast = pos.cast or "adapt"
            local getDmg = {}
            if calcT and calcT[pos.dmg] then
                getDmg = calcT
            end
            if getCast == "adapt" then
                addEvent(doSendDistanceEffectCustom, (i - 1) * 100, playerID, playerPos, pos, player:getDirection())
                addEvent(dealDamagePosCustom, (i - 1) * 100, playerID, i, spellT, pos, getDmg, origin, playerPos, player:getDirection())
			elseif getCast == "staticDirection" then
			                addEvent(doSendDistanceEffectCustom, (i - 1) * 100, playerID, playerPos, pos, player:getDirection(),0)
                addEvent(dealDamagePosCustom, (i - 1) * 100, playerID, i, spellT, pos, getDmg, origin, playerPos, player:getDirection(),0)
            elseif getCast == "static" then
                addEvent(doSendDistanceEffectCustom, (i - 1) * 100, playerID, playerPos, pos, player:getDirection(), player:getDirection())
                addEvent(dealDamagePosCustom, (i - 1) * 100, playerID, i, spellT, pos, getDmg, origin, playerPos, player:getDirection(), player:getDirection(),playerPos)
                        elseif getCast == "caster" then
                addEvent(doSendDistanceEffectCustom, (i - 1) * 100, playerID, player:getPosition(), pos)
                addEvent(dealDamagePosCustom, (i - 1) * 100, playerID, i, spellT, pos, getDmg, origin)
            end
        end
    end
return true
end

function spell_summon(playerID, spellT)
    local player = Creature(playerID)
    if not player then
        return
    end
    local playerPos = player:getPosition()
    local newPosition = player:getClosestFreePosition(player:getPosition(), false)
	if spellT.maxSummon and spellT.maxSummon <= #player:getSummons() then return end
    local getSummon = Game.createMonster(spellT.summon, newPosition, true, true)
    if getSummon then
		if spellT.summonDistanceEffect and spellT.summonDistanceEffect > 0 then
			doSendDistanceEffect(playerPos, newPosition, spellT.summonDistanceEffect)
		end
		if spellT.summonEffect and spellT.summonEffect > 0 then
            doSendMagicEffect(getSummon:getPosition(), spellT.summonEffect)
		end
        getSummon:setMaster(player)
    end
end

function spell_target(playerID, spellT, target)
    local player = Creature(playerID)
    if not player then
        return false
    end
    if not player:getTarget() then
        return false
    end
    local calcT = spellcast_calculateFormula(player, spellT)
    local playerPos = player:getTarget():getPosition()
    local origin = O_player_spells
    local explosionPosT = getAreaPosCustom(playerPos, spellT, player:getDirection(),player)
    for i, posT in pairs(explosionPosT) do
        for _, pos in pairs(posT) do
            local getCast = pos.cast or "adapt"
            local getDmg = {}
            if calcT and calcT[pos.dmg] then
                getDmg = calcT
            end
			
            if getCast == "caster" then
						pos.x = player:getPosition().x
						pos.y = player:getPosition().y
						pos.z = player:getPosition().z
                addEvent(doSendDistanceEffectCustom, (i - 1) * 100, playerID, player:getPosition(), pos)
                addEvent(dealDamagePosCustom, (i - 1) * 100, playerID, i, spellT, pos, getDmg, origin)
			else
			pos.targetId = player:getTarget():getId()
            addEvent(doSendDistanceEffectCustom, (i - 1) * 100, playerID, player:getPosition(), pos, 0, 0)
            addEvent(dealDamagePosCustom, (i - 1) * 100, playerID, i, spellT, pos, getDmg, origin,playerPos, player:getDirection(), 0, playerPos)
        end
		end
    end
return true
end

local function aura(creatureID, direction, flyEffect)
    local creature = Creature(creatureID)
    if not creature then
        return
    end
    while direction > 3 do
        direction = direction - 3
    end
    local creaturePos = creature:getPosition()
    local newPos = getDirectionPos(creaturePos, compass1[direction + 1])
    local tile = Tile(newPos)
    if not tile then
        return
    end
    local newDir = direction - 1
    newDir = newDir == -1 and 3 or newDir
    local nextPos = getDirectionPos(creaturePos, compass1[newDir + 1])

    doSendDistanceEffect(nextPos, newPos, flyEffect)
end

local function auraSpell(playerID, spellT, eventName)
    local player = Creature(playerID)
    if not player then
        return
    end
    local calcT = spellcast_calculateFormula(player, spellT)
    local msDuration = calcT.duration * 1000

    if msDuration < 1001 then
        return player:sendTextMessage(GREEN, "cant use " .. spellT.spellName .. ", because it lasts under 1 second")
    end
    player:registerEvent(eventName)
    addEvent(eventRemove, msDuration, player:getId(), eventName)
end

function spell_aura1(playerID, spellT)
    return auraSpell(playerID, spellT, "spell_aura1")
end
local savedMonsters = {}
local function getMonsters(player, otherT)
    local area = {{1, 1, 1}, {1, 0, 1}, {1, 1, 1}}
    local playerPos = player:getPosition()
    local posT = getAreaPos(playerPos, area)
    local monsterT = {}
    local playerID = player:getId()
    local loopID = 0

    local function addMonster(pos)
        local tile = Tile(pos)
        if not tile then
            return
        end
        local creature = tile:getBottomCreature()
        if not creature then
            return
        end
        if not creature:isMonster() then
            return
        end
        loopID = loopID + 1
        monsterT[loopID] = creature:getId()
    end

    local function checkMonster(monsterID)
        local monster = Monster(monsterID)
        if not monster then
            return
        end
        if getDistanceBetween(playerPos, monster:getPosition()) > otherT.distance then
            return
        end
        loopID = loopID + 1
        monsterT[loopID] = monsterID
    end

    if savedMonsters[playerID] then
        for _, monsterID in pairs(savedMonsters[playerID]) do
            checkMonster(monsterID)
        end
    end

    for _, posT in pairs(posT) do
        for _, pos in pairs(posT) do
            addMonster(pos)
        end
    end

    savedMonsters[playerID] = monsterT
    return monsterT
end

local function auraThink(player, spellT)
    local calcT = spellcast_calculateFormula(player, spellT)
    local origin = O_player_spells
    local otherT = spellT.other
    local playerID = player:getId()
    local loopAmount = math.floor(1000 / otherT.speed)
    local monsterT = getMonsters(player, otherT)
    local damDelay = math.floor(1000 / otherT.damAmount)

    for _, monsterID in ipairs(monsterT) do
        for x = 1, otherT.damAmount do
            addEvent(dealDamage, (x - 1) * damDelay, playerID, monsterID, otherT.damType, calcT.damage, otherT.effect,
                origin, otherT.distance, otherT.flyEffect)
        end
    end

    for x = 0, loopAmount do
        addEvent(aura, x * otherT.speed, playerID, x, otherT.flyEffect)
    end
end


function spellcast_startUp()
local configKeys = {"spellSV", "func", "word", "manaCost", "healthCost", "cooldown", "targetRequired", "formula", "goldCost", 
"min_L", "min_mL", "min_dL", "min_sL", "min_swL", "min_aL", "min_cL", "min_fL", "shareCD", "vocation", "range", "bagItems", "slot", "other"}
local errorMsg = "Wikipedia.Spells."

    local function missingError(missingKey, errorMsg) print("ERROR - missing value in "..errorMsg..missingKey) end

    for spellName, spellT in pairs(Wikipedia.Spells) do
        for key, v in pairs(spellT) do
            --if not isInArray(configKeys, key) then print("ERROR - unknown key ["..key.."] in "..errorMsg) end
        end
        if not spellT.spellSV then missingError("spellSV", errorMsg) end
        if not spellT.func then missingError("func", errorMsg) end
        if not spellT.word then missingError("word", errorMsg) end
        if not spellT.min_L then spellT.min_L = 0 end
        if not spellT.min_mL then spellT.min_mL = 0 end
        if not spellT.min_dL then spellT.min_dL = 0 end
        if not spellT.min_sL then spellT.min_sL = 0 end
        if not spellT.min_swL then spellT.min_swL = 0 end
        if not spellT.min_aL then spellT.min_aL = 0 end
        if not spellT.min_cL then spellT.min_cL = 0 end
        if not spellT.min_fL then spellT.min_fL = 0 end
        if not spellT.cooldown then spellT.cooldown = 1 end
        if not spellT.manaCost then spellT.manaCost = 0 end
        if not spellT.healthCost then spellT.healthCost = 0 end
        if spellT.targetRequired and not spellT.range then spellT.range = 7 end
        if spellT.vocation and type(spellT.vocation) ~= "table" then spellT.vocation = {spellT.vocation} end
        if spellT.shareCD and type(spellT.shareCD) ~= "table" then spellT.shareCD = {spellT.shareCD} end
        spellT.spellName = spellName

        if spellT.slot then
            for slotID, slotT in pairs(spellT.slot) do
                local itemID_list = {}
                local loopID = 0
                local function addItemIDToList(itemID)
                    if type(itemID) == "table" then
                        for _, itemID in pairs(itemID) do addItemIDToList(itemID) end
                    end
                    loopID = loopID + 1
                    itemID_list[loopID] = itemID
                end
                
                addItemIDToList(slotT.items)
                slotT.items = itemID_list
                if not slotT.count then slotT.count = 1 end
                if not slotT.failText then slotT.failText = "you are missing item" end
            end
        end
        
        if spellT.bagItems then
            if spellT.bagItems.itemID then spellT.bagItems = {spellT.bagItems} end
            
            for _, itemT in ipairs(spellT.bagItems) do
                if not itemT.count then itemT.count = 1 end
                if not itemT.failText then itemT.failText = "you are missing item" end
            end
        end
    end
end

spellcast_startUp()
	
function spellcast_castSpell(player, spellWord, areaSpawn, areaPos)
	local spellT = spellcast_getSpellT(spellWord)
	local getCooldown = spellT.cooldown
	if getCooldown < 100 then 	getCooldown = getCooldown * 1000 end
	local getActive = spellT.activeTime
	if getActive and getActive < 100 then		getActive = getActive * 1000 end
	local getId = player:getId()
	local getName = spellT.spellName
	if not spellCooldownMemory[getId] then spellCooldownMemory[getId] = {} end
    if spellCooldownMemory[getId]["spellActive/"..getName] and spellCooldownMemory[getId]["spellActive/"..getName] > 0 then
		spell_onSpawn(getId, spellT, "TurnOff", player:getPosition())
		spellCooldownMemory[getId]["spellActive/"..getName] = 0
		return false
	end
    if not spellcast_canCast(player, spellWord) then return false end
    local getReturn
	if areaPos then
		getReturn = spell_onSpawn(getId, spellT, areaSpawn, areaPos)
	else
		getReturn = _G[spellT.func](player:getId(), spellT)
	end
	if not getReturn then return false end
	local manaCost = spellcast_getManaCost(player, spellT.spellName)
	local healthCost = spellcast_getHealthCost(player, spellT.spellName)

					if spellT.levelsAttributes then
						if player:getStorageValue(spellT.spellSV) > 0 then
									local getCollect = (spellT.levelsCombine and 1) or (not spellT.levelsCombine and player:getStorageValue(spellT.spellSV))
									for it = getCollect,player:getStorageValue(spellT.spellSV) do
						if spellT.levelsAttributes[it] and spellT.levelsAttributes[it].bonusAttributes then
						for i,child in pairs(spellT.levelsAttributes[it].bonusAttributes) do
						if child.attr == "spellCooldown" and child.condition and child.condition.name == "spellCast" then
						getCooldown = getCooldown + (child.value or 0)
						getCooldown = ((child.percent and (getCooldown * (child.percent/100))) or getCooldown)
						end
						end
						end
						end
						end
					end
    if healthCost > 0 then player:addHealth(-healthCost) end
	
    player:say(spellT.spellName, TALKTYPE_MONSTER_SAY)
	spellCooldownMemory[getId]["spellCd/"..getName] = getCooldown
	
	addEvent(function()
	spellCooldownMemory[getId]["spellCd/"..getName] = 0
	end, getCooldown)
	if getActive then
		spellCooldownMemory[getId]["spellActive/"..getName] = getActive
		addEvent(function()
		spellCooldownMemory[getId]["spellActive/"..getName] = 0
		end, getActive)
	end
    if spellT.shareCD then
        for _, v in pairs(spellT.shareCD) do
            local spellT = spellcast_getSpellT(v)
	local getId = player:getId()
	local getName = spellT.spellName
	if not spellCooldownMemory[getId] then spellCooldownMemory[getId] = {} end
	spellCooldownMemory[getId]["spellCd/"..getName] = getCooldown
	local resetFunc = function()
	spellCooldownMemory[getId]["spellCd/"..getName] = 0
	end
	addEvent(resetFunc,getCooldown)
        end
    end
	if not Monster(player) then 
    spellcast_removeItems(player, spellT)

    if manaCost > 0 then player:addMana(-manaCost) end
	-- custom spell cooldown
	local msg = NetworkMessage()
	msg:addByte(0xA4)
	local getSV = spellT.spellSV-29950
	msg:addByte(getSV)
	msg:addU32((spellT.cooldown*1000)) 
	msg:sendToPlayer(player)
	msg:delete()
	local msg2 = NetworkMessage()
	msg2:addByte(0xA5)
	msg2:addByte(spellT.spellGroup)
	msg2:addU32((spellT.groupCooldown*1000))
	msg2:sendToPlayer(player)
	msg2:delete()
	--
	end
	return true
end

function spellcast_canCast(player, spellWord, target)
	local spellT = spellcast_getSpellT(spellWord)
		
    if not spellT then return print("ERROR - missing spellT for "..tostring(spellWord).." in spellcast_canCast()") end
	if Tile(player:getPosition()):isPzLocked() and spellT.aggressive then return false, player:sendTextMessage(GREEN, "Cant cast spell from PZ zone") end
    
    if spellT.monsterSpell then
        local monster = Monster(player)
		if not monster then return false end
	end
	local getMonster = Monster(player)
	if player:getCustomAttribute("Silence") then
	local getAttr = json.decode(player:getCustomAttribute("Silence"))
	if getAttr.timer and getAttr.timer > os.mtime() and getAttr.mute then
	if not getMonster then
	player:sendTextMessage(GREEN, "You are silenced.")
	end
	return false 
	end
	end
	if getMonster then return true end
	if player:isGod() then return true end
    if spellT.targetRequired then
        local target = Creature(target) or player:getTarget()
        if not target then return false, player:sendTextMessage(GREEN, "target required.") end
        if spellT.range and getDistanceBetween(player:getPosition(), target:getPosition()) > spellT.range then return false, player:sendTextMessage(GREEN, "target too far.") end
   
   end
	if spellcast_onCooldown(player, spellT) then return end
	if spellT.maxSummons and #player:getSummons() >= spellT.maxSummons then return false, player:sendTextMessage(GREEN, "You have too much summons to cast this spell.") end
	--print("Vocation List: " .. dump(spellT.vocation))
    if spellT.vocation and #spellT.vocation > 0 and not player:isVocation(spellT.vocation) then return false, player:sendTextMessage(GREEN, "This is not your vocation spell") end
    --if player:getStorageValue(spellT.spellSV) < 0 then return true, player:sendTextMessage(GREEN, "You need to learn "..spellT.spellName.." first") end
    if player:getLevel() < spellT.min_L then return false, player:sendTextMessage(GREEN, "You need higher level to cast that spell.") end
    if player:getMagicLevel() < spellT.min_mL then return false, player:sendTextMessage(GREEN, "You need higher magic level to cast that spell.") end
    if player:getShieldingLevel() < spellT.min_sL then return false, player:sendTextMessage(GREEN, "You need higher shielding level to cast that spell.") end
    if player:getDistanceLevel() < spellT.min_dL then return false, player:sendTextMessage(GREEN, "You need higher distance level to cast that spell.") end
    if player:getSwordLevel() < spellT.min_swL then return false, player:sendTextMessage(GREEN, "You need higher sword level to cast that spell.") end
    if player:getAxeLevel() < spellT.min_aL then return false, player:sendTextMessage(GREEN, "You need higher axe level to cast that spell.") end
    if player:getClubLevel() < spellT.min_cL then return false, player:sendTextMessage(GREEN, "You need higher club level to cast that spell.") end
    if player:getHandcombatLevel() < spellT.min_fL then return false, player:sendTextMessage(GREEN, "You need higher fist fighting level to cast that spell.") end
    if not spellcast_checkSlots(player, spellT.slot) then return end
    if not spellcast_checkItems(player, spellT.bagItems) then return end
	if spellcast_groupCooldown(player) then return false, player:sendTextMessage(GREEN, "You casted to many spells, wait for cooldowns") end
	
	local manaCost = spellcast_getManaCost(player, spellT.spellName)
	local healthCost = spellcast_getHealthCost(player, spellT.spellName)
    
	if player:getMana() < manaCost then return false, player:sendTextMessage(GREEN, "Not enough Mana.") end
    if player:getHealth() <= healthCost then return false, player:sendTextMessage(GREEN, "Not enough Health.") end
    return true
end

function spellcast_groupCooldown(player)
	local spellsOnCooldownAmount = 0
	
	for spellName, spellT in pairs(Wikipedia.Spells) do
		if spellcast_onCooldown(player, spellT) then spellsOnCooldownAmount = spellsOnCooldownAmount + 1 end
		if spellsOnCooldownAmount >= 3 then return true end
	end
end

spellCooldownMemory = {} -- {playerID = timeLeft}
function spellcast_onCooldown(player, spellT, dontSendMsg)
local preventCast = false
local timeLeft = 0
	local getId = player:getId()
	local getName = spellT.spellName
	if spellCooldownMemory[getId] and spellCooldownMemory[getId]["spellCd/"..getName] and spellCooldownMemory[getId]["spellCd/"..getName] > 0 then
		preventCast = true
		timeLeft = spellCooldownMemory[getId]["spellCd/"..getName]
	end


        if preventCast and not dontSendMsg then
            doSendMagicEffect(player:getPosition(), 3)
            player:sendTextMessage(GREEN, "Spell under Cooldown. "..(timeLeft/1000).." sec.")
        end
	
    return preventCast
end

function spellcast_checkSlots(player, slotTable)
    if not slotTable then return true end
    
    for slot, slotT in pairs(slotTable) do
        local item = player:getSlotItem(slot)
        
        if not item or not isInArray(slotT.items, item:getId()) or item:getCount() < slotT.count then
            return false, player:sendTextMessage(GREEN, slotT.failText)
        end
    end
    return true
end

function spellcast_checkItems(player, itemsT)
    if not itemsT then return true end
    
    for _, itemT in pairs(itemsT) do
        local item = player:getItemById(itemT.itemID, true)
        
        if not item or item:getCount() < itemT.count then
            return false, player:sendTextMessage(GREEN, itemT.failText)
        end
    end
    return true
end

function spellcast_removeItems(player, spellT)
    if spellT.slot then
        for slot, slotT in pairs(spellT.slot) do
            if slotT.remove then player:getSlotItem(slot):remove(slotT.count) end
        end
    end

    if spellT.bagItems then
        for _, itemT in pairs(spellT.bagItems) do
            if itemT.remove then player:getItemById(itemT.itemID, true):remove(itemT.count) end
        end
    end
end


function spellcast_calculateFormula(player, spellT, variableInput)

local calculationT = {}
    if not spellT.formula then 
		calculationT["0"] = 0
		return calculationT
	end
	variableInput = variableInput or {}
	if not variableInput["spawnEffect"] then variableInput["spawnEffect"] = {} end
    for key, formulaT in pairs(deepCopy(spellT.formula)) do
		if not variableInput["spawnEffect"][key] then variableInput["spawnEffect"][key] = {} end
		local getVariables = formulaT.variables or {}
		for i,child in pairs(getVariables) do
				if child.value and variableInput[string.gsub(child.name,"|","")] then
					child.value = variableInput[string.gsub(child.name,"|","")]
				end
				if child.name == "|targetMaxHp|" and variableInput["target"] then
					child.value = variableInput["target"]:getMaxHealth()
				elseif child.name == "|targetHp|" and variableInput["target"] then
					child.value = variableInput["target"]:getHealth()
				elseif child.name == "|targetPercentHp|" and variableInput["target"] then
					child.value = (variableInput["target"]:getHealth()/variableInput["target"]:getMaxHealth())*100
				elseif child.name == "|targetLevel|" and variableInput["target"] and Player(variableInput["target"]) then
					child.value = variableInput["target"]:getLevel()
				end
	
			--elseif child.percent then
		end
		
		local newVar = {}
		for i,child in pairs(getVariables) do
			local passed = true
			local passedValue
			if child.condition then
				local getConditions = (child.condition[1] and child.condition[1].name and child.condition) or child.condition
				for _i,_child in pairs(getConditions) do
					if (_child.name == "customVariable" and _child.variable) or (_child.name == "storage" and _child.key and Wikipedia.storageTable[_child.key]) then
							local varOutput
							if (_child.name == "storage" and _child.key and Wikipedia.storageTable[_child.key]) then
								varOutput = player:getStorageValue(Wikipedia.storageTable[_child.key])
							else
								varOutput = math.floor(load("return " .. converFormulaToNumbers(player, _child.variable, getVariables))())
							end
						if varOutput and _child.value and type(_child.range) == "table" and _child.range[1] <= varOutput and varOutput <= _child.range[2] then
							passedValue = _child.value
						elseif varOutput and not _child.value and type(_child.range) == "table" and (varOutput < _child.range[1] or _child.range[2] < varOutput) then
							passed = false
						elseif varOutput and _child.value and type(_child.range) ~= "table" and varOutput == _child.range then
							passedValue = _child.value
						elseif varOutput and not _child.value and type(_child.range) ~= "table" and varOutput ~= _child.range then
							passed = false
						end
					elseif _child.name == "vocation" and _child.voc then
						if player:isVocation(_child.voc) then
							passedValue = _child.value
						end
					elseif _child.name == "spellActive" and _child.spellName then
						if _child.value and spellCooldownMemory[player:getId()] and spellCooldownMemory[player:getId()]["spellActive/".._child.spellName] and spellCooldownMemory[player:getId()]["spellActive/".._child.spellName] > 0 then
							passedValue = _child.value
						elseif not spellCooldownMemory[player:getId()] or  not spellCooldownMemory[player:getId()]["spellActive/".._child.spellName] or spellCooldownMemory[player:getId()]["spellActive/".._child.spellName] < 1 then
							passed = false
						end
					elseif _child.name == "random" and _child.percent then
						local varOutput = _child.percent
						if type(varOutput) == "string" then
							varOutput = math.floor(load("return " .. converFormulaToNumbers(player, _child.percent, getVariables))())
						end
						local varRandom = math.random(1,10000)/100
						if varOutput and _child.value and varOutput >= varRandom then
							passedValue = _child.value
							if _child.effect and _child.effect.success and _child.effect.success > 0 then
								table.insert(variableInput["spawnEffect"][key],_child.effect.success)
							end
						elseif varOutput and not _child.value and varOutput < varRandom then
							passed = false
							if _child.effect and _child.effect.fail and _child.effect.fail > 0 then
								table.insert(variableInput["spawnEffect"][key],_child.effect.fail)
							end
						end
					end
				end
			end
			
			if passed and passedValue then 
				child.value = passedValue
			end
		end
		local getMin = converFormulaToNumbers(player, formulaT.min, getVariables)
        local minAmount = math.floor(load("return " .. getMin)())
        local maxAmount = math.floor(load("return " .. converFormulaToNumbers(player, formulaT.max, getVariables))())
        if minAmount > maxAmount then maxAmount = minAmount end
        local amount = math.random(minAmount, maxAmount)
        if amount < 1 then amount = 0 end
        calculationT[key] = amount
    end
    return calculationT
end


function spellcast_spellScroll_onLook(player, item)
	if not item:isItem() then return end
local spellT = spellcast_getSpellT(item:getActionId())

    if not spellT then return end
    return player:sendTextMessage(GREEN, "You see "..spellT.spellName.." spell scroll")
end

function spellcast_spellScroll_onUse(player, item)
local spellT = spellcast_getSpellT(item:getActionId())
    
    if not spellT then return end
    if player:getStorageValue(spellT.spellSV) >= 0 then return player:sendTextMessage(GREEN, "You already know this spell") end    
    player:setStorageValue(spellT.spellSV, 0)
    player:sendTextMessage(GREEN, "you learned " ..spellT.spellName.. " spell") 
    item:remove(1)
end

-- get functions
function spellcast_getSpellT(object)
    if type(object) == "number" then
        for spellName, spellT in pairs(Wikipedia.Spells) do
            if spellT.spellSV == object then return spellT end
        end
    elseif type(object) == "string" then
        for spellName, spellT in pairs(Wikipedia.Spells) do
            if spellT.word == object or spellName == object then return spellT end
        end
    end
end

local function calcCost(player, cost)
    if type(cost) == "string" then cost = percentage(player:getMaxMana(), tonumber(cost:match("%d+")), true) end
    return cost < 0 and 0 or cost
end

function spellcast_getManaCost(player, spellName)
   -- Vprint("spellName: " .. spellName)
    --Uprint(spellcast_getSpellT(spellName))
    return calcCost(player, spellcast_getSpellT(spellName).manaCost) end
function spellcast_getHealthCost(player, spellName) return calcCost(player, spellcast_getSpellT(spellName).healthCost) end







creatureAfterGhost = {}
function afterGhost(creatureId)
	stopEvent(creatureAfterGhost[creatureId])
	creatureAfterGhost[creatureId] = nil
	local getCreature = Creature(creatureId)
	if getCreature then
		getCreature:setGhostMode(false)
		if hasObstacle(getCreature:getPosition(), "solid") then
			if not lastKnownPosition[creatureId] then return end
			getCreature:teleportTo(lastKnownPosition[creatureId])
		end
	end
end


function afterTimeDuration(creatureId,attribute,findChild)
	local getCreature = Creature(creatureId)
	if getCreature and getCreature:getCustomAttribute(attribute) then
	local getAttr = json.decode(getCreature:getCustomAttribute(attribute))
	if not getAttr then return end
	if type(findChild) == "string" then
		if getAttr[findChild] and getAttr[findChild].customName then
			getCreature:removeCustomAttribute(getAttr[findChild].customName)
		end
		getAttr[findChild] = nil
		local counter = 0
		for i,child in pairs(getAttr) do
			counter = counter + 1
		end
		if counter < 1 then
			getCreature:removeCustomAttribute(attribute)
		else
			getCreature:setCustomAttribute(attribute, json.encode(getAttr))
		end
	elseif tonumber(findChild) then
		if getAttr[findChild] then
			if tonumber(findChild) < 10000 then
	local getCopy = deepCopy(getAttr[findChild])
			for i,child in pairs(getCopy.stats) do
			getCopy.stats[i].value = 0
			end
			return getCreature:changeCustomAttribute(attribute, json.encode(getCopy))
			end
		getAttr[findChild] = nil
			getCreature:setCustomAttribute(attribute, json.encode(getAttr))
	end
	
	elseif getAttr.attr then
		getCreature:removeCustomAttribute(attribute)
end

	end
end

globalDurationTimer = {}
sendEvent = {}
attributeIcons = {
["monsterMark"] = CONDITION_CURSED,
["playerMark"] = CONDITION_CURSED,
["Absorb"] = CONDITION_DAZZLED,
["Silence"] = CONDITION_MUTED,
["movementSpeed"] = CONDITION_FREEZING,
}
function Creature:returnCustomAttribute(attribute)
	if self:getCustomAttribute(attribute) then
		return json.decode(self:getCustomAttribute(attribute))
	end
	if attribute == "actualBar" then
		return 1
	end
	return nil
end

animationEvent = {}
spellEvent = {}
function changeCustomAttributes(creatureId, attribute, value, extraVar)
	local getCreature = Creature(creatureId)
	if not getCreature then return end
	
	getCreature:changeCustomAttribute(attribute, value, extraVar)
end
function Creature:changeCustomAttribute(attribute, value, extraVar)
		local getAttr = json.decode(value)
		if not getAttr then return end
				if getAttr and type(getAttr) == "table" then
		local getCaster = Creature(getAttr.casterId)
		if getAttr.attr ~= "heal" and getCaster and getCaster:canAttack(self) ~= RETURNVALUE_NOERROR then return end
		if getAttr.attr == "heal" and getCaster and self ~= getCaster and getCaster:canAttack(self) == RETURNVALUE_NOERROR then return end
		local localConditionContainer
		if attributeIcons[attribute] then
	localConditionContainer = Condition(attributeIcons[attribute])
	localConditionContainer:setTicks(getAttr.condition.duration)
    localConditionContainer:setParameter(CONDITION_PARAM_PERIODICDAMAGE, 0)
	self:addCondition(localConditionContainer)
	end
	
		if getAttr.condition then
		local removeTimer = getAttr.condition.duration
			if removeTimer then
			if getAttr.condition.immune and getAttr.condition.immune > removeTimer then
				removeTimer = getAttr.condition.immune
			end
			if getAttr.condition.repetition and getAttr.condition.repetition > 1 then
				getAttr.condition.repetition = getAttr.condition.repetition - 1
				removeTimer = (getAttr.immuneTimer and getAttr.immuneTimer >  os.mtime() and getAttr.immuneTimer - os.mtime()) or getAttr.condition.immune or removeTimer
				stopEvent(globalDurationTimer[self:getId().."/"..attribute.."/"..getAttr.casterId])
				globalDurationTimer[self:getId().."/"..attribute.."/"..getAttr.casterId] = nil
				globalDurationTimer[self:getId().."/"..attribute.."/"..getAttr.casterId] = addEvent(changeCustomAttributes, removeTimer, self:getId(), attribute, json.encode(getAttr))
			else
				stopEvent(globalDurationTimer[self:getId().."/"..attribute.."/"..getAttr.casterId])
				globalDurationTimer[self:getId().."/"..attribute.."/"..getAttr.casterId] = nil
				globalDurationTimer[self:getId().."/"..attribute.."/"..getAttr.casterId] = addEvent(afterTimeDuration, removeTimer, self:getId(), attribute)
			end
		end
		end
		end
	

if attribute == "playerMark" or attribute == "monsterMark" then


				
                        stopEvent(sendEvent[getAttr.casterId.."/"..self:getId()])
                        sendEvent[getAttr.casterId.."/"..self:getId()] = nil
                        sendEvent[getAttr.casterId.."/"..self:getId()] = addEvent(function()
						local getPlayer = Player(getAttr.casterId)
							if self and getPlayer and self ~= getPlayer then
							self:sendAttributes(getPlayer)
							end
							if self then
							self:sendAttributes(self)
							end
	   end, 250)
						local getTable = {}
                        if self:getCustomAttribute(attribute) then
                            getTable = json.decode(self:getCustomAttribute(attribute))
                                if getTable[tostring(getAttr.casterId)] and getTable[tostring(getAttr.casterId)].timer and
                                    getTable[tostring(getAttr.casterId)].timer > os.mtime() and
                                    getTable[tostring(getAttr.casterId)].ammount and
                                    getTable[tostring(getAttr.casterId)].maxAmmount and
                                    getTable[tostring(getAttr.casterId)].ammount <
                                    getTable[tostring(getAttr.casterId)].maxAmmount then
                                    getAttr.ammount = getAttr.ammount + getTable[tostring(getAttr.casterId)].ammount
                                elseif getTable[tostring(getAttr.casterId)] and
                                    getTable[tostring(getAttr.casterId)].timer > os.mtime() then
                                    getAttr.ammount = getTable[tostring(getAttr.casterId)].ammount
                                end
							end
                            getTable[tostring(getAttr.casterId)] = getAttr
		local removeTimer = getAttr.condition.duration
			if getAttr.condition.immune then
				removeTimer = getAttr.condition.immune
			end
			stopEvent(globalDurationTimer[self:getId().."/"..attribute.."/"..getAttr.casterId])
			globalDurationTimer[self:getId().."/"..attribute.."/"..getAttr.casterId] = nil
			globalDurationTimer[self:getId().."/"..attribute.."/"..getAttr.casterId] = addEvent(afterTimeDuration, removeTimer, self:getId(),attribute,tostring(getAttr.casterId))
                                
								
		return addEvent(function() self:setCustomAttribute(attribute, json.encode(getTable)) end, 10)

elseif attribute == "teleport" then
    
	

	--print("Extra Var: " .. extraVar)
	
	
if getAttr and getAttr.condition.name == "creatureAction" and getAttr.targetPos then
		if not hasObstacle(getAttr.targetPos, "solid") then
	if self:getPathTo(getAttr.targetPos,0,50,true,true) then
			addEvent(function() self:teleportTo(getAttr.targetPos,true,getAttr.dashDuration or 0) end,10)
	end
end
end
elseif attribute == "spawnMonster" then
if getAttr and getAttr.condition.name == "creatureAction" and getAttr.targetPos then
			if getAttr.maxSummons and getAttr.maxSummons <= #self:getSummons() then return end
		if not hasObstacle(getAttr.targetPos, "solid") then
	if self:getPathTo(getAttr.targetPos,0,50,true,true) then
			local playerPos = getAttr.targetPos
			local getSummon = Game.createMonster(getAttr.name, playerPos, true, true)
			if getSummon then
				getSummon:setMaster(self)
				
			end
	end
end
end
elseif attribute == "push" then
if getAttr and getAttr.targetPos then
if not getAttr.pushDirections then getAttr.pushDirections = {0} end
if not getAttr.pushDistance then getAttr.pushDistance = 1 end
local getPos = Position(getAttr.targetPos)
for i,child in pairs(getAttr.pushDirections) do
local randomI = math.random(#getAttr.pushDirections)
getPos:getNextPosition(getAttr.pushDirections[randomI],getAttr.pushDistance)
		if not hasObstacle(getPos, "solid") and not hasObstacle(getPos, "creature") then
			if self:getPathTo(getPos,0,50,true,true) then
				self:teleportTo(getPos,true)
			end
		elseif hasObstacle(getPos, "solid") and not hasObstacle(getPos, "creature") then
				if getAttr.obstacleDmg then
					return {newDmg=getAttr.obstacleDmg}
				end
			else
			getAttr.pushDirections[randomI] = nil
end
end
end

elseif attribute == "spawnArea" then--immuneTimer pass with new values 
	if not getAttr or not getAttr.casterId then return end
	local getSpell = Wikipedia.Spells[getAttr.spellName]
	if not getSpell then return end
	local getAttacker = Creature(getAttr.casterId)
	if not getAttacker then return end
	if getAttr.condition[2] and getAttr.condition[2].repetition and getAttr.condition[2].repetition > 0 then
		getAttr.condition[2].repetition = getAttr.condition[2].repetition - 1
		self:setCustomAttribute(attribute, json.encode(getAttr))
		if math.abs(os.mtime() - getAttr.castTime) > 5 then
			spell_onSpawn(getAttr.casterId, getSpell, getAttr.areaSpawn, getAttacker:getPosition())
		end
	elseif not getAttr.condition[2] then
		spell_onSpawn(getAttr.casterId, getSpell, getAttr.areaSpawn, getAttacker:getPosition())
	end
				
		if getAttr.condition and getAttr.condition[1] and getAttr.condition[1].duration then
		local removeTimer = getAttr.condition[1].duration
				stopEvent(globalDurationTimer[self:getId().."/"..attribute.."/"..getAttr.casterId])
				globalDurationTimer[self:getId().."/"..attribute.."/"..getAttr.casterId] = nil
				globalDurationTimer[self:getId().."/"..attribute.."/"..getAttr.casterId] = addEvent(afterTimeDuration, removeTimer, self:getId(), attribute)
	

		end
	return
elseif attribute == "damage" or attribute == "heal" then--immuneTimer pass with new values 
	if not getAttr or not getAttr.casterId then return end
	local getSpell = Wikipedia.Spells[getAttr.spellName]
	if not getSpell then return end
	local getAttacker = Creature(getAttr.casterId)
	if not getAttacker then return end
	local getDmg = getAttr.value
	if not getDmg or getDmg < 1 then return end
	local getCombat = COMBAT_HEALING
	self:setCustomAttribute(attribute, json.encode(getAttr))
	if attribute == "damage" then
		if not getAttr.immuneTimer or os.mtime() <= getAttr.immuneTimer then return end
		
		getCombat = COMBAT_EARTHDAMAGE
		if getAttr.manaUse then
			getCombat = COMBAT_MANADRAIN
			if getAttr.repetitionFail and self:getMana() < getDmg then
				local getRepetition = getAttr.condition.repetition
				getAttr.condition.repetition = 0
				getAttr.condition.duration = 1
					if getRepetition > 0 then
					spell_onSpawn(getAttr.casterId, getSpell, getAttr.repetitionFail, getAttacker:getPosition())
				spellCooldownMemory[getAttr.casterId]["spellActive/"..getAttr.spellName] = 0
				 self:changeCustomAttribute(attribute, json.encode(getAttr))
				 end
				return
			end
		else
			getDmg = getDmg * -1
		end
		
	else
		self:getPosition():sendMagicEffect(77)
	end
				stopEvent(creatureAfterGhost[self:getId().."/"..attribute.."/"..getAttr.casterId])
				creatureAfterGhost[self:getId().."/"..attribute.."/"..getAttr.casterId] = nil
				creatureAfterGhost[self:getId().."/"..attribute.."/"..getAttr.casterId] = addEvent(doTargetCombatHealth, 50, getAttacker:getId(), self:getId(), getCombat, getDmg, getDmg, 1)
		

elseif attribute == "creature_animation" then
if getAttr and getAttr.actionObject and getAttr.animationDuration then
local bonusAttributesNumeration
local animationStorage = {
--fast link key names for conditions check
--turnoff condition event//unregister dynamicly creatureevents
--[playerid]
	--[creature_animation] = {
		-- {  {sequence=importanceIndex={[spellsv] = seq child/action object ,} },
		--["lookWings"] = {["all"] = { {activeConfig={},seq={}},{seq2} }},
	--[teleport/push] = {
			--[1]={["all"]}
	--[movementSpeed] = {
			--[SpellSV]={
				--[casterId] = {}
					--[1] = {getAttr.seq}
	--[dmg] = {
			--[SpellSV/casterName/mtime] = getAttr.seq
			--casterId/casterName cleanUp onLogout
	}
	--simple list with objects / remove based on castTime or forceclear everything 
	--reloop everything / store nearest time + addEvents
--////////stack enemy individualy / spellSV unique
--activation/cooldown end callbacks for cleanup by spellsv and pick next action
--///////bonusAttributes numeration for action execution sequence order 
--+ multithreading 
--\\\\\\\\\\sort importanceVariable/castTime
--+ client compatible functions
	--+spell modifications based on same spellSV casters number


local getSpell = getAttr.spellSV
local getAnimation = getAttr.looktype
	if type(getAnimation) == "string" then
		getAnimation = Wikipedia.creatureAnimations[getAnimation][self:getOutfit().lookType]
	end

	for i,child in pairs(animationStorage) do
		if getAttr.condition and getAttr.condition.immune then
		
		end

	end
	
function removeAction(playerId, bonusAttribute, key)--name for longer cd
 --forceWait
end


local bonusAttributesConfig = {--maybe pass as config to getAttr object with dynamic changes
	["spells"] = {order = 1, onChangeRecalculate=true, filterActions = {"highestValue", "stackSpells",} }, -- update player spells for spectators after activation / accurate recreation of spell based on given time
	["spellsActive"] = {order = 1, onChangeRecalculate=true, filterActions = {"highestValue", "stackSpells",} }, --
	["spellsCooldown"] = {order = 1, onChangeRecalculate=true, filterActions = {"highestValue", "stackSpells",} }, --
	["spell_indicator"] = {order = 1, onChangeRecalculate=true, executionRefresh = 500, filterActions = {"highestValue", "stackSpells",} }, -- 
	["spell_mouseInteraction"] = {order = 1, onChangeRecalculate=true, filterActions = {"highestValue", "stackSpells",} }, -- if turned off use current mouse position as instant cast
	["spell_mouseTracker"] = {order = 1, onChangeRecalculate=true, filterActions = {"highestValue", "stackSpells",} }, -- if turned off show last active spell time left on mouse cursor/creature thing
	["spellsEffects"] = {order = 1, renderOff=true, onChangeRecalculate=true, filterActions = {"highestValue", "stackSpells",} }, --
	["spellsMissiles"] = {order = 1, onChangeRecalculate=true, filterActions = {"highestValue", "stackSpells",} }, --
	["spellsDamage"] = {order = 1, onChangeRecalculate=true, filterActions = {"highestValue", "stackSpells",} }, --pass avarage one tile dmg from aoe spells 
	["creature_animation"] = {order = 4, onChangeRecalculate=true, filterActions = {"importance", "last",} },
	["movementSpeed"] = {order = 4, onChangeRecalculate=true, filterActions = {"highestValue", "stackSpells",} },
	["push"] = {order = 5, executionRefresh = 100, filterActions = {"firstFromAvarageTime", "stackSpells",} },
	["teleport"] = {order = 6, validCheck={}, executionRefresh = 100, filterActions = {"lastFromAvarageTime", "stackSpells",} },
}--use single function to handle sameTime attributes to limit position recalculation and easier valid check
local filterActions = "last" --firstCast/lastCast/importance/highestValue/collectValue/lowestValue/stackSpells/stackCasters (limit spectators call by collecting all info)
function insertAction(playerId, actionObjects)--name for longer cd
	for iObject,actionObject in pairs(actionObjects) do
	local getAttr = actionObject and actionObject.condition
	if not getAttr or not getAttr.name or getAttr.name ~= "creatureAction" then return end
	
	if not animationStorage[playerId] then animationStorage[playerId] = {} end
	
	if not animationStorage[playerId][getAttr.attr] then
		--if getAttr.attr == "creature_animation" then
			playerStorage[getAttr.attr] = {}
		--end
	end
	
	local getSpellId = actionObject.spellSV
	local getCaster = actionObject.casterId
	local getSpellTimer = actionObject.castTime
	--if not Player(actionObject.casterId) then return end
	if actionObject.unique then
		if actionObject.unique["caster"] then
			getCaster = actionObject.unique["caster"]
		elseif actionObject.unique["id"] then
			getSpellId = actionObject.unique["id"]
		elseif actionObject.unique["timer"] then
			getSpellTimer = actionObject.unique["timer"]
		end
	end
	local getContainer = {data={1,2}, active=1, conditionEvents=2, lastValue=3, highestValue=4, nearestTime=5, finishTime=6, highestImportance=7} -- limit getspectators refresh as much as possible
	local getKey = getSpellId.."/"..getCaster .."/".. getSpellTimer
	if not animationStorage[playerId][getAttr.attr][getKey] then animationStorage[playerId][getAttr.attr][getKey] = {} end
	local getList = animationStorage[playerId][getAttr.attr][getKey]
	local refreshTime = castTime 
	
					--immune/replaceable
	if replace then
		local spellActions = playerStorage[getAttr.attr]
		for i,child in ipairs(spellActions) do
			if child.spellSV == getAttr.spellSV then
			end
		end
	elseif replacespellsv then
		table.insert(playerStorage[getAttr.attr], getAttr)
	end
	
	end
	
	
	table.sort(playerStorage[getAttr.attr], function(a, b)
		return b.castTime > a.castTime
	end)
	
	--refreshAttributesFunctions
end

local actionsSingleton = {}
local executionRefresh = 1 --instant/low refresh/ high refresh
	
function executeActions(playerId, config)--name for longer cd
	local playerStorage = animationStorage[playerId]
	if not playerStorage then return end
	--active/cooldown as bonusAttribute
	--onremove bonusAttribute callback for TurnOff area
	--attribute last refresh check
	--1 add event refresh all / 20 events for single attribute
	--1k vs 20k performance check
	local removeActions = {{1,"key"},{5,"key"}} -- remove every execute check / remove after spell end callback / remove with spell creator events for client use
	local activeActions = {{2,"key"}}
	local executeTime = 0
	
		
		local start = config.start or 1
		for i = start,#bonusAttributes do
			local getConfig = playerStorage[i]
			local activeLink = 2
			local importanceFilter = {} 
			local spellsFilter = {} 
			local casterFilter = {} 
			if getConfig then
				for i,child in pairs(getConfig) do
					if #getConfig > i and not child.skip then
					
					elseif child.skip then
					
					end
			end
		end
	end
	
	--highest value
	if filterActions == "last" then
		local getActions = activeActions[#activeActions]
	elseif filterActions == "first" then
		local getActions = activeActions[1]
	elseif filterActions == "stack" then
	for i,child in pairs(activeActions) do
		if playerStorage[child[1]] then 
				playerStorage[child[1]][child[2]] = nil end
			end
	end

	for i,child in pairs(removeActions) do
		if playerStorage[child[1]] then playerStorage[child[1]][child[2]] = nil end
	end
	
	--if executionRefresh < 1 then
	--	if actionsSingleton[playerId] then
	--		if actionsSingleton[playerId][bonusAttribute] then
	--			stopEvent(actionsSingleton[playerId][bonusAttribute])
	--			actionsSingleton[playerId][bonusAttribute] = nil
	--		end
	--	else
	--		actionsSingleton[playerId] = {}		
	--	end
	--	actionsSingleton[playerId][bonusAttribute] = addEvent(executeActions, executeTime, playerId, config)
		
--	else
	--end
		if actionsSingleton[playerId] then
			stopEvent(actionsSingleton[playerId])
			actionsSingleton[playerId]= nil
		end
		-- recalculate from all /activeObjects order with valid check
		actionsSingleton[playerId] = addEvent(executeActions, executionRefresh - (os.mtime() % executionRefresh), playerId, config)
	end
	--for i,child in pairs(playerStorage) do
end

	if getAttr and getAttr.outfit then
		local getAnimation = getAttr.outfit
		if not getAnimation then return end
		local getOutfit = getGlobalAnimation(getAnimation, self)
		if getOutfit then
			if getOutfit.animationDuration then
				--getAttr.animationDuration = getOutfit.animationDuration
			end
			if getOutfit.outfit then
				getAnimation = getOutfit.outfit
			end
		end
		if not getAttr.animationDuration then return end
		
		local getId = self:getId()
		local baseOutfit = {}
		local delay = 20
		for i,child in pairs(getAnimation) do
			local actualOutfit = self:getOutfit()[i]
			local getAnimationEvent = animationEvent[getId] and animationEvent[getId][i]
			if getAnimationEvent then 
					actualOutfit = animationEvent[getId][i].actualOutfit
					stopEvent(animationEvent[getId][i].event)
					animationEvent[getId][i] = nil
				elseif not animationEvent[getId] then
					animationEvent[getId] = {}
				end
				
				animationEvent[getId][i] ={event=addEvent(function() 
					local getPlayer = Creature(getId)
					if getPlayer then
						local getOutfiter = getPlayer:getOutfit()
						getOutfiter[i] = animationEvent[getId][i].actualOutfit
						getPlayer:setOutfit(getOutfiter)
					end
					animationEvent[getId][i] = nil
				end,getAttr.animationDuration),actualOutfit=actualOutfit}
			--self:setStorageValue(123678,actualOutfit)
			local pickLooktype = getAnimation[i]
			local getOutfiter = self:getOutfit()
			getOutfiter[i]= pickLooktype
			self:setOutfit(getOutfiter)
		end
	end
elseif attribute == "creature_spell" then
	if getAttr and getAttr.looktype and getAttr.animationDuration then
		local getId = self:getId()
		
		if spellEvent[getId] then 
			stopEvent(spellEvent[getId])
			spellEvent[getId] = nil
		end
		
		spellEvent[getId] = addEvent(function() 
			local getPlayer = Player(getId)
			if getPlayer then
				local getOutfiter = getPlayer:getOutfit()
				getOutfiter.lookSpell = 0
				getPlayer:setOutfit(getOutfiter)
			end
			spellEvent[getId] = nil
		end,getAttr.animationDuration)
		
		local currentOutfiter = self:getOutfit()
		currentOutfiter.lookSpell = getAttr.looktype
		self:setOutfit(currentOutfiter)
	end
elseif attribute == "spell_indicator" or attribute == "spell_mouseInteraction" or attribute == "spell_mouseTracking" then
if getAttr.onlyCaster and self:getId() ~= getAttr.casterId then return true end
                        stopEvent(sendEvent[self:getId().."/"..attribute.."/"..getAttr.casterId.."/"..getAttr.spellSV])
                        sendEvent[self:getId().."/"..attribute.."/"..getAttr.casterId.."/"..getAttr.spellSV] = nil
                        sendEvent[self:getId().."/"..attribute.."/"..getAttr.casterId.."/"..getAttr.spellSV] = addEvent(function()
						local getPlayer = Player(getAttr.casterId)
							if self and getPlayer and self ~= getPlayer then
							self:sendAttributes(getPlayer)
							end
							if self then
							self:sendAttributes(self)
							end
	   end, 150)
						local getTable = {}
							if self:getCustomAttribute(attribute) then
								getTable = json.decode(self:getCustomAttribute(attribute))
							end
     if not getTable[tostring(getAttr.casterId)] then getTable[tostring(getAttr.casterId)] = {} end
	 getAttr.castTime = os.mtime()
	 getAttr.castPosition = self:getPosition()
                            table.insert(getTable[tostring(getAttr.casterId)],getAttr)

		local removeTimer = getAttr.condition.duration
			if getAttr.condition.immune then
				removeTimer = getAttr.condition.immune
			end
			stopEvent(globalDurationTimer[self:getId().."/"..attribute.."/"..getAttr.casterId.."/"..getAttr.spellSV])
			globalDurationTimer[self:getId().."/"..attribute.."/"..getAttr.casterId.."/"..getAttr.spellSV] = nil
			globalDurationTimer[self:getId().."/"..attribute.."/"..getAttr.casterId.."/"..getAttr.spellSV] = addEvent(afterTimeDuration, removeTimer, self:getId(),attribute,tostring(getAttr.casterId))
                                
								
		return addEvent(function() self:setCustomAttribute(attribute, json.encode(getTable)) end, 10)
	elseif attribute == "customBuff" then
		if not getAttr or not getAttr.customName then return end
		local changeValue = getAttr.value or 0
		changeValue = changeValue * 100
		local getTable = (self:getCustomAttribute(attribute) and json.decode(self:getCustomAttribute(attribute))) or {}
		if not getTable[getAttr.customName] or getTable[getAttr.customName].lastValue ~= changeValue then
			self:setCustomAttribute(getAttr.customName, changeValue)
		end
		local localTable = {}
		if getTable then
			for i,child in pairs(getTable) do
				table.insert(localTable, child)
			end
		end
		getAttr.lastValue = changeValue
		getTable[getAttr.customName] = getAttr
		if getAttr.condition and getAttr.condition[1] and getAttr.condition[1].duration then
		local removeTimer = getAttr.condition[1].duration 
			if getAttr.condition[1].immune then
				removeTimer = getAttr.condition[1].immune
			end
			stopEvent(removeCustomBuffReset[self:getId().."/"..attribute.."/"..getAttr.spellSV.."/"..getAttr.customName])
			removeCustomBuffReset[self:getId().."/"..attribute.."/"..getAttr.spellSV.."/"..getAttr.customName] = nil
			removeCustomBuffReset[self:getId().."/"..attribute.."/"..getAttr.spellSV.."/"..getAttr.customName] = addEvent(removeCustomBuff, getAttr.condition[1].duration, self:getId(), getAttr.customName)--trigger with walk animation end source integration  
			
					stopEvent(globalDurationTimer[self:getId().."/"..attribute.."/"..getAttr.spellSV.."/"..getAttr.customName])
					globalDurationTimer[self:getId().."/"..attribute.."/"..getAttr.spellSV.."/"..getAttr.customName] = nil
					globalDurationTimer[self:getId().."/"..attribute.."/"..getAttr.spellSV.."/"..getAttr.customName] = addEvent(afterTimeDuration, removeTimer,self:getId(),attribute, getAttr.customName )

		end

		self:setCustomAttribute(attribute, json.encode(getTable))
		return 
elseif attribute == "conditionBuff"  then
		local getAttr = json.decode(value)
		if not getAttr then return end
		local getTable = (self:getCustomAttribute(attribute) and json.decode(self:getCustomAttribute(attribute))) or {}
		
				local combinedValue = {}
				local realAttribute = false
				local tableCounter = 0
										for baseI,baseChild in pairs(getAttr.stats) do
					local getCondition = self:getCondition(CONDITION_ATTRIBUTES,CONDITIONID_COMBAT,baseChild.subId)
						if getCondition then
						self:removeCondition(getCondition)
						end
						if baseChild.value > 0 then
						combinedValue[baseChild.subId] = (combinedValue[baseChild.subId] or 0) + baseChild.value
						realAttribute = true
						end
					end

				for i,child in pairs(getTable) do
						tableCounter = tableCounter + 1
				if child.stats then
				for _i,_child in pairs(child.stats) do
						for baseI,baseChild in pairs(getAttr.stats) do
						if _child.subId == baseChild.subId and _child.value > 0 and getAttr.spellSV ~= child.spellSV then
						combinedValue[baseChild.subId] = (combinedValue[baseChild.subId] or 0) + _child.value
						end
					end
				end
					end
		end

	
	if tableCounter < 1 then
			for _i,_child in pairs(spellSystemConditionStats) do
					local getCondition = self:getCondition(CONDITION_ATTRIBUTES,CONDITIONID_COMBAT,_child.subId)
						if getCondition then
						self:removeCondition(getCondition)
						end
		end
		
	end
	for _i,_child in pairs(getAttr.stats) do
						if combinedValue[_child.subId] and combinedValue[_child.subId] > 0 then						
                                local localConditionContainer = Condition(CONDITION_ATTRIBUTES)
                                localConditionContainer:setParameter(CONDITION_PARAM_TICKS, getAttr.condition.duration)
                                if _child.condition == CONDITION_PARAM_MANAGAIN or _child.condition ==
                                    CONDITION_PARAM_HEALTHGAIN then
                                    localConditionContainer = Condition(CONDITION_REGENERATION)
                                    localConditionContainer:setParameter(CONDITION_PARAM_HEALTHTICKS, 1000)
                                    localConditionContainer:setParameter(CONDITION_PARAM_MANATICKS, 1000)
                                localConditionContainer:setParameter(CONDITION_PARAM_TICKS, getAttr.condition.duration)
                                end
                                local getValue = combinedValue[_child.subId]
                                if _child.percent then
                                    if _child.condition == CONDITION_PARAM_MANAGAIN then
                                        getValue = (_child.value / 100) * self:getMaxMana()
                                    elseif _child.condition == CONDITION_PARAM_HEALTHGAIN then
                                        getValue = (_child.value / 100) * self:getMaxHealth()
                                    end
                                end
                                localConditionContainer:setParameter(CONDITION_PARAM_SUBID, _child.subId)
                                localConditionContainer:setParameter(CONDITION_PARAM_BUFF_SPELL, 1)
                                localConditionContainer:setParameter(_child.condition, getValue)
                                self:addCondition(localConditionContainer)
				end
	end
	if realAttribute then
		local removeTimer = getAttr.condition.duration
			if getAttr.condition.immune then
				removeTimer = getAttr.condition.immune
			end
				getTable[tostring(getAttr.spellSV)] = getAttr
					stopEvent(globalDurationTimer[self:getId().."/"..attribute.."/"..getAttr.spellSV.."/all"])
					globalDurationTimer[self:getId().."/"..attribute.."/"..getAttr.spellSV.."/all"] = nil
					globalDurationTimer[self:getId().."/"..attribute.."/"..getAttr.spellSV.."/all"] = addEvent(afterTimeDuration, removeTimer,self:getId(),attribute,tostring(getAttr.spellSV) )

	
else
		getTable[tostring(getAttr.spellSV)] = nil
end

	self:setCustomAttribute(attribute, json.encode(getTable))
	return
	end
self:setCustomAttribute(attribute, value)
	if attribute == "extraPercentHealth" then
		self:setMaxHealth(self:getCustomAttribute("baseHealthMax") * (value / 100))
		self:addHealth(self:getMaxHealth())
	elseif attribute == "extraPercentSpeed" then
		self:changeSpeed((self:getCustomAttribute("baseSpeed") * (value / 100)) - self:getCustomAttribute("baseSpeed"))
	elseif attribute == "Silence" then
		if getAttr.target then
				self:setTarget(nil)
				self:setFollowCreature(nil)
			if self:isMonster() then
				self:searchTarget()
			end
		end
	elseif attribute == "movementSpeed" then
		local changeValue = getAttr.value or 0
		if getAttr.percent and getAttr.percent > 0 then
			changeValue = changeValue + ((self:getBaseSpeed()) * (getAttr.percent / 100)) - (self:getBaseSpeed())
		end
		if getAttr.percent and getAttr.percent == 0 then
			changeValue = changeValue - self:getBaseSpeed()
		end
		local removeTimer = 1500
		if getAttr.condition and getAttr.condition.duration then
			removeTimer = getAttr.condition.duration
			if getAttr.condition.immune then
				removeTimer = getAttr.condition.immune
			end
			stopEvent(creatureSpeedReset[self:getId()])
			creatureSpeedReset[self:getId()] = nil
			creatureSpeedReset[self:getId()] = addEvent(resetSpeed, getAttr.condition.duration, self:getId())--trigger with walk animation end source integration  
			
					stopEvent(globalDurationTimer[self:getId().."/"..attribute.."/"..getAttr.spellSV.."/all"])
					globalDurationTimer[self:getId().."/"..attribute.."/"..getAttr.spellSV.."/all"] = nil
					globalDurationTimer[self:getId().."/"..attribute.."/"..getAttr.spellSV.."/all"] = addEvent(afterTimeDuration, removeTimer,self:getId(),attribute )
end
	
		if math.abs((self:getSpeed()) - (self:getBaseSpeed() + changeValue)) > 5 then
			--print("change speed init "..self:getSpeed().." ".. (self:getBaseSpeed() + changeValue) .. " "..self:getBaseSpeed().. " "..changeValue)
			local getValue = self:getBaseSpeed() - self:getSpeed() + changeValue
			self:changeSpeed(getValue)
			if getAttr.percent > 0 or math.abs(getAttr.value) > 0 then
				repeatEffect(self:getId(), 81, 1000, removeTimer)
			elseif self:getId() ~= getAttr.casterId then
				self:getPosition():sendMagicEffect(82)
			end
		end
		
	elseif attribute == "Provocation" then
		if getAttr.casterId < 1 then return end
		local getTarget = Creature(getAttr.casterId)
		if not getTarget then return end
		if Player(self) then return end
		self:setTarget(getTarget)
		self:setFollowCreature(getTarget)
	elseif attribute == "Ghost" then
		self:setGhostMode(true)
		if getAttr.condition and getAttr.condition.duration then
		local removeTimer = getAttr.condition.duration
			if getAttr.condition.immune then
				removeTimer = getAttr.condition.immune
			end
			stopEvent(creatureAfterGhost[self:getId()])
			creatureAfterGhost[self:getId()] = nil
			creatureAfterGhost[self:getId()] = addEvent(afterGhost, getAttr.condition.duration, self:getId())
					stopEvent(globalDurationTimer[self:getId().."/"..attribute.."/"..getAttr.spellSV.."/all"])
					globalDurationTimer[self:getId().."/"..attribute.."/"..getAttr.spellSV.."/all"] = nil
					globalDurationTimer[self:getId().."/"..attribute.."/"..getAttr.spellSV.."/all"] = addEvent(afterTimeDuration, removeTimer,self:getId(),attribute )

		end
	
	end
end

local repeatEffectPlayers = {}
function repeatEffect(playerId, effectId, delay, duration)
	duration = duration - delay
	--if duration < 1 then return end
	local getPlayer = Player(playerId)
	if not getPlayer then return end
	getPlayer:getPosition():sendMagicEffect(effectId)
	if repeatEffectPlayers[playerId] then
		stopEvent(repeatEffectPlayers[playerId])
		repeatEffectPlayers[playerId] = nil
	end
	if math.abs(getPlayer:getBaseSpeed() - getPlayer:getSpeed()) > 20 then
		repeatEffectPlayers[playerId] = addEvent(repeatEffect, delay, playerId, effectId, delay, duration)
	end
end
function getGlobalAnimation(animationName, creature)
	if type(animationName) ~= "string" then return nil end 
	local getConfig = Wikipedia.creatureAnimations[animationName]
	if not creature then return getConfig end
	local getVoc = (creature:isPlayer() and creature:getVocation() and creature:getVocation():getName()) or (creature:isMonster() and creature:getName())
	if not getVoc then return nil end
	
	if getConfig[getVoc] then return getConfig[getVoc] end
	return nil
end
function Creature:canAttack(target)
if self == target then return RETURNVALUE_NOERROR end
if target and target:isInGhostMode() then return RETURNVALUE_NOTPOSSIBLE end
	if target and target:getPosition().z ~= self:getPosition().z then return RETURNVALUE_NOTPOSSIBLE end
	if target and Tile(target:getPosition()) and Tile(target:getPosition()):hasFlag(TILESTATE_PROTECTIONZONE) then return RETURNVALUE_NOTPOSSIBLE end
	if target and self:isMonster() and (self:getMaster() ~= nil and self:getMaster() == target:getMaster() or self:getMaster() == target) then return RETURNVALUE_NOTPOSSIBLE end
if target and self:isPlayer() and self == target:getMaster() then return RETURNVALUE_NOTPOSSIBLE end
		if target and Wikipedia.ALLOW_ATTACK_ONLY_TARGET and (target:isPlayer() and self:isPlayer()) and ( not self:getTarget() or self:getTarget() ~= target ) then return RETURNVALUE_NOTPOSSIBLE end
	if target and target:isPlayer() and self:isPlayer() and target:getParty() and self:getParty() and target:getParty():getLeader() == self:getParty():getLeader() then return RETURNVALUE_NOTPOSSIBLE end
	
	if target and ((self:isMonster() and target:isPlayer()) or (target:isMonster() and self:isPlayer())) then
		local getPos = (self:isMonster() and self:getName()) or (target:isMonster() and target:getName())
		if not growingEventHolder["Quest_onTargetChange"] then
			growingEventHolder["Quest_onTargetChange"] = {}
		end
		local getEvents = growingEventHolder["Quest_onTargetChange"][getPos]
		if not getEvents then
			for i, child in pairs(Wikipedia.Quests) do
				if child.questType == "Saga" then
					for _i, _child in pairs(child.tasks) do
						if _child.condition == "killMonster" then
							local findedName = false
							for __i, __child in pairs(_child.killNeed) do
								if getPos:lower() == __child[1]:lower() then
									findedName = true
								end
							end
							if findedName then
								if not growingEventHolder["Quest_onTargetChange"][getPos] then
									growingEventHolder["Quest_onTargetChange"][getPos] = {}
								end
								local getChild = deepCopy(_child)
								getChild.questName = child.questName
								getChild.questId = child.questId
								getChild.questNumber = _i
								table.insert(growingEventHolder["Quest_onTargetChange"][getPos], getChild)
							end
						end
					end
				end
			end
		end
		getEvents = growingEventHolder["Quest_onTargetChange"][getPos]
		if getEvents and #getEvents > 0 then
			local getHolder = (self:isMonster() and target) or (target:isMonster() and self)
			for i,child in pairs(getEvents) do
				local getKey = QuestBeginStorage + child.questId
				if ((getHolder:getStorageValue(getKey) == child.questNumber) or (child.questNumber <= 0 and getHolder:getStorageValue(getKey) <= child.questNumber)) then
					return RETURNVALUE_NOERROR
				end
			end
			return RETURNVALUE_NOTPOSSIBLE
		end
	end
	
	return RETURNVALUE_NOERROR
end
creatureSpeedReset = {}
function resetSpeed(creatureId)
	stopEvent(creatureSpeedReset[creatureId])
	creatureSpeedReset[creatureId] = nil
	local getCreature = Creature(creatureId)
	if getCreature then
		getCreature:changeSpeed(getCreature:getBaseSpeed() - getCreature:getSpeed())
	end
end

removeCustomBuffReset = {}
function removeCustomBuff(creatureId, attributeName)
	stopEvent(removeCustomBuffReset[creatureId])
	removeCustomBuffReset[creatureId] = nil
	local getCreature = Creature(creatureId)
	if getCreature then
		getCreature:removeCustomAttribute(attributeName)
	end
end



CREATURE_INFORMATION = 220
			
function Player.getPointsBalance(self)
	-- resultId = db.storeQuery("SELECT `"..GameStore.tableName.."` FROM `"..GameStore.table.."` WHERE `id` = " .. self:getAccountId())
	-- if not resultId then return 0 end
	-- return result.getDataInt(resultId, ""..GameStore.tableName.."")
	
	
	return POINTS_SYSTEM:getAlphaPoints(self)
	
end

function Player.setPointsBalance(self, points)
	db.query("UPDATE `"..GameStore.table.."` SET `"..GameStore.tableName.."` = " .. points .. " WHERE `id` = " .. self:getAccountId())
	return true
end

function Player.canRemovePoints(self, points)
	if self:getPointsBalance() < points then
		return false
	end
	return true
end

function Player.removePointsBalance(self, points)
	if self:canRemovePoints(points) then
		return self:setPointsBalance(self:getPointsBalance() - points)
	end

	return false
end

function Player.addPointsBalance(self, points, update)
	self:setPointsBalance(self:getPointsBalance() + points)
	if update then sendPointBalanceUpdating(self, true) end
	return true
end

function Creature:sendAttributes(player)
	local collectedSpells = {}
	local usedTalents = 0
	local unlockedTalents = 0
	local maxedTalents = 0

	local sendTable = {
		uid = self:getId(),
		marks = (self:isMonster() and self:returnCustomAttribute("monsterMark")) or	(self:isPlayer() and self:returnCustomAttribute("playerMark")),
		actualBar = self:returnCustomAttribute("actualBar"),
		spell_indicator = (self:returnCustomAttribute("spell_indicator")),
		spell_mouseInteraction = (self:returnCustomAttribute("spell_mouseInteraction")),
		spell_mouseTracking = (self:returnCustomAttribute("spell_mouseTracking")),
	}

	if self:isPlayer() then
		sendTable.pointsBalance = self:getPointsBalance()
		sendTable.chests = {} 
		
        
		
		local t = storeIndex[1].offers
		for i, v in ipairs(t) do
		    sendTable.chests[i] = {}
			sendTable.chests[i].ammount = self:getChestCount(v.id)--math.max(0, self:getStorageValue(Wikipedia.storageTable["Chest" .. i]))
			sendTable.chests[i].icon = v.icon
			if v.materials then
			    sendTable.chests[i].materials = v.materials
			end
		    --sendTable.chests[i] = {ammount = self:getStorageValue(Wikipedia.storageTable["Chest"]), icon="/images/game/store/chest_wooden_64"}
		    --sendTable.chests[i] = {ammount = self:getStorageValue(Wikipedia.storageTable["Chest2"]), icon="/images/game/store/chest_bronze_64"}
		    --sendTable.chests[3] = {ammount = self:getStorageValue(Wikipedia.storageTable["Chest3"]), icon="/images/game/store/chest_artifact_64"}
		end
		
	end
	
	json.sendJSON(player, CREATURE_INFORMATION, "sendCreatureInformation", sendTable)		
end
