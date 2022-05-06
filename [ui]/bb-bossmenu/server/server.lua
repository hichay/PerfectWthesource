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

RegisterServerEvent("bb-bossmenu:server:withdrawMoney")
AddEventHandler("bb-bossmenu:server:withdrawMoney", function(amount)
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

    TriggerClientEvent('bb-bossmenu:client:refreshSociety', -1, job, Accounts[job])
    SaveResourceFile(GetCurrentResourceName(), "./database.json", json.encode(Accounts), -1)
    --TriggerEvent('bb-logs:server:createLog', 'bossmenu', 'Withdraw Money', "Successfully withdrawn $" .. amount .. ' (' .. job .. ')', src)
end)

RegisterServerEvent("bb-bossmenu:server:depositMoney")
AddEventHandler("bb-bossmenu:server:depositMoney", function(amount)
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
        TriggerClientEvent('ESX:Notify', src, "Invaild Amount :/", "error")
        return
    end

    TriggerClientEvent('bb-bossmenu:client:refreshSociety', -1, job, Accounts[job])
    SaveResourceFile(GetCurrentResourceName(), "./database.json", json.encode(Accounts), -1)
    --TriggerEvent('bb-logs:server:createLog', 'bossmenu', 'Deposit Money', "Successfully deposited $" .. amount .. ' (' .. job .. ')', src)
end)

RegisterServerEvent("bb-bossmenu:server:addAccountMoney")
AddEventHandler("bb-bossmenu:server:addAccountMoney", function(account, amount)
    if not Accounts[account] then
        Accounts[account] = 0
    end
    
    Accounts[account] = Accounts[account] + amount
    TriggerClientEvent('bb-bossmenu:client:refreshSociety', -1, account, Accounts[account])
    SaveResourceFile(GetCurrentResourceName(), "./database.json", json.encode(Accounts), -1)
end)

RegisterServerEvent("bb-bossmenu:server:removeAccountMoney")
AddEventHandler("bb-bossmenu:server:removeAccountMoney", function(account, amount)
    if not Accounts[account] then
        Accounts[account] = 0
    end

    if Accounts[account] >= amount then
        Accounts[account] = Accounts[account] - amount
    end

    TriggerClientEvent('bb-bossmenu:client:refreshSociety', -1, account, Accounts[account])
    SaveResourceFile(GetCurrentResourceName(), "./database.json", json.encode(Accounts), -1)
end)

RegisterServerEvent("bb-bossmenu:server:openMenu")
AddEventHandler("bb-bossmenu:server:openMenu", function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local job = xPlayer.getJob()
    local employees = {}
    if job.grade_name == 'boss' then
        if not Accounts[job.name] then
            Accounts[job.name] = 0
        end

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
            end

            TriggerClientEvent('bb-bossmenu:client:openMenu', src, employees, Config.jobgrade[job.name])
            TriggerClientEvent('bb-bossmenu:client:refreshSociety', -1, job.name, Accounts[job.name])
        end)
    else
        TriggerClientEvent('ESX:Notify', src, "You are not the boss, how did you reach here bitch?!", "error")
    end
end)

RegisterServerEvent('bb-bossmenu:server:fireEmployee')
AddEventHandler('bb-bossmenu:server:fireEmployee', function(data)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
	local job = xPlayer.getJob() 
	print(data.source)
    local xEmployee = ESX.GetPlayerFromIdCard(data.source)

    if xEmployee then
        if xEmployee then
			xEmployee.setJob("unemployed", '0')
			exports['ghmattimysql']:execute( "UPDATE `users` SET `job` = 'unemployed',`job_grade` = '0' WHERE `id` = '".. data.source .."'")	
            TriggerClientEvent('ESX:Notify', src, "Fired successfully!", "success")
            TriggerClientEvent('ESX:Notify', xEmployee.source , "You got fired.", "success")

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

					TriggerClientEvent('bb-bossmenu:client:refreshPage', src, 'employee', employees)
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
                TriggerClientEvent('ESX:Notify', src, "Fired successfully xa thai thanh cong!", "success")
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
						
                        TriggerClientEvent('bb-bossmenu:client:refreshPage', src, 'employee', employees)
                    end
                end)
            else
                TriggerClientEvent('ESX:Notify', src, "Error. Could not find player.", "error")
            end
        end)
    end
end)

RegisterServerEvent('bb-bossmenu:server:giveJob')
AddEventHandler('bb-bossmenu:server:giveJob', function(data)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
	local job = xPlayer.getJob()
    local xTarget = ESX.GetPlayerFromIdCard(data.source)
	print('give job')
	print(data.source)
    if job.grade_name == 'boss' then
	
        if xTarget then
			xTarget.setJob(job.name, '0')
            TriggerClientEvent('ESX:Notify', src, "You recruit " .. xTarget.getName() .. " to " .. job.label .. ".", "success")
            TriggerClientEvent('ESX:Notify', xTarget.source , "You've been recruited to " .. job.label .. ".", "success")
			exports['ghmattimysql']:execute( "UPDATE `users` SET `job` = '"..job.name.."',`job_grade` = '0' WHERE `id` = '".. data.source .."'")
            --TriggerEvent('bb-logs:server:createLog', 'bossmenu', 'Recruit', "Successfully recruited " .. (xTarget.PlayerData.charinfo.firstname .. ' ' .. xTarget.PlayerData.charinfo.lastname) .. ' (' .. job .. ')', src)

			
        end
    else
        TriggerClientEvent('ESX:Notify', src, "You are not the boss, how did you reach here bitch?!", "error")
    end
end)

RegisterServerEvent('bb-bossmenu:server:updateGrade')
AddEventHandler('bb-bossmenu:server:updateGrade', function(data)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
	local job = xPlayer.getJob()
    local xEmployee = ESX.GetPlayerFromIdCard(data.source)

    if xEmployee then
        if xEmployee then
			xEmployee.setJob(job.name, data.grade)
			exports['ghmattimysql']:execute( "UPDATE `users` SET `job` = '"..job.name.."',`job_grade` = '"..data.grade.."' WHERE `id` = '".. data.source .."'")	
            TriggerClientEvent('ESX:Notify', src, "Promoted successfully!", "success")
            TriggerClientEvent('ESX:Notify', xEmployee.source , "You just got promoted [" .. data.grade .."].", "success")

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

					TriggerClientEvent('bb-bossmenu:client:refreshPage', src, 'employee', employees)
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
                TriggerClientEvent('ESX:Notify', src, "Promoted successfully!", "success")
                
                Wait(500)
                local employees = {}
                exports['ghmattimysql']:execute("SELECT * FROM `users` WHERE `job` LIKE '%".. job.name .."%'", function(players)
                    if players[1] ~= nil then
						print('ok tao dang chay')
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
						
                        TriggerClientEvent('bb-bossmenu:client:refreshPage', src, 'employee', employees)
                    end
                end)
            else
                TriggerClientEvent('ESX:Notify', src, "Error. Could not find player.", "error")
            end
        end)
    end
end)

RegisterServerEvent('bb-bossmenu:server:updateNearbys')
AddEventHandler('bb-bossmenu:server:updateNearbys', function(data)
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

    TriggerClientEvent('bb-bossmenu:client:refreshPage', src, 'recruits', players)
end)

function GetAccount(account)
    return Accounts[account] or 0
end