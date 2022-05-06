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