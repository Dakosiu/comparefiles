NPCTasks = {


--- <<<<<<******* Citizen , first npc at hunts tp
   [0] = { creature = {"Orc", "Orc Warrior", "Orc Spearman", "Orc Berserker", "Orc Leader", "Orc Marauder", "Orc Shaman"}, Quantity = 150, TakeTaskMessage = 'Thanks for taking this task', reward = { statsPoint = 1, experience = 50000, storage = 0, items = { 2160, 10, 26179, 1 } }, Storage = 39000, lastMessage = "Thanks for doing it for me, bye" },
   [1] = { itemsToBring = { 8872, 3, 11219, 50 }, TakeTaskMessage = 'Thanks for taking this task', reward = { statsPoint = 10, experience = 70000, storage = 1000, items = { 26179, 1 , 2160, 100} }, Storage = 39001, lastMessage = "Thanks for doing it for me, bye" }, -- ,
   [2] = { creature = {"Gozzler"}, Quantity = 180, reward = { statsPoint = 1, experience = 90000, storage = 0, items = { 2160, 10, 26179, 1 } }, Storage = 39002, TakeTaskMessage = "Please do it for me, you can find gozzlers on teleports and in exploreable area :)", lastMessage = "Thanks for doing it for me, bye" },
   [3] = { itemsToBring = { 11334, 15, 11335, 20, 5881, 25, 11333, 15 }, reward = { statsPoint = 1, experience = 100000, storage = 0, items = { 2160, 20 } }, Storage = 39003, TakeTaskMessage = "Please do it for me :)", lastMessage = "Thanks for doing it for me, bye" },
   [4] = { creature = {"Killer Caiman"}, Quantity = 80, reward = { statsPoint = 2, experience = 120000, storage = 0, items = { 2160, 20, 27604, 1 } }, Storage = 39004, TakeTaskMessage = "Please do it for me :)", lastMessage = "Thanks for doing it for me, bye" },
   [5] = { itemsToBring = { 12405, 50, 10602, 70 }, reward = { statsPoint = 2, experience = 140000, storage = 0, items = { 2160, 30 } }, Storage = 39005, TakeTaskMessage = "Please do it for me, vampires can be found on teleports and in exploreable area :)", lastMessage = "Thanks for doing it for me, bye" },
   [6] = { boss = {"Orshabaal"}, Quantity = 2, reward = { statsPoint = 4, experience = 160000, storage = 0, items = { 40554, 50, 2160, 30, 28436, 1 } }, Storage = 39006, TakeTaskMessage = "Please do it for me, you can find the boss using command /bosses and exiva the boss :)", lastMessage = "Thanks for doing it for me, bye" },

--- <<<<<<******* Pek, second npc at hunts tp
   [7] = { creature = {"Demon"}, Quantity = 150, TakeTaskMessage = 'Thanks for taking this task, you can find demons in teleports room and exploreable area', reward = { statsPoint = 2, experience = 160000, storage = 0, items = { 2160, 20, 27604, 1 } }, Storage = 39007, lastMessage = "Thanks for doing it for me, bye" },
   [8] = { itemsToBring = { 11199, 100, 41529, 2 }, TakeTaskMessage = 'Thanks for taking this task', reward = { statsPoint = 3, experience = 200000, storage = 0, items = { 27604, 1, 8306, 1 } }, Storage = 39008, lastMessage = "Thanks for doing it for me, bye" }, -- ,
   [9] = { creature = {"Infected Weeper"}, Quantity = 125, reward = { statsPoint = 3, experience = 220000, storage = 0, items = { 2160, 30 } }, Storage = 39009, TakeTaskMessage = "Please do it for me :)", lastMessage = "Thanks for doing it for me, bye" },
   [10] = { itemsToBring = { 5922, 25, 5921, 50, 10552, 100 }, reward = { statsPoint = 3, experience = 220000, storage = 0, items = { 2160, 40 } }, Storage = 39010, TakeTaskMessage = "Please do it for me :)", lastMessage = "Thanks for doing it for me, bye" },
   [11] = { creature = {"Elf", "Elf Scout", "Elf Arcanist"}, Quantity = 180, reward = { statsPoint = 3, experience = 220000, storage = 0, items = { 2472, 5 } }, Storage = 39011, TakeTaskMessage = "Please do it for me :)", lastMessage = "Thanks for doing it for me, bye" },
   [12] = { itemsToBring = { 41529, 5, 26179, 10, 5943, 2 }, reward = { statsPoint = 4, experience = 220000, storage = 0, items = { 27604, 2 } }, Storage = 39012, TakeTaskMessage = "Please do it for me, you can find boss with command /bosses :)", lastMessage = "Thanks for doing it for me, bye" },
   [13] = { boss = {"Ghazbaran"}, Quantity = 2, reward = { statsPoint = 8, experience = 420000, storage = 0, items = { 40554, 100, 8306, 2, 28436, 1 } }, Storage = 39013, TakeTaskMessage = "Young warrior i see you are growing big, this boss Morgaroth can be found in hes temple, the temple teleport is protected by Orshabaal, be carefull its very damgerous place !!!", lastMessage = "Thanks for doing it for me, bye" },

--- <<<<<<******* 
   [14] = { creature = {"Snake", "Bug"}, Quantity = 30, TakeTaskMessage = 'Explore around the Main Evotronus city and its tunnels.', reward = { statsPoint = 1, experience = 1000, storage = 0, items = { 2160, 1 } }, Storage = 39014, lastMessage = "Thanks you a lot for cleaning the city, here some reward for you" },
   [15] = { itemsToBring = { 24174, 1 }, TakeTaskMessage = 'I need undying light elixir, please find it in these tunnels, i know there are spiders around the elixit i feel it, bring it to me', reward = { statsPoint = 1, experience = 2000, storage = 0, items = { 2160, 1 } }, Storage = 39015, lastMessage = "Good job yoong soul, keep growing!" }, -- ,
   [16] = { creature = {"Spider", "Poison Spider"}, Quantity = 50, reward = { statsPoint = 1, experience = 3000, storage = 0, items = { 2160, 2 } }, Storage = 39016, TakeTaskMessage = "Can you get some info about {Northeast} of the city?", lastMessage = "Thanks for completing this task." },
   [17] = { itemsToBring = { 24181, 1 }, reward = { statsPoint = 1, experience = 4000, storage = 0, items = { 2160, 3 } }, Storage = 39017, TakeTaskMessage = "Please bring me elixir of life everchanging, you can find this item near crocodiles, you can use command /bosses and try locate the snapper and by trying locate it you can find this item", lastMessage = "Thanks it will help a lot, also you should check about craftingSystem" },
   [18] = { creature = {"Swamp Troll"}, Quantity = 20, reward = { statsPoint = 1, experience = 5000, storage = 0, items = { 2160, 5 } }, Storage = 39018, TakeTaskMessage = "You can find these swamp trolls deep in the city tunnels.", lastMessage = "Thanks it will help the city a lot" },
   [19] = { itemsToBring = { 10609, 20}, reward = { statsPoint = 1, experience = 6000, storage = 0, items = { 2160, 10 } }, Storage = 39019, TakeTaskMessage = "Can you get some of this item for me ?", lastMessage = "Thanks, atlast i can buy blessing with these small energy balls." },
   [20] = { boss = {"Rorc"}, Quantity = 1, reward = { statsPoint = 2, experience = 7000, storage = 0, items = { 2160, 20 } }, Storage = 39020, TakeTaskMessage = "This boss is located in Evotronus city, to easier to find it use command /bosses", lastMessage = "Good job young soul, keep exploring!" },
   
--- <<<<<<******* 
   [21] = { creature = {"Earth Elemental"}, Quantity = 50, TakeTaskMessage = 'There is 2x passages to Grasslands, and for both need keys, you can find keys if you explore, 1 acces is near me , second more east of the city.', reward = { statsPoint = 1, experience = 50000, storage = 0, items = { 2160, 10 } }, Storage = 39021, lastMessage = "Well done young explorer, i see you got some fire in you!" },
   [22] = { itemsToBring = { 32977, 1 }, TakeTaskMessage = 'Help me to get back my fellow amanita muscaria, it been taked by Dwurfs, lots of them.... Explore far north in Grasslands i heard they stay near Grasslands safehouse, bring my mushroom back, please!', reward = { statsPoint = 2, experience = 200000, storage = 0, items = { 34214, 30, 34215, 15 } }, Storage = 39022, lastMessage = "Wow you defeated Dwurfs, i heard they are more stronger then Dwarfs, well done, keep growing, here i give you some powerfull organic berrys!" }, -- ,
   [23] = { creature = {"Askarak Lord", "Askarak Demon", "Askarak Prince"}, Quantity = 250, reward = { statsPoint = 3, experience = 200000, storage = 0, items = { 2160, 20, 21401, 1 } }, Storage = 39023, TakeTaskMessage = "Please try help the grounds of Grasslands be less of Askaraks, they seem to make the hive in the Grasslands", lastMessage = "Thanks for completing this task, here some nice reward for you." },
   [24] = { itemsToBring = { 32665, 1 }, reward = { statsPoint = 4, experience = 40000, storage = 0, items = { 27604, 1 } }, Storage = 39024, TakeTaskMessage = "Please bring me rainbow amanita muscaria, the strongest magic mushroom in our galaxy...Shaburaks been speaking widely about theyr finding, bring it to me from them", lastMessage = "Oh, i hope didint bite tiny bit, this psichodelic mushroom is to strong for newbiew to handle! Oh my mushy... Thanks young soul, here are your rewards for you!" },
   [25] = { creature = {"Dark Torturer"}, Quantity = 300, reward = { statsPoint = 5, experience = 250000, storage = 0, items = { 2160, 85, 21401, 1, 8300, 2 } }, Storage = 39025, TakeTaskMessage = "The old civilization graves have beeen disrespected by those Dark Torturers , please help the old warriors graves.", lastMessage = "We already felt changed of vibration in the air even way before you reported back your mission, well done young soul, keep growing!" },
   [26] = { itemsToBring = { 15572, 1}, reward = { statsPoint = 6, experience = 1000000, storage = 0, items = { 28436, 1, 27604, 3 } }, Storage = 39026, TakeTaskMessage = "Please find me an Yielothax egg, its slimy green thingy...I hear the cave is pickable in Grasslands near those Crystalcrushers, anyway, good luck!", lastMessage = "Thanks thanks thanks i can start my alchemy now, here some rewards for you,and now i can give you last boss hunt mission!" },
   [27] = { boss = {"Wyvern Draco"}, Quantity = 5, reward = { statsPoint = 7, experience = 700000, storage = 0, items = { 40554, 100, 21401, 2, 27604, 3 } }, Storage = 39027, TakeTaskMessage = "This boss is located in Far east from Evotronus city behind the mountains, to easier to find it use command /bosses", lastMessage = "Good job young soul, keep exploring!" },
   
--- <<<<<<Hagricus npc, fourth npc at hunts spots 4
   [28] = { creature = {"Draken Elite", "Draken Warmaster", "Draken Abomination"}, Quantity = 300, TakeTaskMessage = 'Those Drakenss... They seem to be also on exploreable area somewhere...Hunt them down!.', reward = { statsPoint = 2, experience = 250000, storage = 0, items = { 41529, 5 } }, Storage = 39028, lastMessage = "Well done mighty soul, i see you got some fire in you!" },
   [29] = { itemsToBring = { 8844, 1000, 6500, 250, 5911, 50 }, TakeTaskMessage = 'Help me prepare for For hot pepper fiesta!, Please collect those items for me!', reward = { statsPoint = 2, experience = 200000, storage = 0, items = { 34214, 50, 34215, 30, 41529, 1, 8306, 2, 28436, 1 } }, Storage = 39029, lastMessage = "Did you taste those hot peppers ?! wuuh... They strong... Thanks alot, here some reward for you!" }, -- ,
   [30] = { creature = {"Kollos", "Spidris", "Spidris Elite"}, Quantity = 400, reward = { statsPoint = 3, experience = 250000, storage = 0, items = { 40554, 60, 21401, 1, 27604, 2 } }, Storage = 39030, TakeTaskMessage = "Please clear those big bugs, i hate bugs... Those bugs can be found also in exploreable area!", lastMessage = "Thanks for completing this task, here some nice reward for you." },
   [31] = { itemsToBring = { 10554, 150, 10581, 150, 6500, 500, 31949, 2 }, reward = { statsPoint = 4, experience = 300000, storage = 0, items = { 27604, 2, 40554, 80, 8302, 3, 41529, 1 } }, Storage = 39031, TakeTaskMessage = "Please collect that items for me, its important to me...", lastMessage = "Oh, thanks alot, i thought you never will bring me this items, herre some reward for you :) " },
   [32] = { creature = {"Behemoth"}, Quantity = 420, reward = { statsPoint = 5, experience = 250000, storage = 0, items = { 21401, 2, 8302, 3, 41529, 1, 40554, 80 } }, Storage = 39032, TakeTaskMessage = "Please hunt those giants, show them that size doesnt matter!", lastMessage = "Well done young soul, keep growing!" },
   [33] = { itemsToBring = { 31949, 4, 26179, 25, 8982, 2}, reward = { statsPoint = 6, experience = 300000, storage = 0, items = { 40554, 80, 27604, 5, 28436, 1 } }, Storage = 39033, TakeTaskMessage = "Pleas bring me those items, lets do trade!", lastMessage = "Thanks for the nice trade, take care!" },
   [34] = { boss = {"Mutated Behemoth"}, Quantity = 5, reward = { statsPoint = 7, experience = 1000000, storage = 0, items = { 40554, 150, 21401, 2, 27604, 6, 41529, 2 } }, Storage = 39034, TakeTaskMessage = "This boss is located in first desert very far south east from main city, use command /bosses to located the boss", lastMessage = "well done warrior, keep exploring!" },
   
   
   
   --- <<<<<<******* 24808 - Mounts Doll
   --- <<<<<<******* 8300 - legendary slot gem/ 3 grade slot gem
   --- <<<<<<******* 8302 - medium slot gem / 2 grade slot gem
   --- <<<<<<******* 8306 - Rare slot gem/1 grade slot gem
   --- <<<<<<******* 34214 - Organic Rassberry - heals 10k hp/mp on eat
   --- <<<<<<******* 34215 - Organic Elderberry - heals 25k hp/mp on eat
   --- <<<<<<*******
   --- <<<<<<******* 28436 - experience pouch
   --- <<<<<<******* 8982 - Addon Doll
   --- <<<<<<******* 41529 - Amber Coin (100cc)
   --- <<<<<<******* 27604 - Teleportion Drink
   --- <<<<<<******* 21401 - container +1 (small dragon tear)
   --- <<<<<<******* 40554 - warrior coin
   --- <<<<<<******* 41611 - Stat Orb
   --- <<<<<<******* 
   --- <<<<<<******* 
   --- <<<<<<******* 30523 - 1 grade Bonus gem
   --- <<<<<<******* 30524 - 2 grade Bonus Gem
   --- <<<<<<******* 30525 - 3 grade Bonus Gem
   --- <<<<<<******* 39384 - Bonus Remover
   --- <<<<<<******* 32659 - Bonus Holder
   --- <<<<<<******* 36548 - Protection potion/10% protection death
   --- <<<<<<******* 35420 - Stamina Doll/full
   --- <<<<<<******* 
   --- <<<<<<******* 
   --- <<<<<<******* 
   --- <<<<<<******* 
   
   
   --- <<<<<<******* Dranys turi buti npc, fifth npc at hunts spots      4
   [35] = { itemsToBring = { 2792, 35, 2600, 3, 41611, 1 }, TakeTaskMessage = 'Please bring me those items for it i will reward you!', reward = { statsPoint = 2, experience = 300000, storage = 0, items = { 41529, 6 } }, Storage = 39035, lastMessage = "Well done mighty soul, i see you got some fire in you, come for more tasks!" },
   [36] = { itemsToBring = { 20129, 50, 20134, 50, 20135, 50, 18414, 50, 20137, 50, 20127, 50, 20106, 50, 20128, 50, 2160, 50 }, TakeTaskMessage = 'Help me prepare for For hot pepper fiesta!, Please collect those items for me!', reward = { statsPoint = 3, experience = 400000, storage = 0, items = { 35969, 1, 27604, 2, 24808, 1, 8306, 2, 28436, 2 } }, Storage = 39036, lastMessage = "Did you taste those hot peppers ?! wuuh... They strong... Thanks alot, here some reward for you!" }, -- ,
   [37] = { creature = {"Lost Berserker", "Lost Thrower", "Lost Thrower", "Lost Basher"}, Quantity = 350, reward = { statsPoint = 3, experience = 250000, storage = 0, items = { 40554, 75, 21401, 1, 27604, 2 } }, Storage = 39037, TakeTaskMessage = "Please show them your true power!", lastMessage = "Thanks for completing this task, here some nice reward for you." },
   [38] = { itemsToBring = { 2123, 5, 12412, 200, 12448, 200, 2195, 5 }, reward = { statsPoint = 4, experience = 300000, storage = 0, items = { 27604, 2, 40554, 90, 8302, 3, 41529, 1 } }, Storage = 39038, TakeTaskMessage = "Please collect that items for me, its important to me...", lastMessage = "Oh, thanks alot, i thought you never will bring me this items, herre some reward for you :) " },
   [39] = { creature = {"Serpent Spawn"}, Quantity = 420, reward = { statsPoint = 5, experience = 250000, storage = 0, items = { 21401, 2, 8302, 3, 41529, 1, 40554, 100 } }, Storage = 39039, TakeTaskMessage = "These lands need your hands to clear up those creatures!.", lastMessage = "We already know it! Words spreads fast :))) here is your reward!" },
   [40] = { itemsToBring = { 21312, 150, 21311, 150, 2472, 3}, reward = { statsPoint = 6, experience = 300000, storage = 0, items = { 40554, 100, 27604, 5, 41611, 1 } }, Storage = 39040, TakeTaskMessage = "Pleas bring me those items, lets do trade!", lastMessage = "Thanks for the nice trade, take care!" },
   [41] = { boss = {"Snake God Essence"}, Quantity = 2, reward = { statsPoint = 7, experience = 1000000, storage = 0, items = { 40554, 200, 21401, 2, 41611, 1, 41529, 3 } }, Storage = 39041, TakeTaskMessage = "This boss is located on first dragon way safehouse far further from Elfs, use command /bosses to located the boss", lastMessage = "well done warrior, keep exploring!" },
   
   
   
   
   
   
   
   
   
   
   
   
   
     --- <<<<<<*******  Seraphina Truthfinder npc in Depot teleport must have min 50 missions
   [42] = { itemsToBring = { 5902, 3, 10609, 10 }, TakeTaskMessage = 'Please bring me those items for it i will reward you!', reward = { statsPoint = 1, experience = 10000, storage = 0, items = { 2160, 10 } }, Storage = 39042, lastMessage = "Well done young soul, i see you got some fire in you!" },
   [43] = { creature = {"Tarantula"}, Quantity = 90, TakeTaskMessage = 'Go on and train on Tarantulas!', reward = { statsPoint = 1, experience = 15000, storage = 0, items = { 2160, 20 } }, Storage = 39043, lastMessage = "Thanks alot, here some reward for you!" }, -- ,
   [44] = { creature = {"Bublet"}, Quantity = 25, reward = { statsPoint = 1, experience = 20000, storage = 0, items = { 40554, 10, 2160, 20 } }, Storage = 39044, TakeTaskMessage = "This monster only spawns by raid in Evotronus city, keep watching for them!", lastMessage = "Thanks for completing this task, here some nice reward for you." },
   [45] = { itemsToBring = { 10602, 15, 11196, 5 }, reward = { statsPoint = 2, experience = 25000, storage = 0, items = { 40554, 20, 8302, 1 } }, Storage = 39045, TakeTaskMessage = "Please collect that items for me, its important to me...", lastMessage = "Oh, thanks alot, i thought you never will bring me this items, herre some reward for you :) " },
   [46] = { creature = {"Barbarian Skullhunter", "Barbarian Headsplitter", "Barbarian Brutetamer", "Barbarian Bloodwalker"}, Quantity = 130, reward = { statsPoint = 2, experience = 30000, storage = 0, items = { 2160, 10, 8302, 1, 40554, 25 } }, Storage = 39046, TakeTaskMessage = "Go far south east from main city Evotronus to train on those barbarians, i recomend you to loot the values!.", lastMessage = "Well done warrior, keep going!" },
   [47] = { itemsToBring = { 2195, 3, 11194, 25 }, reward = { statsPoint = 2, experience = 35000, storage = 0, items = { 40554, 30, 27604, 1 } }, Storage = 39047, TakeTaskMessage = "Pleas bring me those items, lets do trade!", lastMessage = "Thanks for the nice trade, take care!" },
   [48] = { boss = {"Dark Troll"}, Quantity = 1, reward = { statsPoint = 3, experience = 40000, storage = 0, items = { 40554, 40, 41529, 1 } }, Storage = 39048, TakeTaskMessage = "Please for the sake of peacefull life for trolls go and find Dark Troll and show him hes place, use command /bosses to located the boss, this boss is outside the evotronus city to south east, remember to take pick with you", lastMessage = "well done warrior, keep exploring!" },
   [49] = { itemsToBring = { 9676, 1 }, TakeTaskMessage = 'Please bring me sample of sand wasp honey, you can find it deep in smuggler and poachers camp near Evotronus city north east!', reward = { statsPoint = 3, experience = 45000, storage = 0, items = { 2160, 50 } }, Storage = 39049, lastMessage = "Well done explorer, i see you got some fire in you!" },
   [50] = { itemsToBring = { 41080, 1, 5879, 30, 2492, 1 }, TakeTaskMessage = 'please bring me those items for me, i realy need it', reward = { statsPoint = 3, experience = 50000, storage = 0, items = { 40554, 40, 8306, 2 } }, Storage = 39050, lastMessage = "Thanks alot, here some reward for you!" }, -- ,
   [51] = { creature = {"Giant Spider"}, Quantity = 140, reward = { statsPoint = 3, experience = 55000, storage = 0, items = { 40554, 40, 21401, 1, 27604, 1 } }, Storage = 39051, TakeTaskMessage = "Please clear those big bugs, i hate bugs... Those bugs can be found also in exploreable area!", lastMessage = "Thanks for completing this task, here some nice reward for you." },
   [52] = { itemsToBring = { 7290, 15, 15486, 100, 2195, 1 }, reward = { statsPoint = 3, experience = 60000, storage = 0, items = { 40554, 40, 8302, 1, 41529, 1 } }, Storage = 39052, TakeTaskMessage = "Please collect that items for me, its important to me...", lastMessage = "Oh, thanks alot, i thought you forgot our deal :) " },
   [53] = { creature = {"Stampor"}, Quantity = 120, reward = { statsPoint = 3, experience = 65000, storage = 0, items = { 40554, 45, 8302, 1, 41529, 1 } }, Storage = 39053, TakeTaskMessage = "The old civilization graves have beeen disrespected by those Dark Torturers , please help the old warriors graves.", lastMessage = "We already felt changed of vibration in the air even way before you reported back your mission, well done young soul, keep growing!" },
   [54] = { creature = {"Brimstone Bug"}, Quantity = 130, reward = { statsPoint = 3, experience = 70000, storage = 0, items = { 40554, 60 } }, Storage = 39054, TakeTaskMessage = "Pleas bring me those items, lets do trade!", lastMessage = "Thanks for the nice trade, take care!" },
   [55] = { boss = {"Sulphur Scuttler"}, Quantity = 3, reward = { statsPoint = 3, experience = 75000, storage = 0, items = { 40554, 50, 21401, 1, 27604, 1 } }, Storage = 39055, TakeTaskMessage = "This boss is located in first desert very far south east from main city, use command /bosses to located the boss", lastMessage = "well done warrior, keep exploring!" },
   [56] = { itemsToBring = { 9678, 1 }, TakeTaskMessage = 'Please bring me a piece of royal satin, you can find it near Hero camp far south east from Evotronus city, near From Orshabaal tower to east!', reward = { statsPoint = 2, experience = 80000, storage = 0, items = { 41529, 1 } }, Storage = 39056, lastMessage = "Well done expory soul, i see you got some energy in you!" },
   [57] = { itemsToBring = { 13506, 1 }, TakeTaskMessage = 'Please bring me medicine pouch, you can find it Far south east from Evotronus city, to where are Giant Spiders find Explorers safe house and around safehouse somewhere here you can find the medicine pouch!', reward = { statsPoint = 4, experience = 85000, storage = 0, items = { 40554, 50 } }, Storage = 39057, lastMessage = "Well done mighty explorer!" }, -- ,
   [58] = { creature = {"Vampire Bride", "Vampire Viscount"}, Quantity = 300, reward = { statsPoint = 4, experience = 90000, storage = 0, items = { 40554, 60 } }, Storage = 39058, TakeTaskMessage = "Go and train on these vampire creatures!", lastMessage = "Well done, you getting stronger and stronger!." },
   [59] = { itemsToBring = { 9980, 1 },reward = { statsPoint = 4, experience = 95000, storage = 0, items = { 27604, 1, 40554, 60, 8302, 1, 41529, 1 } }, Storage = 39059, TakeTaskMessage = "Please bring me crystal of power with you can find deep in Grasslands, near those Crystalcrusher creatures, also don't forget to take pick!", lastMessage = "Oh, thanks alot, i thought you will never find that place hehe, here some reward for you :) " },
   [60] = { creature = {"Crystalcrusher"}, Quantity = 420, reward = { statsPoint = 4, experience = 100000, storage = 0, items = { 21401, 1, 8302, 1, 41529, 1, 40554, 65 } }, Storage = 39060, TakeTaskMessage = "Please hunt those Crystalcrushers in Grasslands for me.", lastMessage = "Thanks Warrior for your bravery, here reward for you!" },
   
   
   
   
   
   
   [61] = { itemsToBring = { 31949, 4, 26179, 25, 8982, 2},reward = { statsPoint = 6, experience = 300000, storage = 0, items = { 40554, 80, 27604, 5, 28436, 1 } }, Storage = 39061, TakeTaskMessage = "Pleas bring me those items, lets do trade!", lastMessage = "Thanks for the nice trade, take care!" },
   [62] = { boss = {"Mutated Behemoth"}, Quantity = 5, reward = { statsPoint = 7, experience = 1000000, storage = 0, items = { 40554, 150, 21401, 2, 27604, 6, 41529, 2 } }, Storage = 39062, TakeTaskMessage = "This boss is located in first desert very far south east from main city, use command /bosses to located the boss", lastMessage = "well done warrior, keep exploring!" },
   
   [63] = { itemsToBring = { 2792, 35, 2600, 3, 41611, 1 }, TakeTaskMessage = 'Please bring me those items for it i will reward you!', reward = { statsPoint = 2, experience = 300000, storage = 0, items = { 41529, 5 } }, Storage = 39063, lastMessage = "Well done mighty soul, i see you got some fire in you!" },
   [64] = { itemsToBring = { 8844, 1000, 6500, 250, 5911, 50 }, TakeTaskMessage = 'Help me prepare for For hot pepper fiesta!, Please collect those items for me!', reward = { statsPoint = 2, experience = 200000, storage = 0, items = { 34214, 50, 34215, 30, 41529, 1, 8306, 2, 28436, 1 } }, Storage = 39064, lastMessage = "Did you taste those hot peppers ?! wuuh... They strong... Thanks alot, here some reward for you!" }, -- ,
   [65] = { creature = {"Kollos", "Spidris", "Spidris Elite"}, Quantity = 400, reward = { statsPoint = 3, experience = 250000, storage = 0, items = { 40554, 60, 21401, 1, 27604, 2 } }, Storage = 39065, TakeTaskMessage = "Please clear those big bugs, i hate bugs... Those bugs can be found also in exploreable area!", lastMessage = "Thanks for completing this task, here some nice reward for you." },
   [66] = { itemsToBring = { 10554, 150, 10581, 150, 6500, 500, 31949, 2 },reward = { statsPoint = 4, experience = 300000, storage = 0, items = { 27604, 2, 40554, 80, 8302, 3, 41529, 1 } }, Storage = 39066, TakeTaskMessage = "Please collect that items for me, its important to me...", lastMessage = "Oh, thanks alot, i thought you never will bring me this items, herre some reward for you :) " },
   [67] = { creature = {"Behemoth"}, Quantity = 420, reward = { statsPoint = 5, experience = 250000, storage = 0, items = { 21401, 2, 8302, 3, 41529, 1, 40554, 80 } }, Storage = 39067, TakeTaskMessage = "The old civilization graves have beeen disrespected by those Dark Torturers , please help the old warriors graves.", lastMessage = "We already felt changed of vibration in the air even way before you reported back your mission, well done young soul, keep growing!" },
   [68] = { itemsToBring = { 31949, 4, 26179, 25, 8982, 2},reward = { statsPoint = 6, experience = 300000, storage = 0, items = { 40554, 80, 27604, 5, 28436, 1 } }, Storage = 39068, TakeTaskMessage = "Pleas bring me those items, lets do trade!", lastMessage = "Thanks for the nice trade, take care!" },
   [69] = { boss = {"Mutated Behemoth"}, Quantity = 5, reward = { statsPoint = 7, experience = 1000000, storage = 0, items = { 40554, 150, 21401, 2, 27604, 6, 41529, 2 } }, Storage = 39069, TakeTaskMessage = "This boss is located in first desert very far south east from main city, use command /bosses to located the boss", lastMessage = "well done warrior, keep exploring!" },
   
   [70] = { itemsToBring = { 2792, 35, 2600, 3, 41611, 1 }, TakeTaskMessage = 'Please bring me those items for it i will reward you!', reward = { statsPoint = 2, experience = 300000, storage = 0, items = { 41529, 5 } }, Storage = 39070, lastMessage = "Well done mighty soul, i see you got some fire in you!" },
   [71] = { itemsToBring = { 8844, 1000, 6500, 250, 5911, 50 }, TakeTaskMessage = 'Help me prepare for For hot pepper fiesta!, Please collect those items for me!', reward = { statsPoint = 2, experience = 200000, storage = 0, items = { 34214, 50, 34215, 30, 41529, 1, 8306, 2, 28436, 1 } }, Storage = 39071, lastMessage = "Did you taste those hot peppers ?! wuuh... They strong... Thanks alot, here some reward for you!" }, -- ,
   [72] = { creature = {"Kollos", "Spidris", "Spidris Elite"}, Quantity = 400, reward = { statsPoint = 3, experience = 250000, storage = 0, items = { 40554, 60, 21401, 1, 27604, 2 } }, Storage = 39072, TakeTaskMessage = "Please clear those big bugs, i hate bugs... Those bugs can be found also in exploreable area!", lastMessage = "Thanks for completing this task, here some nice reward for you." },
   [73] = { itemsToBring = { 10554, 150, 10581, 150, 6500, 500, 31949, 2 },reward = { statsPoint = 4, experience = 300000, storage = 0, items = { 27604, 2, 40554, 80, 8302, 3, 41529, 1 } }, Storage = 39073, TakeTaskMessage = "Please collect that items for me, its important to me...", lastMessage = "Oh, thanks alot, i thought you never will bring me this items, herre some reward for you :) " },
   [74] = { creature = {"Behemoth"}, Quantity = 420, reward = { statsPoint = 5, experience = 250000, storage = 0, items = { 21401, 2, 8302, 3, 41529, 1, 40554, 80 } }, Storage = 39074, TakeTaskMessage = "The old civilization graves have beeen disrespected by those Dark Torturers , please help the old warriors graves.", lastMessage = "We already felt changed of vibration in the air even way before you reported back your mission, well done young soul, keep growing!" },
   [75] = { itemsToBring = { 31949, 4, 26179, 25, 8982, 2},reward = { statsPoint = 6, experience = 300000, storage = 0, items = { 40554, 80, 27604, 5, 28436, 1 } }, Storage = 39075, TakeTaskMessage = "Pleas bring me those items, lets do trade!", lastMessage = "Thanks for the nice trade, take care!" },
   [76] = { boss = {"Mutated Behemoth"}, Quantity = 5, reward = { statsPoint = 7, experience = 1000000, storage = 0, items = { 40554, 150, 21401, 2, 27604, 6, 41529, 2 } }, Storage = 39076, TakeTaskMessage = "This boss is located in first desert very far south east from main city, use command /bosses to located the boss", lastMessage = "well done warrior, keep exploring!" },
   
   [77] = { itemsToBring = { 2792, 35, 2600, 3, 41611, 1 }, TakeTaskMessage = 'Please bring me those items for it i will reward you!', reward = { statsPoint = 2, experience = 300000, storage = 0, items = { 41529, 5 } }, Storage = 39077, lastMessage = "Well done mighty soul, i see you got some fire in you!" },
   [78] = { itemsToBring = { 8844, 1000, 6500, 250, 5911, 50 }, TakeTaskMessage = 'Help me prepare for For hot pepper fiesta!, Please collect those items for me!', reward = { statsPoint = 2, experience = 200000, storage = 0, items = { 34214, 50, 34215, 30, 41529, 1, 8306, 2, 28436, 1 } }, Storage = 39078, lastMessage = "Did you taste those hot peppers ?! wuuh... They strong... Thanks alot, here some reward for you!" }, -- ,
   [79] = { creature = {"Kollos", "Spidris", "Spidris Elite"}, Quantity = 400, reward = { statsPoint = 3, experience = 250000, storage = 0, items = { 40554, 60, 21401, 1, 27604, 2 } }, Storage = 39079, TakeTaskMessage = "Please clear those big bugs, i hate bugs... Those bugs can be found also in exploreable area!", lastMessage = "Thanks for completing this task, here some nice reward for you." },
   [80] = { itemsToBring = { 10554, 150, 10581, 150, 6500, 500, 31949, 2 },reward = { statsPoint = 4, experience = 300000, storage = 0, items = { 27604, 2, 40554, 80, 8302, 3, 41529, 1 } }, Storage = 39080, TakeTaskMessage = "Please collect that items for me, its important to me...", lastMessage = "Oh, thanks alot, i thought you never will bring me this items, herre some reward for you :) " },
   [81] = { creature = {"Behemoth"}, Quantity = 420, reward = { statsPoint = 5, experience = 250000, storage = 0, items = { 21401, 2, 8302, 3, 41529, 1, 40554, 80 } }, Storage = 39081, TakeTaskMessage = "The old civilization graves have beeen disrespected by those Dark Torturers , please help the old warriors graves.", lastMessage = "We already felt changed of vibration in the air even way before you reported back your mission, well done young soul, keep growing!" },
   [82] = { itemsToBring = { 31949, 4, 26179, 25, 8982, 2},reward = { statsPoint = 6, experience = 300000, storage = 0, items = { 40554, 80, 27604, 5, 28436, 1 } }, Storage = 39082, TakeTaskMessage = "Pleas bring me those items, lets do trade!", lastMessage = "Thanks for the nice trade, take care!" },
   [83] = { boss = {"Mutated Behemoth"}, Quantity = 5, reward = { statsPoint = 7, experience = 1000000, storage = 0, items = { 40554, 150, 21401, 2, 27604, 6, 41529, 2 } }, Storage = 39083, TakeTaskMessage = "This boss is located in first desert very far south east from main city, use command /bosses to located the boss", lastMessage = "well done warrior, keep exploring!" },
   
   [84] = { itemsToBring = { 2792, 35, 2600, 3, 41611, 1 }, TakeTaskMessage = 'Please bring me those items for it i will reward you!', reward = { statsPoint = 2, experience = 300000, storage = 0, items = { 41529, 5 } }, Storage = 39084, lastMessage = "Well done mighty soul, i see you got some fire in you!" },
   [85] = { itemsToBring = { 8844, 1000, 6500, 250, 5911, 50 }, TakeTaskMessage = 'Help me prepare for For hot pepper fiesta!, Please collect those items for me!', reward = { statsPoint = 2, experience = 200000, storage = 0, items = { 34214, 50, 34215, 30, 41529, 1, 8306, 2, 28436, 1 } }, Storage = 39085, lastMessage = "Did you taste those hot peppers ?! wuuh... They strong... Thanks alot, here some reward for you!" }, -- ,
   [86] = { creature = {"Kollos", "Spidris", "Spidris Elite"}, Quantity = 400, reward = { statsPoint = 3, experience = 250000, storage = 0, items = { 40554, 60, 21401, 1, 27604, 2 } }, Storage = 39086, TakeTaskMessage = "Please clear those big bugs, i hate bugs... Those bugs can be found also in exploreable area!", lastMessage = "Thanks for completing this task, here some nice reward for you." },
   [87] = { itemsToBring = { 10554, 150, 10581, 150, 6500, 500, 31949, 2 },reward = { statsPoint = 4, experience = 300000, storage = 0, items = { 27604, 2, 40554, 80, 8302, 3, 41529, 1 } }, Storage = 39087, TakeTaskMessage = "Please collect that items for me, its important to me...", lastMessage = "Oh, thanks alot, i thought you never will bring me this items, herre some reward for you :) " },
   [88] = { creature = {"Behemoth"}, Quantity = 420, reward = { statsPoint = 5, experience = 250000, storage = 0, items = { 21401, 2, 8302, 3, 41529, 1, 40554, 80 } }, Storage = 39088, TakeTaskMessage = "The old civilization graves have beeen disrespected by those Dark Torturers , please help the old warriors graves.", lastMessage = "We already felt changed of vibration in the air even way before you reported back your mission, well done young soul, keep growing!" },
   [89] = { itemsToBring = { 31949, 4, 26179, 25, 8982, 2},reward = { statsPoint = 6, experience = 300000, storage = 0, items = { 40554, 80, 27604, 5, 28436, 1 } }, Storage = 39089, TakeTaskMessage = "Pleas bring me those items, lets do trade!", lastMessage = "Thanks for the nice trade, take care!" },
   [90] = { boss = {"Mutated Behemoth"}, Quantity = 5, reward = { statsPoint = 7, experience = 1000000, storage = 0, items = { 40554, 150, 21401, 2, 27604, 6, 41529, 2 } }, Storage = 39090, TakeTaskMessage = "This boss is located in first desert very far south east from main city, use command /bosses to located the boss", lastMessage = "well done warrior, keep exploring!" },
   
   [91] = { itemsToBring = { 2792, 35, 2600, 3, 41611, 1 }, TakeTaskMessage = 'Please bring me those items for it i will reward you!', reward = { statsPoint = 2, experience = 300000, storage = 0, items = { 41529, 5 } }, Storage = 39091, lastMessage = "Well done mighty soul, i see you got some fire in you!" },
   [92] = { itemsToBring = { 8844, 1000, 6500, 250, 5911, 50 }, TakeTaskMessage = 'Help me prepare for For hot pepper fiesta!, Please collect those items for me!', reward = { statsPoint = 2, experience = 200000, storage = 0, items = { 34214, 50, 34215, 30, 41529, 1, 8306, 2, 28436, 1 } }, Storage = 39092, lastMessage = "Did you taste those hot peppers ?! wuuh... They strong... Thanks alot, here some reward for you!" }, -- ,
   [93] = { creature = {"Kollos", "Spidris", "Spidris Elite"}, Quantity = 400, reward = { statsPoint = 3, experience = 250000, storage = 0, items = { 40554, 60, 21401, 1, 27604, 2 } }, Storage = 39093, TakeTaskMessage = "Please clear those big bugs, i hate bugs... Those bugs can be found also in exploreable area!", lastMessage = "Thanks for completing this task, here some nice reward for you." },
   [94] = { itemsToBring = { 10554, 150, 10581, 150, 6500, 500, 31949, 2 },reward = { statsPoint = 4, experience = 300000, storage = 0, items = { 27604, 2, 40554, 80, 8302, 3, 41529, 1 } }, Storage = 39094, TakeTaskMessage = "Please collect that items for me, its important to me...", lastMessage = "Oh, thanks alot, i thought you never will bring me this items, herre some reward for you :) " },
   [95] = { creature = {"Behemoth"}, Quantity = 420, reward = { statsPoint = 5, experience = 250000, storage = 0, items = { 21401, 2, 8302, 3, 41529, 1, 40554, 80 } }, Storage = 39095, TakeTaskMessage = "The old civilization graves have beeen disrespected by those Dark Torturers , please help the old warriors graves.", lastMessage = "We already felt changed of vibration in the air even way before you reported back your mission, well done young soul, keep growing!" },
   [96] = { itemsToBring = { 31949, 4, 26179, 25, 8982, 2},reward = { statsPoint = 6, experience = 300000, storage = 0, items = { 40554, 80, 27604, 5, 28436, 1 } }, Storage = 39096, TakeTaskMessage = "Pleas bring me those items, lets do trade!", lastMessage = "Thanks for the nice trade, take care!" },
   [97] = { boss = {"Mutated Behemoth"}, Quantity = 5, reward = { statsPoint = 7, experience = 1000000, storage = 0, items = { 40554, 150, 21401, 2, 27604, 6, 41529, 2 } }, Storage = 39097, TakeTaskMessage = "This boss is located in first desert very far south east from main city, use command /bosses to located the boss", lastMessage = "well done warrior, keep exploring!" },
   
   [98] = { itemsToBring = { 2792, 35, 2600, 3, 41611, 1 }, TakeTaskMessage = 'Please bring me those items for it i will reward you!', reward = { statsPoint = 2, experience = 300000, storage = 0, items = { 41529, 5 } }, Storage = 39098, lastMessage = "Well done mighty soul, i see you got some fire in you!" },
   [99] = { itemsToBring = { 8844, 1000, 6500, 250, 5911, 50 }, TakeTaskMessage = 'Help me prepare for For hot pepper fiesta!, Please collect those items for me!', reward = { statsPoint = 2, experience = 200000, storage = 0, items = { 34214, 50, 34215, 30, 41529, 1, 8306, 2, 28436, 1 } }, Storage = 39099, lastMessage = "Did you taste those hot peppers ?! wuuh... They strong... Thanks alot, here some reward for you!" }, -- ,
   [100] = { creature = {"Kollos", "Spidris", "Spidris Elite"}, Quantity = 400, reward = { statsPoint = 3, experience = 250000, storage = 0, items = { 40554, 60, 21401, 1, 27604, 2 } }, Storage = 39100, TakeTaskMessage = "Please clear those big bugs, i hate bugs... Those bugs can be found also in exploreable area!", lastMessage = "Thanks for completing this task, here some nice reward for you." },
   [101] = { itemsToBring = { 10554, 150, 10581, 150, 6500, 500, 31949, 2 },reward = { statsPoint = 4, experience = 300000, storage = 0, items = { 27604, 2, 40554, 80, 8302, 3, 41529, 1 } }, Storage = 39101, TakeTaskMessage = "Please collect that items for me, its important to me...", lastMessage = "Oh, thanks alot, i thought you never will bring me this items, herre some reward for you :) " },
   [102] = { creature = {"Behemoth"}, Quantity = 420, reward = { statsPoint = 5, experience = 250000, storage = 0, items = { 21401, 2, 8302, 3, 41529, 1, 40554, 80 } }, Storage = 39102, TakeTaskMessage = "The old civilization graves have beeen disrespected by those Dark Torturers , please help the old warriors graves.", lastMessage = "We already felt changed of vibration in the air even way before you reported back your mission, well done young soul, keep growing!" },
   [103] = { itemsToBring = { 31949, 4, 26179, 25, 8982, 2},reward = { statsPoint = 6, experience = 300000, storage = 0, items = { 40554, 80, 27604, 5, 28436, 1 } }, Storage = 39103, TakeTaskMessage = "Pleas bring me those items, lets do trade!", lastMessage = "Thanks for the nice trade, take care!" },
   
   
   
   
   
   
   --- <<<<<<*******  Ancient Men, solo bosses tp
   
   [104] = { boss = {"Draganir"}, Quantity = 2, reward = { statsPoint = 1, experience = 50000, storage = 0, items = { 40554, 150, 21401, 2, 27604, 6, 41529, 2 } }, Storage = 39104, TakeTaskMessage = "Please kill that boss for me!!!", lastMessage = "Perfect, now you can grow more and do more tasks!!!" },
   [105] = { boss = {"Drahhu"}, Quantity = 2, TakeTaskMessage = 'Please kill that boss for me!!!', reward = { statsPoint = 1, experience = 50000, storage = 0, items = { 41529, 5 } }, Storage = 39105, lastMessage = "Perfect, now you can grow more and do more tasks!!!" },
   [106] = { boss = {"Mighty Mino"}, Quantity = 2, TakeTaskMessage = 'Please kill that boss for me!!!', reward = { statsPoint = 2, experience = 100000, storage = 0, items = { 34214, 50, 34215, 30, 41529, 1, 8306, 2, 28436, 1 } }, Storage = 39106, lastMessage = "Perfect, now you can grow more and do more tasks!!!" }, -- ,
   [107] = { boss = {"Skullhasher"}, Quantity = 2, reward = { statsPoint = 2, experience = 100000, storage = 0, items = { 40554, 60, 21401, 1, 27604, 2 } }, Storage = 39107, TakeTaskMessage = "Please kill that boss for me!!!", lastMessage = "Perfect, now you can grow more and do more tasks!!!" },
   [108] = { boss = {"Nighthaven Kraken"}, Quantity = 2, reward = { statsPoint = 3, experience = 200000, storage = 0, items = { 27604, 2, 40554, 80, 8302, 3, 41529, 1 } }, Storage = 39108, TakeTaskMessage = "Please kill that boss for me!!!", lastMessage = "Perfect, now you can grow more and do more tasks!!!" },
   [109] = { boss = {"Durianus"}, Quantity = 2, reward = { statsPoint = 3, experience = 200000, storage = 0, items = { 21401, 2, 8302, 3, 41529, 1, 40554, 80 } }, Storage = 39109, TakeTaskMessage = "Please kill that boss for me!!!", lastMessage = "Perfect, now you can grow more and do more tasks!!!" },
   [110] = { boss = {"Professor Maxxen"}, Quantity = 2, reward = { statsPoint = 4, experience = 250000, storage = 0, items = { 40554, 80, 27604, 5, 28436, 1 } }, Storage = 39110, TakeTaskMessage = "Please kill that boss for me!!!", lastMessage = "Perfect, now you can grow more and do more tasks!!!" },
   [111] = { boss = {"Ursabeast"}, Quantity = 2, reward = { statsPoint = 4, experience = 250000, storage = 0, items = { 40554, 150, 21401, 2, 27604, 6, 41529, 2 } }, Storage = 39041, TakeTaskMessage = "Please kill that boss for me!!!", lastMessage = "Amazing!!! You finished all my missions, thats some glory for you!" },
    
	  
	   --- <<<<<<*******  Valandor Firestorm npc in Top of main house
   [112] = { itemsToBring = { 5920, 20, 5877, 20 }, TakeTaskMessage = 'I need those items for my work, get it mortal, you can find dragons by trying to find Demodras boss with commmand /bosses, its outside from Evotronus city to south!', reward = { statsPoint = 1, experience = 100000, storage = 0, items = { 40554, 20 } }, Storage = 39111, lastMessage = "Well done mortal, i see you got some fire in you, lets see how you handle my second mission!" },
   [113] = { itemsToBring = { 5882, 20, 5948, 20 }, TakeTaskMessage = 'Lets see how you will do this, try to find Demodras and you will find many dragon lords!', reward = { statsPoint = 2, experience = 120000, storage = 0, items = { 40554, 40, 2160, 30 } }, Storage = 39112, lastMessage = "Well done well done, you gaining my respect." }, -- ,
   [114] = { boss = {"Demodras"}, Quantity = 2, reward = { statsPoint = 3, experience = 140000, storage = 0, items = { 40554, 40, 21401, 1, 27604, 1 } }, Storage = 39113, TakeTaskMessage = "Lets see now if you can truly find and hunt this beast!", lastMessage = "Realy well done!." },
   [115] = { itemsToBring = { 5906, 20, 10553, 20, 6500, 20 }, reward = { statsPoint = 4, experience = 160000, storage = 0, items = { 40554, 50,  41529, 1 } }, Storage = 39114, TakeTaskMessage = "I need those items for my magic, bring it to me!", lastMessage = "Atlast you bring those items for me! Good Job!" },
   [116] = { itemsToBring = { 12614, 40, 10554, 40, 10581, 40 }, reward = { statsPoint = 5, experience = 180000, storage = 0, items = { 21401, 1, 8302, 1, 41529, 1, 40554, 50 } }, Storage = 39115, TakeTaskMessage = "I Need more items for my magic to work, bring those please!", lastMessage = "Well done warrior, you are realy worthy!" },
   [117] = { itemsToBring = { 15482, 50, 15483, 50, 15484, 50}, reward = { statsPoint = 6, experience = 200000, storage = 0, items = { 40554, 60, 27604, 1 } }, Storage = 39116, TakeTaskMessage = "Pleas bring me those items, lets do trade, i need to brew some potion to keep balance in Evotronus...!", lastMessage = "Good job, its time for me to brew some excelent potions to raise vibration of the continent, also here some reward for you!" },
   [118] = { boss = {"Batthus Bat"}, Quantity = 5, reward = { statsPoint = 7, experience = 220000, storage = 0, items = { 40554, 70, 21401, 1, 27604, 1, 41529, 1 } }, Storage = 39117, TakeTaskMessage = "This boss is near Evotronus city, use command /bosses to located the boss, don't forget scythe!", lastMessage = "Well done warrior, keep exploring!" },
   [119] = { itemsToBring = { 26179, 35, 6500, 100, 5893, 50 }, TakeTaskMessage = 'Im working on some spell barrier, i need you to bring me this itemas as fast as you can!', reward = { statsPoint = 8, experience = 300000, storage = 0, items = { 41529, 1, 40554, 80 } }, Storage = 39118, lastMessage = "Well done mighty soul, i see you got some fire in you!" },
   [120] = { boss = {"Raging Mage"}, Quantity = 6, TakeTaskMessage = 'i realy need your help with this mage, im so bored of him, can you take care of him for me?!', reward = { statsPoint = 9, experience = 320000, storage = 0, items = { 40554, 100, 41529, 5, 8306, 3, 28436, 1 } }, Storage = 39119, lastMessage = "Did you taste those hot peppers ?! wuuh... They strong... Thanks alot, here some reward for you!" }, -- ,
   
   
   
      --- <<<<<<*******  Elandra Nightwhisper npc , quests room
   [121] = { creature = {"Rotworm"}, Quantity = 130, reward = { statsPoint = 1, experience = 15000, storage = 0, items = { 40554, 10 } }, Storage = 39120, TakeTaskMessage = "Go go train on those rotworms!", lastMessage = "Oky oky, it was only rotworms, but there you go." },
   [122] = { itemsToBring = { 8982, 2 },reward = { statsPoint = 2, experience = 25000, storage = 0, items = { 40554, 20,  2160, 20 } }, Storage = 39121, TakeTaskMessage = "Get those dolls for me, egh dont ask why...", lastMessage = "atlast you gave me it, slow boy..." },
   [123] = { creature = {"Cyclops", "Cyclops Drone", "Cyclops Smith"}, Quantity = 250, reward = { statsPoint = 3, experience = 50000, storage = 0, items = { 21401, 1, 40554, 40 } }, Storage = 39122, TakeTaskMessage = "Near Evotronus city to south east you can find those Cyclops, also you can use command /bosses and find the horned fox, he is surrounded by Cyclops.", lastMessage = "Not bad not bad, here some reward for you." },
   [124] = { itemsToBring = { 5880, 4, 12409, 25, 12435, 2, 12433, 2},reward = { statsPoint = 4, experience = 100000, storage = 0, items = { 40554, 70, 27604, 2 } }, Storage = 39123, TakeTaskMessage = "Bring me those items right away!", lastMessage = "Thanks for the nice trade, take care!" },
   [125] = { boss = {"The Old Widow"}, Quantity = 3, reward = { statsPoint = 5, experience = 150000, storage = 0, items = { 40554, 80, 41529, 1 } }, Storage = 39124, TakeTaskMessage = "use command /bosses to located the boss", lastMessage = "well done warrior, keep exploring!" },
   [126] = { boss = {"Esmeralda"}, Quantity = 5, TakeTaskMessage = 'Just go and take care of this rat...!', reward = { statsPoint = 6, experience = 250000, storage = 0, items = { 41529, 1, 40554, 100 } }, Storage = 39125, lastMessage = "Well done well done, here some reward for you!" },
   [127] = { itemsToBring = { 5904, 40, 12659, 100, 12658, 100 }, TakeTaskMessage = 'I need those items to work on some new quests around here, so you better help me!', reward = { statsPoint = 7, experience = 350000, storage = 0, items = { 41529, 1, 8306, 2, 40554, 120 } }, Storage = 39126, lastMessage = "Good job good job, here some reward for you!" }, -- ,
   [128] = { creature = {"Glooth Bandit", "Glooth Brigand"}, Quantity = 300, reward = { statsPoint = 8, experience = 500000, storage = 0, items = { 40554, 150, 21401, 1, 27604, 1 } }, Storage = 39127, TakeTaskMessage = "Please clear those big bugs, i hate bugs... Those bugs can be found also in exploreable area!", lastMessage = "Thanks for completing this task, here some nice reward for you." },
   [129] = { creature = {"Plaguesmith", "Son of Verminor"}, Quantity = 400, reward = { statsPoint = 9, experience = 800000, storage = 0, items = { 27604, 2, 40554, 200, 8302, 1, 41529, 2 } }, Storage = 39128, TakeTaskMessage = "Please collect that items for me, its important to me...", lastMessage = "Oh, thanks alot, i thought you never will bring me this items, herre some reward for you :) " },
   
   

     --- <<<<<<*******  Solarien Gearmaster npc , quests room items tasker for boh, rh, dsm etc
   [130] = { creature = {"Dwarf", "Dwarf Soldier", "Dwarf Guard", "Dwarf Geomancer"}, Quantity = 180, reward = { statsPoint = 1, experience = 20000, storage = 0, items = { 40554, 20 } }, Storage = 39129, TakeTaskMessage = "I believe in you, you can hunt those dwarfs for me, don't forget to loot values!.", lastMessage = "There we go!" },
   [131] = { itemsToBring = { 2392, 6, 2432, 6, 2187, 6}, reward = { statsPoint = 2, experience = 30000, storage = 0, items = { 40554, 30, 27604, 5, 28436, 1 } }, Storage = 39130, TakeTaskMessage = "Pleas bring me those items, lets do trade!", lastMessage = "Thanks for the nice trade, take care!" },
   [132] = { itemsToBring = { 2195, 6, 2488, 6, 2487, 6, 2491, 6}, reward = { statsPoint = 3, experience = 60000, storage = 0, items = { 40554, 50, 21401, 1, 27604, 1, 41529, 1 } }, Storage = 39131, TakeTaskMessage = "Pleas bring me those items, lets do trade!", lastMessage = "well done warrior, keep exploring!" },
   [133] = { itemsToBring = { 15491, 5, 15490, 5, 15492, 5 }, TakeTaskMessage = 'Please bring me those items for it i will reward you!', reward = { statsPoint = 4, experience = 120000, storage = 0, items = { 41529, 5 } }, Storage = 39132, lastMessage = "nice, thanks, here you go also!" },
   [134] = { itemsToBring = { 2470, 5, 2514, 5, 2472, 5 }, TakeTaskMessage = 'Pleas bring me those items, lets do trade!', reward = { statsPoint = 5, experience = 240000, storage = 0, items = { 41529, 2, 8306, 3 } }, Storage = 39133, lastMessage = "Good good, atlast you bring me those heh, here something for you !" }, -- ,
   [135] = { itemsToBring = { 11302, 4, 12607, 4, 11304, 4, 12646, 4}, reward = { statsPoint = 6, experience = 480000, storage = 0, items = { 40554, 100, 21401, 1, 27604, 1, 13546, 1 } }, Storage = 39134, TakeTaskMessage = "Please bring me those items for me!", lastMessage = "Thanks for completing this task, here some nice reward for you." },
   [136] = { itemsToBring = { 26179, 30, 10518, 1, 11119, 1, 8889, 4, 2123, 4  }, reward = { statsPoint = 7, experience = 700000, storage = 0, items = { 27604, 2, 40554, 150, 8302, 3, 41529, 2 } }, Storage = 39135, TakeTaskMessage = "Please collect that items for me, its important to me...", lastMessage = "Oh, thanks alot, i thought you never will bring me this items, herre some reward for you :) " },
   [137] = { itemsToBring = { 6500, 100, 28632, 1, 5919, 3}, reward = { statsPoint = 8, experience = 850000, storage = 0, items = { 8302, 3, 41529, 3, 40554, 200 } }, Storage = 39136, TakeTaskMessage = "Pleas bring me those items, lets do trade!", lastMessage = "Thanks thanks thanks! Here something for you!" },
   [138] = { itemsToBring = { 15410, 2, 15412, 2, 15408, 2, 15407, 2, 15406, 2, 15413, 2, 15414, 2, 15404, 2},reward = { statsPoint = 9, experience = 1000000, storage = 0, items = { 40554, 250, 27604, 3, 28436, 1, 41533, 1 } }, Storage = 39137, TakeTaskMessage = "Pleas bring me those items, you can loot them from arena bosses near this Batthus Bat boss!", lastMessage = "Wow thats epic, i was waiting realy long time for this, here some epic reward for you!" },
   
   
   
   
   
   
   
   --- <<<<<<******* Ancient Women npc at hunt rooms tp
   [139] = { creature = {"Crocodile"}, Quantity = 1000, reward = { statsPoint = 1, experience = 10000, storage = 0, items = { 40554, 10, 41529, 1 } }, Storage = 39138, TakeTaskMessage = "Please hunt this creature for me", lastMessage = "Nicely done, you can continue with tasks if you want!" },
   [140] = { creature = {"Frost Dragon Hatchling"}, Quantity = 1000, TakeTaskMessage = 'Please bring me those items for it i will reward you!', reward = { statsPoint = 2, experience = 20000, storage = 0, items = { 41529, 2, 40554, 20 } }, Storage = 39139, lastMessage = "Nicely done, you can continue with tasks if you want!" },
   [141] = { creature = {"Dragon Lord"}, Quantity = 1000, TakeTaskMessage = 'Help me prepare for For hot pepper fiesta!, Please collect those items for me!', reward = { statsPoint = 3, experience = 30000, storage = 0, items = { 41529, 3, 40554, 30, 12666, 1 } }, Storage = 39140, lastMessage = "Nicely done, you can continue with tasks if you want!" }, -- ,
   [142] = { creature = {"Draken Warmaster"}, Quantity = 1000, reward = { statsPoint = 4, experience = 40000, storage = 0, items = { 41529, 4, 40554, 40, 12666, 1, 26144, 1, 36765, 1 } }, Storage = 39141, TakeTaskMessage = "Please hunt this creature for me", lastMessage = "Nicely done, you can continue with tasks if you want!" },
   [143] = { creature = {"Hellhound"}, Quantity = 1000, reward = { statsPoint = 5, experience = 50000, storage = 0, items = { 41529, 5, 40554, 50, 12666, 1, 26144, 1, 36765, 1 } }, Storage = 39142, TakeTaskMessage = "Please hunt this creature for me", lastMessage = "Nicely done, you can continue with tasks if you want!" },
   [144] = { creature = {"Infected Weeper"}, Quantity = 1000, reward = { statsPoint = 6, experience = 60000, storage = 0, items = { 41529, 6, 40554, 60, 12666, 1, 26144, 1, 36765, 1, 35420, 1 } }, Storage = 39143, TakeTaskMessage = "Please hunt this creature for me", lastMessage = "Nicely done, you can continue with tasks if you want!" },
   [145] = { creature = {"Draken Elite"}, Quantity = 1000, reward = { statsPoint = 7, experience = 70000, storage = 0, items = { 41529, 7, 40554, 70, 12666, 2, 26144, 1, 36765, 1, 35420, 1 } }, Storage = 39144, TakeTaskMessage = "Please hunt this creature for me", lastMessage = "Nicely done, you can continue with tasks if you want!" },
   [146] = { creature = {"Fury"}, Quantity = 1000, reward = { statsPoint = 8, experience = 80000, storage = 0, items = { 41529, 8, 40554, 80, 11754, 1, 26144, 1, 36765, 1, 35420, 1 } }, Storage = 39145, TakeTaskMessage = "Please hunt this creature for me", lastMessage = "Nicely done, you can continue with tasks if you want!" },
   [147] = { creature = {"Grim Reaper"}, Quantity = 1000, TakeTaskMessage = 'Please bring me those items for it i will reward you!', reward = { statsPoint = 9, experience = 90000, storage = 0, items = { 41529, 9, 40554, 90, 11754, 1, 26144, 2, 36765, 2, 35420, 1 } }, Storage = 39146, lastMessage = "Nicely done, you can continue with tasks if you want!" },
   [148] = { creature = {"Grave Robber"}, Quantity = 1000, TakeTaskMessage = 'Help me prepare for For hot pepper fiesta!, Please collect those items for me!', reward = { statsPoint = 10, experience = 100000, storage = 0, items = { 41529, 10, 40554, 100, 11754, 1, 26144, 3, 36765, 3, 35420, 1 } }, Storage = 39147, lastMessage = "Nicely done, you can continue with tasks if you want!" }, -- ,
   [149] = { creature = {"Inky"}, Quantity = 1000, reward = { statsPoint = 11, experience = 110000, storage = 0, items = { 41529, 11, 40554, 110, 11754, 1, 26144, 3, 36765, 3, 35420, 2 } }, Storage = 39148, TakeTaskMessage = "Please hunt this creature for me", lastMessage = "Nicely done, you can continue with tasks if you want!" },
   [150] = { creature = {"Infernatil"}, Quantity = 1000, reward = { statsPoint = 12, experience = 120000, storage = 0, items = { 41529, 12, 40554, 120, 11754, 2, 26144, 4, 36765, 4, 35420, 2, 40685, 1 } }, Storage = 39149, TakeTaskMessage = "Please hunt this creature for me", lastMessage = "Nicely done, you can continue with tasks if you want!" },
   [151] = { creature = {"Spectre", "Ghastly Dragon", "Glooth Anemone"}, Quantity = 4000, reward = { statsPoint = 13, experience = 130000, storage = 0, items = { 41529, 13, 40554, 130, 11754, 3, 26144, 5, 36765, 5, 35420, 3, 40685, 1 } }, Storage = 3915039150, TakeTaskMessage = "Please hunt this creature for me", lastMessage = "Well Well Done Super warrior! Sadly i don't have anymore any tasks!" },
   
   
   
   
   
   
   [152] = { itemsToBring = { 31949, 4, 26179, 25, 8982, 2}, reward = { statsPoint = 6, experience = 300000, storage = 0, items = { 40554, 80, 27604, 5, 28436, 1 } }, Storage = 39151, TakeTaskMessage = "Pleas bring me those items, lets do trade!", lastMessage = "Thanks for the nice trade, take care!" },
   [153] = { boss = {"Mutated Behemoth"}, Quantity = 5, reward = { statsPoint = 7, experience = 1000000, storage = 0, items = { 40554, 150, 21401, 2, 27604, 6, 41529, 2 } }, Storage = 39152, TakeTaskMessage = "This boss is located in first desert very far south east from main city, use command /bosses to located the boss", lastMessage = "well done warrior, keep exploring!" },
   
   
   --- <<<<<<******* Albert The Ritualist Dark Arts Library
   [154] = { itemsToBring = { 21394, 1}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35450, 1 } }, Storage = 39153, TakeTaskMessage = "Bring me player heart! You can get it only by killing other players!", lastMessage = "Oh you dirty boy!" },
   [155] = { itemsToBring = { 21394, 2}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35450, 1 } }, Storage = 39154, TakeTaskMessage = "Bring me more of those players hearts!", lastMessage = "Wow, do some pauze maybe!" },
   [156] = { creature = {"Necropharus"}, Quantity = 1, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35450, 1 } }, Storage = 39155, TakeTaskMessage = "Please hunt this boss for me, we got some ritual bussines with him... You can find this boss with command /bosses", lastMessage = "well done little explorer!" },
   [157] = { creature = {"Dark Hero"}, Quantity = 1, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35450, 1 } }, Storage = 39156, TakeTaskMessage = "Please hunt this boss for me, we got some ritual bussines with him... You can find this boss with command /bosses", lastMessage = "well done little explorer!" },
   [158] = { creature = {"Minishabaal"}, Quantity = 1, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35450, 2 } }, Storage = 39157, TakeTaskMessage = "Please hunt this boss for me, we got some ritual bussines with him... You can find this boss with command /bosses", lastMessage = "well done little explorer!" },
   [159] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39158, TakeTaskMessage = "Bring me more of those players hearts!", lastMessage = "Hunted! buahahah!" },
   [160] = { itemsToBring = { 21394, 4}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39159, TakeTaskMessage = "Bring me more of those players hearts!", lastMessage = "never surrender!" },
   [161] = { itemsToBring = { 21394, 5}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 2 } }, Storage = 39160, TakeTaskMessage = "Bring me more of those players hearts!", lastMessage = "Dinner ready!!" },
   
   
   
   
   [162] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39161, TakeTaskMessage = "Bring me more of those players hearts!", lastMessage = "Hunted! buahahah!" },
   [163] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39162, TakeTaskMessage = "Bring me more of those players hearts!", lastMessage = "Hunted! buahahah!" },
   
   
   [164] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39163, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   
   [165] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39164, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [166] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39165, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [167] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39166, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [168] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39167, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [169] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39168, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [170] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39169, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [171] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39170, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [172] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39171, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [173] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39172, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [174] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39173, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [175] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39174, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [176] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39175, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [177] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39176, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [178] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39177, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [179] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39178, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [180] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39179, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [181] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39180, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [182] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39181, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [183] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39182, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [184] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39183, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [185] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39184, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [186] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39185, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [187] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39186, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [188] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39187, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [189] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39188, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [190] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39189, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [191] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39190, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [192] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39191, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [193] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39192, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [194] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39193, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [195] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39194, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [196] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39195, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [197] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39196, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [198] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39197, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [199] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39198, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [200] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39199, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [201] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39200, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [202] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39201, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [203] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39202, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [204] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39203, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [205] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39204, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [206] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39205, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [207] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39206, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [208] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39207, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [209] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39208, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [210] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39209, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [211] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39210, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [212] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39211, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [213] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39212, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [214] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39213, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [215] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39214, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [216] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39215, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [217] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39216, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [218] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39217, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [219] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39218, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [220] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39219, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [221] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39220, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [222] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39221, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [223] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39222, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [224] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39223, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [225] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39224, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [226] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39225, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [227] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39226, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [228] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39227, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [229] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39228, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [230] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39229, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [231] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39230, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   [232] = { itemsToBring = { 21394, 3}, reward = { statsPoint = 0, experience = 0, storage = 0, items = { 35423, 1 } }, Storage = 39231, TakeTaskMessage = "Bri", lastMessage = "Hunt" },
   
   
   
   
   
   
   
   
   
}

function Player.addNpcReward(self, value)
   if not value or not value.items then
      error("You are missing some values in the table")
   end
   local items = value.items
   local statsPoint = value.statsPoint
   local experience = value.experience
   local storage = value.storage

   local message = ""
   local item_count = #items
   if item_count >= 2 and item_count % 2 == 0 then
       for i = 1, item_count, 2 do
           local item_id = items[i]
           local item_amount = items[i + 1]
           self:addItem(item_id, item_amount)
           message = message .. "You received: x" .. item_amount .. " " .. getItemName(item_id) .. ", "
       end
       message = string.sub(message, 1, -3) .. "."
   end

   if statsPoint > 0 then
       self:addStatsPoint(statsPoint)
       message = message .. " You received: " .. statsPoint .. " stats points. "
   end
   
   if experience > 0 then
       self:addExperience(experience)
       message = message .. "You received: " .. experience .. " experience points. "
   end
   
   if storage > 0 then
       self:setStorageValue(storage, 1)
       message = message .. "You received one quest access. "
   end
   
   self:sendTextMessage(MESSAGE_INFO_DESCR, message)
end