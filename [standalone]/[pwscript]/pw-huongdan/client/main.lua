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


local data = {
    id = "npc_therenter",
    position = {coords = vector3(-1228.309, -176.6915, 38.326072), heading = 185.73393},
    pedType = 4,
    model = "s_f_y_airhostess_01",
    networked = false,
    distance = 25.0,
    settings = {{ mode = 'invincible', active = true }, { mode = 'ignore', active = true }, { mode = 'freeze', active = true }},
    flags = { ["isNPC"] = true, },
    scenario = "WORLD_HUMAN_CLIPBOARD_FACILITY",
}
local npc = exports["pw-npcs"]:RegisterNPC(data, "npc_therentername")


local Interact = {
  data = {
    {
      id = 'npc_therenterid',
      label = 'Thuê xe',
      icon = 'hand-holding',
      event = 'pw-spawn:showRent',
      parameters = {},
    },
  },
  options = {
    distance = { radius = 2.5 },
    npcIds = { 'npc_therenter' },
    --[[ isEnabled = function(pEntity, pContext)
      return isOnDeliveryTask()
    end, ]]
  },
}

exports["pw-interact"]:AddPeekEntryByFlag({'isNPC'}, Interact.data, Interact.options)


AddEventHandler("pw-spawn:showRent", function()
    local datamen = {}
    for k,v in ipairs(VehiclesConfig) do
        for _, vehicle in ipairs(v["Vehicles"]) do
            vehicle.spawn = v["Spawn"]

            datamen[#datamen + 1] = {
                icon = 'car',
				title = vehicle.name,
				description = "",
				image = vehicle.image,
				children = {
					{ icon = "check", description = '' ,title = "Thuê xe", action = "pw-spawn:rentVehicle", key = {vehicle = vehicle, spawn = v['Spawn']} },
				},
			}
        end
    end

    exports["pw-context"]:showContextMenu(datamen)
end)



AddEventHandler("pw-spawn:rentVehicle", function(params)
    --cb({ data = {}, meta = { ok = true, message = '' } })
    local vehicle = params.vehicle
    local hash = GetHashKey(vehicle.model)
    local success = RPC.execute('pw-spawn:rentVehicle',vehicle.price)
    local newPlate = exports['pw-vehicleshop']:GeneratePlate()
    if success then
        if not HasModelLoaded(hash) then
            RequestModel(hash)
            while not HasModelLoaded(hash) do
                Citizen.Wait(10)
            end
        end
        local lastSelectedVehicleEntity = CreateVehicle(hash, 442.23022, -978.9822, -107.6886, 23.429121, false, false)
        local vehicleProps = ESX.Game.GetVehicleProperties(lastSelectedVehicleEntity)
        vehicleProps.plate = newPlate

        ESX.Game.SpawnVehicle(vehicle.model, vehicle.spawn.coords, vehicle.spawn.heading, function(veh)
            TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
            SetVehicleNumberPlateText(veh, vehicleProps.plate)
            exports["pw-fuel"]:SetFuel(veh,100)
            TriggerEvent("vehiclekeys:client:SetOwner", ESX.Game.GetVehicleProperties(veh).plate)
        end)

        if lastSelectedVehicleEntity ~= nil then
            DeleteVehicle(lastSelectedVehicleEntity)
        end
        
        TriggerEvent('DoLongHudText',"Thuê xe thành công",1)
    else
        TriggerEvent('DoLongHudText',"Không có đủ tiền để thực hiện",2)
    end

end)