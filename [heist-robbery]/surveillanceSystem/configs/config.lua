--[[
EVENTS YOU CAN USE FREELY:

    CLIENT EVENTS:
    "cameraSystem:client:OpenCamera", <camera id> --Open camera. Make sure you send also the camera id you want.
    "cameraSystem:client:DisableAllCameras"

    SERVER EVENTS:
    "cameraSystem:server:OpenCamera", source, <camera id> --Opens camera and checks for job also.
    "cameraSystem:server:updateState", <camera id>, <state> --Sets the current state of the camera. Online or not.
]]

Config = {}

--SERVERSIDE STUFF--
Config.CheckVersion =  true -- Enable/Disable version checker. Prints on serverside console.
--SERVERSIDE STUFF--


--SIMPLE STUFF--
Config.UseCommand = true
Config.CommandName = "cam"
Config.UsingESX = true
--SIMPLE STUFF--


--JOBS CHECKER--
Config.UsingJobs = true --Set to true if you want only JOBS to access the cameras.
Config.WhitelistedJobs = { --Place all the jobs you want to have access here.
    "police",
    "ambulance"
}
--JOBS CHECKER--


--ENHANCEMENTS--
Config.HideMinimap = true --Hides the minimap while being inside the camera. IF YOU WANT TO DISABLE HUD GO TO client_customise_me at function HideMinimap() and add your code there.
Config.RecordFootage = false --Automatically records GTA V clips while being in the camera. Saves them as regular gta clips under C:\Users\<USERNAME>\Documents\Rockstar Games\GTA V\videos\clips.
--ENHANCEMENTS--


--CAMERA SETTINGS--
Config.RotateUp = 32
Config.RotateDown = 8
Config.RotateLeft = 34
Config.RotateRight = 9
Config.Disconnect = 177
--CAMERA SETTINGS--

--Instructional Buttons--
Config.CameraUpDown = 8
Config.CameraUpDownText = "Turn Up/Down" 
Config.CameraRightLeft = 9
Config.CameraRightLeftText = "Turn Left/Right"
Config.CameraDisconnect = 194
Config.CameraEnabledDisconnectText = "Disconnect"
Config.CameraDisabledDisconnectText = "CAMERA CAN NOT TURN - Disconnect"
--Instructional Buttons--

--HACKING SETTINGS--
Config.EnableHacking = true --Enable/disable hacking
Config.HackDistance = 1.0 --Hack distance is for the 3d text. Keep it 1, it's good.
Config.HackButton = 38 --DEFAULT IS 38 (E BUTTON)
Config.AbortHackButton = 73  --DEFAULT IS 73 (X BUTTON)
Config.HackChance = 75 --How much chance to succeed hacking attempt ONLY USE FROM 0-100%.
Config.HackMessage = "[~g~E~w~] - Hack Camera"
Config.RestoreMessage = "[~g~E~w~] - Khôi phục Camera"
Config.AbortMessage = "[~g~X~w~] - Hủy"
Config.HackStage1 = "Khởi động hệ thống"
Config.HackStage2 = "Đăng nhập hệ thống"
Config.HackStage2Fail = "Máy tính bị khóa"
Config.HackStage3 = "Khởi động surveillance-system.exe"
Config.HackStage4 = "Tắt hệ thống camera"
Config.ReactivateComputerHacking = "Khởi động lại hệ thống camera"
Config.HackAborted = "Hủy hack"
Config.RestoringMessage = "Khôi phục camera"
--HACKING SETTINGS--

--SECURITY CAMERA LOCATIONS--
Config.SecurityCameras = {

    --[[CAMERA TYPES:

    1)brown --Clear to see, has a brown colour.
    2)low --Very low quality of feed.
    3)medium --Meidum quality of feed.
    4)blackandwhite --Decent quality but black and white.
    5)blurred --Looks like this is kind of blurred in the sides. I like it.
    6)offline --Offline, it is the one that has snow.

    canRotate is if the camera should be rotate-able.
    isOnline should be set to true, pretty much explains by itself.

    ---]]

    cameras = {
        [1] = {label = "Pacific Bank - CAMERA ID: #1", x = 257.45, y = 210.07, z = 109.08, r = {x = -25.0, y = 0.0, z = 28.05}, canRotate = true, isOnline = true, quality = "blurred"},
        [2] = {label = "Pacific Bank - CAMERA ID: #2", x = 232.86, y = 221.46, z = 107.83, r = {x = -25.0, y = 0.0, z = -140.91}, canRotate = true, isOnline = true, quality = "blurred"},
        [3] = {label = "Pacific Bank - CAMERA ID: #3", x = 252.27, y = 225.52, z = 103.99, r = {x = -35.0, y = 0.0, z = -74.87}, canRotate = true, isOnline = true, quality = "blurred"},
        [4] = {label = "Limited Ltd Grove St. - CAMERA ID: #1", x = -53.1433, y = -1746.714, z = 31.546, r = {x = -35.0, y = 0.0, z = -168.9182}, canRotate = true, isOnline = true, quality = "medium"},
        [5] = {label = "Rob's Liqour Prosperity St. - CAMERA ID: #1", x = -1482.9, y = -380.463, z = 42.363, r = {x = -35.0, y = 0.0, z = 79.53281}, canRotate = true, isOnline = true, quality = "low"},
        [6] = {label = "Rob's Liqour San Andreas Ave. - CAMERA ID: #1", x = -1224.874, y = -911.094, z = 14.401, r = {x = -35.0, y = 0.0, z = -6.778894}, canRotate = true, isOnline = true, quality = "low"},
        [7] = {label = "Limited Ltd Ginger St. - CAMERA ID: #1", x = -718.153, y = -909.211, z = 21.49, r = {x = -35.0, y = 0.0, z = -137.1431}, canRotate = true, isOnline = true, quality = "medium"},
        [8] = {label = "24/7 Supermarkt Innocence Blvd. - CAMERA ID: #1", x = 23.885, y = -1342.441, z = 31.672, r = {x = -35.0, y = 0.0, z = -142.9191}, canRotate = true, isOnline = true, quality = "medium"},
        [9] = {label = "Rob's Liqour El Rancho Blvd. - CAMERA ID: #1", x = 1133.024, y = -978.712, z = 48.515, r = {x = -35.0, y = 0.0, z = -137.302}, canRotate = true, isOnline = true, quality = "low"},
        [10] = {label = "Limited Ltd West Mirror Drive - CAMERA ID: #1", x = 1151.93, y = -320.389, z = 71.33, r = {x = -35.0, y = 0.0, z = -119.4468}, canRotate = true, isOnline = true, quality = "medium"},
        [11] = {label = "24/7 Supermarkt Clinton Ave - CAMERA ID: #1", x = 383.402, y = 328.915, z = 105.541, r = {x = -35.0, y = 0.0, z = 118.585}, canRotate = true, isOnline = true, quality = "blackandwhite"},
        [12] = {label = "Limited Ltd Banham Canyon Dr - CAMERA ID: #1", x = -1832.057, y = 789.389, z = 140.436, r = {x = -35.0, y = 0.0, z = -91.481}, canRotate = true, isOnline = true, quality = "medium"},
        [13] = {label = "Rob's Liqour Great Ocean Hwy - CAMERA ID: #1", x = -2966.15, y = 387.067, z = 17.393, r = {x = -35.0, y = 0.0, z = 32.92229}, canRotate = true, isOnline = true, quality = "low"},
        [14] = {label = "24/7 Supermarkt Ineseno Road - CAMERA ID: #1", x = -3046.749, y = 592.491, z = 9.808, r = {x = -35.0, y = 0.0, z = -116.673}, canRotate = true, isOnline = true, quality = "blackandwhite"},
        [15] = {label = "24/7 Supermarkt Barbareno Rd. - CAMERA ID: #1", x = -3246.489, y = 1010.408, z = 14.705, r = {x = -35.0, y = 0.0, z = -135.2151}, canRotate = true, isOnline = true, quality = "blackandwhite"},
        [16] = {label = "24/7 Supermarkt Route 68 - CAMERA ID: #1", x = 539.773, y = 2664.904, z = 44.056, r = {x = -35.0, y = 0.0, z = -42.947}, canRotate = true, isOnline = true, quality = "blackandwhite"},
        [17] = {label = "Rob's Liqour Route 68 - CAMERA ID: #1", x = 1169.855, y = 2711.493, z = 40.432, r = {x = -35.0, y = 0.0, z = 127.17}, canRotate = true, isOnline = true, quality = "low"},
        [18] = {label = "24/7 Supermarkt Senora Fwy - CAMERA ID: #1", x = 2673.579, y = 3281.265, z = 57.541, r = {x = -35.0, y = 0.0, z = -80.242}, canRotate = true, isOnline = true, quality = "blackandwhite"},
        [19] = {label = "24/7 Supermarkt Alhambra Dr. - CAMERA ID: #1", x = 1966.24, y = 3749.545, z = 34.143, r = {x = -35.0, y = 0.0, z = 163.065}, canRotate = true, isOnline = true, quality = "blackandwhite"},
        [20] = {label = "24/7 Supermarkt Senora Fwy - CAMERA ID: #2", x = 1729.522, y = 6419.87, z = 37.262, r = {x = -35.0, y = 0.0, z = -160.089}, canRotate = true, isOnline = true, quality = "blackandwhite"},
        [21] = {label = "Fleeca Bank Hawick Ave - CAMERA ID: #1", x = 309.341, y = -281.439, z = 55.88, r = {x = -35.0, y = 0.0, z = -146.1595}, canRotate = true, isOnline = true, quality = "blurred"},
        [22] = {label = "Fleeca Bank Legion Square - CAMERA ID: #1", x = 144.871, y = -1043.044, z = 31.017, r = {x = -35.0, y = 0.0, z = -143.9796}, canRotate = true, isOnline = true, quality = "blurred"},
        [23] = {label = "Fleeca Bank Hawick Ave - CAMERA ID: #2", x = -355.7643, y = -52.506, z = 50.746, r = {x = -35.0, y = 0.0, z = -143.8711}, canRotate = true, isOnline = true, quality = "blurred"},
        [24] = {label = "Fleeca Bank Del Perro Blvd - CAMERA ID: #1", x = -1214.226, y = -335.86, z = 39.515, r = {x = -35.0, y = 0.0, z = -97.862}, canRotate = true, isOnline = true, quality = "blurred"},
        [25] = {label = "Fleeca Bank Great Ocean Hwy - CAMERA ID: #1", x = -2958.885, y = 478.983, z = 17.406, r = {x = -35.0, y = 0.0, z = -34.69595}, canRotate = true, isOnline = true, quality = "blurred"},
        [26] = {label = "Paleto Bank - CAMERA ID: #1", x = -102.939, y = 6467.668, z = 33.424, r = {x = -35.0, y = 0.0, z = 24.66}, canRotate = true, isOnline = true, quality = "brown"},
        [27] = {label = "Del Vecchio Liquor Paleto Bay", x = -163.75, y = 6323.45, z = 33.424, r = {x = -35.0, y = 0.0, z = 260.00}, canRotate = true, isOnline = true, quality = "blackandwhite"},
        [28] = {label = "Don's Country Store Paleto Bay - CAMERA ID: #1", x = 166.42, y = 6634.4, z = 33.69, r = {x = -35.0, y = 0.0, z = 32.00}, canRotate = true, isOnline = true, quality = "blackandwhite"},
        [29] = {label = "Don's Country Store Paleto Bay - CAMERA ID: #2", x = 163.74, y = 6644.34, z = 33.69, r = {x = -35.0, y = 0.0, z = 168.00}, canRotate = true, isOnline = true, quality = "blackandwhite"},
        [30] = {label = "Don's Country Store Paleto Bay - CAMERA ID: #3", x = 169.54, y = 6640.89, z = 33.69, r = {x = -35.0, y = 0.0, z = 5.78}, canRotate = true, isOnline = true, quality = "blackandwhite"},
        [31] = {label = "Vangelico Jewellery - CAMERA ID: #1", x = -627.54, y = -239.74, z = 40.33, r = {x = -35.0, y = 0.0, z = 5.78}, canRotate = true, isOnline = true, quality = "brown"},
        [32] = {label = "Vangelico Jewellery - CAMERA ID: #2", x = -627.51, y = -229.51, z = 40.24, r = {x = -35.0, y = 0.0, z = -95.78}, canRotate = true, isOnline = true, quality = "brown"},
        [33] = {label = "Vangelico Jewellery - CAMERA ID: #3", x = -620.3, y = -224.31, z = 40.23, r = {x = -35.0, y = 0.0, z = 165.78}, canRotate = true, isOnline = true, quality = "brown"},
        [34] = {label = "Vangelico Jewellery - CAMERA ID: #4", x = -622.57, y = -236.3, z = 40.31, r = {x = -35.0, y = 0.0, z = 5.78}, canRotate = true, isOnline = true, quality = "brown"},
    },
}
--SECURITY CAMERA LOCATIONS--


--SECURITY CAMERA HACK LOCATIONS--
Config.HackLocations = {
        --[[
            IF YOU WANT TO ADD MULTIPLE CAMERAS FOR ONE PLACE THEN at cameras = add a string value. Then simply add the string at Config.MultipleCameraHackingLocations below + the cameras you want to control from 
            that one location.

            3 MINIGAMES:
            computer - Computer hacking. Does not have any dependencies.
            mhacking - MHacking with a cellphone. Needs mhacking resource. You may download it free here: https://github.com/GHMatti/FiveM-Scripts
            thermite: Thermite is a script made by me. You do need to purchase it from tebex. If you do have another resource for thermite then feel free to write the code at client_customise_me.lua.

        --]]

        [1] = {label = "Pacific Bank", cameras = "pacific", location = {x = 258.33, y = 274.91, z=105.63}, type = "fallout"},
        [4] = {label = "Limited Ltd Grove St.", cameras = 4, location = {x = -44.52, y = -1749.18, z=29.42, h = 50.0}, type = "fallout"},
        [5] = {label = "Rob's Liqour Prosperity St.", cameras = 5, location = {x = -1488.2, y = -376.86, z = 40.18,h = 99.62}, type = "fallout"},
        [6] = {label = "Rob's Liqour San Andreas Ave.", cameras = 6, location = {x = -1220.489, y = -906.57, z = 12.43,h = 345.46}, type = "fallout"},
        [7] = {label = "Limited Ltd Ginger St.", cameras = 7, location = {x = -710.25, y = -905.43, z = 19.22, h = 83.32 }, type = "fallout"},
        [8] = {label = "24/7 Supermarkt Innocence Blvd.",cameras = 8, location = {x = 29.45, y = -1338.86, z = 29.53, h = 350.26 }, type = "fallout"},
        [9] = {label = "Rob's Liqour El Rancho Blvd.", cameras = 9, location = {x = 1135.00, y = -984.52, z = 46.57, h = 227.24}, type = "fallout"},
        [10] = {label = "Limited Ltd West Mirror Drive", cameras = 10, location = {x = 1159.37, y = -315.27, z = 69.21, h= 94.39}, type = "fallout"},
        [11] = {label = "24/7 Supermarkt Clinton Ave", cameras = 11, location = {x = 379.40, y = 333.32, z = 103.57, h= 338.78 }, type = "fallout"},
        [12] = {label = "Limited Ltd Banham Canyon Dr", cameras = 12, location = {x = -1828.54, y = 797.75, z = 138.18, h= 136.75}, type = "fallout"},
        [13] = {label = "Rob's Liqour Great Ocean Hwy",cameras = 13, location = {x = -2966.86, y = 393.04, z = 15.04, h= 211.42}, type = "fallout"},
        [14] = {label = "24/7 Supermarkt Ineseno Road.",cameras = 14, location = {x = -3048.25, y = 586.68, z = 7.91, h= 115.63}, type = "fallout"},
        [15] = {label = "24/7 Supermarkt Barbareno Rd.",cameras = 15, location = {x = -3250.35, y = 1005.55, z = 12.83, h= 84.38}, type = "fallout"},
        [16] = {label = "24/7 Supermarkt Route 68", cameras = 16, location = {x = 545.23, y = 2662.48, z = 42.16, h= 182.69}, type = "fallout"},
        [17] = {label = "Rob's Liqour Route 68", cameras = 17, location = {x = 1163.72, y = 2710.34, z = 38.16, h = 167.30}, type = "fallout"},
        [18] = {label = "24/7 Supermarkt Senora Fwy", cameras = 18, location = {x = 2673.20, y = 3287.87, z = 55.24, h = 65.42}, type = "fallout"},
        [22] = {label = "Fleeca Bank Legion Square", cameras = 22, location={x = 135.60, y = -1046.48, z = 29.65, h=160.00}, type = "mhacking"},
}


Config.MultipleCameraHackingLocations = {
    --You may add whatever the fuck you want here. Really. This resource was made with a million loops. So feel free to make up your own Camera locations above and embed them here.   
    ["pacific"] = {1,2,3},
    ["paleto"] = {26},
    ["vangelico"] = {31,32,33,34},    
}
