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
local display = false
local wlk_acws = false

ESX = nil

local mincode = 0

local DisplayFont = 'Mitr'
local imgsrc = 'nui://esx_inventoryhud/html/img/items/'


local openabykey = false
local openubykey = false

local openakey = 'PAGEDOWN'
local openukey = 'PAGEUP'

local openabytrigger = false
local openubytrigger = false


local group


if Config.OpenAdminUIbykey then
	openabykey = Config.OpenAdminUIbykey
end


if Config.OpenUserUIbykey then
	openubykey = Config.OpenUserUIbykey
end

if Config.OpenAdminUIkey then
	openakey = Config.OpenAdminUIkey
end


if Config.OpenUserUIkey then
	openukey = Config.OpenUserUIkey
end

if Config.OpenAdminUIbyTrigger then
	openabytrigger = Config.OpenAdminUIbyTrigger
end

if Config.OpenUserUIbyTrigger then 
	openubytrigger = Config.OpenUserUIbyTrigger
end

if Config.FirstCode then
	mincode = mincode + tonumber(string.len(Config.FirstCode))
end

if Config.LastCodeLength then
	mincode = mincode + tonumber(Config.LastCodeLength)
else
	mincode = mincode + 20
end

if Config.Image then
	imgsrc = Config.Image
end

RegisterFontFile(DisplayFont)
fontId = RegisterFontId(DisplayFont)




Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

Citizen.CreateThread(function() 
	Citizen.Wait(500)
	while not wlk_acws do
		ESX.TriggerServerCallback('w1ms_redeem-voucher:getwat', function(status)
			wlk_acws = status
		end)
		Citizen.Wait(1000)
	end
end)

RegisterNetEvent('es_admin:setGroup')
AddEventHandler('es_admin:setGroup', function(g)
	group = g
end)

Citizen.CreateThread(function() 
	if openabykey then
		while true do
			Citizen.Wait(0)
			if group ~= "user" then
				if not display then
					if IsControlJustReleased(0, Keys[openakey]) then
						SetDisplay(true)
						display = true
					end
				else
					if IsControlJustReleased(0, Keys[openakey]) then
						SetDisplay(false)
						display = false
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function() 
	if openubykey then
		while true do
			Citizen.Wait(0)
			if not display then
				if IsControlJustReleased(0, Keys[openukey]) then
					SetDisplay2(true)
					display = true
				end
			else
				if IsControlJustReleased(0, Keys[openukey]) then
					SetDisplay2(false)
					display = false
				end
			end
		end
	end
end)

RegisterNetEvent('w1ms_redeem-voucher:open-admin')
AddEventHandler('w1ms_redeem-voucher:open-admin', function()
	if openabytrigger then
		if group ~= "user" then
			if not display then
				SetDisplay(true)
				display = true
			else
				SetDisplay(false)
				display = false
			end
		end
	end
end)

RegisterNetEvent('w1ms_redeem-voucher:open-user')
AddEventHandler('w1ms_redeem-voucher:open-user', function()
	if openubytrigger then
		if not display then
			SetDisplay2(true)
			display = true
		else
			SetDisplay2(false)
			display = false
		end
	end
end)

function SetDisplay2(bool)
	if wlk_acws then
		display = bool
		if display then
			SetNuiFocus(true, true)
		end
		SendNUIMessage({
			type = "use_code",
			status = bool,
			mincode = mincode,
			txt = Config.Text,
			imgsrc = imgsrc
		})
	end
end

RegisterNUICallback("exit", function(data)
	SetNuiFocus(false, false)
	SendNUIMessage({
		type = "exit"
	})
	display = false
end)

RegisterNUICallback("savecode", function(data)
	TriggerServerEvent('w1ms_redeem-voucher:savecode', data)
end)

RegisterNUICallback("check", function(data)
	TriggerServerEvent('w1ms_redeem-voucher:check', data)
end)

RegisterNUICallback("submit", function(data)
	SetNuiFocus(false, false)
	SendNUIMessage({
		type = "exit"
	})
	display = false
	TriggerServerEvent('w1ms_redeem-voucher:submit', data)
end)

RegisterNUICallback("deletecode", function(data)
	TriggerServerEvent('w1ms_redeem-voucher:deletecode', data)
end)

RegisterNUICallback("alert", function(data)
	exports.pNotify:SendNotification({
		text = data.text,
		type = data.type,
		timeout = 3000,
		layout = "centerLeft",
		queue = "left"
	})
end)

RegisterNetEvent('w1ms_redeem-voucher:updateres')
AddEventHandler('w1ms_redeem-voucher:updateres', function(data)
	SendNUIMessage({
		type = "updateresult",
		result = data
	})
end)

RegisterNetEvent('w1ms_redeem-voucher:updatecode')
AddEventHandler('w1ms_redeem-voucher:updatecode', function(page)
	ESX.TriggerServerCallback('w1ms_redeem-voucher:getAlldata', function(data)
		Citizen.Wait(100)
		SendNUIMessage({
			type = "updatecode",
			code = data,
			--useds = data.useds,
			page = page
		})
	end)
end)

function SetDisplay(bool)
	if wlk_acws then
		ESX.TriggerServerCallback('w1ms_redeem-voucher:getAlldata', function(data)
			Citizen.Wait(100)

			local datax = data
			display = bool
			if display then
				SetNuiFocus(true, true)
			end


			SendNUIMessage({
				type = "ui",
				status = bool,
				code = datax,
				--useds = data.useds,
				txt = Config.Text,
				imgsrc = imgsrc
			})

		end)

	end
end

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		SetNuiFocus(false, false)
		SendNUIMessage({
			type = "exit"
		})
	end
end)