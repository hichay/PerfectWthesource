ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Code

ESX.RegisterUsableItem("fitbit", function(source, item)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('qb-fitbit:use', source)
  end)

RegisterServerEvent('qb-fitbit:server:setValue')
AddEventHandler('qb-fitbit:server:setValue', function(type, value)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local fitbitData = {}

    if type == "thirst" then
        local currentMeta = xPlayer.PlayerData.metadata["fitbit"]
        fitbitData = {
            thirst = value,
            food = currentMeta.food
        }
    elseif type == "food" then
        local currentMeta = xPlayer.PlayerData.metadata["fitbit"]
        fitbitData = {
            thirst = currentMeta.thirst,
            food = value
        }
    end

    xPlayer.SetMetaData('fitbit', fitbitData)
end)

ESX.RegisterServerCallback('qb-fitbit:server:HasFitbit', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local Fitbit = xPlayer.GetItemByName("fitbit")
    if Fitbit ~= nil then
        cb(true)
    else
        cb(false)
    end
end)