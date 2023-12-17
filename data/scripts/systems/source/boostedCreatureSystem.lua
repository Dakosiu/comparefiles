local boostBosses = {
   "Master Warlock",
   "Skeleton King",
   "Arcane Wizard",
   "Faceless Bane",
   "The Dread Maiden",
   "The Ghastly Slime",
   "Dwarferius Maximus",
   "Mawhawk",
   "Johnny Storm",
   "Goshnar's Megalomania",
   "Starluxian Hero",
   "The Ancient Spark",
   "Dark Hydra",
   "Humongous Fungus",
   "Smaug",
   "The Pale Count",
   "Tyrn",
   "Distorted Phantom",
   "Ancient Vampus",
   "Tutankhamon",
   "Sacred Scarab",
   "Bloody Spider",
   "Raging Mage",
   "Bog Mother",
   "Ancient Spider",
   "Elder Vampire",
   "Elder Witch",
   "Execowtioner",
   "Minotaur Idol",
   "Obsidian Spider",
   "Holy Scarab",
   "Animated Snowman",
   "Ancient Tortoise",
   "Rotworm Queen",
   "Creepy Witch",
   "Edronian Mummy",
   "Mutated Rotworm",
   "Mutated Spider",
   "Retro Rotworm Queen",
   "Mud Ghoul",
   "Undead Skeleton",
   "Crystaled Rotworm",
   "Hyaena Leader",
   "Demonic Troll",
   "Retro Rotworm",
   "Angry Goat",
   "Cocky Cock",
}

local boostMonsters = {
   "Rotworm",
   "Dragon",
   "Dragon Lord",
   "Demon",
   "Ghost",
   "Banshee",
   "Rat",
   "Cave Rat",
   "Minotaur",
   "Minotaur Archer",
   "Minotaur Guard",
   "Minotaur Mage",
   "Giant Spider",
   "Mountain Spider",
   "Tarantula",
   "Bug",
   "Spider",
   "Poison Spider",
   "Cyclops",
   "Cyclops Drone",
   "Cyclops Smith",
   "Elf",
   "Elf Scout",
   "Elf Arcanist",
   "Vampire",
   "Ghoul",
   "Mummy",
   "Demon Skeleton",
   "Necromancer",
   "Stalker",
   "Wyrm",
   "Elder Wyrm",
   "Hydra",
   "Elder Hydra",
   "Orc",
   "Orc Warrior",
   "Orc Spearman",
   "Orc Shaman",
   "Orc Berserker",
   "Orc Leader",
   "Lancer Beetle",
   "Wailing Widow",
   "Gnarlhound",
   "Killer Caiman",
   "Elder Demon",
   "Warlock Apprentice",
   "Warlock",
   "Elder Warlock",
   "Frost Dragon",
   "Elder Frost Dragon",
   "Witch",
   "Hero",
   "Elder Hero",
   "Spectre Warrior",
   "Skeleton",
   "Warrior Skeleton",
   "Lizard Legionnaire",
   "Lizard High Guard",
   "Lizard Dragon Priest",
   "Lizard Zaogun",
   "Draken Warmaster",
   "Draken Spellweaver",
   "Ghastly Dragon",
   "Brimstone Bug",
   "Souleater",
   "Eternal Guardian",
   "Medusa",
   "Serpent Spawn",
   "Brahados",
   "Fiery Larva",
   "Fiery Scarab",
   "Fiery Archscarabus",
   "Priestess",
   "Monk",
   "Dark Monk",
   "Dwarf",
   "Dwarf Soldier",
   "Dwarf Guard",
   "Carrion Worm",
   "Dark Magician",
   "Dark Apprentice",
   "Hellspawn",
   "Nightmare",
   "Nightmare Scion",
   "Banshee",
   "Black Knight",
   "Skeleton Boxer",
   "Lich",
   "Elder Bonelord",
   "Bonelord",
   "Wyvern",
   "Earth Elemental",
   "Bog Raider",
   "Water Elemental",
   "Fury",
   "Golden Dragon",
   "Amazon",
   "Valkyrie",
   "Corym Charlatan",
   "Corym Skirmisher",
   "Corym Vanguard",
   "Wolf",
   "Bear",
   "Bat",
   "Sibang",
   "Kongra",
   "Merlkin",
   "Lizard Templar",
   "Lizard Sentinel",
   "Lizard Snakecharmer",
   "Dworc Fleshhunter",
   "Dworc Venomsniper",
   "Dworc Voodoomaster",
   "Ice Witch",
   "Barbarian Bloodwalker",
   "Barbarian Skullhunter",
   "Barbarian Brutetamer",
   "Crystal Spider",
   "Ice Golem",
   "Spectre",
   "Mutated Rat",
   "Gladiator",
   "Mutated Tiger",
   "Mutated Human",
   "Destroyer",
   "Nightstalker",
   "Zombie",
   "Blue Djinn",
   "Green Djinn",
   "Novice of the Cult",
   "Acolyte of the Cult",
   "Adept of the Cult",
   "Enlightened of the Cult",
   "Plaguesmith",
   "Grim Reaper",
   "Lava golem",
   "Hellhound",
   "Hellfire Fighter",
   "Askarak Demon",
   "Askarak Lord",
   "Askarak Prince",
   "Shaburak Demon",
   "Shaburak Lord",
   "Shaburak Prince",
   "Troll",
   "Bonebeast",
   "Larva",
   "Scarab",
   "Ancient Scarab",
   "Pirate Buccaneer",
   "Pirate Marauder",
   "Pirate Skeleton",
   "Pirate Cutthroat",
   "Pirate Ghost",
   "Pirate Corsair",
   "Infernalist",
   "Mad Scientist",
   "Tortoise",
   "Thornback Tortoise",
   "Quara Mantassin Scout",
   "Quara Mantassin",
   "Quara Predator Scout",
   "Quara Predator",
   "Quara Pincher Scout",
   "Quara Pincher",
   "Quara Hydromancer Scout",
   "Quara Hydromancer",
   "Crypt Shambler",
   "Mutated Bat",
   "Lizard Chosen",
   "Draken Elite",
   "Draken Abomination",
   "Vampire Viscount",
   "Vampire Bride",
   "Ratrroty",
}


local bonusEXP = 1.4 -- ! 40%
local bonusLoot = 2 -- ! Double Loot

if not BonusCreatureSystem then
   BonusCreatureSystem = {}
end

function BonusCreatureSystem.defineBoostedCreature()
   local randomBoostedMonster = math.random(#boostMonsters)
   local randomBoostedMonsterCreature = boostMonsters[randomBoostedMonster]
   local randomBoostedBoss = math.random(#boostBosses)
   local randomBoostedBossCreature = boostBosses[randomBoostedBoss]
   dailyBoostedCreature, dailyBoostedBoss = randomBoostedMonsterCreature, randomBoostedBossCreature
   return randomBoostedMonsterCreature, randomBoostedBossCreature
end

local globalevent = GlobalEvent("bonusesCreatureSystem_onStartup")
function globalevent.onStartup()
   BonusCreatureSystem.defineBoostedCreature()
end
globalevent:register()

local ec = EventCallback
function ec.onGainExperience(player, source, exp, rawExp)
   if player and source:isMonster() then
      if source:getName():lower() == dailyBoostedCreature:lower() or source:getName():lower() == dailyBoostedBoss:lower() then
         exp = exp * bonusEXP
      end
   end
   return exp
end
ec:register(667)

local function convertToRedable(n)
   n = math.ceil((n - 1) * 100)
   return n
end

creatureevent = CreatureEvent("bonusesCreatureSystem_onLogin")
function creatureevent.onLogin(player)
   player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("The daily boosted creature is %s\nThe daily boosted boss is %s\nYou have %i%% bonus experience and %i%% bonus loot from killing these creatures.", dailyBoostedCreature, dailyBoostedBoss, convertToRedable(bonusEXP), convertToRedable(bonusLoot)))
   return true
end
creatureevent:register()

function isBoostedCreature(monster)
   local value = 0
   if monster:getName():lower() == dailyBoostedBoss:lower() or monster:getName():lower() == dailyBoostedCreature:lower() then
      value = value + 20
  end
  return value
end