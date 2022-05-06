RegisterServerEvent('json:dataStructure')
AddEventHandler('json:dataStructure', function(data)
    print(json.encode(data))
end)

RegisterServerEvent('pw-radialmenu:trunk:server:Door')
AddEventHandler('pw-radialmenu:trunk:server:Door', function(open, plate, door)
    TriggerClientEvent('pw-radialmenu:trunk:client:Door', -1, plate, door, open)
end)