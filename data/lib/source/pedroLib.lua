--? AID
removeItemsOnClick = 33000 --> 34000
CantThrash = 45090
basinSystem = 45091 --> 45093
basinSystemLever = 45092 --> 45093
basinSystemBasin = 45093 --> 45093
--? AID

--* Storages
runesStorage = 51110 --> 51130
waitingArena = 51450
bossStatSystem = 51490
testServer = 99949
DOINGETERNALFLAMES = 99950
BonusAttackSpeed = 99951
timeCooldownArena = 100000 -- 99952
pointsArena = 99953 -- 99953
--* Storages

-- boostedCreature = "Nothing"

function Player.sendFail(self, text, effect)
   if text then self:sendTextMessage(MESSAGE_STATUS_WARNING, text) end
   local effectIs = CONST_ME_POFF
   if effect and effect > 0 then effectIs = effect end
   return self:getPosition():sendMagicEffect(effectIs)
end

function Player.sendSuccess(self, text, effect)
   if text then self:sendTextMessage(MESSAGE_INFO_DESCR, text) end
   local effectIs = 15
   if effect and effect > 0 then effectIs = effect end
   return self:getPosition():sendMagicEffect(effectIs)
end

function Player.getTotalExpBonus(self)
   local a
   local staminaMinutes = self:getStamina()
   if staminaMinutes == 0 then return end

   local playerId = self:getId()
   if not nextUseStaminaTime[playerId] then nextUseStaminaTime[playerId] = 0 end

   local currentTime = os.time()
   local timePassed = currentTime - nextUseStaminaTime[playerId]
   if timePassed <= 0 then return end

   if timePassed > 60 then
      if staminaMinutes > 2 then
         staminaMinutes = staminaMinutes - 2
      else
         staminaMinutes = 0
      end
      nextUseStaminaTime[playerId] = currentTime + 120
   else
      staminaMinutes = staminaMinutes - 1
      nextUseStaminaTime[playerId] = currentTime + 60
   end
   a = staminaMinutes

   local rate = 0
   if a > 2400 and self:isPremium() then
      rate = rate + 10 -- 1.5
   end
   local getTotal = getGlobalStorageValue(17585)
   if getTotal and getTotal > 0 then
      rate = rate + getGlobalStorageValue(17585) / 10
   end

   --[[  if self:hasBlessing(5) then rate = rate + 10 end
   if self:hasBlessing(6) then rate = rate + 10 end
   if self:hasBlessing(5) and self:hasBlessing(6) then rate = rate + 20 end --]]
   _G.rate = rate
   return _G.rate
end

function Player.getSpeedBonus(self)
   -- local value = self:getStorageValue(85675)
   return self.accountStorage[85675]
end

function Player.getTotalSpeedBonus(self)
   -- local value = self:getSpeedBonus() + (self:getSpeed() - self:getSpeedBonus()) - self:getBaseSpeed() + self:speedStatsBonus()
   -- return self:getSpeed() - self:getSpeedBonus() - self:getBaseSpeed() - self:speedStatsBonus()
   -- return self:speedStatsBonus()
   return self:getSpeed() - self:getBaseSpeed()
end

function Player.setSpeedBonus(self, quantity)
   local value = self:setStorageValue(85675, quantity)
   self:changeSpeed(quantity)
   return value
end

function Player.getReflectBase(self)
   local value = (self:getReflect() - self:getReflectItems())
   if value <= 0 then value = 0 end
   return value
end

function Player.setReflectBase(self, quantity)
   local quantity = self:getReflectBase()
   quantity = quantity + self:getReflectItems()
   quantity = self:setReflect(quantity)
   value = quantity
   return value
end

function Player.getStatsPoint(player, value)
   local value = player:getStorageValue(STATS_POINT)
   return value
end

function Player.addStatsPoint(player, value)
   local value = player:setStorageValue(STATS_POINT, (player:getStatsPoint() + value))
   return value
end

function timeLeft(number, usewords)
   local number = tonumber(number)
   if not number then
      return "error"
   end

   if number < 0 then
      return "expired"
   end

   local clocknum = os.date("!%X", number):split(":") -- h:m:s
   local day = math.modf(number / 86400)
   local hour = clocknum[1]
   local minute = clocknum[2]
   local second = clocknum[3]

   if not usewords then
      return table.concat({ day, hour, minute, second }, ":")
   end

   local text = {}
   if day > 0 then
      table.insert(text, tonumber(day) .. " day" .. (day > 1 and "s" or ""))
   end

   if hour ~= "00" then
      table.insert(text, tonumber(hour) .. " hour" .. (tonumber(hour) > 1 and "s" or ""))
   end

   if minute ~= "00" then
      table.insert(text, tonumber(minute) .. " minute" .. (tonumber(minute) > 1 and "s" or ""))
   end

   if second ~= "00" then
      table.insert(text, tonumber(second) .. " second" .. (tonumber(second) > 1 and "s" or ""))
   end

   countdown_text = ""
   if #text > 0 then
      countdown_text = text[1]
      for i = 2, #text - 1 do
         countdown_text = countdown_text .. ", " .. text[i]
      end
      if #text > 1 then
         countdown_text = countdown_text .. " and " .. text[#text]
      end
      countdown_text = countdown_text .. "."
   else
      countdown_text = "expired"
   end
   return countdown_text
end

function Player.setStatsPoint(player, value)
   local value = player:setStorageValue(STATS_POINT, value)
   return value
end

function Player.SME(player, effect)
   local value = player:getPosition():sendMagicEffect(effect)
   return value
end

function Player.sendMagicEffect(player, effect)
   local value = player:getPosition():sendMagicEffect(effect)
   return value
end

function Item.setUnmovable(thing) return thing:setCustomAttribute("Unmovable", 1) end

-- !BOUNCE
function Item.getBounce(thing) return thing:getCustomAttribute("Bounce") end

function Item.addBounce(thing, quantity)
   local value = 0
   if thing:getBounce() then
      value = thing:setCustomAttribute("Bounce", thing:getBounce() + quantity)
   else
      value = thing:setCustomAttribute("Bounce", quantity)
   end
   return value
end

-- ! CHAIN
function Item.getChain(thing) return thing:getCustomAttribute("Chain") end

function Item.addChain(thing, quantity)
   local value = 0
   if thing:getChain() then
      value = thing:setCustomAttribute("Chain", thing:getChain() + quantity)
   else
      value = thing:setCustomAttribute("Chain", quantity)
   end
   return value
end

-- !BLOW
function Item.getBlow(thing) return thing:getCustomAttribute("Blow") end

function Item.addBlow(thing, quantity)
   local value = 0
   if thing:getBlow() then
      value = thing:setCustomAttribute("Blow", thing:getBlow() + quantity)
   else
      value = thing:setCustomAttribute("Blow", quantity)
   end
   return value
end

function Item.getBlow(thing) return thing:getCustomAttribute("Blow") end

-- !EXPLOSION
function Item.addExplosion(thing, quantity)
   local value = 0
   if thing:getExplosion() then
      value = thing:setCustomAttribute("Explosion",
         thing:getExplosion() + quantity)
   else
      value = thing:setCustomAttribute("Explosion", quantity)
   end
   return value
end

function Item.getExplosion(thing) return thing:getCustomAttribute("Explosion") end

function Player.onLookBonusHealth(thing)
   return thing:getAllBonusesHealth() - thing:getExtraHealthAddon()
end

function Player.onLookBonusMana(thing)
   return thing:getAllBonusesMana() - thing:getExtraManaAddon()
end

function Player.getTotalExtraHealing(player)
   local toADD = 0
   if player:getItemsExtraHealing() then
      toADD = player:getItemsExtraHealing()
   end
   return player:getExtraHealingBase() + player:getAddonsExtraHealing() +
       player:healingBoostStatsBonus() + toADD
end

function Player.getTotalReflect(player)
   return player:getReflect() + player:reflectStatsBonus()
end

function Player.getTotalDodge(player)
   return player:getDodge() + player:dodgeStatsBonus()
end

function Sleep(seconds)
   local endTime = os.time() + seconds
   while os.time() < endTime do
   end
end

function Player.getItemCurrency(player)
   local small
   local big
   local value

   small = player:getItemCount(26180)
   big = player:getItemCount(26179)
   value = small + big

   return value, small, big
end

function Player.getMeleeSkill(player)
   local sword = player:getEffectiveSkillLevel(SKILL_SWORD)
   local axe = player:getEffectiveSkillLevel(SKILL_AXE)
   local club = player:getEffectiveSkillLevel(SKILL_CLUB)
   local value = sword + axe + club
   return value
end

function Player.getAxeSkill(player)
   local axe = player:getEffectiveSkillLevel(SKILL_AXE)
   return axe
end

function addTimer(seconds, color, createPos)
   for i = 1, seconds do
      addEvent(function()
         createPos:sendAnimatedText(seconds + 1 - i, color)
      end, i * 1000)
   end
end

function Player.eventChannel(self, message)
   self:sendTextMessage(MESSAGE_EVENT_ADVANCE, message)
   return self:sendChannelMessage("Event", message, TALKTYPE_CHANNEL_O, 11)
end

function Player:eventSendTextMessage(type, text, position, primaryValue, primaryColor, secondaryValue, secondaryColor)
   self:sendTextMessage(type, text, position, primaryValue, primaryColor, secondaryValue, secondaryColor)
   self:sendChannelMessage("Event", text, TALKTYPE_CHANNEL_O, 11)
end

function doAddActionIDSonTop(configuration, actionID, name, single)
   if single == true then
       local tile = Tile(configuration.Pos)
       if tile then
           local thing = tile:getTopVisibleThing()
           if thing then
               thing:setAttribute(ITEM_ATTRIBUTE_ACTIONID, actionID)
           end
       end
   end
   if not single or single == false then
       for i in pairs(configuration) do
           local tile = Tile(Position(configuration[i].Pos.x,
                   configuration[i].Pos.y,
                   configuration[i].Pos.z)) or
               Tile(
                   Position(configuration[i].Pos[1],
                       configuration[i].Pos[2],
                       configuration[i].Pos[3]))
           if tile then
               local thing = tile:getTopVisibleThing()
               if thing then
                   thing:setAttribute(ITEM_ATTRIBUTE_ACTIONID, actionID + i)
               end
           end
       end
   end
   printColor(string.format(">> %s System Loaded", name), "yellow")
end