local script_name = GetCurrentResourceName()
local script_active = false
do
    local script_fail = true 
    local MoonAcceptLoadScript 

    RegisterNetEvent("moon_template:client:license_"..script_name) 
    AddEventHandler("moon_template:client:license_"..script_name, function(state) 
        if script_active ~= true and state then 
            MoonAcceptLoadScript() 
	    script_fail = false 
		
        end
            if not state then
		StopResource(script_name)
                print("^2[License System] ^3"..script_name.." ^0is ^1failed ^0to check a license with server.") 
            end 
        end) 

    RegisterNetEvent("moon_template:client"..script_name) 
    AddEventHandler("moon_template:client"..script_name, function() 
        if script_fail then 
            MoonAcceptLoadScript() 
        end 
    end) 

    Citizen.CreateThread(function() 
        Citizen.Wait(5000) 
        TriggerServerEvent("moon_template:server:license_"..script_name) 
    end) 

    MoonAcceptLoadScript = function() 
        print("^2[License System] ^0Loading ^3"..script_name)
        script_active = true

        -- ///////////////////////////////////////////////////////////////// --
        --  ##########            Add detail Script below         ########## --
        --  ##########            Add detail Script below         ########## --
        --  ##########            Add detail Script below         ########## --
        --  ##########            Add detail Script below         ########## --
        --  ##########            Add detail Script below         ########## --
        --  ##########            Add detail Script below         ########## --
        -- ///////////////////////////////////////////////////////////////// --

local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
ESX = nil
local FirstSpawn = true
local sex = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent(Config.SharedObject, function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

Citizen.CreateThread(function()
	while true do
		SetPedMaxHealth(GetPlayerPed(-1), Config.PedMaxHealth)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('moons_skin:addskin')
AddEventHandler('moons_skin:addskin', function(skin, stype, adminid, pid)
	local playerPed = PlayerPedId()
	local currentHealth = GetEntityHealth(GetPlayerPed(-1))

	if skin == "mp_m_freemode_01" or skin == "mp_f_freemode_01" or skin == "default" or skin == "" or skin == " " then
		RequestModel(skin)
		TriggerEvent('skinchanger:getSkin', function(skin)
			sex = skin["sex"]
		end)
		if sex == 0 then
			skin = "mp_m_freemode_01"
		elseif sex == 1 then
			skin = "mp_f_freemode_01"
		end
		
		Citizen.CreateThread(function()
			HasModelLoaded(skin)
			Citizen.Wait(2000)

			while not HasModelLoaded(skin) do
				RequestModel(skin)
				Citizen.Wait(0)
			end

			if IsModelInCdimage(skin) and IsModelValid(skin) then
				SetPlayerModel(PlayerId(), skin)
				SetPedDefaultComponentVariation(playerPed)
				
			end

			if HasModelLoaded(skin) then
				TriggerServerEvent('moons_skin:saveskin', "default")
				if stype == "change" then
					if Config.Usepnotify then
						exports.pNotify:SendNotification({
							text = _U('default'),
							type = "info",
							timeout = 3000,
							layout = "centerLeft",
							queue = "left"
						})
					else					    
						ESX.ShowNotification(_U('default'))
					end
				end
			else
				if stype == "change" then
					if Config.Usepnotify then
						exports.pNotify:SendNotification({
							text = _U('errordefault'),
							type = "info",
							timeout = 3000,
							layout = "centerLeft",
							queue = "left"
						})
					else					
						ESX.ShowNotification(_U('errordefault'))
					end	
				end
			end

			SetModelAsNoLongerNeeded(skin)

			if cb ~= nil then
				cb()
			end
			TriggerEvent('skinchanger:modelLoaded')
		end)
		Citizen.Wait(Config.Delay2)
		ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin4, jobSkin)
			TriggerEvent('skinchanger:loadSkin', skin4)
		end)
		
	else
		
		RequestModel(skin)
		Citizen.CreateThread(function()

			HasModelLoaded(skin)
			Citizen.Wait(2000)


			while not HasModelLoaded(skin) do
				RequestModel(skin)
				Citizen.Wait(0)
			end

			if IsModelInCdimage(skin) and IsModelValid(skin) then
				SetPlayerModel(PlayerId(), skin)
				SetPedDefaultComponentVariation(playerPed)
			end

			if HasModelLoaded(skin) then
				TriggerServerEvent('moons_skin:saveskin', skin)
				if stype == "add" then
					TriggerServerEvent('moons_skin:addskins', skin)
					if adminid and pid then
						if Config.Usepnotify then
							TriggerServerEvent('moons_skin:alert', adminid, _U('addskintoplayer'),pid,skin, 'success')
						else	
							ESX.ShowNotification(_U('addskintoplayer',pid,skin))
						end
					end
				elseif stype == "change" then
					if Config.Usepnotify then
						exports.pNotify:SendNotification({
							text = _U('changeinto',skin),
							type = "info",
							timeout = 3000,
							layout = "centerLeft",
							queue = "left"
						})
					else
						ESX.ShowNotification(_U('changeinto',skin))
					end		
				end
			else
				if stype == "add" then
					TriggerServerEvent('moons_skin:alert', skin)
					if adminid and pid then
						if Config.Usepnotify then
							TriggerServerEvent('moons_skin:alert', adminid, _U('cantaddskintoplayer',pid,skin), 'error')
						else
							ESX.ShowNotification(_U('cantaddskintoplayer',pid,skin))
						end
					end
				elseif stype == "change" then
					if Config.Usepnotify then
						exports.pNotify:SendNotification({
							text = _U('cannotchangeinto',skin),
							type = "info",
							timeout = 3000,
							layout = "centerLeft",
							queue = "left"
						})
					else						
						
						ESX.ShowNotification(_U('cannotchangeinto',skin))
					end
				end
			end

			SetModelAsNoLongerNeeded(skin)

			if cb ~= nil then
				cb()
			end

			TriggerEvent('skinchanger:modelLoaded')
		end)
		Citizen.Wait(Config.Delay2)
		--ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin6, jobSkin)
			--print('loadskin')
			--TriggerEvent('skinchanger:loadSkin', skin6)
		--end)
		
	end
	Citizen.Wait(1000)

	if Config.UseCurrentHealth then
		SetEntityHealth(GetPlayerPed(-1), currentHealth)
	else
		SetEntityHealth(GetPlayerPed(-1), Config.PedHealth)
	end
	
end)

Citizen.CreateThread(function()
	while true do
		SetPedMaxHealth(GetPlayerPed(-1), Config.PedMaxHealth)
		if IsControlJustReleased(0, Keys[Config.OpenSkinMenu]) and Config.UseMoreSkin then
			ESX.TriggerServerCallback('moons_skin:checkPlayerHaveSkin', function(skins)
				if skins > 0 then
					OpenSkinMenu()
					Citizen.Wait(1000)
				end
			end)
		end
		Citizen.Wait(0)
	end
end)

function OpenSkinMenu()
	ESX.TriggerServerCallback('moons_skin:getPlayerSkinList', function(skins)
		local elements = {}
		elements = {
			{label = _U('labeldefault'), value = 'default'}
		}
		for i=1, #skins, 1 do
			table.insert(elements, {
				label = skins[i].skin,
				value = skins[i].skin,
				type = "change",
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'PlayerSkinMenu', {
			title    = "Player Skin Menu",
			align    = Config.Align,
			elements = elements
		}, function(data, menu)
		TriggerEvent('moons_skin:addskin', data.current.value, "change")
		menu.close()
		end, function(data, menu)
		menu.close()
		end)

	end)
end


AddEventHandler('playerSpawned', function()
	if FirstSpawn then
		Citizen.Wait(Config.Delay1)
		ESX.TriggerServerCallback('moons_skin:getskin', function(skin2)
			if skin2 == nil or skin2 == "" or skin2 == "default" then
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin3, jobSkin)
					if skin3 == nil then
						TriggerEvent('skinchanger:loadSkin', {sex = 0})
					else
						TriggerEvent('skinchanger:loadSkin', skin3)
					end
				end)
				SetEntityHealth(GetPlayerPed(-1), Config.PedHealth)
			else
				TriggerEvent('moons_skin:addskin', skin2, "change")
			end
		end)
		FirstSpawn = false
	end
		
	
end)

RegisterCommand(Config.OpenSkinMenuCommand, function(source, args)
    OpenSkinMenu()
end)


end
end
