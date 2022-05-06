-- Citizen.CreateThread( function()
	-- local resetcounter = 0
	-- local jumpDisabled = false
  	-- while true do 
    		-- Citizen.Wait(1)
		-- if jumpDisabled and resetcounter > 0 and IsPedJumping(GetPlayerPed(-1)) then	
			-- SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 3, 0, 0, 0)
			-- print("jump")
			-- resetcounter = 0
		-- end
		-- if not jumpDisabled and IsPedJumping(GetPlayerPed(-1)) then
			-- if math.random(2) == 2 then
				-- jumpDisabled = true
			-- end
			-- resetcounter = 1000
			-- Citizen.Wait(1000)
		-- end
		-- if resetcounter > 0 then
			-- resetcounter = resetcounter - 1
		-- else
			-- if jumpDisabled then
				-- resetcounter = 0
				-- jumpDisabled = false
			-- end
		-- end
	-- end
-- end)

-- Citizen.CreateThread(function()
	-- while true do
		-- Citizen.Wait(1)
		-- id = PlayerId()
		-- DisablePlayerVehicleRewards(id)	
	-- end
-- end)



Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local ped = GetPlayerPed(-1)
		id = PlayerId()
		DisablePlayerVehicleRewards(id)
		if IsPedBeingStunned(ped) then
			SetPedMinGroundTimeForStungun(GetPlayerPed(-1), math.random(4000, 7000))
		else
			Citizen.Wait(1000)
		end
	end
end)



--Seat swicher
local tonumber = tonumber
local CreateThread = Citizen.CreateThread
local Wait = Citizen.Wait
local TriggerEvent = TriggerEvent
local RegisterCommand = RegisterCommand
local PlayerPedId = PlayerPedId
local IsPedInAnyVehicle = IsPedInAnyVehicle
local GetPedInVehicleSeat = GetPedInVehicleSeat
local GetVehiclePedIsIn = GetVehiclePedIsIn
local SetPedIntoVehicle = SetPedIntoVehicle
-- end optimizations

local disabled = false

CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local restrictSwitching = false
        
        if IsPedInAnyVehicle(ped, false) and not disabled then
            if GetPedInVehicleSeat(GetVehiclePedIsIn(ped, false), 0) == ped then
                restrictSwitching = true
            end
        end
        
        SetPedConfigFlag(ped, 184, restrictSwitching)
        Wait(250)
    end
end)

local function switchSeat(_, args)
    local seatIndex = tonumber(args[1]) - 1
    
    if seatIndex < -1 or seatIndex >= 4 then
        SetNotificationTextEntry('STRING')
        AddTextComponentString("~r~Seat ~b~" .. (seatIndex + 1) .. "~r~ is not recognized")
        DrawNotification(true, true)
    else
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped, false)
        
        if veh ~= nil and veh > 0 then
            CreateThread(function()
                disabled = true
                SetPedIntoVehicle(PlayerPedId(), veh, seatIndex)
                Wait(50)
                disabled = false
            end)
        end
    end
end

local function shuffleSeat()
    CreateThread(function()
        disabled = true
        Wait(3000)
        disabled = false
    end)
end

RegisterCommand("seat", switchSeat)
RegisterCommand("shuff", shuffleSeat)
RegisterCommand("shuffle", shuffleSeat)

TriggerEvent('chat:addSuggestion', '/shuff', "Switch to the driver's seat")
TriggerEvent('chat:addSuggestion', '/shuffle', "Switch to the driver's seat")
TriggerEvent('chat:addSuggestion', '/seat', 'Switch seats in the current vehicle',
  { { name = 'seat', help = "Switch seats in the current vehicle. 0 = driver, 1 = passenger, 2-3 = back seats" } })

AddEventHandler('onClientResourceStop', function(name)
    if name == 'seat-switcher' then
        SetPedConfigFlag(PlayerPedId(), 184, false)
    end
end)