local statues = {
    ["1000,1000,7"] = {outfitIds = {128, 129}, addon = 1, name = "Citizen"},
    ["1001,1001,7"] = {outfitIds = {130, 131}, addon = 2, name = "Hunter"},
}

local statueAddon = Action()

function statueAddon.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local posString = string.format("%d,%d,%d", toPosition.x, toPosition.y, toPosition.z)
    local statue = statues[posString]

    if not statue then
        player:sendCancelMessage("This statue does nothing.")
        return true
    end

    local outfitIds = statue.outfitIds
    local addonId = statue.addon
    local outfitName = statue.name

    local outfitId = outfitIds[1]
    if player:getSex() == PLAYERSEX_FEMALE then
        outfitId = outfitIds[2]
    end

    if player:hasOutfit(outfitId, addonId) then
        player:sendCancelMessage("You already have this addon.")
        return true
    end

    if not player:hasOutfit(outfitId, 0) then
        player:addOutfit(outfitId)
    end

    player:addOutfitAddon(outfitId, addonId)

    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("You have received the %s addon!", outfitName))
    player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)

    return true
end

statueAddon:aid(6666)
statueAddon:register()
