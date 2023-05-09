local exhaust = createConditionObject(CONDITION_EXHAUST)
setConditionParam(exhaust, CONDITION_PARAM_TICKS, 1000) -- time in seconds x1000
 
function onUse(cid, item, fromPosition, itemEx, toPosition)
 
        local hpmax, manamax = getCreatureMaxHealth(cid), getPlayerMaxMana(cid)
        local minhp, maxhp = 0, 0 -- this means 60% minimum hp healing and 65% maximum hp healing 
        local minmana, maxmana = 15, 18 -- this means 3% minimum mana healing and 5% maximum mana healing 
        local hp_add, mana_add = math.random((hpmax * (minhp/100)), (hpmax * (maxhp/100))), math.random((manamax * (minmana/100)), (manamax * (maxmana/100)))   
 
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
    	doPlayerAddMana(cid, mana_add)
    	doSendMagicEffect(getThingPos(cid), CONST_ME_MAGIC_BLUE)
    	doSendAnimatedText(getPlayerPosition(cid),"+"..hp_add.."", TEXTCOLOR_GREEN)
	doAddCondition(cid, exhaust)
    	return true
end