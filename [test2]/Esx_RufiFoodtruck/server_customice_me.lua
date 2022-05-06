
ESX               = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)





RegisterServerEvent('esx_RufiFoodTruck:GiveItem')
AddEventHandler('esx_RufiFoodTruck:GiveItem', function(item)
local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.addInventoryItem(item, 1)
end)



RegisterServerEvent('esx_RufiFoodTruck:OpenBillMenu')
AddEventHandler('esx_RufiFoodTruck:OpenBillMenu', function(player, amount)
local xPlayer = ESX.GetPlayerFromId(player)
local xSeller = ESX.GetPlayerFromId(source)
       TriggerClientEvent('Esx_RufiFoodtruck:PayBill', xPlayer.source, amount, xSeller.source)
end)



RegisterServerEvent('esx_RufiFoodTruck:NPCPay')
AddEventHandler('esx_RufiFoodTruck:NPCPay', function(amount)
  local src = source
  local xPlayer = ESX.GetPlayerFromId(src)
  local Ramount =  tonumber(amount)
  local method = math.random(1,2)
 
 if method == 1 then
            
            			
				xPlayer.addMoney(Ramount)
                TriggerClientEvent('esx:showNotification', xPlayer.source, 'You recieve ~g~' .. Ramount .. '$~w~ ~y~ CASH~w~ payment from:~b~ NPC customer.')
            
  else
    
				
				xPlayer.addAccountMoney('bank', Ramount)
                TriggerClientEvent('esx:showNotification', xPlayer.source, 'You recieve ~g~' .. Ramount .. '$~w~ ~o~ BANK~w~ payment from:~b~ NPC customer.')


  end 
	  
	  
end)





RegisterServerEvent('esx_RufiFoodTruck:Pay')
AddEventHandler('esx_RufiFoodTruck:Pay', function(method, amount, seller)
  local src = source
  local xPlayer = ESX.GetPlayerFromId(src)
  local xSeller = ESX.GetPlayerFromId(seller)
  local Ramount =  tonumber(amount)
 
 if method == 'cash' then
            if xPlayer.getMoney() < Ramount then
                TriggerClientEvent('esx:showNotification', src, '~r~You dont have enought cash')
            else
                xPlayer.removeMoney(Ramount)
				TriggerClientEvent('esx:showNotification', src, '~g~Payment completed.')
				
				xSeller.addMoney(Ramount)
                TriggerClientEvent('esx:showNotification', xSeller.source, 'You recieve ~g~' .. Ramount .. '$~w~ ~y~ CASH~w~ payment from id:~b~ ' .. xPlayer.source .. ' ')
            end
  else
  
             if xPlayer.getAccount('bank').money < Ramount then
                TriggerClientEvent('esx:showNotification', src, '~r~You dont have enought money in the bank.')
            else
                xPlayer.removeAccountMoney('bank', Ramount)
				TriggerClientEvent('esx:showNotification', src, '~g~Payment completed.')
				
				xSeller.addAccountMoney('bank', Ramount)
                TriggerClientEvent('esx:showNotification', xSeller.source, 'You recieve ~g~' .. Ramount .. '$~w~ ~o~ BANK~w~ payment from id:~b~ ' .. xPlayer.source .. ' ')
            end


  end 
	  
	  
end)





RegisterServerEvent('esx_RufiFoodTruck:RegisterOwner')
AddEventHandler('esx_RufiFoodTruck:RegisterOwner', function(plate, amount, cash)
local xPlayer = ESX.GetPlayerFromId(source)

local matricula = plate

 if cash then
 
 
  if xPlayer.getMoney() >= amount then


   MySQL.Async.fetchAll('SELECT * FROM `foodtruck_owners` WHERE identifier = @identifier',
				{
					['@identifier']  = xPlayer.identifier
				
				}, function(tiene)
		if not tiene[1] then
			MySQL.Async.execute('INSERT INTO foodtruck_owners (identifier, plate) VALUES (@identifier, @plate)',
				{   
				    ['@identifier']  = xPlayer.identifier,
					['@plate']      = matricula
				}, function(rowsChanged)
				xPlayer.removeMoney(amount)
					TriggerClientEvent('esx:showNotification', xPlayer.source, ('You have you bought a ~g~FoodTruck!' ))
				end)
				
			
		end
	end)

   else
   
   TriggerClientEvent('esx:showNotification', xPlayer.source, ('~r~ Not enough cash!' ))
   

   end

 
 
 
 
 
 
 else

   if xPlayer.getAccount('bank').money >= amount then


   MySQL.Async.fetchAll('SELECT * FROM `foodtruck_owners` WHERE identifier = @identifier',
				{
					['@identifier']  = xPlayer.identifier
				
				}, function(tiene)
		if not tiene[1] then
			MySQL.Async.execute('INSERT INTO foodtruck_owners (identifier, plate) VALUES (@identifier, @plate)',
				{   
				    ['@identifier']  = xPlayer.identifier,
					['@plate']      = matricula
				}, function(rowsChanged)
				xPlayer.removeAccountMoney('bank', amount)
					TriggerClientEvent('esx:showNotification', xPlayer.source, ('You have you bought a ~g~FoodTruck!' ))
				end)
				
			
		end
	end)

   else
   
   TriggerClientEvent('esx:showNotification', xPlayer.source, ('~r~ Not enough money in the bank!' ))
   

   end

 

 end				
				
	              
	
end)







ESX.RegisterServerCallback('esx_RufiFoodTruck:CheckOwner', function(source, cb)
local xPlayer = ESX.GetPlayerFromId(source)


    MySQL.Async.fetchAll('SELECT * FROM `foodtruck_owners` WHERE identifier = @identifier',
				{
					['@identifier']  = xPlayer.identifier
					
				}, function(result)
		if result[1] then
		local rslt = {}
		for i=1, #result, 1 do
			local plate = result[i].plate
			chk = true
			table.insert(rslt,{chk = chk, plate = plate})
			cb(rslt)
		end
			
	else
		
			local rslt = {}
			table.insert(rslt,{chk = false, plate = nil})
			cb(rslt)
		end
	end)

 



	
end)




ESX.RegisterUsableItem('rtaco', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('rtaco', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 400000)
	TriggerClientEvent('Esx_RufiFoodtruck:onEat', source, 'prop_taco_02')
	
end)


ESX.RegisterUsableItem('rburger', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('rburger', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 400000)
	TriggerClientEvent('Esx_RufiFoodtruck:onEat', source, 'prop_cs_burger_01')
	
end)


ESX.RegisterUsableItem('rhotdog', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('rhotdog', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 400000)
	TriggerClientEvent('Esx_RufiFoodtruck:onEat', source, 'prop_cs_hotdog_01')
	
end)




ESX.RegisterUsableItem('rchocolate', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('rchocolate', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 100000)
	TriggerClientEvent('Esx_RufiFoodtruck:onEat', source, 'prop_choc_ego')
	
end)

ESX.RegisterUsableItem('rsandwich', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('rsandwich', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 150000)
	TriggerClientEvent('Esx_RufiFoodtruck:onEat', source, 'prop_sandwich_01')
	
end)


ESX.RegisterUsableItem('rhamburger', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('rhamburger', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 350000)
	TriggerClientEvent('Esx_RufiFoodtruck:onEat', source, 'prop_cs_burger_01')
	
end)


ESX.RegisterUsableItem('rcupcake', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('rcupcake', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 100000)
	TriggerClientEvent('Esx_RufiFoodtruck:onEat', source, 'ng_proc_food_ornge1a')
	
end)

ESX.RegisterUsableItem('rchips', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('rchips', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 250000)
	TriggerClientEvent('Esx_RufiFoodtruck:onEat', source, 'v_ret_ml_chips4')
	
end)

-- ESX.RegisterUsableItem('water', function(source)
	-- local xPlayer = ESX.GetPlayerFromId(source)

	-- xPlayer.removeInventoryItem('water', 1)

	-- TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
	-- TriggerClientEvent('esx_status:add', source, 'hunger', 30000)
	-- TriggerClientEvent('esx_basicneeds:onDrink', source)
	-- TriggerClientEvent('esx:showNotification', source, _U('used_water'))
-- end)

ESX.RegisterUsableItem('rcola', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('rcola', 1)
	TriggerClientEvent('esx_status:add', source, 'rthirst', 200000)
	TriggerClientEvent('Esx_RufiFoodtruck:onDrink', source, 'prop_ecola_can')
	
end)

ESX.RegisterUsableItem('ricetea', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('ricetea', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
	TriggerClientEvent('esx_status:add', source, 'hunger', 80000)
	TriggerClientEvent('Esx_RufiFoodtruck:onDrink', source, 'prop_ld_can_01')
	
end)

ESX.RegisterUsableItem('rcoffe', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('rcoffe', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
	--TriggerClientEvent('esx_status:remove', source, 'stress', 200000)
	TriggerClientEvent('Esx_RufiFoodtruck:onDrink', source, 'prop_fib_coffee')
	
end)



ESX.RegisterUsableItem('rbeer', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('rbeer', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 150000)
	TriggerClientEvent('esx_status:remove', source, 'stress', 200000)
	TriggerClientEvent('Esx_RufiFoodtruck:onDrink', source, 'prop_amb_beer_bottle')
	
end)

