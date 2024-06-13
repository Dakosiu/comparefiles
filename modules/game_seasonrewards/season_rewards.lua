local seasonEndWindow = nil
local avaibleRewardsList = nil

local achievedPointsLabel = nil
local rankingPositionLabel = nil
local achievedTitleLabel = nil
local totalKillsLabel = nil
local comboKillsLabel = nil
local assistanceKillsLabel = nil
local availableHighscoreTextList = nil
local avaibleRewardsTextList = nil

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end


    
function init()
	--g_keyboard.bindKeyDown('Ctrl+C', toggle)
	connect(g_game, {onGameEnd = terminate})
	seasonEndWindow = g_ui.displayUI('season_rewards')
	seasonEndWindow:setVisible(false)
	ProtocolGame.registerExtendedOpcode(175, onReceiveRequest)
	
	
	
	
	
	avaibleRewardsList = seasonEndWindow:getChildById('availableRewards')
	achievedPointsLabel = seasonEndWindow:getChildById('achievedPointsLabel')
	achievedTitleLabel = seasonEndWindow:getChildById('achievedTitleLabel')
    rankingPositionLabel = seasonEndWindow:getChildById('rankingPositionLabel')
	
	totalKillsLabel = seasonEndWindow:getChildById('totalKillsLabel')
	comboKillsLabel = seasonEndWindow:getChildById('comboKillsLabel')
	assistanceKillsLabel = seasonEndWindow:getChildById('assistanceKillsLabel')
	
	availableHighscoreTextList = seasonEndWindow:getChildById('availableHighscore')
	
	avaibleRewardsTextList = seasonEndWindow:getChildById('availableRewards')
end

function terminate()
    seasonEndWindow:setVisible(false)
end


-- function toggle()
    -- seasonEndWindow:setVisible(true)
	
	-- for i, v in pairs(avaibleRewardsList:getChildren()) do
	    -- for z, b in pairs(v:getChildren()) do
		    -- --b:setItemId(500)
		-- end
	-- end
	
	
	
-- end

function onReceiveRequest(self, opcode, buffer)
    local data = json.decode(buffer)
	if data.buffer == "fetchData" then
		achievedPointsLabel:setText(data.points)
		rankingPositionLabel:setText(data.ranking)
		achievedTitleLabel:setText(data.title)
		totalKillsLabel:setText(data.totalKills)
		comboKillsLabel:setText(data.comboKills)
		assistanceKillsLabel:setText(data.assistances)
		for index, v in ipairs(data.highScores) do
		    local panel = g_ui.createWidget("HighscorePanel", availableHighscoreTextList)
			local nameLabel = panel:getChildById('scoreName')
			nameLabel:setText(index .. ". " .. v.name)
			local pointsLabel = panel:getChildById('value')
			pointsLabel:setText(v.points)
			local localPlayer = g_game.getLocalPlayer()
		    if localPlayer and localPlayer:getName():lower() == v.name:lower() then
		        panel:setBackgroundColor("#b3bda5")
		    end
		end
		local rewards = data.rewards
		if rewards then
		    local max_size = 4
			local size = 1
			local currentPanelId = 1
			for i, v in pairs(rewards) do
			    local panel = avaibleRewardsTextList:getChildById('rewardPanel' .. currentPanelId)
				local slot = panel:getChildById("Item" .. size)
                slot:setItemId(v.clientId)
				--slot:setText("Exp")
			    --slot:setColor("#d9d4c5")
			    --slot:setTooltip("666666" .. " Experience")
                size = size + 1
                if size == max_size then
                    currentPanelId = currentPanelId + 1
					size = 1
                end		 
            end				
		end
		
		
		seasonEndWindow:setVisible(true)
	end
end
	
	
	