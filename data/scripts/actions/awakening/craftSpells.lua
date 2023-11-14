--[CustomSkill]-- By: Athern
function Player.getCustomSkill(self, storage)
  return self:getStorageValue(storage)
end

function Player.addCustomSkill(self, skillName, storage)
  local skillStorage = math.max(10, self:getStorageValue(storage))
  local skillTries = math.max(0, self:getStorageValue(storage + 1))
  self:setStorageValue(storage, skillStorage + 1)
  self:sendTextMessage(MESSAGE_EVENT_ADVANCE,
    "You advanced to " .. string.lower(skillName) .. " level " .. self:getCustomSkill(storage) .. ".")
  self:setStorageValue(storage + 1, 0)
end

function Player.addCustomSkillTry(self, skillName, storage)
  local skillStorage = math.max(10, self:getStorageValue(storage))
  local skillTries = math.max(0, self:getStorageValue(storage + 1))
  self:setStorageValue(storage + 1, skillTries + 1)
  if skillTries > math.floor(20 * math.pow(1.1, (skillStorage - 11)) / 10) then
    self:addCustomSkill(skillName, storage)
  end
end

function Player.getCustomSkillPercent(self, storage)
  local skillStorage = math.max(10, self:getStorageValue(storage))
  local skillTries = math.max(0, self:getStorageValue(storage + 1))
  local triesNeeded = math.floor(20 * math.pow(1.1, (skillStorage - 11)) / 10)
  local percent = math.floor(100 * (1 - skillTries / triesNeeded))
  if percent > 1 and percent <= 100 then
    return percent
  else
    percent = 1
    return percent
  end
end

--[/CustomSkill]--

local storValue = 34
function Player.isProfession(self, storage)
   if self:getStorageValue(storage) == storValue then
     return true
   end
   return false
end




craftingProfessionsConfig = {
  [50501] = {
    skillName = "Blacksmithing",
    skillRecipes = {
[1] = { item = 5908, skill = 10, storage = 101, mats = { { 5880, 30 }, { 5878, 15 }, { 26180, 50 } }, time = 10, difficulty = 2 },
      [2] = { item = 5942, skill = 15, storage = 102, mats = { { 5904, 15 }, { 11305, 1 }, { 26180, 70 } }, time = 15, difficulty = 5 },
      [3] = { item = 28632, skill = 20, storage = 103, mats = { { 6558, 100 }, { 6500, 100 }, { 5954, 100 }, { 2153, 3 }, { 26180, 100 } }, time = 20, difficulty = 10 }, -- stat reset pot
      [4] = { item = 41510, skill = 20, storage = 104, mats = { { 41511, 1 }, { 5904, 100 }, { 41742, 10 }, { 40554, 100 }, { 9971, 50 } }, time = 25, difficulty = 20 },
      [5] = { item = 41316, skill = 25, storage = 105, mats = { { 41697, 20 }, { 32714, 20 }, { 41742, 20 }, { 41529, 3 }, { 40554, 50 } }, time = 25, difficulty = 50 },
      [6] = { item = 41311, skill = 30, storage = 106, mats = { { 41316, 1 }, { 41529, 10 }, { 12614, 50 }, { 41697, 50 }, { 41742, 50 }, { 40554, 100 }, { 9971, 100 } }, time = 35, difficulty = 60 },
	  [7] = { item = 40564, skill = 35, storage = 107, mats = { { 41311, 1 }, { 41529, 25 }, { 41739, 10 }, { 41696, 20 }, { 41742, 10 }, { 40554, 200 }, { 13870, 100 }, { 15455, 100 }, { 15421, 100 }, { 9971, 200 } }, time = 40, difficulty = 65 },
	  
	  ---Berserker axes 2-6
	  [8] = { item = 28677, skill = 15, storage = 108, mats = { { 28676, 1 }, { 41697, 30 }, { 8844, 2000 }, { 41529, 5 }, { 41530, 1 }, { 40554, 100 } }, time = 25, difficulty = 30 },
	  [9] = { item = 28678, skill = 20, storage = 109, mats = { { 28677, 1 }, { 41697, 60 }, { 8844, 6000 }, { 41529, 15 }, { 41530, 3 }, { 40554, 250 } }, time = 35, difficulty = 40 },
	  [10] = { item = 28679, skill = 25, storage = 110, mats = { { 28678, 1 }, { 41697, 100 }, { 8844, 16000 }, { 41529, 40 }, { 41530, 5 }, { 40554, 500 } }, time = 45, difficulty = 50 },
	  [11] = { item = 28680, skill = 30, storage = 111, mats = { { 28679, 1 }, { 41694, 2 }, { 8844, 30000 }, { 41529, 80 }, { 41530, 10 }, { 40554, 1000 } }, time = 55, difficulty = 70 },
	  [12] = { item = 28681, skill = 40, storage = 112, mats = { { 28680, 1 }, { 41694, 4 }, { 8844, 66600 }, { 41529, 200 }, { 41530, 20 }, { 40554, 2500 } }, time = 65, difficulty = 90 },
	  ---Knights axes 2-6
	  [13] = { item = 22405, skill = 15, storage = 113, mats = { { 22404, 1 }, { 5878, 20 }, { 5913, 10 }, { 5925, 10 }, { 5879, 10 }, { 23553, 25 }, { 12403, 50 }, { 11229, 50 }, { 5954, 50 }, { 11233, 50 }, { 41529, 5 }, { 40554, 100 } }, time = 25, difficulty = 30 },
	  [14] = { item = 22407, skill = 20, storage = 114, mats = { { 22405, 1 }, { 5878, 50 }, { 5913, 30 }, { 5925, 30 }, { 5879, 30 }, { 23553, 70 }, { 12403, 150 }, { 11229, 150 }, { 5954, 150 }, { 11233, 150 }, { 41529, 15 }, { 40554, 250 } }, time = 35, difficulty = 40 },
	  [15] = { item = 22406, skill = 25, storage = 115, mats = { { 22407, 1 }, { 5878, 150 }, { 5913, 80 }, { 5925, 80 }, { 5879, 80 }, { 23553, 150 }, { 12403, 400 }, { 11229, 400 }, { 5954, 400 }, { 11233, 400 }, { 41529, 40 }, { 40554, 500 } }, time = 45, difficulty = 50 },
	  [16] = { item = 22408, skill = 30, storage = 116, mats = { { 22406, 1 }, { 5878, 400 }, { 5913, 200 }, { 5925, 200 }, { 5879, 200 }, { 23553, 400 }, { 12403, 1000 }, { 11229, 1000 }, { 5954, 1000 }, { 11233, 1000 }, { 41529, 80 }, { 40554, 1000 } }, time = 55, difficulty = 70 },
	  [17] = { item = 22409, skill = 40, storage = 117, mats = { { 22408, 1 }, { 5878, 1000 }, { 5913, 500 }, { 5925, 500 }, { 5879, 500 }, { 23553, 1000 }, { 12403, 2500 }, { 11229, 2500 }, { 5954, 2500 }, { 11233, 2500 }, { 41529, 200 }, { 40554, 2500 } }, time = 65, difficulty = 90 },
	  ---Berserker clubs 2-6
	  [18] = { item = 22411, skill = 15, storage = 118, mats = { { 22410, 1 }, { 5878, 20 }, { 5913, 10 }, { 5925, 10 }, { 5879, 10 }, { 23553, 25 }, { 12403, 50 }, { 11229, 50 }, { 5954, 50 }, { 11233, 50 }, { 41529, 5 }, { 40554, 100 } }, time = 25, difficulty = 30 },
	  [19] = { item = 22412, skill = 20, storage = 119, mats = { { 22411, 1 }, { 5878, 50 }, { 5913, 30 }, { 5925, 30 }, { 5879, 30 }, { 23553, 70 }, { 12403, 150 }, { 11229, 150 }, { 5954, 150 }, { 11233, 150 }, { 41529, 15 }, { 40554, 250 } }, time = 35, difficulty = 40 },
	  [20] = { item = 22413, skill = 25, storage = 120, mats = { { 22412, 1 }, { 5878, 150 }, { 5913, 80 }, { 5925, 80 }, { 5879, 80 }, { 23553, 150 }, { 12403, 400 }, { 11229, 400 }, { 5954, 400 }, { 11233, 400 }, { 41529, 40 }, { 40554, 500 } }, time = 45, difficulty = 50 },
	  [21] = { item = 22414, skill = 30, storage = 121, mats = { { 22413, 1 }, { 5878, 400 }, { 5913, 200 }, { 5925, 200 }, { 5879, 200 }, { 23553, 400 }, { 12403, 1000 }, { 11229, 1000 }, { 5954, 1000 }, { 11233, 1000 }, { 41529, 80 }, { 40554, 1000 } }, time = 55, difficulty = 70 },
	  [22] = { item = 22415, skill = 40, storage = 122, mats = { { 22414, 1 }, { 5878, 1000 }, { 5913, 500 }, { 5925, 500 }, { 5879, 500 }, { 23553, 1000 }, { 12403, 2500 }, { 11229, 2500 }, { 5954, 2500 }, { 11233, 2500 }, { 41529, 200 }, { 40554, 2500 } }, time = 65, difficulty = 90 },
	  ---Berserker swords 2-6
	  [23] = { item = 22399, skill = 15, storage = 123, mats = { { 22398, 1 }, { 5878, 20 }, { 5913, 10 }, { 5925, 10 }, { 5879, 10 }, { 23553, 25 }, { 12403, 50 }, { 11229, 50 }, { 5954, 50 }, { 11233, 50 }, { 41529, 5 }, { 40554, 100 } }, time = 25, difficulty = 30 },
	  [24] = { item = 22400, skill = 20, storage = 124, mats = { { 22399, 1 }, { 5878, 50 }, { 5913, 30 }, { 5925, 30 }, { 5879, 30 }, { 23553, 70 }, { 12403, 150 }, { 11229, 150 }, { 5954, 150 }, { 11233, 150 }, { 41529, 15 }, { 40554, 250 } }, time = 35, difficulty = 40 },
	  [25] = { item = 22401, skill = 25, storage = 125, mats = { { 22400, 1 }, { 5878, 150 }, { 5913, 80 }, { 5925, 80 }, { 5879, 80 }, { 23553, 150 }, { 12403, 400 }, { 11229, 400 }, { 5954, 400 }, { 11233, 400 }, { 41529, 40 }, { 40554, 500 } }, time = 45, difficulty = 50 },
	  [26] = { item = 22402, skill = 30, storage = 126, mats = { { 22401, 1 }, { 5878, 400 }, { 5913, 200 }, { 5925, 200 }, { 5879, 200 }, { 23553, 400 }, { 12403, 1000 }, { 11229, 1000 }, { 5954, 1000 }, { 11233, 1000 }, { 41529, 80 }, { 40554, 1000 } }, time = 55, difficulty = 70 },
	  [27] = { item = 22403, skill = 40, storage = 127, mats = { { 22402, 1 }, { 5878, 1000 }, { 5913, 500 }, { 5925, 500 }, { 5879, 500 }, { 23553, 1000 }, { 12403, 2500 }, { 11229, 2500 }, { 5954, 2500 }, { 11233, 2500 }, { 41529, 200 }, { 40554, 2500 } }, time = 65, difficulty = 90 },
	   ---paladin crossbows 2-4
	   [28] = { item = 22420, skill = 15, storage = 128, mats = { { 22419, 1 }, { 41530, 2 }, { 40554, 100 }, { 41529, 10 } }, time = 25, difficulty = 30 },
	   [29] = { item = 22421, skill = 30, storage = 129, mats = { { 22420, 1 }, { 41530, 4 }, { 40554, 250 }, { 41529, 25 } }, time = 45, difficulty = 70 },
	   [30] = { item = 30112, skill = 40, storage = 130, mats = { { 22421, 1 }, { 41530, 6 }, { 40554, 700 }, { 41529, 70 } }, time = 65, difficulty = 90 },
	   ---Archer bows  2-5
	   [31] = { item = 22417, skill = 15, storage = 131, mats = { { 22416, 1 }, { 7438, 5 }, { 41530, 1 }, { 40554, 100 }, { 41529, 10 } }, time = 25, difficulty = 30 },
	   [32] = { item = 22418, skill = 30, storage = 132, mats = { { 22417, 1 }, { 7438, 10 }, { 41530, 2 }, { 40554, 250 }, { 41529, 25 } }, time = 45, difficulty = 70 },
	   [33] = { item = 31121, skill = 40, storage = 133, mats = { { 22418, 1 }, { 7438, 20 }, { 41530, 3 }, { 40554, 700 }, { 41529, 70 } }, time = 65, difficulty = 90 },
	   [34] = { item = 40563, skill = 60, storage = 134, mats = { { 31121, 1 }, { 7438, 40 }, { 41530, 4 }, { 40554, 1500 }, { 41529, 150 } }, time = 80, difficulty = 130 },
	   ---Picks  2-3
	   [35] = { item = 32075, skill = 10, storage = 135, mats = { { 2449, 3 }, { 2162, 5 }, { 12420, 30 }, { 41529, 1 }, { 26179, 2 } }, time = 40, difficulty = 40 },
	   [36] = { item = 24828, skill = 20, storage = 136, mats = { { 32075, 1 }, { 6500, 100 }, { 12614, 50 }, { 5906, 20 }, { 41697, 5 }, { 41529, 5 }, { 26179, 5 } }, time = 80, difficulty = 80 },
	     ---spellbooks   1-3
	   [37] = { item = 22422, skill = 20, storage = 137, mats = { { 32075, 1 }, { 6500, 100 }, { 12614, 50 }, { 5906, 20 }, { 41697, 5 }, { 41529, 5 }, { 26179, 5 } }, time = 50, difficulty = 60 },
	   [38] = { item = 22423, skill = 30, storage = 138, mats = { { 22422, 1 }, { 6500, 100 }, { 12614, 50 }, { 5906, 20 }, { 41697, 5 }, { 41529, 5 }, { 26179, 5 } }, time = 100, difficulty = 80 },
	   [39] = { item = 22424, skill = 50, storage = 139, mats = { { 22423, 1 }, { 6500, 100 }, { 12614, 50 }, { 5906, 20 }, { 41697, 5 }, { 41529, 5 }, { 26179, 5 } }, time = 100, difficulty = 80 },
	   
	   
	  
      [40] = { item = 4864, skill = 35, storage = 200, mats = { { 4850, 1 }, { 2913, 1 }, { 2144, 1 } }, time = 5, difficulty = 40 }
    },
    message = "Crafting allows you to create anything from potions to bombs to weapons of the highest caliber. The materials used in crafting can be obtained through gathering and through drops in dungeons and the open world.\n\n"
  },
  [50502] = {
    skillName = "Alchemy",
    skillRecipes = { --Based on Shinmaru/Soul4Soul Alchemy's System
      [1] = { item = 8474, skill = 10, storage = 201, mats = { { 2007, 1 }, { 2795, 1 }, { 2760, 1 } }, time = 5,
        difficulty = 20 },
      [2] = { item = 2152, skill = 15, storage = 202, mats = { { 2148, 10 }, { 10608, 2 } }, time = 5, difficulty = 20 },
      [3] = { item = 2178, skill = 20, storage = 203, mats = { { 2177, 1 }, { 1295, 1 }, { 2146, 3 } }, time = 5,
        difficulty = 40 },
      [4] = { item = 5944, skill = 20, storage = 204, mats = { { 2177, 1 }, { 1295, 1 }, { 2150, 3 } }, time = 5,
        difficulty = 40 },
      [5] = { item = 2363, skill = 25, storage = 205, mats = { { 2177, 1 }, { 2177, 1 }, { 1295, 1 }, { 2798, 1 },
        { 2788, 1 } }, time = 5, difficulty = 50 },
      [6] = { item = 10092, skill = 30, storage = 206, mats = { { 2677, 3 }, { 1685, 1 }, { 2013, 1 }, { 2015, 1 } },
        time = 5, difficulty = 60 },
      [7] = { item = 4864, skill = 35, storage = 207, mats = { { 4850, 1 }, { 2913, 1 }, { 2144, 1 } }, time = 5,
        difficulty = 40 },
      [8] = { item = 2276, skill = 40, storage = 208,
        mats = { { 10558, 1 }, { 2260, 1 }, { 10554, 1 }, { 2151, 1 }, { 5951, 1 }, { 2265, 1 } }, time = 5,
        difficulty = 40 },
      [9] = { item = 2160, skill = 45, storage = 209, mats = { { 2152, 1 }, { 2145, 1 }, { 2146, 1 }, { 2800, 1 } },
        time = 5, difficulty = 30 },
      [10] = { item = 11201, skill = 45, storage = 210, mats = { { 2759, 1 }, { 10565, 1 }, { 2803, 1 }, { 2692, 1 } },
        time = 5, difficulty = 40 },
      [11] = { item = 5892, skill = 5, storage = 211, mats = { { 5468, 1 }, { 2393, 1 } }, time = 5, difficulty = 50 },
      [12] = { item = 5887, skill = 5, storage = 212, mats = { { 5468, 1 }, { 2487, 1 } }, time = 5, difficulty = 50 },
      [13] = { item = 5888, skill = 5, storage = 213, mats = { { 5468, 1 }, { 2462, 1 } }, time = 5, difficulty = 50 },
      [14] = { item = 5889, skill = 5, storage = 214, mats = { { 5468, 1 }, { 2516, 1 } }, time = 5, difficulty = 50 },
      [15] = { item = 5891, skill = 10, storage = 215, mats = { { 2195, 1 }, { 4265, 1 }, { 2151, 1 } }, time = 5,
        difficulty = 40 },
      [16] = { item = 5884, skill = 10, storage = 216, mats = { { 2498, 1 }, { 2498, 1 }, { 2913, 1 }, { 5865, 1 } },
        time = 5, difficulty = 40 },
      [17] = { item = 5885, skill = 10, storage = 217,
        mats = { { 2475, 1 }, { 2475, 1 }, { 2475, 1 }, { 2475, 1 }, { 2015, 1 }, { 5865, 1 } }, time = 5,
        difficulty = 40 },
      [18] = { item = 7439, skill = 60, storage = 218, mats = { { 6558, 1 }, { 2007, 1 }, { 4993, 1 }, { 5480, 1 },
        { 2796, 1 } }, time = 5, difficulty = 30 },
      [19] = { item = 7440, skill = 60, storage = 219, mats = { { 6558, 1 }, { 2007, 1 }, { 4992, 1 }, { 3955, 1 },
        { 7250, 1 } }, time = 5, difficulty = 30 },
      [20] = { item = 7443, skill = 60, storage = 220, mats = { { 6558, 1 }, { 2007, 1 }, { 4994, 1 }, { 2193, 1 },
        { 2031, 1 } }, time = 5, difficulty = 30 },
      [21] = { item = 7140, skill = 65, storage = 221,
        mats = { { 7141, 1 }, { 2015, 1 }, { 5014, 1 }, { 2235, 1 }, { 7439, 1 }, { 7440, 1 }, { 7443, 1 }, { 4845, 1 } },
        time = 5, difficulty = 60 },
      [22] = { item = 9971, skill = 70, storage = 222, mats = { { 10552, 1 }, { 2157, 1 }, { 2159, 1 }, { 5906, 1 } },
        time = 5, difficulty = 50 },
      [23] = { item = 2284, skill = 75, storage = 223, mats = { { 10523, 1 }, { 2260, 1 }, { 10554, 1 }, { 2151, 1 },
        { 2273, 1 } }, time = 5, difficulty = 30 },
      [24] = { item = 11387, skill = 80, storage = 224, mats = { { 2805, 1 }, { 2798, 1 }, { 8582, 1 } }, time = 5,
        difficulty = 70 },
      [25] = { item = 8980, skill = 90, storage = 225, mats = { { 5941, 1 }, { 10559, 1 }, { 2194, 1 }, { 2377, 1 } },
        time = 5, difficulty = 80 },
      [26] = { item = 2184, skill = 90, storage = 226, mats = { { 9942, 1 }, { 9941, 1 }, { 9980, 1 }, { 2445, 1 } },
        time = 5, difficulty = 80 },
      [27] = { item = 2352, skill = 90, storage = 227, mats = { { 2177, 1 }, { 2160, 1 }, { 2544, 1 }, { 2544, 1 },
        { 2802, 1 } }, time = 5, difficulty = 80 },
      [28] = { item = 9969, skill = 100, storage = 228, mats = { { 5741, 1 }, { 2229, 1 }, { 5669, 1 }, { 5809, 1 },
        { 2143, 1 } }, time = 5, difficulty = 90 },
      [29] = { item = 9006, skill = 110, storage = 229,
        mats = { { 8859, 1 }, { 2289, 1 }, { 2807, 1 }, { 10556, 1 }, { 2545, 1 }, { 5879, 1 } }, time = 5,
        difficulty = 100 },
      [30] = { item = 2348, skill = 120, storage = 230,
        mats = { { 2153, 1 }, { 2154, 1 }, { 2155, 1 }, { 2156, 1 }, { 2158, 1 }, { 2260, 1 }, { 2260, 1 }, { 2600, 1 } },
        time = 5, difficulty = 100 }
    },
    message = "Crafting allows you to create ~"
  },
  [50503] = {
    skillName = "Inscription",
    skillRecipes = {
      [1] = { item = 2400, skill = 10, storage = 301, mats = { { 2554, 1 }, { 2120, 1 } }, time = 5, difficulty = 20,
        attr = { attack = 10, defense = 10 } },
      [2] = { item = 2432, skill = 15, storage = 302, mats = { { 2148, 10 }, { 10608, 10 } }, time = 5, difficulty = 20 },
      [3] = { item = 2178, skill = 20, storage = 303, mats = { { 2177, 1 }, { 1295, 1 }, { 2146, 3 } }, time = 5,
        difficulty = 40 },
      [4] = { item = 5944, skill = 20, storage = 304, mats = { { 2177, 1 }, { 1295, 1 }, { 2150, 3 } }, time = 5,
        difficulty = 40 },
      [5] = { item = 2363, skill = 25, storage = 305, mats = { { 2177, 1 }, { 2177, 1 }, { 1295, 1 }, { 2798, 1 },
        { 2788, 1 } }, time = 5, difficulty = 50 },
      [6] = { item = 10092, skill = 30, storage = 306, mats = { { 2677, 3 }, { 1685, 1 }, { 2013, 1 }, { 2015, 1 } },
        time = 5, difficulty = 60 },
      [7] = { item = 4864, skill = 35, storage = 307, mats = { { 4850, 1 }, { 2913, 1 }, { 2144, 1 } }, time = 5,
        difficulty = 40 }
    },
    message = "Crafting allows you to create ~"
  },
  [50504] = {
    skillName = "Tailoring",
    skillRecipes = {
      [1] = { item = 2400, skill = 10, storage = 401, mats = { { 2554, 1 }, { 2120, 1 } }, time = 5, difficulty = 20 },
      [2] = { item = 2432, skill = 15, storage = 402, mats = { { 2148, 10 }, { 10608, 10 } }, time = 5, difficulty = 20 },
      [3] = { item = 2178, skill = 20, storage = 403, mats = { { 2177, 1 }, { 1295, 1 }, { 2146, 3 } }, time = 5,
        difficulty = 40 },
      [4] = { item = 5944, skill = 20, storage = 404, mats = { { 2177, 1 }, { 1295, 1 }, { 2150, 3 } }, time = 5,
        difficulty = 40 },
      [5] = { item = 2363, skill = 25, storage = 405, mats = { { 2177, 1 }, { 2177, 1 }, { 1295, 1 }, { 2798, 1 },
        { 2788, 1 } }, time = 5, difficulty = 50 },
      [6] = { item = 10092, skill = 30, storage = 406, mats = { { 2677, 3 }, { 1685, 1 }, { 2013, 1 }, { 2015, 1 } },
        time = 5, difficulty = 60 },
      [7] = { item = 4864, skill = 35, storage = 407, mats = { { 4850, 1 }, { 2913, 1 }, { 2144, 1 } }, time = 5,
        difficulty = 40 }
    },
    message = "Crafting allows you to create ~"
  },
  [50505] = {
    skillName = "Leatherworking",
    skillRecipes = {
      [1] = { item = 22796, skill = 10, storage = 501, mats = { { 22396, 10 }, { 36796, 5 }, { 36794, 5 } }, time = 0, difficulty = 1 },
      [2] = { item = 13393, skill = 10, storage = 502, mats = { { 22396, 10 }, { 36794, 5 }, { 36797, 5 } }, time = 0, difficulty = 1 },
      [3] = { item = 13298, skill = 10, storage = 503, mats = { { 22396, 10 }, { 36795, 5 }, { 36797, 5 } }, time = 0, difficulty = 1 },
      [4] = { item = 13536, skill = 10, storage = 504, mats = { { 22396, 10 }, { 36799, 5 }, { 36794, 5 } }, time = 0, difficulty = 1 },
      [5] = { item = 13295, skill = 10, storage = 505, mats = { { 22396, 10 }, { 36798, 5 }, { 36794, 5 } }, time = 0, difficulty = 1 },
      [6] = { item = 18447, skill = 10, storage = 506, mats = { { 22396, 10 }, { 36798, 5 }, { 36797, 5 } }, time = 0, difficulty = 1 },
      [7] = { item = 13294, skill = 10, storage = 507, mats = { { 22396, 10 }, { 36799, 5 }, { 36798, 5 } }, time = 0,difficulty = 1 },
      [8] = { item = 5907, skill = 10, storage = 508, mats = { { 22396, 10 }, { 36795, 5 }, { 36798, 5 } }, time = 0,difficulty = 1 },
    },
    message = "Crafting allows you to create ~",
  },
  [50506] = {
    skillName = "SpellCrafting",
    skillRecipes = {
      --? Vou usar esse daqui como base pra você
      --[0] = {item = ID do Item, skill = Nível requerido de crafting pra fazer, storage = Só segue a ordem 600,601,602..., mats = {{id do item q vai ser usado pra construir, quantidade}, {mesma coisa q o anterior, da pra adicionar mais items, quantidade} , {novo item, nova quantidade}}, time = deixa em 0 aq sempre, difficulty = e aq em 1 tbm}, --! "Nome do item que você vai fazer (Só pra ficar facil de ler"
      [1] = { item = 12583, skill = 10, storage = 1500, mats = { { 36797, 5 }, { 2160, 20 }, { 36794, 5 }}, time = 1, difficulty = 1 }, --! "Speed Spell"
      [2] = { item = 12565, skill = 10, storage = 1501, mats = { { 36796, 5 }, { 2152, 20 }, { 36794, 5 } }, time = 0, difficulty = 1 },
      [3] = { item = 12595, skill = 10, storage = 1502, mats = { { 36795, 5 }, { 2152, 20 }, { 36794, 5 } }, time = 0, difficulty = 1 },
      [4] = { item = 12581, skill = 10, storage = 1503, mats = { { 36797, 5 }, { 2152, 20}, { 36796, 5 } }, time = 0, difficulty = 1 },
      [5] = { item = 12567, skill = 25, storage = 1504, mats = { { 36799, 5 }, { 2152, 20 }, { 36796, 5  } }, time = 0, difficulty = 1 },
      [6] = { item = 10092, skill = 30, storage = 1505, mats = { { 2677, 3 }, { 1685, 1 }, { 2013, 1 }, { 2015, 1 } },
        time = 5, difficulty = 60 },
      [7] = { item = 4864, skill = 35, storage = 1506, mats = { { 4850, 1 }, { 2913, 1 }, { 2144, 1 } }, time = 5,
        difficulty = 40 }
    },
    message = "SpellCrafters can craft new and Powerfull Spells"
  },
  maxSkill = 200,
  baseRecipeStorage = 50500,
  extraData = {},
}




local craftSpells = Action()

function craftSpells.onUse(player, item, fromPosition, target, toPosition, isHotkey)
  local found = 0
  local recipes = craftingProfessionsConfig[item.actionid].skillRecipes
  local modal = ModalWindow(item.actionid,
    "" ..
    craftingProfessionsConfig[item.actionid].skillName ..
    " (Crafting Skill: " .. player:getCustomSkill(item.actionid) .. "/" .. craftingProfessionsConfig.maxSkill .. ")",
    craftingProfessionsConfig[item.actionid].message)

  if item.itemid == 30665 or 8895 and isInArray({ 50501, 50502, 50503, 50504, 50505, 50506 }, item.actionid) then
    if getCreatureCondition(player, CONDITION_SPELLCOOLDOWN, 160) then --I don't really know how to use :getCreatureCondition, it never works for me.
      return player:sendCancelMessage("You are already crafting.")
    end

    if not player:isProfession(item.actionid) then
      player:sendTextMessage(MESSAGE_EVENT_ADVANCE,
        "In here you can craft some spells by bringing required items and crafting your new spell that will be unlock onUse of the item, you can unlock more crafting in many ways: Level, Loot, Bosses")
      player:getPosition():sendMagicEffect(CONST_ME_EXPLOSIONHIT)
      player:setStorageValue(item.actionid, storValue)
	  player:setStorageValue(craftingProfessionsConfig.baseRecipeStorage + 101, 1)
      player:setStorageValue(craftingProfessionsConfig.baseRecipeStorage + 102, 1)
      player:setStorageValue(craftingProfessionsConfig.baseRecipeStorage + 103, 1)
	  player:setStorageValue(craftingProfessionsConfig.baseRecipeStorage + 104, 1)
	  player:setStorageValue(craftingProfessionsConfig.baseRecipeStorage + 105, 1)
	  player:setStorageValue(craftingProfessionsConfig.baseRecipeStorage + 106, 1)
	  player:setStorageValue(craftingProfessionsConfig.baseRecipeStorage + 107, 1)
	  player:setStorageValue(craftingProfessionsConfig.baseRecipeStorage + 108, 1)
	  player:setStorageValue(craftingProfessionsConfig.baseRecipeStorage + 109, 1)
	  player:setStorageValue(craftingProfessionsConfig.baseRecipeStorage + 110, 1)
	  player:setStorageValue(craftingProfessionsConfig.baseRecipeStorage + 111, 1)
	  player:setStorageValue(craftingProfessionsConfig.baseRecipeStorage + 112, 1)
	  player:setStorageValue(craftingProfessionsConfig.baseRecipeStorage + 113, 1)
	  player:setStorageValue(craftingProfessionsConfig.baseRecipeStorage + 114, 1)
	  player:setStorageValue(craftingProfessionsConfig.baseRecipeStorage + 115, 1)
	  player:setStorageValue(craftingProfessionsConfig.baseRecipeStorage + 116, 1)
	  player:setStorageValue(craftingProfessionsConfig.baseRecipeStorage + 117, 1)
	  player:setStorageValue(craftingProfessionsConfig.baseRecipeStorage + 118, 1)
	  player:setStorageValue(craftingProfessionsConfig.baseRecipeStorage + 119, 1)
	  player:setStorageValue(craftingProfessionsConfig.baseRecipeStorage + 120, 1)
	  player:setStorageValue(craftingProfessionsConfig.baseRecipeStorage + 121, 1)
	  player:setStorageValue(craftingProfessionsConfig.baseRecipeStorage + 122, 1)
	  player:setStorageValue(craftingProfessionsConfig.baseRecipeStorage + 123, 1)
	  player:setStorageValue(craftingProfessionsConfig.baseRecipeStorage + 124, 1)
	  player:setStorageValue(craftingProfessionsConfig.baseRecipeStorage + 125, 1)
	  player:setStorageValue(craftingProfessionsConfig.baseRecipeStorage + 126, 1)
	  player:setStorageValue(craftingProfessionsConfig.baseRecipeStorage + 127, 1)
	  player:setStorageValue(craftingProfessionsConfig.baseRecipeStorage + 128, 1)
	  player:setStorageValue(craftingProfessionsConfig.baseRecipeStorage + 129, 1)
	  player:setStorageValue(craftingProfessionsConfig.baseRecipeStorage + 130, 1)
	  player:setStorageValue(craftingProfessionsConfig.baseRecipeStorage + 131, 1)
	  player:setStorageValue(craftingProfessionsConfig.baseRecipeStorage + 132, 1)
	  player:setStorageValue(craftingProfessionsConfig.baseRecipeStorage + 133, 1)
	  player:setStorageValue(craftingProfessionsConfig.baseRecipeStorage + 134, 1)
	  player:setStorageValue(craftingProfessionsConfig.baseRecipeStorage + 135, 1)
	  player:setStorageValue(craftingProfessionsConfig.baseRecipeStorage + 136, 1)
	  
	  
      return true
    end

    for i = 1, #recipes do
      if player:getStorageValue(craftingProfessionsConfig.baseRecipeStorage + recipes[i].storage) == 1 then
        modal:addChoice(i, getItemName(recipes[i].item)--[[.." ["..recipes[i].skill.."]"]] )
      end
    end

    craftingProfessionsConfig.extraData[player:getId()] = {
      lastPos = Item(item.uid):getPosition()
    }

    if modal:getChoiceCount() ~= 0 then
      modal:addButton(1, "Create")
      modal:setDefaultEnterButton(1)
      modal:addButton(2, "Exit")
      modal:setDefaultEscapeButton(2)
      modal:addButton(3, "Materials")
      modal:sendToPlayer(player)
    else
      player:sendCancelMessage("You need to learn some " ..
        craftingProfessionsConfig[item.actionid].skillName .. " recipes first.")
    end
  elseif item.itemid == 1967 and item.actionid >= craftingProfessionsConfig.baseRecipeStorage then
    for i = 1, #recipes do
      if recipes[i].storage == tonumber(Item(item.uid):getAttribute(ITEM_ATTRIBUTE_TEXT)) then
        found = i
      end
    end
    if found == 0 then return player:sendCancelMessage(RETURNVALUE_CANNOTUSETHISOBJECT) end
    if player:getStorageValue(craftingProfessionsConfig.baseRecipeStorage + recipes[found].storage) == -1 then
      if player:getCustomSkill(item.actionid) >= recipes[found].skill then
        player:setStorageValue(craftingProfessionsConfig.baseRecipeStorage + recipes[found].storage, 1)
        player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "You learned how to make " .. getItemName(recipes[found].item) ..
          ".")
        player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
        Item(item.uid):remove(1)
      else
        player:sendCancelMessage("You require " ..
          recipes[found].skill ..
          " crafting skill in " .. craftingProfessionsConfig[item.actionid].skillName .. " to learn this recipe.")
      end
    else
      player:sendCancelMessage("You have already learned this recipe.")
    end
  elseif item.itemid == 2217 and item.actionid >= craftingProfessionsConfig.baseRecipeStorage then
    if player:getStorageValue(item.actionid) == -1 then
      player:sendTextMessage(MESSAGE_EVENT_DEFAULT,
        "You have learned " ..
        craftingProfessionsConfig[item.actionid].skillName ..
        ", then the book burned to ashes after learning it's secrets.")
      player:getPosition():sendMagicEffect(CONST_ME_EXPLOSIONHIT)
      player:setStorageValue(item.actionid, 10)
      Item(item.uid):remove(1)
    else
      player:sendCancelMessage("You already know " .. craftingProfessionsConfig[item.actionid].skillName .. ".")
    end
  end
  return true
end

craftSpells:aid(50501)
craftSpells:aid(50502)
craftSpells:aid(50503)
craftSpells:aid(50504)
craftSpells:aid(50505)
craftSpells:aid(50506)
craftSpells:register()

creatureevent = CreatureEvent("craftSpells_System")
function creatureevent.onModalWindow(player, modalWindowId, buttonId, choiceId)
  if not isInArray({ 50501, 50502, 50503, 50504, 50505, 50506 }, modalWindowId) or buttonId == 2 then
    return false
  end
  local count = 0
  local recipes = craftingProfessionsConfig[modalWindowId].skillRecipes
  local str = "" ..
      getItemName(recipes[choiceId].item) ..
      "\n  Skill Needed: " .. recipes[choiceId].skill .. " - Point Cost: 1p\n\nMaterials:"
  if buttonId == 3 then
    for i = 1, #recipes[choiceId].mats do
      str = str ..
          "\n- " ..
          getItemName(recipes[choiceId].mats[i][1]) ..
          " (" .. player:getItemCount(recipes[choiceId].mats[i][1]) .. "/" .. recipes[choiceId].mats[i][2] .. ")"
    end
    if str ~= "" then
      player:showTextDialog(recipes[choiceId].item, str)
    end
    return true
  end
  for i = 1, #recipes[choiceId].mats do
    if player:getItemCount(recipes[choiceId].mats[i][1]) >= recipes[choiceId].mats[i][2] then
      count = count + 1
    end
  end
  if count == #recipes[choiceId].mats then
    local craftCD = Condition(CONDITION_SPELLCOOLDOWN)
    craftCD:setParameter(COMBAT_PARAM_AGGRESSIVE, 0)
    craftCD:setParameter(CONDITION_PARAM_SUBID, 160)
    craftCD:setParameter(CONDITION_PARAM_TICKS, recipes[choiceId].time * 1000)
    player:addCondition(craftCD)
    --player:allowMovement(false)
    player:say("Crafting...", TALKTYPE_MONSTER_SAY)
    local itemPos = craftingProfessionsConfig.extraData[player:getId()].lastPos
    function sendAnimation(times) --This needs to be improved
      itemPos:sendMagicEffect(CONST_ME_BLOCKHIT)
      if times == 0 then
        return true
      end
      addEvent(sendAnimation, 1000, times - 1)
    end

    sendAnimation(recipes[choiceId].time)
    for i = 1, count do
      player:removeItem(recipes[choiceId].mats[i][1], recipes[choiceId].mats[i][2])
    end
    addEvent(function(id)
      local player = Player(id)
      if player then
        local craftedItem = player:addItem(recipes[choiceId].item, 1)
        if craftedItem then
          player:sendTextMessage(MESSAGE_EVENT_DEFAULT,
            "You've successfully crafted " .. craftedItem:getArticle() .. " " .. craftedItem:getName() .. ".")
          craftedItem:setAttribute(ITEM_ATTRIBUTE_NAME, "crafted " .. craftedItem:getName())
          player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
          --doWriteLogFile("data/logs/craf.log", player:getName() .." crafted the following item: ".. craftedItem:getName() .." [".. craftedItem:getId() .."].")
          if craftedItem:getType():getDescription() ~= "" then
            craftedItem:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION,
              craftedItem:getType():getDescription() .. "\nCrafted by " .. player:getName() .. ".")
          else
            craftedItem:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, "Crafted by " .. player:getName() .. ".")
          end
          if craftedItem:getType():getAttack() > 0 and recipes[choiceId].attr ~= nil and
              recipes[choiceId].attr.attack ~= nil then
            craftedItem:setAttribute(ITEM_ATTRIBUTE_ATTACK,
              craftedItem:getType():getAttack() + recipes[choiceId].attr.attack)
          end
          if craftedItem:getType():getDefense() > 0 and recipes[choiceId].attr ~= nil and
              recipes[choiceId].attr.defense ~= nil then
            craftedItem:setAttribute(ITEM_ATTRIBUTE_DEFENSE,
              craftedItem:getType():getDefense() + recipes[choiceId].attr.defense)
          end
          if craftedItem:getType():getExtraDefense() > 0 and recipes[choiceId].attr ~= nil and
              recipes[choiceId].attr.extradefense ~= nil then
            craftedItem:setAttribute(ITEM_ATTRIBUTE_EXTRADEFENSE,
              craftedItem:getType():getExtraDefense() + recipes[choiceId].attr.extradefense)
          end
          if craftedItem:getType():getArmor() > 0 and recipes[choiceId].attr ~= nil and
              recipes[choiceId].attr.armor ~= nil then
            craftedItem:setAttribute(ITEM_ATTRIBUTE_ARMOR,
              craftedItem:getType():getArmor() + recipes[choiceId].attr.armor)
          end
          if craftedItem:getType():getHitChance() > 0 and recipes[choiceId].attr ~= nil and
              recipes[choiceId].attr.hitchance ~= nil then
            craftedItem:setAttribute(ITEM_ATTRIBUTE_HITCHANCE,
              craftedItem:getType():getHitChance() + recipes[choiceId].attr.hitchance)
          end
          if craftedItem:getType():getShootRange() > 0 and recipes[choiceId].attr ~= nil and
              recipes[choiceId].attr.shootrange ~= nil then
            craftedItem:setAttribute(ITEM_ATTRIBUTE_SHOOTRANGE,
              craftedItem:getType():getShootRange() + recipes[choiceId].attr.shootrange)
          end
        end
        skillGain = (recipes[choiceId].difficulty / 10)
        for i = 1, skillGain do
          player:addCustomSkillTry(craftingProfessionsConfig[modalWindowId].skillName, modalWindowId)
        end
        --player:allowMovement(true)
      end
    end, recipes[choiceId].time * 1000, player:getId())
  else
    player:sendCancelMessage("You don't have all the materials to craft this item.")
  end
  return true
end

creatureevent:register()

statSystem = CreatureEvent("craftSpells_onLogin")
function statSystem.onLogin(player)
  player:registerEvent("craftSpells_System")
  return true
end

statSystem:register()

local positions = {
	{
		Position(73, 1874, 10),
		50501
	},
	{
		Position(842, 866, 3),
		50506
	},
}

local globalevent = GlobalEvent("load_Crafting")
function globalevent.onStartup()
	for _, data in pairs(positions) do
		local tile = Tile(data[1])
		if tile then
			local thing = tile:getTopVisibleThing()
			if thing then
				thing:setAttribute(ITEM_ATTRIBUTE_ACTIONID, data[2])
			end
		end
	end
end

globalevent:register()
