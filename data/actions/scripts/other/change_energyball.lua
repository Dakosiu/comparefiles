local config = {
	[26180] = {changeTo = 26179},
	[26179] = {changeBack = 26180},
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local ball = config[item:getId()]
	if ball.changeTo and item.type == 100 then
		item:remove()
		player:addItem(ball.changeTo, 1)
	elseif ball.changeBack then
		item:remove(1)
		player:addItem(ball.changeBack, 100)
	else
		return false
	end
	return true
end
