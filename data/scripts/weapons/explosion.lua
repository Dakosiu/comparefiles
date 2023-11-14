--[[ local function getPlayerWeapon(player)
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

local Explosion = Weapon(WEAPON_SWORD)

local combatSmall = Combat()
combatSmall:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combatSmall:setParameter(COMBAT_PARAM_EFFECT, 7)
combatSmall:setFormula(COMBAT_FORMULA_SKILL, 100, 10, 10, 10)
local area = createCombatArea({
	{ 0, 1, 0, },
	{ 1, 3, 1, },
	{ 0, 1, 0, },
})
combatSmall:setArea(area)
local combatBig = Combat()
combatBig:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combatBig:setParameter(COMBAT_PARAM_EFFECT, 7)
combatBig:setFormula(COMBAT_FORMULA_SKILL, 100, 10, 10, 10)
local area = createCombatArea({
	{ 0, 1, 0, },
	{ 1, 1, 1, },
	{ 1, 3, 1, },
	{ 1, 1, 1, },
	{ 0, 1, 0, },
})
combatBig:setArea(area)

function Explosion.onUseWeapon(creature, var)
	local weapon
	weapon = getPlayerWeapon(creature)
	if weapon:getExplosion() < 5 then
		return combatSmall:(creature, execute(player, var))
	else
		return combatBig:(creature, execute(player, var))
	end
end

Explosion:id(41542)
Explosion:wieldUnproperly(false)
Explosion:register()
 --]]