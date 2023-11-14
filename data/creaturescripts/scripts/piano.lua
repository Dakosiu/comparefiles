function onThink(player, interval)
   
   if player:getStorageValue(751346) < os.time() then
      if player:getStorageValue(PIANO_QUEST.piano.actionid) == PIANO_QUEST.teleport.tries + 1 then
         player:setStorageValue(PIANO_QUEST.piano.actionid, 0)
	  end
   end
   return true
end


