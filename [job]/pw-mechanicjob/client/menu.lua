
RegisterNetEvent('pw-mechanicjob:MainMenu', function()

    local vehicle = GetVehiclePedIsIn(PlayerPedId(),false)

    if not vehicle then return end

    local plate = GetVehicleNumberPlateText(vehicle)
	  local class = exports["pw-vehicles"]:GetVehicleClass(vehicle)
    local mileage = RPC.execute("pw-vehicles:getMileage", plate)
    local degHealth = json.decode(RPC.execute("pw-vehicles:getDegradation", plate))
    degHealth["body"] = round(GetVehicleBodyHealth(vehicle) / 10)
    degHealth["engine"] = round(GetVehicleEngineHealth(vehicle) / 10)

    local data = {
      {
          title = "Kết thúc sửa chữa",
          description = "Hạng: " .. class .. " | Môtơ-mét: " .. mileage,
          action = 'pw-mechanicjob:DetachVehicle',
      },
      {
        icon = "check",
        title = "Kiểm tra xe",
        children = {
            
            {
              title = "1. Động cơ",
              description = "Tình trạng: " .. degHealth.engine,
              children = { 
                { icon = "wrench", description = Config.RepairCostAmount["engine_damage"][class].label.." : ".. Config.RepairCostAmount["engine_damage"][class].costs ,title = "Sửa chữa bộ phận này", action = "pw-vehicles:repairVehicle", key = {name = "engine"} },
              },
            },
            {
                title = "2. Thân vỏ",
                description = "Tình trạng: " .. degHealth.body,
                children = { 
                  { icon = "wrench", description = Config.RepairCostAmount["body_damage"][class].label.." : ".. Config.RepairCostAmount["body_damage"][class].costs ,title = "Sửa chữa bộ phận này", action = "pw-vehicles:repairVehicle", key = {name = "body"} },
                },
            },
            
            {
                title = "3. Ly hợp",
                description = "Tình trạng: " .. degHealth.clutch,
                children = { 
                  { icon = "wrench", description = Config.RepairCostAmount["clutch"][class].label.." : ".. Config.RepairCostAmount["clutch"][class].costs ,title = "Sửa chữa bộ phận này", action = "pw-vehicles:repairVehicle", key = {name = "clutch"} },
                },
            },
            {
                title = "4. Thiết bị điện tử",
                description = "Tình trạng: " .. degHealth.electronics,
                children = { 
                  { icon = "wrench", description = Config.RepairCostAmount["electronics"][class].label.." : ".. Config.RepairCostAmount["electronics"][class].costs ,title = "Sửa chữa bộ phận này", action = "pw-vehicles:repairVehicle", key = {name = "electronic"} },
                },
            },
            
            {
                title = "5. Bộ tản nhiệt động cơ",
                description = "Tình trạng: " .. degHealth.radiator,
                children = { 
                  { icon = "wrench", description = Config.RepairCostAmount["radiator"][class].label.." : ".. Config.RepairCostAmount["radiator"][class].costs ,title = "Sửa chữa bộ phận này", action = "pw-vehicles:repairVehicle", key = {name = "radiator"} },
                },
            },
            {
                title = "6. Kim phun nhiên liệu",
                description = "Tình trạng: " .. degHealth.injector,
                children = { 
                  { icon = "wrench", description = Config.RepairCostAmount["injector"][class].label.." : ".. Config.RepairCostAmount["injector"][class].costs ,title = "Sửa chữa bộ phận này", action = "pw-vehicles:repairVehicle", key = {name = "injector"} },
                },
            },
            {
                title = "7. Trục chuyển",
                description = "Tình trạng: " .. degHealth.transmission,
                children = { 
                  { icon = "wrench", description = Config.RepairCostAmount["transmission"][class].label.." : ".. Config.RepairCostAmount["transmission"][class].costs ,title = "Sửa chữa bộ phận này", action = "pw-vehicles:repairVehicle", key = {name = "transmission"} },
                },
            },
            {
                title = "8. Lốp xe",
                description = "Tình trạng: " .. degHealth.tire,
                children = { 
                  { icon = "wrench", description = Config.RepairCostAmount["tire"][class].label.." : ".. Config.RepairCostAmount["tire"][class].costs ,title = "Sửa chữa bộ phận này", action = "pw-vehicles:repairVehicle", key = {name = "tire"} },
                },
            },
            {
                title = "9. Đĩa phanh",
                description = "Tình trạng: " .. degHealth.brake,
                children = { 
                  { icon = "wrench", description = Config.RepairCostAmount["brake"][class].label.." : ".. Config.RepairCostAmount["brake"][class].costs ,title = "Sửa chữa bộ phận này", action = "pw-vehicles:repairVehicle", key = {name = "brake"} },
                },
            },
            {
                title = "10. Cây trục",
                description = "Tình trạng: " .. degHealth.axle,
                children = { 
                { icon = "wrench", description = Config.RepairCostAmount["axle"][class].label.." : ".. Config.RepairCostAmount["axle"][class].costs ,title = "Sửa chữa bộ phận này", action = "pw-vehicles:repairVehicle", key = {name = "axle"} },
              },
            },
          },
        },
    },

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

  local data = {
    {
        title = "Kết thúc sửa chữa",
        description = "Hạng: " .. class .. " | Môtơ-mét: " .. mileage,
        action = 'pw-mechanicjob:DetachVehicle',
    },
    {
      icon = "check",
      title = "Kiểm tra xe",
      children = {
          
          {
            title = "1. Động cơ",
            description = "Tình trạng: " .. degHealth.engine,
          },
          {
              title = "2. Thân vỏ",
              description = "Tình trạng: " .. degHealth.body,
          },
          
          {
              title = "3. Ly hợp",
              description = "Tình trạng: " .. degHealth.clutch,
          },
          {
              title = "4. Thiết bị điện tử",
              description = "Tình trạng: " .. degHealth.electronics,
          },
          
          {
              title = "5. Bộ tản nhiệt động cơ",
              description = "Tình trạng: " .. degHealth.radiator,
          },
          {
              title = "6. Kim phun nhiên liệu",
              description = "Tình trạng: " .. degHealth.injector,
          },
          {
              title = "7. Trục chuyển",
              description = "Tình trạng: " .. degHealth.transmission,
          },
          {
              title = "8. Lốp xe",
              description = "Tình trạng: " .. degHealth.tire,
          },
          {
              title = "9. Đĩa phanh",
              description = "Tình trạng: " .. degHealth.brake,
          },
          {
              title = "10. Cây trục",
              description = "Tình trạng: " .. degHealth.axle,
          },
        },
      },
  },

exports["pw-context"]:showContextMenu(data)
end)


RegisterNetEvent('pw-mechanicjob:VehicleList', function()
 
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
          },
      
    }
  end
		
  exports["pw-context"]:showContextMenu(data)
end)