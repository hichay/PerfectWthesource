-- [ Events ] --
RegisterCommand('clmenu', function(source, args, RawCommand)
 TriggerEvent("pw-clothing:client:openOutfitMenu")   
end)

RegisterNetEvent('pw-clothing:client:openOutfitMenu', function()
    local OutfitsMenu = {
        {
            title = "Outfit Management",
            icon = "fas fa-tshirt",
            action = {},
        },
        {
            title = "View Outfits",
            icon = "fas fa-tshirt",
            description = "View outfits in wardrobe.",
            action = "pw-clothing:client:openOutfitsContext",
            
        },
        {
            title = "Add Outfit",
            icon = "fas fa-tshirt",
            description = "Adds current outfit to wardrobe.",
            action = "pw-clothing:client:add-outfit",
            
        },
    }
    exports[Config.ContextMenu]:showContextMenu(OutfitsMenu)
end)

RegisterNetEvent("pw-clothing:client:openOutfitsContext", function()
        print('ok')
    --local Promise = promise:new()
    local Outfits = RPC.execute("pw-clothing:server:getOutfits")

    --local Outfits = Citizen.Await(Promise)
    local OutfitList = {}
    OutfitList[#OutfitList + 1] = {
        title = "Outfits",
        icon = "fas fa-tshirt",
        action = {},
    }
    OutfitList[#OutfitList + 1] = {
        title = "Go back",
        icon = "fas fa-chevron-left",
        action = "pw-clothing:client:openOutfitMenu",
    }

    for i = 1, #Outfits do
        OutfitList[#OutfitList + 1] = {
            title = Outfits[i].outfitname,
            description = "Click to open outfit options.",
            action = "pw-clothing:open-outfit-options",
            key = {
                outfitData = Outfits[i]
            },
            
        }
    end

    if #OutfitList > 0 then
        exports[Config.ContextMenu]:showContextMenu(OutfitList)
    else
        TriggerEvent("DoLongHudText", "You don't have any outfits yet.", 2)
    end
end)

RegisterNetEvent("pw-clothing:open-outfit-options", function(Data)
    local outfitData = Data.outfitData

    local OutfitList = {}
    OutfitList[#OutfitList + 1] = {
        title = "Outfit Options",
        icon = "fas fa-tshirt",
        action = {},
    }
    OutfitList[#OutfitList + 1] = {
        title = "Go back",
        icon = "fas fa-chevron-left",
        action = "pw-clothing:client:openOutfitsContext",
    }
    OutfitList[#OutfitList + 1] = {
        title = "Use Outfit",
        description = "Click to use this outfit.",
            action = "pw-clothing:client:loadOutfit",
            key = {
                outfitData = outfitData.skin
            }
    }
    OutfitList[#OutfitList + 1] = {
        title = "Delete Outfit",
        description = "Click to delete this outfit.",
            action = "pw-clothing:client:removeOutfit",
            isServer = true,
            key = {
                name = outfitData.outfitname,
                id = outfitData.outfitId
            }
    }

    if #OutfitList > 0 then
        exports[Config.ContextMenu]:showContextMenu(OutfitList)
    end
end)


RegisterNetEvent('pw-clothing:client:add-outfit', function()
    local OutfitName = 'outfit-' .. math.random(11111, 99999)
    if OutfitName then
        local Model = GetEntityModel(PlayerPedId())
        TriggerServerEvent('np-clothes:saveOutfit', OutfitName, Model, Config.SkinData)
        TriggerEvent("DoLongHudText", "Successfully saved outfit: " .. OutfitName)
    else
        TriggerEvent("DoLongHudText", "You must include oufit name.", 2)
    end
end)

RegisterNetEvent("pw-clothing:client:saveCurrentOutfit", function(Name)
    local Model = GetEntityModel(PlayerPedId())
    TriggerServerEvent('np-clothes:saveOutfit', Name, Model, Config.SkinData)
    TriggerEvent("DoLongHudText", "Successfully saved outfit: " .. Name)
end)

RegisterNetEvent('pw-clothing:client:removeOutfit', function(name,id)
    TriggerServerEvent('pw-clothing:server:removeOutfit',name,id)

end)