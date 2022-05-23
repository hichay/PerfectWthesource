local listening = false
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


    --[[ local data = {
        id = "weedshopnpc",
        position = {coords = vector3(-1171.17, -1571.09, 3.67), heading = 120.0},
        pedType = 4,
        model = "a_f_y_hippie_01",
        networked = false,
        distance = 40.0,
        settings = {{ mode = 'invincible', active = true }, { mode = 'ignore', active = true }, { mode = 'freeze', active = true }},
        flags = { ["isWeedShopKeeper"] = true },
        scenario = "WORLD_HUMAN_SMOKING_POT",
    }
    exports["pw-npcs"]:RegisterNPC(data, "smokeonthewater") ]]

    --[[ local InteractNPC = {
        data = {
            {
                id = "weed_shop",
                label = "Smoke on the Water",
                icon = "cannabis",
                event = "caue-weed:shop"
                parameters = {},
            },
            {
                id = "weed_sell",
                label = "Bán cần thành phẩm",
                icon = "cannabis",
                event = "caue-weed:shop",
            },
        },

         options = {
            npcIds = { 'weedshopnpc' },                
            distance = { radius = 3.5 },
        },
    }

    exports["pw-interact"]:AddPeekEntryByFlag({'isWeedShopKeeper'}, InteractNPC.data, InteractNPC.options)
 ]]
    exports['pw-interact']:AddPeekEntryByPolyTarget('weed_drylocation', {
        {
            id = "weed_drylc",
            event = "pw-weeds:weed_dry",
            icon = "chevron-circle-up",
            label = "Sấy cần"
        }}, { distance = { radius = 4.5 } })
end)

AddEventHandler('pw-weeds:weed_dry', function(pParameters, pEntity, pContext)

	if JustPickedWeed or JustPackedWeed then
        TriggerEvent("DoLongHudText","Bạn quá mệt khi đã làm một công việc khác, Quay lại sau 15p!")
    else
        if not JustDriedWeed then
            TriggerEvent("weed:spam-prevent","drying")
            JustDriedWeed = true
        end
        local wetbud = exports["pw-inventory"]:hasEnoughOfItem("wetbud",5,false)
        if wetbud then

            local finished = exports["np-taskbar"]:taskBar(30000,"Phơi cần sa",false,false,playerVeh)
            if (finished == 100) then
                TriggerEvent("inventory:removeItem", "wetbud", 5)
                TriggerEvent("player:receiveItem","driedbud",1)
            end
        else
            TriggerEvent("DoShortHudText","Bạn cân ít nhất 5 lá tươi.")
        end
    end
end)

AddEventHandler("pw-polyzone:enter", function(pZoneName, pZoneData)
    if pZoneName == "weed_pickuplocation" then
        exports["np-ui"]:showInteraction("Nhấn [E] để hái")
        listenForKeypress(pZoneData.action)
    end
end)

AddEventHandler("pw-polyzone:exit", function(pZoneName, pZoneData)
    if pZoneName == "weed_pickuplocation" then
        exports["np-ui"]:hideInteraction()
        listening = false
    end
end)

function listenForKeypress()
    listening = true

    Citizen.CreateThread(function(pAction)
        while listening do
            if IsControlJustPressed(1, 38) and IsPedInAnyVehicle(PlayerPedId(), false) ~= 1 then
                if pAction == "harvest" then
                    if JustDriedWeed or JustPackedWeed then
                        TriggerEvent("DoLongHudText","Bạn quá mệt khi đã làm một công việc khác, Quay lại sau 15p!")
                    else
                        if not JustPickedWeed then
                            JustPickedWeed = true
                            TriggerEvent("weed:spam-prevent","picking")
                        end
                        TriggerEvent("animation:farm")
                        TriggerEvent("player:receiveItem","wetbud",math.random(1))
                        if math.random(100) < 5 then
                            if math.random(2) == 1 then
                                TriggerEvent("player:receiveItem","whiteseed",1)
                            else
                                TriggerEvent("player:receiveItem","kushseed",1)
                            end
                            
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
		
		if IsEntityPlayingAnim(lPed, "amb@world_human_gardener_plant@male@base", "base", 3) then
			ClearPedSecondaryTask(lPed)
		else
			TaskPlayAnim(lPed, "amb@world_human_gardener_plant@male@base", "base", 8.0, -8, -1, 49, 0, 0, 0, 0)
			seccount = 4
			while seccount > 0 do
				Citizen.Wait(1000)
				seccount = seccount - 1
			end
			ClearPedSecondaryTask(lPed)
		end		
		inanimation = false

end)