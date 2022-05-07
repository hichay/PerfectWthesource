RegisterCommand("kiemtra", function(source, args, rawCommand)
	TriggerEvent('pw-mechanicjob:MainMenu')
end, false)
RegisterCommand("wow", function(source, args, rawCommand)
  local data = {
    {
        title = "Thông tin xe",
        description = "wow" ,
    },
  }
exports["np-ui"]:showContextMenu(data)
end, false)
RegisterNetEvent('pw-mechanicjob:MainMenu', function()

    local vehicle = nil

    local target = exports["np-interact"]:GetCurrentEntity()
    if DoesEntityExist(target) and GetEntityType(target) == 2 and #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(target)) < 5 then
        vehicle = target
    end

    if not vehicle then return end

    local plate = GetVehicleNumberPlateText(vehicle)
	  local class = exports["pw-vehicles"]:GetVehicleClass(vehicle)
    local mileage = RPC.execute("pw-vehicles:getMileage", plate)
    local degHealth = json.decode(RPC.execute("pw-vehicles:getDegradation", plate))
    degHealth["body"] = round(GetVehicleBodyHealth(vehicle) / 10)
    degHealth["engine"] = round(GetVehicleEngineHealth(vehicle) / 10)

    local data = {
        {
            title = "Thông tin xe",
            description = "Hạng: " .. class .. " | Môtơ-mét: " .. mileage,
        },
        {
          icon = "check",
            title = "Kiểm tra xe",
            children = {
                {
                    title = "Axle Tree",
                    description = "Current State: " .. degHealth.axle .. "% | Parts Required: " .. 0,
                    action = "",
                    --[[ children = { 
                      { icon = "wrench", description = Config.RepairCostAmount["axle"][class].label.." : ".. Config.RepairCostAmount["axle"][class].costs ,title = "Sửa chữa bộ phận này", action = "caue-vehicles:repairVehicle", key = {name = "axle"} },
                    }, ]]
                },
                {
                    title = "Body",
                    description = "Current State: " .. degHealth.body .. "% | Parts Required: " .. 0,
                    --[[ children = { 
                      { icon = "wrench", description = Config.RepairCostAmount["body_damage"][class].label.." : ".. Config.RepairCostAmount["body_damage"][class].costs ,title = "Sửa chữa bộ phận này", action = "caue-vehicles:repairVehicle", key = {name = "body"} },
                    }, ]]
                },
                {
                    title = "Brake Discs",
                    description = "Current State: " .. degHealth.brake .. "% | Parts Required: " .. 0,
                },
                {
                    title = "Clutch",
                    description = "Current State: " .. degHealth.clutch .. "% | Parts Required: " .. 0,
                },
                {
                    title = "Eletronics",
                    description = "Current State: " .. degHealth.electronics .. "% | Parts Required: " .. 0,
                },
                {
                    title = "Engine Block",
                    description = "Current State: " .. degHealth.engine .. "% | Parts Required: " .. 0,
                },
                {
                    title = "Engine Radiator",
                    description = "Current State: " .. degHealth.radiator .. "% | Parts Required: " .. 0,
                },
                {
                    title = "Fuel Injectors",
                    description = "Current State: " .. degHealth.injector .. "% | Parts Required: " .. 0,
                },
                {
                    title = "Transmission",
                    description = "Current State: " .. degHealth.transmission .. "% | Parts Required: " .. 0,
                },
                {
                    title = "Tyres",
                    description = "Current State: " .. degHealth.tire .. "% | Parts Required: " .. 0,
                },
            },
        },
    }

    exports["np-ui"]:showContextMenu(data)
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