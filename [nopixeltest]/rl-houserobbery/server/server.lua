ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('houseRobberies:removeLockpick')
AddEventHandler('houseRobberies:removeLockpick', function()
 local source = tonumber(source)
 local xPlayer = ESX.GetPlayerFromId(source)
 TriggerClientEvent('remove:item',-1)
 --TriggerClientEvent('RLCore:Notify', source, 'The lockpick bent out of shape.', "error")
end)

RegisterServerEvent('houseRobberies:giveMoney')
AddEventHandler('houseRobberies:giveMoney', function()
 local source = tonumber(source)
 local xPlayer = ESX.GetPlayerFromId(source)
 local cash = math.random(500, 1200)
 --xPlayer.Functions.AddMoney('cash', cash)
 print('get money')
 --TriggerClientEvent('RLCore:Notify', source, 'You found $'..cash)
end)

RegisterServerEvent('houseRobberies:searchItem')
AddEventHandler('houseRobberies:searchItem', function()
 local source = tonumber(source)
 local item = {}
 local xPlayer = ESX.GetPlayerFromId(source)
 local gotID = {}

 for i=1, math.random(1, 2) do
  item = Config.RobbableItems[math.random(1, #Config.RobbableItems)]
  if math.random(1, 10) >= item.chance then
   if tonumber(item.id) == 0 and not gotID[item.id] then
    gotID[item.id] = true
    --xPlayer.Functions.AddMoney('cash', item.quantity)
	TriggerClientEvent("player:receiveItem", source,item.id,1,true,true,'test file ay ma')
	print('additem')
    --TriggerClientEvent('RLCore:Notify', source, 'You found $'..item.quantity)
   elseif not gotID[item.id] then
    gotID[item.id] = true
    --xPlayer.Functions.AddItem(item.id, item.quantity)
   TriggerClientEvent("player:receiveItem", source,item.id,1,true,true,'test file ay ma 321')
   print('additem')
    --TriggerClientEvent('RLCore:Notify', source, 'Item Added!')
   end
  end
 end
end)

ESX.RegisterServerCallback('houserob:checkcops', function(source, cb)
  --local currentplayers = ESX.GetPlayerFromId(source)
  local cops = 5

  -- for i = 1, #currentplayers, 1 do
    -- local xPlayer = ESX.GetPlayerFromId(currentplayers[i])
    -- if xPlayer.job ~= nil and xPlayer.job.name == "police" then
      -- cops = cops + 1
    -- end
  -- end

  cb(cops)
end)
