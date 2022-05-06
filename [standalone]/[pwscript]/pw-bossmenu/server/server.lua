ESX = nil
Accounts = {}
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

CreateThread(function()
    Wait(500)
    local result = json.decode(LoadResourceFile(GetCurrentResourceName(), "./database.json"))

    if not result then
        return
    end

    for k,v in pairs(result) do
        local k = tostring(k)
        local v = tonumber(v)

        if k and v then
            Accounts[k] = v
        end
    end
end)

RegisterServerEvent("pw-bossmenu:server:withdrawMoney")
AddEventHandler("pw-bossmenu:server:withdrawMoney", function(amount)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local job = xPlayer.getJob().name

    if not Accounts[job] then
        Accounts[job] = 0
    end

    if Accounts[job] >= amount then
        Accounts[job] = Accounts[job] - amount    
		xPlayer.addAccountMoney('money', amount)
    else
        TriggerClientEvent('ESX:Notify', src, "Invaild Amount :/", "error")
        return
    end

    TriggerClientEvent('pw-bossmenu:client:refreshSociety', -1, job, Accounts[job])
    SaveResourceFile(GetCurrentResourceName(), "./database.json", json.encode(Accounts), -1)
    --TriggerEvent('bb-logs:server:createLog', 'bossmenu', 'Withdraw Money', "Successfully withdrawn $" .. amount .. ' (' .. job .. ')', src)
end)

RegisterServerEvent("pw-bossmenu:server:depositMoney")
AddEventHandler("pw-bossmenu:server:depositMoney", function(amount)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local job = xPlayer.getJob().name

    if not Accounts[job] then
        Accounts[job] = 0
    end

    if xPlayer.getAccount("money").money > amount then
		xPlayer.removeAccountMoney("money", amount)		
        Accounts[job] = Accounts[job] + amount
    else
        TriggerClientEvent('ESX:Notify', src, "Số lượng sai :/", "error")
        return
    end

    TriggerClientEvent('pw-bossmenu:client:refreshSociety', -1, job, Accounts[job])
    SaveResourceFile(GetCurrentResourceName(), "./database.json", json.encode(Accounts), -1)
    --TriggerEvent('bb-logs:server:createLog', 'bossmenu', 'Deposit Money', "Successfully deposited $" .. amount .. ' (' .. job .. ')', src)
end)

RegisterServerEvent("pw-bossmenu:server:addAccountMoney")
AddEventHandler("pw-bossmenu:server:addAccountMoney", function(account, amount)
    if not Accounts[account] then
        Accounts[account] = 0
    end
    
    Accounts[account] = Accounts[account] + amount
    TriggerClientEvent('pw-bossmenu:client:refreshSociety', -1, account, Accounts[account])
    SaveResourceFile(GetCurrentResourceName(), "./database.json", json.encode(Accounts), -1)
end)

RegisterServerEvent("pw-bossmenu:server:removeAccountMoney")
AddEventHandler("pw-bossmenu:server:removeAccountMoney", function(account, amount)
    if not Accounts[account] then
        Accounts[account] = 0
    end

    if Accounts[account] >= amount then
        Accounts[account] = Accounts[account] - amount
    end

    TriggerClientEvent('pw-bossmenu:client:refreshSociety', -1, account, Accounts[account])
    SaveResourceFile(GetCurrentResourceName(), "./database.json", json.encode(Accounts), -1)
end)

RegisterServerEvent("pw-bossmenu:server:openMenu")
AddEventHandler("pw-bossmenu:server:openMenu", function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local job = xPlayer.getJob()
    local employees = {}
    if job.grade_name == 'boss' then
        if not Accounts[job.name] then
            Accounts[job.name] = 0
        end

        exports['ghmattimysql']:execute("SELECT * FROM `users` WHERE `job` = '" .. job.name .. "'", function(players)
            if players[1] ~= nil then
                for key, value in pairs(players) do
                    local xPlayerid = ESX.GetPlayerFromIdCard(value.id)
					--print(key,value)
                    if xPlayerid then
                        table.insert(employees, {
                            source = xPlayerid.id, 
                            grade = xPlayerid.job.grade,
							gradeLabel = Config.jobgrade[value.job].grades[tostring(value.job_grade)].name,
                            isboss = Config.jobgrade[value.job].grades[tostring(value.job_grade)].isBoss,
                            name = value.firstname .. ' ' .. value.lastname
                        })
                    else
                        table.insert(employees, {
                            source = value.id, 
                            grade =  value.job_grade,
							gradeLabel = Config.jobgrade[value.job].grades[tostring(value.job_grade)].name,
                            isboss = Config.jobgrade[value.job].grades[tostring(value.job_grade)].isBoss,
                            name = value.firstname .. ' ' .. value.lastname
                        })
                    end
                end
            end

            TriggerClientEvent('pw-bossmenu:client:openMenu', src, employees, Config.jobgrade[job.name])
            TriggerClientEvent('pw-bossmenu:client:refreshSociety', -1, job.name, Accounts[job.name])
        end)
    else
        TriggerClientEvent('ESX:Notify', src, "Có lỗi xảy ra. làm sao bạn có thể vào đây?!", "error")
    end
end)

RegisterServerEvent('pw-bossmenu:server:fireEmployee')
AddEventHandler('pw-bossmenu:server:fireEmployee', function(data)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
	local job = xPlayer.getJob() 
    local xEmployee = ESX.GetPlayerFromIdCard(data.source)

    if xEmployee then
        if xEmployee then
			xEmployee.setJob("unemployed", '0')
			exports['ghmattimysql']:execute( "UPDATE `users` SET `job` = 'unemployed',`job_grade` = '0' WHERE `id` = '".. data.source .."'")	
            TriggerClientEvent('ESX:Notify', src, "Đuổi ra thành công!", "success")
            TriggerClientEvent('ESX:Notify', xEmployee.source , "Bạn đã bị đuổi khỏi.", "success")

            Wait(500)
            local employees = {}
            exports['ghmattimysql']:execute( "SELECT * FROM `users` WHERE `job` = '" .. job.name .. "'", function(players)
                if players[1] ~= nil then
                    for key, value in pairs(players) do
						local xPlayerid = ESX.GetPlayerFromIdCard(value.id)
						
						if xPlayerid then
							table.insert(employees, {
								source = xPlayerid.id, 
								grade = xPlayerid.job.grade,
								gradeLabel = Config.jobgrade[value.job].grades[tostring(value.job_grade)].name,
								isboss = Config.jobgrade[value.job].grades[tostring(value.job_grade)].isboss,
								name = value.firstname .. ' ' .. value.lastname
							})
						else
							table.insert(employees, {
								source = value.id, 
								grade =  value.job_grade,
								gradeLabel = Config.jobgrade[value.job].grades[tostring(value.job_grade)].name,
								isboss = Config.jobgrade[value.job].grades[tostring(value.job_grade)].isboss,
								name = value.firstname .. ' ' .. value.lastname
							})
						end
					end

					TriggerClientEvent('pw-bossmenu:client:refreshPage', src, 'employee', employees)
                end
            end)
        else
            TriggerClientEvent('ESX:Notify', src, "Error.", "error")
        end
    else
        exports['ghmattimysql']:execute( "SELECT * FROM `users` WHERE `id` = '" .. data.source .. "' LIMIT 1", function(player)
            if player[1] ~= nil then
                xEmployee = player[1]
				

                exports['ghmattimysql']:execute( "UPDATE `users` SET `job` = 'unemployed',`job_grade` = '0' WHERE `id` = '".. data.source .."'")
                TriggerClientEvent('ESX:Notify', src, "Bạn đã đuổi thành công!", "success")
                --TriggerEvent('bb-logs:server:createLog', 'bossmenu', 'Fire', "Successfully fired " .. data.source .. ' (' .. xPlayer.PlayerData.job.name .. ')', src)
                
                Wait(500)
                local employees = {}
                exports['ghmattimysql']:execute( "SELECT * FROM `users` WHERE `job` LIKE '%".. job.name .."%'", function(players)
                    if players[1] ~= nil then
                        for key, value in pairs(players) do
							local xPlayerid = ESX.GetPlayerFromIdCard(value.id)
							
							if xPlayerid then
								table.insert(employees, {
									source = xPlayerid.id, 
									grade = xPlayerid.job.grade,
									gradeLabel = Config.jobgrade[value.job].grades[tostring(value.job_grade)].name,
									isboss = Config.jobgrade[value.job].grades[tostring(value.job_grade)].isboss,
									name = value.firstname .. ' ' .. value.lastname
								})
							else
								table.insert(employees, {
									source = value.id, 
									grade =  value.job_grade,
									gradeLabel = Config.jobgrade[value.job].grades[tostring(value.job_grade)].name,
									isboss = Config.jobgrade[value.job].grades[tostring(value.job_grade)].isboss,
									name = value.firstname .. ' ' .. value.lastname
								})
							end
						end
						
                        TriggerClientEvent('pw-bossmenu:client:refreshPage', src, 'employee', employees)
                    end
                end)
            else
                TriggerClientEvent('ESX:Notify', src, "Error. Không thể tìm thấy người chơi.", "error")
            end
        end)
    end
end)

RegisterServerEvent('pw-bossmenu:server:giveJob')
AddEventHandler('pw-bossmenu:server:giveJob', function(data)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
	local job = xPlayer.getJob()
    local xTarget = ESX.GetPlayerFromIdCard(data.source)
    if job.grade_name == 'boss' then
	
        if xTarget then
			xTarget.setJob(job.name, '0')
            TriggerClientEvent('ESX:Notify', src, "Bạn đã tuyển " .. xTarget.getName() .. " vào làm việc " .. job.label .. ".", "success")
            TriggerClientEvent('ESX:Notify', xTarget.source , "Bạn đã được tuyển dụng vào công việc: " .. job.label .. ".", "success")
			exports['ghmattimysql']:execute( "UPDATE `users` SET `job` = '"..job.name.."',`job_grade` = '0' WHERE `id` = '".. data.source .."'")
            --TriggerEvent('bb-logs:server:createLog', 'bossmenu', 'Recruit', "Successfully recruited " .. (xTarget.PlayerData.charinfo.firstname .. ' ' .. xTarget.PlayerData.charinfo.lastname) .. ' (' .. job .. ')', src)

			
        end
    else
        TriggerClientEvent('ESX:Notify', src, "Có lỗi xảy ra. làm sao bạn có thể vào đây??!", "error")
    end
end)

RegisterServerEvent('pw-bossmenu:server:updateGrade')
AddEventHandler('pw-bossmenu:server:updateGrade', function(data)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
	local job = xPlayer.getJob()
    local xEmployee = ESX.GetPlayerFromIdCard(data.source)

    if xEmployee then
        if xEmployee then
			xEmployee.setJob(job.name, data.grade)
			exports['ghmattimysql']:execute( "UPDATE `users` SET `job` = '"..job.name.."',`job_grade` = '"..data.grade.."' WHERE `id` = '".. data.source .."'")	
            TriggerClientEvent('ESX:Notify', src, "Thăng/Hạ cấp thành công!", "success")
            TriggerClientEvent('ESX:Notify', xEmployee.source , "Bạn vừa được̣ bổ nhiệm chức vụ [" .. data.grade .."].", "success")

            Wait(500)
            local employees = {}
            exports['ghmattimysql']:execute( "SELECT * FROM `users` WHERE `job` LIKE '%".. job.name .."%'", function(players)
                if players[1] ~= nil then
					for key, value in pairs(players) do
						local xPlayerid = ESX.GetPlayerFromIdCard(value.id)
						
						if xPlayerid then
							table.insert(employees, {
								source = xPlayerid.id, 
								grade = xPlayerid.job.grade,
								gradeLabel = Config.jobgrade[value.job].grades[tostring(value.job_grade)].name,
								isboss = Config.jobgrade[value.job].grades[tostring(value.job_grade)].isboss,
								name = value.firstname .. ' ' .. value.lastname
							})
						else
							table.insert(employees, {
								source = value.id, 
								grade =  value.job_grade,
								gradeLabel = Config.jobgrade[value.job].grades[tostring(value.job_grade)].name,
								isboss = Config.jobgrade[value.job].grades[tostring(value.job_grade)].isboss,
								name = value.firstname .. ' ' .. value.lastname
							})
						end
					end

					TriggerClientEvent('pw-bossmenu:client:refreshPage', src, 'employee', employees)
				end
            end)
        else
            TriggerClientEvent('ESX:Notify', src, "Error.", "error")
        end
    else
        exports['ghmattimysql']:execute( "SELECT * FROM `users` WHERE `id` = '" .. data.source .. "' LIMIT 1", function(player)
            if player[1] ~= nil then
                xEmployee = player[1]
                exports['ghmattimysql']:execute( "UPDATE `users` SET `job_grade` = '"..data.grade.."' WHERE `id` = '".. data.source .."'")
                TriggerClientEvent('ESX:Notify', src, "Thăng/Hạ cấp thành công!", "success")
                
                Wait(500)
                local employees = {}
                exports['ghmattimysql']:execute("SELECT * FROM `users` WHERE `job` LIKE '%".. job.name .."%'", function(players)
                    if players[1] ~= nil then
                        for key, value in pairs(players) do
							local xPlayerid = ESX.GetPlayerFromIdCard(value.id)
							
							if xPlayerid then
								table.insert(employees, {
									source = xPlayerid.id, 
									grade = xPlayerid.job.grade,
									gradeLabel = Config.jobgrade[value.job].grades[tostring(value.job_grade)].name,
									isboss = Config.jobgrade[value.job].grades[tostring(value.job_grade)].isboss,
									name = value.firstname .. ' ' .. value.lastname
								})
							else
								table.insert(employees, {
									source = value.id, 
									grade =  value.job_grade,
									gradeLabel = Config.jobgrade[value.job].grades[tostring(value.job_grade)].name,
									isboss = Config.jobgrade[value.job].grades[tostring(value.job_grade)].isboss,
									name = value.firstname .. ' ' .. value.lastname
								})
							end
						end
						
                        TriggerClientEvent('pw-bossmenu:client:refreshPage', src, 'employee', employees)
                    end
                end)
            else
                TriggerClientEvent('ESX:Notify', src, "Error. Không tìm thấy người chơi.", "error")
            end
        end)
    end
end)

RegisterServerEvent('pw-bossmenu:server:updateNearbys')
AddEventHandler('pw-bossmenu:server:updateNearbys', function(data)
    local src = source
    local players = {}
    local xPlayer = ESX.GetPlayerFromId(src)
    for _, player in pairs(data) do
        local xTarget = ESX.GetPlayerFromId(player)
		local job = xTarget.getJob()
        if xTarget and job.name ~= xPlayer.getJob().name then
            table.insert(players, {
                source = xTarget.id,
                name = xTarget.getName()
            })
        end
    end

    TriggerClientEvent('pw-bossmenu:client:refreshPage', src, 'recruits', players)
end)

function GetAccount(account)
    return Accounts[account] or 0
end