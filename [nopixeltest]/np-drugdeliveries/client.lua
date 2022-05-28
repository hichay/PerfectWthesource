local tasking = false
local mygang = "local"
local watching = "local"
local watchinglist = {}
local drugStorePed = 0
local cashPayment = 300
local vehspawn = false
local myGangReputation = {
    ["mexican"] = 200,
    ["salva"] = 200,
    ["weicheng"] = 200,   
    ["family"] = 200,
    ["ballas"] = 200,
    ["robbery"] = 200,           
}
local oxyVehicle = 0

local lunchtime = false


ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	PlayerLoaded = true
	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('lunchtime')
AddEventHandler('lunchtime', function(pass)
	lunchtime = pass
end)



local dropoffpoints = {
	[1] =  { ['x'] = 483.17,['y'] = -1827.35,['z'] = 27.86,['h'] = 135.87, ['info'] = ' East Side 1' },
	[2] =  { ['x'] = 475.87,['y'] = -1798.45,['z'] = 28.49,['h'] = 229.85, ['info'] = ' East Side 2' },
	[3] =  { ['x'] = 503.54,['y'] = -1765.06,['z'] = 28.51,['h'] = 67.61, ['info'] = ' East Side 3' },
	[4] =  { ['x'] = 512.0,['y'] = -1842.13,['z'] = 27.9,['h'] = 138.1, ['info'] = ' East Side 4' },
	[5] =  { ['x'] = 466.89,['y'] = -1852.81,['z'] = 27.72,['h'] = 310.97, ['info'] = ' East Side 5' },
	[6] =  { ['x'] = 431.33,['y'] = -1882.85,['z'] = 26.85,['h'] = 39.7, ['info'] = ' East Side 6' },
	[7] =  { ['x'] = 410.64,['y'] = -1908.57,['z'] = 25.46,['h'] = 80.03, ['info'] = ' East Side 7' },
	[8] =  { ['x'] = 192.93,['y'] = -2027.95,['z'] = 18.29,['h'] = 251.25, ['info'] = ' East Side 8' },
	[9] =  { ['x'] = 184.05,['y'] = -2004.77,['z'] = 18.31,['h'] = 49.81, ['info'] = ' East Side 9' },
	[10] =  { ['x'] = 212.4,['y'] = -1971.66,['z'] = 20.31,['h'] = 63.83, ['info'] = ' East Side 10' },
	[11] =  { ['x'] = 266.85,['y'] = -1964.41,['z'] = 23.0,['h'] = 49.59, ['info'] = ' East Side 11' },
	[12] =  { ['x'] = 313.05,['y'] = -1918.57,['z'] = 25.65,['h'] = 315.88, ['info'] = ' East Side 12' },
	[13] =  { ['x'] = 282.63,['y'] = -1948.96,['z'] = 24.39,['h'] = 40.21, ['info'] = ' East Side 13' },
	[14] =  { ['x'] = 250.44,['y'] = -1995.9,['z'] = 20.32,['h'] = 324.5, ['info'] = ' East Side 14' },
	[15] =  { ['x'] = 270.54,['y'] = -1706.13,['z'] = 29.31,['h'] = 46.82, ['info'] = ' Central 1' },
	[16] =  { ['x'] = 167.78,['y'] = -1635.0,['z'] = 29.3,['h'] = 22.04, ['info'] = ' Central 2' },

	[17] =  { ['x'] = 175.98,['y'] = -1542.48,['z'] = 29.27,['h'] = 316.21, ['info'] = ' Central 3' },

	[18] =  { ['x'] = -99.69,['y'] = -1577.74,['z'] = 31.73,['h'] = 231.66, ['info'] = ' Central 4' },
	[19] =  { ['x'] = -171.68,['y'] = -1659.11,['z'] = 33.47,['h'] = 85.41, ['info'] = ' Central 5' },
	[20] =  { ['x'] = -209.75,['y'] = -1632.29,['z'] = 33.9,['h'] = 177.99, ['info'] = ' Central 6' },
	[21] =  { ['x'] = -262.65,['y'] = -1580.04,['z'] = 31.86,['h'] = 251.02, ['info'] = ' Central 7' },
	[22] =  { ['x'] = -182.0,['y'] = -1433.79,['z'] = 31.31,['h'] = 210.92, ['info'] = ' Central 8' },
	[23] =  { ['x'] = -83.37,['y'] = -1415.39,['z'] = 29.33,['h'] = 180.98, ['info'] = ' Central 9' },
	[24] =  { ['x'] = -39.13,['y'] = -1473.67,['z'] = 31.65,['h'] = 5.17, ['info'] = ' Central 10' },
	[25] =  { ['x'] = 45.16,['y'] = -1475.65,['z'] = 29.36,['h'] = 136.92, ['info'] = ' Central 11' },
	[26] =  { ['x'] = 158.52,['y'] = -1496.02,['z'] = 29.27,['h'] = 133.49, ['info'] = ' Central 12' },
	[27] =  { ['x'] = 43.58,['y'] = -1599.87,['z'] = 29.61,['h'] = 50.3, ['info'] = ' Central 13' },
	[28] =  { ['x'] = 7.97,['y'] = -1662.14,['z'] = 29.33,['h'] = 318.63, ['info'] = ' Central 14' },
	[29] =  { ['x'] = -726.92,['y'] = -854.64,['z'] = 22.8,['h'] = 2.0, ['info'] = ' West 1' },
	[30] =  { ['x'] = -713.09,['y'] = -886.66,['z'] = 23.81,['h'] = 357.65, ['info'] = ' West 2' },
	[31] =  { ['x'] = -591.45,['y'] = -891.2,['z'] = 25.95,['h'] = 91.53, ['info'] = ' West 3' },
	[32] =  { ['x'] = -683.59,['y'] = -945.62,['z'] = 20.85,['h'] = 180.74, ['info'] = ' West 4' },
	[33] =  { ['x'] = -765.92,['y'] = -920.94,['z'] = 18.94,['h'] = 180.44, ['info'] = ' West 5' },
	[34] =  { ['x'] = -807.45,['y'] = -957.09,['z'] = 15.29,['h'] = 340.4, ['info'] = ' West 6' },
	[35] =  { ['x'] = -822.88,['y'] = -973.96,['z'] = 14.72,['h'] = 126.28, ['info'] = ' West 7' },
	[36] =  { ['x'] = -657.53,['y'] = -729.91,['z'] = 27.84,['h'] = 309.58, ['info'] = ' West 8' },
	[37] =  { ['x'] = -618.39,['y'] = -750.71,['z'] = 26.66,['h'] = 85.6, ['info'] = ' West 9' },
	[38] =  { ['x'] = -548.36,['y'] = -854.53,['z'] = 28.82,['h'] = 352.84, ['info'] = ' West 10' },
	[39] =  { ['x'] = -518.18,['y'] = -804.65,['z'] = 30.8,['h'] = 267.32, ['info'] = ' West 11' },
	[40] =  { ['x'] = -509.05,['y'] = -737.77,['z'] = 32.6,['h'] = 174.97, ['info'] = ' West 12' },
	[41] =  { ['x'] = -567.5,['y'] = -717.77,['z'] = 33.43,['h'] = 268.02, ['info'] = ' West 13' },
	[42] =  { ['x'] = -654.89,['y'] = -732.13,['z'] = 27.56,['h'] = 309.15, ['info'] = ' West 14' },
	-- [43] =  { ['x'] = -654.89,['y'] = -732.13,['z'] = 27.56,['h'] = 309.15, ['info'] = ' new' },
	-- [44] =  { ['x'] = -654.89,['y'] = -732.13,['z'] = 27.56,['h'] = 309.15, ['info'] = ' West 14' },
	-- [45] =  { ['x'] = -654.89,['y'] = -732.13,['z'] = 27.56,['h'] = 309.15, ['info'] = ' West 14' },
}

local OxyDropOffs = {
	[1] =  { ['x'] = 74.5,['y'] = -762.17,['z'] = 31.68,['h'] = 160.98, ['info'] = ' 1' },
	[2] =  { ['x'] = 100.58,['y'] = -644.11,['z'] = 44.23,['h'] = 69.11, ['info'] = ' 2' },
	[3] =  { ['x'] = 175.45,['y'] = -445.95,['z'] = 41.1,['h'] = 92.72, ['info'] = ' 3' },
	[4] =  { ['x'] = 130.3,['y'] = -246.26,['z'] = 51.45,['h'] = 219.63, ['info'] = ' 4' },
	[5] =  { ['x'] = 198.1,['y'] = -162.11,['z'] = 56.35,['h'] = 340.09, ['info'] = ' 5' },
	[6] =  { ['x'] = 341.0,['y'] = -184.71,['z'] = 58.07,['h'] = 159.33, ['info'] = ' 6' },
	[7] =  { ['x'] = -26.96,['y'] = -368.45,['z'] = 39.69,['h'] = 251.12, ['info'] = ' 7' },
	[8] =  { ['x'] = -155.88,['y'] = -751.76,['z'] = 33.76,['h'] = 251.82, ['info'] = ' 8' },

	[9] =  { ['x'] = -305.02,['y'] = -226.17,['z'] = 36.29,['h'] = 306.04, ['info'] = ' penis1' },
	[10] =  { ['x'] = -347.19,['y'] = -791.04,['z'] = 33.97,['h'] = 3.06, ['info'] = ' penis2' },
	[11] =  { ['x'] = -703.75,['y'] = -932.93,['z'] = 19.22,['h'] = 87.86, ['info'] = ' penis3' },
	[12] =  { ['x'] = -659.35,['y'] = -256.83,['z'] = 36.23,['h'] = 118.92, ['info'] = ' penis4' },
	[13] =  { ['x'] = -934.18,['y'] = -124.28,['z'] = 37.77,['h'] = 205.79, ['info'] = ' penis5' },
	[14] =  { ['x'] = -1214.3,['y'] = -317.57,['z'] = 37.75,['h'] = 18.39, ['info'] = ' penis6' },
	[15] =  { ['x'] = -822.83,['y'] = -636.97,['z'] = 27.9,['h'] = 160.23, ['info'] = ' penis7' },
	[16] =  { ['x'] = 308.04,['y'] = -1386.09,['z'] = 31.79,['h'] = 47.23, ['info'] = ' penis8' },

}


local drugLocs = {
	[1] =  { ['x'] = 131.94,['y'] = -1937.95,['z'] = 20.61,['h'] = 118.59, ['info'] = ' Grove Stash' },
	[2] =  { ['x'] = 1390.84,['y'] = -1507.94,['z'] = 58.44,['h'] = 29.6, ['info'] = ' East Side' },
	[3] =  { ['x'] = -676.81,['y'] = -877.94,['z'] = 24.48,['h'] = 324.9, ['info'] = ' Wei Cheng' },
}
--table = { ['x'] = 591.2265, ['y'] = 2744.78, ['z'] = 42.042533, ['h'] = 311.11083 }
local pillStore =  { ['x'] = 591.2265, ['y'] = 2744.78, ['z'] = 42.042533, ['h'] = 311.11083, ['info'] = ' oxy' }

local pillWorker = { ['x'] = 594.70,['y'] = 2743.184,['z'] = 42.036,['h'] = 177.65, ['info'] = ' lol' }


local pillStore =  { ['x'] = 591.35223, ['y'] = 2744.7895, ['z'] = 42.041542, ['h'] = 2.5324404, ['info'] = ' oxy' }

local pillWorker = { ['x'] = 590.34356, ['y'] = 2742.1293, ['z'] = 30.386508, ['h'] = 180.24305, ['info'] = ' lol' }


function buildDrugShop()
	DoScreenFadeOut(1)
	
	FreezeEntityPosition(PlayerPedId(),true)
	Citizen.Wait(7000)
-- -35.0

	local generator = { x = pillStore["x"] , y = pillStore["y"], z = pillStore["z"]}
  	SetEntityCoords(PlayerPedId(),590.32427,2734.0009,30.386522)
  	
	local building = CreateObject(`traphouse_shell`,590.71246,2740.2744,24.13943,false,false,false)
	FreezeEntityPosition(building, true)
	local coordsofbuilding = GetEntityCoords(building, true)
	CreateObject(`V_38_C_Barbers_Det`,coordsofbuilding.x+0.36036100,coordsofbuilding.y-0.35528500,coordsofbuilding.z-1.54137200,false,false,false)
	CreateObject(`V_38_C_CABINET02`,coordsofbuilding.x+0.37338400,coordsofbuilding.y-3.67517500,coordsofbuilding.z-1.48056600,false,false,false)

	--CreateObject(`V_38_FAN`,coordsofbuilding.x+0.18863910,coordsofbuilding.y-1.78123200,coordsofbuilding.z-1.49853700,false,false,false)
	CreateObject(`V_38_SHELVES`,coordsofbuilding.x+0.38722500,coordsofbuilding.y-0.21649000,coordsofbuilding.z-2.34309200,false,false,false)
	CreateObject(`V_38_Pictures`,coordsofbuilding.x+0.36021210,coordsofbuilding.y+0.34026300,coordsofbuilding.z-1.82029300,false,false,false)
	CreateObject(`V_38_LIGHTS`,coordsofbuilding.x+0.95295510,coordsofbuilding.y-0.34358800,coordsofbuilding.z-4.50438800,false,false,false)
	
	local plant = CreateObject(`V_38_BARB_PLANT02`,coordsofbuilding.x+3.01122600,coordsofbuilding.y-4.98704700,coordsofbuilding.z-2.91572800,false,false,false)
	SetEntityRotation(plant,0.0,0.0,170.0,2,1)

	local chair1 = CreateObject(`Prop_chair_01b`,coordsofbuilding.x+2.92626000,coordsofbuilding.y+0.70815100,coordsofbuilding.z-1.54303900,false,false,false)
	local chair2 = CreateObject(`prop_chair_04a`,coordsofbuilding.x+2.92626000,coordsofbuilding.y+2.21829500,coordsofbuilding.z-1.54303900,false,false,false)
	local chair3 = CreateObject(`prop_chair_02`,coordsofbuilding.x+2.92626000,coordsofbuilding.y+1.44866100,coordsofbuilding.z-1.54303900,false,false,false)
	local chair4 = CreateObject(`prop_chair_02`,coordsofbuilding.x+2.92626000,coordsofbuilding.y+0.00554299,coordsofbuilding.z-1.54303900,false,false,false)

	SetEntityRotation(chair1,0.0,0.0,-90.0,2,1)
	SetEntityRotation(chair2,0.0,0.0,-80.0,2,1)
	SetEntityRotation(chair3,0.0,0.0,-85.0,2,1)
	SetEntityRotation(chair4,0.0,0.0,-95.0,2,1)

	-- CreateObject(`prop_tv_05`,coordsofbuilding.x+2.97058500,coordsofbuilding.y+4.72485000,coordsofbuilding.z-3.96126500,false,false,false)
	-- local tv = CreateObject(`prop_tv_05`,coordsofbuilding.x-2.20064500,coordsofbuilding.y-4.56200100,coordsofbuilding.z-3.96016800,false,false,false)
	-- SetEntityRotation(tv,0.0,0.0,190.0,2,1)
	
	-- local til = CreateObject(`prop_till_01`,coordsofbuilding.x-2.18592300,coordsofbuilding.y-1.87080100,coordsofbuilding.z-2.51398500,false,false,false)
	-- SetEntityRotation(til,0.0,0.0,180.0,2,1)
	-- CreateObject(`v_ret_gc_fan`,coordsofbuilding.x+2.94997000,coordsofbuilding.y+3.27074200,coordsofbuilding.z-1.49715400,false,false,false)
	
	--CreateObject(`prop_cctv_cam_06a`,coordsofbuilding.x-2.35117100,coordsofbuilding.y+4.86646700,coordsofbuilding.z-4.18179800,false,false,false)
	--CreateObject(`prop_game_clock_01`,coordsofbuilding.x-0.54486800,coordsofbuilding.y+5.01194300,coordsofbuilding.z-3.67846000,false,false,false)
	--CreateObject(`prop_radio_01`,coordsofbuilding.x+3.07343200,coordsofbuilding.y+3.16888200,coordsofbuilding.z-3.37168900,false,false,false)
	
	CreateObject(`prop_speaker_05`,coordsofbuilding.x-2.40189600,coordsofbuilding.y+0.54597100,coordsofbuilding.z-3.89755000,false,false,false)
	--CreateObject(`prop_speaker_05`,coordsofbuilding.x-2.40189600,coordsofbuilding.y+3.19824400,coordsofbuilding.z+3.16581200,false,false,false)
	CreateObject(`prop_rub_stool`,coordsofbuilding.x-2.20233000,coordsofbuilding.y+4.06275700,coordsofbuilding.z-1.52316500,false,false,false)
	CreateObject(`prop_watercooler`,coordsofbuilding.x-2.26554100,coordsofbuilding.y+2.82748200,coordsofbuilding.z-1.41562700,false,false,false)
	CreateObject(`V_38_C_SHADOWMAP`,coordsofbuilding.x-0.31811000,coordsofbuilding.y+1.79183500,coordsofbuilding.z-1.54171400,false,false,false)

	
	CreateObject(`V_38_BARB_PLANT003`,coordsofbuilding.x-2.30056400,coordsofbuilding.y+1.66849900,coordsofbuilding.z-2.38898200,false,false,false)
	CreateObject(`V_38_C_Pictures3`,coordsofbuilding.x+3.20509200,coordsofbuilding.y-0.40208200,coordsofbuilding.z-1.91242400,false,false,false)
	CreateObject(`V_38_C_Sink`,coordsofbuilding.x-0.62845000,coordsofbuilding.y+4.84067900,coordsofbuilding.z-1.41538000,false,false,false)

	-- FreezeEntityPosition(coordsofbuilding,true)
	--SetEntityCoords(PlayerPedId(), 594.70,2743.184,42.036)
	Citizen.Wait(500)
	SetEntityHeading(PlayerPedId(),0.0)
	FreezeEntityPosition(PlayerPedId(),false)
	DoScreenFadeIn(1)
end




local rnd = 0
local blip = 0
local deliveryPed = 0
local gangTaskArea = "local"

function GroupSelect(number)
	if number == 1 then
		gangTaskArea = "mexican"
	elseif number == 2 then
		gangTaskArea = "salva"
	elseif number == 3 then
		gangTaskArea = "weicheng"
	elseif number == 4 then
		gangTaskArea = "family"
	elseif number == 5 then
		gangTaskArea = "ballas"
	end
end

local eastpedtypes = {
	'g_m_y_mexgang_01',
	'g_m_y_mexgoon_01',
	'g_m_y_mexgoon_02',
	'g_m_y_mexgoon_03',
}

local centpedtypes = {
	'g_m_y_ballaeast_01',
	'g_m_y_ballaorig_01',
	'g_m_y_famca_01',
	'g_m_y_famdnf_01',
	'g_m_y_famfor_01',
}

local westpedtypes = {
	'g_m_y_korean_01',
	'g_m_y_korean_02',
	'g_m_m_chiboss_01',
	'g_m_m_chicold_01',
	'g_m_m_chigoon_01',
	'g_m_m_chigoon_02',
	'g_m_m_korboss_01',
}

local oxyPeds = {
	'a_m_y_stwhi_02',
	'a_m_y_stwhi_01'
}

function CreateDrugStorePed()

	if DoesEntityExist(drugStorePed) then
		return
	end
	local hashKey = `a_m_y_stwhi_02`
	local pedType = GetPedType(hashKey)
    RequestModel(hashKey)
    while not HasModelLoaded(hashKey) do
        RequestModel(hashKey)
        Citizen.Wait(100)
    end
	drugStorePed = CreatePed(pedType, hashKey, pillWorker["x"],pillWorker["y"],pillWorker["z"], 270.0, 1, 1)
	SetEntityHeading(drugStorePed, 180.24)
	DecorSetBool(drugStorePed, 'ScriptedPed', true)
    ClearPedTasks(drugStorePed)
    ClearPedSecondaryTask(drugStorePed)
    TaskSetBlockingOfNonTemporaryEvents(drugStorePed, true)
    SetPedFleeAttributes(drugStorePed, 0, 0)
    SetPedCombatAttributes(drugStorePed, 17, 1)

    SetPedSeeingRange(drugStorePed, 0.0)
    SetPedHearingRange(drugStorePed, 0.0)
    SetPedAlertness(drugStorePed, 0)
    SetPedKeepTask(drugStorePed, true)
end

local carpick = {
    [1] = "felon",
    [2] = "kuruma",
    [3] = "sultan",
    [4] = "granger",
    [5] = "tailgater",
}

local carspawns = {
	[1] =  { ['x'] = 564.91,['y'] = 2735.9,['z'] = 42.07,['h'] = 182.27, ['info'] = ' park 8' },
	[2] =  { ['x'] = 586.27,['y'] = 2737.04,['z'] = 42.05,['h'] = 184.36, ['info'] = ' park 1' },
	[3] =  { ['x'] = 583.34,['y'] = 2736.95,['z'] = 41.99,['h'] = 181.24, ['info'] = ' park 2' },
	[4] =  { ['x'] = 580.3,['y'] = 2736.68,['z'] = 42.01,['h'] = 181.3, ['info'] = ' park 3' },
	[5] =  { ['x'] = 577.27,['y'] = 2736.31,['z'] = 42.02,['h'] = 181.46, ['info'] = ' park 4' },
	[6] =  { ['x'] = 574.14,['y'] = 2736.34,['z'] = 42.06,['h'] = 182.53, ['info'] = ' park 5' },
	[7] =  { ['x'] = 570.9,['y'] = 2736.1,['z'] = 42.07,['h'] = 176.64, ['info'] = ' park 6' },
	[8] =  { ['x'] = 567.88,['y'] = 2736.03,['z'] = 42.07,['h'] = 182.0, ['info'] = ' park 7' },

	
}


function CreateOxyVehicle()

	if DoesEntityExist(oxyVehicle) then

	    SetVehicleHasBeenOwnedByPlayer(oxyVehicle,false)
		SetEntityAsNoLongerNeeded(oxyVehicle)
		DeleteEntity(oxyVehicle)
	end

    local car = GetHashKey(carpick[math.random(#carpick)])
    RequestModel(car)
    while not HasModelLoaded(car) do
        Citizen.Wait(0)
    end

    local spawnpoint = 1
    for i = 1, #carspawns do
	    local caisseo = GetClosestVehicle(carspawns[i]["x"], carspawns[i]["y"], carspawns[i]["z"], 3.500, 0, 70)
		if not DoesEntityExist(caisseo) then
			spawnpoint = i
		end
    end

    oxyVehicle = CreateVehicle(car, carspawns[spawnpoint]["x"], carspawns[spawnpoint]["y"], carspawns[spawnpoint]["z"], carspawns[spawnpoint]["h"], true, false)
	local plt = GetVehicleNumberPlateText(oxyVehicle)
	DecorSetInt(oxyVehicle,"GamemodeCar",955)
	SetVehicleHasBeenOwnedByPlayer(oxyVehicle,true)
	TriggerEvent("vehiclekeys:client:SetOwner",plt)
	TriggerServerEvent('vehicle:lamban', exports['cd_dispatch']:GetPlayerInfo())


    while true do
    	Citizen.Wait(1)
    	 DrawText3Ds(carspawns[spawnpoint]["x"], carspawns[spawnpoint]["y"], carspawns[spawnpoint]["z"], "Xe giao hàng (Ăn trộm).")
    	 if #(GetEntityCoords(PlayerPedId()) - vector3(carspawns[spawnpoint]["x"], carspawns[spawnpoint]["y"], carspawns[spawnpoint]["z"])) < 8.0 then
    	 	return
    	 end
    end

end

function CreateOxyPed()

    local hashKey = `a_m_y_stwhi_01`

    local pedType = 5

    RequestModel(hashKey)
    while not HasModelLoaded(hashKey) do
        RequestModel(hashKey)
        Citizen.Wait(100)
    end


	deliveryPed = CreatePed(pedType, hashKey, OxyDropOffs[rnd]["x"],OxyDropOffs[rnd]["y"],OxyDropOffs[rnd]["z"], OxyDropOffs[rnd]["h"], 0, 0)
	
	DecorSetBool(deliveryPed, 'ScriptedPed', true)
    ClearPedTasks(deliveryPed)
    ClearPedSecondaryTask(deliveryPed)
    TaskSetBlockingOfNonTemporaryEvents(deliveryPed, true)
    SetPedFleeAttributes(deliveryPed, 0, 0)
    SetPedCombatAttributes(deliveryPed, 17, 1)

    SetPedSeeingRange(deliveryPed, 0.0)
    SetPedHearingRange(deliveryPed, 0.0)
    SetPedAlertness(deliveryPed, 0)
    searchPockets()
    SetPedKeepTask(deliveryPed, true)

end



function CreateDrugPed()
	

    local hashKey = `g_m_y_salvagoon_01`

    local pedType = 5

    RequestModel(hashKey)
    while not HasModelLoaded(hashKey) do
        RequestModel(hashKey)
        Citizen.Wait(100)
    end


	deliveryPed = CreatePed(pedType, hashKey, dropoffpoints[rnd]["x"],dropoffpoints[rnd]["y"],dropoffpoints[rnd]["z"], dropoffpoints[rnd]["h"], 1, 1)
	DecorSetBool(deliveryPed, 'ScriptedPed', true)
    ClearPedTasks(deliveryPed)
    ClearPedSecondaryTask(deliveryPed)
    TaskSetBlockingOfNonTemporaryEvents(deliveryPed, true)
    SetPedFleeAttributes(deliveryPed, 0, 0)
    SetPedCombatAttributes(deliveryPed, 17, 1)

    SetPedSeeingRange(deliveryPed, 0.0)
    SetPedHearingRange(deliveryPed, 0.0)
    SetPedAlertness(deliveryPed, 0)
    searchPockets()
    SetPedKeepTask(deliveryPed, true)
end

function DeleteCreatedPed()
	if DoesEntityExist(deliveryPed) then 
		SetPedKeepTask(deliveryPed, false)
		TaskSetBlockingOfNonTemporaryEvents(deliveryPed, false)
		ClearPedTasks(deliveryPed)
		TaskWanderStandard(deliveryPed, 10.0, 10)
		SetPedAsNoLongerNeeded(deliveryPed)
		DecorSetBool(deliveryPed, 'ScriptedPed', false)

		Citizen.Wait(20000)
		DeletePed(deliveryPed)
	end
end

function DeleteBlip()
	if DoesBlipExist(blip) then
		RemoveBlip(blip)
	end
end

function CreateBlip()
	DeleteBlip()
	if OxyRun then
		blip = AddBlipForCoord(OxyDropOffs[rnd]["x"],OxyDropOffs[rnd]["y"],OxyDropOffs[rnd]["z"])
	else
		blip = AddBlipForCoord(dropoffpoints[rnd]["x"],dropoffpoints[rnd]["y"],dropoffpoints[rnd]["z"])
	end
    
    SetBlipSprite(blip, 514)
    SetBlipScale(blip, 1.0)
    SetBlipAsShortRange(blip, false)
    BeginTextCommandSetBlipName("CUSTOM_TEXT")
    AddTextComponentString("Điểm giao hàng")
    EndTextCommandSetBlipName(blip)
end

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 

function searchPockets()
    if ( DoesEntityExist( deliveryPed ) and not IsEntityDead( deliveryPed ) ) then 
        loadAnimDict( "random@mugging4" )
        TaskPlayAnim( deliveryPed, "random@mugging4", "agitated_loop_a", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
    end
end

function giveAnim()
    if ( DoesEntityExist( deliveryPed ) and not IsEntityDead( deliveryPed ) ) then 
        loadAnimDict( "mp_safehouselost@" )
        if ( IsEntityPlayingAnim( deliveryPed, "mp_safehouselost@", "package_dropoff", 3 ) ) then 
            TaskPlayAnim( deliveryPed, "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
        else
            TaskPlayAnim( deliveryPed, "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
        end     
    end
end

local stolenGoodsTable = {
	[84] = "stolencasiowatch",
	[85] = "rolexwatch",
	[86] = "stoleniphone",
	[87] = "stolens8",
	[88] = "stolennokia",
	[89] = "stolenpixel3",
	[90] = "stolen2ctchain",
	[91] = "stolen5ctchain",
	[92] = "stolen8ctchain",
	[93] = "stolen10ctchain",
	[94] = "stolenraybans",
	[95] = "stolenoakleys",
	[96] = "stolengameboy",
	[97] = "stolenpsp",
}

function HasStolenGoods()
	if OxyRun then
		
		TriggerEvent("attachItemDrugs","cashcase01")
		return true
	else
		for i = 84, 97 do
			local itemcount = exports["pw-inventory"]:hasEnoughOfItem(stolenGoodsTable[i],1,false)
			if itemcount then
				TriggerEvent("inventory:removeItem",stolenGoodsTable[i], 1)
				TriggerEvent("attachItemDrugs","cashcase01")
				return true
			end
		end
	end
	return false
end
local bandprice = 15000
local rollcashprice = 1800
local cashrollprice = 2000
local inkedmoneybagprice = 50000
local markedbillsprice = 7000

function DoDropOff(requestMoney)

	cashPayment = 90 + math.random(35)
	local success = true

	searchPockets()

	Wait(1500)

	PlayAmbientSpeech1(deliveryPed, "Chat_State", "Speech_Params_Force")

	if DoesEntityExist(deliveryPed) and not IsEntityDead(deliveryPed) then

		if HasStolenGoods() then

			if math.random(100) == 1 then
				TriggerEvent("player:receiveItem", "Gruppe6Card", 1)
				--TriggerEvent( "player:receiveItem", "locksystem", math.random(4) )
			end
			
			if math.random(49) == 49 then
				TriggerEvent("traps:luck:aiSale")
			end

			if OxyRun then

				cashPayment = math.random(10,100)
				
				if exports["pw-inventory"]:hasEnoughOfItem("inkedmoneybag",1,false) then     
					-- RepPlus()
					TriggerEvent("inventory:removeItem","inkedmoneybag", 1)   
					cashPayment = cashPayment + 85000  

		        elseif exports["pw-inventory"]:hasEnoughOfItem("rollcash",30,false) then     
		            TriggerEvent("inventory:removeItem","rollcash", 30)   
		            cashPayment = cashPayment + rollcashprice             
		            TriggerEvent("DoLongHudText","Cảm ơn đã mang thêm hàng!")
		        elseif exports["pw-inventory"]:hasEnoughOfItem("markedbills",20,false) then     
		            TriggerEvent("inventory:removeItem","markedbills", 20)   
		            cashPayment = cashPayment + markedbillsprice            
		            TriggerEvent("DoLongHudText","Cảm ơn đã mang thêm hàng!")
				elseif exports["pw-inventory"]:hasEnoughOfItem("band",20,false) then     
					TriggerEvent("inventory:removeItem","band", 20)   
					cashPayment = cashPayment + bandprice           
					TriggerEvent("DoLongHudText","Cảm ơn đã mang thêm hàng!")
				elseif exports["pw-inventory"]:hasEnoughOfItem("cashroll",5,false) then     
					TriggerEvent("inventory:removeItem","cashroll", 5)   
					cashPayment = cashPayment + cashrollprice           
					TriggerEvent("DoLongHudText","Cảm ơn đã mang thêm hàng!")	
					
				else
		            TriggerEvent("DoLongHudText","Thanks, không có đồ cần xử lý à?!")
		        end

				if math.random(100) > 80 then
					TriggerEvent("player:receiveItem", "oxynew", 1 )
				end

			else

				cashPayment = math.random(10,100)

			end
			
		else

			if not OxyRun then
				TriggerEvent("loseGangReputationSpecific","robbery")
				TriggerEvent("DoLongHudText","Chuyến giao hàng thất bại - bạn cần đồ ăn cắp.",2)
			else
				TriggerEvent("DoLongHudText","Chuyến giao hàng thất bại - bạn cần đồ Oxy.",2)
			end
			
			success = false
			return

		end

	end

	local counter = math.random(50,200)
	while counter > 0 do
		local crds = GetEntityCoords(deliveryPed)
		counter = counter - 1
		Citizen.Wait(1)
	end

	if success then
		searchPockets()
		local counter = math.random(100,300)
		while counter > 0 do
			local crds = GetEntityCoords(deliveryPed)
			counter = counter - 1
			Citizen.Wait(1)
		end
		giveAnim()
	end

	local crds = GetEntityCoords(deliveryPed)
	local crds2 = GetEntityCoords(PlayerPedId())

	if #(crds - crds2) > 5.0 or not DoesEntityExist(deliveryPed) or IsEntityDead(deliveryPed) then
		success = false
	end


	if success then

		PlayAmbientSpeech1(deliveryPed, "Generic_Thanks", "Speech_Params_Force_Shouted_Critical")
		if math.random(7) == 5 then
			TriggerEvent("player:receiveItem","pix1",1)
		end

		if math.random(55) == 5 then
			TriggerEvent("player:receiveItem","pix2",1)
		end

		TriggerServerEvent('mission:completed', cashPayment)
		--TriggerServerEvent("police:multipledenominators",true)
		TriggerEvent("denoms",true)

	else
		TriggerEvent("DoLongHudText","Giao hàng cấm thất bại.",2)
	end
	
	DeleteBlip()
	if success then
		Citizen.Wait(2000)
		TriggerEvent("DoLongHudText", "Điểm giao mới sẽ sớm được cập nhật!! ",2)
	else
		TriggerEvent("DoLongHudText","Chuyến giao hàng thất bại - bạn cần đồ ăn cắp.",2)
	end

	DeleteCreatedPed()
end

local fighting = 0
function startAiFight()

    if fighting > 0 then
        return
    end    
    DeleteBlip()
    local killerPed = deliveryPed  
    fighting = 10000

    TaskCombatPed(deliveryPed, PlayerPedId(), 0, 16) 
    Citizen.Wait(700) 

    while fighting > 0 do
        Citizen.Wait(1)
        fighting = fighting - 1
        if IsEntityDead(killerPed) then          
            SearchPockets(killerPed)
            fighting = 0
        end
        if not DoesEntityExist(killerPed) or IsEntityDead(PlayerPedId()) or fighting < 10 then
            ClearPedTasks(killerPed)
            Citizen.Wait(10000)
            fighting = 0
        end
    end

    fighting = 0
end

function DropItemPed(ai)
    local ai = ai
    local chance = math.random(50)
    if chance > 41 then
        DropDrugs(ai,true)
    elseif chance > 35 then
        DropDrugs(ai,false)
    end
    TriggerServerEvent('mission:completed', cashPayment)
end

function DropDrugs(ai,highvalue)
    local highvalue = highvalue
    local pos = GetEntityCoords(PlayerPedId())
    if highvalue then
		TriggerEvent("inv:CreatedropItem",90,math.random(4))
	else
		TriggerEvent("inv:CreatedropItem",85,1)
	end
end

function SearchPockets(ai)
    local timer = 3000
    local ai = ai
    local searching = false
    
    while timer > 0 do
        timer = timer - 1
        local pos = GetEntityCoords(ai)
        Citizen.Wait(1)

        if not searching then
            DrawText3Ds(pos["x"], pos["y"],pos["z"], "Press E to search person.")
            if IsControlJustReleased(1,38) and #(pos - GetEntityCoords(PlayerPedId())) < 3.0 then
                searching = true
                TriggerEvent("animation:PlayAnimation","search")
                local finished = exports["pw-taskbar"]:taskBar(15000,"Searching Thug")

                if tonumber(finished) == 100 then
                    DropItemPed(ai)
                end
                ClearPedTasks(PlayerPedId())
                timer = 0
            end
        end
    end
    searching = false
end

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("CUSTOM_TEXT1")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

RegisterNetEvent('gangs:updateMyReputations')
AddEventHandler('gangs:updateMyReputations', function(mexican,salva,weicheng,family,ballas,robbery)
    myGangReputation["mexican"] = mexican
    myGangReputation["salva"] = salva
    myGangReputation["weicheng"] = weicheng
    myGangReputation["family"] = family
    myGangReputation["ballas"] = ballas
    myGangReputation["robbery"] = robbery

end)

RegisterNetEvent("gang:updateClientReputation")
AddEventHandler("gang:updateClientReputation", function(mexican,salva,weicheng,family,ballas,robbery)
    myGangReputation["mexican"] = mexican
    myGangReputation["salva"] = salva
    myGangReputation["weicheng"] = weicheng
    myGangReputation["family"] = family
    myGangReputation["ballas"] = ballas
    myGangReputation["robbery"] = robbery

end)

RegisterNetEvent("oxydelivery:client")
AddEventHandler("oxydelivery:client", function()

	if tasking then
		return
	end
	
	rnd = math.random(1,#OxyDropOffs)

	CreateBlip()

	local pedCreated = false

	tasking = true
	local toolong = 600000
	while tasking do

		Citizen.Wait(1)
		local plycoords = GetEntityCoords(PlayerPedId())
		local dstcheck = #(plycoords - vector3(OxyDropOffs[rnd]["x"],OxyDropOffs[rnd]["y"],OxyDropOffs[rnd]["z"])) 
		local oxyVehCoords = GetEntityCoords(oxyVehicle)
		local dstcheck2 = #(plycoords - oxyVehCoords) 

		local veh = GetVehiclePedIsIn(PlayerPedId(),false)
		if dstcheck < 40.0 and not pedCreated and (oxyVehicle == veh or dstcheck2 < 15.0) then
			pedCreated = true
			DeleteCreatedPed()
			CreateOxyPed()
			TriggerEvent("DoLongHudText","Bạn đang tới gần điểm giao.")
		end
		toolong = toolong - 1
		if toolong < 0 then

		    SetVehicleHasBeenOwnedByPlayer(oxyVehicle,false)
			SetEntityAsNoLongerNeeded(oxyVehicle)
			tasking = false
			OxyRun = false
			TriggerEvent("DoLongHudText","Bạn không còn đang đi giao hàng nữa vì quá mất thời gian.")
		end
		if dstcheck < 2.0 and pedCreated then

			local crds = GetEntityCoords(deliveryPed)
			DrawText3Ds(crds["x"],crds["y"],crds["z"], "[E]")  

			if IsControlJustReleased(0,38) then
				TaskTurnPedToFaceEntity(deliveryPed, PlayerPedId(), 1.0)
				Citizen.Wait(1500)
				PlayAmbientSpeech1(deliveryPed, "Generic_Hi", "Speech_Params_Force")
				DoDropOff()
				tasking = false
			end

		end

	end
	

	DeleteCreatedPed()
	DeleteBlip()

end)
RegisterNetEvent("drugdelivery:client")
AddEventHandler("drugdelivery:client", function()

	if tasking then
		return
	end

	if mygang == "mexican" then
		rnd = math.random(1,14)
	elseif mygang == "ballas" then
		rnd = math.random(15,28)
	elseif mygang == "weicheng" then
		rnd = math.random(29,42)
	end

	CreateBlip()

	local pedCreated = false

	tasking = true
	local timer = 120000
	while tasking and timer > 0 do
		timer = timer - 1
		Citizen.Wait(1)
		local plycoords = GetEntityCoords(PlayerPedId())
		local dstcheck = #(plycoords - vector3(dropoffpoints[rnd]["x"],dropoffpoints[rnd]["y"],dropoffpoints[rnd]["z"])) 
		if dstcheck < 40.0 and not pedCreated then
			pedCreated = true
			DeleteCreatedPed()
			CreateDrugPed()
			TriggerEvent("DoLongHudText","Bạn đang tới gần điểm giao.")
		end

		if dstcheck < 2.0 and pedCreated then

			local crds = GetEntityCoords(deliveryPed)
			DrawText3Ds(crds["x"],crds["y"],crds["z"], "[E]")  

			if IsControlJustReleased(0,38) then
				TaskTurnPedToFaceEntity(deliveryPed, PlayerPedId(), 1.0)
				Citizen.Wait(1500)
				PlayAmbientSpeech1(deliveryPed, "Generic_Hi", "Speech_Params_Force")
				DoDropOff()
				tasking = false
			end

		end

	end
	
	tasking = false
	DeleteCreatedPed()
	DeleteBlip()

end)

local drugdealer = false
local salecount = 0

local drugLocs = {
	[1] =  { ['x'] = 182.56,['y'] = -1319.25,['z'] = 29.32,['h'] = 236.06, ['info'] = ' Central', ["gang"] = "ballas", ["ent"] = 0 },
}

local areaLocs = {
	[1] =  { ['x'] = 228.36,['y'] = -1762.18,['z'] = 28.7,['h'] = 37.01, ['info'] = 1 },
	[2] =  { ['x'] = 449.71,['y'] = -1760.62,['z'] = 28.99,['h'] = 337.34, ['info'] = 2 },
	[3] =  { ['x'] = -719.0,['y'] = -897.81,['z'] = 20.43,['h'] = 270.27, ['info'] = 3 },
}

local HasProduct = {
	["mexican"] = true,
	["ballas"] = true,
	["weicheng"] = true,
}

local chopinfo = {

	[1] =  { ['x'] = 2341.1,['y'] = 3052.2, ['z'] = 48.15, ['h'] = 359.2, ['info'] = ' Chop Entry Point' },
	[2] =  { ['x'] = 2341.1,['y'] = 3052.2, ['z'] = 48.15,['h'] = 309.96, ['info'] = ' Craft' },
	[3] =  { ['x'] = 115.34,['y'] = 164.33,['z'] = 104.52,['h'] = 71.96, ['info'] = ' outside entrance' },
	[4] =  { ['x'] = 100.17,['y'] = 169.15,['z'] = 104.54,['h'] = 253.79, ['info'] = ' 1' },
	[5] =  { ['x'] = 126.96,['y'] = 159.32,['z'] = 104.51,['h'] = 249.47, ['info'] = ' 2' },
	[6] =  { ['x'] = 144.16,['y'] = 165.17,['z'] = 104.75,['h'] = 341.08, ['info'] = ' 3' },
	[7] =  { ['x'] = 147.77,['y'] = 175.11,['z'] = 105.1,['h'] = 339.32, ['info'] = ' 4' },

}


function IsDroppable()
	playerped = PlayerPedId()
	coordA = GetEntityCoords(playerped, 1)
	coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 100.0, 0.0)
	veh = getVehicleInDirection(coordA, coordB)
	return veh
end

function getVehicleInDirection(coordFrom, coordTo)
	local offset = 0
	local rayHandle
	local vehicle
	for i = 0, 100 do
		rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, PlayerPedId(), 0)	
		a, b, c, d, vehicle = GetRaycastResult(rayHandle)
		offset = offset - 1
		if vehicle ~= 0 then break end
	end
	local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
	if distance > 25 then vehicle = nil end
    return vehicle ~= nil and vehicle or 0
end



local tradingTable = { 
	[1] = "scrapmetal",
	[2] = "electronics",
	[3] = "plastic",
	[4] = "glass",
	[5] = "rubber",
	[6] = "copper",
	[7] = "aluminium",
	[8] = "steel"
}

RegisterNetEvent('payment:chopshopscrap')
AddEventHandler('payment:chopshopscrap', function(rarity,playsound)
	
	
	if playsound then
		-- if math.random(50) == 20 then
		-- 	TriggerEvent( "player:receiveItem", "Gruppe6Card3", 1 )
		-- end
		TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2.0, 'impactdrill', 0.5)
	end
	local amount = rarity * 5
		--TriggerEvent('player:receiveItem', tradingTable[math.random(#tradingTable)], amount)	
	if amount <= 50 then
		TriggerServerEvent('loot:useItem', 'chopchop')
	else
		TriggerServerEvent('loot:useItem', 'chopchoprare')
	end
	TriggerEvent("DoLongHudText","Picked up Scrap Items.",1)
end)


RegisterNetEvent('chopshoppub:leave')
AddEventHandler('chopshoppub:leave', function(plate)

	local veh = GetVehiclePedIsIn(PlayerPedId(), false)
	local myplate = GetVehicleNumberPlateText(veh)
	if plate == myplate then
		TaskLeaveVehicle(PlayerPedId(), veh, 0)
		Citizen.Wait(100)
		SetEntityCoords(PlayerPedId(),GetEntityCoords(PlayerPedId()))
	end

end)



function listedVehicle(veh)
	local answer = 0
	for i = 1, #currentVehicleList do 
		local modelID = currentVehicleList[i]["id"]
		if GetEntityModel(veh) == GetHashKey(vehicleList[modelID]["modelname"]) and not currentVehicleList[i]["resolved"] then
			answer = i
		end
	end
	return answer
end


local recentpix = false
function CompleteScrapping(vehicle, originalVehicleLocation)

	TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2.0, 'impactdrill', 0.5)

	RequestAnimDict('mp_car_bomb')
	while not HasAnimDictLoaded("mp_car_bomb") do
		Citizen.Wait(0)
	end

	TaskPlayAnim(PlayerPedId(), "mp_car_bomb", "car_bomb_mechanic", 8.0, -8, -1, 49, 0, 0, 0, 0)

	local finished = exports["pw-taskbar"]:taskBar(20000,"Scrapping Car")
	local currentLocation = GetEntityCoords(vehicle)
	if finished == 100 then
	    local vehicleDifference = #(currentLocation - originalVehicleLocation)
		if not IsPedInVehicle(PlayerPedId(),vehicle,false) then
			if vehicleDifference <= 1 then
				local vehResponse = listedVehicle(veh)
				local plate = GetVehicleNumberPlateText(veh)
				TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2.0, 'impactdrill', 0.5)
				TriggerServerEvent("chopshop:removevehicle",vehResponse,plate,50)
				Citizen.Wait(2500)
				TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2.0, 'impactdrill', 0.5)
				SetEntityAsNoLongerNeeded(veh,true)
				DeleteEntity(veh)
			else
				TriggerEvent("DoLongHudText","Don't move your vehicle while we're trying to chop it, idiot.",2)
			end
		else
			TriggerEvent("DoLongHudText","You can't stay inside the vehicle while we're trying to chop it, idiot.",2)
		end
	end
end

--[[
RegisterNetEvent('resetpix')
AddEventHandler('resetpix', function()
	Wait(60000)
	recentpix = false
end)

RegisterNetEvent('payment:chopPixerium')
AddEventHandler('payment:chopPixerium', function()
	if not recentpix then
		--TriggerEvent("player:receiveItem","pix1",1)
		TriggerServerEvent('loot:useItem', 'chopchop2')
		recentpix = true
		TriggerEvent("resetpix")
	end
end)
]]

function CleanUpArea()
    local playerped = PlayerPedId()
    local plycoords = GetEntityCoords(playerped)
    local handle, ObjectFound = FindFirstObject()
    local success
    repeat
        local pos = GetEntityCoords(ObjectFound)
        local distance = #(plycoords - pos)
        if distance < 10.0 and ObjectFound ~= playerped then
        	if IsEntityAPed(ObjectFound) then
        		if IsPedAPlayer(ObjectFound) then
        		else
        			DeleteObject(ObjectFound)
        		end
        	else
        		if not IsEntityAVehicle(ObjectFound) and not IsEntityAttached(ObjectFound) then
	        		DeleteObject(ObjectFound)
	        	end
        	end            
        end
        success, ObjectFound = FindNextObject(handle)
    until not success

    SetEntityAsNoLongerNeeded(drugStorePed)
    DeleteEntity(drugStorePed)

    EndFindObject(handle)
end
function buyDrugs()
	TriggerEvent( "player:receiveItem", "oxy", 1)
end

local GoldBarTime = false


RegisterNetEvent('goldtrade')
AddEventHandler('goldtrade', function()
	if exports["pw-inventory"]:hasEnoughOfItem("goldbar",70,true) then
		TriggerEvent("inventory:removeItem", "goldbar", 70)
		TriggerServerEvent('mission:completed', 35000)
	end
end)


Citizen.CreateThread(function()

    while true do

	    Citizen.Wait(1)
	  --  local dropOff3 = #(vector3(GetEntityCoords(PlayerPedId())) - vector3(chopinfo[3]["x"],chopinfo[3]["y"],chopinfo[3]["z"]))
	    local dropOff4 = #(GetEntityCoords(PlayerPedId()) - vector3(590.15521, 2734.0961, 30.386524))
	    local dropOff5 = #(GetEntityCoords(PlayerPedId()) - vector3(pillStore["x"],pillStore["y"],pillStore["z"]))
	    local dropOff6 = #(GetEntityCoords(PlayerPedId()) - vector3(pillWorker["x"],pillWorker["y"],pillWorker["z"]))

	    local GoldBars = #(GetEntityCoords(PlayerPedId()) - vector3(-112.58, 6468.93, 31.63))


		if GoldBars < 1.5 then
			local daytime = GetClockHours() 
			if daytime < 7 or daytime > 12 then
				GoldBarTime = true
			end
			if GoldBarTime then

				DrawText3Ds(-112.58, 6468.93, 31.63, "[E] Để đổi vàng (5p)") 
								
				if IsControlJustReleased(0,38) then
					if exports["pw-inventory"]:hasEnoughOfItem("goldbar",10,true) then
						FreezeEntityPosition(PlayerPedId(),true)
						local finished = exports["pw-taskbar"]:taskBar(120000,"Đang đổi vàng")
						if finished == 100 then
							FreezeEntityPosition(PlayerPedId(),false)
							--TriggerEvent("pixerium:check",5,"goldtrade",false)
							TriggerEvent("inventory:removeItem", "goldbar", 10)
							TriggerServerEvent('mission:completed', 750 )
						end
					end
					Citizen.Wait(1000)
				end

			else

				DrawText3Ds(-112.58, 6468.93, 31.63, "Chúng tôi tạm chưa mở") 

			end

		end

		if dropOff4 < 1.5 then
			DrawText3Ds(590.15521, 2734.0961, 30.386524, "[E] Để rời khỏi") 
			if IsControlJustReleased(0,38) then
				CleanUpArea()
				SetEntityCoords(PlayerPedId(),pillStore["x"],pillStore["y"],pillStore["z"])
				Citizen.Wait(1000)
			end
		end
		if dropOff5 < 1.5 then
			DrawText3Ds(pillStore["x"],pillStore["y"],pillStore["z"], "[E] Để vào") 
			--TriggerServerEvent("kGetWeather")
			if IsControlJustReleased(0,38) then
				buildDrugShop()
				
				CreateDrugStorePed()
			end
		end		

		if dropOff6 < 1.6 and not OxyRun then

			DrawText3Ds(pillWorker["x"],pillWorker["y"],pillWorker["z"], "[E] $200 - Giao hàng") 
			if IsControlJustReleased(0,38) then
				if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job and ESX.PlayerData.job.name == 'offpolice' then
					TriggerEvent("ESX:Notify","Cảnh thì không được làm bẩn","info")
				else	
					TriggerServerEvent("oxydelivery:server",200)
					Citizen.Wait(1000)
				end	
			end


		end		


	    	if dropOff4 > 2.0 and dropOff5 > 2.0 and dropOff6 > 2.0 and GoldBars > 2.0 then
		    	Citizen.Wait(1000)
		    end

	    

	    for i = 1, #drugLocs do

	    	if DoesEntityExist( drugLocs[i]["ent"] ) then

				if IsEntityDead( drugLocs[i]["ent"] ) then

					SetEntityAsNoLongerNeeded(drugLocs[i]["ent"])

					DeleteEntity( drugLocs[i]["ent"] )

				end

			end

		end

    end

end)

local hoods = {
	[1] =  { ['x'] = -854.57,['y'] = -929.71,['z'] = 15.69,['h'] = 180.43, ['info'] = ' west side' },
	[2] =  { ['x'] = -17.4,['y'] = -1610.89,['z'] = 29.24,['h'] = 179.87, ['info'] = ' central' },
	[3] =  { ['x'] = 1139.68,['y'] = -1715.13,['z'] = 35.67,['h'] = 179.31, ['info'] = ' east side' },
}


RegisterNetEvent('gangs:robloserep')
AddEventHandler('gangs:robloserep', function()
	
	local dstCheck = 450.0
	local groupid = 0
	for i=1,#hoods do
		local hoodDst = #(vector3(GetEntityCoords(PlayerPedId())) - vector3(hoods[i]["x"],hoods[i]["y"],hoods[i]["z"]))
		if hoodDst < dstCheck then
			groupid = i
			dstCheck = hoodDst
		end
	end

	if groupid ~= 0 then
		hood = "none"
		if groupid == 1 then
			hood = "weicheng"
		elseif groupid == 2 then
			hood = "ballas"
		elseif groupid == 3 then
			hood = "mexican"
		end
		TriggerEvent("loseGangReputationSpecific",hood)
	end

end)

--weicheng
--ballas
--mexican

local firstdeal = false
Citizen.CreateThread(function()


    while true do

        if drugdealer then

	        Citizen.Wait(1000)

	        if firstdeal then
	        	Citizen.Wait(10000)
	        end

	        TriggerEvent("drugdelivery:client")  

		    salecount = salecount + 1
		    if salecount == 7 then
		    	Citizen.Wait(1200000)
		    	drugdealer = false
		    end

		    Citizen.Wait(150000)
		    firstdeal = false

		elseif OxyRun then

			if (not DoesEntityExist(oxyVehicle) or GetVehicleEngineHealth(oxyVehicle) < 100.0) and vehspawn then
				OxyRun = false
				tasking = false
				print('ass hole')
				TriggerEvent("chatMessage", "EMAIL - Drug Deliveries", 8, "Dude! You fucked the car up, I canceled your run, asshole! ")
			else
				if tasking then
			        Citizen.Wait(30000)
			    else
			        TriggerEvent("oxydelivery:client")  
				    salecount = salecount + 1
				    if salecount == 6 then
				    	Citizen.Wait(1200000)
				    	OxyRun = false
				    end
				end
			end

	    else

	    	local close = false

	    	for i = 1, #drugLocs do

				local plycoords = GetEntityCoords(PlayerPedId())

				local dstcheck = #(plycoords - vector3(drugLocs[i]["x"],drugLocs[i]["y"],drugLocs[i]["z"])) 

			

				if dstcheck < 5.0 then

					close = true

					local job = exports["isPed"]:isPed("job")

					if true then
						--print('wahat')
						local price = 100

			    		DrawText3Ds(drugLocs[i]["x"],drugLocs[i]["y"],drugLocs[i]["z"], "[E] $" .. price .. " offer to sell stolen goods (12).") 
				    	
				    	if IsControlJustReleased(0,38) then

				    		local countpolice = exports["isPed"]:isPed("countpolice")
				    		local daytime = exports["isPed"]:isPed("daytime")
							local timeofthisday = GetClockHours()
							print('this')
							if true then
		            			mygang = drugLocs[i]["gang"]
					    		TriggerServerEvent("drugdelivery:server",price)
					    		Citizen.Wait(1500)
					    	end

				    	end

			    	else

			    		Citizen.Wait(60000)

			    	end

			    	Citizen.Wait(1)

			    end

			end

			if not close then
				Citizen.Wait(2000)
			end

	    end

    end

end)






RegisterNetEvent("drugdeliveries:AcceptBribe")
AddEventHandler("drugdeliveries:AcceptBribe", function()
	local NearNPC = exports["isPed"]:GetClosestNPC()
	PlayAmbientSpeech1(NearNPC, "Chat_Resp", "SPEECH_PARAMS_FORCE", 1)
	watchinglist[mygang] = { ["gang"] = mygang, ["timer"] = 3600 }
end)



RegisterNetEvent("drugdeliveries:nope")
AddEventHandler("drugdeliveries:nope", function()
	local NearNPC = exports["isPed"]:GetClosestNPC()
	TriggerEvent("DoLongHudText","We aint needing no help right now - come back later.",2)
	PlayAmbientSpeech1(NearNPC, "Chat_Resp", "SPEECH_PARAMS_FORCE", 1)
end)

RegisterNetEvent("drugdelivery:bribeInfo")
AddEventHandler("drugdelivery:bribeInfo", function(gangpassed,reputation)

	if watchinglist[gangpassed] then
		if watchinglist[gangpassed]["timer"] > 0 then
			local gangside = "None"
			if gangpassed == "mexican" then
				gangside = "East Side"
			elseif gangpassed == "ballas" then
				gangside = "Central"
			elseif gangpassed == "weicheng" then
				gangside = "West Side"
			end
			if myGangReputation[gangpassed] >= reputation then
				TriggerEvent("chatMessage", "EMAIL ", 8, "Yo, just had someone hit me up in the " .. gangside .. " area")
				print('Yo, just had someone hit me up in the'..gangside)
			end
		end
	end
end)

RegisterNetEvent("drugdelivery:receiveBox")
AddEventHandler("drugdelivery:receiveBox", function(amount)
	TriggerEvent("Evidence:StateSet",4,900)

end)
local breakingdown = false
RegisterNetEvent("drugdelivery:breakdownBox")
AddEventHandler("drugdelivery:breakdownBox", function()


end)




RegisterNetEvent("drugdelivery:startDealing")
AddEventHandler("drugdelivery:startDealing", function()
	local NearNPC = exports["isPed"]:GetClosestNPC()
	PlayAmbientSpeech1(NearNPC, "Chat_Resp", "SPEECH_PARAMS_FORCE", 1)
	TriggerEvent("DoLongHudText","Your pager will be updated with locations soon.")
	salecount = 0
	drugdealer = true
	firstdeal = true
end)

RegisterNetEvent("oxydelivery:startDealing")
AddEventHandler("oxydelivery:startDealing", function()
	local NearNPC = exports["isPed"]:GetClosestNPC()
	PlayAmbientSpeech1(NearNPC, "Chat_Resp", "SPEECH_PARAMS_FORCE", 1)
	
	TriggerEvent("ESX:Notify","Bạn sẽ nhận được địa điểm sớm")
	salecount = 0	
	firstdeal = true
	OxyRun = true
	vehspawn = false
	CreateOxyVehicle()
	vehspawn = true
	

	
end)

