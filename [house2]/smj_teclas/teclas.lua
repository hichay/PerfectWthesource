--Hud de Controles de Teclas. (By Smouj013)
ESX                           = nil


local Playerhud = true
local Vehiclehud = true

Citizen.CreateThread(function()

	while ESX == nil do

		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

		Citizen.Wait(0)

	end

		if turnon == false then

			if IsControlJustPressed(0, 244) then

				func_321TuDongLai()

			end

		else

			Citizen.Wait(500)

		end

end)

Citizen.CreateThread(function()
	while true do Citizen.Wait(1)
		
		if Playerhud then
			drawTxt(0.815, 1.405, 1.0,1.0,0.35, "[~b~B~s~] ~c~Señalar" , 255, 255, 255, 230)
			drawTxt(0.815, 1.425, 1.0,1.0,0.35, "[~b~X~s~] ~c~Manos Arriba" , 255, 255, 255, 230)
			drawTxt(0.815, 1.445, 1.0,1.0,0.35, "[~b~Y~s~] ~c~Cruzar Brazos" , 255, 255, 255, 230)
			drawTxt(0.815, 1.465, 1.0,1.0,0.35, "[~b~Shift+H~s~] ~c~Distancia Voz" , 255, 255, 255, 230)

			drawTxt(0.735, 1.405, 1.0,1.0,0.35, "[~b~U~s~] ~c~Suelo" , 255, 255, 255, 230)
			drawTxt(0.735, 1.425, 1.0,1.0,0.35, "[~b~F9~s~] ~c~Menú DNI" , 255, 255, 255, 230)
			drawTxt(0.735, 1.445, 1.0,1.0,0.35, "[~b~F11~s~] ~c~Menú Ropa" , 255, 255, 255, 230)
			drawTxt(0.735, 1.465, 1.0,1.0,0.35, "[~b~G~s~] ~c~Llavero (~w~Coche~c~)" , 255, 255, 255, 230)

			drawTxt(0.655, 1.405, 1.0,1.0,0.35, "[~b~F3~s~] ~c~Menú Animaciones" , 255, 255, 255, 230)
			drawTxt(0.655, 1.425, 1.0,1.0,0.35, "[~b~F10~s~] ~c~Lista Civiles" , 255, 255, 255, 230)
			drawTxt(0.655, 1.445, 1.0,1.0,0.35, "[~b~F7~s~] ~c~Facturas" , 255, 255, 255, 230)
			drawTxt(0.655, 1.465, 1.0,1.0,0.35, "[~b~L~s~] ~c~Maletero (~w~Coche~c~)" , 255, 255, 255, 230)

		end
		
	end				
end)

RegisterCommand('caidiiit', function(source)
	Playerhud = not Playerhud
	if Playerhud then
	Playerhud = true
	else
	Playerhud = false
	end	

end, false)

Citizen.CreateThread(function()
	while true do Citizen.Wait(1)

		local MyPed = GetPlayerPed(-1)

		if(IsPedInAnyVehicle(MyPed, false)) and turnon == false then

			local MyPedVeh = GetVehiclePedIsIn(GetPlayerPed(-1),false)
			local PlateVeh = GetVehicleNumberPlateText(MyPedVeh)

			if Vehiclehud then

				drawTxt(1.375, 0.835, 1.0,1.0,0.35, "[~r~Z~s~] ~c~Cinturón", 255, 255, 255, 255) 
				drawTxt(1.375, 0.855, 1.0,1.0,0.35, "[~r~G~s~] ~c~Llavero", 255, 255, 255, 255)
				drawTxt(1.375, 0.875, 1.0,1.0,0.35, "[~r~Q~s~] ~c~Rádio", 255, 255, 255, 255) 
				drawTxt(1.375, 0.895, 1.0,1.0,0.35, "[~r~B~s~] ~c~Menú Vehiculo", 255, 255, 255, 255) 
				drawTxt(1.375, 0.915, 1.0,1.0,0.35, "[~r~M~s~] ~w~Abrir Guantera", 255, 255, 255, 255) 
				drawTxt(1.375, 0.935, 1.0,1.0,0.35, "[~r~F~s~] ~w~Salir Vehículo", 255, 255, 255, 255) 
				drawTxt(1.447, 0.895, 1.0,1.0,0.55, "~b~Matrícula: ~w~" .. PlateVeh, 255, 255, 255, 255)

			end

		end		
	end
end)

function drawTxt(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end
