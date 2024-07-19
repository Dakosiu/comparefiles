local hungerGamesLootAction = Action()

function hungerGamesLootAction.onUse(player, item)
	local playerBackpack = player:getSlotItem(CONST_SLOT_BACKPACK)
	if not playerBackpack then
		player:sendCancelMessage("You need to have a backpack in order to loot the bag.")
		return true
	end
	if playerBackpack:getEmptySlots() < item:getSize() then
		player:sendCancelMessage("You don't have enough space in your backpack.")
		return true
	end
	local capRequired = 0
	for i=0, item:getSize()-1 do
		if item:getItem(i) then
			capRequired = capRequired + item:getItem(i):getWeight()
		end
	end
	if player:getFreeCapacity() < capRequired then
		player:sendCancelMessage("You don't have enough capacity.")
		return true
	end
	for i=0, item:getSize()-1 do
		if item:getItem(0) then
			item:getItem(0):moveTo(playerBackpack)
		end
	end
	item:remove()
	return true
end

hungerGamesLootAction:aid(hungerGamesEvent.loot.actionId)
hungerGamesLootAction:register()

local hungerGamesMoveEvent = MoveEvent()
function hungerGamesMoveEvent.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
		creature:teleportTo(fromPosition, true)
		return true
	end
	if not hungerGamesEvent:joinEvent(player) then
		creature:teleportTo(fromPosition, true)
	end
	return true
end
hungerGamesMoveEvent:aid(hungerGamesEvent.teleport.actionId)
hungerGamesMoveEvent:register()

local hungerGamesTalkaction = TalkAction("!hungergames")

function hungerGamesTalkaction.onSay(player, words, param)
    hungerGamesEvent:prepareEvent()
	return false
end

hungerGamesTalkaction:register()

local hungerGamesDeath = CreatureEvent("hungerGamesDeath")
function hungerGamesDeath.onPrepareDeath(creature, lastHitKiller, mostDamageKiller)
    hungerGamesEvent:playerDeath(creature)
    return true
end
hungerGamesDeath:register()

local hungerGamesSpellScroll = Action()

function hungerGamesSpellScroll.onUse(player, item)
	local words = item:getCustomAttribute(hungerGamesEvent.spellScrollCustomAttribute)
	if not words then return false end
	if hungerGamesEvent:addSpell(player, words) then
		item:remove()
	end
	return true
end

hungerGamesSpellScroll:id(hungerGamesEvent.spellScrollItemId)
hungerGamesSpellScroll:register()