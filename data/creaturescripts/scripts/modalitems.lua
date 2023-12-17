local storage = 452342457
local storage2 = storage + 1
function onModalWindow(player, modalWindowId, buttonId, choiceId)  
    player:unregisterEvent("ModalWindow_ItemStats")
    if modalWindowId == 5000 then
        if buttonId ~= 101 then
		   if itemUpgradeSystem:removeAttribute(player, choiceId) then
		      itemUpgradeSystem:removeItem(player, ITEM_STATS_CONFIG.BONUS_REMOVER)
		   end
		end
    end
end