-- familiars_looktype = { 
                       -- [991] = "Knight Familiar",
                       -- [1365] = "Snowbash Familiar",
					   -- [992] = "Paladin Familiar",
					   -- [1366] = "Sandscourge Familiar",
					   -- [993] = "Druid Familiar",
					   -- [1364] = "Mossmasher Familiar",
					   -- [994] = "Sorcerer Familiar",
					   -- [1367] = "Bladespark Familiar",
                     -- }

-- if not players_familiars then
   -- players_familiars = {}
-- end

-- function Player.findFamiliarTable(self, looktype)
   -- if not self then
      -- return nil
   -- end
   
   -- local familiarTable = players_familiars[self:getId()]
   -- for i, t in pairs(familiarTable) do
       -- if i ~= "currentOutfit" and i ~= "currentId" then
         -- for outfit, v in pairs(t) do 
           -- if looktype and outfit == looktype then
              -- local array = {["table"] = v, ["index"] = i}
              -- return array
           -- end
         -- end
      -- end
   -- end
   
   -- return false
-- end
   
-- function Player.addFamiliarTable(self, creature)
   
   -- if not self or not creature then
      -- return nil
   -- end
   
   
   -- local familiarTable = players_familiars[self:getId()]
   -- if not familiarTable then
	  -- players_familiars[self:getId()] = {}
	  -- familiarTable = players_familiars[self:getId()]
   -- end
   
   -- local looktype = creature:getOutfit().lookType

   -- players_familiars[self:getId()]["currentOutfit"] = looktype
   -- players_familiars[self:getId()]["currentId"] = creature:getId()
   
   -- if not self:findFamiliarTable(looktype) then
      -- local values = { 
	                   -- [looktype] = { 
	                                  -- ["health"] = creature:getHealth(),
	                                  -- ["id"] = creature:getId(),
	                                -- } 
	                 -- }
					 
	      -- table.insert(players_familiars[self:getId()], values)
	      -- return true
	-- end
	
	-- familiarTable = self:findFamiliarTable(looktype)["table"]
	-- if familiarTable then
	   -- familiarTable.health = creature:getHealth()
	   -- familiarTable.id = creature:getId()
	   -- return true
	-- end

   -- return false
-- end

-- function Player.onChangeFamiliar(self)
    
	-- print("Tu jestem kiedykolwiek?")
	
    -- if not self then
	   -- return nil
	-- end
	   
    -- local selected_outfit = self:getFamiliarLooktype()
	-- local current_outfit = nil
	
	-- if players_familiars[self:getId()] then
	   -- current_outfit = players_familiars[self:getId()]["currentOutfit"]
	-- end
	
	-- if current_outfit and selected_outfit ~= current_outfit then
	   -- local id = players_familiars[self:getId()]["currentId"]
	   -- local summon = Creature(id)
	   -- local summon2 = nil
	   -- local pos = nil
	   -- if summon then
		  -- pos = summon:getPosition()
		  -- self:addFamiliarTable(summon)
		  -- summon:remove()
	   -- end
		  -- local name = familiars_looktype[selected_outfit]
		  -- print("Name")
		  -- summon2 = Game.createMonster(name, pos, true, false)
		  -- print("Probuje zrobic summona")
	      -- if summon2 then
		     -- print("Tu jestem?")
		     -- summon2:setOutfit({lookType = selected_outfit})
	         -- local familiarTable = self:findFamiliarTable(selected_outfit)
	         -- if familiarTable then
			    -- local hp = familiarTable["table"]["health"]
			    -- if hp > 0 then
			       -- summon2:setHealth(hp)
			    -- end
		    -- end
			-- self:addSummon(summon2)
	        -- self:addFamiliarTable(summon2)
		    -- summon2:registerEvent("FamiliarDeath")
	      -- end
	 -- end
	
	
	-- return true
-- end

-- function Player.getFamiliarVocation(self)

  -- if not self then
  -- return
  -- end
  
  -- local t = nil
  -- local str = self:getVocation():getName():lower()
  -- local voc = nil
  
  -- if string.find(str, "knight") then
     -- voc = "knight"
  -- elseif string.find(str, "paladin") then
     -- voc = "paladin"
  -- elseif string.find(str, "druid") then
     -- voc = "druid"
  -- elseif string.find(str, "sorcerer") then
     -- voc = "sorcerer"
  -- end
  
  -- return voc or false
-- end

-- function removeFamiliar(playerId)
   
   -- if not playerId then
      -- return nil
   -- end
   
   -- local player = Player(playerId)
   
   -- if not player then
      -- return false
   -- end
   
   
   -- for index, summon in ipairs(player:getSummons()) do
       -- if summon then
	      -- local name = summon:getName():lower()
		  -- if string.find(name, "familiar") then
		  -- summon:remove()
	      -- end
	   -- end
   -- end
   
   -- if players_familiars[playerId] then
	  -- players_familiars[playerId]["currentId"] = 0
   -- end
   
   
    -- local timer = {
                   -- [1] = {storage=Storage.PetSummonEvent10, countdown=10, message = "10 seconds"},
	               -- [2] = {storage=Storage.PetSummonEvent60, countdown=60, message = "one minute"}
                  -- }
				  
   	-- for sendMessage = 1, #timer do
		-- player:setStorageValue(timer[sendMessage].storage, -1)
	-- end
	
	-- return true
-- end
   
-- local figures = {
                  -- storage = 9237317,
                  -- ["knight"] = { id = 35589, looktype = 1365 },
				  -- ["paladin"] = { id = 35590, looktype = 1366 },
				  -- ["druid"] = { id = 35591, looktype = 1364 },
				  -- ["sorcerer"] = { id = 35592, looktype = 1367 },
				-- }
-- local action = Action()
-- function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    
	-- local vocation = player:getFamiliarVocation()
		
	-- if item.itemid ~= figures[vocation].id then
	   -- player:sendCancelMessage("Your vocation can't use this figure.")
	   -- --return true
	-- end

	-- if player:getStorageValue(figures.storage) > 0 then
	   -- player:sendCancelMessage("You have already new familiar monster.")
	   -- --return true
	-- end

    -- player:addFamiliar(figures[vocation].looktype)
	-- player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	-- player:sendTextMessage(MESSAGE_INFO_DESCR, "You have got a new familiar monster!.")
	-- player:setStorageValue(figures.storage, 1)
	-- item:remove(1)

    -- return true
-- end

-- for _, v in pairs(figures) do
    -- if type(v) == "table" then
	   -- local id = v.id
	   -- if id then
	      -- action:id(id)
	   -- end
	-- end
-- end
-- action:register()

-- local creaturescript = CreatureEvent("familiar_Logout")
-- function creaturescript.onLogout(player)
   -- players_familiars[player:getId()] = nil
   -- return true
-- end
-- creaturescript:register()