RegisterServerEvent("stores:addInventoryItem")
AddEventHandler("stores:addInventoryItem",function(xPlayer,item,amount)
    local items = stringsplit(item, "_")
    if items[1] and items[1] == "WEAPON" then
        local ammo = 0
        xPlayer.addWeapon(item, ammo)
    else
        xPlayer.addInventoryItem(item, amount)
    end
end)

function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end