local isInFactory = false
local isRunningCrate = false
local RecyclePoints = {
	{1015.4642333984,-3110.4521484375,-38.99991607666,["time"] = 0,["used"] = false},  
	{1011.2679443359,-3110.8725585938,-38.99991607666,["time"] = 0,["used"] = false},  
	{1005.8571777344,-3110.6271972656,-38.99991607666,["time"] = 0,["used"] = false},  
	{995.37841796875,-3108.6293945313,-38.99991607666,["time"] = 0,["used"] = false}, 
	{1003.0407104492,-3104.7854003906,-38.999881744385,["time"] = 0,["used"] = false}, 
	{1008.2990112305,-3106.94140625,-38.999881744385,["time"] = 0,["used"] = false},  
	{1010.9890136719,-3104.5573730469,-38.999881744385,["time"] = 0,["used"] = false},  
	{1013.3607788086,-3106.8874511719,-38.999881744385,["time"] = 0,["used"] = false},  
	{1017.8317260742,-3104.5822753906,-38.999881744385,["time"] = 0,["used"] = false}, 
	{1019.0430297852,-3098.9851074219,-38.999881744385,["time"] = 0,["used"] = false}, 
	{1013.7381591797,-3100.9680175781,-38.999881744385,["time"] = 0,["used"] = false}, 
	{1009.3251342773,-3098.8120117188,-38.999881744385,["time"] = 0,["used"] = false},  
	{1005.9111938477,-3100.9387207031,-38.999881744385,["time"] = 0,["used"] = false}, 
	{1003.2393798828,-3093.9182128906,-38.999885559082,["time"] = 0,["used"] = false}, 
	{1008.0280151367,-3093.384765625,-38.999885559082,["time"] = 0,["used"] = false}, 
	{1010.8000488281,-3093.544921875,-38.999885559082,["time"] = 0,["used"] = false}, 
	{1016.1090087891,-3095.3405761719,-38.999885559082,["time"] = 0,["used"] = false},  
	{1018.2312011719,-3093.1293945313,-38.999885559082,["time"] = 0,["used"] = false},  
	{1025.1221923828,-3091.4680175781,-38.999885559082,["time"] = 0,["used"] = false}, 
	{1024.9321289063,-3096.4670410156,-38.999885559082,["time"] = 0,["used"] = false}, 
}

local dropPoints = {
	{1001.375,-3108.3840332031,-38.999900817871},
	{997.32006835938,-3099.3923339844,-38.999900817871},
	{1022.0564575195,-3095.892578125,-38.999855041504},
	{1022.1699829102,-3106.6181640625,-38.999855041504},
}

Citizen.CreateThread(function()
	exports["pw-polytarget"]:AddCircleZone("factory_outside", vector3(51.408695, 6485.7788, 31.428194), 1.0, {
		options = {
			["useZ"] = true,
		}
	})

	exports["pw-polytarget"]:AddCircleZone("factory_inside", vector3(997.88146, -3091.9541, -38.99985), 1.0, {
		options = {
			["useZ"] = true,
		}
	})

	exports['pw-interact']:AddPeekEntryByPolyTarget('factory_outside', {
        {
            id = "factoryoutside",
            event = "pw-factory:getinside",
            icon = "chevron-circle-up",
            label = "Đi vào"
        }}, { distance = { radius = 4.5 } })

	exports['pw-interact']:AddPeekEntryByPolyTarget('factory_inside', {
		{
			id = "factoryinside",
			event = "pw-factory:leave",
			icon = "chevron-circle-up",
			label = "Ra khỏi"
		}}, { distance = { radius = 4.5 } })
end)	

AddEventHandler('pw-factory:getinside', function(pParameters, pEntity, pContext)
	
	DoScreenFadeOut(1000)
	FreezeEntityPosition(PlayerPedId(),true)
	while not IsScreenFadedOut() do
		Citizen.Wait(10)
	end
	
	SetEntityCoords(PlayerPedId(), 997.88146, -3091.9541, -38.99985)
	isInFactory = true
	Citizen.Wait(500)
	FreezeEntityPosition(PlayerPedId(),false)
	DoScreenFadeIn(1000)
end)

AddEventHandler('pw-factory:leave', function(pParameters, pEntity, pContext)
	
	DoScreenFadeOut(1000)
	FreezeEntityPosition(PlayerPedId(),true)
	while not IsScreenFadedOut() do
		Citizen.Wait(10)
	end
	
	SetEntityCoords(PlayerPedId(), 51.754016, 6486.0678, 31.428379)
	isInFactory = false
	Citizen.Wait(500)
	FreezeEntityPosition(PlayerPedId(),false)
	DoScreenFadeIn(1000)
end)




Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(0)
		local PlayerPos = GetEntityCoords(PlayerPedId())
		if isInFactory then 
			for k,v in pairs(RecyclePoints) do
				if #(PlayerPos - vector3(v[1],v[2],v[3])) <= 3 and not v.used and not isRunningCrate then
					
					DrawText3Ds(v[1],v[2],v[3], "Vật liệu - [E]")
					if IsControlJustPressed(1, 38) then 
						v.used = true
						runRecycle()
					end
				end
			end
		end
	end
end)


function runRecycle()
	local daytime = GetClockHours()
	isRunningCrate = true
	local isHolding = false

	TriggerEvent("attachItem","crate01")
    RequestAnimDict("anim@heists@box_carry@")
    TaskPlayAnim(PlayerPedId(),"anim@heists@box_carry@","idle",2.0, -8, 180, 49, 0, 0, 0, 0)
    Wait(1000)
    TaskPlayAnim(PlayerPedId(),"anim@heists@box_carry@","idle",2.0, -8, 180000000, 49, 0, 0, 0, 0)
    
    isHolding = true
    local rnd = math.random(1,4)

    while isHolding do
    	Citizen.Wait(0)
    	if #(GetEntityCoords(PlayerPedId()) - vector3(dropPoints[rnd][1],dropPoints[rnd][2],dropPoints[rnd][3])) <= 40 then
    		DrawText3Ds(dropPoints[rnd][1],dropPoints[rnd][2],dropPoints[rnd][3], "Đặt đồ tái chế vào đây")
    		if IsControlJustPressed(1, 38) and IsPedInAnyVehicle(PlayerPedId(), false) ~= 1 then
	    		if #(GetEntityCoords(PlayerPedId()) - vector3(dropPoints[rnd][1],dropPoints[rnd][2],dropPoints[rnd][3])) <= 3 then
	    			isHolding = false
	    		end
			end
			if IsPedRunning(PlayerPedId()) then
				SetPedToRagdoll(PlayerPedId(),2000,2000, 3, 0, 0, 0)
				Wait(2100)
				TaskPlayAnim(PlayerPedId(),"anim@heists@box_carry@","idle",2.0, -8, 180000000, 49, 0, 0, 0, 0)
			end
    	end
    end

    ClearPedTasks(PlayerPedId())
    TriggerEvent("destroyProp")
    FreezeEntityPosition(PlayerPedId(),true)
    RequestAnimDict("mp_car_bomb")
    TaskPlayAnim(PlayerPedId(),"mp_car_bomb","car_bomb_mechanic",2.0, -8, 180,49, 0, 0, 0, 0)
    Wait(100)
    TaskPlayAnim(PlayerPedId(),"mp_car_bomb","car_bomb_mechanic",2.0, -8, 1800000,49, 0, 0, 0, 0)
    Wait(3000)
    ClearPedTasks(PlayerPedId())
    FreezeEntityPosition(PlayerPedId(),false)

    if math.random(2) == 2 then
    	TriggerEvent('player:receiveItem',"recyclablematerial", math.random(1,2))
	end

	--TriggerEvent("DoShortHudText","Nice work, keep it up!")
    isRunningCrate = false

end

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
