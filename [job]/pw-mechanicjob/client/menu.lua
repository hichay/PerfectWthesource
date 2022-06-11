
RegisterNetEvent('pw-mechanicjob:MainMenu', function()

    local vehicle = GetVehiclePedIsIn(PlayerPedId(),false)

    if not vehicle then return end

    local plate = GetVehicleNumberPlateText(vehicle)
	  local class = exports["pw-vehicles"]:GetVehicleClass(vehicle)
    local mileage = RPC.execute("pw-vehicles:getMileage", plate)
    local degHealth = json.decode(RPC.execute("pw-vehicles:getDegradation", plate))
    degHealth["body"] = round(GetVehicleBodyHealth(vehicle) / 10)
    degHealth["engine"] = round(GetVehicleEngineHealth(vehicle) / 10)
  local data = {}
    data = {
      {
        icon = 'wrench',
        title = "Kết thúc sửa chữa",
        description = "Hạng: " .. class .. " | Môtơ-mét: " .. mileage,
        action = 'pw-mechanicjob:DetachVehicle',
      },
      {
        icon = "check",
        title = "Kiểm tra xe",
        children = {
            {
              icon = 'list-check',
              title = "1. Động cơ",
              description = "Tình trạng: " .. degHealth.engine,
              children = { 
                { icon = "wrench", description = Config.RepairCostAmount["engine"][class].label.." : ".. Config.RepairCostAmount["engine"][class].costs ,title = "Sửa chữa bộ phận này", action = "pw-vehicles:repairVehicle", key = {name = "engine"} },
              },
            },
            {
              icon = 'list-check',
              title = "2. Thân vỏ",
              description = "Tình trạng: " .. degHealth.body,
              children = { 
                { icon = "wrench", description = Config.RepairCostAmount["body"][class].label.." : ".. Config.RepairCostAmount["body"][class].costs ,title = "Sửa chữa bộ phận này", action = "pw-vehicles:repairVehicle", key = {name = "body"} },
              },
            },
            
            {
              icon = 'list-check',
              title = "3. Ly hợp",
              description = "Tình trạng: " .. degHealth.clutch,
              children = { 
                { icon = "wrench", description = Config.RepairCostAmount["clutch"][class].label.." : ".. Config.RepairCostAmount["clutch"][class].costs ,title = "Sửa chữa bộ phận này", action = "pw-vehicles:repairVehicle", key = {name = "clutch"} },
              },
            },
            {
              icon = 'list-check',
              title = "4. Thiết bị điện tử",
              description = "Tình trạng: " .. degHealth.electronics,
              children = { 
                { icon = "wrench", description = Config.RepairCostAmount["electronic"][class].label.." : ".. Config.RepairCostAmount["electronic"][class].costs ,title = "Sửa chữa bộ phận này", action = "pw-vehicles:repairVehicle", key = {name = "electronic"} },
              },
            },
            
            {
              icon = 'list-check',
              title = "5. Bộ tản nhiệt động cơ",
              description = "Tình trạng: " .. degHealth.radiator,
              children = { 
                { icon = "wrench", description = Config.RepairCostAmount["radiator"][class].label.." : ".. Config.RepairCostAmount["radiator"][class].costs ,title = "Sửa chữa bộ phận này", action = "pw-vehicles:repairVehicle", key = {name = "radiator"} },
              },
            },
            {
              icon = 'list-check',
              title = "6. Kim phun nhiên liệu",
              description = "Tình trạng: " .. degHealth.injector,
              children = { 
                { icon = "wrench", description = Config.RepairCostAmount["injector"][class].label.." : ".. Config.RepairCostAmount["injector"][class].costs ,title = "Sửa chữa bộ phận này", action = "pw-vehicles:repairVehicle", key = {name = "injector"} },
              },
            },
            {
              icon = 'list-check',
              title = "7. Trục chuyển",
              description = "Tình trạng: " .. degHealth.transmission,
              children = { 
                { icon = "wrench", description = Config.RepairCostAmount["transmission"][class].label.." : ".. Config.RepairCostAmount["transmission"][class].costs ,title = "Sửa chữa bộ phận này", action = "pw-vehicles:repairVehicle", key = {name = "transmission"} },
              },
            },
            {
              icon = 'list-check',
              title = "8. Lốp xe",
              description = "Tình trạng: " .. degHealth.tire,
              children = { 
                { icon = "wrench", description = Config.RepairCostAmount["tire"][class].label.." : ".. Config.RepairCostAmount["tire"][class].costs ,title = "Sửa chữa bộ phận này", action = "pw-vehicles:repairVehicle", key = {name = "tire"} },
              },
            },
            {
              icon = 'list-check',
              title = "9. Đĩa phanh",
              description = "Tình trạng: " .. degHealth.brake,
              children = { 
                { icon = "wrench", description = Config.RepairCostAmount["brake"][class].label.." : ".. Config.RepairCostAmount["brake"][class].costs ,title = "Sửa chữa bộ phận này", action = "pw-vehicles:repairVehicle", key = {name = "brake"} },
              },
            },
            {
              icon = 'list-check',
              title = "10. Cây trục",
              description = "Tình trạng: " .. degHealth.axle,
              children = { 
              { icon = "wrench", description = Config.RepairCostAmount["axle"][class].label.." : ".. Config.RepairCostAmount["axle"][class].costs ,title = "Sửa chữa bộ phận này", action = "pw-vehicles:repairVehicle", key = {name = "axle"} },
              },
            },
          },
      },
    }

    --exports["np-ui"]:showContextMenu(data)
	exports["pw-context"]:showContextMenu(data)
end)



--RegisterUICallback('pw-vehicles:repairVehicle', function (data, cb)
AddEventHandler("pw-vehicles:repairVehicle", function(params)
	--cb({ data = {}, meta = { ok = true, message = '' } })
  local type = params.name
  local vehicle = GetVehiclePedIsIn(PlayerPedId(),false)

  if not vehicle then return end

  local plate = GetVehicleNumberPlateText(vehicle)
  local degHealth = json.decode(RPC.execute("pw-vehicles:getDegradation", plate))
  local bodyHealth = GetVehicleBodyHealth(vehicle)
  local engineHealth = GetVehicleEngineHealth(vehicle)
  local class = exports["pw-vehicles"]:GetVehicleClass(vehicle)

  local item = string.lower(class).."fix"..type

  if not exports["pw-inventory"]:hasEnoughOfItem(item, 1, true) then return end

  TriggerEvent("inventory:removeItem", item, 1)

  Citizen.Wait(100)

  RequestAnimDict("mp_car_bomb")
	TaskPlayAnim(PlayerPedId(), "mp_car_bomb","car_bomb_mechanic", 8.0, -8, -1, 49, 0, 0, 0, 0)
	Citizen.Wait(100)
	TaskPlayAnim(PlayerPedId(), "mp_car_bomb","car_bomb_mechanic", 8.0, -8, -1, 49, 0, 0, 0, 0)

	local finished = exports["pw-taskbar"]:taskBar(15000, "Repairing")
    if finished then
        if type == "body" then
            SetVehicleBodyHealth(vehicle, 1000.0)
            SetVehicleFixed(vehicle)
			      SetVehiclePetrolTankHealth(vehicle, 4000.0)
            SetVehicleEngineHealth(vehicle, engineHealth)
            for i = 0, 4 do
                SetVehicleTyreFixed(vehicle, i)
            end

            exports["pw-vehicles"]:updateVehicleHealth()
        elseif type == "engine" then
            SetVehicleEngineHealth(vehicle, 1000.0)
            SetVehicleFixed(vehicle)
			      SetVehiclePetrolTankHealth(vehicle, 4000.0)
            SetVehicleBodyHealth(vehicle, bodyHealth)

            exports["pw-vehicles"]:updateVehicleHealth()
        else
            if type == "tire" then
                for i = 0, 4 do
                    SetVehicleTyreFixed(vehicle, i)
                end
            end

            degHealth[type] = 100
            TriggerServerEvent("pw-vehicles:updateVehicleDegradation", plate, degHealth)
        end
    end

    ClearPedTasks(PlayerPedId())
end)


RegisterNetEvent('pw-mechanicjob:Check', function()

  local vehicle = nil
  local target = exports["pw-interact"]:GetCurrentEntity()
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
  local data = {}
  data = {
      {
          icon = 'wrench',
          title = "Loại xe",
          description = "Hạng: " .. class .. " | Môtơ-mét: " .. mileage,
      },
      {
          icon = "check",
          title = "Kiểm tra xe",
          children = {
              {
                icon = 'searchengin',
                title = "1. Động cơ",
                description = "Tình trạng: " .. degHealth.engine,
              },
              {
                icon = 'searchengin',
                title = "2. Thân vỏ",
                description = "Tình trạng: " .. degHealth.body,
              },

              {
                icon = 'searchengin',
                title = "3. Ly hợp",
                description = "Tình trạng: " .. degHealth.clutch,
              },
              {
                icon = 'searchengin',
                title = "4. Thiết bị điện tử",
                description = "Tình trạng: " .. degHealth.electronics,
              },

              {
                icon = 'searchengin',
                title = "5. Bộ tản nhiệt động cơ",
                description = "Tình trạng: " .. degHealth.radiator,
              },
              {
                icon = 'searchengin',
                title = "6. Kim phun nhiên liệu",
                description = "Tình trạng: " .. degHealth.injector,
              },
              {
                icon = 'searchengin',
                title = "7. Trục chuyển",
                description = "Tình trạng: " .. degHealth.transmission,
              },
              {
                icon = 'searchengin',
                title = "8. Lốp xe",
                description = "Tình trạng: " .. degHealth.tire,
              },
              {
                icon = 'searchengin',
                title = "9. Đĩa phanh",
                description = "Tình trạng: " .. degHealth.brake,
              },
              {
                icon = 'searchengin',
                title = "10. Cây trục",
                description = "Tình trạng: " .. degHealth.axle,
              },
          },
      },
  }

  exports["pw-context"]:showContextMenu(data)
end)



RegisterNetEvent('pw-mechanicjob:VehicleList', function(location)
	--for k, v in pairs(Config.Vehicles) do
  local data = {}
  for k, v in pairs(Config.Vehicles) do
     data[#data+1] = {
          icon = "taxi",
          title = v,
          description = "",
          action = "pw-mechanicjob:SpawnListVehicle",
          key = {
              model = k,
              pos = location
          },
      
    }
  end
		
  exports["pw-context"]:showContextMenu(data)
end)

RegisterNetEvent('pw-mechanicjob:SpawnListVehicle')
AddEventHandler('pw-mechanicjob:SpawnListVehicle', function(data)
    local model = data.model
    local coord = data.pos
    print(model)
    print(data.pos)
    local coords = {
        x = coord[1].x,
        y = coord[1].y,
        z = coord[1].z,
        w = coord[2],
    }
    local plate = "AC"..math.random(1111, 9999)
    ESX.Game.SpawnVehicleqb(model, function(veh)
        SetVehicleNumberPlateText(veh, "ACBV"..tostring(math.random(1000, 9999)))
        SetEntityHeading(veh, coords.h)
        exports['pw-fuel']:SetFuel(veh, 100.0)
        --Menu.hidden = true
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
        SetVehicleEngineOn(veh, true, true)
    end, coords, true)
end)
