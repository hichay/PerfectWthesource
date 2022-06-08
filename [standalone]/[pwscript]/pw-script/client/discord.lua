cfg = {}
--This is where you put your DiscordAppID you can get it from here https://discord.com/developers/applications
cfg.DiscordAppID = 581415681136918528 

cfg.discordImageName = 'monkeyb'
cfg.hoverText = 'Tham gia ngay nào'
cfg.richPresenceText = "[ID:" ..GetPlayerServerId(PlayerId()).. "]/128"
cfg.smallDiscordImageName = 'monke'
cfg.smallHoverText = 'Monke'

cfg.button1 = {
    text = 'Vào discord',
    url = 'discord.gg/VkMNdNGrFf'
}

cfg.button2 = {
    text = 'Tham gia vào',
    url = 'fivem://connect/23dym8'
}
-- Just to clarify something, you can only have 2 buttons


Citizen.CreateThread(function()
	while true do
        --This is the Application ID (Replace this with you own)
		SetDiscordAppId(581415681136918528)

        --Here you will have to put the image name for the "large" icon.
		SetDiscordRichPresenceAsset('monkeyb')
        
        --(11-11-2018) New Natives:

        --Here you can add hover text for the "large" icon.
        SetDiscordRichPresenceAssetText('PerfectW Roleplay')
       
        --Here you will have to put the image name for the "small" icon.
        SetDiscordRichPresenceAssetSmall('apng')

        --Here you can add hover text for the "small" icon.
        SetDiscordRichPresenceAssetSmallText('discord.gg/GmPGayk')

        --It updates every one minute just in case.
		Citizen.Wait(60000)
    end
end)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1500)
        players = {}
        local pid = GetPlayerServerId(PlayerId())
        local pName = GetPlayerName(PlayerId())
		for _, i in ipairs(GetActivePlayers()) do
            if NetworkIsPlayerActive( i ) then
                table.insert( players, i )
            end
        end

        SetRichPresence(#players.. "/128 [ID: "..pid.."] "..pName)
    end
end)



SetDiscordAppId(cfg.DiscordAppID)

Citizen.CreateThread(function()
	while true do
		SetDiscordRichPresenceAsset(cfg.discordImageName) 
		SetDiscordRichPresenceAssetText(cfg.hoverText) 
		SetDiscordRichPresenceAssetSmall(cfg.smallDiscordImageName) -- Name of the smaller image asset.
		SetDiscordRichPresenceAssetSmallText(cfg.smallHoverText)
		SetRichPresence(cfg.richPresenceText) 
		SetDiscordRichPresenceAction(0, cfg.button1.text, cfg.button1.url)
		SetDiscordRichPresenceAction(1, cfg.button2.text, cfg.button2.url)
		Wait(5000)
	end
end)
