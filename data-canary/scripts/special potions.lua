SPECIAL_POTIONS_CONFIG = {
                           [36724] = {
						               criticalchance = 0.05,
									   duration = 5,
									 }
                         }






SPECIAL_POTIONS_SYSTEM = {}


function SPECIAL_POTIONS_SYSTEM:addCondition(player, t)
    
	if t.criticalchance then
	   t.criticalchance = t.criticalchance * 100
	   local subid = 111
	   local condition = Condition(CONDITION_ATTRIBUTES)
	   condition:setParameter(CONDITION_PARAM_SKILL_CRITICAL_HIT_CHANCE, t.criticalchance)
	   condition:setTicks(t.duration*60*1000)
	   condition:setParameter(CONDITION_PARAM_SUBID, subid)
	   if player:getCondition(CONDITION_ATTRIBUTES, CONDITIONID_DEFAULT, subid) then
	      player:removeCondition(CONDITION_ATTRIBUTES, subid)
	   end
	   player:addCondition(condition)
	   player:sendTextMessage(MESSAGE_INFO_DESCR, "You'r critical hit chance is increased by " .. t.criticalchance .. " this effect will end after " .. t.duration .. " minutes.")
	   player:getPosition():sendMagicEffect(CONST_ME_MAGiC_GREEN)
	   return true
	end
	return false
end


local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
   local t = SPECIAL_POTIONS_CONFIG[item:getId()]
   if not t then
      return true
   end	  
   if SPECIAL_POTIONS_SYSTEM:addCondition(player, t) then
      item:remove(1)
   end
   return true
end
for i, v in pairs(SPECIAL_POTIONS_CONFIG) do
    action:id(i)
end
action:register()
	   