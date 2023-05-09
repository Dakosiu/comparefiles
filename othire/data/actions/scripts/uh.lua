local exhaust = createConditionObject(CONDITION_EXHAUST)
setConditionParam(exhaust, CONDITION_PARAM_TICKS, 2000) -- time in seconds x1000
 
function onUse(cid, item, fromPosition, itemEx, toPosition)
 
        local hpmax = getCreatureMaxHealth(cid)
        local min = 50 -- this means 50% minimum healing
        local max = 60 -- this means 60% maximum healing
        local hp_add = math.random((hpmax * (min/100)), (hpmax * (max/100)))  
 
	if(hasCondition(cid, CONDITION_EXHAUST)) then
        	doSendMagicEffect(getThingPos(cid), CONST_ME_POFF) 
		doPlayerSendCancel(cid, "You are exhausted")
                return true
	end
	if item.type > 1 then
	doChangeTypeItem(item.uid, item.type - 1)
	else
	doRemoveItem(item.uid)
	end
    	doCreatureAddHealth(cid, hp_add)
    	doSendMagicEffect(getThingPos(cid), CONST_ME_MAGIC_BLUE)
    	doSendAnimatedText(getPlayerPosition(cid),"+"..hp_add.."", TEXTCOLOR_GREEN) 
	doAddCondition(cid, exhaust)
    	return true
end