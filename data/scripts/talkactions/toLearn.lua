--[[ local bosses = {
   {
       name = "Grand Master Oberon",
       storage = Storage.TheSecretLibrary.TheOrderOfTheFalcon.OberonTimer,
   },
   {
       name = "Scarlett Etzel",
       storage = Storage.GraveDanger.CobraBastion.ScarlettTimer,
   }
}

local talk = TalkAction("!bosstimer")
function talk.onSay(player, words, param)
   local window = ModalWindow {
       title = "Boss Timers",
       message = "Select a boss to check the timer."
   }

   for i = 1, #bosses do
       local choice = window:addChoice(bosses[i].name)
       choice.value = i
   end

   window:addButton("Check",
       function(button, choice)
           local boss = bosses[choice.value]
           if boss then
               local time = player:getStorageValue(boss.storage)
               if time > os.time() then
                   player:sendTextMessage(MESSAGE_EVENT_ADVANCE,
                       boss.name .. " will respawn in " .. os.date("%H:%M:%S", time - os.time()) .. ".")
               else
                   player:sendTextMessage(MESSAGE_EVENT_ADVANCE, boss.name .. " is not dead.")
               end
           end
       end
   )

   window:addButton('Close')
   window:setDefaultEnterButton('Check')
   window:setDefaultEscapeButton('Close')
   window:sendToPlayer(player)

   return false
end

talk:register() --]]