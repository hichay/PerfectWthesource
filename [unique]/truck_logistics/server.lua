ESX 					= nil
TriggerEvent(Config.ESXSHAREDOBJECT, function(obj) ESX = obj end)

local vrp_ready = true
function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

Citizen.CreateThread(function()
	Wait(5000)
	-- MySQL.query([[
		-- CREATE TABLE IF NOT EXISTS `trucker_available_contracts` (
			-- `contract_id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
			-- `contract_type` BIT(1) NOT NULL DEFAULT b'0',
			-- `contract_name` VARCHAR(50) NOT NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
			-- `coords_index` SMALLINT(6) UNSIGNED NOT NULL DEFAULT '0',
			-- `price_per_km` INT(10) UNSIGNED NOT NULL DEFAULT '0',
			-- `cargo_type` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
			-- `fragile` BIT(1) NOT NULL DEFAULT b'0',
			-- `valuable` BIT(1) NOT NULL DEFAULT b'0',
			-- `fast` BIT(1) NOT NULL DEFAULT b'0',
			-- `truck` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
			-- `trailer` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
			-- PRIMARY KEY (`contract_id`) USING BTREE
		-- )
		-- COLLATE='utf8mb4_general_ci'
		-- ENGINE=InnoDB
		-- ;

		-- CREATE TABLE IF NOT EXISTS `trucker_drivers` (
			-- `driver_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
			-- `user_id` VARCHAR(50) NULL DEFAULT NULL,
			-- `name` VARCHAR(50) NOT NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
			-- `product_type` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
			-- `distance` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
			-- `valuable` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
			-- `fragile` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
			-- `fast` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
			-- `price` INT(10) UNSIGNED NOT NULL DEFAULT '0',
			-- `price_per_km` INT(10) UNSIGNED NOT NULL DEFAULT '0',
			-- `img` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
			-- PRIMARY KEY (`driver_id`) USING BTREE
		-- )
		-- COLLATE='utf8mb4_general_ci'
		-- ENGINE=InnoDB
		-- ;

		-- CREATE TABLE IF NOT EXISTS `trucker_loans` (
			-- `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
			-- `user_id` VARCHAR(50) NOT NULL,
			-- `loan` INT(10) UNSIGNED NOT NULL DEFAULT '0',
			-- `remaining_amount` INT(10) UNSIGNED NOT NULL DEFAULT '0',
			-- `day_cost` INT(10) UNSIGNED NOT NULL DEFAULT '0',
			-- `taxes_on_day` INT(10) UNSIGNED NOT NULL DEFAULT '0',
			-- `timer` INT(10) UNSIGNED NOT NULL DEFAULT '0',
			-- PRIMARY KEY (`id`) USING BTREE
		-- )
		-- COLLATE='utf8mb4_general_ci'
		-- ENGINE=InnoDB
		-- ;

		-- CREATE TABLE IF NOT EXISTS `trucker_trucks` (
			-- `truck_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
			-- `user_id` VARCHAR(50) NOT NULL,
			-- `truck_name` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
			-- `driver` INT(10) UNSIGNED NULL DEFAULT NULL,
			-- `body` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '1000',
			-- `engine` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '1000',
			-- `transmission` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '1000',
			-- `wheels` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '1000',
			-- PRIMARY KEY (`truck_id`) USING BTREE
		-- )
		-- COLLATE='utf8mb4_general_ci'
		-- ENGINE=InnoDB
		-- ;

		-- CREATE TABLE IF NOT EXISTS `trucker_users` (
			-- `user_id` VARCHAR(50) NOT NULL,
			-- `money` INT(10) UNSIGNED NOT NULL DEFAULT '0',
			-- `total_earned` INT(10) UNSIGNED NOT NULL DEFAULT '0',
			-- `finished_deliveries` INT(10) UNSIGNED NOT NULL DEFAULT '0',
			-- `exp` INT(10) UNSIGNED NOT NULL DEFAULT '0',
			-- `traveled_distance` DOUBLE UNSIGNED NOT NULL DEFAULT '0',
			-- `skill_points` INT(10) UNSIGNED NOT NULL DEFAULT '0',
			-- `product_type` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
			-- `distance` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
			-- `valuable` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
			-- `fragile` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
			-- `fast` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
			-- `loan_notify` BIT(1) NOT NULL DEFAULT b'0',
			-- PRIMARY KEY (`user_id`) USING BTREE
		-- )
		-- COLLATE='utf8mb4_general_ci'
		-- ENGINE=InnoDB
		-- ;

	-- ]])
end)

local version = 2
-- Citizen.CreateThread(function()
	-- PerformHttpRequest("https://api.ipify.org?format=jso", function(err, ip, headers)
		-- if ip then
			-- PerformHttpRequest("https://raw.githubusercontent.com/LeonardoSoares98/ips/master/ip_trucker.txt", function(err, database_ips, headers)
				-- local arr_ips = json.decode(database_ips)
				-- for k,v in pairs(arr_ips) do
					-- if k == ip then
						-- vrp_ready = true
						-- if Config.lang == "br" then
							-- print("^2["..GetCurrentResourceName().."] Script autenticado, qualquer duvida entre em contato com Lixeiro Charmoso#1104^7")
						-- else
							-- print("^2["..GetCurrentResourceName().."] Authenticated script, any questions please contact me on Discord Lixeiro Charmoso#1104^7")
						-- end

						-- if arr_ips['version'] ~= version then
							-- if Config.lang == "br" then
								-- print("^2["..GetCurrentResourceName().."] Uma nova atualizacao esta disponivel, entre em contato comigo no Discord Lixeiro Charmoso#1104^7")
							-- else
								-- print("^2["..GetCurrentResourceName().."] A new update is available, contact me on Discord Lixeiro Charmoso#1104^7")
							-- end
						-- end
						-- return
					-- end
				-- end
				-- vrp_ready = false
				-- MySQL = nil
				-- if Config.lang == "br" then
					-- print("^8["..GetCurrentResourceName().."] Seu IP nao esta autenticado, entre em contato com Lixeiro Charmoso#1104^7")
				-- else
					-- print("^8["..GetCurrentResourceName().."] Your IP is not authenticated, contact me on Discord Lixeiro Charmoso#1104^7")
				-- end
				-- SendWebhookMessage("https://discordapp.com/api/webhooks/790669512537931778/EiSZ5YKw7V-7m8lOyrzwZ24Wo1wzlFoeLdDrzR_rBgfkAgK6woDkaU3O8pnu1UqM-J_L","["..GetCurrentResourceName().."]"..ip)
			-- end, "GET", "", {})
		-- else
			-- if Config.lang == "br" then
				-- print("^8["..GetCurrentResourceName().."] Problemas com o servidor. Tente novamente! Qualquer duvida entre em contato com Lixeiro Charmoso#1104^7")
			-- else
				-- print("^8["..GetCurrentResourceName().."] Problems with the server. Try again! Any questions please contact Lixeiro Charmoso#1104^7")
			-- end
		-- end
	-- end, "GET", "", {})
-- end)

-- Gera contratos
Citizen.CreateThread(function()
	Citizen.Wait(10000)
	while true do 
		local contract_type = math.random(0,1)
		local coords_index = math.random(1, #Config.locais_entrega)
		local price_per_km = math.random(Config.contratos.preco_por_km_min, Config.contratos.preco_por_km_max)
		
		local truck = Config.contratos.caminhoes[math.random(1, #Config.contratos.caminhoes)]
		
		local cargas = Config.contratos.cargas[math.random(1, #Config.contratos.cargas)]
		local contract_name = cargas.nome
		local trailer = cargas.carga
		local cargo_type = cargas.def[1]
		local fragile = cargas.def[2]
		local valuable = cargas.def[3]
		
		local carga_urgente = math.random(0,100)
		local fast = 0
		if carga_urgente <= Config.contratos.probabilidade_ser_carga_urgente then
			fast = 1
		end

		if contract_type == 1 then truck = nil end

		local sql = "SELECT COUNT(contract_id) as qtd FROM trucker_available_contracts";
		local count = MySQL.query.await(sql, {})[1].qtd;
		
		if count >= Config.contratos.max_contratos_ativos then
			local sql = "SELECT MIN(contract_id) as min FROM trucker_available_contracts";
			local min = MySQL.query.await(sql, {})[1].min;
			
			local sql = "DELETE FROM `trucker_available_contracts` WHERE contract_id = @contract_id;";
			MySQL.query(sql, {['@contract_id'] = min});
		end

		local sql = "INSERT INTO `trucker_available_contracts` (contract_type, contract_name, coords_index, price_per_km, cargo_type, fragile, valuable, fast, truck, trailer) VALUES (@contract_type, @contract_name, @coords_index, @price_per_km, @cargo_type, @fragile, @valuable, @fast, @truck, @trailer);";
		MySQL.query(sql, {['@contract_type'] = contract_type, ['@contract_name'] = contract_name, ['@coords_index'] = coords_index, ['@price_per_km'] = price_per_km, ['@cargo_type'] = cargo_type, ['@fragile'] = fragile, ['@valuable'] = valuable, ['@fast'] = fast, ['@truck'] = truck, ['@trailer'] = trailer});

		local users = ESX.GetPlayers()
		for k,v in pairs(users) do
			openUI(v,true)
		end

		Citizen.Wait(Config.contratos.cooldown*1000*60)
	end
end)

-- Gera motoristas
Citizen.CreateThread(function()
	Citizen.Wait(10000)
	while true do 
		local product_type = math.random(0, 6)
		local distance = math.random(0, 6)
		local fragile = math.random(0, 6)
		local valuable = math.random(0, 6)
		local fast = math.random(0, 6)
		if product_type+distance+fragile+valuable+fast > 15 then
			product_type = math.random(0, 6)
			distance = math.random(0, 6)
			fragile = math.random(0, 6)
			valuable = math.random(0, 6)
			fast = math.random(0, 6)
			if product_type+distance+fragile+valuable+fast > 20 then
				product_type = math.random(0, 6)
				distance = math.random(0, 6)
				fragile = math.random(0, 6)
				valuable = math.random(0, 6)
				fast = math.random(0, 6)
			end
		end
		
		local price = math.random(Config.motoristas.preco_min, Config.motoristas.preco_max)
		price = price + (product_type+distance+fragile+valuable+fast)*(price*(Config.motoristas.porcentagem_bonus_habilidades/100))
		local price_per_km = math.random(Config.motoristas.preco_por_km_min, Config.motoristas.preco_por_km_max)
		price_per_km = price_per_km + (product_type+distance+fragile+valuable+fast)*(price_per_km*(Config.motoristas.porcentagem_bonus_habilidades/100))
		
		local driver = Config.motoristas.nomes[math.random(1, #Config.motoristas.nomes)]
		local name = driver.nomes[math.random(1, #driver.nomes)]

		if contract_type == 1 then truck = nil end

		local sql = "SELECT COUNT(driver_id) as qtd FROM trucker_drivers WHERE user_id IS NULL";
		local count = MySQL.query.await(sql, {})[1].qtd;
		
		if count >= Config.motoristas.max_motoristas_ativos then
			local sql = "SELECT MIN(driver_id) as min FROM trucker_drivers WHERE user_id IS NULL";
			local min = MySQL.query.await(sql, {})[1].min;
			
			local sql = "DELETE FROM `trucker_drivers` WHERE driver_id = @driver_id;";
			MySQL.query(sql, {['@driver_id'] = min});
		end

		local sql = "INSERT INTO `trucker_drivers` (user_id, name, product_type, distance, fragile, valuable, fast, price, price_per_km, img) VALUES (NULL, @name, @product_type, @distance, @fragile, @valuable, @fast, @price, @price_per_km, @img);";
		MySQL.query(sql, {['@name'] = name, ['@product_type'] = product_type, ['@distance'] = distance, ['@fragile'] = fragile, ['@valuable'] = valuable, ['@fast'] = fast, ['@price'] = price, ['@price_per_km'] = price_per_km, ['@img'] = driver.img});
		
		local users = ESX.GetPlayers()
		for k,v in pairs(users) do
			openUI(v,true)
		end
		
		Citizen.Wait(Config.motoristas.cooldown*1000*60)
	end
end)

-- Gera trabalho para os motoristas
Citizen.CreateThread(function()
	Citizen.Wait(10000)
	while true do 
		local sql = [[SELECT d.driver_id, d.user_id, d.name, d.product_type, d.distance, d.valuable, d.fragile, d.fast, d.price, d.price_per_km 
					FROM trucker_trucks t
						INNER JOIN trucker_drivers d ON (t.driver = d.driver_id)
					WHERE t.driver <> 0 AND t.driver IS NOT NULL]];
		local data = MySQL.query.await(sql, {});
		local xPlayer = ESX.GetPlayerFromId(source)
		if xPlayer ~= nil then
			for k,v in pairs(data) do
				local source = ESX.GetPlayerFromIdentifier(tonumber(v.user_id))

				if tryGetTruckerMoney(v.user_id,v.price + v.price_per_km) then
					local amount = math.random(Config.trabalhos.valor_inicial_min,Config.trabalhos.valor_inicial_max)
					amount = amount + (v.product_type+v.distance+v.fragile+v.valuable+v.fast)*(amount*(Config.trabalhos.porcentagem_bonus_habilidades/100))
					giveTruckerMoney(v.user_id,amount)
				else
					local sql = "UPDATE `trucker_drivers` SET user_id = NULL WHERE driver_id = @driver_id";
					MySQL.query(sql, {['@driver_id'] = v.driver_id});
					local sql = "UPDATE `trucker_trucks` SET driver = NULL WHERE driver = @driver_id";
					MySQL.query(sql, {['@driver_id'] = v.driver_id});
					if source then
						TriggerClientEvent("ESX:Notify",source,Lang[Config.lang]['driver_failed']:format(v.name),"error")
					end
				end

				if source then
					openUI(source, true)
				end
			end
		end
		Citizen.Wait(Config.trabalhos.cooldown*1000*60)
	end
end)

-- Paga empréstimo
Citizen.CreateThread(function()
	Citizen.Wait(10000)
	while true do
		local sql = "SELECT * FROM trucker_loans";
		local data = MySQL.query.await(sql, {});
		for k,v in pairs(data) do
			if v.timer + Config.emprestimos.cooldown < os.time() then
				local source = ESX.GetPlayerFromIdentifier(tonumber(v.user_id))
				if tryGetTruckerMoney(v.user_id,v.day_cost) then
					local new_loan = v.remaining_amount - v.taxes_on_day
					if new_loan > 0 then
						local sql = "UPDATE `trucker_loans` SET remaining_amount = @remaining_amount, timer = @timer WHERE id = @id";
						MySQL.query(sql, {['remaining_amount'] = new_loan, ['timer'] = os.time(), ['@id'] = v.id});
					else
						local sql = "DELETE FROM `trucker_loans` WHERE id = @id;";
						MySQL.query(sql, {['@id'] = v.id});
					end
				else
					if source then
						TriggerClientEvent("ESX:Notify",source,"importante",Lang[Config.lang]['no_loan_money'],"info")
					else
						local sql = "UPDATE `trucker_users` SET loan_notify = 1 WHERE user_id = @user_id";
						MySQL.query(sql, {['@user_id'] = v.user_id});
					end
				end
				if source then
					openUI(source, true)
				end
			end
		end
		Citizen.Wait(10*1000*60)
	end
end)

RegisterServerEvent("truck_logistics:getData")
AddEventHandler("truck_logistics:getData",function()
	if vrp_ready then
		local source = source
		openUI(source,false)
	end
end)

RegisterServerEvent("truck_logistics:startContract")
AddEventHandler("truck_logistics:startContract",function(data)
	local id = data.id
	local distance = data.distance
	local reward = data.reward

	local source = source
	local user_id = ESX.GetPlayerFromId(source).identifier
	if user_id then
		local sql = "SELECT * FROM `trucker_available_contracts` WHERE contract_id = @id";
		local query = MySQL.query.await(sql,{['@id'] = id});
		if query and query[1] then
			local sql = "SELECT * FROM `trucker_users` WHERE user_id = @user_id";
			query_users = MySQL.query.await(sql,{['@user_id'] = user_id});
			TriggerClientEvent('table',-1,query)
			if query_users and query_users[1] then
				if tonumber(query_users[1].product_type) >= tonumber(query[1].cargo_type) then
					if tonumber(query_users[1].fragile) >= tonumber(query[1].fragile) then
						if tonumber(query_users[1].valuable) >= tonumber(query[1].valuable) then
							if tonumber(query_users[1].fast) >= tonumber(query[1].fast) then
								if Config.habilidade_distancia[tonumber(query_users[1].distance)] >= tonumber(distance) then
									if tonumber(query[1].contract_type) == 0 then
										-- Inicia o trabalho
										TriggerClientEvent("truck_logistics:startContract",source,query[1],distance,reward,{})
									else
										-- Checa se tem caminhão
										local sql = "SELECT * FROM `trucker_trucks` WHERE driver = 0 AND user_id = @user_id";
										query_truck = MySQL.query.await(sql,{['@user_id'] = user_id});
										if query_truck and query_truck[1] then
											TriggerClientEvent("truck_logistics:startContract",source,query[1],distance,reward,query_truck[1])
										else
											TriggerClientEvent("ESX:Notify",source,Lang[Config.lang]['own_truck'],"error")
										end
									end
								else
									TriggerClientEvent("ESX:Notify",source,Lang[Config.lang]['no_skill_1'],"error")
								end
							else
								TriggerClientEvent("ESX:Notify",source,Lang[Config.lang]['no_skill_2'],"error")
							end
						else
							TriggerClientEvent("ESX:Notify",source,Lang[Config.lang]['no_skill_3'],"error")
						end
					else
						TriggerClientEvent("ESX:Notify",source,Lang[Config.lang]['no_skill_4'],"error")
					end
				else
					TriggerClientEvent("ESX:Notify",source,Lang[Config.lang]['no_skill_5'],"error")
				end
			end
		else
			TriggerClientEvent("ESX:Notify",source,Lang[Config.lang]['job_already_started'],"error")
		end
	end
end)

RegisterServerEvent("truck_logistics:spawnTruck")
AddEventHandler("truck_logistics:spawnTruck",function(truck_id)
	local source = source
	local sql = "SELECT * FROM `trucker_trucks` WHERE truck_id = @truck_id";
	query_truck = MySQL.query.await(sql,{['@truck_id'] = tonumber(truck_id)});
	if query_truck and query_truck[1] then
		TriggerClientEvent("truck_logistics:spawnTruck",source,query_truck[1])
	end
end)

RegisterServerEvent("truck_logistics:deactiveTruck")
AddEventHandler("truck_logistics:deactiveTruck",function(truck_id)
	local source = source
	local sql = "UPDATE `trucker_trucks` SET driver = @driver WHERE truck_id = @truck_id";
	MySQL.query(sql, {['@truck_id'] = truck_id, ['@driver'] = NULL});
	openUI(source,true)
end)

--[[ RegisterServerEvent("truck_logistics:upgradeSkill")
AddEventHandler("truck_logistics:upgradeSkill",function(data)
	local source = source
	local user_id = ESX.GetPlayerFromId(source).identifier
	if user_id then
		local sql = "SELECT * FROM `trucker_users` WHERE user_id = @user_id";
		local query = MySQL.query.await(sql,{['@user_id'] = user_id})[1];
		if query.skill_points >= data.value then
			local sql = "UPDATE `trucker_users` SET "..data.id.." = @value, skill_points = @skill_points WHERE user_id = @user_id";
			MySQL.query(sql, {['@user_id'] = user_id, ['@value'] = data.value, ['@skill_points'] = (query.skill_points - data.value)});
			TriggerClientEvent("ESX:Notify",source,Lang[Config.lang]['upgraded_skill'],'success')
			openUI(source,true)
		else
			TriggerClientEvent("ESX:Notify",source,Lang[Config.lang]['insufficient_skill_points'],'success')
		end
	end
end) ]]

RegisterServerEvent("truck_logistics:upgradeSkill")
AddEventHandler("truck_logistics:upgradeSkill",function(data)
	local source = source
	local user_id = ESX.GetPlayerFromId(source).identifier
	if user_id then
		local sql = "SELECT * FROM `trucker_users` WHERE user_id = @user_id";
		local query = MySQL.query.await(sql,{['@user_id'] = user_id})[1];
		local number = data.value - query[data.id]
		if (data.value - query[data.id]) == 1 then 
			if query.skill_points >= data.value then
				local sql = "UPDATE `trucker_users` SET "..data.id.." = @value, skill_points = @skill_points WHERE user_id = @user_id";
				MySQL.query(sql, {['@user_id'] = user_id, ['@value'] = data.value, ['@skill_points'] = (query.skill_points - data.value)});
				TriggerClientEvent("ESX:Notify",source,Lang[Config.lang]['upgraded_skill'],'success')
				openUI(source,true)
			else
				TriggerClientEvent("ESX:Notify",source,Lang[Config.lang]['insufficient_skill_points'],'success')
			end
		else 
			local oldskillpoint = (1+query[data.id])*query[data.id]/2
			local newskillpoint = (1+data.value)*data.value/2

			local totalskillpoint = newskillpoint - oldskillpoint
			if query.skill_points >= (data.value - query[data.id]) then
				local sql = "UPDATE `trucker_users` SET "..data.id.." = @value, skill_points = @skill_points WHERE user_id = @user_id";
				MySQL.query(sql, {['@user_id'] = user_id, ['@value'] = data.value, ['@skill_points'] = (query.skill_points - totalskillpoint)});
				TriggerClientEvent("ESX:Notify",source,Lang[Config.lang]['upgraded_skill'],'success')
				openUI(source,true)
			else
				TriggerClientEvent("ESX:Notify",source,Lang[Config.lang]['insufficient_skill_points'],'success')
			end
		end
	end
end)


RegisterServerEvent("truck_logistics:repairTruck")
AddEventHandler("truck_logistics:repairTruck",function(item)
	local source = source
	local user_id = ESX.GetPlayerFromId(source).identifier
	if user_id then
		local sql = "SELECT * FROM `trucker_trucks` WHERE user_id = @user_id AND driver = 0";
		local query = MySQL.query.await(sql,{['@user_id'] = user_id})[1];
		if query then
			local amount = math.floor((100-(tonumber(query[item])/10)) * Config.valor_reparo[item])
			if amount > 0 then
				if tryGetTruckerMoney(user_id,amount) then
					local sql = "UPDATE `trucker_trucks` SET "..item.." = 1000 WHERE user_id = @user_id AND driver = 0";
					MySQL.query(sql, {['@user_id'] = user_id});
					TriggerClientEvent("ESX:Notify",source,Lang[Config.lang]['repaired'],'success')
					openUI(source,true)
				else
					TriggerClientEvent("ESX:Notify",source,Lang[Config.lang]['insufficiente_funds'],'error')
				end
			else
				TriggerClientEvent("ESX:Notify",source,Lang[Config.lang]['not_repaired'],'error')
			end
		else
			TriggerClientEvent("ESX:Notify",source,Lang[Config.lang]['have_no_truck'],'error')
		end
	end
end)

RegisterServerEvent("truck_logistics:buyTruck")
AddEventHandler("truck_logistics:buyTruck",function(data)
	local source = source
	local user_id = ESX.GetPlayerFromId(source).identifier
	if user_id then
		if tryGetTruckerMoney(user_id,tonumber(data.price)) then
			local sql = "INSERT INTO `trucker_trucks` (user_id, truck_name, driver) VALUES (@user_id, @name, NULL);";
			MySQL.query(sql, {['@user_id'] = user_id, ['@name'] = data.truck_name});
			TriggerClientEvent("ESX:Notify",source,Lang[Config.lang]['bought'],'success')
			SendWebhookMessage(Config.webhook,Lang[Config.lang]['logs_buytruck']:format(data.truck_name,data.price,user_id..os.date("\n["..Lang[Config.lang]['logs_date'].."]: %d/%m/%Y ["..Lang[Config.lang]['logs_hour'].."]: %H:%M:%S")))
			openUI(source,true)
		else
			TriggerClientEvent("ESX:Notify",source,Lang[Config.lang]['insufficiente_funds'],'success')
		end
	end
end)

RegisterServerEvent("truck_logistics:sellTruck")
AddEventHandler("truck_logistics:sellTruck",function(data)
	local source = source
	local user_id = ESX.GetPlayerFromId(source).identifier
	if user_id then
		local sql = "SELECT * FROM `trucker_trucks` WHERE truck_id = @truck_id";
		local query = MySQL.query.await(sql,{['@truck_id'] = data.truck_id})[1];
		if query then 
			local sql = "DELETE FROM `trucker_trucks` WHERE truck_id = @truck_id;";
			MySQL.query(sql, {['@truck_id'] = data.truck_id});
			local amount = math.floor(tonumber(Config.concessionaria[data.truck_name].price * Config.multiplicador_venda))
			giveTruckerMoney(user_id,amount)
			TriggerClientEvent("ESX:Notify",source,Lang[Config.lang]['sold'],'success')
			openUI(source,true)
		end
	end
end)

RegisterServerEvent("truck_logistics:hireDriver")
AddEventHandler("truck_logistics:hireDriver",function(driver_id)
	local source = source
	local user_id = ESX.GetPlayerFromId(source).identifier
	if user_id then
		local sql = "SELECT COUNT(driver_id) as qtd FROM trucker_drivers WHERE user_id = @user_id";
		local count = MySQL.query.await(sql, {['@user_id'] = user_id})[1].qtd;
		
		if count <= Config.motoristas.max_motoristas_por_player then
			local sql = "UPDATE `trucker_drivers` SET user_id = @user_id WHERE driver_id = @driver_id";
			MySQL.query(sql, {['@user_id'] = user_id, ['@driver_id'] = driver_id});
			TriggerClientEvent("ESX:Notify",source,Lang[Config.lang]['hired'],'success')
			openUI(source,true)
		else
			TriggerClientEvent("ESX:Notify",source,Lang[Config.lang]['max_drivers'],'error')
		end
	end
end)

RegisterServerEvent("truck_logistics:fireDriver")
AddEventHandler("truck_logistics:fireDriver",function(driver_id)
	local source = source
	local user_id = ESX.GetPlayerFromId(source).identifier
	if user_id then
		local sql = "UPDATE `trucker_drivers` SET user_id = NULL WHERE driver_id = @driver_id";
		MySQL.query(sql, {['@driver_id'] = driver_id});
		local sql = "UPDATE `trucker_trucks` SET driver = NULL WHERE driver = @driver_id";
		MySQL.query(sql, {['@driver_id'] = driver_id});
		TriggerClientEvent("ESX:Notify",source,Lang[Config.lang]['fired'],'success')
		openUI(source,true)
	end
end)

RegisterServerEvent("truck_logistics:setDriver")
AddEventHandler("truck_logistics:setDriver",function(data)
	local source = source
	local user_id = ESX.GetPlayerFromId(source).identifier
	if user_id then
		local sql = "UPDATE `trucker_trucks` SET driver = NULL WHERE driver = @driver_id";
		MySQL.query(sql, {['@driver_id'] = data.driver_id});
		local sql = "UPDATE `trucker_trucks` SET driver = @driver_id WHERE truck_id = @truck_id";
		MySQL.query(sql, {['@driver_id'] = data.driver_id, ['@truck_id'] = data.truck_id});
		openUI(source,true)
	end
end)

RegisterServerEvent("truck_logistics:withdrawMoney")
AddEventHandler("truck_logistics:withdrawMoney",function()
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local user_id = xPlayer.identifier
	if user_id then
		local sql = "SELECT * FROM `trucker_loans` WHERE user_id = @user_id";
		local query = MySQL.query.await(sql,{['@user_id'] = user_id})[1];
		if not query or not query.remaining_amount or query.remaining_amount <= 0 then
			local sql = "SELECT money FROM `trucker_users` WHERE user_id = @user_id";
			local query = MySQL.query.await(sql,{['@user_id'] = user_id})[1];
			local amount = tonumber(query.money)
			if amount and amount > 0 then
				local sql = "UPDATE `trucker_users` SET money = 0 WHERE user_id = @user_id";
				MySQL.query(sql, {['@user_id'] = user_id});
				xPlayer.addAccountMoney('bank', amount)
				TriggerClientEvent("ESX:Notify",source,Lang[Config.lang]['money_withdrawn'],'success')
				openUI(source,true)
			else
				TriggerClientEvent("ESX:Notify",source,Lang[Config.lang]['insufficiente_money'],'error')
			end
		else
			TriggerClientEvent("ESX:Notify",source,Lang[Config.lang]['pay_loans'],'error')
		end
	end
end)

RegisterServerEvent("truck_logistics:depositMoney")
AddEventHandler("truck_logistics:depositMoney",function(data)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local user_id = xPlayer.identifier
	if user_id then
		local amount = tonumber(data.amount)
		if amount and amount > 0 then
			money = xPlayer.getAccount('bank').money
			if money >= amount then
				xPlayer.removeAccountMoney('bank', amount)
				giveTruckerMoney(user_id,amount)
				TriggerClientEvent("ESX:Notify",source,Lang[Config.lang]['money_deposited'],'success')
				openUI(source,true)
			else
				TriggerClientEvent("ESX:Notify",sourceLang[Config.lang]['insufficiente_money'],'success')
			end
		else
			TriggerClientEvent("ESX:Notify",source,Lang[Config.lang]['invalid_value'],'error')
		end
	end
end)

RegisterServerEvent("truck_logistics:loan")
AddEventHandler("truck_logistics:loan",function(data)
	local source = source
	local user_id = ESX.GetPlayerFromId(source).identifier
	if user_id then
		local sql = "SELECT * FROM `trucker_loans` WHERE user_id = @user_id";
		local query = MySQL.query.await(sql,{['@user_id'] = user_id});
		local amount_loans = 0;
		for k,v in pairs(query) do
			amount_loans = amount_loans + tonumber(v.loan)
		end
		
		if amount_loans + Config.emprestimos.valores[data.loan_id][1] <= getMaxEmprestimo(user_id) then
			local sql = "INSERT INTO `trucker_loans` (user_id,loan,remaining_amount,day_cost,taxes_on_day,timer) VALUES (@user_id,@loan,@remaining_amount,@day_cost,@taxes_on_day,@timer);";
			MySQL.query(sql, {['@user_id'] = user_id, ['@loan'] = Config.emprestimos.valores[data.loan_id][1], ['@remaining_amount'] = Config.emprestimos.valores[data.loan_id][1], ['@day_cost'] = Config.emprestimos.valores[data.loan_id][2], ['@taxes_on_day'] = Config.emprestimos.valores[data.loan_id][3], ['timer'] = os.time()});
			giveTruckerMoney(user_id,Config.emprestimos.valores[data.loan_id][1])
			TriggerClientEvent("ESX:Notify",source,Lang[Config.lang]['loan'],'success')
			openUI(source,true)
		else
			TriggerClientEvent("ESX:Notify",source,Lang[Config.lang]['no_loan'],'error')
		end
	end
end)

RegisterServerEvent("truck_logistics:payLoan")
AddEventHandler("truck_logistics:payLoan",function(data)
	local source = source
	local user_id = ESX.GetPlayerFromId(source).identifier
	if user_id then
		local sql = "SELECT * FROM `trucker_loans` WHERE id = @id";
		local query = MySQL.query.await(sql,{['@id'] = data.loan_id})[1];
		if tryGetTruckerMoney(user_id,query.remaining_amount) then
			local sql = "DELETE FROM `trucker_loans` WHERE id = @id;";
			MySQL.query(sql, {['@id'] = data.loan_id});
			TriggerClientEvent("ESX:Notify",source,Lang[Config.lang]['loan_paid'],'success')
			openUI(source,true)
		else
			TriggerClientEvent("ESX:Notify",source,Lang[Config.lang]['insufficiente_funds'],'error')
		end
	end
end)

RegisterServerEvent("truck_logistics:finishJob")
AddEventHandler("truck_logistics:finishJob",function(data,distance,reward,truck_data,truck_engine,truck_body,trailer_body)
	local source = source
	local user_id = ESX.GetPlayerFromId(source).identifier
	if user_id then
		trailer_body = trailer_body/1000
		local exp_amount = reward*(Config.exp/100)
		local bonus = 0
		local bonus_exp = 0
		local level = getPlayerLevel(user_id)
		local sql = "SELECT * FROM `trucker_users` WHERE user_id = @user_id";
		local query = MySQL.query.await(sql,{['@user_id'] = user_id})[1];
		if data.fragile > 0 then
			bonus = bonus + reward*(Config.bonus['fragile']['dinheiro'][query.fragile]/100)
			bonus_exp = bonus_exp + exp_amount*(Config.bonus['fragile']['exp'][query.fragile]/100)
		end
		if data.valuable > 0 then
			bonus = bonus + reward*(Config.bonus['valuable']['dinheiro'][query.valuable]/100)
			bonus_exp = bonus_exp + exp_amount*(Config.bonus['valuable']['exp'][query.valuable]/100)
		end
		if data.fast > 0 then
			bonus = bonus + reward*(Config.bonus['fast']['dinheiro'][query.fast]/100)
			bonus_exp = bonus_exp + exp_amount*(Config.bonus['fast']['exp'][query.fast]/100)
		end
		if distance > Config.habilidade_distancia[0] then
			if Config.bonus['distance']['dinheiro'][query.distance] then
				bonus = bonus + reward*(Config.bonus['distance']['dinheiro'][query.distance]/100)
				bonus_exp = bonus_exp + exp_amount*(Config.bonus['distance']['exp'][query.distance]/100)
			end
		end

		local exp_amount = (exp_amount+bonus_exp)*trailer_body
		local money_amount = (reward+bonus)*trailer_body

		if truck_data.truck_id then
			local sql = "UPDATE `trucker_trucks` SET engine = @engine, transmission = @transmission, body = @body, wheels = wheels - @wheels WHERE truck_id = @truck_id";
			MySQL.query(sql, {['@engine'] = truck_engine, ['@body'] = truck_body, ['@transmission'] = math.floor((truck_engine + truck_body)/2), ['@wheels'] = tonumber(string.format("%.2f", distance))*10, ['@truck_id'] = truck_data.truck_id});
		end
		local sql = "UPDATE `trucker_users` SET total_earned = total_earned + @reward, finished_deliveries = finished_deliveries + 1, traveled_distance = traveled_distance + @distance, exp = exp + @exp_amount WHERE user_id = @user_id";
		MySQL.query(sql, {['@reward'] = money_amount, ['@distance'] = tonumber(string.format("%.2f", distance)), ['@exp_amount'] = exp_amount, ['@user_id'] = user_id});

		giveTruckerMoney(user_id,money_amount)
		TriggerClientEvent("ESX:Notify",source,Lang[Config.lang]['reward']:format(tostring(money_amount),tostring(trailer_body*100),tostring(exp_amount)),'success')
		SendWebhookMessage(Config.webhook,Lang[Config.lang]['logs_finish']:format(tostring(money_amount),tostring(exp_amount),user_id..os.date("\n["..Lang[Config.lang]['logs_date'].."]: %d/%m/%Y ["..Lang[Config.lang]['logs_hour'].."]: %H:%M:%S")))
		local level2 = getPlayerLevel(user_id)
		if level2 - level > 0 then
			local sql = "UPDATE `trucker_users` SET skill_points = skill_points + @skill WHERE user_id = @user_id";
			MySQL.query(sql, {['@skill'] = (level2 - level), ['@user_id'] = user_id});
			SendWebhookMessage(Config.webhook,Lang[Config.lang]['logs_skill']:format((level2 - level),user_id..os.date("\n["..Lang[Config.lang]['logs_date'].."]: %d/%m/%Y ["..Lang[Config.lang]['logs_hour'].."]: %H:%M:%S")))
		end
	end
end)

RegisterServerEvent("truck_logistics:updateTruckStatus")
AddEventHandler("truck_logistics:updateTruckStatus",function(truck_data,truck_engine,truck_body)
	local source = source
	local user_id = ESX.GetPlayerFromId(source).identifier
	if user_id then
		if truck_data.truck_id then
			local sql = "UPDATE `trucker_trucks` SET engine = @engine, transmission = @transmission, body = @body WHERE truck_id = @truck_id";
			MySQL.query(sql, {['@engine'] = truck_engine, ['@body'] = truck_body, ['@transmission'] = math.floor((truck_engine + truck_body)/2), ['@truck_id'] = truck_data.truck_id});
		end
	end
end)

RegisterServerEvent("truck_logistics:deleteContract")
AddEventHandler("truck_logistics:deleteContract",function(id)
	local source = source
	local user_id = ESX.GetPlayerFromId(source).identifier
	if user_id then
		local sql = "DELETE FROM `trucker_available_contracts` WHERE contract_id = @id;";
		MySQL.query(sql, {['@id'] = id});
		local users = ESX.GetPlayers()
		for k,v in pairs(users) do
			openUI(v,true)
		end
	end
end)

function giveTruckerMoney(user_id,amount)
	local sql = "UPDATE `trucker_users` SET money = money + @amount WHERE user_id = @user_id";
	MySQL.query(sql, {['@amount'] = amount, ['@user_id'] = user_id});
end

function tryGetTruckerMoney(user_id,amount)
	local sql = "SELECT money FROM `trucker_users` WHERE user_id = @user_id";
	local query = MySQL.query.await(sql,{['@user_id'] = user_id})[1];
	if tonumber(query.money) >= amount then
		local sql = "UPDATE `trucker_users` SET money = @amount WHERE user_id = @user_id";
		MySQL.query(sql, {['@amount'] = (tonumber(query.money) - amount), ['@user_id'] = user_id});
		return true
	else
		return false
	end
end

function getMaxEmprestimo(user_id)
	local max_emprestimo = 0;
	local level = getPlayerLevel(user_id)
	for k,v in pairs(Config.max_emprestimo_por_level) do
		if k <= level then
			max_emprestimo = v
		end
	end
	return max_emprestimo
end

function getPlayerLevel(user_id)
	local sql = "SELECT exp FROM `trucker_users` WHERE user_id = @user_id";
	local query = MySQL.query.await(sql,{['@user_id'] = user_id})[1];
	local level = 0
	if query then
		for k,v in pairs(Config.exp_por_level) do
			if tonumber(query.exp) >= v then
				level = k
			else
				return level
			end
		end
	end
	return level
end

function openUI(source, reset)
	local query = {}
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		local user_id = xPlayer.identifier
		if user_id then
			-- Busca os contratos
			local sql = "SELECT * FROM `trucker_available_contracts`";
			query.trucker_available_contracts = MySQL.query.await(sql,{});

			-- Busca os dados do usuário
			local sql = "SELECT * FROM `trucker_users` WHERE user_id = @user_id";
			query.trucker_users = MySQL.query.await(sql,{['@user_id'] = user_id})[1];
			if query.trucker_users == nil then
				local sql = "INSERT INTO `trucker_users` (user_id) VALUES (@user_id);";
				MySQL.query(sql, {['@user_id'] = user_id});
				local sql = "SELECT * FROM `trucker_users` WHERE user_id = @user_id";
				query.trucker_users = MySQL.query.await(sql,{['@user_id'] = user_id})[1];
			else
				if query.trucker_users.loan_notify == 1 then
					local sql = "UPDATE `trucker_users` SET loan_notify = 0 WHERE user_id = @user_id";
					MySQL.query(sql, {['@user_id'] = user_id});
					TriggerClientEvent("ESX:Notify",source,Lang[Config.lang]['no_loan_money'],'info')
				end
			end

			-- Busca os caminhões
			local sql = "SELECT * FROM `trucker_trucks` WHERE user_id = @user_id";
			query.trucker_trucks = MySQL.query.await(sql,{['@user_id'] = user_id});

			-- Busca os motoristas
			local sql = "SELECT * FROM `trucker_drivers` WHERE user_id = @user_id OR user_id IS NULL";
			query.trucker_drivers = MySQL.query.await(sql,{['@user_id'] = user_id});

			-- Busca os emprestimos
			local sql = "SELECT * FROM `trucker_loans` WHERE user_id = @user_id";
			query.trucker_loans = MySQL.query.await(sql,{['@user_id'] = user_id});

			-- Busca as configs necessárias
			query.config = {}
			query.config.concessionaria = deepcopy(Config.concessionaria)
			query.config.formatacao = deepcopy(Config.formatacao)
			query.config.valor_reparo = deepcopy(Config.valor_reparo)
			query.config.exp_por_level = deepcopy(Config.exp_por_level)
			query.config.max_emprestimo_por_level = deepcopy(Config.max_emprestimo_por_level)
			query.config.emprestimos = deepcopy(Config.emprestimos.valores)
			query.config.cooldown = Config.contratos.cooldown

			-- Busca outras variaveis
			query.config.max_emprestimo = getMaxEmprestimo(user_id)
			query.config.player_level = getPlayerLevel(user_id)

			-- Envia pro front-end
			TriggerClientEvent("truck_logistics:open",source, query, reset)
		end
	end
end


function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function print_table(node)
    -- to make output beautiful
    local function tab(amt)
        local str = ""
        for i=1,amt do
            str = str .. "\t"
        end
        return str
    end
 
    local cache, stack, output = {},{},{}
    local depth = 1
    local output_str = "{\n"
 
    while true do
        local size = 0
        for k,v in pairs(node) do
            size = size + 1
        end
 
        local cur_index = 1
        for k,v in pairs(node) do
            if (cache[node] == nil) or (cur_index >= cache[node]) then
               
                if (string.find(output_str,"}",output_str:len())) then
                    output_str = output_str .. ",\n"
                elseif not (string.find(output_str,"\n",output_str:len())) then
                    output_str = output_str .. "\n"
                end
 
                -- This is necessary for working with HUGE tables otherwise we run out of memory using concat on huge strings
                table.insert(output,output_str)
                output_str = ""
               
                local key
                if (type(k) == "number" or type(k) == "boolean") then
                    key = "["..tostring(k).."]"
                else
                    key = "['"..tostring(k).."']"
                end
 
                if (type(v) == "number" or type(v) == "boolean") then
                    output_str = output_str .. tab(depth) .. key .. " = "..tostring(v)
                elseif (type(v) == "table") then
                    output_str = output_str .. tab(depth) .. key .. " = {\n"
                    table.insert(stack,node)
                    table.insert(stack,v)
                    cache[node] = cur_index+1
                    break
                else
                    output_str = output_str .. tab(depth) .. key .. " = '"..tostring(v).."'"
                end
 
                if (cur_index == size) then
                    output_str = output_str .. "\n" .. tab(depth-1) .. "}"
                else
                    output_str = output_str .. ","
                end
            else
                -- close the table
                if (cur_index == size) then
                    output_str = output_str .. "\n" .. tab(depth-1) .. "}"
                end
            end
 
            cur_index = cur_index + 1
        end
 
        if (#stack > 0) then
            node = stack[#stack]
            stack[#stack] = nil
            depth = cache[node] == nil and depth + 1 or depth - 1
        else
            break
        end
    end
 
    -- This is necessary for working with HUGE tables otherwise we run out of memory using concat on huge strings
    table.insert(output,output_str)
    output_str = table.concat(output)
   
    print(output_str)
end