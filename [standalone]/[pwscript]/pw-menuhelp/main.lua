-- NUI Callback Methods
RegisterNUICallback('open', function(data, cb)
  SendNUIMessage({open = true})
end)

RegisterCommand('help', function(source, args, rawCommand)

	SendNUIMessage({
		type = "open"
    })
	SetNuiFocus(true, true)
end)

RegisterNUICallback('close', function(data, cb)
  passed = false
  TriggerEvent("evidence:bleeding")
  CloseGui()
  cb('ok')
end)

RegisterNUICallback('NUIFocusOff', function(data, cb)
  SetNuiFocus(false, false)
  SendNUIMessage({
		type = "close"
    })
end)

