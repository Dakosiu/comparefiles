local ChestSomeLevel = Action()
local StorageSomeLevel = 99739

local Pos = Position(846, 870, 4)

function ChestSomeLevel.onUse(player, item, fromPosition, target, toPosition,
                              isHotkey)
    if player:getStorageValue(LvlChest) == 0 then
        item:getPosition():sendMagicEffect(33)
        player:addItem(2160, 1)
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You received a level reward")
        player:setStorageValue(LvlChest, 1)
    else
        item:getPosition():sendMagicEffect(CONST_ME_POFF)
        player:sendCancelMessage("You cant open the chest")
    end
end

ChestSomeLevel:aid(99539)
ChestSomeLevel:register()

local globalevent = GlobalEvent("load_ChestSomeLevel")

function globalevent.onStartup()
    local tile = Tile(Pos)
    if tile then
        local thing = tile:getTopVisibleThing()
        if thing then
            thing:setAttribute(ITEM_ATTRIBUTE_ACTIONID, StorageSomeLevel)
        end
    end
end

globalevent:register()