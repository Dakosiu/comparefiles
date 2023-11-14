-- Combat settings
-- NOTE: valid values for worldType are: "pvp", "no-pvp" and "pvp-enforced"
worldType = "pvp"
hotkeyAimbotEnabled = true
protectionLevel = 40
killsToRedSkull = 5
killsToBlackSkull = 10
pzLocked = 60000
removeChargesFromRunes = true
removeChargesFromPotions = true
removeWeaponAmmunition = true
removeWeaponCharges = true
timeToDecreaseFrags = 24 * 60 * 60
whiteSkullTime = 15 * 60
stairJumpExhaustion = 300
experienceByKillingPlayers = true
expFromPlayersLevelRange = 99

-- Connection Config
-- NOTE: maxPlayers set to 0 means no limit
-- NOTE: allowWalkthrough is only applicable to players
ip = "162.19.205.63"
bindOnlyGlobalAddress = false
loginProtocolPort = 7171
gameProtocolPort = 7172
statusProtocolPort = 7171
maxPlayers = 0
motd = "Welcome to The Evotronus! Never Surrender Project!"
onePlayerOnlinePerAccount = false
allowClones = false
allowWalkthrough = true
serverName = "Evotronus"
statusTimeout = 5000
replaceKickOnLogin = true
maxPacketsPerSecond = 500
packetCompression = true

proxyList = "1,testingz.servegame.com,7172,TestServer"

-- Deaths
-- NOTE: Leave deathLosePercent as -1 if you want to use the default
-- death penalty formula. For the old formula, set it to 10. For
-- no skill/experience loss, set it to 0.
deathLosePercent = -1

-- Houses
-- NOTE: set housePriceEachSQM to -1 to disable the ingame buy house functionality
-- NOTE: valid values for houseRentPeriod are: "daily", "weekly", "monthly", "yearly"
-- use any other value to disable the rent system
housePriceEachSQM = 1500
houseRentPeriod = "weekly"
houseOwnedByAccount = true
houseDoorShowPrice = true
onlyInvitedCanMoveHouseItems = true

-- Item Usage
timeBetweenActions = 200
timeBetweenExActions = 1000

-- Level Monster System
rateMonsterHealth = 7.7
rateMonsterAttack = 7
rateMonsterDefense = 0

levelMonsterBonusAttack = 0.2
levelMonsterBonusSpeed = 0.1
levelMonsterBonusHealth = 0.1
levelMonsterBonusExperience = 0.1
levelMonsterBonusLootRate = 0.1


-- Colours
GainExperienceColour = 210
RecoveryHealthColour = 31
RecoveryManaColour = 16


-- Non Vocationn Things
levelLimit = 22

-- Map
-- NOTE: set mapName WITHOUT .otbm at the end
mapName = "otaip"
mapAuthor = "Vanagas"

-- Market
marketOfferDuration = 30 * 24 * 60 * 60
premiumToCreateMarketOffer = false
checkExpiredMarketOffersEachMinutes = 60
maxMarketOffersAtATimePerPlayer = 100

-- MySQL
mysqlHost = "127.0.0.1"
mysqlUser = "root"
mysqlPass = "aR1NClkbPmGU2PgFkFz4"
mysqlDatabase = "evotron"
mysqlPort = 3306
mysqlSock = ""

-- Misc.
-- NOTE: classicAttackSpeed set to true makes players constantly attack at regular
-- intervals regardless of other actions such as item (potion) use. This setting
-- may cause high CPU usage with many players and potentially affect performance!
-- NOTE: forceMonsterTypesOnLoad loads all monster types on startup to validate them.
-- You can disable it to save some memory if you don't see any errors at startup.
allowChangeOutfit = true
freePremium = false
kickIdlePlayerAfterMinutes = 150000
maxMessageBuffer = 4
emoteSpells = true
classicEquipmentSlots = true
classicAttackSpeed = true
showScriptsLogInConsole = false
showOnlineStatusInCharlist = false
yellMinimumLevel = 2
yellAlwaysAllowPremium = false
forceMonsterTypesOnLoad = true
cleanProtectionZones = true
luaItemDesc = false
showPlayerLogInConsole = true

-- VIP and Depot limits
-- NOTE: you can set custom limits per group in data/XML/groups.xml
vipFreeLimit = 20
vipPremiumLimit = 100
depotFreeLimit = 2000
depotPremiumLimit = 10000

-- World Light
-- NOTE: if defaultWorldLight is set to true the world light algorithm will
-- be handled in the sources. set it to false to avoid conflicts if you wish
-- to make use of the function setWorldLight(level, color)
defaultWorldLight = true

-- Server Save
-- NOTE: serverSaveNotifyDuration in minutes
serverSaveNotifyMessage = true
serverSaveNotifyDuration = 10
serverSaveCleanMap = false
serverSaveClose = false
serverSaveShutdown = true

-- Experience stages
-- NOTE: to use a flat experience multiplier, set experienceStages to nil
-- minlevel and multiplier are MANDATORY
-- maxlevel is OPTIONAL, but is considered infinite by default
-- to disable stages, create a stage with minlevel 1 and no maxlevel
--[[ experienceStages = {
	{ minlevel = 1, maxlevel = 10, multiplier = 4 },
	{ minlevel = 11, maxlevel = 20, multiplier = 3 },
	{ minlevel = 21, maxlevel = 50, multiplier = 2 },
	{ minlevel = 51, maxlevel = 100, multiplier = 1.5 },
	{ minlevel = 101, maxlevel = 200, multiplier = 1 },
	{ minlevel = 201, maxlevel = 300, multiplier = 0.9 },
	{ minlevel = 301, maxlevel = 400, multiplier = 0.8 },
	{ minlevel = 401, maxlevel = 500, multiplier = 0.7 },
	{ minlevel = 501, maxlevel = 600, multiplier = 0.6 },
	{ minlevel = 601, maxlevel = 700, multiplier = 0.5 },
	{ minlevel = 701, maxlevel = 800, multiplier = 0.4 },
	{ minlevel = 801, multiplier = 0.3 }
} --]]
experienceStages = {
	{ minlevel = 1, maxlevel = 10, multiplier = 3 },
	{ minlevel = 11, maxlevel = 20, multiplier = 2 },
	{ minlevel = 21, maxlevel = 50, multiplier = 1 },
	{ minlevel = 51, maxlevel = 100, multiplier = 0.9 },
	{ minlevel = 101, maxlevel = 200, multiplier = 0.8 },
	{ minlevel = 201, maxlevel = 300, multiplier = 0.7 },
	{ minlevel = 301, maxlevel = 400, multiplier = 0.6 },
	{ minlevel = 401, maxlevel = 500, multiplier = 0.5 },
	{ minlevel = 501, maxlevel = 600, multiplier = 0.4 },
	{ minlevel = 601, maxlevel = 700, multiplier = 0.3 },
	{ minlevel = 701, maxlevel = 800, multiplier = 0.2 },
	{ minlevel = 801, maxlevel = 850, multiplier = 0.09 },
	{ minlevel = 851, maxlevel = 900, multiplier = 0.08 },
	{ minlevel = 901, maxlevel = 950, multiplier = 0.06 },
	{ minlevel = 951, maxlevel = 1000, multiplier = 0.04 },
	{ minlevel = 1001, maxlevel = 1050, multiplier = 0.02 },
	{ minlevel = 1051, maxlevel = 1100, multiplier = 0.009 },
	{ minlevel = 1101, maxlevel = 1150, multiplier = 0.006 },
	{ minlevel = 1151, maxlevel = 1200, multiplier = 0.004 },
	{ minlevel = 1201, maxlevel = 1250, multiplier = 0.002 },
	{ minlevel = 1251, multiplier = 0.0009 }
}


-- Rates
-- NOTE: rateExp is not used if you have enabled stages above
rateExp = 1
rateSkill = 10
rateLoot = 4
rateMagic = 3
rateSpawn = 3

-- Monster Despawn Config
-- despawnRange is the amount of floors a monster can be from its spawn position
-- despawnRadius is how many tiles away it can be from its spawn position
-- removeOnDespawn will remove the monster if true or teleport it back to its spawn position if false
-- walkToSpawnRadius is the allowed distance that the monster will stay away from spawn position when left with no targets, 0 to disable
deSpawnRange = 2
deSpawnRadius = 50
removeOnDespawn = true
walkToSpawnRadius = 15

-- Stamina
staminaSystem = true

-- Scripts
warnUnsafeScripts = true
convertUnsafeScripts = true

-- Startup
-- NOTE: defaultPriority only works on Windows and sets process
-- priority, valid values are: "normal", "above-normal", "high"
defaultPriority = "high"
startupDatabaseOptimization = false

-- Status Server Information
ownerName = ""
ownerEmail = ""
url = "https://otland.net/"
location = "Sweden"
