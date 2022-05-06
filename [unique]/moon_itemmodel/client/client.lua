RegisterNetEvent('phmodel:h_wheel')
AddEventHandler('phmodel:h_wheel', function ()
	TriggerEvent(Config['Event'][2])
	if not wheel then
		--
		wheel = true
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop1), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop1), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.25, 0.00, 0.00, 0.0, 90.00, 200.0, true, true, false, true, 1, true)
		else
		--
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop1), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop1), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.25, 0.00, 0.00, 0.0, 90.00, 200.0, true, true, false, true, 1, true)
		ClearPedTasks(ped)
		wheel = false
		DetachEntity(prop, ped, boneIndex, 0.25, 0.00, 0.00, 0.0, 90.00, 200.0, true, true, false, true, 1, true)
		DeleteObject(prop)
	end
end)

RegisterNetEvent('phmodel:pCube2')
AddEventHandler('phmodel:pCube2', function ()
	TriggerEvent(Config['Event'][2])
	if not wheel then
		--
		wheel = true
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop2), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop2), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.06, 0.00, 0.00, 0.0, 90.00, 270.0, true, true, false, true, 1, true)
		else
		--
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop2), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop2), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.06, 0.00, 0.00, 0.0, 90.00, 270.0, true, true, false, true, 1, true)
		ClearPedTasks(ped)
		wheel = false
		DetachEntity(prop, ped, boneIndex, 0.06, 0.00, 0.00, 0.0, 90.00, 270.0, true, true, false, true, 1, true)
		DeleteObject(prop)
	end
end)

RegisterNetEvent('phmodel:pCube22')
AddEventHandler('phmodel:pCube22', function ()
	TriggerEvent(Config['Event'][2])
	if not wheel then
		--
		wheel = true
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop4), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop4), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.06, 0.00, 0.00, 0.0, 90.00, 270.0, true, true, false, true, 1, true)
		else
		--
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop4), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop4), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.06, 0.00, 0.00, 0.0, 90.00, 270.0, true, true, false, true, 1, true)
		ClearPedTasks(ped)
		wheel = false
		DetachEntity(prop, ped, boneIndex, 0.06, 0.00, 0.00, 0.0, 90.00, 270.0, true, true, false, true, 1, true)
		DeleteObject(prop)
	end
end)

RegisterNetEvent('phmodel:pCube222')
AddEventHandler('phmodel:pCube222', function ()
	TriggerEvent(Config['Event'][2])
	if not wheel then
		--
		wheel = true
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop5), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop5), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.06, 0.00, 0.00, 0.0, 90.00, 270.0, true, true, false, true, 1, true)
		else
		--
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop5), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop5), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.06, 0.00, 0.00, 0.0, 90.00, 270.0, true, true, false, true, 1, true)
		ClearPedTasks(ped)
		wheel = false
		DetachEntity(prop, ped, boneIndex, 0.06, 0.00, 0.00, 0.0, 90.00, 270.0, true, true, false, true, 1, true)
		DeleteObject(prop)
	end
end)

RegisterNetEvent('phmodel:pCube2222')
AddEventHandler('phmodel:pCube2222', function ()
	TriggerEvent(Config['Event'][2])
	if not wheel then
		--
		wheel = true
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop12), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop12), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.06, 0.00, 0.00, 0.0, 90.00, 270.0, true, true, false, true, 1, true)
		else
		--
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop12), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop12), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.06, 0.00, 0.00, 0.0, 90.00, 270.0, true, true, false, true, 1, true)
		ClearPedTasks(ped)
		wheel = false
		DetachEntity(prop, ped, boneIndex, 0.06, 0.00, 0.00, 0.0, 90.00, 270.0, true, true, false, true, 1, true)
		DeleteObject(prop)
	end
end)

RegisterNetEvent('phmodel:arcadeahri')
AddEventHandler('phmodel:arcadeahri', function ()
	TriggerEvent(Config['Event'][2])
	if not wheel then
		--
		wheel = true
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop6), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop6), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.13, 0.00, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		else
		--
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop6), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop6), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.13, 0.00, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		ClearPedTasks(ped)
		wheel = false
		DetachEntity(prop, ped, boneIndex, 0.13, 0.00, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		DeleteObject(prop)
	end
end)

RegisterNetEvent('phmodel:BearHat')
AddEventHandler('phmodel:BearHat', function ()
	TriggerEvent(Config['Event'][2])
	if not wheel then
		--
		wheel = true
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop7), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop7), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.10, 0.01, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
	else
		--
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop7), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop7), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.10, 0.01, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		ClearPedTasks(ped)
		wheel = false
		DetachEntity(prop, ped, boneIndex, 0.10, 0.01, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		DeleteObject(prop)
	end
end)

RegisterNetEvent('phmodel:DevilHorns')
AddEventHandler('phmodel:DevilHorns', function ()
	TriggerEvent(Config['Event'][2])
	if not wheel then
		--
		wheel = true
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop10), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop10), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.13, 0.10, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		else
		--
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop10), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop10), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.13, 0.10, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		ClearPedTasks(ped)
		wheel = false
		DetachEntity(prop, ped, boneIndex, 0.13, 0.10, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		DeleteObject(prop)
	end
end)

RegisterNetEvent('phmodel:DevilHorns2')
AddEventHandler('phmodel:DevilHorns2', function ()
	TriggerEvent(Config['Event'][2])
	if not wheel then
		--
		wheel = true
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop20), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop20), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.13, 0.10, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		else
		--
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop20), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop20), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.13, 0.10, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		ClearPedTasks(ped)
		wheel = false
		DetachEntity(prop, ped, boneIndex, 0.13, 0.10, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		DeleteObject(prop)
	end
end)

RegisterNetEvent('phmodel:CatEars1')
AddEventHandler('phmodel:CatEars1', function ()
	TriggerEvent(Config['Event'][2])
	if not wheel then
		--
		wheel = true
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop11), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop11), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.08, 0.05, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		else
		--
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop11), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop11), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.08, 0.05, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		ClearPedTasks(ped)
		wheel = false
		DetachEntity(prop, ped, boneIndex, 0.08, 0.05, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		DeleteObject(prop)
	end
end)

RegisterNetEvent('phmodel:Mousehat')
AddEventHandler('phmodel:Mousehat', function ()
	TriggerEvent(Config['Event'][2])
	if not wheel then
		--
		wheel = true
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop8), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop8), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, -1.69, 0.02, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		else
		--
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop8), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop8), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, -1.69, 0.02, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		ClearPedTasks(ped)
		wheel = false
		DetachEntity(prop, ped, boneIndex, -1.69, 0.02, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		DeleteObject(prop)
	end
end)

RegisterNetEvent('phmodel:WINGSrENDER')
AddEventHandler('phmodel:WINGSrENDER', function ()
	TriggerEvent(Config['Event'][2])
	if not wheel then
		--
		wheel = true
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop19), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop19), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x2E28)
        AttachEntityToEntity(prop, ped, boneIndex, -0.40, -0.20, 0.00, 0.0, 270.00, 182.0, true, true, false, true, 1, true)
		else
		--
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop19), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop19), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, -0.35, -0.28, 0.00, 0.0, 90.00, 0.0, true, true, false, true, 1, true)
		ClearPedTasks(ped)
		wheel = false
		DetachEntity(prop, ped, boneIndex, -0.35, -0.28, 0.00, 0.0, 90.00, 0.0, true, true, false, true, 1, true)
		DeleteObject(prop)
	end
end)

RegisterNetEvent('phmodel:angel_wing')
AddEventHandler('phmodel:angel_wing', function ()
	TriggerEvent(Config['Event'][2])
	if not wheel then
		--
		wheel = true
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop9), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop9), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x2E28)
        AttachEntityToEntity(prop, ped, boneIndex, -0.00, 0.00, -0.00, 0.0, 270.00, 182.0, true, true, false, true, 1, true)
        else
		--
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop9), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop9), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x2E28)
        AttachEntityToEntity(prop, ped, boneIndex, -0.00, 0.00, -0.05, 0.0, 00.00, 182.0, true, true, false, true, 1, true)
		ClearPedTasks(ped)
		wheel = false
		DetachEntity(prop, ped, boneIndex, -0.59, -0.15, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		DeleteObject(prop)
	end
end)

RegisterNetEvent('phmodel:angel_wing2')
AddEventHandler('phmodel:angel_wing2', function ()
	TriggerEvent(Config['Event'][2])
	if not wheel then
		--
		wheel = true
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop13), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop13), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x2E28)
        AttachEntityToEntity(prop, ped, boneIndex, -0.00, 0.00, -0.00, 0.0, 270.00, 182.0, true, true, false, true, 1, true)
		else
		--
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop13), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop13), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, -0.59, -0.15, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		ClearPedTasks(ped)
		wheel = false
		DetachEntity(prop, ped, boneIndex, -0.59, -0.15, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		DeleteObject(prop)
	end
end)

RegisterNetEvent('phmodel:angel_wing3')
AddEventHandler('phmodel:angel_wing3', function ()
	TriggerEvent(Config['Event'][2])
	if not wheel then
		--
		wheel = true
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop14), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop14), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x2E28)
        AttachEntityToEntity(prop, ped, boneIndex, -0.00, 0.00, -0.00, 0.0, 270.00, 182.0, true, true, false, true, 1, true)
		else
		--
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop14), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop14), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, -0.59, -0.15, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		ClearPedTasks(ped)
		wheel = false
		DetachEntity(prop, ped, boneIndex, -0.59, -0.15, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		DeleteObject(prop)
	end
end)

RegisterNetEvent('phmodel:wingshalloween')
AddEventHandler('phmodel:wingshalloween', function ()
	TriggerEvent(Config['Event'][2])
	if not wheel then
		--
		wheel = true
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop15), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop15), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x2E28)
        AttachEntityToEntity(prop, ped, boneIndex, -0.38, -0.24, 0.00, 0.0, 270.00, 182.0, true, true, false, true, 1, true)
		else
		--
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop15), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop15), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, -0.35, -0.28, 0.00, 0.0, 90.00, 0.0, true, true, false, true, 1, true)
		ClearPedTasks(ped)
		wheel = false
		DetachEntity(prop, ped, boneIndex, -0.35, -0.28, 0.00, 0.0, 90.00, 0.0, true, true, false, true, 1, true)
		DeleteObject(prop)
	end
end)

RegisterNetEvent('phmodel:heartpink')
AddEventHandler('phmodel:heartpink', function ()
	TriggerEvent(Config['Event'][2])
	if not wheel then
		--
		wheel = true
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop16), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop16), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.37, 0.0, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		else
		--
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop16), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop16), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.37, 0.0, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		ClearPedTasks(ped)
		wheel = false
		DetachEntity(prop, ped, boneIndex, 0.37, 0.0, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		DeleteObject(prop)
	end
end)

RegisterNetEvent('phmodel:anglewing')
AddEventHandler('phmodel:anglewing', function ()
	TriggerEvent(Config['Event'][2])
	if not wheel then
		--
		wheel = true
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop17), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop17), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x2E28)
        AttachEntityToEntity(prop, ped, boneIndex, -0.40, -0.20, 0.00, 0.0, 270.00, 182.0, true, true, false, true, 1, true)
		else
		--
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop17), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop17), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x2E28)
        AttachEntityToEntity(prop, ped, boneIndex, -0.20, 0.00, 0.00, 0.0, 270.00, 182.0, true, true, false, true, 1, true)
		ClearPedTasks(ped)
		wheel = false
		DetachEntity(prop, ped, boneIndex, -0.15, -0.1, 0.00, 0.0, 90.00, 180.0, true, true, false, true, 1, true)
		DeleteObject(prop)
	end
end)

RegisterNetEvent('phmodel:hellwing')
AddEventHandler('phmodel:hellwing', function ()
	TriggerEvent(Config['Event'][2])
	if not wheel then
		--
		wheel = true
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop18), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop18), x, y, z + 0.0, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x2E28)
        AttachEntityToEntity(prop, ped, boneIndex, -0.50, -0.04, 0.00, 0.0, 270.00, 182.0, true, true, false, true, 1, true)
		else
		--
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop18), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop18), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, -0.15, -0.2, 0.00, 0.0, 90.00, 0.0, true, true, false, true, 1, true)
		ClearPedTasks(ped)
		wheel = false
		DetachEntity(prop, ped, boneIndex, -0.15, -0.2, 0.00, 0.0, 90.00, 0.0, true, true, false, true, 1, true)
		DeleteObject(prop)
	end
end)

RegisterNetEvent('phmodel:sunglasses')
AddEventHandler('phmodel:sunglasses', function ()
	TriggerEvent(Config['Event'][2])
	if not wheel then
		--
		wheel = true
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop3), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop3), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.06, 0.10, 0.0, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		else
		--
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop3), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop3), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.06, 0.10, 0.0, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		ClearPedTasks(ped)
		wheel = false
		DetachEntity(prop, ped, boneIndex, 0.06, 0.10, 0.0, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		DeleteObject(prop)
	end
end)

RegisterNetEvent('phmodel:woodcooper')
AddEventHandler('phmodel:woodcooper', function ()
	TriggerEvent(Config['Event'][2])
	if not wheel then
		--
		wheel = true
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop21), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop21), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x8C53)
		AttachEntityToEntity(prop, ped, boneIndex, -0.100, 0.00, 0.00, 0.0, 20.00, 150.0, true, true, false, true, 1, true)
		else
		--
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop21), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop21), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x8C53)
		AttachEntityToEntity(prop, ped, boneIndex, -0.59, -0.15, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		ClearPedTasks(ped)
		wheel = false
		DetachEntity(prop, ped, boneIndex, -0.59, -0.15, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		DeleteObject(prop)
	end
end)

RegisterNetEvent('phmodel:cyclops')
AddEventHandler('phmodel:cyclops', function ()
	TriggerEvent(Config['Event'][2])
	if not wheel then
		--
		wheel = true
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop22), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop22), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.06, 0.05, 0.0, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		else
		--
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop22), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop22), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.06, 0.10, 0.0, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		ClearPedTasks(ped)
		wheel = false
		DetachEntity(prop, ped, boneIndex, 0.06, 0.10, 0.0, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		DeleteObject(prop)
	end
end)

RegisterNetEvent('phmodel:mrak1')
AddEventHandler('phmodel:mrak1', function ()
	TriggerEvent(Config['Event'][2])
	if not wheel then
		--
		wheel = true
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop23), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop23), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, -0.65, 0.01, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		else
		--
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop23), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop23), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.10, 0.01, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		ClearPedTasks(ped)
		wheel = false
		DetachEntity(prop, ped, boneIndex, 0.10, 0.01, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		DeleteObject(prop)
	end
end)

RegisterNetEvent('phmodel:highsupreme')
AddEventHandler('phmodel:highsupreme', function ()
	TriggerEvent(Config['Event'][2])
	if not wheel then
		--
		wheel = true
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop24), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop24), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, -0.65, 0.01, 0.0, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		else
		--
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop24), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop24), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.06, 0.10, 0.0, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		ClearPedTasks(ped)
		wheel = false
		DetachEntity(prop, ped, boneIndex, 0.06, 0.10, 0.0, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		DeleteObject(prop)
	end
end)

RegisterNetEvent('phmodel:mask3')
AddEventHandler('phmodel:mask3', function ()
	TriggerEvent(Config['Event'][2])
	if not wheel then
		--
		wheel = true
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop25), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop25), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, -0.01, 0.12, 0.0, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		else
		--
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop25), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop25), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.06, 0.10, 0.0, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		ClearPedTasks(ped)
		wheel = false
		DetachEntity(prop, ped, boneIndex, 0.06, 0.10, 0.0, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		DeleteObject(prop)
	end
end)

RegisterNetEvent('phmodel:diamond1')
AddEventHandler('phmodel:diamond1', function ()
	TriggerEvent(Config['Event'][2])
	if not wheel then
		--
		wheel = true
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop26), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop26), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.40, 0.01, 0.0, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		else
		--
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop26), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop26), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.06, 0.10, 0.0, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		ClearPedTasks(ped)
		wheel = false
		DetachEntity(prop, ped, boneIndex, 0.06, 0.10, 0.0, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		DeleteObject(prop)
	end
end)

RegisterNetEvent('phmodel:star1')
AddEventHandler('phmodel:star1', function ()
	TriggerEvent(Config['Event'][2])
	if not wheel then
		--
		wheel = true
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop27), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop27), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x9D4D)
		AttachEntityToEntity(prop, ped, boneIndex, 0.05, 0.00, 0.05, 0.0, 260.0, 90.0, true, true, false, true, 1, true)
		else
		--
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop27), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop27), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x9D4D)
		AttachEntityToEntity(prop, ped, boneIndex, 0.06, 0.10, 0.0, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		ClearPedTasks(ped)
		wheel = false
		DetachEntity(prop, ped, boneIndex, 0.06, 0.10, 0.0, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		DeleteObject(prop)
	end
end)

RegisterNetEvent('phmodel:mask2')
AddEventHandler('phmodel:mask2', function ()
	TriggerEvent(Config['Event'][2])
	if not wheel then
		--
		wheel = true
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop28), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop28), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, -0.01, 0.12, 0.0, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		else
		--
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop28), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop28), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.06, 0.10, 0.0, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		ClearPedTasks(ped)
		wheel = false
		DetachEntity(prop, ped, boneIndex, 0.06, 0.10, 0.0, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		DeleteObject(prop)
	end
end)

RegisterNetEvent('phmodel:mask4')
AddEventHandler('phmodel:mask4', function ()
	TriggerEvent(Config['Event'][2])
	if not wheel then
		--
		wheel = true
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop29), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop29), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, -0.05, 0.01, 0.0, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		else
		--
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop29), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop29), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.06, 0.10, 0.0, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		ClearPedTasks(ped)
		wheel = false
		DetachEntity(prop, ped, boneIndex, 0.06, 0.10, 0.0, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		DeleteObject(prop)
	end
end)

RegisterNetEvent('phmodel:diamond2')
AddEventHandler('phmodel:diamond2', function ()
	TriggerEvent(Config['Event'][2])
	if not wheel then
		--
		wheel = true
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop30), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop30), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.40, 0.01, 0.0, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		else
		--
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop30), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop30), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.06, 0.10, 0.0, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		ClearPedTasks(ped)
		wheel = false
		DetachEntity(prop, ped, boneIndex, 0.06, 0.10, 0.0, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		DeleteObject(prop)
	end
end)

RegisterNetEvent('phmodel:ufohead')
AddEventHandler('phmodel:ufohead', function ()
	TriggerEvent(Config['Event'][2])
	if not wheel then
		--
		wheel = true
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop31), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop31), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.30, 0.00, 0.00, 0.0, 90.00, 200.0, true, true, false, true, 1, true)
		else
		--
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop31), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop31), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.25, 0.00, 0.00, 0.0, 90.00, 200.0, true, true, false, true, 1, true)
		ClearPedTasks(ped)
		wheel = false
		DetachEntity(prop, ped, boneIndex, 0.25, 0.00, 0.00, 0.0, 90.00, 200.0, true, true, false, true, 1, true)
		DeleteObject(prop)
	end
end)

RegisterNetEvent('phmodel:prop_hat-magic')
AddEventHandler('phmodel:prop_hat-magic', function ()
	TriggerEvent(Config['Event'][2])
	if not wheel then
		--
		wheel = true
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop32), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop32), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.17, 0.20, 0.07, 0.0, 90.00, 200.0, true, true, false, true, 1, true)
	else
		--
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop32), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop32), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.10, 0.01, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		ClearPedTasks(ped)
		wheel = false
		DetachEntity(prop, ped, boneIndex, 0.10, 0.01, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		DeleteObject(prop)
	end
end)

RegisterNetEvent('phmodel:birdcooper')
AddEventHandler('phmodel:birdcooper', function ()
	TriggerEvent(Config['Event'][2])
	if not wheel then
		--
		wheel = true
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop33), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop33), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x29D2)
		AttachEntityToEntity(prop, ped, boneIndex, 0.13, -0.08, 0.05, 0.00, -5.00, 182.0, true, true, false, true, 1, true)
		else
		--
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop33), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop33), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.06, 0.10, 0.0, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		ClearPedTasks(ped)
		wheel = false
		DetachEntity(prop, ped, boneIndex, 0.06, 0.10, 0.0, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		DeleteObject(prop)
	end
end)

RegisterNetEvent('phmodel:mask5')
AddEventHandler('phmodel:mask5', function ()
	TriggerEvent(Config['Event'][2])
	if not wheel then
		--
		wheel = true
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop34), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop34), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.03, 0.08, 0.0, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		else
		--
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop34), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop34), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.06, 0.10, 0.0, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		ClearPedTasks(ped)
		wheel = false
		DetachEntity(prop, ped, boneIndex, 0.06, 0.10, 0.0, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		DeleteObject(prop)
	end
end)

RegisterNetEvent('phmodel:mask6')
AddEventHandler('phmodel:mask6', function ()
	TriggerEvent(Config['Event'][2])
	if not wheel then
		--
		wheel = true
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop35), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop35), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.03, 0.08, 0.0, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		else
		--
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop35), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop35), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.06, 0.10, 0.0, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		ClearPedTasks(ped)
		wheel = false
		DetachEntity(prop, ped, boneIndex, 0.06, 0.10, 0.0, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		DeleteObject(prop)
	end
end)

RegisterNetEvent('phmodel:one1')
AddEventHandler('phmodel:one1', function ()
	TriggerEvent(Config['Event'][2])
	if not wheel then
		--
		wheel = true
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop36), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop36), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.00, 0.00, 0.0, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		else
		--
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop36), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop36), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.06, 0.10, 0.0, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		ClearPedTasks(ped)
		wheel = false
		DetachEntity(prop, ped, boneIndex, 0.06, 0.10, 0.0, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		DeleteObject(prop)
	end
end)

RegisterNetEvent('phmodel:one2')
AddEventHandler('phmodel:one2', function ()
	TriggerEvent(Config['Event'][2])
	if not wheel then
		--
		wheel = true
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop37), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop37), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.00, 0.00, 0.0, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		else
		--
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop37), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop37), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.06, 0.10, 0.0, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		ClearPedTasks(ped)
		wheel = false
		DetachEntity(prop, ped, boneIndex, 0.06, 0.10, 0.0, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		DeleteObject(prop)
	end
end)

RegisterNetEvent('phmodel:wood1oakker')
AddEventHandler('phmodel:wood1oakker', function ()
	TriggerEvent(Config['Event'][2])
	if not wheel then
		--
		wheel = true
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop41), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop41), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x8C53)
		AttachEntityToEntity(prop, ped, boneIndex, -0.100, 0.00, 0.00, 0.0, 20.00, 150.0, true, true, false, true, 1, true)
		else
		--
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop41), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop41), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x8C53)
		AttachEntityToEntity(prop, ped, boneIndex, -0.59, -0.15, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		ClearPedTasks(ped)
		wheel = false
		DetachEntity(prop, ped, boneIndex, -0.59, -0.15, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		DeleteObject(prop)
	end
end)

RegisterNetEvent('phmodel:bearhatoakker1')
AddEventHandler('phmodel:bearhatoakker1', function ()
	TriggerEvent(Config['Event'][2])
	if not wheel then
		--
		wheel = true
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop44), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop44), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.08, 0.05, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		else
		--
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop44), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop44), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.08, 0.05, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		ClearPedTasks(ped)
		wheel = false
		DetachEntity(prop, ped, boneIndex, 0.08, 0.05, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		DeleteObject(prop)
	end
end)

RegisterNetEvent('phmodel:wingoakker1')
AddEventHandler('phmodel:wingoakker1', function ()
	TriggerEvent(Config['Event'][2])
	if not wheel then
		--
		wheel = true
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop46), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop46), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x2E28)
        AttachEntityToEntity(prop, ped, boneIndex, -0.40, -0.20, 0.00, 0.0, 270.00, 182.0, true, true, false, true, 1, true)
		else
		--
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop46), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop46), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x2E28)
        AttachEntityToEntity(prop, ped, boneIndex, -0.20, 0.00, 0.00, 0.0, 270.00, 182.0, true, true, false, true, 1, true)
		ClearPedTasks(ped)
		wheel = false
		DetachEntity(prop, ped, boneIndex, -0.15, -0.1, 0.00, 0.0, 90.00, 180.0, true, true, false, true, 1, true)
		DeleteObject(prop)
	end
end)

RegisterNetEvent('phmodel:blackoakker1')
AddEventHandler('phmodel:blackoakker1', function ()
	TriggerEvent(Config['Event'][2])
	if not wheel then
		--
		wheel = true
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop45), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop45), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x2E28)
        AttachEntityToEntity(prop, ped, boneIndex, 0.10, -0.00, 0.00, 0.0, 270.00, 182.0, true, true, false, true, 1, true)
		else
		--
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop45), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop45), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x2E28)
        AttachEntityToEntity(prop, ped, boneIndex, -0.20, 0.00, 0.00, 0.0, 270.00, 182.0, true, true, false, true, 1, true)
		ClearPedTasks(ped)
		wheel = false
		DetachEntity(prop, ped, boneIndex, -0.15, -0.1, 0.00, 0.0, 90.00, 180.0, true, true, false, true, 1, true)
		DeleteObject(prop)
	end
end)

RegisterNetEvent('phmodel:redoakker1')
AddEventHandler('phmodel:redoakker1', function ()
	TriggerEvent(Config['Event'][2])
	if not wheel then
		--
		wheel = true
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop47), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop47), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x2E28)
        AttachEntityToEntity(prop, ped, boneIndex, 0.10, -0.00, 0.00, 0.0, 270.00, 182.0, true, true, false, true, 1, true)
		else
		--
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop47), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop47), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x2E28)
        AttachEntityToEntity(prop, ped, boneIndex, -0.20, 0.00, 0.00, 0.0, 270.00, 182.0, true, true, false, true, 1, true)
		ClearPedTasks(ped)
		wheel = false
		DetachEntity(prop, ped, boneIndex, -0.15, -0.1, 0.00, 0.0, 90.00, 180.0, true, true, false, true, 1, true)
		DeleteObject(prop)
	end
end)

RegisterNetEvent('phmodel:hat1')
AddEventHandler('phmodel:hat1', function ()
	TriggerEvent(Config['Event'][2])
	if not wheel then
		--
		wheel = true
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop48), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop48), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.09, 0.06, 0.01, 0.0, 90.00, 200.0, true, true, false, true, 1, true)
	else
		--
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop48), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop48), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.10, 0.01, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		ClearPedTasks(ped)
		wheel = false
		DetachEntity(prop, ped, boneIndex, 0.10, 0.01, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		DeleteObject(prop)
	end
end)

RegisterNetEvent('phmodel:hat2')
AddEventHandler('phmodel:hat2', function ()
	TriggerEvent(Config['Event'][2])
	if not wheel then
		--
		wheel = true
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop49), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop49), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.09, 0.06, 0.01, 0.0, 90.00, 200.0, true, true, false, true, 1, true)
	else
		--
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop49), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop49), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.10, 0.01, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		ClearPedTasks(ped)
		wheel = false
		DetachEntity(prop, ped, boneIndex, 0.10, 0.01, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		DeleteObject(prop)
	end
end)

RegisterNetEvent('phmodel:predatoroakker')
AddEventHandler('phmodel:predatoroakker', function ()
	TriggerEvent(Config['Event'][2])
	if not wheel then
		--
		wheel = true
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop50), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop50), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.00, 0.04, 0.00, 0.00, 90.00, 190.0, true, true, false, true, 1, true)
	else
		--
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop50), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop50), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.10, 0.01, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		ClearPedTasks(ped)
		wheel = false
		DetachEntity(prop, ped, boneIndex, 0.10, 0.01, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		DeleteObject(prop)
	end
end)


--

RegisterNetEvent('phmodel:Chii')
AddEventHandler('phmodel:Chii', function ()
    TriggerEvent(Config['Event'][2])
    if not wheel then
        --
        wheel = true
        local ped = GetPlayerPed(-1)
        local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
        local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop51), false, false, false)
        if object ~= 0 then
            DeleteObject(object)
        end
        --
        local x,y,z = table.unpack(GetEntityCoords(ped))
        local prop = CreateObject(GetHashKey(Config.prop51), x, y, z + 0.2, true, true, true)
        local boneIndex = GetPedBoneIndex(ped, 0x322c)
        AttachEntityToEntity(prop, ped, boneIndex, -0.19, 0.02, 0.00, -0.10, 90.00, 179.0, true, true, false, true, 1, true)
    else
        --
        local ped = GetPlayerPed(-1)
        local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
        local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop51), false, false, false)
        if object ~= 0 then
            DeleteObject(object)
        end
        --
        local x,y,z = table.unpack(GetEntityCoords(ped))
        local prop = CreateObject(GetHashKey(Config.prop51), x, y, z + 0.2, true, true, true)
        local boneIndex = GetPedBoneIndex(ped, 0x322c)
        AttachEntityToEntity(prop, ped, boneIndex, 0.10, 0.01, 0.00, 0.0, 90.00, 180.0, true, true, false, true, 1, true)
        ClearPedTasks(ped)
        wheel = false
        DetachEntity(prop, ped, boneIndex, 0.10, 0.01, 0.00, 0.0, 90.00, 180.0, true, true, false, true, 1, true)
        DeleteObject(prop)
    end
end)

RegisterNetEvent('phmodel:Seal')
AddEventHandler('phmodel:Seal', function ()
	TriggerEvent(Config['Event'][2])
	if not wheel then
		--
		wheel = true
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop52), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop52), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x2E28)
        AttachEntityToEntity(prop, ped, boneIndex, -0.00, 0.00, -0.00, 0.0, 270.00, 182.0, true, true, false, true, 1, true)
        else
		--
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop52), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop52), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x2E28)
        AttachEntityToEntity(prop, ped, boneIndex, -0.00, 0.00, -0.05, 0.0, 00.00, 182.0, true, true, false, true, 1, true)
		ClearPedTasks(ped)
		wheel = false
		DetachEntity(prop, ped, boneIndex, -0.59, -0.15, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		DeleteObject(prop)
	end
end)



RegisterNetEvent('phmodel:Digger')
AddEventHandler('phmodel:Digger', function ()
	TriggerEvent(Config['Event'][2])
	if not wheel then
		--
		wheel = true
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop53), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop53), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x29D2)
		AttachEntityToEntity(prop, ped, boneIndex, 0.15, -0.01, 0.05, 0.00, -5.00, 182.0, true, true, false, true, 1, true)
		else
		--
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop53), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop53), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.06, 0.10, 0.0, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		ClearPedTasks(ped)
		wheel = false
		DetachEntity(prop, ped, boneIndex, 0.06, 0.10, 0.0, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		DeleteObject(prop)
	end
end)


RegisterNetEvent('phmodel:dragon')
AddEventHandler('phmodel:dragon', function ()
	TriggerEvent(Config['Event'][2])
	if not wheel then
		--
		wheel = true
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop54), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop54), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x29D2)
		AttachEntityToEntity(prop, ped, boneIndex, 0.15, -0.01, 0.05, 0.00, -5.00, 182.0, true, true, false, true, 1, true)
		else
		--
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop54), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop54), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, 0.06, 0.10, 0.0, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		ClearPedTasks(ped)
		wheel = false
		DetachEntity(prop, ped, boneIndex, 0.06, 0.10, 0.0, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		DeleteObject(prop)
	end
end)


RegisterNetEvent('phmodel:angel_wing19')
AddEventHandler('phmodel:angel_wing19', function ()
	TriggerEvent(Config['Event'][2])
	if not wheel then
		--
		wheel = true
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop55), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop55), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x2E28)
        AttachEntityToEntity(prop, ped, boneIndex, -0.00, 0.00, -0.00, 0.0, 270.00, 182.0, true, true, false, true, 1, true)
		else
		--
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop55), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop55), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, -0.59, -0.15, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		ClearPedTasks(ped)
		wheel = false
		DetachEntity(prop, ped, boneIndex, -0.59, -0.15, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		DeleteObject(prop)
	end
end)




RegisterNetEvent('phmodel:wing_gb_blue')
AddEventHandler('phmodel:wing_gb_blue', function ()
	TriggerEvent(Config['Event'][2])
	if not wheel then
		--
		wheel = true
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop56), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop56), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x2E28)
        AttachEntityToEntity(prop, ped, boneIndex, -0.40, 0.00, -0.00, 0.0, 270.00, 182.0, true, true, false, true, 1, true)
		else
		--
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop56), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop56), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, -0.59, -0.15, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		ClearPedTasks(ped)
		wheel = false
		DetachEntity(prop, ped, boneIndex, -0.59, -0.15, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		DeleteObject(prop)
	end
end)

RegisterNetEvent('phmodel:wing_gb_green')
AddEventHandler('phmodel:wing_gb_green', function ()
	TriggerEvent(Config['Event'][2])
	if not wheel then
		--
		wheel = true
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop57), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop57), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x2E28)
        AttachEntityToEntity(prop, ped, boneIndex, -0.40, 0.00, -0.00, 0.0, 270.00, 182.0, true, true, false, true, 1, true)
		else
		--
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop57), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop57), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, -0.59, -0.15, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		ClearPedTasks(ped)
		wheel = false
		DetachEntity(prop, ped, boneIndex, -0.59, -0.15, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		DeleteObject(prop)
	end
end)

RegisterNetEvent('phmodel:wing_gb_pink')
AddEventHandler('phmodel:wing_gb_pink', function ()
	TriggerEvent(Config['Event'][2])
	if not wheel then
		--
		wheel = true
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop58), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop58), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x2E28)
        AttachEntityToEntity(prop, ped, boneIndex, -0.40, 0.00, -0.00, 0.0, 270.00, 182.0, true, true, false, true, 1, true)
		else
		--
		local ped = GetPlayerPed(-1)
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop58), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local prop = CreateObject(GetHashKey(Config.prop58), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(ped, 0x322c)
		AttachEntityToEntity(prop, ped, boneIndex, -0.59, -0.15, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		ClearPedTasks(ped)
		wheel = false
		DetachEntity(prop, ped, boneIndex, -0.59, -0.15, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
		DeleteObject(prop)
	end
end)