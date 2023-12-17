local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(creature, msgtype, msg)      npcHandler:onCreatureSay(creature, msgtype, msg)    end
function onThink()                          npcHandler:onThink()                        end

local voices = { {text = "Runes, health and mana potions for sale! you can simply click me with mouse to open trade!"} }
npcHandler:addModule(VoiceModule:new(voices))

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

keywordHandler:addKeyword({'stuff'}, StdModule.say, {npcHandler = npcHandler, text = 'Just ask me for a {trade} to see my offers.'})
keywordHandler:addAliasKeyword({'wares'})
keywordHandler:addAliasKeyword({'offer'})

shopModule:addBuyableItem({'spellbook'}, 2175, 1500, 'spellbook')
shopModule:addBuyableItem({'magic lightwand'}, 2162, 4000, 'magic lightwand')

shopModule:addBuyableItem({'health potion'}, 7618, 200, 1, 'health potion')
shopModule:addBuyableItem({'mana potion'}, 7620, 250, 1, 'mana potion')
shopModule:addBuyableItem({'strong health'}, 7588, 400, 1, 'strong health potion')
shopModule:addBuyableItem({'strong mana'}, 7589, 500, 1, 'strong mana potion')
shopModule:addBuyableItem({'great health'}, 7591, 800, 1, 'great health potion')
shopModule:addBuyableItem({'great mana'}, 7590, 1000, 1, 'great mana potion')
shopModule:addBuyableItem({'great spirit'}, 8472, 850, 1, 'great spirit potion')
shopModule:addBuyableItem({'ultimate health'}, 8473, 1200, 1, 'ultimate health potion')

shopModule:addBuyableItem({'ultimate mana'}, 26029, 2000, 1, 'great mana potion')
shopModule:addBuyableItem({'ultra mana'}, 41266, 2500, 1, 'ultra mana rune')
shopModule:addBuyableItem({'iceverius mana'}, 41265, 3000, 1, 'iceverius mana rune')
shopModule:addBuyableItem({'pandorus mana'}, 41189, 4000, 1, 'pandorus mana rune')
shopModule:addBuyableItem({'ultimate spirit'}, 26030, 1700, 1, 'great spirit potion')
shopModule:addBuyableItem({'ultra spirit'}, 41169, 2200, 1, 'ultra spirit rune')
shopModule:addBuyableItem({'iceverius spirit'}, 41168, 2700, 1, 'iceverius spirit rune')
shopModule:addBuyableItem({'pandorus spirit'}, 41195, 3700, 1, 'pandorus spirit rune')
shopModule:addBuyableItem({'ultimate health'}, 26031, 2400, 1, 'ultimate health potion')
shopModule:addBuyableItem({'ultra health'}, 41177, 2900, 1, 'ultra health rune')
shopModule:addBuyableItem({'iceverius health'}, 41176, 3400, 1, 'iceverius health rune')
shopModule:addBuyableItem({'pandorus health'}, 41203, 4400, 1, 'pandorus health potion')


shopModule:addBuyableItem({'antidote potion'}, 8474, 500, 1, 'antidote potion')

shopModule:addBuyableItem({'ultimate healing'}, 2273, 1750, 1, 'ultimate healing rune')
shopModule:addBuyableItem({'magic wall'}, 2293, 3500, 3, 'magic wall rune')
shopModule:addBuyableItem({'destroy field'}, 2261, 450, 3, 'destroy field rune')
shopModule:addBuyableItem({'heavy magic missile'}, 2311, 1200, 10, 'heavy magic missile rune')
shopModule:addBuyableItem({'great fireball'}, 2304, 1800, 4, 'great fireball rune')
shopModule:addBuyableItem({'avalanche'}, 2274, 1800, 4, 'avalanche rune')
shopModule:addBuyableItem({'thunderstorm'}, 2315, 1800, 4, 'thunderstorm rune')
shopModule:addBuyableItem({'explosion'}, 2313, 2500, 6, 'explosion rune')
shopModule:addBuyableItem({'Sudden death'}, 2263, 3500, 3, 'sudden death rune')
shopModule:addBuyableItem({'Master death'}, 2268, 7000, 1, 'master death rune')
shopModule:addBuyableItem({'paralyze'}, 2278, 7000, 1, 'paralyze rune')
shopModule:addBuyableItem({'animate dead'}, 2316, 3750, 1, 'animate dead rune')
shopModule:addBuyableItem({'convince creature'}, 2290, 800, 1, 'convince creature rune')
shopModule:addBuyableItem({'chameleon'}, 2291, 2100, 1, 'chameleon rune')
shopModule:addBuyableItem({'disintegrate'}, 2310, 800, 3, 'disintegrate rune')
shopModule:addBuyableItem({'blankrune'}, 2260, 550, 1, 'blank rune')
shopModule:addBuyableItem({'ancientblankrune'}, 41248, 11000, 1, 'ancient blank rune')

function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	local player = Player(cid)
	local vocationId = player:getVocation():getId()
	local items = {
		[1] = 2190,
		[2] = 2182,
		[5] = 2190,
		[6] = 2182
	}

	if msgcontains(msg, 'first rod') or msgcontains(msg, 'first wand') then
		if table.contains({1, 2, 5, 6}, vocationId) then
			if player:getStorageValue(PlayerStorageKeys.firstRod) == -1 then
				selfSay('So you ask me for a {' .. ItemType(items[vocationId]):getName() .. '} to begin your adventure?', cid)
				npcHandler.topic[cid] = 1
			else
				selfSay('What? I have already gave you one {' .. ItemType(items[vocationId]):getName() .. '}!', cid)
			end
		else
			selfSay('Sorry, you aren\'t a druid either a sorcerer.', cid)
		end
	elseif msgcontains(msg, 'yes') then
		if npcHandler.topic[cid] == 1 then
			player:addItem(items[vocationId], 1)
			selfSay('Here you are young adept, take care yourself.', cid)
			player:setStorageValue(PlayerStorageKeys.firstRod, 1)
		end
		npcHandler.topic[cid] = 0
	elseif msgcontains(msg, 'no') and npcHandler.topic[cid] == 1 then
		selfSay('Ok then.', cid)
		npcHandler.topic[cid] = 0
	end

	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
