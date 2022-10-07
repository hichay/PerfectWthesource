RegisterServerEvent("pw-police:cuff")
AddEventHandler("pw-police:cuff", function(pTarget)
	local src = source

    TriggerClientEvent("pw-police:getArrested", pTarget, src)
	TriggerClientEvent("pw-police:cuffTransition", src)
end)

RegisterServerEvent("pw-police:uncuff")
AddEventHandler("pw-police:uncuff", function(pTarget)
	TriggerClientEvent("pw-police:uncuff", pTarget)
end)

RegisterServerEvent("pw-police:softcuff")
AddEventHandler("pw-police:softcuff", function(pTarget)
    TriggerClientEvent("pw-police:handCuffedWalking", pTarget)
end)

RPC.register("isPedCuffed", function(src, pTarget)
	local isCuffed = RPC.execute(pTarget, "isPlyCuffed")
	return isCuffed
end)