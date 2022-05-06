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



local taskInProcess = false
local activeTasks = 0


function openGui()
    guiEnabled = true
    SetNuiFocus(guiEnabled,true)
    SendNUIMessage({openGame = true})
end

function closeGui()
    guiEnabled = false
    SetNuiFocus(guiEnabled,false)
    SendNUIMessage({closeGame = true})	
end


function FalloutHack()
	
  openGui()
  activeTasks = 1
  while activeTasks == 1 do
        Citizen.Wait(1)
  end
	if activeTasks == 2 then
        closeGui()
        taskInProcess = false
        return 0
    else
        closeGui()
        taskInProcess = false
        return 100
    end 
  	
 	
end




RegisterNUICallback('Gamewin', function(data, cb)
  closeGui()
  activeTasks = data.tasknum

end)


RegisterNUICallback('Gamelose', function(data, cb)
    closeGui()
    activeTasks = data.tasknum
   
end)


RegisterCommand('fallout', function()		 
		local a = FalloutHack()
		
end)