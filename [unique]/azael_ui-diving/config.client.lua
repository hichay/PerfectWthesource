

Config = {}

Config['esx_routers'] = {								   
	['client_shared_obj'] = 'esx:getSharedObject',          
	['client_re_loadout'] = 'esx:restoreLoadout',           
	['client_player_load'] = 'esx:playerLoaded',            
	['client_player_skin'] = 'esx_skin:getPlayerSkin',
	['client_status_loaded'] = 'esx_status:loaded',
	['client_status_register'] = 'esx_status:registerStatus',
	['client_status_get'] = 'esx_status:getStatus',
	['client_status_remove'] = 'esx_status:remove',
	['client_status_set'] = 'esx_status:set'
}

Config['esx_status_max'] = 1000000						    -- Giá trị được xác định trong tài nguyên esx_status (giá trị tối đa là 1.000.000 theo định nghĩa của esx_status)
Config['scuba_oxygen_remove'] = 1000					    -- Giảm lượng oxy trên 1 giây khi sử dụng bộ đồ lặn.
Config['snorkelling_depth'] = 25						    -- Thiết bị lặn với ống thở có thể bị mờ đến mức giới hạn (Đã kiểm tra tại Coords Z)
Config['snorkelling_timer'] = 30						   -- Một bộ đồ lặn có thể lặn trong bao nhiêu giây? (Tính bằng giây)
Config['snorkelling_timer_recovery'] = 1				    -- Đặt ống thở nếu lên trên mặt nước Sẽ khôi phục thời gian lặn về giá trị được chỉ định (trên 1 giây).

Config['object'] = {
	['scuba'] = {										    -- Prop ชุดดำน้ำลึก
		['enable'] = true,								    -- เปิดใช้งาน Prop ชุดดำน้ำลึก หรือไม่? (true เท่ากับ ใช้งาน | false เท่ากับ ไม่ใช้งาน)
		['mask'] = 'p_michael_scuba_mask_s',			    -- ชื่อ หน้ากาก (Object Name)
		['tank'] = 'p_michael_scuba_tank_s'				    -- ชื่อ ถังออกซิเจน (Object Name)
	},
	['snorkelling'] = {									    -- Prop ชุดดำน้ำตื้น
		['enable'] = true,								    -- เปิดใช้งาน Prop ชุดดำน้ำตื้น หรือไม่? (true เท่ากับ ใช้งาน | false เท่ากับ ไม่ใช้งาน)
		['mask'] = 'p_d_scuba_mask_s'					    -- ชื่อ หน้ากาก (Object Name)
	}
}

Config['animation'] = {									    -- Ped Animation
	['dict_clothing'] = 'clothingtie',
	['anim_clothing'] = 'try_tie_negative_a',
	['delay_clothing'] = 1200
}

Config['skin_color_random'] = {
	['scuba_enable'] = true,							    -- เปิดใช้งาน สุ่มสี ชุดดำน้ำลึก (true เท่ากับ ใช้งาน | false เท่ากับ ไม่ใช้งาน)
	['scuba_male'] = {									    -- รหัสสี ชุดดำน้ำลึก แบบสุ่ม (ชาย)
		['color_min'] = 0,								    -- รหัสสี น้อย ที่สุด
		['color_max'] = 25,								    -- รหัสสี มาก ที่สุด
		['color_position'] = {							    -- ตำแหน่ง สุ่มสี ชุดดำน้ำลึก (ชาย)
			'tshirt_2', 'torso_2', 'pants_2', 'shoes_2'
		}
	},
	['scuba_female'] = {								    -- รหัสสี ชุดดำน้ำลึก แบบสุ่ม (หญิง)
		['color_min'] = 0,								    -- รหัสสี น้อย ที่สุด
		['color_max'] = 25,								    -- รหัสสี มาก ที่สุด
		['color_position'] = {							    -- ตำแหน่ง สุ่มสี ชุดดำน้ำลึก (หญิง)
			'tshirt_2', 'torso_2', 'pants_2', 'shoes_2'
		}
	},
	['snorkelling_enable'] = true,						    -- เปิดใช้งาน สุ่มสี ชุดดำน้ำตื้น (true เท่ากับ ใช้งาน | false เท่ากับ ไม่ใช้งาน)
	['snorkelling_male'] = {							    -- รหัสสี ชุดดำน้ำตื้น แบบสุ่ม (ชาย)
		['color_min'] = 0,								    -- รหัสสี น้อย ที่สุด
		['color_max'] = 6,								    -- รหัสสี มาก ที่สุด
		['color_position'] = {							    -- ตำแหน่ง สุ่มสี ชุดดำน้ำตื้น (ชาย)
			'pants_2'
		}
	},
	['snorkelling_female'] = {							    -- รหัสสี ชุดดำน้ำตื้น แบบสุ่ม (หญิง)
		['color_min'] = 0,								    -- รหัสสี น้อย ที่สุด
		['color_max'] = 11,								    -- รหัสสี มาก ที่สุด
		['color_position'] = {							    -- ตำแหน่ง สุ่มสี ชุดดำน้ำตื้น (หญิง)
			'tshirt_2', 'torso_2', 'decals_2', 'pants_2'
		}
	}
}

Config['skin_color_scuba_agencies'] = {
	['enable'] = true,									  -- Kích hoạt Set Color Scuba Series (true = hoạt động | false = không hoạt động)
	['ambulance'] = {
		['name'] = 'ambulance',							    -- ชื่อ หน่วยงาน Ambulance
		['color'] = 0,									    -- รหัสสี ชุดดำน้ำลึก หน่วยงาน Ambulance
		['color_position'] = {							    -- ตำแหน่ง สี ชุดดำน้ำลึก หน่วยงาน Ambulance
			'tshirt_2', 'torso_2', 'pants_2', 'shoes_2'	    -- ตำแหน่ง สี ชุดดำน้ำลึก หน่วยงาน Ambulance
		}
	},
	['police'] = {
		['name'] = 'police',							    -- ชื่อ หน่วยงาน Police
		['color'] = 0,									    -- รหัสสี ชุดดำน้ำลึก หน่วยงาน Police
		['color_position'] = {							    -- ตำแหน่ง สี ชุดดำน้ำลึก หน่วยงาน Police
			'tshirt_2', 'torso_2', 'pants_2', 'shoes_2'	    -- ตำแหน่ง สี ชุดดำน้ำลึก หน่วยงาน Police
		}
	}
}

Config['skin']= {
	['scuba'] = {										    -- Skin ชุดดำน้ำลึก (Scuba)
		['male'] = {									    -- Skin ผู้ชาย
			['hair_1'] = 0,			['hair_2'] = 0,
			['hair_color_1'] = 0,	['hair_color_2'] = 0,
			['tshirt_1'] = 15,		['tshirt_2'] = 0,
			['ears_1'] = -1,		['ears_2'] = 0,
			['torso_1'] = 243,		['torso_2'] = 0,
			['decals_1'] = 0,		['decals_2']= 0,
			['mask_1'] = 0, 		['mask_2'] = 0,
			['arms'] = 31,			['arms_2'] = 0,
			['pants_1'] = 94,		['pants_2'] = 0,
			['shoes_1'] = 67,		['shoes_2'] = 0,
			['helmet_1'] = -1,		['helmet_2'] = 0,
			['bags_1'] = -1,		['bags_2'] = 0,
			['glasses_1'] = -1,		['glasses_2'] = 0,
			['chain_1'] = 0,		['chain_2'] = 0,
			['bproof_1'] = 0, 		['bproof_2'] = 0
		},

		['female'] = {									    -- Skin ผู้หญิง
			['hair_1'] = 0,			['hair_2'] = 0,
			['hair_color_1'] = 0,	['hair_color_2'] = 0,
			['tshirt_1'] = 15,		['tshirt_2'] = 0,
			['ears_1'] = -1,		['ears_2'] = 0,
			['torso_1'] = 251,		['torso_2'] = 0,
			['decals_1'] = 0,		['decals_2'] = 0,
			['mask_1'] = 0, 		['mask_2'] = 0,
			['arms'] = 36,			['arms_2'] = 0,
			['pants_1'] = 97,		['pants_2'] = 0,
			['shoes_1'] = 70,		['shoes_2'] = 0,
			['helmet_1']= -1,		['helmet_2'] = 0,
			['bags_1'] = -1,		['bags_2']	= 0,
			['glasses_1'] = -1,		['glasses_2'] = 0,
			['chain_1'] = 0,		['chain_2'] = 0,
			['bproof_1'] = 0,		['bproof_2'] = 0
		}
	},

	['snorkelling'] = {									    -- Skin ชุดดำน้ำตื้น (Snorkelling)
		['male'] = {									    -- Skin ผู้ชาย
			['hair_1'] = 0,			['hair_2'] = 0,
			['hair_color_1'] = 0,	['hair_color_2'] = 0,
			['tshirt_1'] = 15, 		['tshirt_2'] = 0,
			['ears_1'] = -1, 		['ears_2'] = 0,
            ['torso_1'] = 15, 		['torso_2'] = 0,
            ['decals_1'] = 0,  		['decals_2'] = 0,
            ['mask_1'] = 0, 		['mask_2'] = 0,
            ['arms'] = 15,			['arms_2'] = 0,
            ['pants_1'] = 54, 		['pants_2'] = 0,
            ['shoes_1'] = 67,		['shoes_2'] = 0,
            ['helmet_1'] = 8, 		['helmet_2'] = 0,
            ['bags_1'] = 43, 		['bags_2'] = 0,
			['glasses_1'] = -1, 	['glasses_2'] = 0,
			['chain_1'] = 0, 		['chain_2'] = 0,
            ['bproof_1'] = 0,  		['bproof_2'] = 0
		},

		['female'] = {									    -- Skin ผู้หญิง
			['hair_1'] = 0,			['hair_2'] = 0,
			['hair_color_1'] = 0,	['hair_color_2'] = 0,
			['tshirt_1'] = 15, 		['tshirt_2'] = 0,
			['ears_1'] = -1, 		['ears_2'] = 0,
            ['torso_1'] = 15, 		['torso_2'] = 0,
            ['decals_1'] = 0,  		['decals_2'] = 0,
            ['mask_1'] = 0, 		['mask_2'] = 0,
            ['arms'] = 15,			['arms_2'] = 0,
            ['pants_1'] = 15, 		['pants_2'] = 0,
            ['shoes_1'] = 70,		['shoes_2'] = 0,
            ['helmet_1'] = -1, 		['helmet_2']	= 0,
            ['bags_1'] = 43, 		['bags_2'] = 0,
			['glasses_1'] = -1, 	['glasses_2'] = 0,
			['chain_1'] = 0, 		['chain_2'] = 0,
            ['bproof_1'] = 0,  		['bproof_2'] = 0
		}
	}
}

Config['pNotify'] = {									    
	['enable'] = false,									   
	['type'] = 'error',									   
	['timeout'] = 3000,									    
	['layout'] = 'bottomCenter',						    
	['queue'] = 'global'								    
}
