-- [ Code ] --
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


-- [ Commands ] --

-- Mercy.Commands.Add('addoutfit', 'Put your current outfit in your closet.', {{name = 'name', help = 'Outfit Name'}}, false, function(source, args)
--     local OutfitName = args[1] ~= nil and args[1] or 'outfit-'..math.random(111111, 999999)
--     if OutfitName then   
--         TriggerClientEvent('pw-clothing:client:saveCurrentOutfit', source, OutfitName)
--     else
--         TriggerClientEvent('QBCore:Notify', source, 'You have not given a name for your outfit.', 'error')
--     end
-- end)

-- Mercy.Commands.Add('skin', 'Clothing Menu', {}, false, function(source, args)
--     TriggerClientEvent('pw-clothing:client:openMenu', source)
-- end, "admin")

-- [ Events ] --

ESX.RegisterServerCallback('raid_clothes:getSex', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll("SELECT sex FROM users WHERE identifier = @identifier", {["identifier"] = xPlayer.getIdentifier()}, function(result)
        cb(result[1].sex)
    end)
end)


RegisterNetEvent("pw-clothing:saveSkin", function(Model, Skin)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    --local Player = exports["np-base"]:getModule("Player"):GetUser(src)
    local cid = xPlayer.getIdentifier()

    if Model ~= nil and Skin ~= nil then

        local delete = MySQL.update.await([[
            DELETE FROM playerskins
            WHERE citizenid = ?
        ]],
        { cid })

        if not delete then return print("error deleteting skin from database") end

        local data2 = MySQL.insert.await([[
            INSERT INTO playerskins (citizenid, model, skin, active)
            VALUES (?, ?, ?, ?)
        ]],
        { cid, Model, Skin, 1 })

        if not data2 then return print("error inserting skin from database") end

        TriggerClientEvent("DoLongHudText", src, "Outfit Saved")
    end
end)

RegisterNetEvent("pw-clothes:loadPlayerSkin", function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    --local Player = exports["np-base"]:getModule("Player"):GetUser(src)
    local cid = xPlayer.getIdentifier()

    local result = MySQL.query.await([[
        SELECT *
        FROM playerskins
        WHERE citizenid = ? AND active = ?
    ]], { cid, 1 })

    if result[1] ~= nil then
        TriggerClientEvent("pw-clothes:loadSkin", src, false, result[1].model, result[1].skin)
    else
        TriggerClientEvent("pw-clothes:loadSkin", src, true)
    end
end)

RegisterNetEvent("pw-clothes:saveOutfit", function(outfitName, model, skinData)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    --local Player = exports["np-base"]:getModule("Player"):GetUser(src)
    local cid = xPlayer.getIdentifier()

    if model ~= nil and skinData ~= nil then
        local outfitId = "outfit-"..math.random(1, 10).."-"..math.random(1111, 9999)
        local data2 = MySQL.insert.await([[
            INSERT INTO player_outfits (citizenid, outfitname, model, skin, outfitId)
            VALUES (?, ?, ?, ?, ?)
        ]],
        { cid, outfitName, model, json.encode(skinData), outfitId })

        if not data2 then return print("error inserting outfit in database") end
    end
end)

RegisterNetEvent("pw-clothing:server:removeOutfit", function(outfitName, outfitId)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    --local Player = exports["np-base"]:getModule("Player"):GetUser(src)
    local cid = xPlayer.getIdentifier()

    local Outfit = nil
    local OutfitIdentifier = nil

    if type(outfitName) == 'table' then
        Outfit = outfitName.name
        OutfitIdentifier = outfitName.id
    else
        Outfit = outfitName
        OutfitIdentifier = outfitId
    end

    local delete = MySQL.update.await([[
        DELETE FROM player_outfits
        WHERE citizenid = ? AND outfitname = ? AND outfitId = ?
    ]],
    { cid, Outfit, OutfitIdentifier })

    if not delete then 
        return print("error deleteting outfit from database") 
    else 
        TriggerClientEvent('DoLongHudText',-1,"Thành công",1)
    end
end)

-- [ Callbacks ] --
RPC.register("pw-clothing:server:pay-for-clothes", function(src, isAdmin)
    --local user = exports["np-base"]:getModule("Player"):GetUser(src)

    if not IsAdmin then
        --[[ if Player.Functions.RemoveMoney('cash', Config.ClothingPrice) then
            return true
        else
            TriggerClientEvent("DoLongHudText", src, "Not enough money", 2)
            TriggerClientEvent("pw-clothes:client:loadPlayerSkin", src)
            return false
        end ]]
        return true
    else
        return true
    end
end)

RPC.register("pw-clothing:server:getOutfits", function(src)
    --local user = exports["np-base"]:getModule("Player"):GetUser(src)
	local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local cid = xPlayer.getIdentifier()

    local Outfits = {}
    local result = MySQL.query.await([[
        SELECT *
        FROM player_outfits
        WHERE citizenid = ?
    ]], { cid })

    if result[1] ~= nil then
        for k, v in pairs(result) do
            result[k].skin = json.decode(result[k].skin)
            Outfits[k] = v
        end
        return Outfits
    end

    return Outfits
end)
-- Mercy.Functions.CreateCallback('pw-clothing:server:pay-for-clothes', function(source, cb, IsAdmin)
--     local Player = Mercy.Functions.GetPlayer(source)
--     if not IsAdmin then
--         if Player.Functions.RemoveMoney('cash', Config.ClothingPrice) then
--             cb(true)
--         else
--             cb(false)
--             TriggerClientEvent('QBCore:Notify', source, "Not enough money", "error")
--             TriggerClientEvent("pw-clothes:client:loadPlayerSkin", source)
--         end
--     else
--         cb(true)
--     end
-- end)

-- Mercy.Functions.CreateCallback('pw-clothing:server:getOutfits', function(source, cb)
--     local Player = Mercy.Functions.GetPlayer(source)
--     local Outfits = {}
--     local result = MySQL.query.await('SELECT * FROM player_outfits WHERE citizenid = ?', { cid })
--     if result[1] ~= nil then
--         for k, v in pairs(result) do
--             result[k].skin = json.decode(result[k].skin)
--             Outfits[k] = v
--         end
--         cb(Outfits)
--     end
--     cb(Outfits)
-- end)
