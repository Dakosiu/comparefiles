local pall = {3,7}
 skille = {4,5}
 function onUse(cid, item, fromPosition, itemEx, toPosition)
 
 if getPlayerSkillLevel(cid, skille) <= 120 and isInArray(pall, getPlayerVocation(cid)) then
		doPlayerAddSkill(cid, 5, 2) -- shielding
		doRemoveItem(item.uid, 1)
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You gain 2 shielding skill points and 1 distance point!")
		doPlayerAddSkill(cid, 4, 1) -- distance
	else
	doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You are too strong or not a palladin.")
	end
return true
end 