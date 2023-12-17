local addonItemId = 24808
local outfits = {
	             [1] = { name = "Widow Queen", id = 1 },
				 [2] = { name = "Racing Bird", id = 2 },
				 [3] = { name = "War Bear", id = 3 },
				 [4] = { name = "Black Sheep", id = 4 },
				 [5] = { name = "Midnight Panther", id = 5 },
                 [6] = { name = "Draptor", id = 6 },
				 [7] = { name = "Titanica", id = 7 },
				 [8] = { name = "Tin Lizzard", id = 8 },
				 [9] = { name = "Blazebringer", id = 9 },
				 [10] = { name = "Rapid Boar", id = 10 },
				 [11] = { name = "Stampor", id = 11 },
				 [12] = { name = "Undead Cavebear", id = 12 },
				 [13] = { name = "Donkey", id = 13 },
				 [14] = { name = "Tiger Slug", id = 14 },
				 [15] = { name = "Uniwheel", id = 15 },
				 [16] = { name = "Crystal Wolf", id = 16 },
				 [17] = { name = "War Horse", id = 17 },
				 [18] = { name = "Kingly Deer", id = 18 },
				 [19] = { name = "Tamed Panda", id = 19 },
				 [20] = { name = "Dromedary", id = 20 },
				}





	-- <mount id="21" clientid="406" name="Scorpion King" speed="20" premium="yes" />
	-- <mount id="22" clientid="421" name="Rented Horse" speed="20" premium="no" />
	-- <mount id="23" clientid="426" name="Armoured War Horse" speed="20" premium="no" />
	-- <mount id="24" clientid="427" name="Shadow Draptor" speed="20" premium="yes" />
	-- <mount id="25" clientid="437" name="Rented Horse" speed="20" premium="no" />
	-- <mount id="26" clientid="438" name="Rented Horse" speed="20" premium="no" />
	-- <mount id="27" clientid="447" name="Lady Bug" speed="20" premium="yes" />
	-- <mount id="28" clientid="450" name="Manta Ray" speed="20" premium="yes" />
	-- <mount id="29" clientid="502" name="Ironblight" speed="20" premium="yes" />
	-- <mount id="30" clientid="503" name="Magma Crawler" speed="20" premium="yes" />
	-- <mount id="31" clientid="506" name="Dragonling" speed="20" premium="yes" />
	-- <mount id="32" clientid="515" name="Gnarlhound" speed="20" premium="yes" />
	-- <mount id="33" clientid="521" name="Crimson Ray" speed="20" premium="no" />
	-- <mount id="34" clientid="522" name="Steelbeak" speed="20" premium="no" />
	-- <mount id="35" clientid="526" name="Water Buffalo" speed="20" premium="yes" />
	-- <mount id="36" clientid="546" name="Tombstinger" speed="20" premium="no" />
	-- <mount id="37" clientid="547" name="Platesaurian" speed="20" premium="no" />
	-- <mount id="38" clientid="548" name="Ursagrodon" speed="20" premium="yes" />
	-- <mount id="39" clientid="559" name="The Hellgrip" speed="20" premium="yes" />
	-- <mount id="40" clientid="571" name="Noble Lion" speed="20" premium="yes" />
	-- <mount id="41" clientid="572" name="Desert King" speed="20" premium="no" />
	-- <mount id="42" clientid="580" name="Shock Head" speed="20" premium="yes" />
	-- <mount id="43" clientid="606" name="Walker" speed="20" premium="yes" />
	-- <mount id="44" clientid="621" name="Azudocus" speed="20" premium="no" />
	-- <mount id="45" clientid="622" name="Carpacosaurus" speed="20" premium="no" />
	-- <mount id="46" clientid="624" name="Death Crawler" speed="20" premium="no" />
	-- <mount id="47" clientid="626" name="Flamesteed" speed="20" premium="no" />
	-- <mount id="48" clientid="627" name="Jade Lion" speed="20" premium="no" />
	-- <mount id="49" clientid="628" name="Jade Pincer" speed="20" premium="no" />
	-- <mount id="50" clientid="629" name="Nethersteed" speed="20" premium="no" />
	-- <mount id="51" clientid="630" name="Tempest" speed="20" premium="no" />
	-- <mount id="52" clientid="631" name="Winter King" speed="20" premium="no" />
	-- <mount id="53" clientid="644" name="Doombringer" speed="20" premium="no" />
	-- <mount id="54" clientid="647" name="Woodland Prince" speed="20" premium="no" />
	-- <mount id="55" clientid="648" name="Hailstorm Fury" speed="20" premium="no" />
	-- <mount id="56" clientid="649" name="Siegebreaker" speed="20" premium="no" />
	-- <mount id="57" clientid="650" name="Poisonbane" speed="20" premium="no" />
	-- <mount id="58" clientid="651" name="Blackpelt" speed="20" premium="no" />
	-- <mount id="59" clientid="669" name="Golden Dragonfly" speed="20" premium="no" />
	-- <mount id="60" clientid="670" name="Steel Bee" speed="20" premium="no" />
	-- <mount id="61" clientid="671" name="Copper Fly" speed="20" premium="no" />
	-- <mount id="62" clientid="672" name="Tundra Rambler" speed="20" premium="no" />
	-- <mount id="63" clientid="673" name="Highland Yak" speed="20" premium="no" />
	-- <mount id="64" clientid="674" name="Glacier Vagabond" speed="20" premium="no" />
	-- <mount id="65" clientid="688" name="Flying Divan" speed="20" premium="no" />
	-- <mount id="66" clientid="689" name="Magic Carpet" speed="20" premium="no" />
	-- <mount id="67" clientid="690" name="Floating Kashmir" speed="20" premium="no" />
	-- <mount id="68" clientid="691" name="Ringtail Waccoon" speed="20" premium="no" />
	-- <mount id="69" clientid="692" name="Night Waccoon" speed="20" premium="no" />
	-- <mount id="70" clientid="693" name="Emerald Waccoon" speed="20" premium="no" />
	-- <mount id="71" clientid="682" name="Glooth Glider" speed="20" premium="yes" />
	-- <mount id="72" clientid="685" name="Shadow Hart" speed="20" premium="no" />
	-- <mount id="73" clientid="686" name="Black Stag" speed="20" premium="no" />
	-- <mount id="74" clientid="687" name="Emperor Deer" speed="20" premium="no" />
	-- <mount id="75" clientid="726" name="Flitterkatzen" speed="20" premium="no" />
	-- <mount id="76" clientid="727" name="Venompaw" speed="20" premium="no" />
	-- <mount id="77" clientid="728" name="Batcat" speed="20" premium="no" />
	-- <mount id="78" clientid="734" name="Sea Devil" speed="20" premium="no" />
	-- <mount id="79" clientid="735" name="Coralripper" speed="20" premium="no" />
	-- <mount id="80" clientid="736" name="Plumfish" speed="20" premium="no" />
	-- <mount id="81" clientid="738" name="Gorongra" speed="20" premium="no" />
	-- <mount id="82" clientid="739" name="Noctungra" speed="20" premium="no" />
	-- <mount id="83" clientid="740" name="Silverneck" speed="20" premium="no" />
	-- <mount id="84" clientid="761" name="Slagsnare" speed="20" premium="no" />
	-- <mount id="85" clientid="762" name="Nightstinger" speed="20" premium="no" />
	-- <mount id="86" clientid="763" name="Razorcreep" speed="20" premium="no" />
	-- <mount id="87" clientid="848" name="Rift Runner" speed="20" premium="yes" />
	-- <mount id="88" clientid="849" name="Nightdweller" speed="20" premium="no" />
	-- <mount id="89" clientid="850" name="Frostflare" speed="20" premium="no" />
	-- <mount id="90" clientid="851" name="Cinderhoof" speed="20" premium="no" />
	-- <mount id="91" clientid="868" name="Mouldpincer" speed="20" premium="no" />
	-- <mount id="92" clientid="869" name="Bloodcurl" speed="20" premium="no" />
	-- <mount id="93" clientid="870" name="Leafscuttler" speed="20" premium="no" />
	-- <mount id="94" clientid="883" name="Sparkion" speed="20" premium="yes" />
	-- <mount id="95" clientid="886" name="Swamp Snapper" speed="20" premium="no" />
	-- <mount id="96" clientid="887" name="Mould Shell" speed="20" premium="no" />
	-- <mount id="97" clientid="888" name="Reed Lurker" speed="20" premium="no" />
	-- <mount id="98" clientid="889" name="Neon Sparkid" speed="20" premium="yes" />
	-- <mount id="99" clientid="890" name="Vortexion" speed="20" premium="yes" />
	-- <mount id="100" clientid="901" name="Ivory Fang" speed="20" premium="no" />
	-- <mount id="101" clientid="902" name="Shadow Claw" speed="20" premium="no" />
	-- <mount id="102" clientid="903" name="Snow Pelt" speed="20" premium="no" />

local function check(player)

    local container = player:getSlotItem(CONST_SLOT_BACKPACK)
	
    local containers = {}
	
	local items = {}
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

local players = { }
local function findOutfitTable(index)
	for i = 1, #outfits do
	    for name, t in pairs(outfits[i]) do
		    if i == index then
			   local values = { ["Table"] = outfits[i], ["Outfit Name"] = outfits[i].name, ["Id"] = outfits[i].id }
		       return values
			end
		end
	end
	return false
end

local function sendOutfitList(player)
   
   if not player then
      return nil
   end
   
   player:registerEvent("ModalWindow_mounts")
	  
   local title = "Mount Manager"
   local message = "Mount List Test: "
   
   local window = ModalWindow(1203, title, message)
   window:addButton(100, "Select") 
   window:addButton(101, "Cancel")     
   window:setDefaultEnterButton(100)
   window:setDefaultEscapeButton(101)
   
   for i = 1, #outfits do
       local name = outfits[i].name
	   local id = outfits[i].id
		   if player:hasMount(id) then
		      window:addChoice(i, "[x] " .. name)
		   else
		      window:addChoice(i, "[ ] " .. name)
		   end
   end
   return window:sendToPlayer(player)
 
end

local function getOutfitTable(player)

      if not player then
	  return nil
	  end
	  
	  local t = players[player:getId()]["Table"]
	  if not t then
	  return nil
	  end
	  
	  return t[1]
end

local function sendAddonList(player, id)
	  
	  player:registerEvent("ModalWindow_mountList")
	  local title = "Mount Manager"
	  local message = "Addon List: "
	  local window = ModalWindow(1203, title, message)
	  window:addButton(100, "Select") 
      window:addButton(101, "Cancel")
      window:setDefaultEnterButton(100)	  
      window:setDefaultEscapeButton(101)
	  
	  local outfit = getOutfitTable(player)
	  	  
	  if player:hasMount(outfit[1]) then
	     window:addChoice(1, "[x] First Addon")
	  else
	     window:addChoice(1, "[ ] First Addon")
	  end

      return window:sendToPlayer(player)
end	  

local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    
	local pos = player:getPosition()
	if not isInArray(check(player), item.uid) then
	player:sendTextMessage(MESSAGE_STATUS_WARNING, "this item cannot be used from ground.")
	pos:sendMagicEffect(CONST_ME_POFF)
	return true
	end
    sendOutfitList(player)
	return true
end
action:id(addonItemId)
action:register()

local creaturescript = CreatureEvent("ModalWindow_mounts")
function creaturescript.onModalWindow(player, modalWindowId, buttonId, choiceId) 
        
		if modalWindowId == 1203 then
		
			if buttonId == 101 then
			   return
			end
			
			if buttonId == 100 then	 
		       local t = findOutfitTable(choiceId)
		       local values = { ["Table"] = t["Table"], ["Outfit Name"] = t["Outfit Name"], ["Id"] = t["Id"] }
		       players[player:getId()] = values
		       			   
			   local id = players[player:getId()]["Id"]
               local name = players[player:getId()]["Outfit Name"]
			   
		       if player:hasMount(id) then
		          player:sendCancelMessage("You have already this mount.")
			     return true
		       end
		       
			   if not player:removeItem(addonItemId, 1) then
			      return true
			   end
			   
		   	   player:addMount(id)
		       player:sendTextMessage(MESSAGE_INFO_DESCR, "Congratulations!, you got a " .. name:lower() .. " mount.")
		   
			   local pos = player:getPosition()
		       pos:sendMagicEffect(CONST_ME_MAGIC_GREEN)

			   
			end
		end
end
creaturescript:register()