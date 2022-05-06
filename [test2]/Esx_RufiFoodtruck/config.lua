Config              = {}


Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,["-"] = 84,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178, ["INSERT"] = 121,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}



---- MARKERS CONFIG -------------------------------------------------------
Config.DrawDistance = 10.0
Config.ZoneSize     = {x = 1.0, y = 1.0, z = 0.8}
Config.MarkerColor  = {r = 0, g = 200, b = 0}
Config.MarkerType   = 22


BuyFoodtruckPos = vector3(445.93, -1242.31, 30.5)

--------- FOODTRUCK SPAWN POS ---------
Spawnpos = { x = 452.38, y = -1250.9, z = 29.8 }
SpawnHeading = 86.0
---------------------------------------

ParkCoords = vector3(436.05, -1250.86, 31.0) --- Marker pos for park and modify vehicle
----------------------------------------------------------------------------


---- BLIP CONFIG ----
AllowBlip = true
BlipName = 'FoodTruck' 
BlipSprite = 635
BlipScale = 1.0
BlipColour = 46
BlipCoords = vector3(445.93, -1242.31, 30.5)
---------------------


---- FOODTRUCK BUY PRICE CONFIG ----
Config.FoodtruckBuyPrice = 125000
------------------------------------

---- CAM CONFIG ----
MaxCamZoomDistance = 20.0
MaxCamHeight = 15.0
--------------------

---- TIME TO START SEARCH NEW NPC CUSTOMER CONFIG (It wait random time between MinNPCWaitTIME and MaxNPCWaitTime) ----
MinNPCWaitTime = 2000 
MAxNPCWaitTime = 5000
----------------------------------------------------------------------------------------------------------------------

---- MAX DISTANCE FROM PLAYER TO SEARCH NPC ----
NPCSearchDistance = 50
------------------------------------------------

---- PLATE CONFIG ----
PlateLetters  = 3
PlateNumbers  = 4
PlateUseSpace = true
---------------------


---- TEXTS ----
StartNpcJob = '~w~Starting NPC job...'
WaitingForNpc = '~b~Waiting for NPC customer...'
NpcJobCancel = '~y~NPC job cancelled'
CustomerFound = '~g~Customer found!'
NpcStuckOrDeadMessage = 'NPC customer dead or stuck. ~y~Searching new NPC customer...'
WrongDrink = '~y~Wrong drink.'
WrongFood = '~y~Wrong food.'
WrongDrinkAndFood = '~y~Wrong drink and food.'
NoDrinkOrFood = '~y~No drink or food selected.'
LoadCamMode = '~y~Loading camera mode...'
CamLoaded = '~g~Done!'
---------------


---- FOODTRUCK CONTROLS AND HELPTEXT CONFIG (You can look all control name (Like ~INPUT_CONTEXT~) here: https://docs.fivem.net/docs/game-references/controls/) ----
FoodTruckMenuKey = "Hold ~INPUT_CONTEXT~ to get in/out the Foodtruck"
Config.EnterExitKey = Keys['E']

BuyFoodtruckMarkerText = 'Press ~INPUT_CONTEXT~ to open FoodTruck menu.'
ParkText = 'Press ~INPUT_CONTEXT~ to Park or modify your foodtruck'
Config.UseKey = Keys['E']

Config.OptionsHelpText = 'Press ~INPUT_CELLPHONE_CAMERA_FOCUS_LOCK~ to open foodtruck menu.     Press ~INPUT_VEH_LOOK_BEHIND~ to open/close camera mode.            Press ~INPUT_VEH_FLY_ATTACK_CAMERA~ to start/stop NPC job.'
Config.CamMenuKey = Keys['C']
Config.NpcJobKey = Keys['INSERT']
Config.FoodTruckMenuKey = Keys['L']


CamControlsHelpMessage = 'Press ~INPUT_VEH_FLY_ROLL_LEFT_ONLY~  ~INPUT_VEH_FLY_ROLL_RIGHT_ONLY~  ~INPUT_VEH_FLY_PITCH_UP_ONLY~  ~INPUT_VEH_SUB_PITCH_DOWN_ONLY~ to move the camera and ~INPUT_REPLAY_FOVINCREASE~  ~INPUT_REPLAY_FOVDECREASE~ to change zoom.'
CamUP = Keys['N8']
CamDOWN = Keys['N5']
CamLEFT = Keys['N4']
CamRIGHT = Keys['N6']
ZoomIN = Keys['N+']
ZoomOUT = Keys['N-']


----------------------------------------------------------------------------------------------------------------------------------------------------------


---- FOODS AND DRINKS THAT CAN BE SOLD TO PLAYER CUSTOMERS ---
Foods = {
      {label = "Hotdog", item = 'rhotdog', prop = 'prop_cs_hotdog_01'},
      {label = "Burger", item = 'rburger', prop = 'prop_cs_burger_01'},
      {label = "Taco", item = 'rtaco', prop = 'prop_taco_02'},
      {label = "Sandwich", item = 'rsandwich', prop = 'prop_sandwich_01'},
      {label = "Chips", item = 'rchips', prop = 'v_ret_ml_chips4'},
      {label = "Chocolate", item = 'rchocolate', prop = 'prop_choc_ego'},
      {label = "Cupcake", item = 'rcupcake', prop = 'ng_proc_food_ornge1a'}
    }
	
Drinks = {
      {label = "Water", item = 'water', prop = 'ba_prop_club_water_bottle' },
      {label = "Cola", item = 'rcola', prop = 'prop_ecola_can'},
	  {label = "Coffe", item = 'rcoffe', prop = 'prop_fib_coffee'},
	  {label = "Icetea", item = 'ricetea', prop = 'prop_ld_can_01'}, 
	  {label = "Beer", item = 'rbeer', prop = 'prop_amb_beer_bottle'}
	  
    }	
--------------------------------------------------------------	





---- FOODS AND DRINKS THAT CAN BE SOLD TO NPC CUSTOMERS ----

NPCFood = {
	  {label = "Hotdog", price = 3, prop = 'prop_cs_hotdog_01'},
      {label = "Burger", price = 5, prop = 'prop_cs_burger_01'},
      {label = "Taco", price = 4, prop = 'prop_taco_02'},
      {label = "Sandwich", price = 2, prop = 'prop_sandwich_01'},
      {label = "Chips", price = 1, prop = 'v_ret_ml_chips4'},
      {label = "Chocolate", price = 1, prop = 'prop_choc_ego'},
      {label = "Cupcake", price = 2, prop = 'ng_proc_food_ornge1a'}
}

NPCDrink = {
	  {label = "Water", price = 1, prop = 'ba_prop_club_water_bottle' },
      {label = "Cola", price = 2, prop = 'prop_ecola_can'},
	  {label = "Coffe", price = 2, prop = 'prop_fib_coffee'},
	  {label = "Icetea", price = 2, prop = 'prop_ld_can_01'}, 
	  {label = "Beer", price = 3, prop = 'prop_amb_beer_bottle'}
}
--------------------------------------------------------------


