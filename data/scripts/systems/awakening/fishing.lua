
local fishing = Action()
local waterIds = {493, 4608, 4609, 4610, 4611, 4612, 4613, 4614, 4615, 4616, 4617, 4618, 4619, 4620, 4621, 4622, 4623, 4624, 4625, 7236, 10499, 15401, 15402}
local lavaIds = {599, 600, 601, 23846, 23848, 23849, 23850, 23851, 23857, 23858, 23859, 23860, 23868, 23861, 23862, 23863, 23864, 23865, 23866, 23867}
local swampIds = {4691, 4692, 2693, 2694, 2695, 2696, 2697, 2698, 2699, 2700, 2701, 2702, 2703, 2704, 2705, 2706, 2707, 2708, 2709, 2710, 2711, 2712, 4749, 4750, 4751, 4752, 4753, 4754, 4755}
local tarIds = {708}

--[[
level - Level required to catch the fish.
fishing - Fishing level required to catch the fish.
vowel - If the name starts with a vowel set this to true. This is used when broadcasting a message to change a to an.
chance - Chance to catch the fish.
key - Used to store how many fish a player has caught
scroll - If players must have a fishing scroll active to catch the fish
bowlable - Monster is able to be bowled (You will need the bowl code that I release later on set to false for now)
serverBC - Broadcast the catch to all players online
broadcast - The message that will be broadcasted
]]--

local waterMonsters = {
    [1] = {name = "Shiversleep", level = 35, vowel = true, fishing = 35, chance = 200, key = 19, scroll = true, bowlable = true, serverBC = true, broadcast = "|PLAYERNAME| has caught an ???!"},
    [16] = {name = "Sharptooth", level = 25, fishing = 30, chance = 1500000, key = 4, scroll = false, bowlable = false, serverBC = false, broadcast = "Tyria The Sea Goddess has been angered by |PLAYERNAME|!"},
    [17] = {name = "Shark", level = 20, fishing = 25, chance = 2000000, key = 3, scroll = true, bowlable = false, serverBC = false, broadcast = "A wild Krabby has appeared. Krabby is attacking |PLAYERNAME|!"},
    [18] = {name = "Crab", level = 15, fishing = 20, chance = 2500000, key = 2, scroll = false, bowlable = false, serverBC = false, broadcast = "A Hydros has been caught by |PLAYERNAME|!"},
    [19] = {name = "Fish", vowel = true, level = 10, fishing = 15, chance = 5000000, key = 1, scroll = false, bowlable = false}
}

local lavaMonsters = {
    [1] = {name = "Volcanis", level = 7500, fishing = 145, chance = 20000, key = 43, scroll = true, bowlable = true, serverBC = true, broadcast = "How dare you |PLAYERNAME|. Do you think lava is some kind of TOY?!? I will show you how it feels to be burned. I Volcanis will send you to a FIERY GRAVE"},
    [2] = {name = "Molten Fury", level = 7000, fishing = 140, chance = 20000, key = 42, scroll = true, bowlable = true, serverBC = true, broadcast = "|PLAYERNAME| flesh has been seared! A Molten Fury has appeared to scorch the lands!"},
    [3] = {name = "Lavos", level = 6500, fishing = 140, chance = 20000, key = 41, scroll = true, bowlable = true, serverBC = true, broadcast = "The horrid smell of smoke has began to linger around the vicinity of |PLAYERNAME|. Lavos has come for his prey!"},
    [4] = {name = "Pyria", level = 6000, fishing = 140, chance = 20000, key = 40, scroll = false, bowlable = true, serverBC = true, broadcast = "Pyria The Incinerator has entered the mortal realm to immolate |PLAYERNAME|!"},
    [5] = {name = "Hephaestus", level = 5500, fishing = 135, chance = 20000, key = 39, scroll = false, bowlable = true, serverBC = true, broadcast = "A barrage of arrows zooms past |PLAYERNAME| head. Hephaestus has come to test |PLAYERNAME| might!"},
    [6] = {name = "Krakatoa", level = 5000, fishing = 130, chance = 20000, key = 38, scroll = false, bowlable = true, serverBC = true, broadcast = "A Krakatoa has descended upon |PLAYERNAME|!"},
    [7] = {name = "Onyx", level = 4500, fishing = 125, vowel = true, chance = 20000, key = 37, scroll = true, bowlable = true, serverBC = true, broadcast = "The ground around |PLAYERNAME| is torn asunder by a great force from below. Onyx has been unsealed!"},
    [8] = {name = "Engorged Magmaworm", level = 4000, vowel = true, fishing = 125, chance = 20000, key = 36, scroll = false, serverBC = true, bowlable = true, broadcast = "|PLAYERNAME| has caused the lava to spit out a blazing hot Engorged Magmaworm!"},
    [9] = {name = "Chimera", level = 3500, fishing = 120, chance = 20000, key = 35, scroll = true, bowlable = true, serverBC = true, broadcast = "Chimera, the three-headed demon has arose from Hell to obliterate |PLAYERNAME|!"},
    [10] = {name = "Charmander", level = 3000, fishing = 120, chance = 20000, key = 34, scroll = false, bowlable = true, serverBC = true, broadcast = "A wild Charmander appeared! |PLAYERNAME| used tail whip!"},
    [11] = {name = "Ember of Draconis", level = 2500, vowel = true, fishing = 120, chance = 20000, key = 33, scroll = true, bowlable = false, serverBC = false, broadcast = "|PLAYERNAME| has caught an Ember of Draconis"},
    [12] = {name = "Firebat", level = 2500, fishing = 120, chance = 20000, key = 22, scroll = false, bowlable = false, serverBC = false, broadcast = "|PLAYERNAME| is being lit up by a Firebat!"},
    [13] = {name = "Unstable Pyroclast", level = 2000, vowel = true, fishing = 120, chance = 20000, key = 32, scroll = false, bowlable = false, serverBC = false, broadcast = "|PLAYERNAME| has awoken an Unstable Pyroclast!"},
    [14] = {name = "Molten Magma Crab", level = 1500, fishing = 120, chance = 20000, key = 31, scroll = false, bowlable = false, serverBC = false, broadcast = "A Molten Magma Crab has appeared before |PLAYERNAME|!"},
    [15] = {name = "Magma Minion", level = 1000, fishing = 120, chance = 20000, key = 30, scroll = false, bowlable = false}
}

local swampMonsters = {
    [1] = {name = "Swamp Blob", level = 1000, vowel = true, fishing = 120, chance = 100000, key = 60, scroll = true, bowlable = true, serverBC = false, broadcast = "|PLAYERNAME| has caught an Swamp Blob!"},
}

local tarMonsters = {
    [1] = {name = "???", level = 10000, vowel = true, fishing = 140, chance = 200, key = 80, scroll = true, bowlable = true, serverBC = true, broadcast = "|PLAYERNAME| has caught an ???!"},
}

-- Chance to catch monster is (catchMonsterRandom / difficulty) [[Difficulty shown below]]
local catchMonstersRandom = 1000000000

-- Effects shown on water, lava, ect when a players casts (based on the item used to fish)--
local castEffects = {
    [1] = {[2580] = CONST_ME_LOSEENERGY, [10223] = CONST_ME_WATERSPLASH}, -- Water Effects
    [2] = {[2580] = CONST_ME_HITBYFIRE, [10223] = CONST_ME_FIREAREA}, -- Lava Effects
    [3] = {[2580] = CONST_ME_ENERGYHIT, [10223] = CONST_ME_ENERGYAREA}, -- Swamp Effects
    [4] = {[2580] = CONST_ME_LOSEENERGY, [10223] = CONST_ME_WATERSPLASH} -- Tar Effects
}

function fishing.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if not target or not target.itemid then
        return false
    end
    
    if Tile(player:getPosition()):hasFlag(TILESTATE_PROTECTIONZONE) then
        return player:sendCancelMessage("You cannot fish in protection zones.")
    end
    
    -- Check which type of fishing is being done and assign a monster table --
    local fishingMonsters
    local effect
    if isInArray(waterIds, target.itemid) then
        fishingMonsters = waterMonsters
        effect = castEffects[1][itemid]
    elseif isInArray(lavaIds, target.itemid) then
        if player:getSkillLevel(SKILL_FISHING) < 120 then
            return player:sendCancelMessage("You cannot fish in lava until level 120 fishing.")
        end
        fishingMonsters = lavaMonsters
        effect = castEffects[2][itemid]
    elseif isInArray(swampIds, target.itemid) then
        if player:getSkillLevel(SKILL_FISHING) < 120 then
            return player:sendCancelMessage("You cannot fish in swamps until level 120 fishing.")
        end
        fishingMonsters = swampMonsters
        effect = castEffects[3][itemid]
    elseif isInArray(tarIds, target.itemid) then
        if player:getSkillLevel(SKILL_FISHING) < 140 then
            return player:sendCancelMessage("You cannot fish in tar until level 140 fishing.")
        end
        fishingMonsters = tarMonsters
        effect = castEffects[4][itemid]
    end
    
    if not fishingMonsters then
        return false
    end
    
    -- Difficulty based on different items, fishing scroll, and skill level --
    local difficulty = 2.00
    local skillModifier = 0.0
    local itemModifier = 0.0
    if player:getSkillLevel(SKILL_FISHING) > 100 then
        skillModifier = (100 / player:getSkillLevel(SKILL_FISHING))
    end
    
    difficulty = difficulty - math.abs(skillModifier)
    
    if itemid == 10223 then
        itemModifier = 0.25
    end
    
    difficulty = difficulty - math.abs(itemModifier)
    ---------------------------------------------------------------------------

    local realMonsterChance = catchMonstersRandom * difficulty
    
    -- Catch Monsters --
    for i = 1, #fishingMonsters do
        if player:getLevel() >= fishingMonsters[i].level and player:getSkillLevel(SKILL_FISHING) >= fishingMonsters[i].fishing then
            local extraChance = player:getSkillLevel(SKILL_FISHING) * 200
            if Game.randNumbers(realMonsterChance) <= (fishingMonsters[i].chance + extraChance) then
                local MONS = Game.createMonster(fishingMonsters[i].name, player:getPosition(), true, false)
                if MONS then
                    player:addCatch(fishingMonsters[i].key, 1)
                
                    if fishingMonsters[i].broadcast then
                        local msg = fishingMonsters[i].broadcast:gsub("|PLAYERNAME|", player:getName())
                        local players = Game.getPlayers()
                        for x, v in ipairs(players) do
                            v:sendChannelMessage("", msg, TALKTYPE_CHANNEL_O, 9)
                        end
                        if fishingMonsters[i].serverBC then
                            Game.broadcastMessage(msg, MESSAGE_EVENT_ADVANCE)
                        end
                    end
                    
                    if fishingMonsters[i].vowel then 
                        player:sendTextMessage(MESSAGE_INFO_DESCR, "You have caught an "..fishingMonsters[i].name.."!")
                    else
                        player:sendTextMessage(MESSAGE_INFO_DESCR, "You have caught a "..fishingMonsters[i].name.."!")
                    end
                    toPosition:sendMagicEffect(CONST_ME_WATERCREATURE)
                    FISHINGMONSTERS[MONS:getId()] = {owner = player:getName(), status = 1}
                end
                break
            end
        end
    end
    
    -- Change fishing skill rate based on level --
    if player:getSkillLevel(SKILL_FISHING) < 80 then
        player:addSkillTries(SKILL_FISHING, 5)
    else
        player:addSkillTries(SKILL_FISHING, 1)
    end
    --------------
    
    toPosition:sendMagicEffect(effect)
    return true
end

fishing:allowFarUse(true)
fishing:id(2580)
fishing:id(10223)
fishing:register()