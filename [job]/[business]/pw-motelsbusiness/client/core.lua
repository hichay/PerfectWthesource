local Keys = { ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18, ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182, ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81, ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178, ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173, }

ESX = nil Lib = nil MX = nil MyName = '' PlayersMotels = {} CallbackData = false EmployeeMotels = {} MotelsMoney = {} ClosestPlayers = {} MotelsBill = {} FXZ = {} local elevator = false MenuPlayers = {} local currentRoom = 0 MenuEmployeers = {} local currentPlayer = 0 local CurrentRequested = false local inBill = false local reqmenu = false

Citizen.CreateThread(function() 
    TriggerServerEvent('pw-motelsbusiness:GetConfig') 
    while not Cfg do
        Wait(100)
    end
    if not Cfg.QBCore then
        while ESX == nil do 
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 
            Citizen.Wait(0) 
        end 
        Citizen.Wait(1000) 
        if Cfg.charinfosystem then 
            while Lib == nil do 
                TriggerEvent('mx-base:getSharedObject', function(Library) Lib = Library end) 
                Citizen.Wait(0) 
            end 
        end 
        while not Identifier() do Wait(100) end
        TriggerServerEvent('pw-motelsbusiness:GetCharinfoName', false, Identifier())
        while not CallbackData do Wait(100) end
        if CallbackData ~= 'empty' then
            MyName = CallbackData.firstname..' '..CallbackData.lastname
        else
            MyName = 'none'
        end
    else
        while ESX == nil do 
            TriggerEvent('QBCore:GetObject', function(obj) ESX = obj end) 
            Citizen.Wait(0) 
        end 
        while not Identifier() do Wait(100) end
        TriggerServerEvent('pw-motelsbusiness:GetCharinfoName', false, Identifier())
        while not CallbackData do Wait(100) end
        if CallbackData ~= 'empty' then
            MyName = CallbackData.firstname..' '..CallbackData.lastname
        else
            MyName = 'none'
        end
        RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
        AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
            TriggerServerEvent('pw-motelsbusiness:qbload', GetPlayerServerId(PlayerId()))
        end)
    end
end)

RegisterNetEvent('pw-motelsbusiness:SetCallbackData')
AddEventHandler('pw-motelsbusiness:SetCallbackData', function(data)
    CallbackData = data
end)

RegisterNetEvent('pw-motelsbusiness:SendData')
AddEventHandler('pw-motelsbusiness:SendData', function (data)
    MX = data
    BuildDoors()
    BuildReception()
    BuildElevator()
    BuildInside()
    BuildCustomerMenu()
    if not Cfg.metasystem and not Cfg.QBCore then
        BuildNotMeta()
    end
    if Cfg.marker.doors then
        BuildDoorsMarker()
    end
    if Cfg.generalPurchasable then
        BuildBuyMotel()
    end
    if Cfg.bill then
        BuildBill()
    end
    BuildBlips()
    SendNUIMessage({
        type = 'getMainData',
        language = Langs[Cfg.Language],
        config = Cfg,
        buildData = MX
    })
end)

RegisterNetEvent('pw-motelsbusiness:UpdateOpened')
AddEventHandler('pw-motelsbusiness:UpdateOpened', function(key, upval)
    if MX then
        MX[key].opened = upval
    end
end)

RegisterNetEvent('pw-motelsbusiness:GetPlayersData')
AddEventHandler('pw-motelsbusiness:GetPlayersData', function(data)
    PlayersMotels = data
end)

RegisterNetEvent('pw-motelsbusiness:GetConfig')
AddEventHandler('pw-motelsbusiness:GetConfig', function(Config, Lang)
    Cfg = Config
    _U = Lang
end)

RegisterNetEvent('pw-motelsbusiness:GetEmployeesData')
AddEventHandler('pw-motelsbusiness:GetEmployeesData', function(data)
    EmployeeMotels = data
end)

RegisterNetEvent('pw-motelsbusiness:GetBillsData')
AddEventHandler('pw-motelsbusiness:GetBillsData', function(data)
    MotelsBill = data
end)

RegisterNetEvent('pw-motelsbusiness:GetSocietyData')
AddEventHandler('pw-motelsbusiness:GetSocietyData', function(data)
    MotelsMoney = data
end)

RegisterNetEvent('pw-motelsbusiness:setMotelOwner')
AddEventHandler('pw-motelsbusiness:setMotelOwner', function(player, motelid)
    TriggerServerEvent('pw-motelsbusiness:setMotelOwner', player, motelid)
end)

function GardrobeMenu()
    local elements = {}
    elements[1] = {label = _U['gardrobe_changeoutfit'],val="Change"}
    elements[2] = {label = _U['gardrobe_deleteoutfit'],val="Delete"}
    elements[3] = {label = _U['gardrobe_saveoutfit'],val="Save"}
  
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'dressing', {
      title    = _U['gardrobe_cabinet'],
      align    = 'top-left',
      elements = elements
    }, function(data, menu)
      ESX.TriggerServerCallback('pw-motelsbusiness:GetDressing', function(d)
        local dressing = d
        if data.current.val == "Change" then
          local elements = {}
          for i=1, #dressing, 1 do
            table.insert(elements, {
              label = dressing[i],
              value = i
            })
          end
  
          ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'change', {
            title    = _U['gardrobe_changeoutfit'],
            align    = 'top-left',
            elements = elements
          }, function(data2, menu2)
            TriggerEvent('skinchanger:getSkin', function(skin)
              ESX.TriggerServerCallback('pw-motelsbusiness:getOutfit', function(clothes)
                TriggerEvent('skinchanger:loadClothes', skin, clothes)
                TriggerEvent('esx_skin:setLastSkin', skin)
                TriggerEvent('skinchanger:getSkin', function(skin)
                  TriggerServerEvent('esx_skin:save', skin)
                end)
              end, data2.current.value)
            end)
          end, function(data2, menu2)
            menu2.close()
          end)

        elseif data.current.val == "Delete" then
          local elements = {}
  
          for i=1, #dressing, 1 do
            table.insert(elements, {
              label = dressing[i],
              value = i
            })
          end

          ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'remove', {
            title    = _U['gardrobe_deleteoutfit'],
            align    = 'top-left',
            elements = elements
          }, function(data2, menu2)
            menu2.close()
            TriggerServerEvent('pw-motelsbusiness:removeOutfit', data2.current.value)
          end, function(data2, menu2)
            menu2.close()
          end)
        elseif data.current.val == "Save" then
            ESX.TriggerServerCallback('pw-motelsbusiness:checkPropertyDataStore', function(foundStore)
                if foundStore then
                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'outfit_name', {
                        title = _U['wardrobe_selectName']
                    }, function(data3, menu3)
                        menu3.close()

                        TriggerEvent('skinchanger:getSkin', function(skin)
                            TriggerServerEvent('pw-motelsbusiness:saveOutfit', data3.value, skin)
                        end)
                    end, function(data3, menu3)
                        menu3.close()
                    end)            
                end
            end)
        end
      end)
    end, function(data, menu)
      menu.close()
    end)
end

RegisterNetEvent('pw-motelsbusiness:Sync')
AddEventHandler('pw-motelsbusiness:Sync', function(method, key, value, upval)
    if MX then
        MX[key][method][value].locked = upval
    end
end)

RegisterNetEvent('pw-motelsbusiness:SetOwner')
AddEventHandler('pw-motelsbusiness:SetOwner', function(key, value)
    if MX then
        MX[key].owner = value
    end
end)

CreateThread(function ()
    while not Cfg do
        Wait(100)
    end
    if not Cfg.QBCore then
        RegisterNetEvent('pw-motelsbusiness:UseKey')
        AddEventHandler('pw-motelsbusiness:UseKey', function(item)
            --local metadata = ESX.GetPlayerData().inventory[item.slot].metadata
			local metadata = exports["pw-inventory"]:GetItemInfoName("motelkey")
            local motelKEY = false
            local motelID = false
            local type = false
            local pcoords = GetEntityCoords(PlayerPedId())
            if MX then
                for k,v in pairs(MX) do
                    for i = 1, #v.doors do
                        if #(v.doors[i].coords - pcoords) <= 3.0 then
                            motelKEY = k
                            motelID = i 
                            type = "doors"
                        end
                        if #(v.gardrobes[i].coords - pcoords) <= 1.5 then
                            motelKEY = k
                            motelID = i 
                            type = "gardrobes"
                        end
                        if #(v.stashes[i].coords - pcoords) <= 1.5 then
                            motelKEY = k
                            motelID = i 
                            type = "stashes"
                        end
                    end
                end
                Citizen.Wait(93)
                if motelKEY and motelID and type then
                    local isuniq = UniqItem(metadata, motelKEY, motelID)
                    if isuniq == true then
                        RequestAnimDict("anim@heists@keycard@")
                        while not HasAnimDictLoaded("anim@heists@keycard@") do
                            Citizen.Wait(1)
                        end
                        if Cfg.doorSound then
                            if type == 'doors' then
                                SendNUIMessage({type = 'StartSound'})
                            end
                        end
                        TaskPlayAnim(PlayerPedId(), "anim@heists@keycard@", "exit", 8.0, 8.0, 1000, 1, 1, 0, 0, 0)
                        TriggerServerEvent('pw-motelsbusiness:Sync', type, motelKEY, motelID, not MX[motelKEY][type][motelID].locked)
                    elseif isuniq == false then
                        Notification(_U['metadata_notnumb'])
                    end
                else
                    Notification(_U['metadata_notclosestmotel'])
                end
            end
        end)
    else
        RegisterNetEvent('pw-motelsbusiness:UseKey')
        AddEventHandler('pw-motelsbusiness:UseKey', function(item)
            local motelKEY = false
            local motelID = false
            local type = false
            local pcoords = GetEntityCoords(PlayerPedId())
            if MX then
                for k,v in pairs(MX) do
                    for i = 1, #v.doors do
                        if #(v.doors[i].coords - pcoords) <= 1.5 then
                            motelKEY = k
                            motelID = i 
                            type = "doors"
                        end
                        if #(v.gardrobes[i].coords - pcoords) <= 1.5 then
                            motelKEY = k
                            motelID = i 
                            type = "gardrobes"
                        end
                        if #(v.stashes[i].coords - pcoords) <= 1.5 then
                            motelKEY = k
                            motelID = i 
                            type = "stashes"
                        end
                    end
                end
                Citizen.Wait(93)
                if motelKEY and motelID and type then
                    local isuniq = UniqItem(item, motelKEY, motelID)
                    if isuniq == true then
                        RequestAnimDict("anim@heists@keycard@")
                        while not HasAnimDictLoaded("anim@heists@keycard@") do
                            Citizen.Wait(1)
                        end
                        if Cfg.doorSound then
                            if type == 'doors' then
                                SendNUIMessage({type = 'StartSound'})
                            end
                        end
                        TaskPlayAnim(PlayerPedId(), "anim@heists@keycard@", "exit", 8.0, 8.0, 1000, 1, 1, 0, 0, 0)
                        TriggerServerEvent('pw-motelsbusiness:Sync', type, motelKEY, motelID, not MX[motelKEY][type][motelID].locked)
                    elseif isuniq == false then
                        Notification(_U['metadata_notnumb'])
                    end
                else
                    Notification(_U['metadata_notclosestmotel'])
                end
            end
        end)
    end
end)

function BuildBlips()
    Citizen.CreateThread(function()
        for k,v in pairs(MX) do
            if v.blip.active then
                local bl = AddBlipForCoord(v.blip.coords)
                SetBlipSprite(bl, v.blip.sprite)
                SetBlipColour(bl, v.blip.color)
                SetBlipScale(bl, v.blip.scale)
                BeginTextCommandSetBlipName("CUSTOM_TEXT")
                AddTextComponentString(v.blip.name)
                EndTextCommandSetBlipName(bl)
                SetBlipAsShortRange(bl, true)
            end
        end
        -- if Cfg.bill then
            -- local bl = AddBlipForCoord(Cfg.bill.pos)
            -- SetBlipSprite(bl, Cfg.bill.blip.sprite)
            -- SetBlipColour(bl, Cfg.bill.blip.color)
            -- SetBlipScale(bl, Cfg.bill.blip.scale)
            -- BeginTextCommandSetBlipName("CUSTOM_TEXT")
            -- AddTextComponentString(Cfg.bill.blip.name)
            -- EndTextCommandSetBlipName(bl)
            -- SetBlipAsShortRange(bl, true)
        -- end
    end)
end

function BuildDoors()
    Citizen.CreateThread(function()
        while true do
            local sleep = 2000
            local playercoords = GetEntityCoords(PlayerPedId())
            for _,v in pairs(MX) do
                for i = 1, #v.doors do
                    if #(v.doors[i].coords - playercoords) <= 167.3 then
                        sleep = 500
                        if v.doors[i].obj == nil or not DoesEntityExist(v.doors[i].obj) then
                            v.doors[i].obj = GetClosestObjectOfType(v.doors[i].coords, 0.7, v.doors[i].hash, false, false, false)
                            FreezeEntityPosition(v.doors[i].obj, v.doors[i].locked)
                        else
                            FreezeEntityPosition(v.doors[i].obj, v.doors[i].locked)
                            if v.doors[i].locked then
                                SetEntityHeading(v.doors[i].obj, v.doors[i].h)
                            end
                        end
                    end
                end
            end
            Citizen.Wait(sleep)
        end
    end)
end

function BuildBill()
    Citizen.CreateThread(function()
        while true do
            local sleep = 1250  
            local playercoords = GetEntityCoords(PlayerPedId())
            if #(Cfg.bill.pos - playercoords) <= 4.0 then
                sleep = 3
                HelpNotify(_U['bill'], Cfg.bill.pos)
                if IsControlJustPressed(0, Keys['E']) then
                    OpenBillMenu()
                end
            end
            Citizen.Wait(sleep)
        end
    end)
end

function BuildBuyMotel()
    Citizen.CreateThread(function()
        while true do   
            local sleep = 1250
            local playercoords = GetEntityCoords(PlayerPedId())
            for k,v in pairs(MX) do
                if v.purchasable then
                    if v.owner == '' or not v.owner then
                        if #(playercoords - v.reception) <= 3.0 then
                            sleep = 3
                            HelpNotify(_U['reception_buyMotel'], v.reception)
                            if IsControlJustPressed(0, Keys['E']) then
                                TriggerServerEvent('pw-motelsbusiness:SelfBuyMotel', k, v.price)
                            end
                        end
                    end
                end
            end
            Citizen.Wait(sleep)
        end
    end)
end

function BuildDoorsMarker()
    Citizen.CreateThread(function()
        while true do   
            local sleep = 1250
            local playercoords = GetEntityCoords(PlayerPedId())
            for k,v in pairs(MX) do
                for i = 1, #v.doors do
                    if #(v.doors[i].coords - playercoords) <= 2.0 then
                        if PlayersMotels[Identifier()] then
                            local playerMotel = PlayersMotels[Identifier()].motel..'-'..PlayersMotels[Identifier()].motelid
                            local genmotel = k..'-'..i
                            sleep = 3
                            if playerMotel == genmotel then
                                DrawMarker(Cfg.marker.type, v.doors[i].coords.x, v.doors[i].coords.y, v.doors[i].coords.z - 0.9, 0, 0, 0, 0, 0, 0, 0.60, 0.60, 0.3, 222, 2, 2, 60, 0, 0, 2, 0, 0, 0, 0) 
                            end
                        end
                    end
                end
            end
            Citizen.Wait(sleep)
        end
    end)
end

function BuildNotMeta()
    Citizen.CreateThread(function()
        while true do
            local sleep = 1250
            local playercoords = GetEntityCoords(PlayerPedId())
            local motelKEY = false
            local motelID = false
            local type = false
            for k,v in pairs(MX) do
                for i = 1, #v.doors do
                    if #(v.doors[i].coords - playercoords) <= 1.5 then
                        motelKEY = k
                        motelID = i 
                        type = "doors"
                    end
                    if #(v.gardrobes[i].coords - playercoords) <= 1 then
                        motelKEY = k
                        motelID = i 
                        type = "gardrobes"
                    end
                    if #(v.stashes[i].coords - playercoords) <= 1 then
                        motelKEY = k
                        motelID = i 
                        type = "stashes"
                    end
                end
            end
            if motelKEY and motelID and type then
                local dst = #(MX[motelKEY][type][motelID].coords - playercoords)
                if PlayersMotels[Identifier()] then
                    local playerMotel = PlayersMotels[Identifier()].motel..'-'..PlayersMotels[Identifier()].motelid
                    local genmotel = motelKEY..'-'..motelID
                    if dst <= 1.2 and playerMotel == genmotel then
                        if PlayersMotels[Identifier()].suspended == 0 then
                            sleep = 3
                            if MX[motelKEY][type][motelID].locked then
                                HelpNotify(_U['not_metadata_text']:format(_U['not_metadata_locked']), MX[motelKEY][type][motelID].coords)
								--ESX.ShowHelpNotification(""
                            elseif MX[motelKEY][type][motelID].locked == false then
                                if type == 'doors' then
                                    HelpNotify(_U['not_metadata_text']:format(_U['not_metadata_unlocked']), MX[motelKEY][type][motelID].coords)
                                end
                            end
                            if IsControlJustPressed(0, Keys['G']) then
                                Citizen.Wait(50)
                                RequestAnimDict("anim@heists@keycard@")
                                while not HasAnimDictLoaded("anim@heists@keycard@") do
                                    Citizen.Wait(1)
                                end
                                if Cfg.doorSound then
                                    if type == 'doors' then
                                        SendNUIMessage({type = 'StartSound'})
                                    end
                                end
                                TaskPlayAnim(PlayerPedId(), "anim@heists@keycard@", "exit", 8.0, 8.0, 1000, 1, 1, 0, 0, 0)
                                TriggerServerEvent('pw-motelsbusiness:Sync', type, motelKEY, motelID, not MX[motelKEY][type][motelID].locked)
                            end
                        else
                            Notification(_U['motel_Suspended'])
                        end
                    end
                end
            end
            Citizen.Wait(sleep)
        end
    end)
end

function BuildCustomerMenu()
    Citizen.CreateThread(function()
        while true do
            local sleep = 1250
            local playercoords = GetEntityCoords(PlayerPedId())
            for k,v in pairs(MX) do
                if #(playercoords - v.selfMan) <= 4 then
                    if PlayersMotels[Identifier()] and PlayersMotels[Identifier()].motel == k then
                        sleep = 3
                        HelpNotify(_U['selfManagementE'], v.selfMan)
                        if IsControlJustPressed(0, 38) then
                            TriggerServerEvent('pw-motelsbusiness:GetPlayersData')
                            TriggerServerEvent('pw-motelsbusiness:GetEmployeesData')
                            TriggerServerEvent('pw-motelsbusiness:GetSocietyData')
                            OpenCustomerMenu(k)
                        end
                    end
                end
            end
            Citizen.Wait(sleep)
        end
    end)
end

function BuildReception()
    Citizen.CreateThread(function()
        while true do
            local sleep = 1250
            local playercoords = GetEntityCoords(PlayerPedId())
            for k,v in pairs(MX) do
                local dst = #(playercoords - v.reception)
                if dst <= 2 then
                    if MX[k].opened then
                        if (v.owner == Identifier()) or EmployeeMotels[Identifier()] and EmployeeMotels[Identifier()].motel == k then
                            sleep = 3
                            HelpNotify(_U['reception'], v.reception)
                            if IsControlJustPressed(0, 38) then
                                TriggerServerEvent('pw-motelsbusiness:UpdateOpened', k, false)
                                TriggerServerEvent('pw-motelsbusiness:GetPlayersData')
                                TriggerServerEvent('pw-motelsbusiness:GetEmployeesData')
                                TriggerServerEvent('pw-motelsbusiness:GetSocietyData')
                                OpenReceptionMenu(k, v.owner == Identifier())
                            end
                        end
                    end
                end
            end
            Citizen.Wait(sleep)
        end
    end)
end

function BuildInside()
    Citizen.CreateThread(function()
        while true do
            local sleep = 1250
            local playercoords = GetEntityCoords(PlayerPedId())
            for k,v in pairs(MX) do
                for i = 1, #v.stashes do
                    local dst = #(playercoords - v.stashes[i].coords)
                    if dst <= 3.0 then
                        if not v.stashes[i].locked then
                            if Cfg.metasystem or Cfg.QBCore then
                                sleep = 3
                                HelpNotify(_U['stash'], v.stashes[i].coords)
                                if dst <= 2 and IsControlJustPressed(0, 38) and not v.stashes[i].locked then
                                    OpenStash(k, i)
                                end
                            else
                                sleep = 3
                                HelpNotify(_U['stash']..' | '.._U['not_metadata_text']:format(_U['not_metadata_unlocked']), v.stashes[i].coords)
                                if dst <= 2 and IsControlJustPressed(0, 38) and not v.stashes[i].locked then
                                    OpenStash(k, i)
                                end
                            end
                        elseif v.stashes[i].locked and Cfg.marker.stashes then
                            sleep = 3
                            DrawMarker(Cfg.marker.type, v.stashes[i].coords.x, v.stashes[i].coords.y, v.stashes[i].coords.z - 0.9, 0, 0, 0, 0, 0, 0, 0.60, 0.60, 0.3, 222, 2, 2, 60, 0, 0, 2, 0, 0, 0, 0) 
                        end
                    end
                    if #(playercoords - v.gardrobes[i].coords) <= 3.0 then
                        if not v.gardrobes[i].locked then
                            if Cfg.metasystem or Cfg.QBCore then
                                sleep = 3
                                HelpNotify(_U['gardrobe'], v.gardrobes[i].coords)
                                if #(playercoords - v.gardrobes[i].coords) <= 2 and IsControlJustPressed(0, 38) and not v.gardrobes[i].locked then
                                    if Cfg.gardrobe == "qb" then
                                        TriggerEvent('qb-clothing:client:openOutfitMenu')
                                    elseif Cfg.gardrobe == "esx" then
                                        GardrobeMenu()
                                    end
                                end
                            else
                                sleep = 3
                                HelpNotify(_U['gardrobe']..' | '.._U['not_metadata_text']:format(_U['not_metadata_unlocked']), v.gardrobes[i].coords)
                                if #(playercoords - v.gardrobes[i].coords) <= 2 and IsControlJustPressed(0, 38) and not v.gardrobes[i].locked then
                                    if Cfg.gardrobe == "qb" then
                                        TriggerEvent('qb-clothing:client:openOutfitMenu')
                                    elseif Cfg.gardrobe == "esx" then
                                        GardrobeMenu()
                                    end
                                end
                            end
                        elseif v.gardrobes[i].locked and Cfg.marker.gardrobes then
                            sleep = 3
                            DrawMarker(Cfg.marker.type, v.gardrobes[i].coords.x, v.gardrobes[i].coords.y, v.gardrobes[i].coords.z - 0.9, 0, 0, 0, 0, 0, 0, 0.60, 0.60, 0.3, 222, 2, 2, 60, 0, 0, 2, 0, 0, 0, 0) 
                        end
                    end
                end
            end
            Citizen.Wait(sleep)
        end
    end)
end

function OpenStash(key, index)
    if Cfg.stash == "qb" then
        TriggerServerEvent("inventory:server:OpenInventory", "stash", tostring(key..'_'..index), Cfg.inventorySettings)
        TriggerEvent("inventory:client:SetCurrentStash", tostring(key..'_'..index))
	elseif Cfg.stash == "pw" then
		TriggerEvent("server-inventory-open", "1", tostring(key..'_'..index))	
    elseif Cfg.stash == "disc" then
        Cfg.inventorySettings.owner = tostring(key..'_'..index)
        TriggerEvent('disc-inventoryhud:openInventory', Cfg.inventorySettings)
    elseif Cfg.stash == "linden" then
        Cfg.inventorySettings.owner = tostring(key..'_'..index)
        exports['linden_inventory']:OpenStash(Cfg.inventorySettings)
    end
end

--[[ Citizen.CreateThread(function()
    Citizen.Wait(1000)
    local allmenu = {
        'motelReq',
        'elevator',
        'bill',
        'bills',
        'elevator_rooms'
    }
    WarMenu.CreateMenu('motelReq', _U['motel_request'])
    WarMenu.CreateMenu('elevator', _U['elevator_menu'])
    WarMenu.CreateMenu('bill', _U['bill_menumsg'])
    WarMenu.CreateSubMenu('bills', 'bill')
    WarMenu.CreateSubMenu('elevator_rooms', 'elevator')
    for _, v in pairs(allmenu) do
        WarMenu.SetMenuWidth(v, 0.35)
        WarMenu.SetMenuX(v, 0.01)
        WarMenu.SetMenuY(v, 0.017)
        WarMenu.SetMenuMaxOptionCountOnScreen(v, 20)
        WarMenu.SetTitleColor(v, 255, 255, 255, 255)
        WarMenu.SetMenuSubTitleColor(v, 255, 255, 255, 255)
        WarMenu.SetTitleBackgroundColor(v, 0 , 0, 0, 150) -- Resepsiyonun arka planı
        WarMenu.SetMenuBackgroundColor(v, 0, 0, 0, 100)
        WarMenu.SetMenuSubTextColor(v, 255, 255, 255, 255)
    end
end) ]]

RegisterNetEvent('pw-motelsbusiness:OpenReqMenu')
AddEventHandler('pw-motelsbusiness:OpenReqMenu', function(method, data)
    if not reqmenu then
        --OpenReqMenu(method, data)
        TriggerEvent("pw-motel:client:RequestMenu",method,data)
    end
end)

function OpenReqMenu(method, data)
    reqmenu = true
    WarMenu.OpenMenu('motelReq')
    Citizen.CreateThread(function()
        while reqmenu do
            if WarMenu.IsMenuOpened('motelReq') then
                if method == 'buy' then
                    if WarMenu.Button(_U['reception_accept']) then
                        if data then
                                TriggerServerEvent('pw-motelsbusiness:BuyMotel', data.src, data.target, data.motel, data.motelid, data.time, data.expense)
                        else
                            Notification(_U['society_notData'])
                        end
                        WarMenu.CloseMenu()
                    end
                    if WarMenu.IsItemHovered() then
                        WarMenu.ToolTip(_U['motel_requestDesc']:format(data.firstname..' '..data.lastname, data.motelid, GetFirstTimer(data.time), data.expense))
                    end
                    if WarMenu.Button(_U['reception_ignore']) then
                        TriggerServerEvent('pw-motelsbusiness:ReqReject', data)
                        WarMenu.CloseMenu()
                    end
                    WarMenu.Display()
                elseif method == 'takeemployee' then
                    if WarMenu.Button(_U['reception_accept']) then
                        if data then
                                TriggerServerEvent('pw-motelsbusiness:TakeEmployee', data.src, data.target, data.motel, data.salary)
                        else
                            Notification(_U['society_notData'])
                        end
                        WarMenu.CloseMenu()
                    end
                    if WarMenu.IsItemHovered() then
                        WarMenu.ToolTip(_U['motel_employeeReqDesc']:format(data.firstname..' '..data.lastname, data.motel, data.salary))
                    end
                    if WarMenu.Button(_U['reception_ignore']) then
                        TriggerServerEvent('pw-motelsbusiness:ReqReject', data)
                        WarMenu.CloseMenu()
                    end
                    WarMenu.Display()
                end
            end
            Citizen.Wait(3)
        end
    end)
end

function OpenCustomerMenu(key)
    MenuPlayers, ClosestPlayers, MenuEmployeers, Requests = table.unpack(GetGeneralDatas(key)) 
    SendNUIMessage({
        type = 'customer',
        PlayersMotels = PlayersMotels,
        EmployeeMotels = EmployeeMotels,
        MotelsMoney = MotelsMoney,
        ClosestPlayers = ClosestPlayers,
        MenuPlayers = MenuPlayers,
        MenuEmployeers = MenuEmployeers,
        MotelsBill = MotelsBill,
        Requests = Requests,
        Identifier = Identifier(),
        isOwner = false,
        nowMotel = key,
        myName = MyName,
    });
    SetNuiFocus(true, true)
end

function OpenReceptionMenu(key, isOwner)
    MenuPlayers, ClosestPlayers, MenuEmployeers, Requests = table.unpack(GetGeneralDatas(key)) 
    CallbackData = false
    SendNUIMessage({
        type = 'reception',
        PlayersMotels = PlayersMotels,
        EmployeeMotels = EmployeeMotels,
        MotelsMoney = MotelsMoney,
        ClosestPlayers = ClosestPlayers,
        MenuPlayers = MenuPlayers,
        MenuEmployeers = MenuEmployeers,
        MotelsBill = MotelsBill,
        Requests = Requests,
        Identifier = Identifier(),
        isOwner = isOwner,
        nowMotel = key,
        myName = MyName,
        buildData = MX
    });
    SetNuiFocus(true, true)
end

RegisterNUICallback('CloseMotel', function (data)
    SetNuiFocus(false, false)
    TriggerServerEvent('pw-motelsbusiness:UpdateOpened', data.motel, true)
end)

RegisterNetEvent('pw-motelsbusiness:AddTransaction')
AddEventHandler('pw-motelsbusiness:AddTransaction', function(method, veri)
    SendNUIMessage({
        type = 'transaction',
        method = method,
        data = veri
    })
end)

RegisterNUICallback('SendFromReceptionReq', function(veri)
    TriggerServerEvent('pw-motelsbusiness:Req', veri.method, veri.data)
end)

RegisterNUICallback('GetTimer', function(data, cb)
    cb(GetTimer(data.target))
end)

RegisterNUICallback('UpdateSuspend', function(data)
    TriggerServerEvent('pw-motelsbusiness:UpdateSuspend', data.target)
end)

RegisterNUICallback('DeleteMotel', function(data)
    TriggerServerEvent('pw-motelsbusiness:DeleteMotelFromPlayer', data.target)
end)

RegisterNUICallback('ChangeRoom', function(data)
    ChangeRoomFromReception(data)
end)

RegisterNUICallback('CreateNewKey', function (data)
    TriggerServerEvent('pw-motelsbusiness:CreateNewKey', data.target)
end)

RegisterNUICallback('UpdateSalary', function(data)
    TriggerServerEvent('pw-motelsbusiness:UpdateSalary', data.target, data.amount)
end)

RegisterNUICallback('SendMessageFromRecetion', function (data)
    SendMessagePlayerFromReception(data.msg, data.target)
end)

AddEventHandler('inmenu', function(upval)
    if not upval then
        reqmenu = false
        elevator = false
        inBill = false
    end
end)

RegisterNUICallback('KickEmployee', function(data)
    TriggerServerEvent('pw-motelsbusiness:KickEmployee', data.current)
end)

RegisterNUICallback('WithdrawMoney', function(data)
    TriggerServerEvent('pw-motelsbusiness:SetMoney', data.motel, tonumber(data.amount), 2)
end)

RegisterNUICallback('DepositMoney', function(data)
    TriggerServerEvent('pw-motelsbusiness:SetMoney', data.motel, tonumber(data.amount), 1)
end)

RegisterNUICallback('SellMotel', function(data)
    TriggerServerEvent('pw-motelsbusiness:SellMotel', data.motel)
end)

RegisterNUICallback('GiveReward', function(data)
    TriggerServerEvent('pw-motelsbusiness:GiveReward', data.target, data.motel, data.amount)
end)

RegisterNUICallback('PayRoom', function(data)
    TriggerServerEvent('pw-motelsbusiness:payRoom', tonumber(data.amount))
end)

function GetGeneralDatas(key)
    MenuPlayers = {}
    MenuEmployeers = {}
    ClosestPlayers = {}
    Requests = {}
    local players = GetPlayers()
    for _,v in ipairs(players) do
        local targetPed = GetPlayerPed(v)
        -- if targetPed ~= PlayerPedId() then
            if #(GetEntityCoords(targetPed) - GetEntityCoords(PlayerPedId())) <= 4 then
                CallbackData = false
                TriggerServerEvent('pw-motelsbusiness:GetCid', GetPlayerServerId(v))
                while not CallbackData do Wait(10) end
                if CallbackData ~= 'empty' then
                    local cid = CallbackData
                    CallbackData = false
                    TriggerServerEvent('pw-motelsbusiness:GetCharinfoName', false, cid)
                    while not CallbackData do Wait(10) end
                    if CallbackData ~= 'empty' then
                        ClosestPlayers[cid] = CallbackData
                    end
                end
                CallbackData = false
            -- end
        end
    end
    if next(PlayersMotels) then
        for k,v in pairs(PlayersMotels) do
            if v.requests.requestEmployee or v.requests.requestKey or v.requests.requestChangeRoom or v.requests.requestRefreshTime then
                Requests[k] = v.requests
            end
        end
        TriggerServerEvent('pw-motelsbusiness:GetCharinfoName', PlayersMotels, false, key)
        while not CallbackData do Wait(10) end
        if CallbackData ~= 'empty' then
            MenuPlayers = CallbackData
        end
        CallbackData = false
    end
    if Cfg.Employee.active then
        if next(EmployeeMotels) then
            TriggerServerEvent('pw-motelsbusiness:GetCharinfoName', EmployeeMotels, false, key)
            while not CallbackData do Wait(10) end
            if CallbackData ~= 'empty' then
                for k,v in pairs(CallbackData) do
                    MenuEmployeers = CallbackData
                end
            end
            CallbackData = false
        end
    end
    if not MotelsMoney[key] then
        MotelsMoney[key] = {}
        MotelsMoney[key].motel = key
        MotelsMoney[key].money = 0
    end
    return {
        MenuPlayers,
        ClosestPlayers,
        MenuEmployeers,
        Requests
    }
end

RegisterNUICallback('RefreshData', function(veri)
    local MenuPlayers, ClosestPlayers, MenuEmployeers, Requests = table.unpack(GetGeneralDatas(veri.motel))
    SendNUIMessage({
        type = 'RefreshDatas',
        PlayersMotels = PlayersMotels,
        EmployeeMotels = EmployeeMotels,
        MotelsMoney = MotelsMoney,
        ClosestPlayers = ClosestPlayers,
        MenuPlayers = MenuPlayers,
        MenuEmployeers = MenuEmployeers,
        MotelsBill = MotelsBill,
        Requests = Requests
    })
end)

RegisterNUICallback('AddPermission', function(data)
    if data.currentReq == 'permKick' then
        TriggerServerEvent('pw-motelsbusiness:UpdatePermission', data.target, "kick", not EmployeeMotels[data.target].permissions.kick)
    elseif data.currentReq == 'permChangeRoom' then
        TriggerServerEvent('pw-motelsbusiness:UpdatePermission', data.target, "change", not EmployeeMotels[data.target].permissions.change)
    elseif data.currentReq == 'permRefreshTime' then
        TriggerServerEvent('pw-motelsbusiness:UpdatePermission', data.target, "timerefresh", not EmployeeMotels[data.target].permissions.timerefresh)
    elseif data.currentReq == 'permCreateNewKey' then
        TriggerServerEvent('pw-motelsbusiness:UpdatePermission', data.target, "createnewkey", not EmployeeMotels[data.target].permissions.createnewkey)
    elseif data.currentReq == 'permSendMessage' then
        TriggerServerEvent('pw-motelsbusiness:UpdatePermission', data.target, "sendmessage", not EmployeeMotels[data.target].permissions.sendmessage)
    elseif data.currentReq == 'permRentRoom' then
        TriggerServerEvent('pw-motelsbusiness:UpdatePermission', data.target, "takeplayer", not EmployeeMotels[data.target].permissions.takeplayer)
    elseif data.currentReq == 'permShowRequests' then
        TriggerServerEvent('pw-motelsbusiness:UpdatePermission', data.target, "showrequests", not EmployeeMotels[data.target].permissions.showrequests)
    elseif data.currentReq == 'permWithdrawMoney' then
        TriggerServerEvent('pw-motelsbusiness:UpdatePermission', data.target, "takeMoney", not EmployeeMotels[data.target].permissions.takeMoney)
    elseif data.currentReq == 'permDepositMoney' then
        TriggerServerEvent('pw-motelsbusiness:UpdatePermission', data.target, "depositMoney", not EmployeeMotels[data.target].permissions.depositMoney)
    elseif data.currentReq == 'permChangeStatus' then
        TriggerServerEvent('pw-motelsbusiness:UpdatePermission', data.target, "updateStatus", not EmployeeMotels[data.target].permissions.updateStatus)
    end
end)

RegisterNUICallback('SendRequest', function(data)
    if data.currentReq == 'reqEmployee' then
        TriggerServerEvent('pw-motelsbusiness:Requests', 'requestEmployee', data.upval)
    elseif data.currentReq == 'reqKey' then
        TriggerServerEvent('pw-motelsbusiness:Requests', 'requestKey', data.upval)
    elseif data.currentReq == 'reqChangeRoom' then
        TriggerServerEvent('pw-motelsbusiness:Requests', 'requestChangeRoom', data.upval)
    elseif data.currentReq == 'reqRefreshTime' then
        TriggerServerEvent('pw-motelsbusiness:Requests', 'requestRefreshTime', data.upval)
    end
end)

RegisterNUICallback('RefreshTime', function(data)
    TimeRefreshFromReception(data)
end)

RegisterNUICallback('ConfirmRequest', function(data)
    if data.currentReq == 'reqEmployee' then
        TriggerServerEvent('pw-motelsbusiness:AcceptRequest', data.current, 'requestEmployee', false)
    elseif data.currentReq == 'reqKey' then
        TriggerServerEvent('pw-motelsbusiness:CreateNewKey', data.current)
        TriggerServerEvent('pw-motelsbusiness:AcceptRequest', data.current, 'requestKey', false)
    elseif data.currentReq == 'reqChangeRoom' then
        ChangeRoomFromReception(data.current)
        TriggerServerEvent('pw-motelsbusiness:AcceptRequest', data.current, 'requestChangeRoom', false)
    elseif data.currentReq == 'reqRefreshTime' then
        TimeRefreshFromReception(data.current)
        TriggerServerEvent('pw-motelsbusiness:AcceptRequest', data.current, 'requestRefreshTime', false)
    end
end)

RegisterNUICallback('RejectRequest', function(data)
    if data.currentReq == 'reqEmployee' then
        TriggerServerEvent('pw-motelsbusiness:RejectRequest', data.current, 'requestEmployee', false)
    elseif data.currentReq == 'reqKey' then
        TriggerServerEvent('pw-motelsbusiness:RejectRequest', data.current, 'requestKey', false)
    elseif data.currentReq == 'reqChangeRoom' then
        TriggerServerEvent('pw-motelsbusiness:RejectRequest', data.current, 'requestChangeRoom', false)
    elseif data.currentReq == 'reqRefreshTime' then
        TriggerServerEvent('pw-motelsbusiness:RejectRequest', data.current, 'requestRefreshTime', false)
    end
end)

RegisterNUICallback('LeftRoom', function ()
    TriggerServerEvent('pw-motelsbusiness:leftRoom')
end)

RegisterNUICallback('GetMotelPrice', function(data,cb)
    local text = ""
    text = _U['motel_sellMotelPrice']:format(tonumber(math.floor(MX[data.motel].price * MX[data.motel].sell)))
    cb(text)
end)

function ChangeRoomFromReception(data)
    local found = true
    if data then
        for _,v in pairs(PlayersMotels) do
            if v.motel == PlayersMotels[data.current].motel and data.motel ~= v.motelid then
                found = false
                break
            end
        end
        Citizen.Wait(100)
        if not found then
            TriggerServerEvent('pw-motelsbusiness:ChangeRoom', data.current, tonumber(data.motel))
        end
    else
        Notification(_U['reception_notplayerfound'])
    end
end

function TimeRefreshFromReception(data)
    if data then
        TriggerServerEvent('pw-motelsbusiness:TimeRefreshFromReception', data.current, data.time, data.method, data.expense)         
    end
end

function SendMessagePlayerFromReception(msg, data)
    if data then
        TriggerServerEvent('pw-motelsbusiness:SendMessagePlayerFromReception', msg, data)
    end
end

function BuildElevator()
    Citizen.CreateThread(function()
        while true do
            local sleep = 1250
            local playercoords = GetEntityCoords(PlayerPedId())
            for key,motel in pairs(MX) do
                if motel.elevators then
                    for i = 1, #motel.elevators do
                        if #(motel.elevators[i].coords - playercoords) <= 3 then
                            sleep = 3
                            HelpNotify(_U['elevator'], motel.elevators[i].coords)
                            if IsControlJustPressed(0, 38) then
                                --OpenElevatorMenu(key, i)
                                TriggerEvent("pw-motel:client:OpenElevatorMenu",key, i)
                            end
                        else
                            if elevator then
                                elevator = false
                            end
                        end
                    end
                end
            end
            Citizen.Wait(sleep)
        end
    end)
end

function OpenBillMenu()
    local data = {}
    inBill = true
    WarMenu.OpenMenu('bill')
    WarMenu.SetSubTitle('bill', _U['bill_menumsg'])
    while inBill do
        WarMenu.Display()
        if (WarMenu.IsMenuOpened('bill')) then
            if MotelsBill[Identifier()] then
                for k,v in pairs(MotelsBill[Identifier()].data) do
                    if WarMenu.MenuButton(_U['bill_menu']:format(v.motel, v.price), 'bills') then
                        WarMenu.SetSubTitle('bills', _U['bill_menu']:format(v.motel, v.price))
                        data.price = v.price
                        data.motel = v.motel
                    end
                end
            else
                WarMenu.CloseMenu()
                Notification(_U['not_bill'])
            end
        elseif (WarMenu.IsMenuOpened('bills')) then
            if WarMenu.Button(_U['reception_accept']) then
                TriggerServerEvent('pw-motelsbusiness:PayBill', data.price, data.motel)
                WarMenu.CloseMenu()
            end
            WarMenu.MenuButton(_U['reception_ignore'], 'bill')
        end
        Citizen.Wait(3)
    end
end


--[[ function OpenElevatorMenu(key, nt)
    local data = {}
    elevator = true 
    WarMenu.OpenMenu('elevator')
    WarMenu.SetSubTitle('elevator', _U['elevator_menu'])
    while elevator do   
        if WarMenu.IsMenuOpened('elevator') then
            if MX[key].elevators then
                for i = 1, #MX[key].elevators do
                    if i ~= nt then
                        if WarMenu.MenuButton(_U['elevator_rooms']:format(i), 'elevator_rooms') then
                            data.kat = i
                            data.coords = MX[key].elevators[i].coords
                            WarMenu.SetSubTitle('elevator_rooms', _U['elevator_rooms']:format(i))
                        end
                    end
                end
            end
        elseif WarMenu.IsMenuOpened('elevator_rooms') then
            TeleportElevator(data)
            WarMenu.CloseMenu()
        end
        WarMenu.Display()
        Citizen.Wait(3)
    end
end ]]


function TeleportElevator(data)
    Notification(_U['elevator_msg']:format(data.kat))
    DoScreenFadeOut(200)
    Citizen.Wait(450)
    SetEntityCoordsNoOffset(PlayerPedId(), data.coords, false, false, false, true)
    DoScreenFadeIn(500)
end


function HelpNotify(text, coords)
    if Cfg.CustomHelpNotify then
        --ShowFloatingHelpNotification(text, coords)
		ESX.ShowHelpNotification(text)
    else
        DrawText3D(text, coords)
    end
end

function ShowFloatingHelpNotification(msg, coords)
    AddTextEntry('ShowFloatingHelpNotification', msg)
	SetFloatingHelpTextWorldPosition(1, coords)
	SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
	BeginTextCommandDisplayHelp('ShowFloatingHelpNotification')
	EndTextCommandDisplayHelp(2, false, false, -1)
end

function DrawText3D(text, coords) 
    SetTextScale(0.35, 0.35) 
    SetTextFont(4) 
    SetTextProportional(1) 
    SetTextColour(255, 255, 255, 215) 
    SetTextEntry("CUSTOM_TEXT") 
    SetTextCentre(true) 
    AddTextComponentString(text) 
    SetDrawOrigin(coords, 0) 
    DrawText(0.0, 0.0) 
    local factor = (string.len(text)) / 370 
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75) 
    ClearDrawOrigin() 
end
