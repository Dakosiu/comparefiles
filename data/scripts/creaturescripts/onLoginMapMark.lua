marks = {
   [0] = { pos = { x = 822, y = 872, z = 5 }, type = MAPMARK_STAR, description = "Evotronus MainHouse/Depot/Teleports" },
   [1] = { pos = { x = 847, y = 875, z = 5 }, type = MAPMARK_TEMPLE, description = "The Only One, Evotronus Temple" },
   [2] = { pos = { x = 833, y = 924, z = 5 }, type = MAPMARK_CROSS, description = "The Temple of Dragonia(vocation take place)" },
   [3] = { pos = { x = 904, y = 916, z = 6 }, type = MAPMARK_DOLLAR, description = "Vegrico, Equipments buyer(you can sell items here)" },
   [4] = { pos = { x = 851, y = 909, z = 5 }, type = MAPMARK_SKULL, description = "Weaponary shops" },
   [5] = { pos = { x = 805, y = 886, z = 5 }, type = MAPMARK_KISS, description = "Furniture shop" },
   [6] = { pos = { x = 788, y = 862, z = 4 }, type = MAPMARK_DOLLAR, description = "Fiona, Creature products buyer" },
   [7] = { pos = { x = 882, y = 882, z = 5 }, type = MAPMARK_DOLLAR, description = "Malunga, Creature products buyer" },
   [8] = { pos = { x = 894, y = 868, z = 5 }, type = MAPMARK_SWORD, description = "Syndra, Grasslands Tasker" },
   [9] = { pos = { x = 975, y = 886, z = 6 }, type = MAPMARK_STAR, description = "Stamina Trainers place" },
   [10] = { pos = { x = 1155, y = 1037, z = 7 }, type = MAPMARK_TEMPLE, description = "The first desert, safe house" },
}

--[[--
MAPMARK_TICK = 0,
    MAPMARK_QUESTION = 1,
    MAPMARK_EXCLAMATION = 2,
    MAPMARK_STAR = 3,
    MAPMARK_CROSS = 4,
    MAPMARK_TEMPLE = 5,
    MAPMARK_KISS = 6,
    MAPMARK_SHOVEL = 7,
    MAPMARK_SWORD = 8,
    MAPMARK_FLAG = 9,
    MAPMARK_LOCK = 10,
    MAPMARK_BAG = 11,
    MAPMARK_SKULL = 12,
    MAPMARK_DOLLAR = 13,
    MAPMARK_REDNORTH = 14,
    MAPMARK_REDSOUTH = 15,
    MAPMARK_REDEAST = 16,
    MAPMARK_REDWEST = 17,
    MAPMARK_GREENNORTH = 18,
 MAPMARK_GREENSOUTH = 19,
--]]

local creatureevent = CreatureEvent("MapMarks")

function creatureevent.onLogin(player)
   --if player:getLastLoginSaved() <= 0 then
      for i = 0, #marks do
         player:addMapMark(marks[i].pos, marks[i].type, marks[i].description)
     end
   --end
   return true
end

creatureevent:register()
