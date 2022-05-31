RegisterNetEvent("pw-npcs:set:ped")
AddEventHandler("pw-npcs:set:ped", function(pNPCs)
    if type(pNPCs) == "table" then
        for _, ped in ipairs(pNPCs) do
            RegisterNPC(ped)
            EnableNPC(ped.id)
        end
    else
        RegisterNPC(ped)
        EnableNPC(ped.id)
    end
end)

RegisterNetEvent("pw-npcs:set:position")
AddEventHandler("pw-npcs:set:position", function(pId, pVectors, pHeading)
    local position = { coords = pVectors, heading = pHeading}
    UpdateNPCData(pId, 'position', position)
end)

RegisterNetEvent("pw-npcs:ped:signInJob")
AddEventHandler("pw-npcs:ped:signInJob", function(pArgs, pEntity, pEntityFlags, pEntityCoords)
    if #pArgs == 0 then
        local npcId = DecorGetInt(pEntity, 'NPC_ID')
        if npcId == `news_reporter` then
            TriggerServerEvent("jobssystem:jobs", "news")
        elseif npcId == `head_stripper` then
            TriggerServerEvent("jobssystem:jobs", "entertainer")
        end
    else
        TriggerServerEvent("jobssystem:jobs", "unemployed")
    end
end)

RegisterNetEvent("pw-npcs:ped:paycheckCollect")
AddEventHandler("pw-npcs:ped:paycheckCollect", function(pArgs, pEntity, pEntityFlags, pEntityCoords)
    TriggerServerEvent("pw-jobs:paycheckPickup")
end)

RegisterNetEvent("pw-npcs:ped:tijolo")
AddEventHandler("pw-npcs:ped:tijolo", function(pArgs, pEntity, pEntityFlags, pEntityCoords)
TriggerEvent("player:receiveItem", "1064738331", 1)
end)

RegisterNetEvent("pw-npcs:ped:keeper")
AddEventHandler("pw-npcs:ped:keeper", function(pArgs, pEntity, pEntityFlags, pEntityCoords)
    if pArgs[1] == "5" then
        local hasLicense = RPC.execute("pw-licenses:hasLicense", "weapon")
        if not hasLicense then
            TriggerEvent("DoLongHudText", "Você não tem permissão para falar comigo.", 2)
            return
        end
    end

    TriggerEvent("server-inventory-open", pArgs[1], "Shop")
end)


TriggerServerEvent("pw-npcs:location:fetch")