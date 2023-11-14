--[[
local config = {
   Timers = {
      areaDamageSeconds = 4.5,
      rangeDamageSeconds = 2,
   },
   areaDamagePositions = {
      { Position = { 1052, 1063, 7 }, range = 3, effect = 376, damage = 15, percent = true , pattern = 4 }, -- 2 stat points near orsha
      { Position = { 1055 , 1046, 1 }, range = 4, effect = 362, damage = 26, percent = true , pattern = 5 }, -- teleport to morga island
      { Position = { 984, 973, 8 }, range = 2, effect = 47, damage = 5, percent = true , pattern = 1 }, -- troll place south east from evotronus
	  { Position = { 953, 986, 8 }, range = 2, effect = 47, damage = 5, percent = true , pattern = 1 }, -- troll place south east from evotronus
	  { Position = { 952, 969, 8 }, range = 2, effect = 47, damage = 5, percent = true , pattern = 1 }, -- troll place south east from evotronus
	  { Position = { 972, 974, 8 }, range = 2, effect = 47, damage = 5, percent = true , pattern = 1 }, -- troll place south east from evotronus
	  { Position = { 1014, 975, 8 }, range = 2, effect = 47, damage = 5, percent = true , pattern = 1 }, -- troll place south east from evotronus
	  { Position = { 1029, 968, 8 }, range = 2, effect = 47, damage = 5, percent = true , pattern = 1 }, -- troll place south east from evotronus
	  { Position = { 1023, 949, 8 }, range = 2, effect = 47, damage = 5, percent = true , pattern = 1 }, -- troll place south east from evotronus
	  { Position = { 1033, 959, 9 }, range = 5, effect = 286, damage = 11, percent = true , pattern = 7 }, -- dark troll boss place
	  { Position = { 981, 879, 8 }, range = 5, effect = 3, damage = 7, percent = true , pattern = 7 }, -- the horned fox boss place
	  { Position = { 987, 879, 8 }, range = 5, effect = 3, damage = 7, percent = true , pattern = 7 }, -- the horned fox boss place
	  { Position = { 812, 871, 3 }, range = 2, effect = 16, damage = 8, percent = true , pattern = 2 }, -- top floor main house
	  { Position = { 1112 , 977, 7 }, range = 5, effect = 444, damage = 44, percent = true , pattern = 6 }, -- way to east lands
	  { Position = { 778, 957, 10 }, range = 2, effect = 54, damage = 11, percent = true , pattern = 1 }, -- deep under evotronus, in waters 
	  { Position = { 784, 964, 10 }, range = 2, effect = 54, damage = 11, percent = true , pattern = 1 }, -- deep under evotronus, in waters 
	  { Position = { 801, 952, 10 }, range = 2, effect = 54, damage = 11, percent = true , pattern = 1 }, -- deep under evotronus, in waters 
	  { Position = { 794, 947, 11 }, range = 2, effect = 54, damage = 11, percent = true , pattern = 1 }, -- deep under evotronus, in waters 
	  { Position = { 804, 937, 11 }, range = 2, effect = 54, damage = 11, percent = true , pattern = 1 }, -- deep under evotronus, in waters 
	  { Position = { 814, 935, 11 }, range = 2, effect = 54, damage = 11, percent = true , pattern = 1 }, -- deep under evotronus, in waters 
	  { Position = { 814, 926, 11 }, range = 2, effect = 54, damage = 11, percent = true , pattern = 1 }, -- deep under evotronus, in waters 
	  { Position = { 780, 949, 10 }, range = 2, effect = 54, damage = 11, percent = true , pattern = 1 }, -- deep under evotronus, in waters 
	  { Position = { 783, 944, 10 }, range = 2, effect = 54, damage = 11, percent = true , pattern = 1 }, -- deep under evotronus, in waters 
	  { Position = { 726, 849, 13 }, range = 5, effect = 289, damage = 22, percent = true , pattern = 7 }, -- water elements place under evotronus
	  { Position = { 729, 856, 13 }, range = 5, effect = 289, damage = 22, percent = true , pattern = 7 }, -- water elements place under evotronus
	  { Position = { 776, 966, 6 }, range = 2, effect = 327, damage = 44, percent = true , pattern = 2 }, -- behind 2x goblins arena
	  { Position = { 781, 966, 6 }, range = 2, effect = 327, damage = 44, percent = true , pattern = 2 }, -- behind 2x goblins arena
	  { Position = { 776, 969, 6 }, range = 2, effect = 327, damage = 44, percent = true , pattern = 2 }, -- behind 2x goblins arena
	  { Position = { 781, 969, 6 }, range = 2, effect = 327, damage = 44, percent = true , pattern = 2 }, -- behind 2x goblins arena
	  { Position = { 776, 972, 6 }, range = 2, effect = 327, damage = 44, percent = true , pattern = 2 }, -- behind 2x goblins arena
	  { Position = { 781, 972, 6 }, range = 2, effect = 327, damage = 44, percent = true , pattern = 2 }, -- behind 2x goblins arena
	  { Position = { 868, 954, 7 }, range = 2, effect = 357, damage = 22, percent = true , pattern = 1 }, -- vampires quest near houses in evotronus city
	  { Position = { 524, 2805, 11 }, range = 5, effect = 16, damage = 11, percent = true , pattern = 7 }, -- 50 cc quest
	  { Position = { 537, 2806, 11 }, range = 5, effect = 16, damage = 11, percent = true , pattern = 7 }, -- 50 cc quest
	  { Position = { 524, 2813, 11 }, range = 5, effect = 16, damage = 11, percent = true , pattern = 7 }, -- 50 cc quest
	  
	  
	  { Position = { 523, 3250, 7 }, range = 5, effect = 7, damage = 66, percent = true , pattern = 7 }, -- books backpack quest in quest room
	  { Position = { 513, 3210, 7 }, range = 5, effect = 14, damage = 37, percent = true , pattern = 7 }, -- books backpack quest in quest room
	  
	  
	  { Position = { 278, 3715, 9 }, range = 5, effect = 18, damage = 75, percent = true , pattern = 7 }, -- First regen point quest in quests room
	  { Position = { 259, 3738, 10 }, range = 5, effect = 18, damage = 85, percent = true , pattern = 7 }, -- First regen point quest in quests room
	  
	  { Position = { 394, 4466, 15 }, range = 5, effect = 46, damage = 44, percent = true , pattern = 7 }, -- first boots quest in quests room
	  { Position = { 392, 4474, 14 }, range = 5, effect = 46, damage = 46, percent = true , pattern = 7 }, -- first boots quest in quests room
	  { Position = { 393, 4486, 14 }, range = 5, effect = 46, damage = 48, percent = true , pattern = 7 }, -- first boots quest in quests room
	  { Position = { 385, 4499, 14 }, range = 5, effect = 46, damage = 52, percent = true , pattern = 7 }, -- first boots quest in quests room
	  { Position = { 386, 4512, 14 }, range = 5, effect = 46, damage = 56, percent = true , pattern = 7 }, -- first boots quest in quests room
	  { Position = { 377, 4515, 14 }, range = 5, effect = 46, damage = 60, percent = true , pattern = 7 }, -- first boots quest in quests room
	  { Position = { 368, 4508, 14 }, range = 5, effect = 46, damage = 64, percent = true , pattern = 7 }, -- first boots quest in quests room
	  { Position = { 357, 4514, 14 }, range = 5, effect = 46, damage = 70, percent = true , pattern = 7 }, -- first boots quest in quests room
	  { Position = { 485, 2800, 11 }, range = 2, effect = 16, damage = 44, percent = true , pattern = 2 }, -- dimension wand and shimmer rod
	  { Position = { 490, 2800, 11 }, range = 2, effect = 16, damage = 44, percent = true , pattern = 2 }, -- dimension wand and shimmer rod
	  
   },
   rangeDamagePositions = {
      { fromPos = { 159, 1991, 12 }, toPos = { 175, 1991, 12 }, missile = 90, effect = 2, damage = 1000, percent = false },
	  
	  -- 100cc quest in quests ROOM
      { fromPos = { 439, 3310, 7 }, toPos = { 379, 3310, 7 }, missile = 30, effect = 9, damage = 25, percent = true },
	  
	  	  -- FIRST RING QUEST, in quest room
      { fromPos = { 157, 2301, 4 }, toPos = { 157, 2314, 4 }, missile = 4, effect = 0, damage = 10, percent = true },
      { fromPos = { 161, 2301, 4 }, toPos = { 161, 2314, 4 }, missile = 4, effect = 0, damage = 20, percent = true },
	  { fromPos = { 165, 2301, 4 }, toPos = { 165, 2314, 4 }, missile = 4, effect = 0, damage = 30, percent = true },
	  { fromPos = { 169, 2301, 4 }, toPos = { 169, 2314, 4 }, missile = 4, effect = 0, damage = 40, percent = true },
	  { fromPos = { 173, 2301, 4 }, toPos = { 173, 2314, 4 }, missile = 4, effect = 0, damage = 50, percent = true },
	  { fromPos = { 177, 2301, 4 }, toPos = { 177, 2314, 4 }, missile = 60, effect = 0, damage = 60, percent = true },
	  { fromPos = { 181, 2301, 4 }, toPos = { 181, 2314, 4 }, missile = 60, effect = 0, damage = 70, percent = true },
	  { fromPos = { 185, 2301, 4 }, toPos = { 185, 2314, 4 }, missile = 60, effect = 0, damage = 80, percent = true },
	  { fromPos = { 189, 2301, 4 }, toPos = { 189, 2314, 4 }, missile = 60, effect = 0, damage = 90, percent = true },
	  
	  	  -- First regen point quest in quests room
      { fromPos = { 257, 3712, 9 }, toPos = { 257, 3701, 9 }, missile = 75, effect = 1, damage = 75, percent = true },
	  { fromPos = { 260, 3701, 9 }, toPos = { 260, 3712, 9 }, missile = 75, effect = 1, damage = 75, percent = true },
	  { fromPos = { 263, 3712, 9 }, toPos = { 263, 3701, 9 }, missile = 75, effect = 1, damage = 75, percent = true },
	  { fromPos = { 266, 3701, 9 }, toPos = { 266, 3712, 9 }, missile = 75, effect = 1, damage = 75, percent = true },
	  { fromPos = { 269, 3712, 9 }, toPos = { 269, 3701, 9 }, missile = 75, effect = 1, damage = 75, percent = true },
	  
	  { fromPos = { 307, 3711, 9 }, toPos = { 307, 3726, 9 }, missile = 32, effect = 18, damage = 80, percent = true },
	  { fromPos = { 308, 3711, 9 }, toPos = { 308, 3726, 9 }, missile = 32, effect = 18, damage = 80, percent = true },
	  { fromPos = { 309, 3711, 9 }, toPos = { 309, 3726, 9 }, missile = 32, effect = 18, damage = 80, percent = true },
	  
	  
	  -- 6 Stats points quests(3x inq rooms)
	  { fromPos = { 428, 3218, 7 }, toPos = { 428, 3223, 7 }, missile = 0, effect = 16, damage = 35, percent = true },
	  { fromPos = { 429, 3218, 7 }, toPos = { 429, 3223, 7 }, missile = 0, effect = 16, damage = 35, percent = true },
	  { fromPos = { 430, 3218, 7 }, toPos = { 430, 3223, 7 }, missile = 0, effect = 16, damage = 35, percent = true },
	  { fromPos = { 449, 3195, 7 }, toPos = { 409, 3195, 7 }, missile = 60, effect = 223, damage = 45, percent = true },
	  { fromPos = { 449, 3196, 7 }, toPos = { 409, 3196, 7 }, missile = 60, effect = 223, damage = 45, percent = true },
	  { fromPos = { 449, 3197, 7 }, toPos = { 409, 3197, 7 }, missile = 60, effect = 223, damage = 45, percent = true },
	  { fromPos = { 449, 3198, 7 }, toPos = { 409, 3198, 7 }, missile = 60, effect = 223, damage = 45, percent = true },
	  { fromPos = { 449, 3199, 7 }, toPos = { 409, 3199, 7 }, missile = 60, effect = 223, damage = 45, percent = true },
	  
	  -- 3 simple weps quest ( first mele weps quest) at quests room
	  { fromPos = { 525, 2720, 11 }, toPos = { 493, 2720, 11 }, missile = 4, effect = 1, damage = 10, percent = true },
	  
	  -- hailstorm rod and woi quest at quests room
	  { fromPos = { 560, 2848, 11 }, toPos = { 560, 2750, 11 }, missile = 4, effect = 1, damage = 5, percent = true },
	  { fromPos = { 562, 2848, 11 }, toPos = { 562, 2750, 11 }, missile = 4, effect = 1, damage = 5, percent = true },
	  { fromPos = { 561, 2754, 11 }, toPos = { 561, 2846, 11 }, missile = 4, effect = 1, damage = 5, percent = true },
	  -- 10 amber coin quest in quest ROOM
	  { fromPos = { 817, 2202, 7 }, toPos = { 685, 2202, 7 }, missile = 29, effect = 375, damage = 35, percent = true },
	  { fromPos = { 825, 2203, 7 }, toPos = { 685, 2203, 7 }, missile = 29, effect = 375, damage = 35, percent = true },
	  
	  -- Ghazbaran boss room
	  { fromPos = { 1178, 1225, 15 }, toPos = { 1192, 1225, 15 }, missile = 32, effect = 18, damage = 22, percent = true },
	  { fromPos = { 1178, 1221, 15 }, toPos = { 1192, 1221, 15 }, missile = 32, effect = 18, damage = 22, percent = true },
	  { fromPos = { 1183, 1218, 15 }, toPos = { 1183, 1235, 15 }, missile = 32, effect = 18, damage = 22, percent = true },
	  { fromPos = { 1187, 1218, 15 }, toPos = { 1187, 1235, 15 }, missile = 32, effect = 18, damage = 22, percent = true },
	  
	  -- first promotion npc
	  { fromPos = { 1172, 1090, 14 }, toPos = { 1180, 1090, 14 }, missile = 61, effect = 341, damage = 45, percent = true },
	  { fromPos = { 1172, 1091, 14 }, toPos = { 1180, 1091, 14 }, missile = 61, effect = 341, damage = 45, percent = true },
	  { fromPos = { 1172, 1092, 14 }, toPos = { 1180, 1092, 14 }, missile = 61, effect = 341, damage = 45, percent = true },
	  	  -- first promotion npc - desert enter
	  { fromPos = { 1183, 1055, 7 }, toPos = { 1183, 1069, 7 }, missile = 66, effect = 210, damage = 7, percent = true },
	  { fromPos = { 1183, 1083, 7 }, toPos = { 1183, 1069, 7 }, missile = 66, effect = 210, damage = 7, percent = true },
	  -- teleport to morga place
	  { fromPos = { 1055, 1041, 1 }, toPos = { 1055, 1046, 7 }, missile = 88, effect = 362, damage = 17, percent = true },
	  { fromPos = { 1055, 1051, 1 }, toPos = { 1055, 1046, 7 }, missile = 88, effect = 362, damage = 17, percent = true },
	  
	  -- top floor main house
	  { fromPos = { 809, 868, 3 }, toPos = { 815, 868, 3 }, missile = 4, effect = 0, damage = 8, percent = true },
	  { fromPos = { 815, 868, 3 }, toPos = { 815, 874, 3 }, missile = 4, effect = 0, damage = 8, percent = true },
	  { fromPos = { 815, 874, 3 }, toPos = { 809, 874, 3 }, missile = 4, effect = 0, damage = 8, percent = true },
	  { fromPos = { 809, 874, 3 }, toPos = { 809, 868, 3 }, missile = 4, effect = 0, damage = 8, percent = true },
	  
	  -- crocodile place behind locked doors, near teleport
	  { fromPos = { 898, 852, 7 }, toPos = { 898, 868, 7 }, missile = 15, effect = 17, damage = 8, percent = true },
	  
	  -- daily room, daily quest
	  { fromPos = { 85, 2205, 12 }, toPos = { 85, 2225, 12 }, missile = 75, effect = 0, damage = 22, percent = true },
	  
	  -- 25 amber coin and 4 stat point quest
	  { fromPos = { 228, 2220, 10 }, toPos = { 228, 2226, 10 }, missile = 70, effect = 341, damage = 26, percent = true },
	  { fromPos = { 229, 2226, 10 }, toPos = { 229, 2220, 10 }, missile = 70, effect = 341, damage = 26, percent = true },
	  { fromPos = { 230, 2220, 10 }, toPos = { 230, 2226, 10 }, missile = 70, effect = 341, damage = 26, percent = true },
	  { fromPos = { 231, 2226, 10 }, toPos = { 231, 2220, 10 }, missile = 70, effect = 341, damage = 26, percent = true },
	  { fromPos = { 232, 2220, 10 }, toPos = { 232, 2226, 10 }, missile = 70, effect = 341, damage = 26, percent = true },
	  { fromPos = { 233, 2226, 10 }, toPos = { 233, 2220, 10 }, missile = 70, effect = 341, damage = 26, percent = true },
	  { fromPos = { 234, 2220, 10 }, toPos = { 234, 2226, 10 }, missile = 70, effect = 341, damage = 26, percent = true },
	  { fromPos = { 235, 2226, 10 }, toPos = { 235, 2220, 10 }, missile = 70, effect = 341, damage = 26, percent = true },
	  
	  
	  
	  
	  	  -- Soft boots quest
	  { fromPos = { 102, 2288, 11 }, toPos = { 102, 2310, 10 }, missile = 32, effect = 18, damage = 53, percent = true },
	  { fromPos = { 103, 2288, 11 }, toPos = { 103, 2310, 10 }, missile = 32, effect = 18, damage = 53, percent = true },
	  
	  { fromPos = { 125, 2297, 11 }, toPos = { 131, 2297, 11 }, missile = 4, effect = 337, damage = 53, percent = true },
	  { fromPos = { 125, 2296, 11 }, toPos = { 131, 2296, 11 }, missile = 4, effect = 337, damage = 53, percent = true },
	  { fromPos = { 125, 2295, 11 }, toPos = { 131, 2295, 11 }, missile = 4, effect = 337, damage = 53, percent = true },
	  
	  
	  
   }
}

local patterns = {
   [1] = {
      {'x','y','y','y','x'},
      {'y','y','y','y','y'},
      {'y','y','y','y','y'},
      {'y','y','y','y','y'},
      {'x','y','y','y','x'},
   },
   [2] = {
      {'x','x','x','x','x'},
      {'x','x','y','x','x'},
      {'y','y','x','y','y'},
      {'x','x','y','x','x'},
      {'x','x','x','x','x'},
   },
   [3] = {
      {'x','y','y','y','x'},
      {'x','y','x','y','x'},
      {'x','y','y','y','x'},
      {'x','y','x','x','x'},
      {'x','y','x','x','x'},
   },
   [4] = {
      {'x','x','x','y','x','x','x'},
	  {'x','x','y','y','y','x','x'},
      {'x','y','y','y','y','y','x'},
      {'y','y','y','x','y','y','y'},
	  {'x','y','y','y','y','y','x'},
      {'x','x','y','y','y','x','x'},
      {'x','x','x','y','x','x','x'},
   },
   [5] = {
      {'x','x','x','x','x','x','x','x','y'},
	  {'x','x','x','x','x','x','x','y','y'},
	  {'x','x','x','x','x','x','y','y','y'},
      {'x','x','x','x','x','y','y','y','y'},
      {'x','x','x','x','y','y','y','y','y'},
	  {'x','x','x','x','x','y','y','y','y'},
      {'x','x','x','x','x','x','y','y','y'},
      {'x','x','x','x','x','x','x','y','y'},
	  {'x','x','x','x','x','x','x','x','y'},
   },
   [6] = {
      {'y','x','x','x','x','x','x','x','x','x','y'},
	  {'y','y','x','x','x','x','x','x','x','y','y'},
	  {'y','y','y','x','x','x','x','x','y','y','y'},
	  {'y','y','y','y','x','x','x','y','y','y','y'},
      {'y','y','y','y','y','x','y','y','y','y','y'},
      {'y','y','y','y','y','y','y','y','y','y','y'},
	  {'y','y','y','y','y','x','y','y','y','y','y'},
      {'y','y','y','y','x','x','x','y','y','y','y'},
      {'y','y','y','x','x','x','x','x','y','y','y'},
	  {'y','y','x','x','x','x','x','x','x','y','y'},
	  {'y','x','x','x','x','x','x','x','x','x','y'},
   },
   [7] = {
      {'x','x','x','x','x','y','x','x','x','x','x'},
	  {'x','y','x','x','x','y','x','x','x','y','x'},
	  {'x','x','y','x','x','y','x','x','y','x','x'},
	  {'x','x','x','y','x','y','x','y','x','x','x'},
      {'x','x','x','x','y','y','y','x','x','x','x'},
      {'y','y','y','y','y','y','y','y','y','y','y'}, -- 
	  {'x','x','x','x','y','y','y','x','x','x','x'},
      {'x','x','x','y','x','y','x','y','x','x','x'},
      {'x','x','y','x','x','y','x','x','y','x','x'},
	  {'x','y','x','x','x','y','x','x','x','y','x'},
	  {'x','x','x','x','x','y','x','x','x','x','x'},
   },
   [8] = {
      {'x','x','x','x','x','x','y','x','x','x','x','x','x'},
	  {'y','x','x','x','x','x','y','x','x','x','x','x','y'},
	  {'x','y','x','x','x','x','y','x','x','x','x','y','x'},
	  {'x','x','y','x','x','x','y','x','x','x','y','x','x'},
	  {'x','x','x','y','x','x','y','x','x','y','x','x','x'},
	  {'x','x','x','x','y','x','y','x','y','x','x','x','x'},
	  {'x','x','x','x','x','y','y','y','x','x','x','x','x'},
	  {'y','y','y','y','y','y','O','y','y','y','y','y','y'},
      {'x','x','x','x','x','y','y','y','x','x','x','x','x'},
      {'x','x','x','x','y','x','y','x','y','x','x','x','x'}, -- 
	  {'x','x','x','y','x','x','y','x','x','y','x','x','x'},
      {'x','x','y','x','x','x','y','x','x','x','y','x','x'},
      {'x','y','x','x','x','x','y','x','x','x','x','y','x'},
	  {'y','x','x','x','x','x','y','x','x','x','x','x','y'},
	  {'x','x','x','x','x','x','y','x','x','x','x','x','x'},
   }
}

function inRangeEffect(initialPosition, range, effect, damage, percent, pattern)
   for x = -range, range do
      for y = -range, range do
         local skip = false
         if pattern then
            local patternX = x + range + 1
            local patternY = y + range + 1
            if pattern[patternY] and pattern[patternY][patternX] then
               if pattern[patternY][patternX] == 'x' then
                  skip = true
               end
            end
         end
         if not skip then
            local pos = Position(initialPosition.x + x, initialPosition.y + y, initialPosition.z)
            pos:sendMagicEffect(effect)
            local tile = Tile(pos) 
            if tile then
               local person = tile:getTopCreature()
               if person and person:isPlayer() then
                  if percent == true then
                     local totalDamage = person:getMaxHealth() * (damage / 100)
                     doTargetCombat(0, person, COMBAT_PHYSICALDAMAGE, totalDamage, totalDamage, CONST_ME_EXPLOSIONHIT)
                  else
                     doTargetCombat(0, person, COMBAT_PHYSICALDAMAGE, damage, damage, CONST_ME_EXPLOSIONHIT)
                  end
               end
            end
         end
      end
   end
end

local it = config
local globalEvent = GlobalEvent("areaDamage_onThink")

function globalEvent.onThink(interval)
   for index, this in pairs(it.areaDamagePositions) do
      local a = this.Position
      local pos = Position(a[1], a[2], a[3])
      local spectators = Game.getSpectators(pos, true, true, 14 + this.range, 14 + this.range, 8 + this.range, 8 + this.range)
      if #spectators >= 1 then
         inRangeEffect(pos, this.range, this.effect, this.damage, this.percent, patterns[this.pattern])
      end
   end
   return true
end

globalEvent:interval(it.Timers.areaDamageSeconds * 1000)
globalEvent:register()

function Position:getDirection(toPosition)
   local dx = toPosition.x - self.x
   local dy = toPosition.y - self.y
   local adx = math.abs(dx)
   local ady = math.abs(dy)
   if adx > ady then
       if dx > 0 then
           return DIRECTION_EAST
       else
           return DIRECTION_WEST
       end
   else
       if dy > 0 then
           return DIRECTION_SOUTH
       else
           return DIRECTION_NORTH
       end
   end
end

function Position:sendDistanceAnimateEffect(toPosition, distanceEffect, queueEffect, damage, percent)
   local distance = self:getDistance(toPosition)
   local direction = self:getDirection(toPosition)
   local pos = Position(self.x, self.y, self.z)
   for i = 1, distance do
       local nextPos = Position(pos.x, pos.y, pos.z)
       nextPos:getNextPosition(direction)
       addEvent(function (pos, nextPos)
         if queueEffect ~= 0 then
            pos:sendMagicEffect(queueEffect)
         end
           pos:sendDistanceEffect(nextPos, distanceEffect)
		   local tile = Tile(nextPos)
		   if tile then
              local creatures = tile:getCreatures()
		      if creatures then
			     for _, creature in pairs(creatures) do
				    if creature:isPlayer() then
					  if percent == true then
						 local totalDamage = creature:getMaxHealth() * (damage / 100)
						 doTargetCombat(0, creature, COMBAT_PHYSICALDAMAGE, totalDamage, totalDamage, CONST_ME_EXPLOSIONHIT)
					  else
						 doTargetCombat(0, creature, COMBAT_PHYSICALDAMAGE, damage, damage, CONST_ME_EXPLOSIONHIT)
					  end
				   end
			      end
			   end
		   end
       end, 125 * i, pos, nextPos)
       pos = nextPos
   end
end

local globalEvent = GlobalEvent("missileDamage_onThink")
function globalEvent.onThink(interval)
   for _, execute in pairs(config.rangeDamagePositions) do 
      local a = execute.fromPos
      local b = execute.toPos
      Position(a[1], a[2], a[3]):sendDistanceAnimateEffect(Position(b[1], b[2], b[3]), execute.missile, execute.effect, execute.damage, execute.percent)
   end
   return true
end

globalEvent:interval(config.Timers.rangeDamageSeconds * 1000)
globalEvent:register()
--]]