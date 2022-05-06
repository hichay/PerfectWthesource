ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)






--Cigarette
for i=1, #Config.ItemCigarette, 1 do

ESX.RegisterUsableItem(Config.ItemCigarette[i], function(source)
    src = source
    local cigarette = Config.ItemCigarette[i]
	local xPlayer = ESX.GetPlayerFromId(src)
	local lighter = xPlayer.getInventoryItem(Config.LighterItem)
    if lighter.count > 0 then
        xPlayer.removeInventoryItem(cigarette, 1)
        TriggerClientEvent('devcore_smoke:CigarettesLightingAnim', source)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = _U('need_lighter') })
        end
    end)
end



for i=1, #Config.CigarettePack, 1 do

ESX.RegisterUsableItem(Config.CigarettePack[i].PackItem, function(source)
    src = source
	local xPlayer = ESX.GetPlayerFromId(src)
    local pack     = Config.CigarettePack[i].PackItem
    local item     = Config.CigarettePack[i].CigaretteItem
    local amount    = Config.CigarettePack[i].Amount

    TriggerClientEvent('devcore_smoke:CigarettesPackAnim', src)
    Citizen.Wait(3000)
        xPlayer.removeInventoryItem(pack, 1)
        xPlayer.addInventoryItem(item, amount)
        end)
end

--Cigar
for i=1, #Config.ItemCigar, 1 do

    ESX.RegisterUsableItem(Config.ItemCigar[i], function(source)
        src = source
        local cigar = Config.ItemCigar[i]
        local xPlayer = ESX.GetPlayerFromId(src)
        local lighter = xPlayer.getInventoryItem(Config.LighterItem)
        if lighter.count > 0 then
            xPlayer.removeInventoryItem(cigar, 1)
            TriggerClientEvent('devcore_smoke:CigarLightingAnim', source)
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = _U('need_lighter') })
            end
        end)
    end
    
--Joint

for i=1, #Config.ItemJoint, 1 do

    ESX.RegisterUsableItem(Config.ItemJoint[i], function(source)
        src = source
        local joint = Config.ItemJoint[i]
        local xPlayer = ESX.GetPlayerFromId(src)
        local lighter = xPlayer.getInventoryItem(Config.LighterItem)
        if lighter.count > 0 then
            xPlayer.removeInventoryItem(joint, 1)
            TriggerClientEvent('devcore_smoke:JointLightingAnim', source)
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = _U('need_lighter') })
            end
        end)
    end


ESX.RegisterUsableItem(Config.Rollingpaper, function(source)
    src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    for i=1, #Config.ItemWeed, 1 do
    local weed = xPlayer.getInventoryItem(Config.ItemWeed[i])
    if weed.count > 0 then
        TriggerClientEvent('esx_crafting:OpenMenu', source)
        end
    end
end)




    --cigaratte
RegisterServerEvent("devcore_smoke:eff_smokes")
AddEventHandler("devcore_smoke:eff_smokes", function(cigaentity)
	TriggerClientEvent("devcore_smoke:c_eff_smokes", -1, cigaentity)
end)

RegisterServerEvent("devcore_smoke:eff_lighter")
AddEventHandler("devcore_smoke:eff_lighter", function(light)
	TriggerClientEvent("devcore_smoke:c_eff_lighter", -1, light)
end)

RegisterServerEvent("devcore_smoke:eff_cigarette")
AddEventHandler("devcore_smoke:eff_cigarette", function(cigaratte)
	TriggerClientEvent("devcore_smoke:c_eff_cigarette", -1, cigaratte)
end)

--cigar
RegisterServerEvent("devcore_smoke:eff_smokes_cigar")
AddEventHandler("devcore_smoke:eff_smokes_cigar", function(cigarentity)
	TriggerClientEvent("devcore_smoke:c_eff_smokes_cigar", -1, cigarentity)
end)

RegisterServerEvent("devcore_smoke:eff_lighter_cigar")
AddEventHandler("devcore_smoke:eff_lighter_cigar", function(lighter)
	TriggerClientEvent("devcore_smoke:c_eff_lighter_cigar", -1, lighter)
end)

RegisterServerEvent("devcore_smoke:eff_cigar")
AddEventHandler("devcore_smoke:eff_cigar", function(cigar)
	TriggerClientEvent("devcore_smoke:c_eff_cigar", -1, cigar)
end)

--joint
RegisterServerEvent("devcore_smoke:eff_smokes_joint")
AddEventHandler("devcore_smoke:eff_smokes_joint", function(jointentity)
	TriggerClientEvent("devcore_smoke:c_eff_smokes_joint", -1, jointentity)
end)

RegisterServerEvent("devcore_smoke:eff_lighter_joint")
AddEventHandler("devcore_smoke:eff_lighter_joint", function(lighterjoint)
	TriggerClientEvent("devcore_smoke:c_eff_lighter_joint", -1, lighterjoint)
end)

RegisterServerEvent("devcore_smoke:eff_joint")
AddEventHandler("devcore_smoke:eff_joint", function(joint)
	TriggerClientEvent("devcore_smoke:c_eff_joint", -1, joint)
end)