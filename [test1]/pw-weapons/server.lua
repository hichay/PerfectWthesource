ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("pw-weapons:updateAmmo")
AddEventHandler("pw-weapons:updateAmmo", function(newammo,ammoType,ammoTable)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer then
        MySQL.Async.fetchAll('SELECT ammo FROM user_weapons WHERE type = @type AND id = @identifier',{['@type'] = ammoType, ['@identifier'] = xPlayer.getIdentifier()}, function(result)
            if result[1] == nil then
                MySQL.Async.execute('INSERT INTO user_weapons (id, type, ammo) VALUES (@identifier, @type, @ammo)', {
                    ['@identifier'] = xPlayer.getIdentifier(),
                    ['@type'] = ammoType,
                    ['@ammo'] = newammo
                })
            else
                MySQL.Async.execute('UPDATE user_weapons SET ammo = @newammo WHERE type = @type AND ammo = @ammo AND id = @identifier', {
                    ['@identifier'] = xPlayer.getIdentifier(),
                    ['@type'] = ammoType,
                    ['@ammo'] = result[1].ammo,
                    ['@newammo'] = newammo
                })
            end
        end)
    end
    
end)

RegisterServerEvent("pw-weapons:getAmmo")
AddEventHandler("pw-weapons:getAmmo", function()
    local src = source
    local ammoTable = {}
    local xPlayer = ESX.GetPlayerFromId(src)
    MySQL.Async.fetchAll("SELECT type, ammo FROM user_weapons WHERE id = @cid",{
        ["@cid"] = xPlayer.getIdentifier()
    },function(result)
        for i = 1, #result do
            if ammoTable["" .. result[i].type .. ""] == nil then
                ammoTable["" .. result[i].type .. ""] = {}
                ammoTable["" .. result[i].type .. ""]["ammo"] = result[i].ammo
                ammoTable["" .. result[i].type .. ""]["type"] = ""..result[i].type..""
            end
        end
        TriggerClientEvent('pw-items:SetAmmo', src, ammoTable)
	--return ammoTable
    end)
end)