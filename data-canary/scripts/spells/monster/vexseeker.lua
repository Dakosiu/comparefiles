local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_YELLOW_RINGS)

local condition = Condition(CONDITION_DAZZLED)
condition:setParameter(CONDITION_PARAM_DELAYED, 1)
condition:addDamage(math.random(100, 200), 3000, -20)
combat:setArea(createCombatArea(AREA_CIRCLE5X5))
combat:addCondition(condition)

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
    local itsTimeToUse = false
    local creaturePosition = creature:getPosition()
    local lastPositionX = Game.getStorageValue(GlobalStorage.bosses.vexseeker.lastPosition.x)
    local lastPositionY = Game.getStorageValue(GlobalStorage.bosses.vexseeker.lastPosition.y)
    local lastExecuted = Game.getStorageValue(GlobalStorage.bosses.vexseeker.lastExecuted)

    Game.setStorageValue(GlobalStorage.bosses.vexseeker.lastPosition.x, creaturePosition.x)
    Game.setStorageValue(GlobalStorage.bosses.vexseeker.lastPosition.y, creaturePosition.y)

    if creaturePosition.x ~= lastPositionX or creaturePosition.y ~= lastPositionY then
        itsTimeToUse = true
    end

    if lastExecuted + 5 <= os.time() then
        itsTimeToUse = true
    end

    if not itsTimeToUse then
        creature:say("Grrrrrr.", TALKTYPE_MONSTER_SAY)
        return false
    end

    Game.setStorageValue(GlobalStorage.bosses.vexseeker.lastExecuted, os.time())

    return combat:execute(creature, var)
end

spell:name("vexseeker")
spell:words("###0")
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(true)
spell:register()