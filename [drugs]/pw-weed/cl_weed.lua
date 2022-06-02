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
local listening = false
local CopOnline = 0
Citizen.CreateThread(function()
    exports["pw-polyzone"]:AddBoxZone("weed_pickuplocation", vector3(2225.05, 5577.5278, 53.823883), 8.2, 20.2, {
        heading=0,
        minZ=52.84,
        maxZ=53.84,
        data = {
            action = 'harvest'
        }
    })
    exports["pw-polytarget"]:AddCircleZone("weed_drylocation", vector3(3796.0236, 4445.5034, 4.6320528), 1.0, {
        options = {
            ["useZ"] = true,
        }
    })

    exports["pw-polytarget"]:AddCircleZone("weed_sellposition", vector3(-1171.522, -1571.314, 4.6636252), 1.0, {
        options = {
            ["useZ"] = true,
        }
    })

    exports['pw-interact']:AddPeekEntryByPolyTarget('weed_sellposition', {
        {
            id = "weed_sell",
            event = "pw-weed:makeSales",
            icon = "cannabis",
            label = "Bán cần sa"
        },
        {
            id = "weed_shops",
            event = "pw-weeds:weed_dry",
            icon = "cannabis",
            label = "Smoke on the Water"
        }
    
    }, { distance = { radius = 4.5 } })

    exports['pw-interact']:AddPeekEntryByPolyTarget('weed_drylocation', {
        {
            id = "weed_drylc",
            event = "pw-weeds:weed_dry",
            icon = "circle",
            label = "Sấy cần"
        }}, { distance = { radius = 4.5 } })
end)

local weed_listpack = {
    { name = "smallbud", price = 5},
}


AddEventHandler('ListCopOnline', function(CopsInfo)
    CopOnline = CopsInfo
end)

RegisterNetEvent("pw-weed:makeSales")
AddEventHandler("pw-weed:makeSales",function()
    if CopOnline >= Config.PoliceRequire then
        local veh = GetVehiclePedIsIn(PlayerPedId())
        if veh and veh ~= 0 then
        local vehModel = GetEntityModel(veh)
        if IsThisModelABike(vehModel) or IsThisModelAQuadbike(vehModel) or IsThisModelABicycle(vehModel) then
            DeleteEntity(veh)
        end
        return
        end
        local cashroll = 0

        for k, v in pairs(weed_listpack) do
            local qty = exports["pw-inventory"]:getQuantity(v.name, true)

            if qty > 0 then
                cashroll = cashroll + (qty / 5)
                TriggerEvent("inventory:removeItem", v.name, qty)      
            end
        end

        if cashroll == 0 then
            TriggerEvent("ESX:Notify","Không có gì để bán","error")
        end

        if cashroll > 0 then
            TriggerEvent("player:receiveItem","cashroll",1)
        end
    else 
        TriggerEvent('DoLongHudText',"Không có đủ cảnh sát online",2)
    end

end)

RegisterCommand("wow", function(source, args, rawCommand)
    TriggerServerEvent("inventory:RetreiveSettings")
end, false)
AddEventHandler('pw-weeds:weed_dry', function(pParameters, pEntity, pContext)

	if JustPickedWeed or JustPackedWeed then
        TriggerEvent("DoLongHudText","Bạn quá mệt khi đã làm một công việc khác, Quay lại sau 15p!")
    else
        if not JustDriedWeed then
            TriggerEvent("weed:spam-prevent","drying")
            JustDriedWeed = true
        end
        local wetbud = exports["pw-inventory"]:hasEnoughOfItem("wetbud",1,false)
        if wetbud then
            local success = loopSkill(math.random(5,8))	
            if success then 
                ClearPedSecondaryTask(PlayerPedId())
                TriggerEvent("inventory:removeItem", "wetbud", 1)
                TriggerEvent("player:receiveItem","driedbud",1)
            else 
                ClearPedSecondaryTask(PlayerPedId())
                TriggerEvent("alert:weedpickup")
            end
            
        else
            TriggerEvent("DoShortHudText","Bạn cân ít nhất 1 lá tươi.")
        end
        
    end
end)

AddEventHandler("pw-polyzone:enter", function(pZoneName, pZoneData)
    if pZoneName == "weed_pickuplocation" then
		if ESX.GetPlayerData().job.name == 'police' or ESX.GetPlayerData().job.name == 'ambulance' then 

		else
			exports["pw-interaction"]:showInteraction("Nhấn [E] để hái")
			listenForKeypress(pZoneData.action)
		end
    end
end)

AddEventHandler("pw-polyzone:exit", function(pZoneName, pZoneData)
    if pZoneName == "weed_pickuplocation" then
        exports["pw-interaction"]:hideInteraction()
        listening = false
    end
end)

function listenForKeypress()
    listening = true

    Citizen.CreateThread(function(pAction)
        while listening do
            if IsControlJustPressed(0, 38) and IsPedInAnyVehicle(PlayerPedId(), false) ~= 1 then         
				if JustDriedWeed or JustPackedWeed then
					TriggerEvent("DoLongHudText","Bạn quá mệt khi đã làm một công việc khác, Quay lại sau 15p!")
				else
					if not JustPickedWeed then
						JustPickedWeed = true
						TriggerEvent("weed:spam-prevent","picking")
					end
	
					local success = loopSkill(math.random(3,5))
					
					if success then 
						ClearPedSecondaryTask(PlayerPedId())
						TriggerEvent("player:receiveItem","wetbud",1)
					else 
						ClearPedSecondaryTask(PlayerPedId())
						TriggerEvent("alert:weedpickup")
					end

					if math.random(100) < 5 then
						if math.random(2) == 1 then
							TriggerEvent("player:receiveItem","whiteseed",1)
						else
							TriggerEvent("player:receiveItem","kushseed",1)
						end
						
					end
				end             
            end

            Citizen.Wait(1)
        end
    end)
end

Config.Location = {
    Weedharverst = {
        location = {2225.05, 5577.5278, 53.823883},
        label = 'Chỗ hái cần',
    },
    DryWeed = {
        location = {3795.9643, 4444.2465, 4.5806803},
        label = 'Chỗ sấy cần',
    },
    ShopWeed = {
        location = {-1171.17, -1571.09, 3.67},
        label = 'Smoke on the Water',
    },
}

RegisterNetEvent('pw-weeds:ToggleBlips')
AddEventHandler('pw-weeds:ToggleBlips', function()
    WeedLocation = not WeedLocation
    for _, item in pairs(Config.Location) do
        if not WeedLocation then
            if item.blip ~= nil then
                RemoveBlip(item.blip)
            end
        else
            item.blip = AddBlipForCoord(item.location[1], item.location[2], item.location[2])
            SetBlipSprite(item.blip, 469)
            SetBlipColour(item.blip, 2)
            SetBlipScale(item.blip, 1.0)
            SetBlipAsShortRange(item.blip, true)
            BeginTextCommandSetBlipName("CUSTOM_TEXT")
            AddTextComponentString(item.label)
            EndTextCommandSetBlipName(item.blip)
        end
    end
end)

local JustPickedWeed = false
local JustDriedWeed = false
local JustPackedWeed = false



RegisterNetEvent('weed:spam-prevent')
AddEventHandler('weed:spam-prevent', function(prevent)
	if prevent == "picking" then
		Wait(900000)
		JustPickedWeed = false
	elseif prevent == "drying" then
		Wait(900000)
		JustDriedWeed = false
	else
		Wait(900000)
		JustPackedWeed = false
	end
end)

RegisterNetEvent('animation:farm')
AddEventHandler('animation:farm', function()

		inanimation = true
		local lPed = GetPlayerPed(-1)
		RequestAnimDict("amb@world_human_gardener_plant@male@base")
		while not HasAnimDictLoaded("amb@world_human_gardener_plant@male@base") do
			Citizen.Wait(0)
		end
		TaskPlayAnim(PlayerPedId(), "amb@world_human_gardener_plant@male@base", "base", 8.0, -8, 12.0, 49, 0, 0, 0, 0)
	
		inanimation = false

end)

function loopSkill(count)
	local loopCount = 1
	while loopCount < count do
		Wait(100)
		loopCount = loopCount + 1
		ClearPedSecondaryTask(PlayerPedId())
		TriggerEvent("animation:farm")
		local finished = exports["pw-taskbarskill"]:taskBarSkill(12000, math.random(5, 10))
		if finished ~= 100 then
			return false
		end
	end
	return true
end



function hasScale()
    return exports['pw-inventory']:hasEnoughOfItem('qualityscales', 1, false) or
    exports['pw-inventory']:hasEnoughOfItem('smallscales', 1, false)
end
  
function rollJoints(pItem, pAmount, pItemInfo)
    TriggerEvent('inventory:removeItem', 'rollingpaper', pAmount)
    TriggerEvent("inventory:removeItem", pItem, 1)
    TriggerEvent('player:receiveItem', 'joint2', pAmount, false, itemInfo)
end
  
local rollAnimDict = 'anim@amb@business@weed@weed_sorting_seated@'
local rollAnim = 'sorter_left_sort_v2_sorter01'
  
local gramsPerJoint = 2
  
AddEventHandler('pw-inventory:itemUsed', function(item, passedItemInfo, inventoryName, slot)
    if item == 'driedbud' then
      local finished = exports['pw-taskbar']:taskBar(10000, "Chia nhỏ ra"), false, true, false, false, nil, 5.0, PlayerPedId()
      if finished == 100 and exports['pw-inventory']:hasEnoughOfItem(item, 1, false, true) then
        TriggerEvent("inventory:removeItem", item, 1)
        TriggerEvent('player:receiveItem', 'smallbud', 5, false)
      end
    end 
  
    if item == 'weedpackage' then
      TriggerEvent('np-weed:prepareBaggies', {}, PlayerPedId())
    end
  
    if item == 'smallbud' then
      if not hasScale() then
        TriggerEvent('DoLongHudText', "Cần có cân mới có thể đóng gói", 2)
        return
      end
  
      local amount = math.floor(20 / gramsPerJoint )
      local hasPaper = exports['pw-inventory']:hasEnoughOfItem('rollingpaper', amount, false)
      if not hasPaper then
        TriggerEvent('DoLongHudText', "Không có đủ giấy cuốn", 2)
        return
      end
  
      loadAnimDict(rollAnimDict)
      TaskPlayAnim(PlayerPedId(), rollAnimDict, rollAnim, 8.0, 1.0, -1, 17, 0, 0, 0, 0)
      local finished = exports['pw-taskbar']:taskBar(15000, "Cuốn cần", false, true, false, false, nil, 5.0, PlayerPedId())
      ClearPedTasks(PlayerPedId())
      if finished == 100 and exports['pw-inventory']:hasEnoughOfItem(item, 1, false, true) then
        rollJoints(item, amount, json.decode(passedItemInfo))
      end
    end
  
    if item == 'weedbaggie' then
      local amount = math.floor(8 / gramsPerJoint)
      local hasPaper = exports['pw-inventory']:hasEnoughOfItem('rollingpaper', amount, false)
      if not hasPaper then
        TriggerEvent('DoLongHudText', "Không có đủ giấy cuốn", 2)
        return
      end
      loadAnimDict(rollAnimDict)
      TaskPlayAnim(PlayerPedId(), rollAnimDict, rollAnim, 8.0, 1.0, -1, 17, 0, 0, 0, 0)
      local finished = exports['pw-taskbar']:taskBar(5000, "Cuốn cần", false, true, false, false, nil, 5.0, PlayerPedId())
      ClearPedTasks(PlayerPedId())
        if finished == 100 and exports['pw-inventory']:hasEnoughOfItem(item, 1, false, true) then
            rollJoints(item, amount, json.decode(passedItemInfo))
        end
    end
end)
  