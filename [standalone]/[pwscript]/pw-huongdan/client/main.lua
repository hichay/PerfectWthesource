Keys = {
    ['ESC'] = 322, ['F1'] = 288, ['F2'] = 289, ['F3'] = 170, ['F5'] = 166, ['F6'] = 167, ['F7'] = 168, ['F8'] = 169, ['F9'] = 56, ['F10'] = 57,
    ['~'] = 243, ['1'] = 157, ['2'] = 158, ['3'] = 160, ['4'] = 164, ['5'] = 165, ['6'] = 159, ['7'] = 161, ['8'] = 162, ['9'] = 163, ['-'] = 84, ['='] = 83, ['BACKSPACE'] = 177,
    ['TAB'] = 37, ['Q'] = 44, ['W'] = 32, ['E'] = 38, ['R'] = 45, ['T'] = 245, ['Y'] = 246, ['U'] = 303, ['P'] = 199, ['['] = 39, [']'] = 40, ['ENTER'] = 18,
    ['CAPS'] = 137, ['A'] = 34, ['S'] = 8, ['D'] = 9, ['F'] = 23, ['G'] = 47, ['H'] = 74, ['K'] = 311, ['L'] = 182,
    ['LEFTSHIFT'] = 21, ['Z'] = 20, ['X'] = 73, ['C'] = 26, ['V'] = 0, ['B'] = 29, ['N'] = 249, ['M'] = 244, [','] = 82, ['.'] = 81,
    ['LEFTCTRL'] = 36, ['LEFTALT'] = 19, ['SPACE'] = 22, ['RIGHTCTRL'] = 70,
    ['HOME'] = 213, ['PAGEUP'] = 10, ['PAGEDOWN'] = 11, ['DELETE'] = 178,
    ['LEFT'] = 174, ['RIGHT'] = 175, ['TOP'] = 27, ['DOWN'] = 173,
}

ESX = nil


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

local inCityhallPage = false
local PW = {}

PW.Open = function()
    SendNUIMessage({
        type = "toggle",
		state = true
    })
    SetNuiFocus(true, true)
    --inCityhallPage = true
end

PW.Close = function()
    SendNUIMessage({
        type = "toggle",
		state = false
    })
    SetNuiFocus(false, false)
    --inCityhallPage = false
end

RegisterNUICallback('toggle', function()
    SendNUIMessage({
        type = "toggle",
		state = false
    })
	SetNuiFocus(false, false)
end)

RegisterNUICallback('acceptjob', function(data)
	--TriggerEvent("table",data)
	for k,v in pairs(Config.Citywhat) do
		if data == k then 
		end
	end
end)

PW.DrawText3Ds = function(x,y,z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("CUSTOM_TEXT")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 300
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

RegisterNUICallback('close', function()
    SetNuiFocus(false, false)
    inCityhallPage = false
end)

local inRange = false

local currentName = nil

Citizen.CreateThread(function()
    while true do

        local ped = GetPlayerPed(-1)
        local pos = GetEntityCoords(ped)
        inRange = false

        --local dist = GetDistanceBetweenCoords(pos, Config.Cityhall.coords.x, Config.Cityhall.coords.y, Config.Cityhall.coords.z, true)
		local dist = #(vector3(pos) - vector3(Config.Cityhall.coords.x, Config.Cityhall.coords.y, Config.Cityhall.coords.z))
        --local dist2 = GetDistanceBetweenCoords(pos, Config.NoTouch.coords.x, Config.NoTouch.coords.y, Config.NoTouch.coords.z, true)

        if dist < 20 then
            inRange = true
            DrawMarker(2, Config.Cityhall.coords.x, Config.Cityhall.coords.y, Config.Cityhall.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.2, 155, 152, 234, 155, false, false, false, true, false, false, false)
            if dist < 20 then
				PW.DrawText3Ds(Config.Cityhall.coords.x, Config.Cityhall.coords.y, Config.Cityhall.coords.z+1.6, '~o~Bấm E để được cho phép teleport tới cửa hàng xe để nhận xe hỗ trợ')
				PW.DrawText3Ds(Config.Cityhall.coords.x, Config.Cityhall.coords.y, Config.Cityhall.coords.z+1.3, 'Bạn cần hỗ trợ thêm đừng ngần ngại vào discord ~r~discord.gg/VkMNdNGrFf~w~')
                PW.DrawText3Ds(Config.Cityhall.coords.x, Config.Cityhall.coords.y, Config.Cityhall.coords.z+1.0, 'Để bật hướng dẫn Nhấn nút ~g~[T]~w~ sau đó gõ vào lệnh ~r~/help~w~')
				PW.DrawText3Ds(Config.Cityhall.coords.x, Config.Cityhall.coords.y, Config.Cityhall.coords.z+0.5, 'Đứng tại đây và bấm ~g~[E]~w~ để xem video hướng dẫn nghề')
                
                if IsControlJustPressed(0, Keys["E"]) then
                    PW.Open()
                end
            end
        end

        if not inRange then
            Citizen.Wait(1000)
        end

        Citizen.Wait(2)
    end
end)


