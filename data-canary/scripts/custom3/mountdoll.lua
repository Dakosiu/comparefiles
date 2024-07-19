local mountItemId = 21947

local mounts = {
    {name = "Widow Queen", id = 1},
    {name = "Racing Bird", id = 2},
    {name = "War Bear", id = 3},
    {name = "Black Sheep", id = 4},
    {name = "Titanica", id = 7},
    {name = "Tin Lizzard", id = 8},
    {name = "Rapid Boar", id = 10},
    {name = "Stampor", id = 11},
    {name = "Donkey", id = 13},
    {name = "Tiger Slug", id = 14},
    {name = "Uniwheel", id = 15},
    {name = "War Horse", id = 17},
    {name = "Kingly Deer", id = 18},
    {name = "Tamed Panda", id = 19},
    {name = "Dromedary", id = 20},
    {name = "Scorpion King", id = 21},
    {name = "Rented Horse", id = 22},
    {name = "Rented Horse Gray", id = 25},
    {name = "Rented Horse Brown", id = 26},
    {name = "Water Buffalo", id = 35},
    {name = "Neon Sparkid", id = 98},
    {name = "Cold Percht Sleigh", id = 132},
    {name = "Bright Percht Sleigh", id = 133},
    {name = "Dark Percht Sleigh", id = 134},
    {name = "Cold Percht Sleigh Variant", id = 147},
    {name = "Bright Percht Sleigh Variant", id = 148},
    {name = "Dark Percht Sleigh Variant", id = 149},
    {name = "Cold Percht Sleigh Final", id = 150},
    {name = "Bright Percht Sleigh Final", id = 151},
    {name = "Dark Percht Sleigh Final", id = 152}
}

local function check(player)
    local container = player:getSlotItem(CONST_SLOT_BACKPACK)
    local containers, items = {}, {}

    if container and container:isContainer() then
        table.insert(containers, container)
    end

    while #containers > 0 do
        for i = (containers[1]:getSize() - 1), 0, -1 do
            local it = containers[1]:getItem(i)
            if it:isContainer() then
                table.insert(containers, it)
            else
                table.insert(items, it.uid)
            end
        end
        table.remove(containers, 1)
    end

    return items
end

local function sendMountList(player)
    local playerId = player:getId()
    local modalWindow = ModalWindow({
        title = "Mount Manager",
        message = "Mount List:",
    })

    for _, mount in pairs(mounts) do
        local hasMount = player:hasMount(mount.id)
        local prefix = hasMount and "[X]" or "[ ]"

        modalWindow:addChoice(prefix .. ' ' .. mount.name, function(_, button, choice)
            if button.name == "Select" then
                handleMountSelection(playerId, mount)
            end
        end)
    end

    modalWindow:addButton("Select")
    modalWindow:addButton("Close")

    modalWindow:sendToPlayer(player)
end

function handleMountSelection(playerId, mount)
    local player = Player(playerId)
    if not player then return end

    if player:hasMount(mount.id) then
        player:sendCancelMessage("You already have this mount.")
        return
    end

    if not player:removeItem(mountItemId, 1) then
        player:sendCancelMessage("Cannot remove item from inventory, mount not granted.")
        return
    end

    player:addMount(mount.id)
    player:sendTextMessage(MESSAGE_INFO_DESCR, "Congratulations! You got a " .. mount.name:lower() .. " mount.")
    player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
end

local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if not isInArray(check(player), item.uid) then
        player:sendTextMessage(MESSAGE_STATUS_WARNING, "This item cannot be used from ground.")
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return true
    end
    sendMountList(player)
    return true
end

action:id(mountItemId)
action:register()
