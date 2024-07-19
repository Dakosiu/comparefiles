local Storage2 = {
	TibiaDrome = {
		-- General Upgrades
		BestiaryBetterment = {
			TimeLeft = 64000,
			LastActivatedAt = 64001,
		},
		CharmUpgrade = {
			TimeLeft = 64002,
			LastActivatedAt = 64003,
		},
		KooldownAid = {
			LastActivatedAt = 64005,
		},
		StaminaExtension = {
			LastActivatedAt = 64007,
		},
		StrikeEnhancement = {
			TimeLeft = 64008,
			LastActivatedAt = 64009,
		},
		WealthDuplex = {
			TimeLeft = 64010,
			LastActivatedAt = 64011,
		},
		-- Resilience
		FireResilience = {
			TimeLeft = 64012,
			LastActivatedAt = 64013,
		},
		IceResilience = {
			TimeLeft = 64014,
			LastActivatedAt = 64015,
		},
		EarthResilience = {
			TimeLeft = 64016,
			LastActivatedAt = 64017,
		},
		EnergyResilience = {
			TimeLeft = 64018,
			LastActivatedAt = 64019,
		},
		HolyResilience = {
			TimeLeft = 64020,
			LastActivatedAt = 64021,
		},
		DeathResilience = {
			TimeLeft = 64022,
			LastActivatedAt = 64023,
		},
		PhysicalResilience = {
			TimeLeft = 64024,
			LastActivatedAt = 64025,
		},
		-- Amplifications
		FireAmplification = {
			TimeLeft = 64026,
			LastActivatedAt = 64027,
		},
		IceAmplification = {
			TimeLeft = 64028,
			LastActivatedAt = 64029,
		},
		EarthAmplification = {
			TimeLeft = 64030,
			LastActivatedAt = 64031,
		},
		EnergyAmplification = {
			TimeLeft = 64032,
			LastActivatedAt = 64033,
		},
		HolyAmplification = {
			TimeLeft = 64034,
			LastActivatedAt = 64035,
		},
		DeathAmplification = {
			TimeLeft = 64036,
			LastActivatedAt = 64037,
		},
		PhysicalAmplification = {
			TimeLeft = 64038,
			LastActivatedAt = 64039,
		},
	},
}

local configs = {
	-- Override examples
	--- durationOverride = 30,
	--- cooldownOverride = 60,
	--- tickTypeOverride = ConcoctionTickType.Experience,

	[Concoction.Ids.StaminaExtension] = {
		amount = 60, -- minutes
		callback = function(player, config)
			player:setStamina(player:getStamina() + config.amount)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have been granted " .. config.amount .. " minutes of stamina.")
		end,
	},
	[Concoction.Ids.KooldownAid] = {
		callback = function(player)
			player:clearSpellCooldowns()
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your spells are no longer on cooldown.")
		end,
	},
	[Concoction.Ids.StrikeEnhancement] = { condition = { CONDITION_PARAM_SKILL_CRITICAL_HIT_CHANCE, 5 } },
	[Concoction.Ids.CharmUpgrade] = { condition = { CONDITION_PARAM_CHARM_CHANCE_MODIFIER, 5 } },
	[Concoction.Ids.WealthDuplex] = { rate = 100 },
	[Concoction.Ids.BestiaryBetterment] = { multiplier = 2.0 },
	[Concoction.Ids.FireResilience] = { condition = { CONDITION_PARAM_ABSORB_FIREPERCENT, 8 } },
	[Concoction.Ids.IceResilience] = { condition = { CONDITION_PARAM_ABSORB_ICEPERCENT, 8 } },
	[Concoction.Ids.EarthResilience] = { condition = { CONDITION_PARAM_ABSORB_EARTHPERCENT, 8 } },
	[Concoction.Ids.EnergyResilience] = { condition = { CONDITION_PARAM_ABSORB_ENERGYPERCENT, 8 } },
	[Concoction.Ids.HolyResilience] = { condition = { CONDITION_PARAM_ABSORB_HOLYPERCENT, 8 } },
	[Concoction.Ids.DeathResilience] = { condition = { CONDITION_PARAM_ABSORB_DEATHPERCENT, 8 } },
	[Concoction.Ids.PhysicalResilience] = { condition = { CONDITION_PARAM_ABSORB_PHYSICALPERCENT, 8 } },
	[Concoction.Ids.FireAmplification] = { condition = { CONDITION_PARAM_INCREASE_FIREPERCENT, 8 } },
	[Concoction.Ids.IceAmplification] = { condition = { CONDITION_PARAM_INCREASE_ICEPERCENT, 8 } },
	[Concoction.Ids.EarthAmplification] = { condition = { CONDITION_PARAM_INCREASE_EARTHPERCENT, 8 } },
	[Concoction.Ids.EnergyAmplification] = { condition = { CONDITION_PARAM_INCREASE_ENERGYPERCENT, 8 } },
	[Concoction.Ids.HolyAmplification] = { condition = { CONDITION_PARAM_INCREASE_HOLYPERCENT, 8 } },
	[Concoction.Ids.DeathAmplification] = { condition = { CONDITION_PARAM_INCREASE_DEATHPERCENT, 8 } },
	[Concoction.Ids.PhysicalAmplification] = { condition = { CONDITION_PARAM_INCREASE_PHYSICALPERCENT, 8 } },
}

for concoctionKey, concoctionId in pairs(Concoction.Ids) do
	Concoction.new({
		id = concoctionId,
		timeLeftStorage = Storage2.TibiaDrome[concoctionKey].TimeLeft,
		lastActivatedAtStorage = Storage2.TibiaDrome[concoctionKey].LastActivatedAt,
		config = configs[concoctionId] or {},
	}):register()
end

local concoctionsOnLogin = CreatureEvent("ConcoctionsOnLogin")

function concoctionsOnLogin.onLogin(player)
	Concoction.initAll(player, true)
	return true
end

concoctionsOnLogin:register()
