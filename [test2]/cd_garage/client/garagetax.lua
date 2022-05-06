RegisterNetEvent('cd_garage:GarageTax')
AddEventHandler('cd_garage:GarageTax', function(hash)
    maths = VehicleClass(hash, 'costs')
    amount = amount + maths
    garagecount = garagecount + 1
    if not hasSentOnce then
        hasSentOnce = true
        TriggerEvent('cd_garage:PayTax')
    end
end)

RegisterNetEvent('cd_garage:PayTax')
AddEventHandler('cd_garage:PayTax', function()
    if hasSentOnce then
        Wait(5000)
        TriggerServerEvent('cd_garage:PayTax', amount, math.ceil(garagecount))
        amount = 0
    end
end)

function VehicleClass(hash, returning)
    if Config.GarageTaxTable and hash and returning then
        local costs = Config.GarageTaxDefault
        for k, v in pairs (Config.GarageTaxTable) do
            if v.hash ~= nil then
                if v.hash == hash then
                    if returning == 'costs' then
                        if v.taxrate then
                            return costs*v.taxrate
                        else
                            return costs
                        end
                    elseif returning == 'class' then
                        if v.class then
                            return v.class
                        else
                            return ' '
                        end
                    end
                end
            end
        end
        if returning == 'costs' then
            return costs
        elseif returning == 'class' then
            return ' '
        end
    end
end