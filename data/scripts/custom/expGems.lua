local expGems = {
   [35962] = { exp = 100 }, -- Experience pearl grade 1
   [35961] = { exp = 200 }, -- Experience pearl grade 2
   [35966] = { exp = 400 }, -- Experience pearl grade 3
   [35965] = { exp = 600 }, -- Experience pearl grade 4
   [35959] = { exp = 800 }, -- Experience pearl grade 5
   [35960] = { exp = 1000 }, -- Experience pearl grade 6
   [35964] = { exp = 1200 }, -- Experience pearl grade 7
   [35967] = { exp = 1400 }, -- Experience pearl grade 8
   [35963] = { exp = 1600 }, -- Experience pearl grade 9
}

local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player then
		return true
	end

   if player:getLevel() >= 21 and player:getVocation():getId() == 0 then
      player:sendTextMessage(MESSAGE_STATUS_WARNING, "You can't go past level 22 without having a vocation.")
      return false
   end

	local points = player:getLevel()
   local itemId = item:getId()
	item:remove(1)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You received " ..points*expGems[itemId].exp .. " XP" )
	player:addExperience(points*expGems[itemId].exp)
	return true
end

action:id(35962, 35961, 35966, 35965, 35959, 35960, 35964, 35967, 35963)
action:register()