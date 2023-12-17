function onUse(cid, item, fromPosition, itemEx, toPosition)
    local player = Player(cid)
    player:setSex(player:getSex() == PLAYERSEX_FEMALE and PLAYERSEX_MALE or PLAYERSEX_FEMALE)
    player:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
    player:sendTextMessage(MESSAGE_INFO_DESCR, "You have changed your gender.")
    Item(item.uid):remove(1)
    return true
end
