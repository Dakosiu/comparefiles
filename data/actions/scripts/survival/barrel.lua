-- function break_barrel(player , fromPosition)
--     -- Breaks a barrel and replaces it with a monster or a chest.
--     print("break barrel")
--     -- Determine if a monster or a new barrel will appear.
--     local random_number = math.random()
--     print("random number: ")
--     print(random_number)
--     if random_number < 0.5 then
--         print("Spawn a monster")
--         local monster_type = get_random_monster_type()
--         Game.createMonster(monster_type, fromPosition)
--     --   return monster
--     else
--       -- Spawn a chest.
--       local chest_type = get_random_chest_type()
--       print("--------------")
--       print("--------------")
--       print("--------------")
--       print("chest_type")
--       print(chest_type)
--       if (chest_type == 'Small chest') then
--         player:addItem(860, 2)
--         player:addItem(861, 2)
--         player:addItem(862, 2)
--         player:addItem(863, 2)
--       end
--       if (chest_type == 'Big chest') then
--         player:addItem(860, 4)
--         player:addItem(861, 4)
--         player:addItem(862, 4)
--         player:addItem(863, 4)
--       end

--     end
--   end
  
--   function get_random_monster_type(fromPosition)
--     -- Generates a random monster type based on specified probabilities.
  
--     -- Define the monster types and their probabilities.
--     local monster_types = {
--       {type = 'Helmet Gladiator', probability = 0.35},
--       {type = 'Drunken Gladiator', probability = 0.25},
--       {type = 'Gladiator Fisherman', probability = 0.25},
--       {type = 'Bully Gladiator', probability = 0.15}
--     }
  
--     -- Choose a random monster type based on probabilities.
--     local random_number = math.random()
--     local cumulative_probability = 0
--     for _, monster in ipairs(monster_types) do
--       cumulative_probability = cumulative_probability + monster.probability
--       if random_number <= cumulative_probability then
--         return monster.type
--       end
--     end
--   end
  
--   function get_random_chest_type(fromPosition)
--     -- Generates a random chest type based on specified probabilities.
  
--     -- Define the chest types and their probabilities.
--     local barrel_types = {
--       {type = 'Small chest', probability = 0.7},
--       {type = 'Big chest', probability = 0.3}
--     }
  
--     -- Choose a random chest type based on probabilities.
--     local random_number = math.random()
--     local cumulative_probability = 0
--     for _, chestl in ipairs(barrel_types) do
--       cumulative_probability = cumulative_probability + chest.probability
--       if random_number <= cumulative_probability then
--         return chest.type
--       end
--     end
--   end

-- function onUse(player, item, fromPosition, target, toPosition, isHotkey)
--   print("Log cuando uso un barrel")
--     item:remove()
--     break_barrel(player ,fromPosition)
-- end