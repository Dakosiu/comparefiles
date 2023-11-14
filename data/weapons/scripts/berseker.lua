local combatSmall = Combat()
combatSmall:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combatSmall:setParameter(COMBAT_PARAM_EFFECT, 7)
combatSmall:setFormula(COMBAT_FORMULA_SKILL, 1, 0, 1, 0)
local area = createCombatArea({
	{ 0, 1, 0,},
	{ 1, 3, 1,},
	{ 0, 1, 0,},
})
combatSmall:setArea(area)

local combatBig = Combat()
combatBig:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combatBig:setParameter(COMBAT_PARAM_EFFECT, 7)
combatBig:setFormula(COMBAT_FORMULA_SKILL, 100, 10, 10, 10)
local area = createCombatArea({
	{ 0, 1, 0,},
	{ 1, 1, 1,},
	{ 1, 3, 1,},
	{ 1, 1, 1,},
	{ 0, 1, 0,},
})
combatBig:setArea(area)

local combatEnormous = Combat()
combatEnormous:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combatEnormous:setParameter(COMBAT_PARAM_EFFECT, 7)
combatEnormous:setFormula(COMBAT_FORMULA_SKILL, 100, 10, 10, 10)
local area = createCombatArea({
	{ 1, 1, 1,},
	{ 1, 3, 1,},
	{ 1, 1, 1,},
})
combatEnormous:setArea(area)

local function getPlayerWeapon(player)
	local weapon = player:getSlotItem(CONST_SLOT_LEFT)
	if not weapon or weapon:getType():getWeaponType() == WEAPON_NONE then
		weapon = player:getSlotItem(CONST_SLOT_RIGHT)
		if not weapon or weapon:getType():getWeaponType() == WEAPON_NONE then
			return
		end
	end

	return weapon
end

local function isWeapon(item)
	return item:getType():getWeaponType() ~= WEAPON_NONE
end

local function isWand(item)
	return item:getType():getWeaponType() == WEAPON_WAND
end

local function isBow(item)
	return item:getType():getWeaponType() == WEAPON_DISTANCE
end

function onUseWeapon(player, var)
	local weapon
	weapon = getPlayerWeapon(player)
	if not weapon:getExplosion() then
		return combatEnormous:execute(player, var)
		
	end
	if weapon:getExplosion() < 5 then
		return combatSmall:execute(player, var)
	else
		return combatBig:execute(player, var)
	end
end
