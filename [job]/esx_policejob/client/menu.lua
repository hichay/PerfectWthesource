

RegisterNetEvent('esx_policejob:MainCameraMenu', function()
    TriggerEvent('pw-context:sendMenu', {
        {
			id = 1,
			header = ">> Trang tiếp" ,
			txt = "",
			params = {
				event = "esx_policejob:SecondCamerasMenu",
			}
		},
		
		{
			id = 2,
			header = "CCTV 1" ,
			txt = "Pacific Bank - CAMERA ID: #1",
			params = {
				event = "cameraSystem:client:OpenCamera",
				 args = {
					id = 1
				}
			}
		},
		
		{
			id = 3,
			header = "CCTV 2" ,
			txt = "Pacific Bank - CAMERA ID: #2",
			params = {
				event = "cameraSystem:client:OpenCamera",
				 args = {
					id = 2
				}
			}
		},
		
		{
			id = 4,
			header = "CCTV 3" ,
			txt = "Pacific Bank - CAMERA ID: #3",
			params = {
				event = "cameraSystem:client:OpenCamera",
				 args = {
					id = 3
				}
			}
		},
		
		{
			id = 5,
			header = "CCTV 4" ,
			txt = "Limited Ltd Grove St. - CAMERA ID: #1",
			params = {
				event = "cameraSystem:client:OpenCamera",
				 args = {
					id = 4
				}
			}
		},
		
		{
			id = 6,
			header = "CCTV 5" ,
			txt = "Rob's Liqour Prosperity St. - CAMERA ID: #1",
			params = {
				event = "cameraSystem:client:OpenCamera",
				 args = {
					id = 5
				}
			}
		},
		
		{
			id = 7,
			header = "CCTV 6" ,
			txt = "Rob's Liqour San Andreas Ave. - CAMERA ID: #1",
			params = {
				event = "cameraSystem:client:OpenCamera",
				 args = {
					id = 6
				}
			}
		},
		
		{
			id = 8,
			header = "CCTV 7" ,
			txt = "Limited Ltd Ginger St. - CAMERA ID: #1",
			params = {
				event = "cameraSystem:client:OpenCamera",
				 args = {
					id = 7
				}
			}
		},
		
		{
			id = 9,
			header = "CCTV 8" ,
			txt = "24/7 Supermarkt Innocence Blvd. - CAMERA ID: #1",
			params = {
				event = "cameraSystem:client:OpenCamera",
				 args = {
					id = 8
				}
			}
		},
		
		{
			id = 10,
			header = "CCTV 9" ,
			txt = "Rob's Liqour El Rancho Blvd. - CAMERA ID: #1",
			params = {
				event = "cameraSystem:client:OpenCamera",
				 args = {
					id = 9
				}
			}
		},
		
		{
			id = 11,
			header = "CCTV 10" ,
			txt = "Limited Ltd West Mirror Drive - CAMERA ID: #1",
			params = {
				event = "cameraSystem:client:OpenCamera",
				 args = {
					id = 10
				}
			}
		},
			
		

    })
end)


RegisterNetEvent('esx_policejob:SecondCamerasMenu', function()
   TriggerEvent('pw-context:sendMenu', {
        {
			id = 1,
			header = ">> Trang tiếp" ,
			txt = "",
			params = {
				event = "esx_policejob:ThirdCameraMenu",
				 args = {
					1
				}
			}
		},
		
		{
			id = 2,
			header = "<< Trang trước" ,
			txt = "",
			params = {
				event = "esx_policejob:MainCameraMenu",
				 args = {
				}
			}
		},
		
		{
			id = 3,
			header = "CCTV 11" ,
			txt = "24/7 Supermarkt Clinton Ave - CAMERA ID: #1",
			params = {
				event = "cameraSystem:client:OpenCamera",
				 args = {
					id = 11
				}
			}
		},
		
		{
			id = 4,
			header = "CCTV 12" ,
			txt = "Limited Ltd Banham Canyon Dr - CAMERA ID: #1",
			params = {
				event = "cameraSystem:client:OpenCamera",
				 args = {
					id = 12
				}
			}
		},
		
		
		{
			id = 5,
			header = "CCTV 13" ,
			txt = "Rob's Liqour Great Ocean Hwy - CAMERA ID: #1",
			params = {
				event = "cameraSystem:client:OpenCamera",
				 args = {
					id = 13
				}
			}
		},
		
		{
			id = 6,
			header = "CCTV 14" ,
			txt = "24/7 Supermarkt Ineseno Road - CAMERA ID: #1",
			params = {
				event = "cameraSystem:client:OpenCamera",
				 args = {
					id = 14
				}
			}
		},
		
		{
			id = 7,
			header = "CCTV 15" ,
			txt = "24/7 Supermarkt Barbareno Rd. - CAMERA ID: #1",
			params = {
				event = "cameraSystem:client:OpenCamera",
				 args = {
					id = 15
				}
			}
		},
		
		{
			id = 8,
			header = "CCTV 16" ,
			txt = "24/7 Supermarkt Route 68 - CAMERA ID: #1",
			params = {
				event = "cameraSystem:client:OpenCamera",
				 args = {
					id = 16
				}
			}
		},
		
		{
			id = 9,
			header = "CCTV 17" ,
			txt = "Rob's Liqour Route 68 - CAMERA ID: #1",
			params = {
				event = "cameraSystem:client:OpenCamera",
				 args = {
					id = 17
				}
			}
		},
		
		{
			id = 10,
			header = "CCTV 18" ,
			txt = "24/7 Supermarkt Senora Fwy - CAMERA ID: #1",
			params = {
				event = "cameraSystem:client:OpenCamera",
				 args = {
					id = 18
				}
			}
		},
		
		
		{
			id = 11,
			header = "CCTV 19" ,
			txt = "24/7 Supermarkt Alhambra Dr. - CAMERA ID: #1",
			params = {
				event = "cameraSystem:client:OpenCamera",
				 args = {
					id = 19
				}
			}
		},

    })
	
end)


RegisterNetEvent('esx_policejob:ThirdCameraMenu', function()
   TriggerEvent('pw-context:sendMenu', {
        {
			id = 1,
			header = ">> Trang tiếp" ,
			txt = "",
			params = {
				event = "esx_policejob:FourthCameraMenu",
				 args = {
					1
				}
			}
		},
		
		{
			id = 2,
			header = "<< Trang trước" ,
			txt = "",
			params = {
				event = "esx_policejob:SecondCamerasMenu",
				 args = {
				}
			}
		},
		
		{
			id = 3,
			header = "CCTV 20" ,
			txt = "24/7 Supermarkt Senora Fwy - CAMERA ID: #2",
			params = {
				event = "cameraSystem:client:OpenCamera",
				 args = {
					id = 20
				}
			}
		},
		
		{
			id = 4,
			header = "CCTV 21" ,
			txt = "Fleeca Bank Hawick Ave - CAMERA ID: #1",
			params = {
				event = "cameraSystem:client:OpenCamera",
				 args = {
					id = 21
				}
			}
		},
		
		{
			id = 5,
			header = "CCTV 22" ,
			txt = "Fleeca Bank Legion Square - CAMERA ID: #1",
			params = {
				event = "cameraSystem:client:OpenCamera",
				 args = {
					id = 22
				}
			}
		},
		
		{
			id = 6,
			header = "CCTV 23" ,
			txt = "Fleeca Bank Hawick Ave - CAMERA ID: #2",
			params = {
				event = "cameraSystem:client:OpenCamera",
				 args = {
					id = 23
				}
			}
		},
		
		{
			id = 7,
			header = "CCTV 24" ,
			txt = "Fleeca Bank Del Perro Blvd - CAMERA ID: #1",
			params = {
				event = "cameraSystem:client:OpenCamera",
				 args = {
					id = 24
				}
			}
		},
		
		{
			id = 8,
			header = "CCTV 25" ,
			txt = "Fleeca Bank Great Ocean Hwy - CAMERA ID: #1",
			params = {
				event = "cameraSystem:client:OpenCamera",
				 args = {
					id = 25
				}
			}
		},
		
		{
			id = 9,
			header = "CCTV 26" ,
			txt = "Paleto Bank - CAMERA ID: #1",
			params = {
				event = "cameraSystem:client:OpenCamera",
				 args = {
					id = 26
				}
			}
		},
		
		{
			id = 10,
			header = "CCTV 27" ,
			txt = "Del Vecchio Liquor Paleto Bay",
			params = {
				event = "cameraSystem:client:OpenCamera",
				 args = {
					id = 27
				}
			}
		},
		
		{
			id = 11,
			header = "CCTV 28" ,
			txt = "Don's Country Store Paleto Bay - CAMERA ID: #1",
			params = {
				event = "cameraSystem:client:OpenCamera",
				 args = {
					id = 28
				}
			}
		},
		
		{
			id = 12,
			header = "CCTV 29" ,
			txt = "Don's Country Store Paleto Bay - CAMERA ID: #2",
			params = {
				event = "cameraSystem:client:OpenCamera",
				 args = {
					id = 29
				}
			}
		},
		
		{
			id = 31,
			header = "CCTV 30" ,
			txt = "Don's Country Store Paleto Bay - CAMERA ID: #3",
			params = {
				event = "cameraSystem:client:OpenCamera",
				 args = {
					id = 30
				}
			}
		},

    })
	
end)


RegisterNetEvent('esx_policejob:FourthCameraMenu', function()
   TriggerEvent('pw-context:sendMenu', {
        	
		{
			id = 1,
			header = "<< Trang trước" ,
			txt = "",
			params = {
				event = "esx_policejob:ThirdCameraMenu",
				 args = {
				}
			}
		},
		
		{
			id = 2,
			header = "CCTV 31" ,
			txt = "Vangelico Jewellery - CAMERA ID: #1",
			params = {
				event = "cameraSystem:client:OpenCamera",
				 args = {
					id = 31
				}
			}
		},
		
		{
			id = 3,
			header = "CCTV 32" ,
			txt = "Vangelico Jewellery - CAMERA ID: #2",
			params = {
				event = "cameraSystem:client:OpenCamera",
				 args = {
					id = 32
				}
			}
		},
		
		{
			id = 4,
			header = "CCTV 33" ,
			txt = "Vangelico Jewellery - CAMERA ID: #3",
			params = {
				event = "cameraSystem:client:OpenCamera",
				 args = {
					id = 33
				}
			}
		},
		
		{
			id = 5,
			header = "CCTV 34" ,
			txt = "Vangelico Jewellery - CAMERA ID: #4",
			params = {
				event = "cameraSystem:client:OpenCamera",
				 args = {
					id = 34
				}
			}
		},
		
    })
	
end)

