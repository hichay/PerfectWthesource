AddEventHandler("pw-evidence:analyze", function(pParameters, pEntity, pContext)
    if pParameters.actionId == 1 then
        TriggerEvent("inventory-open-container", "analyze_evidence", 1, 1)
    elseif pParameters.actionId == 2 then
        --TriggerEvent("dpemotes:e", {"parkingmeter"})
        local finished = exports["pw-taskbar"]:taskBar(15000, "Phân tích")
        --TriggerEvent("dpemotes:e", {"c"})
        if finished == 100 then
            TriggerServerEvent("pw-evidence:analyze")
        end
    end
end)

AddEventHandler("pw-evidence:dnaSwab", function(pArgs, pEntity)
	TriggerEvent("dpemotes:e", {"parkingmeter"})
    local finished = exports["pw-taskbar"]:taskBar(15000, "Thu thập DNA")
	TriggerEvent("dpemotes:e", {"c"})
    if finished == 100 then
		TriggerServerEvent("pw-evidence:dnaSwab", GetPlayerServerId(NetworkGetPlayerIndexFromPed(pEntity)))
	end
end)






Citizen.CreateThread(function()
    exports["pw-polytarget"]:AddBoxZone("analyze_evidence", vector3(483.62, -988.59, 30.69), 0.55, 0.75, {
        heading = 0,
        minZ=30.69,
        maxZ=31.49
    })

    exports["pw-interact"]:AddPeekEntryByPolyTarget("analyze_evidence", {{
        event = "pw-evidence:analyze",
        id = "analyze_evidence_inventory",
        icon = "hand-paper",
        label = "Thêm bằng chứng",
        parameters = { actionId = 1 }
    }}, { distance = { radius = 3.5 } })

    exports["pw-interact"]:AddPeekEntryByPolyTarget("analyze_evidence", {{
        event = "pw-evidence:analyze",
        id = "analyze_evidence_action",
        icon = "search",
        label = "Phân tích bằng chứng",
        parameters = { actionId = 2 }
    }}, { distance = { radius = 3.5 } })

end)