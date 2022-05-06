
isStatusChecking = false
statusChecks = {}
statusCheckPed = nil
statusCheckTime = 0

local pillboxTeleports = {
    { x = 325.48892211914, y = -598.75372314453, z = 43.291839599609, h = 64.513374328613, text = 'Press ~INPUT_CONTEXT~ ~s~to go to lower Pillbox Entrance' },
    { x = 355.47183227539, y = -596.26495361328, z = 28.773477554321, h = 245.85662841797, text = 'Press ~INPUT_CONTEXT~ ~s~to enter Pillbox Hospital' },
    { x = 359.57849121094, y = -584.90911865234, z = 28.817169189453, h = 245.85662841797, text = 'Press ~INPUT_CONTEXT~ ~s~to enter Pillbox Hospital' },
}

local hspLocs = {
	[1] = { ['x'] = 309.23,['y'] = -593.03,['z'] = 43.36,['h'] = 209.52, ["name"] = "[E] Nhập viện", ["fnc"] = "DrawText3DTest" },
	[2] = { ["x"] = 1828.2244, ["y"] = 3685.35, ["z"] = 34.271049, ["h"] = 192.33, ["name"] = "[E] Nhập viện", ["fnc"] = "DrawText3DTest" },

	[3] = { ["x"] = 326.2477722168, ["y"] = -583.00897216797, ["z"] = 43.317371368408, ["h"] = 330.01126098633, ["name"] = "None", ["fnc"] = "RandomNPC" },
	[4] = { ["x"] = 308.50784301758, ["y"] = -596.73718261719, ["z"] = 43.291816711426, ["h"] = 9.658652305603, ["name"] = "None", ["fnc"] = "RandomNPC" },
	[5] = { ["x"] = 305.08477783203, ["y"] = -598.11743164063, ["z"] = 43.291816711426, ["h"] = 74.243743896484, ["name"] = "None", ["fnc"] = "RandomNPC" },

	[6] = { ["x"] = 331.91491699219, ["y"] = -576.86529541016, ["z"] = 43.317203521729, ["h"] = 66.368347167969, ["name"] = "None", ["fnc"] = "RandomNPC" },
	[7] = { ["x"] = 344.10360717773, ["y"] = -586.115234375, ["z"] = 43.315013885498, ["h"] = 143.51832580566, ["name"] = "None", ["fnc"] = "RandomNPC" },
	[8] = { ["x"] = 347.22564697266, ["y"] = -587.91693115234, ["z"] = 43.31504440307, ["h"] = 67.972259521484, ["name"] = "None", ["fnc"] = "RandomNPC" },

	[9] = { ["x"] = 329.59005737305, ["y"] = -581.37854003906, ["z"] = 43.317241668701, ["h"] = 86.95824432373, ["name"] = "None", ["fnc"] = "aiSCAN" },
	[10] = { ["x"] = 315.22637939453, ["y"] = -593.30419921875, ["z"] = 43.291805267334, ["h"] = 115.40777587891, ["name"] = "None", ["fnc"] = "aiSCAN" },
	[11] = { ["x"] = 353.38198852539, ["y"] = -588.38922119141, ["z"] = 43.315010070801, ["h"] = 61.995723724365, ["name"] = "None", ["fnc"] = "aiSCAN" },

	[12] = { ['x'] = 312.3,['y'] = -592.4,['z'] = 43.29,['h'] = 156.45, ["name"] = "[E] Results", ["fnc"] = "DrawText3DTest" },
	[13] = { ['x'] = 343.77,['y'] = -591.44,['z'] = 43.29, ["h"] = 164.47006225586, ["name"] = "[E] Check Up", ["fnc"] = "DrawText3DTest" },

}


function DrawText3DTest(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)

    SetTextEntry("CUSTOM_TEXT")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

local bedOccupying = nil
local bedObject = nil
local bedOccupyingData = nil

local cam = nil

local inBedDict = "missfinale_c1@"
local inBedAnim = "lying_dead_player0"
local getOutDict = 'switch@franklin@bed'
local getOutAnim = 'sleep_getup_rubeyes'

function PrintHelpText(message)
    SetTextComponentFormat("CUSTOM_TEXT")
    AddTextComponentString(message)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function LeaveBed()
    RequestAnimDict(getOutDict)
    while not HasAnimDictLoaded(getOutDict) do
        Citizen.Wait(0)
    end

    RenderScriptCams(0, true, 200, true, true)
    DestroyCam(cam, false)

    SetEntityInvincible(PlayerPedId(), false)

    SetEntityHeading(PlayerPedId(), bedOccupyingData.h - 90)
    TaskPlayAnim(PlayerPedId(), getOutDict , getOutAnim ,8.0, -8.0, -1, 0, 0, false, false, false )
    Citizen.Wait(5000)
    ClearPedTasks(PlayerPedId())
    
    TriggerServerEvent('pw-hospital:server:LeaveBed', bedOccupying)
	FreezeEntityPosition(PlayerPedId(), false)
    FreezeEntityPosition(bedObject, false)
    
    bedOccupying = nil
    bedObject = nil
    bedOccupyingData = nil
end
RegisterCommand("caigiday", function(source, args, rawCommand)
	TriggerEvent('pw-hospital:client:RPCheckPos')
end, false) 
RegisterNetEvent('pw-hospital:client:RPCheckPos')
AddEventHandler('pw-hospital:client:RPCheckPos', function()
    TriggerServerEvent('pw-hospital:server:RPRequestBed', GetEntityCoords(PlayerPedId()))
end)

RegisterNetEvent('pw-hospital:client:RPSendToBed')
AddEventHandler('pw-hospital:client:RPSendToBed', function(id, data)
    bedOccupying = id
    bedOccupyingData = data

    bedObject = GetClosestObjectOfType(data.x, data.y, data.z, 1.0, data.model, false, false, false)
    FreezeEntityPosition(bedObject, true)

    SetEntityCoords(PlayerPedId(), data.x, data.y, data.z)
    
    RequestAnimDict(inBedDict)
    while not HasAnimDictLoaded(inBedDict) do
        Citizen.Wait(0)
    end

    TaskPlayAnim(PlayerPedId(), inBedDict , inBedAnim ,8.0, -8.0, -1, 1, 0, false, false, false )
    SetEntityHeading(PlayerPedId(), data.h + 180)

    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 1, true, true)
    AttachCamToPedBone(cam, PlayerPedId(), 31085, 0, 0, 1.0 , true)
    SetCamFov(cam, 90.0)
    SetCamRot(cam, -90.0, 0.0, GetEntityHeading(PlayerPedId()) + 180, true)

    SetEntityInvincible(PlayerPedId(), true)
            

    Citizen.CreateThread(function()
        while bedOccupyingData ~= nil do
            Citizen.Wait(1)
            PrintHelpText('Press ~INPUT_VEH_DUCK~ to get up')
            if IsControlJustReleased(0, 56) then
                LeaveBed()
            end
        end
    end)
end)

RegisterNetEvent('pw-hospital:client:SendToBed')
AddEventHandler('pw-hospital:client:SendToBed', function(id, data)
    bedOccupying = id
    bedOccupyingData = data

    bedObject = GetClosestObjectOfType(data.x, data.y, data.z, 1.0, data.model, false, false, false)
    FreezeEntityPosition(bedObject, true)

    SetEntityCoords(PlayerPedId(), data.x, data.y, data.z)
    RequestAnimDict("savecouch@")
    while not HasAnimDictLoaded("savecouch@") do
        Citizen.Wait(0)
    end
    TaskPlayAnim(PlayerPedId(), "savecouch@" , "t_sleep_loop_couch" ,8.0, -8.0, -1, 1, 0, false, false, false )
    SetEntityHeading(PlayerPedId(), data.h + 180)
    SetEntityInvincible(PlayerPedId(), true)
    --SetEntityHeading(PlayerPedId(), GetEntityHeading(bed))
	
    Citizen.CreateThread(function ()
        Citizen.Wait(500)
        local player = PlayerPedId()
		FreezeEntityPosition(PlayerPedId(), true)
        TriggerEvent('DoLongHudText', 'Bạn đang được chăm sóc')
		TriggerEvent("ESX:Notify","Bạn đang nằm viện",'info')
        Citizen.Wait(Config.AIHealTimer * 1000)
        TriggerServerEvent('pw-hospital:server:EnteredBed')
        TriggerEvent('pw-hospital:client:RemoveBleed')
    end)
end)

RegisterNetEvent('pw-hospital:client:FinishNancy')
AddEventHandler('pw-hospital:client:FinishNancy', function()
	SetEntityHealth(PlayerPedId(), GetEntityMaxHealth(PlayerPedId()))
    TriggerEvent('pw-hospital:client:RemoveBleed')
    TriggerEvent('pw-hospital:client:ResetLimbs')
    TriggerEvent('DoLongHudText', 'Bạn đã cảm thấy khoẻ hơn')
end)

RegisterNetEvent('pw-hospital:client:FinishServices')
AddEventHandler('pw-hospital:client:FinishServices', function()
	SetEntityHealth(PlayerPedId(), GetEntityMaxHealth(PlayerPedId()))
    TriggerEvent('pw-hospital:client:RemoveBleed')
    TriggerEvent('pw-hospital:client:ResetLimbs')
    TriggerEvent('DoLongHudText', 'Bạn đã cảm thấy khoẻ hơn')
    LeaveBed()
end)

Citizen.CreateThread(function()
	
    while true do
        Citizen.Wait(2)
		local playerPed = PlayerPedId()
		local hspDist = #(GetEntityCoords(playerPed) - vector3(hspLocs[1]["x"],hspLocs[1]["y"],hspLocs[1]["z"]))
		local hspDist1 = #(GetEntityCoords(playerPed) - vector3(hspLocs[2]["x"],hspLocs[2]["y"],hspLocs[2]["z"]))
        if hspDist < 5 then
            if hspDist < 4 then
                DrawText3DTest(hspLocs[1]["x"],hspLocs[1]["y"],hspLocs[1]["z"], hspLocs[1]["name"])
                if IsControlJustReleased(0, 54) then
                    if (GetEntityHealth(PlayerPedId()) < 201) or (IsInjuredOrBleeding()) then
                        RequestAnimDict("anim@narcotics@trash")
                        while not HasAnimDictLoaded("anim@narcotics@trash") do
                            Citizen.Wait(0)
                        end
                        TaskPlayAnim(PlayerPedId(), "anim@narcotics@trash" , "drop_front" ,8.0, -8.0, -1, 1, 0, false, false, false )
                        local finished = exports["np-taskbar"]:taskBar(1700,"Đang làm thủ tục")
                        if finished == 100 then
                            ClearPedTasks(PlayerPedId())
                            Citizen.Wait(1000)
                            TriggerServerEvent('pw-hospital:server:RequestBed')
                        end
                    else
                        TriggerEvent('DoLongHudText', 'Bạn không cần', 2)
                    end
                end
            end
        
        end

        if hspDist1 < 5 then
            
            if hspDist1 < 4 then
                DrawText3DTest(hspLocs[2]["x"],hspLocs[2]["y"],hspLocs[2]["z"], hspLocs[2]["name"])
                if IsControlJustReleased(0, 54) then
                    if (GetEntityHealth(PlayerPedId()) < 201) or (IsInjuredOrBleeding()) then
                        RequestAnimDict("anim@narcotics@trash")
                        while not HasAnimDictLoaded("anim@narcotics@trash") do
                            Citizen.Wait(0)
                        end
                        TaskPlayAnim(PlayerPedId(), "anim@narcotics@trash" , "drop_front" ,8.0, -8.0, -1, 1, 0, false, false, false )
                        local finished = exports["np-taskbar"]:taskBar(1700,"Đang làm thủ tục")
                        if finished == 100 then
                            ClearPedTasks(PlayerPedId())
                            Citizen.Wait(1000)
                            TriggerServerEvent('pw-hospital:server:RequestBedsamac')
                        end
                    else
                        TriggerEvent('DoLongHudText', 'Bạn không cần', 2)
                    end
                end
            end
            
        end
		
		-- if hspDist1 < 5 then
            
                -- if hspDist < 4 then
					-- DrawText3DTest(hspLocs[2]["x"],hspLocs[2]["y"],hspLocs[2]["z"], hspLocs[2]["name"])
                    -- if IsControlJustReleased(0, 54) then
                        -- if (GetEntityHealth(PlayerPedId()) < 201) or (IsInjuredOrBleeding()) then
                            -- RequestAnimDict("anim@narcotics@trash")
                            -- while not HasAnimDictLoaded("anim@narcotics@trash") do
                                -- Citizen.Wait(0)
                            -- end
                            -- TaskPlayAnim(PlayerPedId(), "anim@narcotics@trash" , "drop_front" ,8.0, -8.0, -1, 1, 0, false, false, false )
                            -- local finished = exports["np-taskbar"]:taskBar(1700,"Đang làm thủ tục")
                            -- if finished == 100 then
                                -- ClearPedTasks(PlayerPedId())
                                -- Citizen.Wait(1000)
                                -- TriggerServerEvent('pw-hospital:server:RequestBed')
                            -- end
                        -- else
                            -- TriggerEvent('DoLongHudText', 'Bạn không cần', 2)
                        -- end
                    -- end
                -- end
            
        -- else
            -- Citizen.Wait(500)
        -- end
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local Getmecuh = PlayerPedId()
		local plyCoords = GetEntityCoords(Getmecuh)
		local hspDist = #(GetEntityCoords(playerPed) - vector3(345.99, -582.71, 28.79))
		local hspDist1 = #(GetEntityCoords(playerPed) - vector3(332.20, -595.64, 43.28))
		if hspDist <= 1.2 then
			DrawText3Ds(345.99, -582.71, 28.79, "~b~ E ~w~- Lên Tầng") 
			if IsControlJustReleased(0, 38) then
				Citizen.Wait(500)
				DoScreenFadeOut(400)
				Citizen.Wait(500)
				SetEntityCoords(Getmecuh, 332.20, -595.64, 43.28)
				Citizen.Wait(250)
				DoScreenFadeIn(250)
			end
		else
			if hspDist >= 1.2 then
				Citizen.Wait(1000)	
			end
		end
		
		if hspDist1 <= 1.2 then
			DrawText3Ds(332.20, -595.64, 43.28, "~b~ E ~w~- Xuống tầng") 
			if IsControlJustReleased(0, 38) then
				Citizen.Wait(500)
				DoScreenFadeOut(400)
				Citizen.Wait(500)
				SetEntityCoords(Getmecuh, 345.99, -582.71, 28.79)
				Citizen.Wait(250)
				DoScreenFadeIn(250)
			end
		else
			if hspDist1 >= 1.2 then
				Citizen.Wait(1000)
				
			end
		end
	end
end)

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("CUSTOM_TEXT1")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

RegisterNetEvent('hospital:client:CheckStatus')
AddEventHandler('hospital:client:CheckStatus', function()
    local player, distance = ESX.Game.GetClosestPlayer()
    if player ~= -1 and distance < 5.0 then
	
        local playerId = GetPlayerServerId(player)
        statusCheckPed = GetPlayerPed(player)
        ESX.TriggerServerCallback('hospital:GetPlayerStatus', function(result)
            if result ~= nil then
                for k, v in pairs(result) do
					
                    if k ~= "BLEED" and k ~= "WEAPONWOUNDS" then
                        table.insert(statusChecks, {bone = Config.BoneIndexes[k], label = v.label .." (".. Config.WoundStates[v.severity] ..")"})
                    elseif result["WEAPONWOUNDS"] ~= nil then
                        for k, v in pairs(result["WEAPONWOUNDS"]) do
							TriggerEvent("ESX:Notify",Config.WeaponDamageList[v],"error")
                        end
                    elseif result["BLEED"] > 0 then
						TriggerEvent("ESX:Notify","Bị "..Config.BleedingStates[v],"error")
                    else
						TriggerEvent("ESX:Notify","Người chơi bình thường","info")
                    end
                end
                isStatusChecking = true
                statusCheckTime = Config.CheckTime
            end
        end, playerId)
    else
        TriggerEvent("ESX:Notify","Không có ai ở gần","error")
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if isStatusChecking then
            statusCheckTime = statusCheckTime - 1
            if statusCheckTime <= 0 then
                statusChecks = {}
                isStatusChecking = false
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if isStatusChecking then
            for k, v in pairs(statusChecks) do
                local x,y,z = table.unpack(GetPedBoneCoords(statusCheckPed, v.bone))
                DrawText3D(x, y, z, v.label)
            end
        end
	
        if isHealingPerson then
            local ped = PlayerPedId()
            if not IsEntityPlayingAnim(ped, healAnimDict, healAnim, 3) then
                loadAnimDict(healAnimDict)	
                TaskPlayAnim(ped, healAnimDict, healAnim, 3.0, 3.0, -1, 49, 0, 0, 0, 0)
            end
        end
    end
end)

function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("CUSTOM_TEXT1")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end