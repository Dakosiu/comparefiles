local talk = TalkAction("!repairSoft", "/repairSoft")

function talk.onSay(player, words, param)
   if player:getItemCount(10021) < 1 then
      player:sendTextMessage(MESSAGE_INFO_DESCR,"You don't have a Wasted Soft Boot")
      return false
   end
   if player:getTotalMoney() <= 5000 then
      player:sendTextMessage(MESSAGE_INFO_DESCR,"You don't have enough Money")
      return false
   end

  if player:removeItem(10021, 1) and player:removeTotalMoney(5000) then
   player:addItem(6132, 1)
   player:sendTextMessage(MESSAGE_INFO_DESCR, "You repaired your soft boots")
  end
end

talk:separator(" ")
talk:register()