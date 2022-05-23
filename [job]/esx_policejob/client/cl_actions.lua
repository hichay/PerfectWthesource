
function IsNearPlayer(player)
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply, 0)
    local ply2 = GetPlayerPed(GetPlayerFromServerId(player))
    local ply2Coords = GetEntityCoords(ply2, 0)
    local distance = Vdist2(plyCoords, ply2Coords)
    if(distance <= 5) then
        return true
    end
end

inmenus = false

RegisterNetEvent("inmenu")
AddEventHandler("inmenu", function(change)
	inmenus = change
end)

RegisterNetEvent("police:remmask")
AddEventHandler("police:remmask", function(t)
	local t, distance = GetClosestPlayer()

    if distance ~= -1 and distance < 5 then
		if not IsPedInVehicle(t, GetVehiclePedIsIn(t, false), false) then
			TriggerServerEvent("police:remmaskGranted", GetPlayerServerId(t))

            local AnimSet = "mp_missheist_ornatebank"
			local AnimationOn = "stand_cash_in_bag_intro"
			local AnimationOff = "stand_cash_in_bag_intro"

            loadAnimDict(AnimSet)
			TaskPlayAnim(PlayerPedId(), AnimSet, AnimationOn, 8.0, -8, -1, 49, 0, 0, 0, 0)

            Citizen.Wait(500)

            ClearPedTasks(PlayerPedId())
		end
	else
		TriggerEvent("DoLongHudText", "Không có ai ở gần.",2)
	end
end)

RegisterNetEvent("police:remmaskAccepted")
AddEventHandler("police:remmaskAccepted", function()
	TriggerEvent("facewear:adjust", {
		{
			id = "hat",
			shouldRemove = true
		},
		{
			id = "googles",
			shouldRemove = true
		},
		{
			id = "mask",
			shouldRemove = true
		},
	}, true, true)
end)

RegisterNetEvent("police:checkInventory")
AddEventHandler("police:checkInventory", function(pArgs, pEntity)
	TriggerEvent("animation:PlayAnimation", "push")
    local finished = exports["np-taskbar"]:taskBar(15000, pArgs and "Đang kiểm tra" , false, true, nil, false, nil, 5)
	TriggerEvent("animation:PlayAnimation", "c")

    if finished == 100 then
        TriggerServerEvent("police:targetCheckInventory", GetPlayerServerId(NetworkGetPlayerIndexFromPed(pEntity)), pArgs)
    end
end)

--[[ RegisterNetEvent("police:rob")
AddEventHandler("police:rob", function(pArgs, pEntity)
    RequestAnimDict("random@shop_robbery")
    while not HasAnimDictLoaded("random@shop_robbery") do
        Citizen.Wait(0)
    end

    ClearPedTasksImmediately(PlayerPedId())

    TaskPlayAnim(PlayerPedId(), "random@shop_robbery", "robbery_action_b", 8.0, -8, -1, 16, 0, 0, 0, 0)
    local finished = exports["np-taskbar"]:taskBar(60000, "Ăn trộm", true, true, nil, false, nil, 5)

    ClearPedTasksImmediately(PlayerPedId())

	if finished == 100 then
        TriggerServerEvent("police:rob", GetPlayerServerId(NetworkGetPlayerIndexFromPed(pEntity)))
        TriggerServerEvent("police:targetCheckInventory", GetPlayerServerId(NetworkGetPlayerIndexFromPed(pEntity)), false)
    end
end) ]]

RegisterNetEvent("shoes:steal")
AddEventHandler("shoes:steal", function(pArgs, pEntity)
  	loadAnimDict("random@domestic")
  	TaskTurnPedToFaceEntity(PlayerPedId(), pEntity, -1)
  	TaskPlayAnim(PlayerPedId(),"random@domestic", "pickup_low",5.0, 1.0, 1.0, 48, 0.0, 0, 0, 0)
  	Citizen.Wait(1600)
  	ClearPedTasks(PlayerPedId())
  	TriggerServerEvent("facewear:adjust", GetPlayerServerId(NetworkGetPlayerIndexFromPed(pEntity)), "stolenshoes", true, true)
end)

--[[ RegisterNetEvent("police:gsr")
AddEventHandler("police:gsr", function(pArgs, pEntity)

	local finished = exports["caue-taskbar"]:taskBar(10000, "Teste de GSR")
	if finished == 100 then
		TriggerServerEvent("police:gsr", GetPlayerServerId(NetworkGetPlayerIndexFromPed(pEntity)))
	end
end) ]]

AddEventHandler("pw-police:impound", function(pParams, pVehicle)
	TriggerEvent("animation:PlayAnimation", "phone")
    local finished = exports["np-taskbar"]:taskBar(math.random(5000, 10000), "Đang dọn xe")
    TriggerEvent("animation:PlayAnimation", "cancel")
	local plate = GetVehicleNumberPlateText(pVehicle)
	
    if plate then
		RPC.execute("pw-vehicles:ImpoundVehicle", vid, plate)
	end

	Sync.DeleteVehicle(pVehicle)
	Sync.DeleteEntity(pVehicle)

end)

