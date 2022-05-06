local GotHit = false
local CurrentBin = nil

function SetBinUsed(BinNumber)
    Config.OpenedBins[BinNumber] = true
    Citizen.SetTimeout(50000, function()
        Config.OpenedBins[BinNumber] = false
    end)
end


RegisterNetEvent('pw-materials:client:search:trash')
AddEventHandler('pw-materials:client:search:trash', function()
    local _, coords, entity2 = exports["bt-target"]:raycast()
    local BinModel = 0
    GotHit = false
    if entity2 then
    local BinModel = GetEntityModel(entity2)
        for k, v in pairs(Config.Dumpsters) do
            if v['Model'] == BinModel then
            GotHit = true
            CurrentBin = GetHashKey(entity2)
            print(CurrentBin)
            end
        end
    end
    if not GotHit then 
        Citizen.Wait(1500)
        CurrentBin = nil, nil
    end


    local BinModel = CurrentBin
    if BinModel ~= nil then
      if not Config.OpenedBins[BinModel] then
        ESX.Progressbar("search-trash", "Đang lục lọi..", math.random(10000, 12500), false, true, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = 'mini@repair',
            anim = 'fixing_a_ped',
            flags = 16,
        }, {}, {}, function() -- Done
            SetBinUsed(BinModel)
            TriggerServerEvent('pw-materials:server:get:reward')
            StopAnimTask(GetPlayerPed(-1), 'mini@repair', "fixing_a_ped", 1.0)
        end, function() -- Cancel
            StopAnimTask(GetPlayerPed(-1), 'mini@repair', "fixing_a_ped", 1.0)
            ESX.ShowNotification("Thất bại!", "error")
        end)
       else
        ESX.ShowNotification("Chỗ này đã được lục lọi..", "error")
      end
    end
end)

RegisterNetEvent('pw-materials:client:crack:parkmeter')
AddEventHandler('pw-materials:client:crack:parkmeter', function()
    local BinModel = CurrentBin
    local _, coords, entity2 = exports["bt-target"]:raycast()
    local BinModel = 0
    GotHit = false
    if entity2 then
    local BinModel = GetEntityModel(entity2)
        for k, v in pairs(Config.Dumpsters) do
            if v['Model'] == BinModel then
            GotHit = true
            CurrentBin = GetHashKey(entity2)

            end
        end
    end
    if not GotHit then 
        Citizen.Wait(1500)
        CurrentBin = nil, nil
    end

    local BinModel = CurrentBin
    if BinModel ~= nil then
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job and ESX.PlayerData.job.name == 'offpolice' then 
            TriggerEvent("ESX:Notify","Cảnh thì không được làm điều này, Lách lách cái đcm","info")
        else
            if not Config.OpenedBins[BinModel] and exports["pw-inventory"]:hasEnoughOfItem("lockpick",1) and IsPedSittingInAnyVehicle(GetPlayerPed(-1)) == false then
                local finished = exports["pw-lockpicking"]:lockpick(1,25,math.random(5,10),5)
                if finished == 100 then 
                    TriggerServerEvent('pw-materials:server:policeAlert', exports['cd_dispatch']:GetPlayerInfo())
                    ESX.Progressbar("search-trash", "Đang lục lọi..", math.random(20000, 30000), false, true, {
                        disableMovement = true,
                        disableCarMovement = false,
                        disableMouse = false,
                        disableCombat = true,
                    }, {
                        animDict = 'mini@repair',
                        anim = 'fixing_a_ped',
                        flags = 16,
                    }, {}, {}, function() -- Done
                        SetMachineUsed(BinModel)
                        TriggerServerEvent('pw-materials:server:crackget:reward')
                        StopAnimTask(GetPlayerPed(-1), 'mini@repair', "fixing_a_ped", 1.0)
                    end, function() -- Cancel
                        StopAnimTask(GetPlayerPed(-1), 'mini@repair', "fixing_a_ped", 1.0)
                        ESX.ShowNotification("Thất bại!", "error")
                    end)
                else
					SetBinCooldown(BinModel)
                    TriggerServerEvent('pw-materials:server:policeAlert', exports['cd_dispatch']:GetPlayerInfo())
                    local random = math.random(1,10)
                    if random <= 4 then
                        TriggerEvent("inventory:removeItem","lockpick",1)
                    end
                end		
            else
                ESX.ShowNotification("Chỗ này đã bị cạy..", "error")
            end
        end
    end
end)

function SetBinUsed(BinNumber)
    Config.OpenedBins[BinNumber] = true
    Citizen.SetTimeout(50000, function()
        Config.OpenedBins[BinNumber] = false
    end)
end

function SetMachineUsed(BinNumber)
    Config.OpenedBins[BinNumber] = true
    Citizen.SetTimeout(300000, function()
        Config.OpenedBins[BinNumber] = false
    end)
end

function SetBinCooldown(BinNumber)
    Config.OpenedBins[BinNumber] = true
    Citizen.SetTimeout(150000, function()
        Config.OpenedBins[BinNumber] = false
    end)
end