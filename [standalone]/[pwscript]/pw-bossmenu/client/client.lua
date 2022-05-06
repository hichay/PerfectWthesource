
ESX = nil
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if ESX == nil then
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Citizen.Wait(200)
        end
    end
end)

local isInMenu = false
RegisterCommand("tess", function(source, args, rawCommand)
    TriggerServerEvent("pw-bossmenu:server:openMenu")
end, false) 

RegisterNetEvent('pw-bossmenu:client:openMenu')
AddEventHandler('pw-bossmenu:client:openMenu', function(employees, jobdata)
    local employeesHTML, gradesHTML, recruitsHTML = '', '', ''

    for _, player in pairs(employees) do
        if player.name then
            if player.isboss == true then
                employeesHTML = employeesHTML .. [[<div class='player-box box-shadow option-enabled' id="]] .. player.source  .. [["><span id='option-text'>]] .. player.name .. ' [' .. player.gradeLabel .. [[]</span></div>]]

            else
                -- employeesHTML = employeesHTML .. [[<div class='player-box box-shadow' id="]] .. player.source  .. [["><span class='hoster-options' id="playeroptions-]] .. player.source  .. [["><span style="position: relative; top: 15%; margin-left: 27%;"><i id="]] .. player.source  .. [[" class="fas fa-angle-double-up gradeschange"></i>  <i id="]] .. player.source  .. [[" class="fas fa-user-slash fireemployee"></i></span></span><span id='option-text'>]] .. player.name .. ' [' .. player.gradeLabel .. [[]</span></div>]]
				
				employeesHTML = employeesHTML .. [[<div class='player-box box-shadow' id="]] .. player.source  .. [["><span class='hoster-options' id="playeroptions-]] .. player.source  .. [["><span style="position: relative; top: 15%; margin-left: 27%;"><i id="]] .. player.source  .. [[" class="fas fa-angle-double-up gradeschange"></i>  <i id="]] .. player.source  .. [[" class="fas fa-user-slash fireemployee"></i></span></span><span id='option-text'>]] .. player.name .. ' [' .. player.gradeLabel .. [[]</span></div>]]
            end
			
			
        end
    end

  
	local max = 0
    for k, v in pairs(jobdata.grades) do
        if tonumber(k) > max then
            max = tonumber(k)
        end
    end

    for level = 0, max do
        local grade = jobdata.grades[tostring(level)]
        if grade.isboss then
            gradesHTML = gradesHTML .. [[<div class='grade-box box-shadow option-enabled' id="]] .. tostring(level) .. [["><span id='option-text'>]] .. grade.name .. [[</span></div>]]
        else
            gradesHTML = gradesHTML .. [[<div class='grade-box box-shadow' id="]] .. tostring(level) .. [["><span id='option-text'>]] .. grade.name .. [[</span></div>]]
        end
    end

    isInMenu = true
    SetNuiFocus(true, true)
    SendNUIMessage({
        open = true,
        class = 'open',
        employees = employeesHTML,
        grades = gradesHTML,
    })
end)

RegisterNetEvent('pw-bossmenu:client:refreshPage')
AddEventHandler('pw-bossmenu:client:refreshPage', function(data, list)
    if data == 'employee' then
        local employeesHTML = ''
        for _, player in pairs(list) do
            if player.name then
                if player.isboss == true then
                    employeesHTML = employeesHTML .. [[<div class='player-box box-shadow option-enabled' id="]] .. player.source  .. [["><span id='option-text'>]] .. player.name .. ' [' .. player.gradeLabel .. [[]</span></div>]]
                else
                    employeesHTML = employeesHTML .. [[<div class='player-box box-shadow' id="]] .. player.source  .. [["><span class='hoster-options' id="playeroptions-]] .. player.source  .. [["><span style="position: relative; top: 15%; margin-left: 27%;"><i id="]] .. player.source  .. [[" class="fas fa-angle-double-up gradeschange"></i>  <i id="]] .. player.source  .. [[" class="fas fa-user-slash fireemployee"></i></span></span><span id='option-text'>]] .. player.name .. ' [' .. player.gradeLabel .. [[]</span></div>]]
                end
            end
        end
        
        isInMenu = true
        SendNUIMessage({
            open = true,
            class = 'refresh-players',
            employees = employeesHTML,
        })
    elseif data == 'recruits' then
        local recruitsHTML = ''
		
         if #list > 0 then
            for _, player in pairs(list) do
                recruitsHTML = recruitsHTML .. [[<div class='player-box box-shadow' id="]] .. player.source  .. [["><span class='hoster-options' id="playeroptions-]] .. player.source  .. [["><span style="position: relative; top: 15%; margin-left: 27%;"><i id="]] .. player.source  .. [[" class="fas fa-user-tag givejob"></i></span></span><span id='option-text'>]] .. player.name .. '</span></div>'
            end
        else
            recruitsHTML = [[<div class='player-box box-shadow option-enabled'><span class='hoster-options'"><span style="position: relative; top: 15%; margin-left: 27%;"></span></span><span id='option-text'>There is no players nearby.</span></div>]]
        end
        
        isInMenu = true
        SendNUIMessage({
            open = true,
            class = 'refresh-recruits',
            recruits = recruitsHTML,
        })
    end
end)

RegisterNetEvent('pw-bossmenu:client:refreshSociety')
AddEventHandler('pw-bossmenu:client:refreshSociety', function(job, data)
    if ESX and ESX.GetPlayerData().job.name == job then
        SendNUIMessage({
            open = true,
            class = 'refresh-society',
            amount = data,
         })
    end
end)

RegisterNUICallback('openStash', function(data)
    isInMenu = false
    SendNUIMessage({open = false})
    SetNuiFocus(false, false)
    
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "boss_" .. ESX.GetPlayerData().job.name, {
        maxweight = 4000000,
        slots = 500,
    })

    TriggerEvent("inventory:client:SetCurrentStash", "boss_" .. ESX.GetPlayerData().job.name)
end)

RegisterNUICallback('giveJob', function(data)
    TriggerServerEvent('pw-bossmenu:server:giveJob', data)
end)

RegisterNUICallback('openRecruit', function(data)
    CreateThread(function()
        local playerPed = PlayerPedId()
        local players = { GetPlayerServerId(PlayerId()) }
        for k,v in pairs(ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 10.0)) do
            if v and v ~= PlayerId() then
                table.insert(players, GetPlayerServerId(v))
            end
        end

        TriggerServerEvent("pw-bossmenu:server:updateNearbys", players)
    end)
end)

RegisterNUICallback('changeGrade', function(data)
    TriggerServerEvent('pw-bossmenu:server:updateGrade', data)
end)

RegisterNUICallback('fireEmployee', function(data)
    TriggerServerEvent('pw-bossmenu:server:fireEmployee', data)
end)

RegisterNUICallback('closeNUI', function()
    isInMenu = false
    SetNuiFocus(false, false)
end)

RegisterNUICallback('withdraw', function(data)
    local amount = tonumber(data.amount)
    TriggerServerEvent("pw-bossmenu:server:withdrawMoney", amount)
end)

RegisterNUICallback('deposit', function(data)
    local amount = tonumber(data.amount)
    TriggerServerEvent("pw-bossmenu:server:depositMoney", amount)
end)

RegisterCommand('closeboss', function()
    isInMenu = false
    SendNUIMessage({
        open = false,
    })
    SetNuiFocus(false, false)
end)

function tprint (t, s)
    for k, v in pairs(t) do
        local kfmt = '["' .. tostring(k) ..'"]'
        if type(k) ~= 'string' then
            kfmt = '[' .. k .. ']'
        end
        local vfmt = '"'.. tostring(v) ..'"'
        if type(v) == 'table' then
            tprint(v, (s or '')..kfmt)
        else
            if type(v) ~= 'string' then
                vfmt = tostring(v)
            end
            print(type(t)..(s or '')..kfmt..' = '..vfmt)
        end
    end
end 
