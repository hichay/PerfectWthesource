local carcasses = {
    { name = "huntingcarcass1", price = math.random(100,300), illegal = false },
    { name = "huntingcarcass2", price = math.random(200,300), illegal = false },
    { name = "huntingcarcass3", price = math.random(400,700), illegal = false },
	{ name = "leathercormorant1", price = 30, illegal = false },
	{ name = "leathercormorant2", price = 50, illegal = false },
	{ name = "leathercormorant3", price = 60, illegal = false },
	{ name = "leatherrabbit1", price = 20, illegal = false },
	{ name = "leatherrabbit2", price = 50, illegal = false },
	{ name = "leatherrabbit3", price = 60, illegal = false },
	{ name = "leathercoyote1", price = 20, illegal = false },
	{ name = "leathercoyote2", price = 40, illegal = false },
	{ name = "leathercoyote3", price = 60, illegal = false },
	{ name = "leathermtlion1", price = 30, illegal = false },
	{ name = "leathermtlion2", price = 50, illegal = false },
	{ name = "leathermtlion3", price = 70, illegal = false },
	{ name = "leatherboard1", price = 30, illegal = false },
	{ name = "leatherboard2", price = 50, illegal = false },
	{ name = "leatherboard3", price = 70, illegal = false },
	{ name = "leatherdeer1", price = 30, illegal = false },
	{ name = "leatherdeer2", price = 50, illegal = false },
	{ name = "leatherdeer3", price = 70, illegal = false },
    { name = "huntingcarcass4", price = math.random(1000,1500), illegal = true },
}
local nightTime = false

local function sellAnimals()
    local veh = GetVehiclePedIsIn(PlayerPedId())
    if veh and veh ~= 0 then
      local vehModel = GetEntityModel(veh)
      if IsThisModelABike(vehModel) or IsThisModelAQuadbike(vehModel) or IsThisModelABicycle(vehModel) then
        DeleteEntity(veh)
      end
      return
    end
    local totalCash = 0
    local totalBMarketCash = 0

    for _, carcass in pairs(carcasses) do
        local qty = exports["pw-inventory"]:getQuantity(carcass.name, true)

        if qty > 0 then
            if not carcass.illegal then
                totalCash = totalCash + (carcass.price * qty)
                TriggerEvent("inventory:removeItem", carcass.name, qty)
            elseif nightTime then
                totalBMarketCash = totalBMarketCash + (carcass.price * qty)
                TriggerEvent("inventory:removeItem", carcass.name, qty)
            end
        end
    end

    if totalCash == 0 and totalBMarketCash == 0 then
		TriggerEvent("ESX:Notify","Không có gì để bán","error")
    end
    
    if totalCash > 0 then
        --RPC.execute("np-financials:giveJobPay", "hunting_sales", totalCash)
        TriggerServerEvent("pw-hunting:Payout",totalCash)
    end

    if totalBMarketCash > 0 then
        TriggerEvent("player:receiveItem", "band", totalBMarketCash)
    end
end

RegisterNetEvent("pw-hunting:makeSales")
AddEventHandler("pw-hunting:makeSales", sellAnimals)

RegisterNetEvent("timeheader")
AddEventHandler("timeheader", function(pHour, pMinutes)
    if pHour > 19 or pHour < 5 then
        nightTime = true
    else
        nightTime = false
    end
end)
