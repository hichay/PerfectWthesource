
Config = {}



Config['esx_routers'] = {									
	['server_shared_obj'] = 'esx:getSharedObject',			
	['server_status_add'] = 'esx_status:add'				
}															

Config['item'] = {
	['scuba_gear'] = 'scuba_gear',							
	['scuba_oxygen_tank'] = 'scuba_oxygen_tank',			
	['snorkelling_gear'] = 'snorkelling_gear'				
}

Config['use_scuba_gear_in_water'] = false					-- Tôi có thể sử dụng bộ đồ lặn dưới nước không? (true = có thể sử dụng được | false = không khả dụng)
Config['use_scuba_oxygen_tank_in_water'] = false			-- Có thể dùng bình oxi để thêm khí oxi vào nước được không? (true = có thể sử dụng được | false = không khả dụng)
Config['use_snorkelling_gear_in_water'] = true				-- Tôi có thể sử dụng ống thở trong nước không? (true = có thể sử dụng được | false = không khả dụng)

Config['scuba_oxygen_add'] = 500000							--Lượng oxy nhận được nếu sử dụng 1 vật dụng bình oxy.
