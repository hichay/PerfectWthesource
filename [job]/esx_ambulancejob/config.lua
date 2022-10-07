Config                            = {}

Config.DrawDistance               = 100.0

Config.Marker                     = {type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false}

Config.ReviveReward               = 100  -- revive reward, set to 0 if you don't want it enabled
Config.Hoisinhcommand               = 500
Config.AntiCombatLog              = true -- enable anti-combat logging?
Config.LoadIpl                    = false -- disable if you're using fivem-ipl or other IPL loaders
Config.CheckInHospital            = 200

Config.Locale                     = 'en'

Config.EarlyRespawnTimer          = 60000 * 60 -- time til respawn is available
Config.BleedoutTimer              = 60000 * 60 -- time til the player bleeds out

Config.EnablePlayerManagement     = true

Config.RemoveWeaponsAfterRPDeath  = true
Config.RemoveCashAfterRPDeath     = true
Config.RemoveItemsAfterRPDeath    = true
Config.EnableJobBlip              = true -- enable blips for colleagues, requires esx_society
Config.EnableESXService           = false -- enable esx service?

-- Let the player pay for respawning early, only if he can afford it.
Config.EarlyRespawnFine           = true
Config.EarlyRespawnFineAmount     = 5000

Config.RespawnPoint = {coords = vector3(312.31, -591.6, 43.28), heading = 60.74}

Config.Hospitals = {

	Pillbox = {
		Name = "Trụ sở pill box",
		Blip = {
			Coords  = vector3(298.84, -584.7, 43.26),
			Sprite  = 61,
			Display = 4,
			Scale   = 1.2,
			Colour  = 2
		},

	},
	Sandy = {
		Name = "Trụ sở thứ Sa mạc",
		Blip = {
			Coords  = vector3(1824.8369, 3671.7902, 34.271053),
			Sprite  = 61,
			Display = 4,
			Scale   = 1.2,
			Colour  = 2
		},

	}
	

}