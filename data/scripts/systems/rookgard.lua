--[[if not rookgardSystem then
    rookgardSystem = {}
 end
 rookgardSystem.storage = 3231
 
 function rookgardSystem:setOnRookgard(player, bool)
     
     if not player then
        return nil
     end
     
     if bool then
        return player:setStorageValue(rookgardSystem.storage, 1)
     end
     return player:setStorageValue(rookgardSystem.storage, -1)
 end
 
 function rookgardSystem:isOnRookgard(player)
 
     if not player then
       return nil
     end
     
     if player:getStorageValue(rookgardSystem.storage) == 1 then
        return true
     end
     
     return false
 end
 
 function has_value (tab, val)
     for index, value in ipairs(tab) do
         if value == val then
             return true
         end
     end
     return false
 end
 
 function Player.addEventColumn(self)
    
    if not self then
       return nil
    end
    
    local playerData = db.storeQuery("SELECT id FROM `players_event`")
    local playerGUIDT = {}
    local GUID = self:getGuid()
    local name = '"' .. self:getName() .. '"'
    
     if playerData then
         repeat
             local guid = result.getNumber(playerData, "id")
             table.insert(playerGUIDT, guid)
         until not result.next(playerData)
     end
     
     if has_value(playerGUIDT, GUID) then
        return true
     end
     
     db.query("INSERT INTO `players_event` (`id`, `name`, `account_id`, `group_id`, `sex`, `vocation`, `health`, `healthmax`, `experience`, `lookbody`, `lookfeet`, `lookhead`, `looklegs`, `looktype`, `lookaddons`, `lookaura`, `lookwings`, `lookshader`, `direction`, `maglevel`, `mana`, `manamax`, `manaspent`, `soul`, `town_id`, `posx`, `posy`, `posz`, `conditions`, `cap`, `lastlogin`, `lastip`, `save`, `skull`, `skulltime`, `lastlogout`, `blessings`, `onlinetime`, `deletion`, `balance`, `offlinetraining_time`, `offlinetraining_skill`, `stamina`, `skill_fist`, `skill_fist_tries`, `skill_club`, `skill_club_tries`, `skill_sword`, `skill_sword_tries`, `skill_axe`, `skill_axe_tries`, `skill_dist`, `skill_dist_tries`, `skill_shielding`, `skill_shielding_tries`, `skill_fishing`, `skill_fishing_tries`, `extraHealth`, `extraMana`, `extraHealthRegeneration`, `extraManaRegeneration`, `extraHealthAddon`, `extraManaAddon`, `extraHealing`, `saveStatement`, `Dodge`, `reflect`, `protectionAll`) VALUES (".. GUID .. "," .. name .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 ..", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ", " ..0 .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ", " ..0 .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ", " .. 0 .. ");") 
 
     
     return true
 end
 
 function Player.saveStatement(self)
 
     if not self then
       return nil
     end
     self:addEventColumn()
     self:saveEvent()
     return true
 end 
 
 
 
 
    --]]