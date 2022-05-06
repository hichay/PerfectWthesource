ESX = nil Lib = nil PlayersMotels = {} EmployeeMotels = {} MotelsMoney = {} MotelsBill = {} Trans = {}
if not Cfg.QBCore then TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) if Cfg.charinfosystem then TriggerEvent('mx-base:getSharedObject', function(Library) Lib = Library end) end else TriggerEvent('QBCore:GetObject', function(obj) ESX = obj end) end

function AnalyzeMotel()
    -- Citizen.Wait(tonumber('3000'))
    print('^1 [PW-MOTELS] ^0 : '.._U['database_connection'])
    -- Citizen.Wait(tonumber('8000'))
    local results = FetchSQL('SELECT * FROM motels')
    if results and #results ~= tonumber('0') then
        for i = tonumber('1'), #results do
            PlayersMotels[results[i].owner] = results[i]
            PlayersMotels[results[i].owner].rentcycle = tonumber(results[i].rentcycle)
            PlayersMotels[results[i].owner].requests = json.decode(PlayersMotels[results[i].owner].requests)
        end
    end
    print('^1 [PW-MOTELS] ^0 : '.._U['database_connected'])
    if Cfg.Employee.active then
        local results2 = FetchSQL('SELECT * FROM motels_employee')
        if results2 and #results2 ~= tonumber('0') then
            for i = tonumber('1'), #results2 do
                EmployeeMotels[results2[i].employee] = results2[i]
                EmployeeMotels[results2[i].employee].permissions = json.decode(EmployeeMotels[results2[i].employee].permissions)
            end
        end
        print('^1 [PW-MOTELS] ^0 : '.._U['employee_active'])
    end
    if Cfg.society.active then
        local results3 = FetchSQL('SELECT * FROM motels_money')
        if results3 and #results3 ~= tonumber('0') then
            for i = tonumber('1'), #results3 do
                MotelsMoney[results3[i].motel] = results3[i]
            end
        end
        print('^1 [PW-MOTELS] ^0 : '.._U['society_active'])
    end
    if Cfg.autosave then
        if Cfg.autosaveTime then
            if tonumber(Cfg.autosaveTime) then
                function AutoSave()
                    Citizen.CreateThread(function()
                        Citizen.Wait(Cfg.autosaveTime)
                        SaveAll()
                    end)
                end
                AutoSave()
            else
                print('^1 [PW-MOTELS] ^0 '.._U['wrong_autosave'])
            end
        end
    end
    if Cfg.generalPurchasable then
        local results4 = FetchSQL("SELECT * FROM motels_owner")
        if results4 and #results4 ~= tonumber('0') then
            for k,v in pairs(MX) do
                for i = tonumber('1'), #(results4) do
                    if results4[i].motel then
                        if k == results4[i].motel then
                            MX[k].owner = results4[i].owner
                        end
                    end
                end
            end
        end 
    end
    
    if Cfg.bill.active then
        local results5 = FetchSQL("SELECT * FROM motels_bill")
        if results5 and #results5 ~= tonumber('0') then
            for i = tonumber('1'), #(results5) do
                MotelsBill[results5[i].owner] = results5[i]
                MotelsBill[results5[i].owner].data = json.decode(MotelsBill[results5[i].owner].data)
            end
        end 
    end
    if Cfg.Employee.autosalary then
        EmployeeAutoSalary()
    end
    print('^1 [PW-MOTELS]^0 : ^3The script will not work properly if there is a player inside! ^0')
    Wait(700)
    print([[
        ^1[PW-MOTELS]^0 ^5Checking your version...^0
    ]])
    Wait(500)
    local CurrentVer = LoadResourceFile(GetCurrentResourceName(), 'version.json')
    if CurrentVer then
        local CurrentVerData = json.decode(CurrentVer)
        PerformHttpRequest('https://raw.githubusercontent.com/MOXHAFOREVA/pw-motelsbusiness_ver/main/version.json', function(code, res, headers)
            if code == 200 then
                local newVerData = json.decode(res)
                if newVerData.version == CurrentVerData.version then
                    print('^1 [PW-MOTELS] ^0 ^2You are using the latest version of the motel.^0')
                else
                    print(([[
                        ---^1[PW-MOTELS]---
                        ^3The motel version u are using is outdated. Please contact me.
                        New Ver: %s
                        Current Ver: %s
                        New Ver Description: ^4%s ^0
                    ]]):format(newVerData.version, CurrentVerData.version, "\n"..newVerData.description))
                end
            end
        end)
    end
end

CreateThread(AnalyzeMotel)

if not Cfg.QBCore then
    RegisterNetEvent('esx:playerLoaded')
    AddEventHandler('esx:playerLoaded', function(id, xPlayer)
        Citizen.Wait(tonumber('7000'))
        if PlayersMotels[Identifier(xPlayer)] then
            if PlayersMotels[Identifier(xPlayer)].rentcycle and PlayersMotels[Identifier(xPlayer)].rentcycle >= tonumber('0') then
                RentCycle(xPlayer)
            elseif PlayersMotels[Identifier(xPlayer)].rentcycle and PlayersMotels[Identifier(xPlayer)].rentcycle == tonumber('0') then
                DeleteMotel(Identifier(xPlayer))
            end
        end
        if Cfg.Employee.active then
            if EmployeeMotels[Identifier(xPlayer)] then
                if not Cfg.Employee.reqingame then
                    if EmployeeMotels[Identifier(xPlayer)].pay >= tonumber('0') then
                        if Cfg.society.takeSalary then
                            if Cfg.society.obligatorySalary then
                                MotelsRemoveMoney(EmployeeMotels[Identifier(xPlayer)].motel, EmployeeMotels[Identifier(xPlayer)].pay)
                                if Cfg.Employee.salaryMethod == 'bank' then
                                    AddAccountMoney(id, 'bank', tonumber(EmployeeMotels[Identifier(xPlayer)].pay))
                                elseif Cfg.Employee.salaryMethod == 'cash' then
                                    AddMoney(id, tonumber(EmployeeMotels[Identifier(xPlayer)].pay))
                                else
                                    print('^1 [PW-MOTELS] ^0 '.._U['employee_notsalaryMethod'])
                                end
                            else
                                if MotelsMoney[EmployeeMotels[Identifier(xPlayer)].motel] and MotelsMoney[EmployeeMotels[Identifier(xPlayer)].motel].money >= EmployeeMotels[Identifier(xPlayer)].pay then
                                    MotelsRemoveMoney(EmployeeMotels[Identifier(xPlayer)].motel, EmployeeMotels[Identifier(xPlayer)].pay)
                                    if Cfg.Employee.salaryMethod == 'bank' then
                                        AddAccountMoney(id, 'bank', tonumber(EmployeeMotels[Identifier(xPlayer)].pay))
                                    elseif Cfg.Employee.salaryMethod == 'cash' then
                                        AddMoney(id, tonumber(EmployeeMotels[Identifier(xPlayer)].pay))
                                    else
                                        print('^1 [PW-MOTELS] ^0 '.._U['employee_notsalaryMethod'])
                                    end
                                end
                            end
                        else
                            if Cfg.Employee.salaryMethod == 'bank' then
                                AddAccountMoney(id, 'bank', tonumber(EmployeeMotels[Identifier(xPlayer)].pay))
                            elseif Cfg.Employee.salaryMethod == 'cash' then
                                AddMoney(id, tonumber(EmployeeMotels[Identifier(xPlayer)].pay))
                            else
                                print('^1 [PW-MOTELS] ^0 '.._U['employee_notsalaryMethod'])
                            end
                        end
                        EmployeeMotels[Identifier(xPlayer)].pay = tonumber('0')
                    end
                end
            end
        end
        TriggerClientEvent('pw-motelsbusiness:SendData', id, MX)
        TriggerEvent('pw-motelsbusiness:GetPlayersData')
        TriggerEvent('pw-motelsbusiness:GetEmployeesData')
        TriggerEvent('pw-motelsbusiness:GetSocietyData')
        TriggerEvent('pw-motelsbusiness:GetBillsData')
        for i = 1, #Trans do
            TriggerClientEvent('pw-motelsbusiness:AddTransaction', id, Trans[i].name, Trans[i].data)
        end
    end)
else
    RegisterNetEvent('pw-motelsbusiness:qbload')
    AddEventHandler('pw-motelsbusiness:qbload', function (source)
        local id = source
        local xPlayer = GetPlayerFromId(id)
        Citizen.Wait(tonumber('7000'))
        if PlayersMotels[Identifier(xPlayer)] then
            if PlayersMotels[Identifier(xPlayer)].rentcycle and PlayersMotels[Identifier(xPlayer)].rentcycle >= tonumber('0') then
                RentCycle(xPlayer)
            elseif PlayersMotels[Identifier(xPlayer)].rentcycle and PlayersMotels[Identifier(xPlayer)].rentcycle == tonumber('0') then
                DeleteMotel(Identifier(xPlayer))
            end
        end
        if Cfg.Employee.active then
            if EmployeeMotels[Identifier(xPlayer)] then
                if not Cfg.Employee.reqingame then
                    if EmployeeMotels[Identifier(xPlayer)].pay >= tonumber('0') then
                        if Cfg.society.takeSalary then
                            if Cfg.society.obligatorySalary then
                                MotelsRemoveMoney(EmployeeMotels[Identifier(xPlayer)].motel, EmployeeMotels[Identifier(xPlayer)].pay)
                                if Cfg.Employee.salaryMethod == 'bank' then
                                    AddAccountMoney(id, 'bank', tonumber(EmployeeMotels[Identifier(xPlayer)].pay))
                                elseif Cfg.Employee.salaryMethod == 'cash' then
                                    AddMoney(id, tonumber(EmployeeMotels[Identifier(xPlayer)].pay))
                                else
                                    print('^1 [PW-MOTELS] ^0 '.._U['employee_notsalaryMethod'])
                                end
                            else    
                                if MotelsMoney[EmployeeMotels[Identifier(xPlayer)].motel] and MotelsMoney[EmployeeMotels[Identifier(xPlayer)].motel].money >= EmployeeMotels[Identifier(xPlayer)].pay then
                                    MotelsRemoveMoney(EmployeeMotels[Identifier(xPlayer)].motel, EmployeeMotels[Identifier(xPlayer)].pay)
                                    if Cfg.Employee.salaryMethod == 'bank' then
                                        AddAccountMoney(id, 'bank', tonumber(EmployeeMotels[Identifier(xPlayer)].pay))
                                    elseif Cfg.Employee.salaryMethod == 'cash' then
                                        AddMoney(id, tonumber(EmployeeMotels[Identifier(xPlayer)].pay))
                                    else
                                        print('^1 [PW-MOTELS] ^0 '.._U['employee_notsalaryMethod'])
                                    end
                                end
                            end
                        else
                            if Cfg.Employee.salaryMethod == 'bank' then
                                AddAccountMoney(id, 'bank', tonumber(EmployeeMotels[Identifier(xPlayer)].pay))
                            elseif Cfg.Employee.salaryMethod == 'cash' then
                                AddMoney(id, tonumber(EmployeeMotels[Identifier(xPlayer)].pay))
                            else
                                print('^1 [PW-MOTELS] ^0 '.._U['employee_notsalaryMethod'])
                            end
                        end
                        EmployeeMotels[Identifier(xPlayer)].pay = tonumber('0')
                    end
                end
            end
        end
        TriggerClientEvent('pw-motelsbusiness:SendData', id, MX)
        TriggerEvent('pw-motelsbusiness:GetPlayersData')
        TriggerEvent('pw-motelsbusiness:GetEmployeesData')
        TriggerEvent('pw-motelsbusiness:GetSocietyData')
        TriggerEvent('pw-motelsbusiness:GetBillsData')
        for i = 1, #Trans do
            TriggerClientEvent('pw-motelsbusiness:AddTransaction', id, Trans[i].name, Trans[i].data)
        end
    end)
end

function MotelsAddMoney(motelKEY, count)
    local found = false
    if motelKEY and count then
        for k,_ in pairs(MX) do
            if k == motelKEY then
                found = true
                break 
            end
        end
        if found then
            if MotelsMoney[motelKEY] and MotelsMoney[motelKEY].money then
                local amount = MotelsMoney[motelKEY].money + count
                MotelsMoney[motelKEY].money = amount
            else
                MotelsMoney[motelKEY] = {
                    motel = motelKEY,
                    money = count
                }
            end
        else
            print('^1 [PW-MOTELS] ^0 '.._U['society_notMotel'])
        end
    end
end

function MotelsRemoveMoney(motelKEY, count)
    local found = false
    if motelKEY and count then
        for k,_ in pairs(MX) do
            if k == motelKEY then
                found = true
                break 
            end
        end
        if found then
            if MotelsMoney[motelKEY] and MotelsMoney[motelKEY].money then
                local amount = MotelsMoney[motelKEY].money - count 
                MotelsMoney[motelKEY].money = amount
            else
                MotelsMoney[motelKEY] = {
                    motel = motelKEY,
                    money = count
                }
            end
        else
            print('^1 [PW-MOTELS] ^0 '.._U['society_notMotel'])
        end
    end
    TriggerEvent('pw-motelsbusiness:GetSocietyData')
end

function MotelsSetMoney(motelKEY, count)
    local found = false
    if motelKEY and count then
        for k,_ in pairs(MX) do
            if k == motelKEY then
                found = true
                break 
            end
        end
        if found then
            if MotelsMoney[motelKEY] then
                MotelsMoney[motelKEY].money = count
            else
                MotelsMoney[motelKEY] = {
                    motel = motelKEY,
                    money = count
                }
            end
        else
            print('^1 [PW-MOTELS] ^0 '.._U['society_notMotel'])
        end
    end
    TriggerEvent('pw-motelsbusiness:GetSocietyData')
end

function EmployeeAutoSalary()
    Citizen.CreateThread(function()
        if tonumber(Cfg.Employee.autosalary) then
            print('^1 [PW-MOTELS] ^0 '.._U['employee_autosystemactive'])
            AutoSalary()
        else
            print('^1 [PW-MOTELS] ^0 '.._U['employee_notauthautotime'])
        end
    end)
end

RegisterNetEvent('pw-motelsbusiness:PayBill')
AddEventHandler('pw-motelsbusiness:PayBill', function(price, motel)
    local src = source
    if src then
        local player = GetPlayerFromId(src)
        if player then
           if MotelsBill[Identifier(player)] then
                for k,v in pairs(MotelsBill[Identifier(player)].data) do
                    if v.motel == motel then
                        if (GetMoney(src) >= price) then
                            SendLog(src, _U['log_bill']:format(GetPlayerName(src), motel:upper(), tostring(price)).."\n"..GetProperty(src, _U['log_player']), _U['log_billX'], tonumber('6347265'), Cfg.LogWebHooks['Pay Bill'])
                            table.remove(MotelsBill[Identifier(player)].data, k)
                            RemoveMoney(src, price)
                            TriggerEvent('pw-motelsbusiness:GetBillsData')
                            MotelsAddMoney(motel, price)
                            Notification(src, _U['bill_paid']:format(tostring(price)))
                        else
                            Notification(src, _U['society_notEnoughtMoney'])
                            break
                        end 
                    end
                end
           end
        end
    end
end)

function GetPlayerFromId(source)
    if Cfg.QBCore then
        return ESX.Functions.GetPlayer(tonumber(source)) and ESX.Functions.GetPlayer(tonumber(source)).PlayerData or false
    else
        return ESX.GetPlayerFromId(tonumber(source))
    end
end

RegisterNetEvent('pw-motelsbusiness:UpdateOpened')
AddEventHandler('pw-motelsbusiness:UpdateOpened', function(key, upval)
    MX[key].opened = upval
    TriggerClientEvent('pw-motelsbusiness:UpdateOpened', tonumber('-1'), key, upval)
end)

RegisterNetEvent('pw-motelsbusiness:CreateBill')
AddEventHandler('pw-motelsbusiness:CreateBill', function(playerID, motel, price)
    local founded = false
    if playerID then
        local player = GetPlayerFromId(playerID)
        if (player) then
            if (MotelsBill[Identifier(player)] and MotelsBill[Identifier(player)].data) then
                for k,v in pairs(MotelsBill[Identifier(player)].data) do
                    if v.motel == motel then
                        MotelsBill[Identifier(player)].data[k].price = MotelsBill[Identifier(player)].data[k].price + price
                        founded = true
                        break
                    end
                end 
                if (not founded) then
                    table.insert(MotelsBill[Identifier(player)].data, {
                        motel = motel,
                        price = price
                    })
                end
            else
                MotelsBill[Identifier(player)] = {
                    owner = Identifier(player),
                    data = {
                        {
                            motel = motel, 
                            price = price
                        },
                    }
                }
            end
            if Cfg.gcphone then
                TriggerEvent('esx_addons_gcphone:motelSendMessage', playerID, motel..' '.._U['motel_admin'], _U['bill_create']:format(price))
            else
                Notification(playerID, _U['bill_create']:format(price))
            end
            SendLog(playerID, _U['log_createBill']:format(GetPlayerName(playerID), motel:upper(), tostring(price)).."\n"..GetProperty(playerID, _U['log_player']), _U['log_createBillX'], tonumber('16729856'), Cfg.LogWebHooks['Create Bill'])
            TriggerEvent('pw-motelsbusiness:GetBillsData')
        end
    end
end)

RegisterNetEvent('pw-motelsbusiness:SetMoney')
AddEventHandler('pw-motelsbusiness:SetMoney', function(motelID, money, method)
    local src = source
    local player = GetPlayerFromId(src)
    if player then
        if method == tonumber('1') then
            if GetMoney(src) >= tonumber(money) then
                RemoveMoney(src, tonumber(money))
                local para = MotelsMoney[motelID] and MotelsMoney[motelID].money + money or money
                MotelsSetMoney(motelID, tonumber(para))
                Notification(src, _U['society_successDeposit']:format(money))
                SendLog(src, _U['log_addDepositeMoney']:format(GetPlayerName(src), string.upper(motelID), money).."\n"..GetProperty(src, _U['motel_owner']), _U['log_deposite'], tonumber('10038562'), Cfg.LogWebHooks['Deposit Money'])
                local veri = PlayerName(player)
                veri.amount = money
                veri.motel = motelID
                TriggerEvent('pw-motelsbusiness:SaveTransaction', 'deposit', veri)
            else
                Notification(src, _U['not_money'])
            end
        elseif method == tonumber('2') then
            if MotelsMoney[motelID] and MotelsMoney[motelID].money >= tonumber(money) then
                local para = MotelsMoney[motelID] and MotelsMoney[motelID].money - money or money
                AddMoney(src, tonumber(money))
                MotelsSetMoney(motelID, tonumber(para))
                Notification(src, _U['society_successWithdraw']:format(money))
                SendLog(src, _U['log_withdrawMoney']:format(GetPlayerName(src), string.upper(motelID), money).."\n"..GetProperty(src, _U['motel_owner']), _U['log_withdraw'], tonumber('9807270'), Cfg.LogWebHooks['Withdraw Money'])
                local veri = PlayerName(player)
                veri.amount = money
                veri.motel = motelID
                TriggerEvent('pw-motelsbusiness:SaveTransaction', 'withdraw', veri)
            else
                Notification(src, _U['society_notEnoughtDeposit'])
            end
        end
    end
end)

RegisterNetEvent('pw-motelsbusiness:SaveTransaction')
AddEventHandler('pw-motelsbusiness:SaveTransaction', function(name, data)
    table.insert(Trans, {name = name, data = data})
    TriggerClientEvent('pw-motelsbusiness:AddTransaction', -1, name, data)
end)

function AutoSalary()
    Citizen.CreateThread(function()
        Citizen.Wait(Cfg.Employee.autosalary)
        if not Cfg.Employee.reqingame then
            if next(EmployeeMotels) then
                for k,v in pairs(EmployeeMotels) do
                    local Player = GetPlayerFrom(k)
                    if Player then
                        if Cfg.society.takeSalary then
                            if Cfg.society.obligatorySalary then
                                MotelsRemoveMoney(v.motel, tonumber(v.salary))
                                if Cfg.Employee.salaryMethod == 'bank' then
                                    AddAccountMoney(Player.source, 'bank', tonumber(v.salary))
                                elseif Cfg.Employee.salaryMethod == 'cash' then
                                    AddMoney(Player.source, tonumber(v.salary))
                                else
                                    print('^1 [PW-MOTELS] ^0 '.._U['employee_notsalaryMethod'])
                                end
                                if Cfg.gcphone then
                                    TriggerEvent('esx_addons_gcphone:motelSendMessage', Player.source, EmployeeMotels[k].motel..' '.._U['motel_admin'], _U['employee_AutoPay']:format(v.salary))
                                else
                                    Notification(Player.source, _U['employee_AutoPay']:format(v.salary))
                                end
                            else
                                if MotelsMoney[v.motel] and MotelsMoney[v.motel].money >= EmployeeMotels[v.motel].pay then
                                    MotelsRemoveMoney(v.motel, v.salary)
                                    if Cfg.Employee.salaryMethod == 'bank' then
                                        AddAccountMoney(Player.source, 'bank', tonumber(v.salary))
                                    elseif Cfg.Employee.salaryMethod == 'cash' then
                                        AddMoney(Player.source, tonumber(v.salary))
                                    else
                                        print('^1 [PW-MOTELS] ^0 '.._U['employee_notsalaryMethod'])
                                    end
                                    if Cfg.gcphone then
                                        TriggerEvent('esx_addons_gcphone:motelSendMessage', Player.source, EmployeeMotels[k].motel..' '.._U['motel_admin'], _U['employee_AutoPay']:format(v.salary))
                                    else
                                        Notification(Player.source, _U['employee_AutoPay']:format(v.salary))
                                    end
                                else
                                    Notification(Player.source, _U['society_notEnoughtMoney'])
                                end
                            end
                        else
                            if Cfg.Employee.salaryMethod == 'bank' then
                                AddAccountMoney(Player.source, 'bank', tonumber(v.salary))
                            elseif Cfg.Employee.salaryMethod == 'cash' then
                                AddMoney(Player.source, tonumber(v.salary))
                            else
                                print('^1 [PW-MOTELS] ^0 '.._U['employee_notsalaryMethod'])
                            end
                            if Cfg.gcphone then
                                TriggerEvent('esx_addons_gcphone:motelSendMessage', Player.source, EmployeeMotels[k].motel..' '.._U['motel_admin'], _U['employee_AutoPay']:format(v.salary))
                            else
                                Notification(Player.source, _U['employee_AutoPay']:format(v.salary))
                            end
                        end
                    else
                        local sal = v.salary + v.pay
                        ExecuteSQL('UPDATE motels_employee SET pay = "'..sal..'" WHERE employee = "'..k..'"')
                        EmployeeMotels[k].pay = v.salary + v.pay
                    end
                end
            end
        elseif Cfg.Employee.reqingame then
            if next(EmployeeMotels) then
                for k,v in pairs(EmployeeMotels) do
                    local Player = GetPlayerFrom(k)
                    if Player then
                        if Cfg.Employee.salaryMethod == 'bank' then
                            AddAccountMoney(Player.source, 'bank', tonumber(v.salary))
                        elseif Cfg.Employee.salaryMethod == 'cash' then
                            addMoney(Player.source, tonumber(v.salary))
                        else
                            print('^1 [PW-MOTELS] ^0 '.._U['employee_notsalaryMethod'])
                        end
                        if Cfg.gcphone then
                            TriggerEvent('esx_addons_gcphone:motelSendMessage', Player.source, EmployeeMotels[k].motel..' '.._U['motel_admin'], _U['employee_AutoPay']:format(v.salary))
                        else
                            Notification(Player.source, _U['employee_AutoPay']:format(v.salary))
                        end
                    end
                end
            end
        end
        AutoSalary()
    end)
end

RegisterNetEvent('pw-motelsbusiness:GetPlayersData')
AddEventHandler('pw-motelsbusiness:GetPlayersData', function()
    TriggerClientEvent('pw-motelsbusiness:GetPlayersData', tonumber('-1'), PlayersMotels)
end)

RegisterNetEvent('pw-motelsbusiness:GetSocietyData')
AddEventHandler('pw-motelsbusiness:GetSocietyData', function()
    TriggerClientEvent('pw-motelsbusiness:GetSocietyData', tonumber('-1'), MotelsMoney)
end)

RegisterNetEvent('pw-motelsbusiness:GetEmployeesData')
AddEventHandler('pw-motelsbusiness:GetEmployeesData', function()
    TriggerClientEvent('pw-motelsbusiness:GetEmployeesData', tonumber('-1'), EmployeeMotels)
end)

RegisterNetEvent('pw-motelsbusiness:GetBillsData')
AddEventHandler('pw-motelsbusiness:GetBillsData', function()
    TriggerClientEvent('pw-motelsbusiness:GetBillsData', tonumber('-1'), MotelsBill)
end)

RegisterNetEvent('pw-motelsbusiness:GetConfig')
AddEventHandler('pw-motelsbusiness:GetConfig', function()
    TriggerClientEvent('pw-motelsbusiness:GetConfig', tonumber('-1'), Cfg, _U)
end)

RegisterNetEvent('pw-motelsbusiness:Sync')
AddEventHandler('pw-motelsbusiness:Sync', function(method, key, value, upval)
    MX[key][method][value].locked = upval
    TriggerClientEvent('pw-motelsbusiness:Sync', tonumber('-1'), method, key, value, upval)
end)

RegisterNetEvent('pw-motelsbusiness:Requests')
AddEventHandler('pw-motelsbusiness:Requests', function(method, upval)
    local src = source
    if src then
        local player = GetPlayerFromId(src)
        if player and upval ~= nil then
            if PlayersMotels[Identifier(player)] then
                PlayersMotels[Identifier(player)].requests[method] = upval
                TriggerEvent('pw-motelsbusiness:GetPlayersData')
            else
                Notification(src, _U['society_notData'])
            end
        end
    end
end)

AddEventHandler('playerDropped', function(reason)
    local src = source
    local player = GetPlayerFromId(src)
    if player then
        if PlayersMotels[Identifier(player)] then
            local result = FetchSQL("SELECT motelid FROM motels WHERE owner = '"..Identifier(player).."'")
            if result and result[tonumber('1')] then
                ExecuteSQL("UPDATE motels SET suspended = '"..PlayersMotels[Identifier(player)].suspended.."', pay = '"..PlayersMotels[Identifier(player)].pay.."', motel = '"..PlayersMotels[Identifier(player)].motel.."', motelid = '"..PlayersMotels[Identifier(player)].motelid.."', rentcycle = '"..tostring(PlayersMotels[Identifier(player)].rentcycle).."', uniq = '"..PlayersMotels[Identifier(player)].uniq.."', requests = '"..json.encode(PlayersMotels[Identifier(player)].requests).."' WHERE owner = '"..Identifier(player).."'")
            else
                ExecuteSQL("INSERT INTO motels (owner, pay, motel, motelid, rentcycle, uniq, requests, suspended) VALUES ('"..Identifier(player).."', '"..PlayersMotels[Identifier(player)].pay.."', '"..PlayersMotels[Identifier(player)].motel.."', '"..PlayersMotels[Identifier(player)].motelid.."', '"..PlayersMotels[Identifier(player)].rentcycle.."', '"..PlayersMotels[Identifier(player)].uniq.."', '"..json.encode(PlayersMotels[Identifier(player)].requests).."', '"..PlayersMotels[Identifier(player)].suspended.."')")
            end
            local time = PlayersMotels[Identifier(player)].rentcycle/tonumber('60000')
            print('^1 [PW-MOTELS] ^0 '..Identifier(player).._U['playerdropped_SaveRent']:format(math.floor(time)))
        end
        if Cfg.Employee.active then
            if EmployeeMotels[Identifier(player)] then
                local result2 = FetchSQL("SELECT motel FROM motels_employee WHERE employee = '"..Identifier(player).."'")
                if result2 and result2[tonumber('1')] then
                    ExecuteSQL("UPDATE motels_employee SET motel = '"..EmployeeMotels[Identifier(player)].motel.."', salary = '"..EmployeeMotels[Identifier(player)].salary.."', pay = '"..EmployeeMotels[Identifier(player)].pay.."', permissions = '"..json.encode(EmployeeMotels[Identifier(player)].permissions).."' WHERE employee = '"..Identifier(player).."'")
                else
                    ExecuteSQL("INSERT INTO motels_employee (employee, motel, salary, pay, permissions) VALUES ('"..Identifier(player).."', '"..EmployeeMotels[Identifier(player)].motel.."', '"..EmployeeMotels[Identifier(player)].salary.."', '"..EmployeeMotels[Identifier(player)].pay.."', '"..json.encode(EmployeeMotels[Identifier(player)].permissions).."')")
                end
            end
        end
        if Cfg.society.active then
            if next(MotelsMoney) then
                for k,v in pairs(MotelsMoney) do
                    local result3 = FetchSQL("SELECT motel FROM motels_money WHERE motel = '"..k.."'")
                    if result3 and result3[tonumber('1')] then
                        ExecuteSQL("UPDATE motels_money SET money = '"..v.money.."' WHERE motel = '"..k.."'")
                    else
                        ExecuteSQL("INSERT INTO motels_money (motel, money) VALUES ('"..k.."', '"..v.money.."')")
                    end
                end
            end
        end
        if Cfg.bill.active then
            if MotelsBill[Identifier(player)] then
                local result4 = FetchSQL("SELECT owner FROM motels_bill WHERE owner = '"..Identifier(player).."'")
                if result4 and result4[tonumber('1')] then
                    ExecuteSQL("UPDATE motels_bill SET data = '"..json.encode(MotelsBill[Identifier(player)].data).."'")
                else
                    ExecuteSQL("INSERT INTO motels_bill (owner, data) VALUES ('"..Identifier(player).."', '"..json.encode(MotelsBill[Identifier(player)].data).."')")
                end
            end
        end
        print('^1 [PW-MOTELS] ^0 '.._U['playerdropped_UpdatedPlayer']:format(Identifier(player)))
    else
        if GetPlayerIdentifiers(src) and GetPlayerIdentifiers(src)[tonumber('1')] then
            print('^1 [PW-MOTELS] ^0 '..GetPlayerIdentifiers(src)[tonumber('1')].._U['playerdropped_NotFindedESX'])
        end
    end
end)

-- test command
-- RegisterCommand('tests', function(source)
--     local xPlayer = GetPlayerFromId(source)
--     local id = source
--     if PlayersMotels[Identifier(xPlayer)] then
--         if PlayersMotels[Identifier(xPlayer)].rentcycle and PlayersMotels[Identifier(xPlayer)].rentcycle >= tonumber('0') then
--             RentCycle(xPlayer)
--         elseif PlayersMotels[Identifier(xPlayer)].rentcycle and PlayersMotels[Identifier(xPlayer)].rentcycle == tonumber('0') then
--             DeleteMotel(Identifier(xPlayer))
--         end
--     end
--     if Cfg.Employee.active then
--         if EmployeeMotels[Identifier(xPlayer)] then
--             if not Cfg.Employee.reqingame then
--                 if EmployeeMotels[Identifier(xPlayer)].pay >= tonumber('0') then
--                     if Cfg.society.takeSalary then
--                         if Cfg.society.obligatorySalary then
--                             MotelsRemoveMoney(EmployeeMotels[Identifier(xPlayer)].motel, EmployeeMotels[Identifier(xPlayer)].pay)
--                             if Cfg.Employee.salaryMethod == 'bank' then
--                                 AddAccountMoney(id, 'bank', tonumber(EmployeeMotels[Identifier(xPlayer)].pay))
--                             elseif Cfg.Employee.salaryMethod == 'cash' then
--                                 AddMoney(id, tonumber(EmployeeMotels[Identifier(xPlayer)].pay))
--                             else
--                                 print('^1 [PW-MOTELS] ^0 '.._U['employee_notsalaryMethod'])
--                             end
--                         else
--                             if MotelsMoney[EmployeeMotels[Identifier(xPlayer)].motel] and MotelsMoney[EmployeeMotels[Identifier(xPlayer)].motel].money >= EmployeeMotels[Identifier(xPlayer)].pay then
--                                 MotelsRemoveMoney(EmployeeMotels[Identifier(xPlayer)].motel, EmployeeMotels[Identifier(xPlayer)].pay)
--                                 if Cfg.Employee.salaryMethod == 'bank' then
--                                     AddAccountMoney(id, 'bank', tonumber(EmployeeMotels[Identifier(xPlayer)].pay))
--                                 elseif Cfg.Employee.salaryMethod == 'cash' then
--                                     AddMoney(id, tonumber(EmployeeMotels[Identifier(xPlayer)].pay))
--                                 else
--                                     print('^1 [PW-MOTELS] ^0 '.._U['employee_notsalaryMethod'])
--                                 end
--                             end
--                         end
--                     else
--                         if Cfg.Employee.salaryMethod == 'bank' then
--                             AddAccountMoney(id, 'bank', tonumber(EmployeeMotels[Identifier(xPlayer)].pay))
--                         elseif Cfg.Employee.salaryMethod == 'cash' then
--                             AddMoney(id, tonumber(EmployeeMotels[Identifier(xPlayer)].pay))
--                         else
--                             print('^1 [PW-MOTELS] ^0 '.._U['employee_notsalaryMethod'])
--                         end
--                     end
--                     EmployeeMotels[Identifier(xPlayer)].pay = tonumber('0')
--                 end
--             end
--         end
--     end
--     TriggerClientEvent('pw-motelsbusiness:SendData', id, MX)
--     TriggerEvent('pw-motelsbusiness:GetPlayersData')
--     TriggerEvent('pw-motelsbusiness:GetEmployeesData')
--     TriggerEvent('pw-motelsbusiness:GetSocietyData')
--     TriggerEvent('pw-motelsbusiness:GetBillsData')
--     for i = 1, #Trans do
--         TriggerClientEvent('pw-motelsbusiness:AddTransaction', id, Trans[i].name, Trans[i].data)
--     end
-- end)

if Cfg.saveCommand then
    RegisterCommand(Cfg.saveCommand, function(svr)
        if svr == tonumber('0') then
            if next(PlayersMotels) then
                local total = 0
                for k,v in pairs(PlayersMotels) do
                    total = total+1
                    local result = FetchSQL("SELECT owner FROM motels WHERE owner = '"..k.."'")
                    if result and result[tonumber('1')] then
                        ExecuteSQL("UPDATE motels SET suspended = '"..v.suspended.."', pay = '"..v.pay.."', motel = '"..v.motel.."', motelid = '"..v.motelid.."', rentcycle = '"..tostring(v.rentcycle).."', uniq = '"..v.uniq.."', requests = '"..json.encode(v.requests).."' WHERE owner = '"..k.."'")
                    else
                        ExecuteSQL("INSERT INTO motels (owner, pay, motel, motelid, rentcycle, uniq, requests, suspended) VALUES ('"..k.."', '"..v.pay.."', '"..v.motel.."', '"..v.motelid.."', '"..tostring(v.rentcycle).."', '"..v.uniq.."', '"..json.encode(v.requests).."', '"..v.suspended.."')")
                    end
                end
                print('^1 [PW-MOTELS] ^0 Saved ^2'..total..'^1 Customer(s) ^0')
            end
            if Cfg.Employee.active then
                if next(EmployeeMotels) then
                    local total = 0
                    for k,v in pairs(EmployeeMotels) do
                        total = total+1
                        local result = FetchSQL("SELECT motel FROM motels_employee WHERE employee = '"..k.."'")
                        if result and result[tonumber('1')] then
                            ExecuteSQL("UPDATE motels_employee SET motel = '"..v.motel.."', salary = '"..v.salary.."', pay = '"..v.pay.."', permissions = '"..json.encode(v.permissions).."' WHERE employee = '"..k.."'")
                        else
                            ExecuteSQL("INSERT INTO motels_employee (employee, motel, salary, pay, permissions) VALUES ('"..k.."', '"..v.motel.."', '"..v.salary.."', '"..v.pay.."', '"..json.encode(v.permissions).."')")
                        end
                    end
                    print('^1 [PW-MOTELS] ^0 Saved ^2'..total..'^1 Employee(s) ^0')
                end
            end
            if Cfg.society.active then
                if next(MotelsMoney) then
                    for k,v in pairs(MotelsMoney) do
                        local result = FetchSQL("SELECT motel FROM motels_money WHERE motel = '"..k.."'")
                        if result and result[tonumber('1')] then
                            ExecuteSQL("UPDATE motels_money SET money = '"..v.money.."' WHERE motel = '"..k.."'")
                        else
                            ExecuteSQL("INSERT INTO motels_money (motel, money) VALUES ('"..k.."', '"..v.money.."')")
                        end
                    end
                end
            end
            if Cfg.bill.active then
                if next(MotelsBill) then
                    local total = 0
                    for k,v in pairs(MotelsBill) do
                        total = total+1
                        local result = FetchSQL("SELECT owner FROM motels_bill WHERE owner = '"..k.."'")
                        if result and result[tonumber('1')] then
                            ExecuteSQL("UPDATE motels_bill SET data = '"..json.encode(v.data).."'")
                        else
                            ExecuteSQL("INSERT INTO motels_bill (owner, data) VALUES ('"..k.."', '"..json.encode(v.data).."')")
                        end
                    end 
                    print('^1 [PW-MOTELS] ^0 Saved ^2'..total..'^1 Bill(s) ^0')
                end
            end
        end
    end)
end

RegisterNetEvent('pw-motelsbusiness:Print')
AddEventHandler('pw-motelsbusiness:Print', function(string)
    print(string)
end)

RegisterNetEvent('pw-motelsbusiness:GetCid')
AddEventHandler('pw-motelsbusiness:GetCid', function (ply)
    local src = source
    local player = GetPlayerFromId(ply)
    if player then
        local ret = Identifier(player) and type(Identifier(player)) ~= 'table' and Identifier(player) or 'empty'
        TriggerClientEvent('pw-motelsbusiness:SetCallbackData', src, ret)
    else
        TriggerClientEvent('pw-motelsbusiness:SetCallbackData', src, 'empty')
    end
end)

if not Cfg.QBCore then
    ESX.RegisterServerCallback('pw-motelsbusiness:checkPropertyDataStore', function(source, cb)
        local xPlayer = GetPlayerFromId(source)
        local foundStore = false
    
        TriggerEvent('esx_datastore:getDataStore', 'property', Identifier(xPlayer), function(store)
            foundStore = true
        end)
        cb(foundStore)
    end)
    
    ESX.RegisterServerCallback('pw-motelsbusiness:GetDressing', function(source, cb)
        local xPlayer  = GetPlayerFromId(source)
        while not xPlayer do xPlayer = GetPlayerFromId(source); Citizen.Wait(tonumber('0')); end
        local lab = false
        TriggerEvent('esx_datastore:getDataStore', 'property', Identifier(xPlayer), function(store)
          local count  = store.count('dressing')
          local labels = {}
          for i=tonumber('1'), count, tonumber('1') do
            local entry = store.get('dressing', i)
            table.insert(labels, entry.label)
          end
          lab = labels
        end) 
        while not lab do Citizen.Wait(tonumber('0')); end
        cb(lab)
    end)
    
    ESX.RegisterServerCallback('pw-motelsbusiness:getOutfit', function(source, cb, num)
        local xPlayer  = GetPlayerFromId(source)
        while not xPlayer do xPlayer = GetPlayerFromId(source); Citizen.Wait(tonumber('0')); end
        local lab = false
        TriggerEvent('esx_datastore:getDataStore', 'property', Identifier(xPlayer), function(store)
          local outfit = store.get('dressing', num)
          lab = outfit.skin
        end)
        while not lab do Citizen.Wait(tonumber('0')); end
        cb(lab)
    end)
end

RegisterNetEvent('pw-motelsbusiness:GetCharinfoName')
AddEventHandler('pw-motelsbusiness:GetCharinfoName', function (data, owner, key)
    local src = source
    local select = false
    local retData = {}  
    if owner and type(owner) ~= 'table' then
        if Cfg.QBCore then
            if owner then
                local result = FetchSQL('SELECT charinfo FROM players WHERE citizenid = "'..owner..'"')
                if result and result[tonumber('1')] then
                    local data = json.decode(result[tonumber('1')].charinfo)
                    if data then
                        TriggerClientEvent('pw-motelsbusiness:SetCallbackData', src, {firstname = data.firstname or '...', lastname = data.lastname or '...', phone = data.phone or '...'})
                    else
                        TriggerClientEvent('pw-motelsbusiness:SetCallbackData', src, 'empty')
                    end
                else
                    TriggerClientEvent('pw-motelsbusiness:SetCallbackData', src, 'empty')
                end             
            else
                TriggerClientEvent('pw-motelsbusiness:SetCallbackData', src, 'empty')
            end
        else
            if owner then
                if Cfg.charinfosystem then  
                    select = Cfg.identifierType == 'citizenid' and 'SELECT charinfo FROM users WHERE citizenid = "'..owner..'"' or Cfg.identifierType == 'identifier' and 'SELECT charinfo FROM users WHERE identifier = "'..owner..'"' or ''              
                    local result = FetchSQL(select)
                    if result and result[tonumber('1')] then
                        local data = json.decode(result[tonumber('1')].charinfo)
                        if data then
                            TriggerClientEvent('pw-motelsbusiness:SetCallbackData', src, {firstname = data.firstname or '...', lastname = data.lastname or '...', phone = data.phone or '...'})
                        else
                            TriggerClientEvent('pw-motelsbusiness:SetCallbackData', src, 'empty')
                        end
                    else
                        TriggerClientEvent('pw-motelsbusiness:SetCallbackData', src, 'empty')
                    end 
                else
                    select = Cfg.identifierType == 'citizenid' and 'SELECT firstname, lastname, phone FROM users WHERE citizenid = "'..owner..'"' or Cfg.identifierType == 'identifier' and 'SELECT firstname, lastname FROM users WHERE identifier = "'..owner..'"' or ''
                    local result = FetchSQL(select)
                    if result and result[tonumber('1')] then
                        local data = result[tonumber('1')]
                        TriggerClientEvent('pw-motelsbusiness:SetCallbackData', src, {firstname = data.firstname or '...', lastname = data.lastname or '...', phone = data.phone or '...'})
                    else
                        TriggerClientEvent('pw-motelsbusiness:SetCallbackData', src, 'empty')
                    end
                end
            else
                TriggerClientEvent('pw-motelsbusiness:SetCallbackData', src, 'empty')
            end            
        end
    else
        if Cfg.QBCore then
            if data then
                for k,v in pairs(data) do
                    if v.motel == key then
                        if not select then
                            select = "SELECT charinfo, `citizenid` FROM players WHERE `citizenid` = '"..k.."'"
                        else
                            select = select.." OR `citizenid` = '"..k.."'"
                        end
                    end
                end
                if select then
                    local results = FetchSQL(select)
                    if #results > 0 then
                        for i = 1, #results do  
                            local data = json.decode(results[i].charinfo)
                            if data then
                                retData[results[i].citizenid] = {
                                    owner = results[i].citizenid,
                                    firstname = data.firstname or '...',
                                    lastname = data.lastname or '...',
                                    phone = data.phone or '...'
                                }
                            end
                        end
                    end
                end
            end
        else
            if data then
                if Cfg.charinfosystem then
                    for k,v in pairs(data) do
                        if v.motel == key then
                            if not select then
                                select = "SELECT charinfo, `"..Cfg.identifierType.."` FROM users WHERE `"..Cfg.identifierType.."` = '"..k.."'"
                            else
                                select = select.." OR `"..Cfg.identifierType.."` = '"..k.."'"
                            end
                        end
                    end
                    if select then
                        local results = FetchSQL(select)
                        if #results > 0 then
                            for i = 1, #results do  
                                local data = json.decode(results[i].charinfo)
                                if data then
                                    retData[results[i][Cfg.identifierType]] = {
                                        owner = results[i][Cfg.identifierType],
                                        firstname = data.firstname or '...',
                                        lastname = data.lastname or '...',
                                        phone = data.phone or '...'
                                    }
                                end
                            end
                        end 
                    end
                else
                    for k,v in pairs(data) do
                        if v.motel == key then
                            if not select then
                                select = "SELECT `firstname`, `lastname`, `phone`, `"..Cfg.identifierType.."` FROM users WHERE `"..Cfg.identifierType.."` = '"..k.."'"
                            else
                                select = select.." OR `"..Cfg.identifierType.."` = '"..k.."'"
                            end
                        end
                    end
                    if select then
                        local results = FetchSQL(select)
                        if #results > 0 then
                            for i = 1, #results do  
                                retData[results[i][Cfg.identifierType]] = {
                                    owner = results[i][Cfg.identifierType],
                                    firstname = results[i].firstname or '...',
                                    lastname = results[i].lastname or '...',
                                    phone = results[i].phone or '...'
                                }
                            end
                        end
                    end
                end
            end            
        end
        if next(retData) or #retData > 0 then
            TriggerClientEvent('pw-motelsbusiness:SetCallbackData', src, retData)
        else
            TriggerClientEvent('pw-motelsbusiness:SetCallbackData', src, 'empty')
        end
    end
end)

function GetIdentifierName(owner)
    local data = nil
    if not Cfg.QBCore then
        if Cfg.charinfosystem then
            if Cfg.identifierType == "citizenid" then
                local result = FetchSQL('SELECT charinfo FROM users WHERE citizenid = "'..owner..'"')
                if result and result[tonumber('1')] then
                    local asd = json.decode(result[tonumber('1')].charinfo)
                    if asd then
                        local veri = {firstname = asd.firstname or '...', lastname = asd.lastname or '...'}
                        data = veri
                    end
                end
            elseif Cfg.identifierType == "identifier" then
                local result = FetchSQL('SELECT charinfo FROM users WHERE identifier = "'..owner..'"')
                if result and result[tonumber('1')] then
                    local asd = json.decode(result[tonumber('1')].charinfo)
                    if asd then
                        local veri = {firstname = asd.firstname or '...', lastname = asd.lastname or '...'}
                        data = veri
                    end
                end
            end   
        else
            if Cfg.identifierType == "citizenid" then
                local result = FetchSQL('SELECT firstname, lastname FROM users WHERE citizenid = "'..owner..'"')
                    if result and result[tonumber('1')] then
                        local veri = {firstname = result[tonumber('1')].firstname or '...', lastname = result[tonumber('1')].lastname or '...'}
                        data = veri
                    end
            elseif Cfg.identifierType == "identifier" then
                local result = FetchSQL('SELECT firstname, lastname FROM users WHERE identifier = "'..owner..'"')
                if result and result[tonumber('1')] then
                    local veri = {firstname = result[tonumber('1')].firstname or '...', lastname = result[tonumber('1')].lastname or '...'}
                    data = veri
                end
            end  
        end
    else
        local result = FetchSQL('SELECT charinfo FROM players WHERE citizenid = "'..owner..'"')
        if result and result[tonumber('1')] then
            local asd = json.decode(result[tonumber('1')].charinfo)
            if asd then
                local veri = {firstname = asd.firstname or '...', lastname = asd.lastname or '...'}
                data = veri
            end
        end
    end
    return data
end

RegisterNetEvent('pw-motelsbusiness:ResetRentCycle')
AddEventHandler('pw-motelsbusiness:ResetRentCycle', function()
    local src = source
    local player = GetPlayerFromId(src)
    if player then
        ResetRentCycle(src, Identifier(player))    
    end
end)

function RentCycle(player)
    TriggerClientEvent('pw-motelsbusiness:StartRentCycle', player.source, PlayersMotels[Identifier(player)].rentcycle)
end

RegisterNetEvent('pw-motelsbusiness:GetRentCycle')
AddEventHandler('pw-motelsbusiness:GetRentCycle', function(cycle)
    local src = source
    local player = GetPlayerFromId(src)
    if player then
        if PlayersMotels[Identifier(player)] then
            PlayersMotels[Identifier(player)].rentcycle = cycle
            TriggerEvent('pw-motelsbusiness:GetPlayersData')
        end
    end
end)

RegisterNetEvent('pw-motelsbusiness:removeOutfit')
AddEventHandler('pw-motelsbusiness:removeOutfit', function(label)
    local xPlayer = GetPlayerFromId(source)
    TriggerEvent('esx_datastore:getDataStore', 'property', Identifier(xPlayer), function(store)
      local dressing = store.get('dressing') or {}
      table.remove(dressing, label)
      store.set('dressing', dressing)
    end)
end) 

RegisterNetEvent('pw-motelsbusiness:SendMessagePlayerFromReception')
AddEventHandler('pw-motelsbusiness:SendMessagePlayerFromReception', function(msg, playerID)
    local src = source
    if src then
        local player = GetPlayerFrom(playerID)
        if player then
            if Cfg.gcphone then
                TriggerEvent('esx_addons_gcphone:motelSendMessage', player.source, PlayersMotels[playerID] and PlayersMotels[playerID].motel or EmployeeMotels[playerID] and EmployeeMotels[playerID].motel..' '.._U['motel_admin'], msg or "...")
            else
                Notification(player.source, msg or "...")
            end
        else
            Notification(src, _U['notfoundedplayer'])
        end
    end
end)

RegisterNetEvent('pw-motelsbusiness:AcceptRequest')
AddEventHandler('pw-motelsbusiness:AcceptRequest', function(target, method, upval)
    local src = source
    if src and target then
        local player = GetPlayerFrom(target)
        if method and upval ~= nil then
            if PlayersMotels[target] then
            PlayersMotels[target].requests[method] = nil
            if player then
                SendLog(src, _U['log_acceptRequest']:format(GetPlayerName(src), GetPlayerName(player.source), GetRequestName(method)).."\n"..GetProperty(src, _U['log_player']).."\n"..GetProperty(player.source, _U['log_player']), _U['log_acceptRequestX'], tonumber('65321'), Cfg.LogWebHooks['Accept Request'])
                if Cfg.gcphone then
                    TriggerEvent('esx_addons_gcphone:motelSendMessage', player.source, PlayersMotels[target].motel..' '.._U['motel_admin'], _U['motel_acceptRequest'])
                else
                    Notification(player.source, _U['motel_acceptRequest'])
                end
            else
                SendLog(src, _U['log_acceptRequest']:format(GetPlayerName(src), target, GetRequestName(method)).."\n"..GetProperty(src, _U['log_player']), _U['log_acceptRequestX'], tonumber('65321'), Cfg.LogWebHooks['Accept Request'])
            end
            TriggerEvent('pw-motelsbusiness:GetPlayersData')
        end
    end
    else
        Notification(src, _U['notfoundedplayer'])
    end
end)

RegisterNetEvent('pw-motelsbusiness:RejectRequest')
AddEventHandler('pw-motelsbusiness:RejectRequest', function(target, method, upval)
    local src = source
    if src and target then
        local player = GetPlayerFrom(target)
        if method and upval ~= nil then
            PlayersMotels[target].requests[method] = nil
            if player then
                if Cfg.gcphone then
                    TriggerEvent('esx_addons_gcphone:motelSendMessage', player.source, PlayersMotels[target].motel..' '.._U['motel_admin'], _U['motel_rejectRequest'])
                else
                    Notification(player.source, _U['motel_rejectRequest'])
                end
                SendLog(src, _U['log_rejectRequest']:format(GetPlayerName(src), GetPlayerName(player.source), GetRequestName(method)).."\n"..GetProperty(src, _U['log_player']).."\n"..GetProperty(player.source, _U['log_player']), _U['log_rejectRequestX'], tonumber('16711680'), Cfg.LogWebHooks['Reject Request'])
            else
                SendLog(src, _U['log_rejectRequest']:format(GetPlayerName(src), target, GetRequestName(method)).."\n"..GetProperty(src, _U['log_player']), _U['log_rejectRequestX'], tonumber('16711680'), Cfg.LogWebHooks['Reject Request'])
            end
            TriggerEvent('pw-motelsbusiness:GetPlayersData')
        end
    else
        Notification(src, _U['notfoundedplayer'])
    end
end)

RegisterNetEvent('pw-motelsbusiness:TakeEmployee')
AddEventHandler('pw-motelsbusiness:TakeEmployee', function(src, target, motelID, salary)
    if src then
        local xTarget = GetPlayerFrom(target)
        if xTarget then
            EmployeeMotels[target] = {
                employee = target,
                motel = motelID,
                salary = salary,
                pay = tonumber('0'),
                permissions = {
                    kick = false,
                    change = false,
                    timerefresh = false,
                    createnewkey = false,
                    sendmessage = false,
                    takeplayer = false,
                    showrequests = false,
                    takeMoney = false,
                    depositMoney = false,
                    updateStatus = false
                }
            }
            SendLog(src, _U['log_takeemployee']:format(GetPlayerName(src), GetPlayerName(xTarget.source), tostring(salary)).."\n"..GetProperty(src, _U['motel_owner']).."\n"..GetProperty(xTarget.source, _U['log_player']), _U['log_takeemployeex'], tonumber('6684927'), Cfg.LogWebHooks['Take Employee'])
            Notification(src, _U['reception_succesfullytakeemploye'])
            Notification(xTarget.source, _U['reception_succesfullytakeemployeTarget']:format(motelID, tostring(salary)))
            TriggerEvent('pw-motelsbusiness:GetEmployeesData')
            local veri = PlayerName(xTarget)
            veri.motel = motelID
            TriggerEvent('pw-motelsbusiness:SaveTransaction', 'TakeEmployee', veri)
        end
    end
end)

RegisterNetEvent('pw-motelsbusiness:UpdatePermission')
AddEventHandler('pw-motelsbusiness:UpdatePermission', function(target, method, upval)
    local src = source
    if target then
        local xTarget = GetPlayerFrom(target)
        if EmployeeMotels[target] then
            EmployeeMotels[target].permissions[method] = upval
            TriggerEvent('pw-motelsbusiness:GetEmployeesData')
            if xTarget then
                SendLog(src, _U['log_updatePermission']:format(GetPlayerName(src), GetPlayerName(xTarget.source), GetPermissionName(method), upval and _U['reception_open'] or _U['reception_close']).."\n"..GetProperty(src, _U['log_admin']).."\n"..GetProperty(xTarget.source, _U['motel_buyer']), _U['log_updatePerm'], tonumber('16737792'), Cfg.LogWebHooks['Update Permission'])
            else
                ExecuteSQL("UPDATE motels_employee SET permissions = '"..json.encode(EmployeeMotels[target].permissions).."' WHERE employee = '"..target.."' LIMIT 1")
                SendLog(src, _U['log_updatePermission']:format(GetPlayerName(src), target, GetPermissionName(method), upval and _U['reception_open'] or _U['reception_close']).."\n"..GetProperty(src, _U['log_admin']), _U['log_updatePerm'], tonumber('16737792'), Cfg.LogWebHooks['Update Permission'])
            end
        else    
            Notification(src, _U['reception_notplayerdata'])
        end
    else
        Notification(src, _U['reception_notplayerfound'])
    end
end)

RegisterNetEvent('pw-motelsbusiness:SellMotel')
AddEventHandler('pw-motelsbusiness:SellMotel', function(key)
    local src = source
    if src then
        local player = GetPlayerFromId(src)
        if player then
            if MX[key] and MX[key].owner then
                if MX[key].owner == Identifier(player) then
                    AddMoney(src, tonumber(math.floor(MX[key].price * MX[key].sell)))
                    MX[key].owner = ''
                    TriggerClientEvent('pw-motelsbusiness:SetOwner', tonumber('-1'), key, '')
                    local result = FetchSQL("SELECT owner FROM motels_owner WHERE motel = '"..key.."'")
                    if result and result[1] then
                        ExecuteSQL("DELETE FROM motels_owner WHERE motel = '"..key.."'")
                    end
                    if next(PlayersMotels) then
                        for k,v in pairs(PlayersMotels) do
                            if v.motel == key then
                                local target = GetPlayerFrom(v.owner)
                                if target then
                                    if Cfg.gcphone then
                                        TriggerEvent('esx_addons_gcphone:motelSendMessage', target.source, key..' '.._U['motel_admin'], _U['motel_deletedPlayerMsg'])
                                    else
                                        Notification(target.source, _U['motel_deletedPlayerMsg'])
                                    end
                                    TriggerClientEvent('pw-motelsbusiness:StopRentCycle', target.source, true)
                                end
                                PlayersMotels[k] = nil
                            end
                        end
                    end
                    if next(EmployeeMotels) then
                        for k,v in pairs(EmployeeMotels) do
                            if v.motel == key then
                                local target = GetPlayerFrom(v.employee)
                                if target then
                                    if Cfg.gcphone then
                                        TriggerEvent('esx_addons_gcphone:motelSendMessage', target.source, key..' '.._U['motel_admin'], _U['motel_deletedEmployeeMsg'])
                                    else
                                        Notification(target.source, _U['motel_deletedEmployeeMsg'])
                                    end
                                    TriggerClientEvent('pw-motelsbusiness:StopRentCycle', target.source, true)
                                end
                                EmployeeMotels[k] = nil
                            end
                        end
                    end
                    if MotelsMoney[key] then
                        MotelsMoney[key] = nil
                    end
                    TriggerEvent('pw-motelsbusiness:GetPlayersData')
                    TriggerEvent('pw-motelsbusiness:GetEmployeesData')
                    TriggerEvent('pw-motelsbusiness:GetSocietyData')
                    TriggerEvent('pw-motelsbusiness:GetBillsData')
                    Notification(src, _U['motel_successfullySell']:format(tostring(tonumber(math.floor(MX[key].price * MX[key].sell)))))
                else
                    Notification(src, _U['not_motelowner']) 
                end
            else
                Notification(src, _U['society_notData'])
            end
        else
            Notification(src, _U['society_notData'])
        end
    else
        Notification(src, _U['society_notData'])
    end
end)

RegisterNetEvent('pw-motelsbusiness:saveOutfit')
AddEventHandler('pw-motelsbusiness:saveOutfit', function(label, skin)
	local xPlayer = GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'property', Identifier(xPlayer), function(store)
		local dressing = store.get('dressing')

		if dressing == nil then
			dressing = {}
		end

		table.insert(dressing, {
			label = label,
			skin  = skin
		})

		store.set('dressing', dressing)
		store.save()
	end)
end)

RegisterNetEvent('pw-motelsbusiness:setMotelOwner')
AddEventHandler('pw-motelsbusiness:setMotelOwner', function(playerid, motelid)
    local validate = false
    local src = source
    local player = GetPlayerFromId(src)
    local target = GetPlayerFromId(playerid)
    if player and target then
        for k,_ in pairs(MX) do
            if motelid and motelid == k then
                validate = true
                break
            end
        end
        if validate then
            if Cfg.generalPurchasable then
                local result = FetchSQL("SELECT * FROM motels_owner WHERE motel = '"..motelid.."'")
                if result and result[tonumber('1')] then
                    ExecuteSQL("DELETE FROM motels_owner WHERE motel = '"..motelid.."'")
                end
                MX[motelid].owner = Identifier(target)
                TriggerClientEvent('pw-motelsbusiness:SetOwner', tonumber('-1'), motelid, Identifier(target))
                ExecuteSQL("INSERT INTO motels_owner (owner, motel) VALUES ('"..Identifier(target).."', '"..motelid.."')")
                SendLog(src, _U['log_setmotelowner']:format(GetPlayerName(src), string.upper(motelid), GetPlayerName(playerid)).."\n"..GetProperty(src, _U['log_admin']).."\n"..GetProperty(playerid, _U['motel_buyer']), _U['log_setmotel'], tonumber('15105570'), Cfg.LogWebHooks['SetMotelOwner'])
                Notification(target.source, _U['motel_BuyMotel']:format(motelid))
            else
                local result = FetchSQL("SELECT * FROM motels_owner WHERE motel = '"..motelid.."'")
                if result and result[tonumber('1')] then
                    ExecuteSQL("DELETE FROM motels_owner WHERE motel = '"..motelid.."'")
                end
                MX[motelid].owner = Identifier(target)
                TriggerClientEvent('pw-motelsbusiness:SetOwner', tonumber('-1'), motelid, Identifier(target))
                ExecuteSQL("INSERT INTO motels_owner (owner, motel) VALUES ('"..Identifier(target).."', '"..motelid.."')")
                SendLog(src, _U['log_setmotelowner']:format(GetPlayerName(src), string.upper(motelid), GetPlayerName(playerid)).."\n"..GetProperty(src, _U['log_admin']).."\n"..GetProperty(playerid, _U['motel_buyer']), _U['log_setmotel'], tonumber('15105570'), Cfg.LogWebHooks['SetMotelOwner'])
                Notification(target.source, _U['motel_BuyMotel']:format(motelid))
            end
        else
            Notification(src, _U['setmotelowner_notFoundedMotelID2'])
        end
    end
end)

function ResetRentCycle(src, cid)
    if PlayersMotels[cid] then
        if PlayersMotels[cid].pay > tonumber('0') then
            TriggerEvent('pw-motelsbusiness:CreateBill', src, PlayersMotels[cid].motel, tonumber(math.floor(PlayersMotels[cid].pay * tonumber('2'))))
            SendLog(src, _U['log_resetrent']:format(GetPlayerName(src), PlayersMotels[cid].motel, _U['log_notpayed']).."\n"..GetProperty(src, _U['log_player']), _U['log_resrent'], tonumber('1146986'), Cfg.LogWebHooks['Reset Rent'])
        else
            if Cfg.gcphone then
                TriggerEvent('esx_addons_gcphone:motelSendMessage', src, PlayersMotels[cid].motel..' '.._U['motel_admin'], _U['motel_finalTime'])
            else
                Notification(src, _U['motel_finalTime'])
            end
            SendLog(src, _U['log_resetrent']:format(GetPlayerName(src), PlayersMotels[cid].motel, _U['log_payed']).."\n"..GetProperty(src, _U['log_player']), _U['log_resrent'], tonumber('1146986'), Cfg.LogWebHooks['Reset Rent'])
        end
        DeleteMotel(cid)
    end
end

RegisterNetEvent('pw-motelsbusiness:CheckPay')
AddEventHandler('pw-motelsbusiness:CheckPay', function(method)
    local src = source
    if src then
        local player = GetPlayerFromId(src)
        if player then
            if PlayersMotels[Identifier(player)] then
                if method == tonumber('1') then
                    if PlayersMotels[Identifier(player)].pay > tonumber('0') then
                        if Cfg.gcphone then
                            TriggerEvent('esx_addons_gcphone:motelSendMessage', player.source, PlayersMotels[Identifier(player)].motel..' '.._U['motel_admin'], _U['motel_Suspended'])
                        else
                            Notification(player.source, _U['motel_Suspended'])
                        end
                        PlayersMotels[Identifier(player)].suspended = tonumber('1')
                        TriggerEvent('pw-motelsbusiness:GetPlayersData')
                    else
                        if Cfg.gcphone then
                            TriggerEvent('esx_addons_gcphone:motelSendMessage', player.source, PlayersMotels[Identifier(player)].motel..' '.._U['motel_admin'], _U['motel_firstTime']:format(GetTimer(Identifier(player))))
                        else
                            Notification(player.source, _U['motel_firstTime']:format(GetTimer(Identifier(player))))
                        end
                    end
                elseif method == tonumber('2') then
                    if PlayersMotels[Identifier(player)].pay > tonumber('0') then
                        PlayersMotels[Identifier(player)].pay = tonumber(PlayersMotels[Identifier(player)].pay + PlayersMotels[Identifier(player)].pay * MX[PlayersMotels[Identifier(player)].motel].warningExpense.first)
                        if Cfg.gcphone then
                            TriggerEvent('esx_addons_gcphone:motelSendMessage', player.source, PlayersMotels[Identifier(player)].motel..' '.._U['motel_admin'], _U['motel_paySuspended']:format(PlayersMotels[Identifier(player)].pay))
                        else
                            Notification(player.source, _U['motel_paySuspended']:format(PlayersMotels[Identifier(player)].pay))
                        end
                    else
                        if Cfg.gcphone then
                            TriggerEvent('esx_addons_gcphone:motelSendMessage', player.source, PlayersMotels[Identifier(player)].motel..' '.._U['motel_admin'], _U['motel_secondTime']:format(GetTimer(Identifier(player))))
                        else
                            Notification(player.source, _U['motel_secondTime']:format(GetTimer(Identifier(player))))
                        end
                    end
                elseif method == tonumber('3') then
                    if PlayersMotels[Identifier(player)].pay > tonumber('0') then
                        PlayersMotels[Identifier(player)].pay = tonumber(math.floor(PlayersMotels[Identifier(player)].pay + PlayersMotels[Identifier(player)].pay * MX[PlayersMotels[Identifier(player)].motel].warningExpense.second))
                        if Cfg.gcphone then
                            TriggerEvent('esx_addons_gcphone:motelSendMessage', player.source, PlayersMotels[Identifier(player)].motel..' '.._U['motel_admin'], _U['motel_paySuspended']:format(PlayersMotels[Identifier(player)].pay))
                        else
                            Notification(player.source, _U['motel_paySuspended']:format(PlayersMotels[Identifier(player)].pay))
                        end
                    else
                        if Cfg.gcphone then
                            TriggerEvent('esx_addons_gcphone:motelSendMessage', player.source, PlayersMotels[Identifier(player)].motel..' '.._U['motel_admin'], _U['motel_secondTime']:format(GetTimer(Identifier(player))))
                        else
                            Notification(player.source, _U['motel_secondTime']:format(GetTimer(Identifier(player))))
                        end
                    end
                elseif method == tonumber('4') then
                    if PlayersMotels[Identifier(player)].pay > tonumber('0') then
                        PlayersMotels[Identifier(player)].pay = tonumber(math.floor(PlayersMotels[Identifier(player)].pay + PlayersMotels[Identifier(player)].pay * MX[PlayersMotels[Identifier(player)].motel].warningExpense.three))
                        if Cfg.gcphone then
                            TriggerEvent('esx_addons_gcphone:motelSendMessage', player.source, PlayersMotels[Identifier(player)].motel..' '.._U['motel_admin'], _U['motel_paySuspended']:format(PlayersMotels[Identifier(player)].pay))
                        else
                            Notification(player.source, _U['motel_paySuspended']:format(PlayersMotels[Identifier(player)].pay))
                        end
                    else    
                        if Cfg.gcphone then
                            TriggerEvent('esx_addons_gcphone:motelSendMessage', player.source, PlayersMotels[Identifier(player)].motel..' '.._U['motel_admin'], _U['motel_threeTime']:format(GetTimer(Identifier(player))))
                        else
                            Notification(player.source, _U['motel_threeTime']:format(GetTimer(Identifier(player))))
                        end
                    end
                elseif method == tonumber('5') then
                    if PlayersMotels[Identifier(player)].pay > tonumber('0') then
                        PlayersMotels[Identifier(player)].pay = tonumber(math.floor(PlayersMotels[Identifier(player)].pay + PlayersMotels[Identifier(player)].pay * MX[PlayersMotels[Identifier(player)].motel].warningExpense.four))
                        if Cfg.gcphone then
                            TriggerEvent('esx_addons_gcphone:motelSendMessage', player.source, PlayersMotels[Identifier(player)].motel..' '.._U['motel_admin'], _U['motel_paySuspended']:format(PlayersMotels[Identifier(player)].pay))
                        else
                            Notification(player.source, _U['motel_paySuspended']:format(PlayersMotels[Identifier(player)].pay))
                        end
                    else
                        if Cfg.gcphone then
                            TriggerEvent('esx_addons_gcphone:motelSendMessage', player.source, PlayersMotels[Identifier(player)].motel..' '.._U['motel_admin'], _U['motel_fourTime']:format(GetTimer(Identifier(player))))
                        else
                            Notification(player.source, _U['motel_fourTime']:format(GetTimer(Identifier(player))))
                        end
                    end
                end
                TriggerEvent('pw-motelsbusiness:GetPlayersData')
            end
        end
    end
end)

-- burda kaldın
RegisterNetEvent('pw-motelsbusiness:payRoom')
AddEventHandler('pw-motelsbusiness:payRoom', function(amount)
    local src = source
    if src then
        local player = GetPlayerFromId(src)
        if player then
            if PlayersMotels[Identifier(player)] then
                if PlayersMotels[Identifier(player)].pay - amount >= tonumber('0') then
                    if GetMoney(src) >= amount then
                        RemoveMoney(src, amount)
                        PlayersMotels[Identifier(player)].pay = PlayersMotels[Identifier(player)].pay - amount
                        MotelsAddMoney(PlayersMotels[Identifier(player)].motel, amount)
                        Notification(src, _U['reception_payed'])
                        TriggerEvent('pw-motelsbusiness:GetPlayersData')
                        SendLog(src, _U['log_payRoom']:format(GetPlayerName(src), PlayersMotels[Identifier(player)].motel, PlayersMotels[Identifier(player)].motelid, tostring(amount), tostring(PlayersMotels[Identifier(player)].pay))..'\n'..GetProperty(src, _U['log_player']), _U['log_payRoomX'], tonumber('47359'), Cfg.LogWebHooks['Pay Rent'])
                        if PlayersMotels[Identifier(player)].pay == tonumber('0') then
                            PlayersMotels[Identifier(player)].suspended = tonumber('0')
                        end
                        local veri = PlayerName(player)
                        veri.amount = amount
                        veri.motel = PlayersMotels[Identifier(player)].motel
                        TriggerEvent('pw-motelsbusiness:SaveTransaction', 'PayRoom', veri)
                    else
                        Notification(src, _U['not_money'])
                    end
                else
                    Notification(src, _U['reception_notReqPay'])
                end
            end
        else
            Notification(src, _U['society_notData'])
        end
    end
end)

RegisterNetEvent('pw-motelsbusiness:SelfBuyMotel')
AddEventHandler('pw-motelsbusiness:SelfBuyMotel', function(motelID, price)
    local src = source
    if src then
        local player = GetPlayerFromId(src)
        if player then
            if GetMoney(src) >= price then
                RemoveMoney(src, price)
                MX[motelID].owner = Identifier(player)
                TriggerClientEvent('pw-motelsbusiness:SetOwner', tonumber('-1'), motelID, Identifier(player))
                ExecuteSQL("INSERT INTO motels_owner (owner, motel) VALUES ('"..Identifier(player).."', '"..motelID.."')")
                
            else
                Notification(src, _U['society_notEnoughtMoney']..' : '..tostring(price))
            end
        end
    end
end)

RegisterNetEvent('pw-motelsbusiness:Req')
AddEventHandler('pw-motelsbusiness:Req', function(method, data)
    local src = source
    local player = GetPlayerFromId(src)
    if player then
        data.src = src
        if method == 'buy' then
            local xTarget = GetPlayerFrom(data.target)
            if xTarget then
                data.firstname = 'not founded'
                data.lastname = 'not founded'
                local cidData = GetIdentifierName(Identifier(player))
                if cidData then
                    data.firstname = cidData.firstname or ''
                    data.lastname = cidData.lastname or ''
                end
                Notification(src, _U['motel_requestWaiting'])
                TriggerClientEvent('pw-motelsbusiness:OpenReqMenu', xTarget.source, method, data)
            end
        elseif method == 'takeemployee' then
            local xTarget = GetPlayerFrom(data.target)
            if xTarget then
                data.firstname = 'not founded'
                data.lastname = 'not founded'
                local cidData = GetIdentifierName(Identifier(player))
                if cidData then
                    data.firstname = cidData.firstname or ''
                    data.lastname = cidData.lastname or ''
                end
                Notification(src, _U['motel_requestWaiting'])
                TriggerClientEvent('pw-motelsbusiness:OpenReqMenu', xTarget.source, method, data)
            end
        end
    end
end)

RegisterNetEvent('pw-motelsbusiness:ReqReject')
AddEventHandler('pw-motelsbusiness:ReqReject', function(data)
    if data and data.src then
        Notification(data.src, _U['motel_requestReject'])
    end
end)

RegisterNetEvent('pw-motelsbusiness:BuyMotel')
AddEventHandler('pw-motelsbusiness:BuyMotel', function(src, xTarget, motelID, motelRoom, time, expense)
    if src then
    if xTarget then
            local target = GetPlayerFrom(xTarget)
            local me = GetPlayerFromId(src)
            if me then
                if target then
                    if Identifier(me) == MX[motelID].owner or EmployeeMotels[Identifier(me)].motel == motelID then
                        if not PlayersMotels[Identifier(target)] then
                            PlayersMotels[Identifier(target)] = {
                                owner = Identifier(target),
                                rentcycle = time,
                                pay = expense,
                                motel = motelID,
                                motelid = motelRoom,
                                suspended = tonumber('0'),
                                uniq = '',
                                requests = {
                                    requestEmployee = false,
                                    requestKey = false,
                                    requestChangeRoom = false,
                                    requestRefreshTime = false
                                },
                            }
                            if Cfg.metasystem or Cfg.QBCore then
                                local lb = GetPlayerFromId(target.source)
                                if lb then
                                    local info = {}
                                    local namecharacter = PlayerName(target)
                                    info.code = 'PW-'..tostring(RandomInt(tonumber('4')) .. RandomInt(tonumber('3')) .. RandomInt(tonumber('2')) .. RandomInt(tonumber('3')) .. RandomStr(tonumber('4')))
									info.motel = PlayersMotels[Identifier(target)].motel..'-'..PlayersMotels[Identifier(target)].motelid
                                    info.steam = Identifier(target)
                                    info.chuphong = namecharacter.firstname.."-"..namecharacter.lastname
                                    --info.steam = namecharacter.firstname.."-"..namecharacter.lastname
                                    --[[ if not Cfg.QBCore then
                                        info.description = 'Motel ID: '..info.motel
                                    end ]]
                                    if Cfg.QBCore then
                                        AddInventoryItem(target.source, Cfg.metaitem, tonumber('1'), false, info)
                                    else
                                        AddInventoryItem(target.source, Cfg.metaitem, tonumber('1'),info)
                                    end
                                    PlayersMotels[Identifier(target)].uniq = info.code
                                end
                            end
                            if Cfg.charinfosystem then
                                if Lib then
                                    local lb = Lib.GetPlayerFromId(target.source)
                                    if lb then
                                        Notification(src, _U['buy_sellhouseMsgSeller']:format(lb.PlayerData.charinfo.firstname.."-"..lb.PlayerData.charinfo.lastname, motelID, motelRoom))
                                    end
                                    local lc = Lib.GetPlayerFromId(src)
                                    if lc then
                                        Notification(target.source, _U['buy_sellhouseMsgBuyer']:format(motelID, motelRoom, lc.PlayerData.charinfo.firstname.."-"..lc.PlayerData.charinfo.lastname))
                                    end
                                end
                            else
                                if PlayerName(target) then
                                    local info = PlayerName(target)
                                    Notification(src, _U['buy_sellhouseMsgSeller']:format(info.firstname.."-"..info.lastname, motelID, motelRoom))
                                end
                                if PlayerName(me) then
                                    local info = PlayerName(me)
                                    Notification(target.source, _U['buy_sellhouseMsgBuyer']:format(motelID, motelRoom, info.firstname.."-"..info.lastname))
                                end
                            end
                            SendLog(src, _U['log_buymotel']:format(GetPlayerName(target.source), motelID, motelRoom, expense).."\n"..GetProperty(target.source, _U['motel_buyer'])..'\n'..GetProperty(src, _U['motel_owner']), _U['log_buy'], tonumber('44543'), Cfg.LogWebHooks['BuyMotel'])
                            RentCycle(target)
                            TriggerEvent('pw-motelsbusiness:GetPlayersData')
                            Notification(src, _U['motel_requestAccept'])
                            local veri = PlayerName(target)
                            veri.motel = PlayersMotels[Identifier(target)].motel
                            TriggerEvent('pw-motelsbusiness:SaveTransaction', 'RentRoom', veri)
                        else
                            Notification(src, _U['buy_alreadyhouse'])
                        end
                    else
                        print('^1 [PW-MOTELS] ^0 :: '.._U['hacker_probably']:format(src, GetPlayerIdentifiers(src)[tonumber('1')]))
                    end
                else
                    Notification(src, _U['not_foundedid'])
                end
            end
        else
            Notification(src, _U['notfoundedplayer'])
        end
    end
end)

RegisterNetEvent('pw-motelsbusiness:UpdateSuspend')
AddEventHandler('pw-motelsbusiness:UpdateSuspend', function(target)
    local src = source
    if src and target then
        if PlayersMotels[target] and PlayersMotels[target].suspended then
            if PlayersMotels[target].suspended == tonumber('1') then
                PlayersMotels[target].suspended = tonumber('0')
            else
                PlayersMotels[target].suspended = tonumber('1')
            end
            local xTarget = GetPlayerFrom(target)
            if xTarget then
                local msg = PlayersMotels[target].suspended == tonumber('1') and _U['reception_updatedSuspended'] or PlayersMotels[target].suspended == tonumber('0') and _U['reception_updatedBeat']
                if Cfg.gcphone then
                    TriggerEvent('esx_addons_gcphone:motelSendMessage', xTarget.source, PlayersMotels[target].motel..' '.._U['motel_admin'], msg)
                else
                    Notification(xTarget.source, msg)
                end
            else
                ExecuteSQL("UPDATE motels SET suspended = '"..PlayersMotels[target].suspended.."' WHERE owner = '"..target.."'")
            end
            Notification(src, _U['motel_successfullyChangedStatus'])
            TriggerEvent('pw-motelsbusiness:GetPlayersData')
        end
    end
end)

RegisterNetEvent('pw-motelsbusiness:ChangeRoom')
AddEventHandler('pw-motelsbusiness:ChangeRoom', function(target, motelID)
    local src = source
    local verified = true
    if next(PlayersMotels) then
        for k,v in pairs(PlayersMotels) do
            if v.motel == PlayersMotels[target].motel and v.motelid == motelID then
                verified = false
            end
        end
    end
    if target and PlayersMotels[target] then
        if motelID <= #MX[PlayersMotels[target].motel].doors then
            if verified then
                local xTarget = GetPlayerFrom(target)
                if Cfg.metasystem or Cfg.QBCore then
                    local info = {}
                    local namecharacter = PlayerName(target)
                    info.code = 'PW-'..tostring(RandomInt(tonumber('4')) .. RandomInt(tonumber('3')) .. RandomInt(tonumber('2')) .. RandomInt(tonumber('3')) .. RandomStr(tonumber('4')))
                    info.motel = PlayersMotels[target].motel..'-'..motelID
                    info.steam = target
                    info.chuphong = namecharacter.firstname.."-"..namecharacter.lastname
                    if not Cfg.QBCore then
                        info.description = 'Motel ID: '..info.motel
                    end
                    if xTarget then
                        SendLog(src, _U['log_changeRoom']:format(GetPlayerName(src), GetPlayerName(xTarget.source), PlayersMotels[target].motel, PlayersMotels[target].motelid, motelID).."\n"..GetProperty(src, _U['motel_owner'])..'\n'..GetProperty(xTarget.source, _U['log_player']), _U['log_chh'], tonumber('2899536'), Cfg.LogWebHooks['Change Room'])
                        Notification(xTarget.source, _U['changed_room']:format(motelID))
                        if Cfg.QBCore then
                            AddInventoryItem(xTarget.source, Cfg.metaitem, tonumber('1'), false, info)
                        else
                            AddInventoryItem(xTarget.source, Cfg.metaitem, tonumber('1'), info)
                        end
                    else
                        SendLog(src, _U['log_changeRoom']:format(GetPlayerName(src), target, PlayersMotels[target].motel, PlayersMotels[target].motelid, motelID).."\n"..GetProperty(src, _U['motel_owner']), _U['log_chh'], tonumber('2899536'), Cfg.LogWebHooks['Change Room'])
                        ExecuteSQL("UPDATE motels SET uniq = '"..info.code.."', motelid = '"..motelID.."' WHERE owner = '"..target.."'")
                    end
                    Notification(src, _U['reception_changedMotel'])
                    PlayersMotels[target].motelid = motelID
                    PlayersMotels[target].uniq = info.code
                elseif not Cfg.metasystem and Cfg.QBCore then
                    PlayersMotels[target].motelid = motelID
                    if xTarget then
                        SendLog(src, _U['log_changeRoom']:format(GetPlayerName(src), GetPlayerName(xTarget.source), PlayersMotels[target].motel, PlayersMotels[target].motelid, motelID).."\n"..GetProperty(src, _U['motel_owner'])..'\n'..GetProperty(xTarget.source, _U['log_player']), _U['log_chh'], tonumber('2899536'), Cfg.LogWebHooks['Change Room'])
                        Notification(xTarget.source, _U['changed_room']:format(motelID))
                    else
                        SendLog(src, _U['log_changeRoom']:format(GetPlayerName(src), target, PlayersMotels[target].motel, PlayersMotels[target].motelid, motelID).."\n"..GetProperty(src, _U['motel_owner']), _U['log_chh'], tonumber('2899536'), Cfg.LogWebHooks['Change Room'])
                        ExecuteSQL("UPDATE motels SET motelid = '"..motelID.."' WHERE owner = '"..target.."'")
                    end
                end
            else
                Notification(src, _U['reception_ownedRoom'])
            end
        else
            Notification(src, _U['motel_notfounded'])
        end
    else
        Notification(src, _U['not_foundedid'])
    end
    TriggerEvent('pw-motelsbusiness:GetPlayersData')
end)

function DeleteMotel(cid)
    local player = GetPlayerFrom(cid)
    if player then
        if PlayersMotels[cid] then
            SendLog(player.source, _U['log_autodeletemotel']:format(GetPlayerName(player.source), PlayersMotels[cid].motel, PlayersMotels[cid].motelid).."\n"..GetProperty(player.source, _U['log_player']), _U['log_autodelete'], tonumber('12715269'), Cfg.LogWebHooks['Delete Motel'])
            PlayersMotels[cid] = nil
            TriggerEvent('pw-motelsbusiness:GetPlayersData')
            Notification(player.source, _U['motel_removed'])
        end
    end
end

RegisterNetEvent('pw-motelsbusiness:KickEmployee')
AddEventHandler('pw-motelsbusiness:KickEmployee', function(target)
    local src = source
    if target then
        local xTarget = GetPlayerFrom(target)
        if xTarget then
            if EmployeeMotels[target] then
                ExecuteSQL("DELETE FROM motels_employee WHERE employee = '"..target.."'")
                Notification(src, _U['reception_successfullykicked'])
                if xTarget then
                    SendLog(src, _U['log_kickEmployee']:format(GetPlayerName(src), EmployeeMotels[target].motel, GetPlayerName(xTarget.source)).."\n"..GetProperty(src, _U['log_player']).."\n"..GetProperty(xTarget.source, _U['log_employee']), _U['log_kickedEmployee'], tonumber('16716800'), Cfg.LogWebHooks['Kick Employee'])
                    Notification(xTarget.source, _U['reception_Employeekicked'])
                else
                    SendLog(src, _U['log_kickEmployee']:format(GetPlayerName(src), EmployeeMotels[target].motel, target).."\n"..GetProperty(src, _U['log_player']), _U['log_kickedEmployee'], tonumber('16716800'), Cfg.LogWebHooks['Kick Employee'])
                end
                EmployeeMotels[target] = nil
            else
                Notification(src, _U['reception_notplayerdata'])
            end
        end
        TriggerEvent('pw-motelsbusiness:GetEmployeesData')
    else
        Notification(src, _U['not_foundedid'])
    end
end)

RegisterNetEvent('pw-motelsbusiness:GiveReward')
AddEventHandler('pw-motelsbusiness:GiveReward', function(target, motelID, reward)
    local src = source
    if src then
        if target then
            if reward and motelID then
                local xTarget = GetPlayerFrom(target)
                if xTarget then
                    if MotelsMoney[motelID] and MotelsMoney[motelID].money >= tonumber(reward) then
                        MotelsMoney[motelID].money = MotelsMoney[motelID].money - tonumber(reward)
                        AddAccountMoney(target, 'bank', tonumber(reward))
                        Notification(src, _U['reception_rewardSenderMsg']:format(tostring(reward)))
                        Notification(xTarget.source, _U['reception_rewardTakerMsg']:format(tostring(reward)))
                        SendLog(src, _U['log_rewardEmployee']:format(GetPlayerName(src), GetPlayerName(xTarget.source), tostring(reward)).."\n"..GetProperty(xTarget.source, _U['log_player']).."\n"..GetProperty(src, _U['motel_owner']), _U['log_reward'], tonumber('720640'), Cfg.LogWebHooks['Give Employee Reward'])
                    else
                        Notification(src, _U['society_notEnoughtMoney'])
                    end
                else
                    Notification(src, _U['notfoundedplayer'])
                end
            end
        else
            Notification(src, _U['notfoundedplayer'])
        end
    end 
    TriggerEvent('pw-motelsbusiness:GetSocietyData')
end)

RegisterNetEvent('pw-motelsbusiness:UpdateSalary')
AddEventHandler('pw-motelsbusiness:UpdateSalary', function(target, sal)
    local src = source
    if src then
        if target then
            if sal and tonumber(sal) then
                if EmployeeMotels[target] then
                    local xTarget = GetPlayerFrom(target)
                    EmployeeMotels[target].salary = tonumber(sal)
                    Notification(src, _U['reception_updateSalarySenderMsg']:format(tostring(sal)))
                    if xTarget then
                        Notification(xTarget.source, _U['reception_updateSalaryTakerMsg']:format(tostring(sal)))
                        SendLog(src, _U['log_updateSalary']:format(GetPlayerName(src), GetPlayerName(xTarget.source), tostring(sal)).."\n"..GetProperty(xTarget.source, _U['log_player']).."\n"..GetProperty(src, _U['motel_owner']), _U['log_updateSal'], tonumber('720640'), Cfg.LogWebHooks['Set Employee Salary'])
                    else
                        ExecuteSQL("UPDATE motels_employee SET salary = '"..tonumber(sal).."' WHERE employee = '"..target.."'")
                        SendLog(src, _U['log_updateSalary']:format(GetPlayerName(src), target, tostring(sal)).."\n"..GetProperty(src, _U['motel_owner']), _U['log_updateSal'], tonumber('720640'), Cfg.LogWebHooks['Set Employee Salary'])
                    end
                else
                    Notification(src, _U['reception_notplayerdata'])
                end
            end
        else
            Notification(src, _U['notfoundedplayer'])
        end
    end
    TriggerEvent('pw-motelsbusiness:GetEmployeesData')
end)

RegisterNetEvent('pw-motelsbusiness:DeleteMotelFromPlayer')
AddEventHandler('pw-motelsbusiness:DeleteMotelFromPlayer', function(target)
    local src = source
    if target and PlayersMotels[target] then
        local xTarget = GetPlayerFrom(target)
        if xTarget then
            TriggerClientEvent('pw-motelsbusiness:StopRentCycle', xTarget.source, true)
            SendLog(src, _U['log_deletemotelfromplayer']:format(GetPlayerName(xTarget.source), GetPlayerName(src), PlayersMotels[target].motel, PlayersMotels[target].motelid).."\n"..GetProperty(xTarget.source, _U['log_player']).."\n"..GetProperty(src, _U['motel_owner']), _U['log_deletemotelfrom'], tonumber('12715269'), Cfg.LogWebHooks['Delete Motel'])
            PlayersMotels[target] = nil
            Notification(xTarget.source, _U['reception_Customerkicked'])
            Notification(src, _U['reception_deletedMotelRoom']:format(GetPlayerName(xTarget.source)))
            local result = FetchSQL("SELECT owner FROM motels WHERE owner = '"..Identifier(xTarget).."'")
            if result and result[1] then
                ExecuteSQL("DELETE FROM motels WHERE owner = '"..Identifier(xTarget).."'")
            end
        else
            SendLog(src, _U['log_deletemotelfromplayer']:format(target, GetPlayerName(src), PlayersMotels[target].motel, PlayersMotels[target].motelid).."\n"..GetProperty(src, _U['motel_owner']), _U['log_deletemotelfrom'], tonumber('12715269'), Cfg.LogWebHooks['Delete Motel'])
            PlayersMotels[target] = nil
            Notification(src, _U['reception_deletedMotelRoom']:format(target))
            ExecuteSQL("DELETE FROM motels WHERE owner = '"..target.."'")
        end
        TriggerEvent('pw-motelsbusiness:GetPlayersData')
    else
        Notification(src, _U['not_foundedid'])
    end
end)

RegisterNetEvent('pw-motelsbusiness:CreateNewKey')
AddEventHandler('pw-motelsbusiness:CreateNewKey', function(target)
    local src = source
    if src then
        if target then
            local xTarget = GetPlayerFrom(target)
            if xTarget then
                if Cfg.metasystem or Cfg.QBCore then
                    if PlayersMotels[target] then
                        local lb = GetPlayerFromId(src)
                        if lb then
                            local info = {}
                            local namecharacter = PlayerName(target)
                            info.code = 'PW-'..tostring(RandomInt(tonumber('4')) .. RandomInt(tonumber('3')) .. RandomInt(tonumber('2')) .. RandomInt(tonumber('3')) .. RandomStr(tonumber('4')))
                            info.motel = PlayersMotels[target].motel..'-'..PlayersMotels[target].motelid
                            info.steam = target
                            info.chuphong = namecharacter.firstname.."-"..namecharacter.lastname
                            if not Cfg.QBCore then
                                info.description = 'Motel ID: '..info.motel
                            end
                            if Cfg.QBCore then
                                AddInventoryItem(src, Cfg.metaitem, tonumber('1'), false, info)
                            else
                                AddInventoryItem(src, Cfg.metaitem, tonumber('1'), info)
                            end
                            MotelsRemoveMoney(PlayersMotels[target].motel, MX[PlayersMotels[target].motel].takeKeyExp)
                            Notification(src, _U['reception_createdRoomKey'])
                            if xTarget then
                                SendLog(src, _U['log_createNewKey']:format(GetPlayerName(src), PlayersMotels[target].motel, PlayersMotels[target].motelid, GetPlayerName(xTarget.source)).."\n"..GetProperty(xTarget.source, _U['log_player']).."\n"..GetProperty(src, _U['motel_owner']), _U['log_createdNewKey'], tonumber('6347265'), Cfg.LogWebHooks['Create New Key'])
                            else
                                SendLog(src, _U['log_createNewKey']:format(GetPlayerName(src), PlayersMotels[target].motel, PlayersMotels[target].motelid, target).."\n"..GetProperty(src, _U['motel_owner']), _U['log_createdNewKey'], tonumber('6347265'), Cfg.LogWebHooks['Create New Key'])
                                ExecuteSQL("UPDATE motels SET uniq = '"..PlayersMotels[target].uniq.."' WHERE owner = '"..target.."'")
                            end
                            PlayersMotels[target].uniq = info.code
                        end
                    else
                        print('^1 [PW-MOTELS] ^0 To use the metadata system, you must purchase mx-base. \n For information : https://discord.gg/davU2SY \n or MOXHA#4250')
                    end
                end
            else
                Notification(src, _U['reception_notIngame'])
            end
        end
    end
    TriggerEvent('pw-motelsbusiness:GetPlayersData')
end)

RegisterNetEvent('pw-motelsbusiness:TimeRefreshFromReception')
AddEventHandler('pw-motelsbusiness:TimeRefreshFromReception', function(target, time, method, expense)
    local src = source
    if target and time and method and expense then
        local timethod = method == 1 and 60000 or method == 2 and 3600000
        if PlayersMotels[target] then
            local xTarget = GetPlayerFrom(target)
            if xTarget then
                TriggerClientEvent('pw-motelsbusiness:StopRentCycle', xTarget.source, true, {
                    target = target,
                    time = time,
                    timethod = timethod,
                    expense = expense,
                    source = xTarget.source
                })
                Notification(src, _U['reception_sucresetTime'])
                SendLog(src, _U['log_timerefreshfromplayer']:format(GetPlayerName(xTarget.source), GetPlayerName(src), PlayersMotels[target].motel, PlayersMotels[target].motelid, PlayersMotels[target].rentcycle, tostring(tonumber(math.floor(time * timethod)))).."\n"..GetProperty(xTarget.source, _U['log_player']).."\n"..GetProperty(src, _U['motel_owner']), _U['log_timerefreshfrom'], tonumber('6347265'), Cfg.LogWebHooks['Refresh Rent Motel'])
            else 
                SendLog(src, _U['log_timerefreshfromplayer']:format(target, GetPlayerName(src), PlayersMotels[target].motel, PlayersMotels[target].motelid, PlayersMotels[target].rentcycle, tostring(tonumber(math.floor(time * timethod)))).."\n"..GetProperty(src, _U['motel_owner']), _U['log_timerefreshfrom'], tonumber('6347265'), Cfg.LogWebHooks['Refresh Rent Motel'])
                Notification(src, _U['reception_sucresetTime'])
                PlayersMotels[target].rentcycle = tonumber(math.floor(time * timethod))
                PlayersMotels[target].pay = expense
                ExecuteSQL("UPDATE motels SET rentcycle = '"..tostring(math.floor(time * timethod)).."', pay = '"..expense.."' WHERE owner = '"..target.."'")
            end
        else
            Notification(src, _U['reception_notplayerdata'])
        end
    end
end)

RegisterNetEvent('pw-motelsbusiness:StoppedRent')
AddEventHandler('pw-motelsbusiness:StoppedRent', function (data)
    if not data then return false end
    PlayersMotels[data.target].rentcycle = tonumber(math.floor(data.time * data.timethod))
    PlayersMotels[data.target].pay = data.expense
    TriggerClientEvent('pw-motelsbusiness:StartRentCycle', data.source, PlayersMotels[data.target].rentcycle)
end)

RegisterNetEvent('pw-motelsbusiness:leftRoom')
AddEventHandler('pw-motelsbusiness:leftRoom', function()
    local src = source
    if src then
        local player = GetPlayerFromId(src)
        if player then
            if PlayersMotels[Identifier(player)] then
                local veri = PlayerName(player)
                veri.motel = PlayersMotels[Identifier(player)].motel
                TriggerEvent('pw-motelsbusiness:SaveTransaction', 'leftRoom', veri)
                PlayersMotels[Identifier(player)] = nil
                local result = FetchSQL("SELECT owner FROM motels WHERE owner = '"..Identifier(player).."'")
                if result and result[1] then
                    ExecuteSQL("DELETE FROM motels WHERE owner = '"..Identifier(player).."'")
                end
                Notification(src, _U['reception_leftedRoom'])
                SendLog(src, _U['log_leftMotel']:format(GetPlayerName(src), veri.motel)..'\n'..GetProperty(src, _U['log_player']), _U['log_leftMotelR'], tonumber('16727296'), Cfg.LogWebHooks['Left Motel'])
            else
                Notification(src, _U['reception_notplayerdata'])
            end
            TriggerEvent('pw-motelsbusiness:GetPlayersData')
        end
    end
end)

function SaveAll()
    if next(PlayersMotels) then
        local total = 0
        for k,v in pairs(PlayersMotels) do
            total = total + 1
            local result = FetchSQL("SELECT motelid FROM motels WHERE owner = '"..k.."'")
            if result and result[tonumber('1')] then
                ExecuteSQL("UPDATE motels SET suspended = '"..v.suspended.."', pay = '"..v.pay.."', motel = '"..v.motel.."', motelid = '"..v.motelid.."', rentcycle = '"..tostring(v.rentcycle).."', uniq = '"..v.uniq.."', requests = '"..json.encode(v.requests).."' WHERE owner = '"..k.."'")
            else
                ExecuteSQL("INSERT INTO motels (owner, pay, motel, motelid, rentcycle, uniq, requests, suspended) VALUES ('"..k.."', '"..v.pay.."', '"..v.motel.."', '"..v.motelid.."', '"..v.rentcycle.."', '"..v.uniq.."', '"..json.encode(v.requests).."', '"..v.suspended.."')")
            end
        end
        print('^1 [PW-MOTELS] ^0 Saved ^2'..total..'^1 Customer(s) ^0')
    end
    if Cfg.Employee.active then
        if next(EmployeeMotels) then
            local total = 0
            for k,v in pairs(EmployeeMotels) do
                total = total + 1
                local result = FetchSQL("SELECT motel FROM motels_employee WHERE employee = '"..k.."'")
                if result and result[tonumber('1')] then
                    ExecuteSQL("UPDATE motels_employee SET motel = '"..v.motel.."', salary = '"..v.salary.."', pay = '"..v.pay.."', permissions = '"..json.encode(v.permissions).."' WHERE employee = '"..k.."'")
                else
                    ExecuteSQL("INSERT INTO motels_employee (employee, motel, salary, pay, permissions) VALUES ('"..k.."', '"..v.motel.."', '"..v.salary.."', '"..v.pay.."', '"..json.encode(v.permissions).."')")
                end
            end
            print('^1 [PW-MOTELS] ^0 Saved ^2'..total..'^1 Employee(s) ^0')
        end
    end
    if Cfg.society.active then
        if next(MotelsMoney) then
            for k,v in pairs(MotelsMoney) do
                local result = FetchSQL("SELECT motel FROM motels_money WHERE motel = '"..k.."'")
                if result and result[tonumber('1')] then
                    ExecuteSQL("UPDATE motels_money SET money = '"..v.money.."' WHERE motel = '"..k.."'")
                else
                    ExecuteSQL("INSERT INTO motels_money (motel, money) VALUES ('"..k.."', '"..v.money.."')")
                end
            end
        end
    end
    if Cfg.bill.active then
        if next(MotelsBill) then
            local total = 0
            for k,v in pairs(MotelsBill) do
                total = total+1
                local result = FetchSQL("SELECT owner FROM motels_bill WHERE owner = '"..k.."'")
                if result and result[tonumber('1')] then
                    ExecuteSQL("UPDATE motels_bill SET data = '"..json.encode(v.data).."'")
                else
                    ExecuteSQL("INSERT INTO motels_bill (owner, data) VALUES ('"..k.."', '"..json.encode(v.data).."')")
                end
            end 
            print('^1 [PW-MOTELS] ^0 Saved ^2'..total..'^1 Bill(s) ^0')
        end
    end
    print('^1 [PW-MOTELS] ^0 '.._U['allplayer_saved'])
    AutoSave()
end

if Cfg.AdminOptions.setMotelOwnerCommand then
    if Cfg.AdminOptions.privateAdmin and Cfg.AdminOptions.privatePermission then
        print('^1 [PW-MOTELS] ^0 '.._U['admincommands_wronguse'])
        return false 
    end
    if Cfg.AdminOptions.privatePermission then
        if Cfg.AdminOptions.privatePermissions[tonumber('1')] == nil then
            print('^1 [PW-MOTELS] ^0 '.._U['admincommands_wronguse2'])
            return false
        end
        RegisterCommand(Cfg.AdminOptions.setMotelOwnerCommand, function(source, args)
            local me = GetPlayerFromId(source)
            if me then
                if AccessCheck(me) then
                    if args[1] and args[2] then
                        local player = GetPlayerFromId(args[1])
                        if player then
                            local motelName = {}
                            for i = tonumber('2'), #args do
                                table.insert(motelName, args[i])
                            end
                            TriggerClientEvent('pw-motelsbusiness:setMotelOwner', source, args[1], table.concat(motelName, ' '))
                        else
                            Notification(source, _U['reception_notplayerfound'])
                        end
                    else
                        Notification(source, _U['space'])
                    end
                else
                    Notification(source, 'Access Denied')
                end
            end
        end)
    elseif Cfg.AdminOptions.privateAdmin then
        if Cfg.AdminOptions.privateAdmins[tonumber('1')] == nil then
            print('^1 [PW-MOTELS] ^0 '.._U['admincommands_wronguse3'])
            return false
        end
        RegisterCommand(Cfg.AdminOptions.setMotelOwnerCommand, function(source, args)
            local me = GetPlayerFromId(source)
            if me then
                local founded = false
                for k,v in pairs(Cfg.AdminOptions.privateAdmins) do
                    if v == Identifier(xPlayer) then
                        founded = true
                    end
                end
                if not founded then
                    return Notification(_U['setmotelowner_notFoundedAdmin'])
                end
                if args[tonumber('1')] and args[tonumber('2')] then
                    local player = GetPlayerFromId(args[tonumber('1')])
                    if player then
                        local motelName = {}
                        for i = tonumber('2'), #args, tonumber('1') do
                            table.insert(motelName, args[i])
                        end
                        TriggerClientEvent('pw-motelsbusiness:setMotelOwner', source, args[tonumber('1')], table.concat(motelName, ' '))
                    else
                        Notification(source, _U['reception_notplayerfound'])
                    end
                else
                    Notification(source, _U['space'])
                end
            end
        end)
    end
end

if Cfg.QBCore then
    ESX.Functions.CreateUseableItem(Cfg.metaitem, function(source, item)
        local player = GetPlayerFromId(source)
        if player then
            TriggerClientEvent('pw-motelsbusiness:UseKey', source, item)
        end
    end) 
end

if not Cfg.QBCore then
	ESX.RegisterUsableItem(Cfg.metaitem, function(source, item)
		TriggerClientEvent('pw-motelsbusiness:UseKey', source, item)
	end)
end