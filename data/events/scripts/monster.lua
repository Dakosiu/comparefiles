function Monster:onDropLoot(corpse)
    if hasEventCallback(EVENT_CALLBACK_ONDROPLOOT) then
        EventCallback(EVENT_CALLBACK_ONDROPLOOT, self, corpse)
    end
end

function Monster:onSpawn(position, startup, artificial)

    local config = {
        fromPosX = 2925,
        fromPoxY = 190,
        posZ = 7,
        toPosX = 2932,
        toPosY = 214,
    }

    local a = config
    for x = a.fromPosX, a.toPosX do
        for y = a.fromPoxY, a.toPosY do
            local temporary = {x = x, y = y, z = a.posZ};
            if position.x == temporary.x and position.y == temporary.y and position.z == temporary.z then
                self:setEmblem(GUILDEMBLEM_ENEMY)
                     self:setLevel(1)
                     self:setSkull(0)
            end
        end
    end

    self:registerEvent("system_CursedChest")
    self:registerEvent("eternalflame_onDeath")
    self:registerEvent("statsSystem_onHealthChange")
    self:registerEvent("extraDamage_summon")
    self:registerEvent("bossDeath")
    self:registerEvent("trappedEnergy_onKill")
    bossSystem:register(self)

    if hasEventCallback(EVENT_CALLBACK_ONSPAWN) then
        return EventCallback(EVENT_CALLBACK_ONSPAWN, self, position, startup,
                             artificial)
    else
        return true
    end
end