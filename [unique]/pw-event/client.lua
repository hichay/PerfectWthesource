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

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("CUSTOM_TEXT")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

ListNPCEVENT = { -- Nightclub Bartender
	{ x = 3938.4284,   y = 4404.3959, z = 3.4499816, heading = 322.88125 },	-- dong
	{ x = -3067.697,   y = 3328.3374, z = 7.9119062, heading = 82.490768 }, -- tay
    { x = 223.00323,   y = -3158.242, z = 64.67897, heading = 359.68511 },	-- nam
    { x = -66.56037,   y = 6228.9462, z = 54.820583, heading = 359.78018 },	-- bac
    { x = 948.21325,   y = 2408.7629, z = 88.396942, heading = 359.78018 } -- trungtam
}

Citizen.CreateThread(function()
    RequestModel(GetHashKey("g_m_importexport_01"))
	
    while not HasModelLoaded(GetHashKey("g_m_importexport_01")) do
        Wait(1)
    end
	
	
		for _, item in pairs(ListNPCEVENT) do
			local npc = CreatePed(4, 'g_m_importexport_01', item.x, item.y, item.z, item.heading, false, true)
			
			FreezeEntityPosition(npc, true)	
			SetEntityHeading(npc, item.heading)
			SetEntityInvincible(npc, true)
			SetBlockingOfNonTemporaryEvents(npc, true)
		end
	
end)

Citizen.CreateThread(function()
    local pedcreated = false
    local createdPeds = {}
    
    while true do


        if true then
            
            local pos = GetEntityCoords(PlayerPedId())
            local location1 = #(pos - vector3(3938.3964, 4404.3876, 4.4572563))-- đông
            local location2 = #(pos - vector3(-3067.683, 3328.4641, 8.9130029)) -- tây
            local location3 = #(pos - vector3(223.00323, -3158.242, 65.67897)) -- nam
            local location4 = #(pos - vector3(-66.56037, 6228.9462, 55.820583)) -- bắc
            local location5 = #(pos - vector3(948.21325, 2408.7629, 89.396942)) -- trungtam
            --local location5 = #(pos - vector3(Config.Locations["craft"].x, Config.Locations["craft"].y, Config.Locations["craft"].z)) -- trung tâm


            if location1 < 2 then
                inRange = true
                DrawMarker(2, 3938.3964, 4404.3876, 4.4572563, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.2, 210, 50, 9, 255, false, false, false, true, false, false, false)
                DrawText3Ds(3938.3964, 4404.3876, 4.4572563, "[E] Để lấy mảnh ghép")
                if IsControlJustReleased(0, 38) then
                    
                   TriggerServerEvent("pw-event:laymanh","logo1")
                end
            
            end



            if location2 < 2 then
                inRange = true
                DrawMarker(2, -3067.683, 3328.4641, 8.9130029, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.2, 210, 50, 9, 255, false, false, false, true, false, false, false)
                DrawText3Ds(-3067.683, 3328.4641, 8.9130029, "[E] Để lấy mảnh ghép")
                if IsControlJustReleased(0, 38) then
                    
                   TriggerServerEvent("pw-event:laymanh","logo2")
                end
            
            end

            if location3 < 2 then
                inRange = true
                DrawMarker(2, 223.00323, -3158.242, 65.67897, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.2, 210, 50, 9, 255, false, false, false, true, false, false, false)
                DrawText3Ds(223.00323, -3158.242, 65.67897, "[E] Để lấy mảnh ghép")
                if IsControlJustReleased(0, 38) then
                    
                   TriggerServerEvent("pw-event:laymanh","logo3")
                end
            
            end

            if location4 < 2 then
                inRange = true
                DrawMarker(2, -66.56037, 6228.9462, 55.820583, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.2, 210, 50, 9, 255, false, false, false, true, false, false, false)
                DrawText3Ds(-66.56037, 6228.9462, 55.820583, "[E] Để lấy mảnh ghép")
                if IsControlJustReleased(0, 38) then
                    
                   TriggerServerEvent("pw-event:laymanh","logo4")
                end
            
            end

            if location5 < 2 then
                inRange = true
                DrawMarker(2, 948.21325, 2408.7629, 89.396942, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.2, 210, 50, 9, 255, false, false, false, true, false, false, false)
                DrawText3Ds(948.21325, 2408.7629, 89.396942, "[E] để ghép mảnh")
                if IsControlJustReleased(0, 38) then
                    if exports["pw-inventory"]:hasEnoughOfItem("logo1",1) and exports["pw-inventory"]:hasEnoughOfItem("logo2",1) and exports["pw-inventory"]:hasEnoughOfItem("logo3",1) and exports["pw-inventory"]:hasEnoughOfItem("logo4",1) then
                        TriggerEvent("inventory:removeItem","logo1",1)
                        TriggerEvent("inventory:removeItem","logo2",1)
                        TriggerEvent("inventory:removeItem","logo3",1)
                        TriggerEvent("inventory:removeItem","logo4",1)
                        TriggerServerEvent("pw-event:ghepmanh","logofull")
                    end
                end
            
            end


            if not inRange then
                Citizen.Wait(1500)
            end
        else
            Citizen.Wait(1500)
        end

        Citizen.Wait(3)
    end
end)

