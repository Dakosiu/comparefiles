local FixSpells = GlobalEvent("FixSpells")
local timeBetweenReload = 60 * 60 * 1000 -- in minutes

function FixSpells.onThink(interval, lastExecution)
   addEvent(function() 
      Game.reload(RELOAD_TYPE_WEAPONS)
      addEvent(function() 
         Game.reload(RELOAD_TYPE_SPELLS)
      end, 500)
   end, 1500)
end
FixSpells:interval(timeBetweenReload)
FixSpells:register()