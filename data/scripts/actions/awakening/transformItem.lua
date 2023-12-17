local config = {
	[35359] = {changeTo = 35239},
	[35239] = {changeBack = 35359},
	[31947] = {changeTo = 31949},
	[31949] = {changeBack = 31947, changeTo = 31948},
	[31948] = {changeBack = 31949, changeTo = 31950},
	[31950] = {changeBack = 31948},
	[35427] = {changeTo = 18422},
	[18422] = {changeBack = 35427, changeTo = 18423},
	[18423] = {changeBack = 18422},
}
local transformItem = Action()

function transformItem.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local coin = config[item:getId()]
	if coin.changeTo and item.type == 100 then
		item:remove()
		player:addItem(coin.changeTo, 1)
	elseif coin.changeBack then
		item:remove(1)
		player:addItem(coin.changeBack, 100)
	else
		return false
	end
	return true
end

for item, _ in pairs(config) do
	transformItem:id(item)
end
transformItem:register()
