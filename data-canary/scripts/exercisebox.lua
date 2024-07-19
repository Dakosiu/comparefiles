local presentBoxOnUse = Action()

function presentBoxOnUse.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:getItemCount(37561) < 1 then
        player:sendCancelMessage('You do not have an exercise box in your inventory!')

        return true
    end

    local gifts = {
        {name = "lasting exercise wand", charges = 14400},
        {name = "lasting exercise sword", charges = 14400},
        {name = "lasting exercise club", charges = 14400},
        {name = "lasting exercise bow", charges = 14400},
        {name = "lasting exercise axe", charges = 14400},
        {name = "lasting exercise shield", charges = 14400},
    }

    local choices = {}

    for _, gift in pairs(gifts) do
        choices[gift.name] = function(player)
            if not player:removeItem(37561, 1) then
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You do not have an exercise box in your inventory!')
                return
            end

            local item = player:addItem(gift.name, 1)
            if item then
                item:setAttribute(ITEM_ATTRIBUTE_CHARGES, gift.charges)
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You received ' .. gift.name .. ' with ' .. gift.charges .. ' charges!')
            end
        end
    end

    local modalWindow = ModalWindow({
        title = 'Exercise Box',
        message = 'Choose your Exercise Weapon:',
    })

    for text, callback in pairs(choices) do
        modalWindow:addChoice(text, function(player, button, choice)
            if button.name == "Select" then
                callback(player)
            end
        end)
    end

    modalWindow:addButton("Select")
    modalWindow:addButton("Close")

    modalWindow:sendToPlayer(player)

    return true
end

presentBoxOnUse:id(37561)
presentBoxOnUse:register()
