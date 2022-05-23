
toolshop = {
	{46.080375, -1749.123, 28.633472, 45.888553},
	{2748.6979, 3472.0498, 54.677799, 245.58422}

}

Citizen.CreateThread(function()
	for k,v in pairs(toolshop) do 
		local data = {
			id = "toolshop_npc_"..k,
			position = {coords = vector3(v[1], v[2], v[3]), heading = v[4]},
			pedType = 4,
			model = "s_m_m_ccrew_01",
			networked = false,
			distance =	50.0,
			settings = {{ mode = 'invincible', active = true }, { mode = 'ignore', active = true }, { mode = 'freeze', active = true }},
			flags = {["isNPC"] = true, ["isToolShopKeeper"] = true,},
			scenario = "WORLD_HUMAN_CLIPBOARD_FACILITY",
		}

		local npc = exports["pw-npcs"]:RegisterNPC(data, "toolshopname_npc_"..k)
		
	end
	local Interact = {
		data = {
		  {
			id = 'npc_toolshop_interact',
			label = 'Mở cửa hàng',
			icon = 'hand-holding',
			event = 'pw-shops:openToolshop',
			parameters = {},
		  },
		},
		options = {
		  distance = { radius = 2.5 },
		},
	  }
	  
	  exports["pw-interact"]:AddPeekEntryByFlag({"isToolShopKeeper"}, Interact.data, Interact.options)
end)

RegisterNetEvent('pw-shops:openToolshop')
AddEventHandler('pw-shops:openToolshop', function()
	TriggerEvent("server-inventory-open", "4", "Shop")
end)

--[[ Citizen.CreateThread(function()
	exports["pw-polyzone"]:AddBoxZone("tool_shop", vector3(44.83, -1748.53, 29.54), 1.8, 2.4, {
		  heading=315,
		  minZ=28.40,
		  maxZ=30.50,
	})
  
	exports["pw-polyzone"]:AddBoxZone("tool_shop", vector3(2749.23, 3472.33, 55.67), 5.2, 4.4, {
		heading=8,
		minZ=55.20,
		maxZ=56.0
	})
	  
	  
end) ]]
  