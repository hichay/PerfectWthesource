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
PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(job)
	PlayerData.job = job
end)

function MyInvoices()
	ESX.TriggerServerCallback("pw-billing:GetInvoices", function(invoices)
		SetNuiFocus(true, true)
		SendNUIMessage({
			action = 'myinvoices',
			invoices = invoices,
			VAT = Config.VATPercentage
		})			
	end)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlJustReleased(0, Keys['F7']) and not isDead and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'billing') then
			local isAllowed = false
			local jobName = ""
			for k, v in pairs(Config.AllowedSocieties) do
				if v == PlayerData.job.name then
					jobName = v
					isAllowed = true
				end
			end

			if Config.OnlyBossCanAccessSocietyInvoices and PlayerData.job.grade_name == "boss" and isAllowed then
				SetNuiFocus(true, true)
				SendNUIMessage({
					action = 'mainmenu',
					society = true,
					create = true
				})
			elseif Config.OnlyBossCanAccessSocietyInvoices and PlayerData.job.grade_name ~= "boss" and isAllowed then
				SetNuiFocus(true, true)
				SendNUIMessage({
					action = 'mainmenu',
					society = false,
					create = true
				})
			elseif not Config.OnlyBossCanAccessSocietyInvoices and isAllowed then
				SetNuiFocus(true, true)
				SendNUIMessage({
					action = 'mainmenu',
					society = true,
					create = true
				})
			elseif not isAllowed then
				SetNuiFocus(true, true)
				SendNUIMessage({
					action = 'mainmenu',
					society = false,
					create = false
				})
			end
		end
	end
end)

function SocietyInvoices(society)
	ESX.TriggerServerCallback("pw-billing:GetSocietyInvoices", function(cb, totalInvoices, totalIncome, totalUnpaid, awaitedIncome)
		if json.encode(cb) ~= '[]' then
			SetNuiFocus(true, true)
			SendNUIMessage({
				action = 'societyinvoices',
				invoices = cb,
				totalInvoices = totalInvoices,
				totalIncome = totalIncome,
				totalUnpaid = totalUnpaid,
				awaitedIncome = awaitedIncome,
				VAT = Config.VATPercentage
			})		
		else		
			TriggerEvent("ESX:Notify","Hiện chưa có hoá đơn nào.","info")
			SetNuiFocus(false, false)
		end
	end, society)
end

function CreateInvoice(society)
	SetNuiFocus(true, true)
	SendNUIMessage({
		action = 'createinvoice',
		society = society
	})
end

RegisterCommand(Config.InvoicesCommand, function()
	local isAllowed = false
	local jobName = ""
	for k, v in pairs(Config.AllowedSocieties) do
		if v == PlayerData.job.name then
			jobName = v
			isAllowed = true
		end
	end

	if Config.OnlyBossCanAccessSocietyInvoices and PlayerData.job.grade_name == "boss" and isAllowed then
		SetNuiFocus(true, true)
		SendNUIMessage({
			action = 'mainmenu',
			society = true,
			create = true
		})
	elseif Config.OnlyBossCanAccessSocietyInvoices and PlayerData.job.grade_name ~= "boss" and isAllowed then
		SetNuiFocus(true, true)
		SendNUIMessage({
			action = 'mainmenu',
			society = false,
			create = true
		})
	elseif not Config.OnlyBossCanAccessSocietyInvoices and isAllowed then
		SetNuiFocus(true, true)
		SendNUIMessage({
			action = 'mainmenu',
			society = true,
			create = true
		})
	elseif not isAllowed then
		SetNuiFocus(true, true)
		SendNUIMessage({
			action = 'mainmenu',
			society = false,
			create = false
		})
	end
end, false)

RegisterNUICallback("action", function(data, cb)
	if data.action == "close" then
		SetNuiFocus(false, false)
	elseif data.action == "payInvoice" then
		TriggerServerEvent("pw-billing:PayInvoice", data.invoice_id)
		SetNuiFocus(false, false)
	elseif data.action == "cancelInvoice" then
		TriggerServerEvent("pw-billing:CancelInvoice", data.invoice_id)
		SetNuiFocus(false, false)
	elseif data.action == "createInvoice" then
		local closestPlayer, playerDistance = ESX.Game.GetClosestPlayer()
		target = GetPlayerServerId(closestPlayer)
		data.target = target
		--[[ data.society = "society_"..PlayerData.job.name ]]
		data.society = ""..PlayerData.job.name
		data.society_name = PlayerData.job.label

		if closestPlayer == -1 or playerDistance > 3.0 then
			TriggerEvent("ESX:Notify","Không thể ghi hoá đơn vì không có ai ở gần","error")
		else
			TriggerServerEvent("pw-billing:CreateInvoice", data)
			TriggerEvent("ESX:Notify","Đã ghi hoá đơn thành công!","success")
		end
		
		SetNuiFocus(false, false)
	elseif data.action == "missingInfo" then
		TriggerEvent("ESX:Notify","Hãy điền đủ thông tin trước khi xác nhận!","error")
	elseif data.action == "negativeAmount" then
		TriggerEvent("ESX:Notify","Số không hợp lệ!","error")
	elseif data.action == "mainMenuOpenMyInvoices" then
		MyInvoices()
	elseif data.action == "mainMenuOpenSocietyInvoices" then
		for k, v in pairs(Config.AllowedSocieties) do
			if v == PlayerData.job.name then
				if Config.OnlyBossCanAccessSocietyInvoices and PlayerData.job.grade_name == "boss" then
					SocietyInvoices(PlayerData.job.name)
				elseif not Config.OnlyBossCanAccessSocietyInvoices then
					SocietyInvoices(PlayerData.job.name)
				elseif Config.OnlyBossCanAccessSocietyInvoices then
					TriggerEvent("ESX:Notify","Chỉ có giám đốc mới có thể xem.","error")
				end
			end
		end
	elseif data.action == "mainMenuOpenCreateInvoice" then
		for k, v in pairs(Config.AllowedSocieties) do
			if v == PlayerData.job.name then
				CreateInvoice(PlayerData.job.label)
			end
		end
	end
end)

RegisterCommand('ghibill', function(source, args, rawCommand)
	local text
	local societyname 
	local societyn 
	
    if PlayerData.job and PlayerData.job.name == 'ambulance' then
		text = "Tiền viện phí"
		societyn = "ambulance"
		societyname = "Bệnh viện"
		
		TriggerServerEvent('pw-billing:CreateInvoice', {
		target = args[1],
		invoice_value = args[2],
		invoice_item = "Hoá đơn từ tổ chức",
		society = societyn,
		society_name = societyname,
		invoice_notes = text	
	
		})
	elseif PlayerData.job and PlayerData.job.name == 'police' then 
		text = "Phạt vi phạm"
		societyn = "police"
		societyname = "Cảnh sát"
	

	--TriggerServerEvent('pw_script:sendBillplayer', args[1], ESX.PlayerData.job.name, text, args[2])
		TriggerServerEvent('pw-billing:CreateInvoice', {
			target = args[1],
			invoice_value = args[2],
			invoice_item = "Hoá đơn từ tổ chức",
			society = societyn,
			society_name = societyname,
			invoice_notes = text	
		
		})
	end

end)