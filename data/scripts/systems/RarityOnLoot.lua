--[[ local ec = EventCallback

ec.onDropLoot = function(self, corpse)
    local r = math.random(1, 1000)
    local a = ITEM_RARITY

    local player = Player(corpse:getCorpseOwner())

    local mType = self:getType()
    if player then
        local monsterLoot = mType:getLoot()
        for i = 1, #monsterLoot do
            local id = monsterLoot[i]["itemId"]
            local itemType = ItemType(id)
            if itemType:getWeaponType() ~= 0 then
                local possibilities = {}
                table.insert(possibilities, id)
                local choosed = math.random(#possibilities)
                local choosedItem = Game.createItem(2526, 1,
                                                    player:getPosition())
                choosedItem:setCustomAttribute("Tier", "demonic")
                local name = choosedItem:getName()
                choosedItem:setAttribute(ITEM_ATTRIBUTE_NAME,choosedItem:getCustomAttribute("Tier")  .. " ".. name)
                local a = ITEM_RARITY.Demonic
                local r = math.random(1, 2)
                choosedItem:setAttribute(ITEM_ATTRIBUTE_BONUSDAMAGE, a.BonusDamage[r])
                choosedItem:setAttribute(ITEM_ATTRIBUTE_REFLECTION, a.reflect[r])
                choosedItem:setAttribute(ITEM_ATTRIBUTE_EXTRAHEALING, a.extraHealing[r])
                choosedItem:setAttribute(ITEM_ATTRIBUTE_DODGE, a.dodge[r])
                choosedItem:moveTo(player)
                return true
            end
        end
    end

    --[[ if r <= a.Demonic.chance then

    elseif r <= a.Legendary.chance then

    elseif r <= a.Epic.chance then

    elseif r <= a.Rare.chance then

    end
end

ec:register()

local ec = EventCallback
function ec.onLook(player, thing, position, distance, description)
    if thing:isItem() then
        if thing:getCustomAttribute("Tier") then
            local crName = thing:getCustomAttribute("Tier")
            local name = crName:gsub("^%l", string.upper)
        end
    end

    return description
end

ec:register() --]]