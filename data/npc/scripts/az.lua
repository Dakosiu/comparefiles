local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end

function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end

function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end

function onThink() npcHandler:onThink() end

local NPC_CITIES = {
	[1] = {
		name = 'thais',
		cost = 160,
		effectBefore = 20,
		effectAfter = 21,
		phraseFirst = "Hello World",
		phraseNegative = "Bye World",
		position = Position(32310, 32210, 6),
		direction = 1, -- ! 0, Up > 1, Right > 2, Down > 3, Left <
		cooldown = 30, -- ? in Seconds
		activated = false,
	},
	[2] = {
		name = 'carlin',
		cost = 110,
		effectBefore = CONST_ME_TELEPORT,
		effectAfter = CONST_ME_TELEPORT,
		phraseFirst = "Do you seek a passage to Carlin for 110 gold?",
		phraseNegative = "We would like to serve you some time.",
		position = Position(32387, 31820, 6),
		direction = 3, -- ! 0, Up > 1, Right > 2, Down > 3, Left <
		activated = true,
	},
	[3] = {
		name = 'ab\'dendriel',
		cost = 130,
		effectBefore = CONST_ME_TELEPORT,
		effectAfter = CONST_ME_TELEPORT,
		phraseFirst = "Do you seek a passage to Ab'Dendriel for 130 gold?",
		phraseNegative = "We would like to serve you some time.",
		position = Position(32734, 31668, 6),
		direction = 1, -- ! 0, Up > 1, Right > 2, Down > 3, Left <
		cooldown = 30, -- ? in Seconds
		activated = true,
	},
	[4] = {
		name = 'edron',
		cost = 110,
		effectBefore = CONST_ME_TELEPORT,
		effectAfter = CONST_ME_TELEPORT,
		phraseFirst = "Do you seek a passage to Edron for 110 gold?",
		phraseNegative = "We would like to serve you some time.",
		position = Position(33175, 31764, 6),
		direction = 1, -- ! 0, Up > 1, Right > 2, Down > 3, Left <
		cooldown = 30, -- ? in Seconds
		activated = true,
	},
	[5] = {
		name = 'darashia',
		cost = 110,
		effectBefore = CONST_ME_TELEPORT,
		effectAfter = CONST_ME_TELEPORT,
		phraseFirst = "Do you seek a passage to Darashia for 110 gold?",
		phraseNegative = "We would like to serve you some time.",
		position = Position(1024, 1024, 7),
		direction = 1, -- ! 0, Up > 1, Right > 2, Down > 3, Left <
		cooldown = 30, -- ? in Seconds
		activated = true,
	},
	[6] = {
		name = 'venore',
		cost = 110,
		effectBefore = CONST_ME_TELEPORT,
		effectAfter = CONST_ME_TELEPORT,
		phraseFirst = "Do you seek a passage to Venore for 110 gold?",
		phraseNegative = "We would like to serve you some time.",
		position = Position(32954, 32022, 6),
		direction = 1, -- ! 0, Up > 1, Right > 2, Down > 3, Left <
		cooldown = 30, -- ? in Seconds
		activated = true,
	},
	[7] = {
		name = 'ankrahmun',
		cost = 110,
		effectBefore = CONST_ME_TELEPORT,
		effectAfter = CONST_ME_TELEPORT,
		phraseFirst = "Do you seek a passage to Ankrahmun for 110 gold?",
		phraseNegative = "We would like to serve you some time.",
		position = Position(32954, 32022, 6),
		direction = 1, -- ! 0, Up > 1, Right > 2, Down > 3, Left <
		cooldown = 30, -- ? in Seconds
		activated = true,
	}
}

local function creatureSayCallback(cid, type, msg)
	local player = Player(cid)
	for _, data in pairs(NPC_CITIES) do
		if data.activated and msg == "bring me to " .. data.name then
			npcHandler:addFocus(cid)
			local townPos = data.position
			local playerpos = player:getPosition()
			if player:getStorageValue(TravelCooldown) < os.time() then
				if player:removeMoney(data.cost) then
					player:teleportTo(townPos)
					playerpos:sendMagicEffect(data.effectBefore)
					townPos:sendMagicEffect(data.effectAfter)
					player:setDirection(data.direction)
					player:setStorageValue(TravelCooldown, os.time() + data.cooldown)
				end
			else
				npcHandler:say("The ship is not ready yet, wait a bit.", cid)
				npcHandler:releaseFocus(cid)
			end
			return true
		elseif msg == "kick me out" then
			local kickPos = Position(1024, 1030, 7)
			npcHandler:addFocus(cid)
			player:teleportTo(kickPos)
			kickPos:sendMagicEffect(CONST_ME_TELEPORT)
			return true
		end
	end
	return true
end


for _, data in pairs(NPC_CITIES) do
	if data.activated then
		local node = keywordHandler:addKeyword({ data.name }, StdModule.say,
			{
				npcHandler = npcHandler,
				onlyFocus = true,
				text = data.phraseFirst,
			})
		node:addChildKeyword({ 'yes' }, StdModule.travel,
			{
				npcHandler = npcHandler,
				premium = false,
				cost = data.cost,
				destination = data.pos,
				direction = data.direction,
				cooldown = data.cooldown
			})
		node:addChildKeyword({ 'no' }, StdModule.say,
			{ npcHandler = npcHandler, onlyFocus = true, reset = true, text = data.phraseNegative })
	end
end


npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
