


RegisterNetEvent('pw:dialog:open')
AddEventHandler("pw:dialog:open", function(buttons, name, question)
    SetNuiFocus(true, true)
    
 
    SendNUIMessage({
        action = "setdialog",
        name = name,
        buttons = buttons,
        question = question
    })
end)



RegisterNUICallback("close", function(data)
    SetNuiFocus(false,false)

end)

RegisterNUICallback("triggerevent", function(data)
    local event = data.event
    local args1 = data.args1
    local args2 = data.args2
    local args3 = data.args3
    local args4 = data.args4
    print(data.server)
    --print(data.func)
    
	 	
    if data.server then

        TriggerServerEvent(event, args1,args2,args3,args4)
    else
        TriggerEvent(event, args1,args2,args3,args4)
    end
    
    SendNUIMessage({
        action="close"
    })

    SetNuiFocus(false, false)
    TriggerEvent('pw:bt-target:resetNuiFocus')
end)


RegisterNetEvent('pw:close:dialog')
AddEventHandler('pw:close:dialog', function()
     SendNUIMessage({
        action="close"
    })
    SetNuiFocus(false, false)
end)