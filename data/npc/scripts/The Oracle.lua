local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local vocation = {}
local town = {}
local destination = {}

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local function greetCallback(cid)
	local player = Player(cid)
	local level = player:getLevel()
	if level < 22 then
		npcHandler:say("HUMAN CHILD! COME BACK WHEN YOU HAVE GROWN UP, minimum level 22 , maximum 22!", cid)
		return false
	elseif level > 22 then
		npcHandler:say(player:getName() .. ", I CAN'T LET YOU LEAVE - YOU ARE TOO STRONG ALREADY! YOU CAN ONLY LEAVE WITH LEVEL 22 LOWER.", cid)
		return false
	elseif player:getVocation():getId() > 0 then
		npcHandler:say("YOU ALREADY HAVE CHOSSEN YOUR PATH!", cid)
		return false
	end
	return true
end

local function creatureSayCallback(cid, type, msg)
	local vocations = {
		["Assassin"] = { vocid = 11, vocName = "Assassin", description = " Assassin: \n Type: Physical/Melee \n Role: Damage \n Attack Speed: High \n Difficulty: Medium \n WeaponType: Knife and Spears" },
		["Berseker"] = { vocid = 23, vocName = "Berseker", description = " Berseker: \n Type: Physical/Melee \n Role: Damage \n Attack Speed: Medium \n Difficulty: Low \n WeaponType: Axe" },
		["Sorcerer"] = { vocid = 1, vocName = "Sorcerer", description = " Sorcerer: \n Type: Magic/Ranged \n Role: Damage \n Attack Speed: Low \n Difficulty: Normal \n WeaponType: Wand" },
		["Paladin"] = { vocid = 3, vocName = "Paladin", description = " Paladin: \n Type: Physical/Ranged \n Role: Damage \n Attack Speed: High \n Difficulty: Easy \n WeaponType: Crossbows" },
		["Venomic"] = { vocid = 13, vocName = "Venomic", description = " Venomic: \n Type: Magic/Ranged \n Role: Damage~Support \n Attack Speed: Low \n Difficulty: Low~Medium \n WeaponType: Rods and Wands" },
		["Archer"] = { vocid = 9, vocName = "Archer", description = " Archer: \n Type: Physical/Ranged \n Role: Damage \n Attack Speed: High \n Difficulty: Low \n WeaponType: Bow" },
		["Knight"] = { vocid = 4, vocName = "Knight", description = " Knight: \n Type: Physical/Melee \n Role: Damage/Tank \n Attack Speed: Medium \n Difficulty: High \n WeaponType: Melee Weapons" },
		["Druid"] = { vocid = 2, vocName = "Druid", description = " Druid: \n Type: Magic/Ranged \n Role: Support/Damage \n Attack Speed: Low \n Difficulty: Hard \n WeaponType: Rod" },
		["Tank"] = { vocid = 21, vocName = "Tank", description = " Tank: \n Type: Physical/Melee \n Role: Tank \n Attack Speed: Medium \n Difficulty: High \n WeaponType: Melee Weapons" },
		["Mage"] = { vocid = 17, vocName = "Mage", description = " Mage: \n Type: Magic/Ranged \n Role: Damage \n Attack Speed: Low \n Difficulty: Low \n WeaponType: Wands" },
		["Summoner"] = { vocid = 15, vocName = "Summoner", description = " Summoner: \n Type: Magic/Ranged \n Role: Damage \n Attack Speed: Medium \n Difficulty: High \n WeaponType: Wands" },
		--["Botanist"] = { vocid = 19, vocName = "Botanist", description = " Botanist: \n Type: Magic/Ranged \n Role: Damage \n Attack Speed: Medium \n Difficulty: Medium~High \n WeaponType: Rods" },
		--["Guru"] = { vocid = 25, vocName = "Guru", description = "ClassName \n A tank class with ranged spells and fast atk speed" },
	}
	
	local id = 19674

	local destination = Position(354, 2265, 10)

	
	local function oracleStart(playerId)
		local player = Player(cid)
		local choosingVocation
		function Player:sendVocations()
			local function buttonAccept(button, choice)
				choosingVocation = choice.text
				if choice.text == vocations[choice.text].vocName then
					player:Vocation()
				end
			end
	
			vocation = vocation
			local window = ModalWindow {
				title = "-------------Choose a vocation-------------",
				message = "Once you choose you will be challenged in many ways to test if you are really capable of this vocation.",
			}
			window:addButton("Ok", buttonAccept)
			window:addButton("Exit")
	
			if player:getVocation():getId() == VOCATION_NONE then
				for i in pairs(vocations) do
					window:addChoice(vocations[i].vocName)
				end
			else
				player:say("I already did this")
				return false
			end
			window:setDefaultEnterButton("Ok")
			window:setDefaultEscapeButton("Exit")
			window:sendToPlayer(self)
		end
		function Player:Vocation()
			local vocation = choosingVocation
			local function buttonAccept(button, choice)
				if button.text == "Yes" then
					if player:getLevel() == 22 then
				--		rookgardSystem:setOnRookgard(player, true)
				--		player:saveStatement()
						player:setVocation(vocations[vocation].vocid)
						print(player:getName().. " choosed vocation: " .. vocations[vocation].vocName)
						player:setTown(1)
						player:teleportTo(destination)
						player:getPosition():sendMagicEffect(380)
						player:say(vocation)
						player:sendTextMessage(MESSAGE_INFO_DESCR, "Go Take your rewards, and have fun! Also don't forget command /bosses !!!")
						destination:sendMagicEffect(379)
					elseif player:getLevel() < 22 then
						player:say("Im still too weak to enter this quest")
					elseif player:getLevel() > 22 then
						player:say('Im to strong for this quest')
						player:getPosition():sendMagicEffect(CONST_ME_POFF)
					end
				elseif button.text == "Back" then
					player:sendVocations()
				end
			end
			if vocation == nil then
				player:sendCancelMessage("Time Expired, try again.")
			end
	
			local window = ModalWindow {
				title = vocations[vocation].vocName,
				message = vocations[vocation].description,
			}
	
			window:addButton("Yes", buttonAccept)
			window:addButton("Back", buttonAccept)
			window:addButton("Cancel")
	
			window:setDefaultEnterButton("Yes")
			window:setDefaultEscapeButton("Cancel")
	
			window:sendToPlayer(self)
		end
		player:sendVocations()
	end
	if not npcHandler:isFocused(cid) then
		return false
	end

	if msgcontains(msg, "yes") and npcHandler.topic[cid] == 0 then
		npcHandler:say("Hello HUMAN, today might be the lucky day about your choosen {path}", cid)
		npcHandler.topic[cid] = 1
	elseif npcHandler.topic[cid] == 1 then
		if msgcontains(msg, "path") then
			oracleStart()
			npcHandler:releaseFocus(cid)
			npcHandler:resetNpc(cid)
			--[[ town[cid] = 1
			destination[cid] = Position(939, 1060, 0)
			npcHandler:say("THE PATH YOO WILL TAKE WILL TELEPORT YOU VERY FAR FROM OUR HOME LAND, AND TO PROVE THAT YOU ARE WORTHY YOU NEED FIND YOUR HOME! PICK PROFESSION HAVE YOU CHOSEN: {KNIGHT}, {TANK}, {BERSERKER}, {PALADIN}, {ASSASSIN}, {ARCHER}, {SORCERER}, {MAGE}, {BOTANIST}, {DRUID}, {VENOMIC}, {SUMMONER}, OR {GURU} and get ready to be teleported far far from HOME LAND?", cid)
			npcHandler.topic[cid] = 2 --]]
		end
	end
	return true
end

local function onAddFocus(cid)
	town[cid] = 0
	vocation[cid] = 0
	destination[cid] = 0
end

local function onReleaseFocus(cid)
	town[cid] = nil
	vocation[cid] = nil
	destination[cid] = nil
end

npcHandler:setCallback(CALLBACK_ONADDFOCUS, onAddFocus)
npcHandler:setCallback(CALLBACK_ONRELEASEFOCUS, onReleaseFocus)

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
