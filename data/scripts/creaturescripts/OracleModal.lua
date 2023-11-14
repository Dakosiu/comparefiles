--[[ local vocations = {
   ["Sorcerer"] = { vocid = 1, vocName = "Sorcerer", description = " Sorcerer: \n Type: Mage/Ranged \n Role: Damage \n Attack Speed: Medium \n Difficulty: Normal" },
   ["Druid"] = { vocid = 2, vocName = "Druid", description = " Druid: \n A tank class with ranged spells and fast atk speed" },
   ["Paladin"] = { vocid = 3, vocName = "Paladin", description = " Paladin: \n A tank class with ranged spells and fast atk speed" },
   ["Knight"] = { vocid = 4, vocName = "Knight", description = " Knight: \n A tank class with ranged spells and fast atk speed" },
   ["Archer"] = { vocid = 9, vocName = "Archer", description = " Archer: \n A tank class with ranged spells and fast atk speed" },
   ["Assassin"] = { vocid = 11, vocName = "Assassin", description = " Assassin: \n A tank class with ranged spells and fast atk speed" },
   ["Venomic"] = { vocid = 13, vocName = "Venomic", description = " Venomic: \n A tank class with ranged spells and fast atk speed" },
   ["Summoner"] = { vocid = 15, vocName = "Summoner", description = " Summoner: \n A tank class with ranged spells and fast atk speed" },
   ["Mage"] = { vocid = 17, vocName = "Mage", description = " Mage: \n A tank class with ranged spells and fast atk speed" },
   ["Botanist"] = { vocid = 19, vocName = "Botanist", description = " Botanist: \n A tank class with ranged spells and fast atk speed" },
   ["Tank"] = { vocid = 21, vocName = "Tank", description = " Tank: \n A tank class with ranged spells and fast atk speed" },
   ["Berseker"] = { vocid = 23, vocName = "Berseker", description = " Berseker: \n A tank class with ranged spells and fast atk speed" },
   --["Guru"] = { vocid = 25, vocName = "Guru", description = "ClassName \n A tank class with ranged spells and fast atk speed" },
}

local id = 19674

local destination = Position(939, 1060, 0)

local vocation

action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
   function Player:sendVocations()
      local function buttonAccept(button, choice)
         vocation = choice.text
         if choice.text == vocations[choice.text].vocName then
            player:Vocation()
         end
      end

      vocation = vocation
      local window = ModalWindow {
         title = "-------------Choose a vocation-------------",
         message = "Once you choose you will be challenged in many ways to test if you are really capable of this vocation.",
      }
      window:addButton("Ok", buttonAccept)
      window:addButton("Exit")

      if player:getVocation():getId() == VOCATION_NONE then
         window:addChoice(vocations["Sorcerer"].vocName)
         window:addChoice(vocations["Druid"].vocName)
         window:addChoice(vocations["Paladin"].vocName)
         window:addChoice(vocations["Knight"].vocName)
         window:addChoice(vocations["Archer"].vocName)
         window:addChoice(vocations["Assassin"].vocName)
         window:addChoice(vocations["Venomic"].vocName)
         window:addChoice(vocations["Summoner"].vocName)
         window:addChoice(vocations["Mage"].vocName)
         window:addChoice(vocations["Botanist"].vocName)
         window:addChoice(vocations["Tank"].vocName)
         window:addChoice(vocations["Berseker"].vocName)
         --window:addChoice(vocations["Guru"].vocName)
      else
         player:say("I already did this")
         return false
      end
      window:setDefaultEnterButton("Ok")
      window:setDefaultEscapeButton("Exit")
      window:sendToPlayer(self)
      vocation = vocation
   end

   function Player:Vocation()
      local function buttonAccept(button, choice)
         if button.text == "Yes" then
            if player:getLevel() == 22 then
               rookgardSystem:setOnRookgard(player, true)
               player:saveStatement()
               player:setVocation(vocations[vocation].vocid)
               print(vocations[vocation].vocName)
               player:setTown(1)
               player:teleportTo(destination)
               player:getPosition():sendMagicEffect(380)
               player:say(vocation)
               destination:sendMagicEffect(379)
            elseif player:getLevel() < 22 then
               player:say("Im still too weak to enter this quest")
            elseif player:getLevel() > 22 then
               player:say('Im to strong for this quest')
               player:getPosition():sendMagicEffect(CONST_ME_POFF)
            end
         elseif button.text == "Back" then
            player:sendVocations()
         end
      end

      local window = ModalWindow {
         title = vocations[vocation].vocName,
         message = vocations[vocation].description,
      }

      window:addButton("Yes", buttonAccept)
      window:addButton("Back", buttonAccept)
      window:addButton("Cancel")

      window:setDefaultEnterButton("Yes")
      window:setDefaultEscapeButton("Cancel")

      window:sendToPlayer(self)
   end

   player:sendVocations()

end

action:id(id)
action:register()
 --]]