Ped = {}

AddEventHandler("baseevents:enteredVehicle", function (pVehicle)
    Ped.isInVehicle = true
    Ped.vehicleHandle = pVehicle
end)

AddEventHandler("baseevents:leftVehicle", function (pVehicle)
    Ped.isInVehicle = false
    Ped.vehicleHandle = nil
end)

RegisterNetEvent("evidence:bulletInformation", function(information)
    Ped.weaponInfo = information
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
    print('trigger spawn dna')
    Ped.characterDNA = RPC.execute("pw-evidence:getDNA")
	TriggerEvent('SpawnEventsServer')
end)

AddEventHandler("pw-inventory:itemUsed", function(itemId, itemInfo, inventoryName, slot)
    if itemId == "pdevidencebag" then
        local metaData = json.decode(itemInfo)

        if not metaData.inventoryId then
            local input = exports["pw-input"]:showInput({
                {
                    icon = "circle",
                    label = "Tên",
                    name = "name",
                },
            })
            if input["name"] then
                local genId = tostring(math.random(10000, 99999999))
                local invId = "container-" .. genId .. "-evidencebag"

                metaData = {
                    inventoryId = invId,
                    ['Tên'] = input["name"],
                    slots = 15,
                    weight = 15,
                    _hideKeys = {"inventoryId", "slots", "weight"},
                }

                TriggerEvent("inventory:updateItem", "pdevidencebag", slot, metaData)
            end

            return
        end

        TriggerEvent("inventory-open-container", metaData.inventoryId, metaData.slots, metaData.weight)
    end
end)

-- Player Ped loop
Citizen.CreateThread(function ()
    while true do
        local idle = 1000

        Ped.handle = PlayerPedId()

        Ped.playerId = PlayerId()

        Ped.coords = GetEntityCoords(Ped.handle)

        Ped.isArmed = IsPedArmed(Ped.handle, 7)

        Ped.weaponHash = Ped.isArmed and GetSelectedPedWeapon(Ped.handle) or nil

        Ped.weaponType = Ped.isArmed and GetWeapontypeGroup(GetSelectedPedWeapon(Ped.handle)) or nil

        Citizen.Wait(idle)
    end
end)

