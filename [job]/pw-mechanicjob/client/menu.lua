RegisterNetEvent('pw-mechanicjob:MainMenu', function()
    TriggerEvent('pw-context:sendMenu', {
        {
            id = 1,
            header = "Hoàn tất sửa chữa",
            txt = "",
            params = {
                event = "pw-mechanicjob:DetachVehicle",
            }
        },
        {
            id = 2,
            header = "Kiểm tra tổng thể",
            txt = "kiểm tra các bộ phận của xe",
            params = {
                event = "pw-mechanicjob:Partsmenu",
            }
        },
    })
end)



RegisterNetEvent('pw-mechanicjob:Partsmenu', function()
    local plate = GetVehicleNumberPlateText(Config.Plates[ClosestPlate].AttachedVehicle)
	if VehicleStatus[plate] ~= nil then
		for k, v in pairs(Config.ValuesLabels) do
			if math.ceil(VehicleStatus[plate][k]) ~= Config.MaxStatusValues[k] then
				local percentage = math.ceil(VehicleStatus[plate][k])
                if percentage > 100 then
                    percentage = math.ceil(VehicleStatus[plate][k]) / 10
                end
				
				TriggerEvent('pw-context:sendMenu', {
					{
						id = k,
						header = ""..v ,
						txt = percentage.."%",
						params = {
							event = "pw-mechanicjob:Partmenu",
							 args = {
								name = k
							}
						}
					},

				})
			else
				local percentage = math.ceil(Config.MaxStatusValues[k])
				if percentage > 100 then
					percentage = math.ceil(Config.MaxStatusValues[k]) / 10
				end
				
				TriggerEvent('pw-context:sendMenu', {
					{
						id = k,
						header = ""..v ,
						txt = percentage.."%",
						params = {
							event = "NoDamage",
							 args = {
								name = k
							}
						}
					},

				})
			
			end
		end	
	else
		for k, v in pairs(Config.ValuesLabels) do
            local percentage = math.ceil(Config.MaxStatusValues[k])
            if percentage > 100 then
                percentage = math.ceil(Config.MaxStatusValues[k]) / 10
            end
			
			TriggerEvent('pw-context:sendMenu', {
					{
						id = k,
						header = ""..v ,
						txt = "%"..percentage,
						params = {
							event = "NoDamage",
							 args = {
								name = k
							}
						}
					},

				})
			
		end	

	end	
end)

RegisterNetEvent('pw-mechanicjob:Partmenu', function(part)
	local name = part.name
	local veh = GetVehiclePedIsIn(PlayerPedId())
	classvehicle = GetVehicleClass(veh)
	if classvehicle == 0 or classvehicle == 8 then
		classvehicle = "A"
	elseif classvehicle == 1 or classvehicle == 1 then
		classvehicle = "B"
	elseif classvehicle == 4 or classvehicle == 9 or classvehicle == 18 then
		classvehicle = "C"
	elseif classvehicle == 2 or classvehicle == 12 then
		classvehicle = "D"
	elseif classvehicle == 5 or classvehicle == 6 or classvehicle == 7 then
		classvehicle = "S"
	else
		classvehicle = "All"
	end	

	TriggerEvent('pw-context:sendMenu', {
		{
			id = 1,
			header = "Sửa chữa" ,
			txt = Config.RepairCostAmount[name][classvehicle].label.." : ".. Config.RepairCostAmount[name][classvehicle].costs ,
			params = {
				event = "pw-mechanicjob:RepairPart",
				 args = {
					namethis = name
				}
			}
		},
		
		{
			id = 2,
			header = "<< Trở lại",
			txt = "" ,
			params = {
				event = "pw-mechanicjob:Partsmenu",
			}
		},

	})		
end)

RegisterNetEvent('pw-mechanicjob:VehicleList', function()
	for k, v in pairs(Config.Vehicles) do
        --Menu.addButton(v, "SpawnListVehicle", k) 
	
		TriggerEvent('pw-context:sendMenu', {
			{
				id = k,
				header = ""..v,
				txt = "",
				params = {
					event = "pw-mechanicjob:SpawnListVehicle",
					args = {
					model = k
					}
				}
			},

		})
	end
end)

-- function GardrobeMenu()
    -- local elements = {}
    -- elements[1] = {label = "Thay đồ",val="Change"}
  
    -- ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'dressing', {
      -- title    = "Tủ đồ cá nhân",
      -- align    = 'top-left',
      -- elements = elements
    -- }, function(data, menu)
      -- ESX.TriggerServerCallback('pw-mechanicjob:GetDressing', function(d)
        -- local dressing = d
        -- if data.current.val == "Change" then
          -- local elements = {}
          -- for i=1, #dressing, 1 do
            -- table.insert(elements, {
              -- label = dressing[i],
              -- value = i
            -- })
          -- end
  
          -- ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'change', {
            -- title    = "Thay đồ",
            -- align    = 'top-left',
            -- elements = elements
          -- }, function(data2, menu2)
            -- TriggerEvent('skinchanger:getSkin', function(skin)
              -- ESX.TriggerServerCallback('pw-mechanicjob:getOutfit', function(clothes)
                -- TriggerEvent('skinchanger:loadClothes', skin, clothes)
                -- TriggerEvent('esx_skin:setLastSkin', skin)
                -- TriggerEvent('skinchanger:getSkin', function(skin)
                  -- TriggerServerEvent('esx_skin:save', skin)
                -- end)
              -- end, data2.current.value)
            -- end)
          -- end, function(data2, menu2)
            -- menu2.close()
          -- end)
		-- end
      -- end)
    -- end, function(data, menu)
      -- menu.close()
    -- end)
-- end