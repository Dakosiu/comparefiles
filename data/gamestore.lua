CS_SHOP_RECEIVE = 202
CS_SHOP_SERVERSIDE = 203

GameStore = {
	table = "accounts",
	tableName = "alpha_points",
	historyMaxRows = 26,
	storeUrl = "https://google.com",
	imagesUrl = "https://google.com",
	debug = false
}

GameStore_OfferTypes = {
	OFFER_TYPE_NONE = 0,
	OFFER_TYPE_ITEM = 1,
	OFFER_TYPE_MESSAGE = 2,
	OFFER_TYPE_OUTFIT = 3,
	OFFER_TYPE_OUTFIT_ADDON = 4,
	OFFER_TYPE_NAMECHANGE = 5,
	OFFER_TYPE_SEXCHANGE = 6,
	OFFER_TYPE_TEMPLE = 7,
	OFFER_TYPE_PREMIUM = 8,
	OFFER_TYPE_BLESSINGS = 9,
	OFFER_TYPE_ALLBLESSINGS = 10,
	OFFER_TYPE_FULLOUTFIT = 11,
	OFFER_TYPE_WINGS = 12,
	OFFER_TYPE_AURA = 13,
	OFFER_TYPE_SHADER = 14,
	OFFER_TYPE_STORAGE = 15,
	OFFER_TYPE_MOUNT = 16,
	OFFER_TYPE_PREMIUMPOINTS = 17,
}

PREMIUM_DEFAULT_DESC = "Enhance your gaming experience by gaining additional abilities and advantages:\n\n* access to Premium areas\n* use Tibia's transport system (ships, carpet)\n* more spells\n* rent houses\n* found guilds\n* offline training\n* larger depots\n* and many more\n\n- valid for all characters on this account\n- activated at purchase"
rewardIndex = {
	["Alpha Points"] = {{
		image = {"32/namechange"},
		name = "Premium Days",
		price = 750,
		id = 0,
		packageId = 865,
		actionId = 1240,
		count = 100,
		description = "+100 premium points",
		type = GameStore_OfferTypes.OFFER_TYPE_PREMIUMPOINTS,
		category_id = "1",
	}},
	["Map Statue"] = {{
		image = {"32/namechange"},
		name = "Premium Days",
		price = 750,
		id = 0,
		packageId = 865,
		actionId = 1240,
		count = 100,
		description = "+100 premium points",
		type = GameStore_OfferTypes.OFFER_TYPE_MESSAGE,
		category_id = "1",
	}},
	["Premium Days"] = {{
		image = {"32/namechange"},
		name = "Premium Days",
		price = 750,
		id = 0,
		packageId = 865,
		actionId = 1240,
		count = 100,
		description = "+100 premium points",
		type = GameStore_OfferTypes.OFFER_TYPE_PREMIUM,
		category_id = "1",
	}},
	["Alpha Points"] = {{
		image = {"32/namechange"},
		name = "Premium Days",
		price = 750,
		id = 0,
		packageId = 865,
		actionId = 1240,
		count = 100,
		description = "+100 premium points",
		type = GameStore_OfferTypes.OFFER_TYPE_PREMIUM,
		category_id = "1",
	}}
}
storeIndex = {
	[1] = {
		icon = '13/scrolls', -- path in images folder game_store/images/13/premium_small
		name = 'Recommended', -- name of category
		id = '1', -- category id
		offers = {
			{
				image = {"128/chest_wooden_128"},
				name = "Wooden Chest",
				price = 750,
                id = 0,
                packageId = 865,
                actionId = 1240,
				count = 100,
				description = "+100 premium points",
				type = GameStore_OfferTypes.OFFER_TYPE_STORAGE,
				
				-- Internal variables
				category_id = "1",
			},
			{
				image = {"128/chest_bronze_128"},
                name = "Bronze Chest",
                price = 750,
                packageId = 865,
                actionId = 1241,
                id = 0,
                count = 1,
                type = GameStore_OfferTypes.OFFER_TYPE_STORAGE,
                
                -- Internal variables
                category_id = "1",
            },
			{
				image = {"128/chest_artifact_128"},
                name = "Artifact-Chest",
                price = 750,
                id = 0,
                count = 1,
                type = GameStore_OfferTypes.OFFER_TYPE_STORAGE,
                
                -- Internal variables
                category_id = "1",
            },
		}
	},
	[2] = {
		id = '2',
		name = 'Outfits',
		icon  = '13/Items',
		offers = {
			{
                image = {female = 914, male = 914},-- for outfits/addons you must change here numbers these are outfits number from dat 
                name = "DBAF Skin",
                price = 750,
                id = "looktypeSkin2",
                count = 1,
                vocationId = {"Voc_Saiyan"},
                type = GameStore_OfferTypes.OFFER_TYPE_STORAGE,
                
                -- Internal variables
                category_id = "2",
            },
			{
                image = {female = 915, male = 915},-- for outfits/addons you must change here numbers these are outfits number from dat 
                name = "DBAF Skin",
                price = 750,
                id = "looktypeSkin2",
                count = 1,
                vocationId = {"Voc_Demon"},
                type = GameStore_OfferTypes.OFFER_TYPE_STORAGE,
                
                -- Internal variables
                category_id = "2",
            },
		}
	},
	[3] = {
		id = '3',
		name = 'Kinto',
		icon  = '13/Category_Outfits',
		offers = {
			{
                image = {female = {type=914,head=111,body=111,legs=111,feet=111,mount=918}, male = {type=131,head=111,body=111,legs=111,feet=111,mount=918}},-- for outfits/addons you must change here numbers these are outfits number from dat 
                name = "Heaven Kinto",
                price = 750,
                id = 1,
                count = 1,
                description = "Retro Knight Addons",
                type = GameStore_OfferTypes.OFFER_TYPE_MOUNT,
                
                -- Internal variables
                category_id = "3",
            },
			{
                image = {female = {type=918}, male = {type=918}},-- for outfits/addons you must change here numbers these are outfits number from dat 
                name = "Kai Kinto",
                price = 750,
                id = 2,
                count = 1,
                description = "Extra speed",
                type = GameStore_OfferTypes.OFFER_TYPE_MOUNT,
                
                -- Internal variables
                category_id = "3",
            },
		}
	},
	[4] = {
		id = '4',
		name = 'Containers',
		icon  = '13/Category_ExtraServices',
		offers = {
			{
				name = "Red Backpack",
				price = 350,
				id = 2000,
                packageId = 2151,
                actionId = 1251,
				count = 1,
				type = GameStore_OfferTypes.OFFER_TYPE_ITEM, -- type of buying item this is decription of function if you dont want to use premium from shop dont use premium type just item
				
				-- Internal variables
				category_id = "4",
			},
			{
				name = "Yellow Backpack",
				price = 350,
				id = 1999,
				count = 1,
				type = GameStore_OfferTypes.OFFER_TYPE_ITEM, -- type of buying item this is decription of function if you dont want to use premium from shop dont use premium type just item
				
				-- Internal variables
				category_id = "4",
			},
		}
	},
	[5] = {
	id = '5',
	name = 'Furniture',
	icon  = '13/Decoration',
	offers = {
		{
			name = "Blood Herb",
			price = 350,
			id = 26129,
			count = 1,
			description = "House Decoration",
			type = GameStore_OfferTypes.OFFER_TYPE_ITEM, -- type of buying item this is decription of function if you dont want to use premium from shop dont use premium type just item
			
			-- Internal variables
			category_id = "5",
		},
	}
	},
	
	[6] = {
		id = '6',
		name = 'Extras',
		icon  = '13/Category_Outfits',
		offers = {
			{
				image = {"32/namechange"},
				name = "Name Changer",
				price = 750,
				id = 1,
				count = 1,
				--description = ".",
				type = GameStore_OfferTypes.OFFER_TYPE_NAMECHANGE,
				
				-- Internal variables
				category_id = "6",
			},
			{
				image = {"32/namechange"},
                name = "Message to admin",
                price = 750,
                id = 1,
                count = 1,
                description = "Leave message to admin.",
                type = GameStore_OfferTypes.OFFER_TYPE_MESSAGE,
                
                -- Internal variables
                category_id = "6",
            },
		}
	},	
}