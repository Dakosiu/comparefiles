function onUse(cid, item, frompos, itemEx, topos)
local playerinfo = -- Please don't touch
{
level = getPlayerLevel(cid),
mlevel = getPlayerMagLevel(cid),
voc = getPlayerVocation(cid)
}
local config =
{
strenght = "template", ---Values: template (strenght dependent on level and magic level), constant (on all level adding same mana)
template = {min = (((playerinfo.level * 3) + (playerinfo.mlevel * 5.9)) / 1.5) , max =(((playerinfo.level * 4) + (playerinfo.mlevel * 5)) / 1.5)}, -- liczymy - lvl * 4 /1.5 = x m lvl * 2 /1.5 = x lvl + m lvl = Minimum, lvl * 6 /1.5 = x m lvl * 4 /1.5 = x lvl + m lvl = Maximum
constant = {min = 70, max = 100},--only if strenght is constant
exhaustion = 1,--exhaustion in secs
exhaustion_value = 56789, --exhaustion storage value
minimum_level = 1,--minimum level to use manarune
minimum_mlevel = 0,--minimum magic level to use manarune
cannot_use_voc = {0} --id vocation which cannot use
}
local rand = 0
if(isPlayer(itemEx.uid) == false) then
return true
end
if(playerinfo.level < config.minimum_level) then
return true
end
if(playerinfo.mlevel < config.minimum_mlevel) then
return true
end
if(isInArray(config.cannot_use_voc, playerinfo.voc)) then
return true
end
if(config.strenght ~= "template" and config.strenght ~= "constant") then
config.strenght = "constant"
end
if(getPlayerStorageValue(cid, config.exhaustion_value) > os.time()) then
doPlayerSendTextMessage(cid, MESSAGE_EVENT_DEFAULT, "You are exhausted.")
return true
end
if(config.strenght == "template") then
rand = math.random(config.template.min, config.template.max)
elseif (config.strenght == "constant") then
rand = math.random(config.constant.min, config.constant.max)
end
if item.type > 1 then
doChangeTypeItem(item.uid, item.type - 1)
else
doRemoveItem(item.uid)
end
doPlayerAddMana(cid, rand)
setPlayerStorageValue(cid, config.exhaustion_value, (os.time() + config.exhaustion))
doCreatureSay(cid, "+"..math.floor(rand).." mana", TALKTYPE_ORANGE_1)
return true
end