-- local foods = {
    -- [2362] = {5, "Crunch."}, -- carrot
    -- [2666] = {15, "Munch."}, -- meat
    -- [2667] = {12, "Munch."}, -- fish
    -- [2668] = {10, "Mmmm."}, -- salmon
    -- [2669] = {17, "Munch."}, -- northern pike
    -- [2670] = {4, "Gulp."}, -- shrimp
    -- [2671] = {30, "Chomp."}, -- ham
    -- [2672] = {60, "Chomp."}, -- dragon ham
    -- [2673] = {5, "Yum."}, -- pear
    -- [2674] = {6, "Yum."}, -- red apple
    -- [2675] = {13, "Yum."}, -- orange
    -- [2676] = {8, "Yum."}, -- banana
    -- [2677] = {1, "Yum."}, -- blueberry
    -- [2678] = {18, "Slurp."}, -- coconut
    -- [2679] = {1, "Yum."}, -- cherry
    -- [2680] = {2, "Yum."}, -- strawberry
    -- [2681] = {9, "Yum."}, -- grapes
    -- [2682] = {20, "Yum."}, -- melon
    -- [2683] = {17, "Munch."}, -- pumpkin
    -- [2684] = {5, "Crunch."}, -- carrot
    -- [2685] = {6, "Munch."}, -- tomato
    -- [2686] = {9, "Crunch."}, -- corncob
    -- [2687] = {2, "Crunch."}, -- cookie
    -- [2688] = {2, "Munch."}, -- candy cane
    -- [2689] = {10, "Crunch."}, -- bread
    -- [2690] = {3, "Crunch."}, -- roll
    -- [2691] = {8, "Crunch."}, -- brown bread
    -- [2695] = {6, "Gulp."}, -- egg
    -- [2696] = {9, "Smack."}, -- cheese
    -- [2787] = {9, "Munch."}, -- white mushroom
    -- [2788] = {4, "Munch."}, -- red mushroom
    -- [2789] = {22, "Munch."}, -- brown mushroom
    -- [2790] = {30, "Munch."}, -- orange mushroom
    -- [2791] = {9, "Munch."}, -- wood mushroom
    -- [2792] = {6, "Munch."}, -- dark mushroom
    -- [2793] = {12, "Munch."}, -- some mushrooms
    -- [2794] = {3, "Munch."}, -- some mushrooms
    -- [2795] = {36, "Munch."}, -- fire mushroom
    -- [2796] = {5, "Munch."}, -- green mushroom
    -- [5097] = {4, "Yum."}, -- mango
    -- [6125] = {8, "Gulp."}, -- tortoise egg
    -- [6278] = {10, "Mmmm."}, -- cake
    -- [6279] = {15, "Mmmm."}, -- decorated cake
    -- [6393] = {12, "Mmmm."}, -- valentine's cake
    -- [6394] = {15, "Mmmm."}, -- cream cake
    -- [6501] = {20, "Mmmm."}, -- gingerbread man
    -- [6541] = {6, "Gulp."}, -- coloured egg (yellow)
    -- [6542] = {6, "Gulp."}, -- coloured egg (red)
    -- [6543] = {6, "Gulp."}, -- coloured egg (blue)
    -- [6544] = {6, "Gulp."}, -- coloured egg (green)
    -- [6545] = {6, "Gulp."}, -- coloured egg (purple)
    -- [6569] = {1, "Mmmm."}, -- candy
    -- [6574] = {5, "Mmmm."}, -- bar of chocolate
    -- [7158] = {15, "Munch."}, -- rainbow trout
    -- [7159] = {13, "Munch."}, -- green perch
    -- [7372] = {2, "Yum."}, -- ice cream cone (crispy chocolate chips)
    -- [7373] = {2, "Yum."}, -- ice cream cone (velvet vanilla)
    -- [7374] = {2, "Yum."}, -- ice cream cone (sweet strawberry)
    -- [7375] = {2, "Yum."}, -- ice cream cone (chilly cherry)
    -- [7376] = {2, "Yum."}, -- ice cream cone (mellow melon)
    -- [7377] = {2, "Yum."}, -- ice cream cone (blue-barian)
    -- [7909] = {4, "Crunch."}, -- walnut
    -- [7910] = {4, "Crunch."}, -- peanut
    -- [7963] = {60, "Munch."}, -- marlin
    -- [8112] = {9, "Urgh."}, -- scarab cheese
    -- [8838] = {10, "Gulp."}, -- potato
    -- [8839] = {5, "Yum."}, -- plum
    -- [8840] = {1, "Yum."}, -- raspberry
    -- [8841] = {1, "Urgh."}, -- lemon
    -- [8842] = {7, "Munch."}, -- cucumber
    -- [8843] = {5, "Crunch."}, -- onion
    -- [8844] = {1, "Gulp."}, -- jalapeño pepper
    -- [8845] = {5, "Munch."}, -- beetroot
    -- [8847] = {11, "Yum."}, -- chocolate cake
    -- [9005] = {7, "Slurp."}, -- yummy gummy worm
    -- [9114] = {5, "Crunch."}, -- bulb of garlic
    -- [9996] = {0, "Slurp."}, -- banana chocolate shake
    -- [10454] = {0, "Your head begins to feel better."}, -- headache pill
    -- [11246] = {15, "Yum."}, -- rice ball
    -- [11370] = {3, "Urgh."}, -- terramite eggs
    -- [11429] = {10, "Mmmm."}, -- crocodile steak
    -- [12415] = {20, "Yum."}, -- pineapple
    -- [12416] = {10, "Munch."}, -- aubergine
    -- [12417] = {8, "Crunch."}, -- broccoli
    -- [12418] = {9, "Crunch."}, -- cauliflower
    -- [12637] = {55, "Gulp."}, -- ectoplasmic sushi
    -- [12638] = {18, "Yum."}, -- dragonfruit
    -- [12639] = {2, "Munch."}, -- peas
    -- [13297] = {20, "Crunch."}, -- haunch of boar
    -- [15405] = {55, "Munch."}, -- sandfish
    -- [15487] = {14, "Urgh."}, -- larvae
    -- [15488] = {15, "Munch."}, -- deepling filet
    -- [16014] = {60, "Mmmm."}, -- anniversary cake
    -- [18397] = {33, "Munch."}, -- mushroom pie
    -- [19737] = {10, "Urgh."}, -- insectoid eggs
    -- [20100] = {15, "Smack."}, -- soft cheese
    -- [20101] = {12, "Smack."} -- rat cheese
-- }

-- local autoFeed = CreatureEvent("AutoFeed")

-- function autoFeed.onThink(player, interval)
    -- local foundFood, removeFood
    -- for itemid, food in pairs(foods) do
        -- if player:getItemCount(itemid) > 0 then
            -- foundFood, removeFood = food, itemid
            -- break
        -- end
    -- end
    -- if not foundFood then
        -- return true
    -- end
    -- local condition = player:getCondition(CONDITION_REGENERATION, CONDITIONID_DEFAULT)
    -- if condition and math.floor(condition:getTicks() / 1000 + foundFood[1] * 12) < 1200 then
        -- player:feed(foundFood[1] * 12)
        -- player:say(foundFood[2], TALKTYPE_MONSTER_SAY)
        -- player:removeItem(removeFood, 1)
    -- end
    -- return true
-- end

-- autoFeed:register()

-- local login = CreatureEvent("RegisterAutoFeed")

-- function login.onLogin(player)
    -- player:registerEvent("AutoFeed")
    -- return true
-- end

-- login:register()

AUTO_EAT_CONFIG = {
                    [3577] = { value = 15, text = "munch." },
					[3725] = { value = 15, text = "mucng." },
				  }
AUTO_EAT_SYSTEM = {}
AUTO_EAT_SYSTEM.storage = 23111
AUTO_EAT_SYSTEM.players = {}


local function feed(name)
    local player = Player(name)
 
    if not player then
        return true
    end

    local condition = player:getCondition(CONDITION_REGENERATION, CONDITIONID_DEFAULT)
    if condition and (condition:getTicks() / 1000) >= 1200 then
       return true 
	end
	
	local t = nil
	local id = nil
	for i, v in pairs(AUTO_EAT_CONFIG) do
	    if player:getItemCount(i) > 0 then
		   t = v
		   id = i
		   break
		end
    end
	
	if t then
	   player:feed(t.value)
       player:say(t.text, TALKTYPE_MONSTER_SAY)
	   player:removeItem(id, 1)
	end
	
	--addEvent(feed, 60 * 1000, name)
	AUTO_EAT_SYSTEM:addEvent(player)
end

function AUTO_EAT_SYSTEM:addEvent(player)
	local name = player:getName()
	AUTO_EAT_SYSTEM.players[name] = addEvent(feed, 60 * 1000, name)
end	

function AUTO_EAT_SYSTEM:removeEvent(player)
	local name = player:getName()
	if not AUTO_EAT_SYSTEM.players[name] then
	   return
	end
	stopEvent(AUTO_EAT_SYSTEM.players[name])
	AUTO_EAT_SYSTEM.players[name] = nil
end


local login = CreatureEvent("RegisterAutoFeed")
function login.onLogin(player)
    if player:getStorageValue(AUTO_EAT_SYSTEM.storage) == 1 then
       AUTO_EAT_SYSTEM:addEvent(player)
	end
    return true
end
login:register()

local autoFeed = TalkAction("!autofeed", "/autofeed", "!autofood", "/autofood", "!autoeat", "/autoeat", "!autoeating", "/autoeating")
function autoFeed.onSay(player, words, param)
  	   
	if param == "on" then
	   if player:getStorageValue(AUTO_EAT_SYSTEM.storage) == 1 then
	      player:sendCancelMessage("You have already enabled auto eating.")
		  return false
	   end
	      player:sendTextMessage(MESSAGE_INFO_DESCR, "You have enabled auto eating.")
		  AUTO_EAT_SYSTEM:addEvent(player)
          player:setStorageValue(AUTO_EAT_SYSTEM.storage, 1)
		  return false
	elseif param == "off" then
	   if player:getStorageValue(AUTO_EAT_SYSTEM.storage) == 0 then
	      player:sendCancelMessage("You have already disabled auto eating.")
		  return false
	   end
	      player:sendTextMessage(MESSAGE_INFO_DESCR, "You have disabled auto eating.")
		  AUTO_EAT_SYSTEM:removeEvent(player)
          player:setStorageValue(AUTO_EAT_SYSTEM.storage, 0)
		  return false   
	else
        player:sendCancelMessage("Invalid param.")	
    end
	
    return false
end
autoFeed:separator(" ")
autoFeed:register()
