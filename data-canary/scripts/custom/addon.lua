local presentBoxOnUse = Action()

local itemId = 27846
local outfits = {
    {name = "Hunter", ids = {female = 137, male = 129}},
    {name = "Knight", ids = {female = 139, male = 131}},
    {name = "Nobleman", ids = {female = 140, male = 132}},
    {name = "Warrior", ids = {female = 142, male = 134}},
    {name = "Barbarian", ids = {female = 147, male = 143}},
    {name = "Druid", ids = {female = 148, male = 144}},
    {name = "Pirate", ids = {female = 155, male = 151}},
    {name = "Assassin", ids = {female = 156, male = 152}},
    {name = "Beggar", ids = {female = 157, male = 153}},
    {name = "Shaman", ids = {female = 158, male = 154}},
    {name = "Norseman", ids = {female = 252, male = 251}},
    {name = "Nightmare", ids = {female = 269, male = 268}},
    {name = "Jester", ids = {female = 270, male = 273}},
    {name = "Brotherhood", ids = {female = 279, male = 278}},
    {name = "Demon Hunter", ids = {female = 288, male = 289}},
    {name = "Yalaharian", ids = {female = 324, male = 325}},
    {name = "Warmaster", ids = {female = 336, male = 335}},
    {name = "Wayfarer", ids = {female = 366, male = 367}}
}

local addons = {1, 2}

function presentBoxOnUse.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local playerId = player:getId()
    local sex = player:getSex()
    local modalWindow = ModalWindow({
        title = 'Outfit Selection',
        message = 'Choose an outfit:',
    })

    for _, outfit in pairs(outfits) do
        local outfitId = (sex == PLAYERSEX_FEMALE) and outfit.ids.female or outfit.ids.male
        local hasOutfit = player:hasOutfit(outfitId, 0)
        local prefix = hasOutfit and "[X]" or "[ ]"

        modalWindow:addChoice(prefix .. ' ' .. outfit.name, function(_, button, choice)
            if button.name == "Select" then
                showAddonSelection(playerId, outfit)
            end
        end)
    end

    modalWindow:addButton("Select")
    modalWindow:addButton("Close")

    modalWindow:sendToPlayer(player)

    return true
end

function showAddonSelection(playerId, outfit)
    local player = Player(playerId)
    if not player then return end
    
    local modalWindow = ModalWindow({
        title = 'Addon Selection',
        message = 'Choose an addon for ' .. outfit.name .. ':',
    })

    for _, addon in pairs(addons) do
        local femaleOutfitId = outfit.ids.female
        local maleOutfitId = outfit.ids.male
        local hasFemaleAddon = player:hasOutfit(femaleOutfitId, addon)
        local hasMaleAddon = player:hasOutfit(maleOutfitId, addon)
        local prefix = (hasFemaleAddon or hasMaleAddon) and "[X]" or "[ ]"

        modalWindow:addChoice(prefix .. " Addon " .. addon, function(_, button, choice)
            if button.name == "Select" then
                if hasFemaleAddon and hasMaleAddon then
                    player:sendCancelMessage('You already possess ' .. outfit.name .. ' with Addon ' .. addon)
                else
                    if not player:removeItem(itemId, 1) then
                        player:sendCancelMessage('Cannot remove item from inventory, addon not granted.')
                        return
                    end
                    
                    if not hasFemaleAddon then
                        player:addOutfitAddon(femaleOutfitId, addon)
                    end

                    if not hasMaleAddon then
                        player:addOutfitAddon(maleOutfitId, addon)
                    end

                    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You received ' .. outfit.name .. ' with Addon ' .. addon)
                end
            end
        end)
    end

    modalWindow:addButton("Select")
    modalWindow:addButton("Close")

    modalWindow:sendToPlayer(player)
end

presentBoxOnUse:id(itemId)
presentBoxOnUse:register()
