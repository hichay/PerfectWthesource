
Config = {}

Config['license_key'] = ''        



Config['esx_routers'] = {								
	['server_shared_obj'] = 'esx:getSharedObject',		
	['client_shared_obj'] = 'esx:getSharedObject',		
	['server_player_load'] = 'esx:playerLoaded'			
}


Config['webhook_image'] 					= 'https://imgur.com/pHPMkYX'		
Config.roleplayname							= true
Config['color'] = {							-- Decimal Colors: https://convertingcolors.com
	['^0'] = 16777215,						-- White #ffffff
	['^1'] = 16729156,						-- Light Red #ff4444
	['^2'] = 10079232,						-- Strong Green #99cc00
	['^3'] = 16759603,						-- Vivid Orange #ffbb33
	['^4'] = 39372,							-- Strong Blue #0099cc
	['^5'] = 3388901,						-- Bright Blue #33b5e5
	['^6'] = 11167436,						-- Moderate Violet #aa66cc
	['^7'] = 10070709,						-- Grayish Blue #99aab5
	['^8'] = 13369344,						-- Strong Red #cc0000
	['^9'] = 13369448						-- Strong Pink #cc0068
}

Config['webhook'] = {						
	['Login'] = 'https://discord.com/api/webhooks/803838790065193000/ZXlbuNOq4hgJtTTgKcTt_Kgo4pTTvATXRevdhtFgmRnOxCIBymn4YuIxnWmaGUBx8dWa',		
	['Logout'] = 'https://discord.com/api/webhooks/803838790065193000/ZXlbuNOq4hgJtTTgKcTt_Kgo4pTTvATXRevdhtFgmRnOxCIBymn4YuIxnWmaGUBx8dWa',	
	['Chat'] = 'https://discordapp.com/api/webhooks/732203632476553257/2_pblgbhipYx7MYQs-zn-GZT4GebcWN1-U3htGPlqgMoN2cCWPfgC9WrUGtchz-3Vsto',		
	['Dead'] = 'https://discordapp.com/api/webhooks/732203359695798322/OIVNbUXI0-fuUsWkTbmTTM_BUPG9nHDf_i6OgUP1NcvW3j9wfJX3w5dE1BgMvsOwNbcG',			
	['GiveItem'] = 'https://discordapp.com/api/webhooks/732217236026032228/Om0RSkgpB_J-BqO6mWlVMTDNBjkZHDTPttM3YKBlqNPCc-m1LSdCOqrlaAedJemdh5Qc',			
	['GiveMoney'] = 'https://discordapp.com/api/webhooks/732217502960058449/6lCd07Kp5EoyotFyzGlzgtsQKYLmnVGlTbDKqMSVAQj0rqxLGKuhvphePp4aJ79a37jl',			
	['GiveDirtyMoney'] = 'https://discordapp.com/api/webhooks/732217694207737996/Gku0sGyMYtfwBMR7V0MIUY9xW4OrKmBH6E6zvUXIOL3ddMtzMAcHJXoAb7j1ovtKKK30',			
	['GiveWeapon'] = 'https://discordapp.com/api/webhooks/732217915109277696/osGlF8Fsg2IJSgq_fwfscN8bQjxWcuky79Qa4oSrqpZNNEIfjIj4P7x6bdltY7MHxubE',			
	['RemoveItem'] = 'https://discordapp.com/api/webhooks/732218163563069563/ZqzEtFtZzUBoVKkV8XgzK3_1rh3pRCmfpGMCmv7jYp_KlMdxXHLumcBc8SNH3QgmDan9',			
	['RemoveMoney'] = 'https://discordapp.com/api/webhooks/732218354361696397/jdEB3fcBx49GgHqwYPQi27HqCKx-_8ndFzPYC6dwgDu22J8oM19IMqZp9CmkJyjWHwos',			
	['RemoveDirtyMoney'] = 'https://discordapp.com/api/webhooks/732218576018210916/VBySpyP8n515FRixb950n7S5b1z7DLYRYjAhzFhGQmLBLX9Hz2GB5kI_lTyJ297cYqPm',			
	['RemoveWeapon'] = 'https://discordapp.com/api/webhooks/732218774757048423/4j42ErJ26TECc91rQbvQd61fzpnr1Ry-a7ldffTm9KkF-ngE4rczE6cggE0eeNMKTwD9',			
	['UseItem'] = 'https://discordapp.com/api/webhooks/732218966558376006/Oxo8Mg4x9Pz2sRlyVg8ONUiI7XcmS4V7zt1KnNM3JegrJ08bLTgxHUC3OFUUvRqT0atl',			
	['PickupItem'] = 'https://discordapp.com/api/webhooks/732219183441510471/RH7hgFArxsyzS7Mw2gga6AN-PEnyriLhXT4M38piS3Up2aymxftLRb3Zij2yUcJF6oJe',			
	['PickupMoney'] = 'https://discordapp.com/api/webhooks/732219363897114697/Zo24sUvtF-LaGEHkS6nqwUhjuhaM9MSZtZKpO76PtZ04rIjPNhbI-OIkmUliTP7dG5Ee',			
	['PickupDirtyMoney'] = 'https://discordapp.com/api/webhooks/732219552934395975/pAe8f6IvlKdgytfx6XUTWq0J1Ji11NpCGLJIScmUkHBKOq4tNPyYSMRAIhAlKp_wJA67'			
}


Config["translate"] = {  
   login = "%s login into server",	
   logout = "%s logout from server (%s)",
   kill = "%s Kill %s by %s",
   kill2 = "%s Kill by %s",		 
	
}

Config["discordtemplate"] = {  
   name= "Name: **",
   identifier= "\nIdentifier: **",	
   discord= "\nDiscord: **",
   discordid= "** | Discord ID: **",
   ipaddress= "**\nIP Address: **", 
   date= "Date: ",		
}