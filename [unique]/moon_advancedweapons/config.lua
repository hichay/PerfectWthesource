Config = Config or {}
Config["license_key"] = "" --- Your license key here
Config.SharedObject = 'esx:getSharedObject' -- ESX Shared Object / Change if using a custom version of ESX

Config.DrawDistance = 100
Config.Locale       = 'en'

Config.attachments = {
	
	["attach_at_scope_medium"] = {
		key = "COMPONENT_AT_SCOPE_MEDIUM",
		replace = {},
	},
	
	["attach_at_scope_macro"] = {
		key = "COMPONENT_AT_SCOPE_MACRO",
		replace = {},
	},
	
	["attach_at_ar_afgrip"] = {
		key = "COMPONENT_AT_AR_AFGRIP",
		replace = {},
	},
	
	["attach_at_ar_supp02"] = {
		key = "COMPONENT_AT_AR_SUPP_02",
		replace = {},
	},
	
	["attach_at_ar_flsh"] = {
		key = "COMPONENT_AT_AR_FLSH",
		replace = {},
	},
	
	-- new attachment
	["attach_at_pi_flsh"] = {
		key = "COMPONENT_AT_PI_FLSH",
		replace = {},
	},
	
	["attach_at_pi_supp"] = {
		key = "COMPONENT_AT_PI_SUPP",
		replace = {},
	},
	
	["attach_at_pi_supp02"] = {
		key = "COMPONENT_AT_PI_SUPP_02",
		replace = {},
	},
	
	["attach_at_scope_small"] = {
		key = "COMPONENT_AT_SCOPE_SMALL",
		replace = {},
	},
	
	["attach_at_scope_large"] = {
		key = "COMPONENT_AT_SCOPE_LARGE",
		replace = {},
	},
	
	["attach_at_scope_largef"] = {
		key = "COMPONENT_AT_SCOPE_LARGE_FIXED_ZOOM",
		replace = {},
	},
	
	["attach_at_scope_max"] = {
		key = "COMPONENT_AT_SCOPE_MAX",
		replace = {},
	},
	
	["attach_at_ar_supp"] = {
		key = "COMPONENT_AT_AR_SUPP",
		replace = {},
	},
	
	
	
	-- Pistol
	["attach_pi_clip2"] = {
		key = "COMPONENT_PISTOL_CLIP_02",
		replace = {},
	},
	["attach_skin_pi_luxe"] = {
		key = "COMPONENT_PISTOL_VARMOD_LUXE",
		replace = {},
	},
	
	--micromsg
	["attach_msmg_clip2"] = {
		key = "COMPONENT_MICROSMG_CLIP_02",
		replace = {},
	},
	["attach_skin_msmg_luxe"] = {
		key = "COMPONENT_MICROSMG_VARMOD_LUXE",
		replace = {},
	},
	["attach_skin_msmg_neonr"] = {
		key = "COMPONENT_MICROSMG_RPV_NEONR",
		replace = {},
	},
	
	--heavypistol
	["attach_hpi_clip2"] = {
		key = "COMPONENT_HEAVYPISTOL_CLIP_02",
		replace = {},
	},
	["attach_skin_hpi_luxe"] = {
		key = "COMPONENT_HEAVYPISTOL_VARMOD_LUXE",
		replace = {},
	},
	
	--carbinerifle
	["attach_cr_clip2"] = {
		key = "COMPONENT_CARBINERIFLE_CLIP_02",
		replace = {
			COMPONENT_CARBINERIFLE_CLIP_03
		},
	},
	["attach_cr_clip3"] = {
		key = "COMPONENT_CARBINERIFLE_CLIP_03",
		replace = {
			COMPONENT_CARBINERIFLE_CLIP_02
		},
	},
	["attach_skin_cr_luxe"] = {
		key = "COMPONENT_CARBINERIFLE_VARMOD_LUXE",
		replace = {},
	},
	
	-- ASSAULTRIFLE
	["attach_assaultrifle_clip2"] = {
		key = "COMPONENT_ASSAULTRIFLE_CLIP_02",
		replace = {
			COMPONENT_ASSAULTRIFLE_CLIP_03
		},
	},
	
	["attach_assaultrifle_clip3"] = {
		key = "COMPONENT_ASSAULTRIFLE_CLIP_03",
		replace = {
			COMPONENT_ASSAULTRIFLE_CLIP_02
		},
	},
	
	["attach_skin_ak_luxe"] = {
		key = "COMPONENT_ASSAULTRIFLE_VARMOD_LUXE",
		replace = {},
	},
	
	
	---Carbine Skin New
	
	["attach_skin_cb_divi"] = {
		key = "COMPONENT_CARBINERIFLE_MKMOD_DIVI",
		replace = {},
	},
	
	["attach_skin_cb_redcamo"] = {
		key = "COMPONENT_CARBINERIFLE_MKMOD_REDCAMO",
		replace = {},
	},
	

	---ASSAULTRIFLE Skin New
	
	["attach_skin_cb_aquamarine"] = {
		key = "COMPONENT_ASSAULTRIFLE_MKMOD_AMARINE",
		replace = {},
	},
	
	["attach_skin_cb_elitebuild"] = {
		key = "COMPONENT_ASSAULTRIFLE_MKMOD_ELITEBUILD",
		replace = {},
	},
	
	["attach_skin_cb_frontsidem"] = {
		key = "COMPONENT_ASSAULTRIFLE_MKMOD_FRONTSIDEM",
		replace = {},
	},
	
	["attach_skin_cb_jaguar"] = {
		key = "COMPONENT_ASSAULTRIFLE_MKMOD_JAGUAR",
		replace = {},
	},
	
	["attach_skin_cb_rebel"] = {
		key = "COMPONENT_ASSAULTRIFLE_MKMOD_REBEL",
		replace = {},
	},
	
	["attach_skin_cb_redline"] = {
		key = "COMPONENT_ASSAULTRIFLE_MKMOD_REDLINE",
		replace = {},
	},
	
	["attach_skin_cb_vulkan"] = {
		key = "COMPONENT_ASSAULTRIFLE_MKMOD_VULKAN",
		replace = {},
	},
	
	["attach_skin_cb_orbit"] = {
		key = "COMPONENT_ASSAULTRIFLE_MKMOD_ORBIT",
		replace = {},
	},
	
	["attach_skin_cb_assimov"] = {
		key = "COMPONENT_ASSAULTRIFLE_MKMOD_ASSIMOV",
		replace = {},
	},
	
	["attach_skin_cb_blacklaminate"] = {
		key = "COMPONENT_ASSAULTRIFLE_MKMOD_BLACKLAMINATE",
		replace = {},
	},
	
	["attach_skin_cb_bloodsport"] = {
		key = "COMPONENT_ASSAULTRIFLE_MKMOD_BLOODSPORT",
		replace = {},
	},
	
	["attach_skin_cb_cartel"] = {
		key = "COMPONENT_ASSAULTRIFLE_MKMOD_CARTEL",
		replace = {},
	},
	
	["attach_skin_cb_casehardened"] = {
		key = "COMPONENT_ASSAULTRIFLE_MKMOD_CASEHARDENED",
		replace = {},
	},
	
	["attach_skin_cb_emeraldpinstripe"] = {
		key = "COMPONENT_ASSAULTRIFLE_MKMOD_EMERALDPINSTRIPE",
		replace = {},
	},
	
	["attach_skin_cb_empress"] = {
		key = "COMPONENT_ASSAULTRIFLE_MKMOD_EMPRESS",
		replace = {},
	},
	
	["attach_skin_cb_fireserpent"] = {
		key = "COMPONENT_ASSAULTRIFLE_MKMOD_FIRESERPENT",
		replace = {},
	},
	
	["attach_skin_cb_firstclass"] = {
		key = "COMPONENT_ASSAULTRIFLE_MKMOD_FIRSTCLASS",
		replace = {},
	},
	
	["attach_skin_cb_fuelinjector"] = {
		key = "COMPONENT_ASSAULTRIFLE_MKMOD_FUELINJECTOR",
		replace = {},
	},
	
	["attach_skin_cb_hydroponic"] = {
		key = "COMPONENT_ASSAULTRIFLE_MKMOD_HYDROPONIC",
		replace = {},
	},
	
	["attach_skin_cb_jetset"] = {
		key = "COMPONENT_ASSAULTRIFLE_MKMOD_JETSET",
		replace = {},
	},
	
	["attach_skin_cb_neonrevolution"] = {
		key = "COMPONENT_ASSAULTRIFLE_MKMOD_NEONREVOLUTION",
		replace = {},
	},
	
	["attach_skin_cb_neonraider"] = {
		key = "COMPONENT_ASSAULTRIFLE_MKMOD_NEONRAIDER",
		replace = {},
	},
	
	["attach_skin_cb_pointdisarray"] = {
		key = "COMPONENT_ASSAULTRIFLE_MKMOD_POINTDISARRAY",
		replace = {},
	},
	
	["attach_skin_cb_predator"] = {
		key = "COMPONENT_ASSAULTRIFLE_MKMOD_PREDATOR",
		replace = {},
	},
	
	["attach_skin_cb_redlaminate"] = {
		key = "COMPONENT_ASSAULTRIFLE_MKMOD_REDLAMINATE",
		replace = {},
	},
	
	["attach_skin_cb_safarimesh"] = {
		key = "COMPONENT_ASSAULTRIFLE_MKMOD_SAFARIMESH",
		replace = {},
	},
	
	["attach_skin_cb_safetynet"] = {
		key = "COMPONENT_ASSAULTRIFLE_MKMOD_SAFETYNET",
		replace = {},
	},
	
	["attach_skin_cb_uncharted"] = {
		key = "COMPONENT_ASSAULTRIFLE_MKMOD_UNCHARTED",
		replace = {},
	},
	
	["attach_skin_cb_bluelaminate"] = {
		key = "COMPONENT_ASSAULTRIFLE_MKMOD_BLUELAMINATE",
		replace = {},
	},
	
	
	
	
}