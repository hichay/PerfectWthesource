

ESX              = nil
local PlayerData = {}


Citizen.CreateThread(function()
 
    
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
 
end)



local menuIsShowed = false
local hasAlreadyEnteredMarker = false
local isInMarker = false

function OpenBuyMenu()

	ESX.TriggerServerCallback('esx_RufiFoodTruck:CheckOwner', function(resp)
	
	 ESX.UI.Menu.CloseAll()
	 
	 local plate = nil
	 local chk = nil
	 
	 
	 for i=1, #resp, 1 do
	
	 chk = resp[i].chk
	 NWplate = resp[i].plate
	 
	 end
	 
	 local elements = {}
    	
	 
	   if chk then
	
		
				    table.insert(elements,{label = 'Spawn foodtruck', value = 'tiene'})
									
				
        else
		
		        
				    table.insert(elements,{label = 'Buy Foodtruck', value = 'notiene'})

		
		
		end
		

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), '---', {
			title    = 'FoodTruck menu',
			align    = 'bottom-right',
			elements = elements
		}, function(data, menu)
		
		
		if data.current.value == 'tiene' then
		ESX.UI.Menu.CloseAll()
		
		  ESX.UI.Menu.Open('default', GetCurrentResourceName(), '--',
		
		
		
		
		
		
		
		
		{
			title    = 'Which foodtruck model?',
			align    = 'bottom-right',
			elements = {
					{label = 'Foodtruck 1',  value = 'f1'},
					{label = 'Foodtruck 2', value = 'f2'}
				}
		}, function(data, menu)
             
			 
			if data.current.value == 'f1' then
			ESX.UI.Menu.CloseAll()
			
			 local playerPed = PlayerPedId()
		                                ESX.Game.SpawnVehicle(GetHashKey('taco'), Spawnpos, SpawnHeading, function (vehicle)
											TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
                                            SetEntityAsMissionEntity(vehicle, true, true)
											
											local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
											vehicleProps.plate = NWplate
											SetVehicleNumberPlateText(vehicle, NWplate)
											
											
										end)
			
			
			end
			
			if data.current.value == 'f2' then
			 local playerPed = PlayerPedId()
		                                ESX.Game.SpawnVehicle(GetHashKey('taco2'), Spawnpos, SpawnHeading, function (vehicle)
											TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

											SetEntityAsMissionEntity(vehicle, true, true)
											local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
											vehicleProps.plate = NWplate
											SetVehicleNumberPlateText(vehicle, NWplate)
											
											
											
										end)
			
			end
			
			 
			 
			

		end, function(data, menu)
			menu.close()
		end)
		
		
			   
		else

		BuyFoodtruck()
		   
		end   
		
		
		
		
			
		end, function(data, menu)
			menu.close()
		end)

	end)
	
	
end





function BuyFoodtruck()


     ESX.UI.Menu.CloseAll()


        ESX.UI.Menu.Open('default', GetCurrentResourceName(), '--',
		
		
		
		
		
		
		
		
		{
			title    = ('Buy FoodTruck for  <span style="color:lawngreen;">%s</span>$ ?'):format(Config.FoodtruckBuyPrice),
			align    = 'bottom-right',
			elements = {
					{label = 'Yes',  value = 'yesi'},
					{label = 'No', value = 'no'}
				}
		}, function(data, menu)
             
			 
			if data.current.value == 'yesi' then
			ESX.UI.Menu.CloseAll()
			
			BuyFoodtruck2()
			
			
			end
			
			if data.current.value == 'no' then
			ESX.UI.Menu.CloseAll()
			
			end
			
			 
			 
			

		end, function(data, menu)
			menu.close()
		end)

end


function BuyFoodtruck2()

 
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), '',
			{
				title    = 'Are you sure?', '',
				align    = 'bottom-right',
				elements = {
					{label = 'no',  value = 'no'},
					{label = 'yes', value = 'yesi'}
				}
			}, function(data3, menu3)

			

				if data3.current.value == 'yesi' then
				ESX.UI.Menu.CloseAll()
				
				

                   BuyFoodtruck3()
					
					
					
					

					

				end
				
				if data3.current.value == 'no' then

					
					ESX.UI.Menu.CloseAll()
					

					

				end
				

			end, function(data3, menu3)
				menu3.close()
			end)

end




function BuyFoodtruck3()

 
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), '',
			{
				title    = 'which payment method?', '',
				align    = 'bottom-right',
				elements = {
					{label = 'Cash',  value = 'c'},
					{label = 'Bank', value = 'b'}
				}
			}, function(data3, menu3)

			

				if data3.current.value == 'c' then
				ESX.UI.Menu.CloseAll()
				
				

                   local newPlate = GeneratePlate()
    			   TriggerServerEvent('esx_RufiFoodTruck:RegisterOwner', newPlate, Config.FoodtruckBuyPrice, true)
					
					
					
					

					

				end
				
				if data3.current.value == 'b' then
				
					ESX.UI.Menu.CloseAll()
					local newPlate = GeneratePlate()
    			    TriggerServerEvent('esx_RufiFoodTruck:RegisterOwner', newPlate, Config.FoodtruckBuyPrice, false)
					

					

				end
				

			end, function(data3, menu3)
				menu3.close()
			end)

end




local NumberCharset = {}
local Charset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end

for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

function GeneratePlate()
	local generatedPlate
	

	while true do
		Citizen.Wait(2)
		math.randomseed(GetGameTimer())
		if PlateUseSpace then
			generatedPlate = string.upper(GetRandomNumber(PlateNumbers) .. ' ' .. GetRandomLetter(PlateLetters))
			break
		else
			generatedPlate = string.upper(GetRandomLetter(PlateLetters) .. GetRandomNumber(PlateNumbers))
			break
		end

		
	end

	return generatedPlate
end


function GetRandomNumber(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

function GetRandomLetter(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end





AddEventHandler('esx_RufiFoodtruck:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
end)


tiempo5 = 1000

Citizen.CreateThread(function()
if AllowBlip then
addMapBlip(BlipName, BlipCoords)
end
	while true do
		Citizen.Wait(tiempo5)
		tiempo5 = 1000

		local coords = GetEntityCoords(PlayerPedId())
		isInMarker = false

		
			local distance = GetDistanceBetweenCoords(coords, BuyFoodtruckPos, true)

			if distance < Config.DrawDistance then
			tiempo5 = 0
			DrawMarker(Config.MarkerType, BuyFoodtruckPos, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.ZoneSize.x, Config.ZoneSize.y, Config.ZoneSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, true, true, 2, false, false, false, false)
            end

			if distance < 2 then
				isInMarker = true
				SetTextComponentFormat('STRING')
				AddTextComponentString(BuyFoodtruckMarkerText)
				DisplayHelpTextFromStringLabel(0, 0, 1, -1)
			end
		

		if isInMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
			tiempo5 = 0
		end

		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('esx_RufiFoodtruck:hasExitedMarker')
		end
	end
end)




function addMapBlip(text, bcoords)
    local blip = AddBlipForCoord(bcoords)
    SetBlipSprite(blip, BlipSprite)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, BlipScale)
    SetBlipColour(blip, BlipColour)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)
end

tiempo6 = 1000

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(tiempo6)
		

   tiempo6 = 1000
   local playerVeh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
   
   if (GetDistanceBetweenCoords(ParkCoords, GetEntityCoords(GetPlayerPed(-1))) < 20) and IsPedInAnyVehicle(GetPlayerPed(-1), false) and GetDisplayNameFromVehicleModel(GetEntityModel(playerVeh)) == "TACO"  or (GetDistanceBetweenCoords(ParkCoords, GetEntityCoords(GetPlayerPed(-1))) < 8) and IsPedInAnyVehicle(GetPlayerPed(-1), false) and GetDisplayNameFromVehicleModel(GetEntityModel(playerVeh)) == "TACO2" then
			 tiempo6 = 0
            DrawMarker(39, ParkCoords, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 0, 0, 96, 1, 1, 0, 0, 0, 0, 0)
			
            if (GetDistanceBetweenCoords(ParkCoords, GetEntityCoords(GetPlayerPed(-1))) < 2) then
			
			   tiempo = 0
                SetTextComponentFormat('STRING')
				AddTextComponentString(ParkText)
				DisplayHelpTextFromStringLabel(0, 0, 1, -1)
                if (IsControlJustReleased(1, Config.UseKey)) then
				ParkOrMod()
				
				
				end
				else
				
				if mdfyng then
				mdfyng = false
				ESX.UI.Menu.CloseAll()
				end
				
			end	
			
			
   end
   
   
   
   if isInMarker then
   tiempo6 = 0
   end

		if IsControlJustReleased(0, Config.UseKey) and isInMarker and not menuIsShowed then
		
			
			OpenBuyMenu()
		end
	end
end)




function ParkOrMod()

	
	
	 ESX.UI.Menu.CloseAll()
	 


		ESX.UI.Menu.Open('default', GetCurrentResourceName(), '---', {
			title    = 'Park or modify?',
			align    = 'bottom-right',
			elements = {
					{label = 'Park',  value = 'p'},
					{label = 'Modify', value = 'm'}
				}
		}, function(data, menu)
		
		
		if data.current.value == 'm' then
		
		ESX.UI.Menu.CloseAll()
		mdfyng = true
		  ESX.UI.Menu.Open('default', GetCurrentResourceName(), '--',
		
		
		
		
		
		
		
		
		{
			title    = 'Vehicle mod menu',
			align    = 'bottom-right',
			elements = {
					{label = 'Skin',  value = 'lv'},
					{label = 'Extras', value = 'ex'}
				}
		}, function(data, menu)
             
			 
			if data.current.value == 'lv' then
			ESX.UI.Menu.CloseAll()
			OpenSkinMenu()
			 end
			
			if data.current.value == 'ex' then
			ESX.UI.Menu.CloseAll()
			OpenExtraMenu()
			end
			
			 
			 
			

		end, function(data, menu)
			menu.close()
		end)
		
		
			   
		else
		
		ESX.UI.Menu.CloseAll()
		local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
		
		       ESX.Game.DeleteVehicle(vehicle)
				
				Citizen.Wait(500)
				
				if DoesEntityExist(vehicle) then
					
					SetEntityAsMissionEntity(vehicle, true, true)
					DeleteVehicle(vehicle)
				end
				
				if DoesEntityExist(vehicle) then
					
					DeleteEntity(vehicle)
				end

		

		   
		end   
		
		
		
		
			
		end, function(data, menu)
			menu.close()
		end)

	
	
	
end








function OpenExtraMenu()
	local elements = {}
	local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
	for id=0, 12 do
		if DoesExtraExist(vehicle, id) then
			local state = IsVehicleExtraTurnedOn(vehicle, id) 

			if state then
				table.insert(elements, {
					label = "Extra: "..('<span style="color:green;">%s</span>'):format("On"),
					value = id,
					state = not state
				})
			else
				table.insert(elements, {
					label = "Extra: "..('<span style="color:red;">%s</span>'):format("Off"),
					value = id,
					state = not state
				})
			end
		end
	end
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'extra_actions', {
		title    = 'Extra menu',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		SetVehicleExtra(vehicle, data.current.value, not data.current.state)
		local newData = data.current
		if data.current.state then
			newData.label = "Extra: "..('<span style="color:green;">%s</span>'):format("On")
		else
			newData.label = "Extra: "..('<span style="color:red;">%s</span>'):format("Off")
		end
		newData.state = not data.current.state

		menu.update({value = data.current.value}, newData)
		 menu.refresh()
	end, function(data, menu)
		menu.close()
	end)
end


function OpenSkinMenu()
	local elements = {}
	
	local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1))
	local liveryCount = GetVehicleLiveryCount(vehicle)
			
	for i = 1, liveryCount do
		local state = GetVehicleLivery(vehicle) 
		local text
		
		if state == i then
			text = "Skin: "..i..""
		else
			text = "Skin: "..i..""
		end
		
		table.insert(elements, {
			label = text,
			value = i,
			state = not state
		}) 
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), '--', {
		title    = 'Skin menu',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		SetVehicleLivery(vehicle, data.current.value, not data.current.state)
		local newData = data.current
		if data.current.state then
			newData.label = "Skin: "..data.current.value..""
		else
			newData.label = "Skin: "..data.current.value..""
		end
		newData.state = not data.current.state
		menu.update({value = data.current.value}, newData)
		menu.refresh()

	end, function(data, menu)
		menu.close()		
	end)
end


tiempo2 = 1000
Citizen.CreateThread(function()
	while true do
	
		Citizen.Wait(tiempo2)
		tiempo2 = 1000
		
		
		if vendiendo then		
		tiempo2 = 1
		
		if fst then
		 fst = false
		FoodtruckHelpMessage(Config.OptionsHelpText)
		end
		
		if IsControlJustPressed(0, Config.CamMenuKey) then
		
		CamState()
		
		
		end
		
		
		if IsControlJustReleased(0, Config.NpcJobKey) then
		 if not currando then
		 FoodtruckNotification(StartNpcJob)
		 Citizen.Wait(2000)
		 
		 FoodtruckNotification(WaitingForNpc)
		 CurrentCustomer           = nil
		  currando = true
		  currandoN = true
		  forceExit2 = false
		 else
		   FoodtruckNotification(NpcJobCancel)
		  forceExit2 = true
		  NoNPC = false
		  
		 end
		
		end
		
		if IsControlJustReleased(0, 177) then
		ESX.UI.Menu.CloseAll()
				
		end
		
		if IsControlJustReleased(0, Config.FoodTruckMenuKey) then
		
		if ok then
        OpenMainMenu()
		else
		TriggerEvent('esx:showNotification', 'Cooking...')
        end
		
		end
		
		    if IsControlPressed(0, 108) or IsControlPressed(0, 109) or IsControlPressed(0, 96) or IsControlPressed(0, 97) or IsControlPressed(0, 60) or IsControlPressed(0, 61) or ini then
	            tcam = 10
				
            else
             tcam = 100
 
            end	
		
		if isCameraActive then	
			DisableControlAction(2, 30, true)
			DisableControlAction(2, 31, true)
			DisableControlAction(2, 32, true)
			DisableControlAction(2, 33, true)
			DisableControlAction(2, 34, true)
			DisableControlAction(2, 35, true)
			DisableControlAction(0, 25, true) -- Input Aim
			DisableControlAction(0, 24, true) -- Input Attack
		end
		
		DisableControlAction(0, 22, true)
		DisableControlAction(2, 22, true)
		--DisableControlAction(2, 177, true)
        --DisableControlAction(0, 177, true)  -- Disable exit vehicle		
		DisableControlAction(0, 75, true)  -- Disable exit vehicle
		DisableControlAction(27, 75, true) -- Disable exit vehicle
		DisableControlAction(0, 23, true) -- Also 'enter'?
		else
		fst = true
		end
		
		
	end
end)


-- RegisterCommand("taco", function(source, args, raw)
  -- if ok then
    -- OpenMainMenu()
	-- else
	-- TriggerEvent('esx:showNotification', 'Cooking...')
   -- end	
-- end)

ok12 = true
function CamState()
  if ok12 then
  ok12 = false
    CreateFCam()
	else
	ok12 = true
	DeleteCam()
   end	
end






 














wnpc = false

function OpenMainMenu()

    local elements = {
      {label = "Products", value = 'f'},
      {label = "Billing", value = 'd'}
	  
     
    }
    if wnpc then
	table.insert(elements,{label = "Npc Menu", value = 'n'})
	end

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), '-',
      {
        title    = 'Menu',
        align    = 'bottom-right',
        elements = elements,
      },
      function(data, menu)
	  
	  if data.current.value == "f" then
	  menu.close()
	  npc = false
	  OpenProductsMenu(npc)
	  end
	  
	  if data.current.value == "d" then
	  menu.close()
	  OpenBillMenu()
	  end
	  
	  if data.current.value == "n" then
	  if wnpc then
	  menu.close()
	  npc = true
	  OpenProductsMenu(npc)
	  else
	  TriggerEvent('esx:showNotification', 'No npc!')
	  end
	  end
	
		
      end,
      
      function(data, menu)

        menu.close()

      end
    )

end


RegisterNetEvent('Esx_RufiFoodtruck:PayBill')
AddEventHandler('Esx_RufiFoodtruck:PayBill', function(amount, seller)
	PayBillMenu(amount, seller)
end)

function PayBillMenu(amount, seller)

    local elements = {
      {label = "Cash", value = 'f'},
      {label = "Bank", value = 'd'}
     
    }
    

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), '-',
      {
        title    = 'Pay ' .. amount .. ' $ bill',
        align    = 'bottom-right',
        elements = elements,
      },
      function(data, menu)
	  
	  if data.current.value == "f" then
	  menu.close()
	  TriggerServerEvent('esx_RufiFoodTruck:Pay', 'cash', amount, seller)
	  end
	  
	  if data.current.value == "d" then
	  menu.close()
	  TriggerServerEvent('esx_RufiFoodTruck:Pay', 'bank', amount, seller)
	  end
	
		
      end,
      
      function(data, menu)

        menu.close()

      end
    )

end




function OpenBillMenu()



		


     local playerPed = PlayerPedId()
	 local players, nearbyPlayer = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 3.0)
     local foundPlayers = false
     local elements = {}

     for i = 1, #players, 1 do
        if players[i] ~= PlayerId() then
            foundPlayers = true

            table.insert(
                elements,
                {
                    label = 'ID: ' .. GetPlayerServerId(players[i]) .. '',
                    value = GetPlayerServerId(players[i]),
					name = GetPlayerName(players[i])
                }
            )
        end
     end



		ESX.UI.Menu.Open('default', GetCurrentResourceName(), '--',
		{
			title    = 'Give bill to',
			align    = 'bottom-right',
			elements = elements
		}, function(data, menu)
             
			 
			 AddTextEntry('FMMC_KEY_TIP1', 'How much $ ?')

             DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", '', "", "", "", 8)

                  while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do

                        Citizen.Wait(0)

                    end

                   if UpdateOnscreenKeyboard() ~= 2 then

                       Bamount = GetOnscreenKeyboardResult()

                   Citizen.Wait(500)

                  

                    else

                  Citizen.Wait(500)


               end
			
			 
			 
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), '',
			{
				title    = 'Are you sure?', data.current.name,
				align    = 'bottom-right',
				elements = {
					{label = 'no',  value = 'no'},
					{label = 'yes', value = 'yesi'}
				}
			}, function(data3, menu3)

			

				if data3.current.value == 'yesi' then

					
					
					TriggerServerEvent('esx_RufiFoodTruck:OpenBillMenu', data.current.value, Bamount)
					menu3.close()
					

					

				end
				
				if data3.current.value == 'no' then

					
					menu3.close()
					

					

				end
				

			end, function(data3, menu3)
				menu3.close()
			end)

		end, function(data, menu)
			menu.close()
		end)

	
end


   

function OpenProductsMenu(npc)

    local elements = {
      {label = "Food", value = 'f'},
      {label = "Drinks", value = 'd'}
	  
     
    }
	
	  if npc then
	  table.insert(elements,{label = "Sell to npc", value = 's'})
	  end
    

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), '-',
      {
        title    = 'Menu',
        align    = 'bottom-right',
        elements = elements,
      },
      function(data, menu)
	  
	  if data.current.value == "f" then
	  OpenFoodMenu(npc)
	  end
	  
	  if data.current.value == "d" then
	  OpenDrinksMenu(npc)
	  end
	
	  if data.current.value == "s" then
	  CheckFood()
	  ESX.UI.Menu.CloseAll()
	  end
		
      end,
      
      function(data, menu)

        menu.close()

      end
    )

end

function OpenFoodMenu(npc)

    local elements = Foods
    

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), '--',
      {
        title    = 'Food',
        align    = 'bottom-right',
        elements = elements,
      },
      function(data2, menu2)
	  ok = false
	  menu2.close()
	  if npc then
	  Cooknpc(data2.current.prop, data2.current.label)
      else
      Cook(data2.current.prop, data2.current.item)
      end	  
	  
	  
	  

	  
	  
      end,
      
      function(data2, menu2)

        menu2.close()

        
      end
    )

end



function OpenDrinksMenu(npc)

    local elements = Drinks
    

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), '--',
      {
        title    = 'Drinks',
        align    = 'bottom-right',
        elements = elements,
      },
      function(data3, menu3)
	  
	  if npc then
	  ESX.UI.Menu.CloseAll()
	  CookDnpc(data3.current.prop, data3.current.label)
	  ESX.UI.Menu.CloseAll()
      else
	  menu3.close()	  
	  CookD(data3.current.prop, data3.current.item)
	  end
	  
      end,
      
      function(data3, menu3)

        menu3.close()

        
      end
    )

end

function CheckFood()

if foodnpc ~= nil and drinknpc ~= nil then


if foodnpc == NPCF.label and drinknpc == NPCD.label then


NPCprop_name = NPCF.prop
NPCDprop_name = NPCD.prop
fin = true

local Namount = NPCF.price + NPCD.price
TriggerServerEvent('esx_RufiFoodTruck:NPCPay', Namount)
elseif foodnpc == NPCF.label and drinknpc ~= NPCD.label then

FoodtruckNotification(WrongDrink)
elseif foodnpc ~= NPCF.label and drinknpc == NPCD.label then

FoodtruckNotification(WrongFood)
elseif foodnpc ~= NPCF.label and drinknpc ~= NPCD.label then
FoodtruckNotification(WrongDrinkAndFood)
end

else

FoodtruckNotification(NoDrinkOrFood)


end









end





tmpo = 1000
Citizen.CreateThread(function()
    while true do
        if textito then
		tmpo = 50
		if msg11 then
           ShowFloatingHelpNotification('Can I get a ' .. NPCF.label .. ' and ' .. NPCD.label .. ' please?', j, k, l - 0.1)
		 else
          ShowFloatingHelpNotification('Thank you. Bye!', j, k, l - 0.1)
        end		 
        else
			tmpo = 1000
        end
        Citizen.Wait(tmpo)
    end
end)


function FoodtruckHelpMessage(msg)

ESX.ShowHelpNotification(msg)

	
end


function FoodtruckNotification(msg)

ESX.ShowNotification(msg)  
	
end

function ShowFloatingHelpNotification(msg, x, y, z)
   SetFloatingHelpTextStyle(2, 1, 2, -1, 3, 0)
  SetFloatingHelpTextWorldPosition(1, vector3(x, y, z + 1.0))
  AddTextEntry('esxFloatingHelpNotification', msg)
   BeginTextCommandDisplayHelp('esxFloatingHelpNotification')
  EndTextCommandDisplayHelp(2, false, false, -1)
	
end



