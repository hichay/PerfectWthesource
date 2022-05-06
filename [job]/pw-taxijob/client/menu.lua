RegisterNetEvent('pw-taxijob:Vehicle', function()
	for k, v in pairs(Config.Vehicles) do
        --Menu.addButton(v, "SpawnListVehicle", k) 
	
		TriggerEvent('pw-context:sendMenu', {
			{
				id = k,
				header = ""..v,
				txt = "",
				params = {
					event = "pw-taxijob:SpawnListVehicle",
					args = {
					model = k
					}
				}
			},

		})
	end
end)



RegisterNetEvent('pw-taxijob:MainMenu', function()
    TriggerEvent('pw-context:sendMenu', {
        {
            id = 1,
            header = "Tìm kiếm khách hàng",
            txt = "",
            params = {
                event = "pw-taxijob:client:DoTaxiNpc",
            }
        },
		{
            id = 2,
            header = "Huỷ cuốc",
            txt = "",
            params = {
                event = "pw-taxijob:Clearcurrent",
            }
        },
        {
            id = 3,
            header = "Bộ đếm km",
            txt = "",
            params = {
                event = "pw-taxijob:client:toggleMeter",
            }
        },
		
		{
            id = 4,
            header = "Kích hoạt bộ đếm",
            txt = "",
            params = {
                event = "pw-taxijob:client:enableMeter",
            }
        },
		
    })
end)
