ESX = nil   
local PlayerData = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

local isJudge = false
local isPolice = false
local isMedic = false
local isDoctor = false
local isNews = false
local isDead = false
local isInstructorMode = false
local myJob = "unemployed"
local isHandcuffed = false
local isHandcuffedAndWalking = false
local hasOxygenTankOn = false
local gangNum = 0
local cuffStates = {}


rootMenuConfig =  {
    

    {
        id = "general",
        displayName = "General",
        icon = "#globe-europe",
        enableMenu = function()
            return not isDead
        end,
        subMenus = {"general:emotes", "general:bills", 'MF_VehSales:SellCar'}
    },

    {
        id = "animations",
        displayName = "Animations",
        icon = "#walking",
        enableMenu = function()
            return not isDead
        end,
        subMenus = { "animations:brave", "animations:hurry", "animations:business", "animations:tipsy", "animations:injured","animations:tough", "animations:default", "animations:hobo", "animations:money", "animations:swagger", "animations:shady", "animations:maneater", "animations:chichi", "animations:sassy", "animations:sad", "animations:posh", "animations:alien" }
    },

        {
        id = "civil",
        displayName = "Civil Interaction",
        icon = "#vatandas",
        enableMenu = function()

            return not isDead 
        end,
        subMenus = {  "carry:omzundatasi","carry:kucagindatasi", "takehostage", "steal"}
    },

    {
        id = "expressions",
        displayName = "Clothing",
        icon = "#expressions",
        enableMenu = function()
            return not isDead
        end,
        subMenus = { "giyim:normal", "giyim:maske","giyim:giyin", "giyim:kask", "giyim:canta", "giyim:pantolon", "giyim:ayakkabı"}
    },

    {
        id = "taxi",
        displayName = "Taxi",
        icon = "#taxi",
        enableMenu = function()
            local Data = ESX.GetPlayerData()
            return (not isDead and Data.job ~= nil and Data.job.name == "taxi")
        end,
        subMenus = { "taxi:taksimetre", "police:bill", "taxi:taksimetrekapat" }
    },

    {
        id = "tow",
        displayName = "Tow",
        icon = "#vehicle-options-vehicle",
        enableMenu = function()
            local Data = ESX.GetPlayerData()
            return (not isDead and Data.job ~= nil and Data.job.name == "tow")
        end,
        subMenus = { "ToggleNpc", "TowVehicle", "CancelNpc" }
    },


    {
        id = "mechanic",
        displayName = "Mechanic",
        icon = "#mechanic",
        enableMenu =function()
            local Data = ESX.GetPlayerData()
            return (not isDead and Data.job ~= nil and (Data.job.name == "mechanic" or Data.job.name == "tuner"))
        end,
        subMenus = { "police:impound", "mechanic:repair","mechanic:hijack" }
    },

    {
        id = "police",
        displayName = "Security",
        icon = "#police",
        enableMenu =function()
            local Data = ESX.GetPlayerData()
            return (not isDead and Data.job ~= nil and Data.job.name == "police" or Data.job.name == "ambulance")
        end,
        subMenus = { "police:putinvehicle", "police:bill", "police:outofvehicle", "police:impound", "police:cuff", "police:uncuff", "police:drag", "steal"}
    },
    
    {
        id = "police-check",
        displayName = "Police",
        icon = "#police-check",
        enableMenu = function()
            local Data = ESX.GetPlayerData()
            return (not isDead and Data.job ~= nil and Data.job.name == "police")
        end,
        subMenus = {"police:checkbank", "police:search", "policedog", 'police:mdt', "police:cone", "police:barier", "police:light", 'police:deleteObject', "steal"}
    },

    {
        id = "police-objects",
        displayName = "Police Objects",
        icon = "#police-objects",
        enableMenu =function()
            local Data = ESX.GetPlayerData()
            return (not isDead and Data.job ~= nil and Data.job.name == "police")
        end,
        subMenus = { "police:cone", "police:barier", "police:light", 'police:deleteObject'}
    },

    {
        id = "blips",
        displayName = "GPS",
        icon = "#blips",
        enableMenu = function()
            return (not isDead and IsPedInAnyVehicle(PlayerPedId(), false))
        end,
        subMenus = { "blips:gasstations", "blips:barbershop", "fk:deleteblip", "blips:tattooshop", "fk:karakol", "fk:hastane", "fk:galeri", "fk:motel"}
    },  


    {
        id = "ems",
        displayName = "EMS",
        icon = "#ems-ambulance",
        enableMenu = function()
            local Data = ESX.GetPlayerData()
            return (not isDead and Data.job ~= nil and Data.job.name == "ambulance")
        end,
        subMenus = {"ems:revive", 'ems:heal', "police:putinvehicle", "police:outofvehicle", 'police:drag'  }
    }
}

newSubMenus = {

    ['MF_VehSales:SellCar'] = {
        title = "Sell Vehicle",
        icon = "#vehicle-sell",
        functionName = "MF_VehSales:SellCar"
    },
    ['general:emotes'] = {
        title = "Emotes",
        icon = "#emotes",
        functionName = "emotes:OpenMenu"
    },

    ['general:bills'] = {
        title = "Bills",
        icon = "#police-bills",
        functionName = "esx_billing:openMenu"
    },

    -- Cuff
    ['cuffing:searchDeath'] = {
        title = "Steal",
        icon = "#cuffs-rob",
        functionName = "inventory:client:search",
    },

    ['cuffing:drag'] = {
        title = "Drag",
        icon = "#cuffs-drag",
        enableMenu = function()
            local Data = ESX.GetPlayerData()
            return (not isDead and Data.job ~= nil and Data.job.name ~= "ambulance" and Data.job.name ~= "police" and not IsPedInAnyVehicle(ped, true))
        end,
        functionName = "police:client:GetEscorted",
    },

    ['cuffing:steal'] = {
        title = "Steal",
        icon = "#cuffs-steal",
        functionName = "inventory:client:search",
    },

    ['cuffing:cuff'] = {
        title = "Cuff",
        icon = "#cuffs-cuff",
        enableMenu = function()
            local Data = ESX.GetPlayerData()
            return (not isDead and Data.job ~= nil and Data.job.name ~= "ambulance" and Data.job.name ~= "police" and not IsPedInAnyVehicle(ped, true))
        end,
        functionName = "police:client:CuffPlayer",
    },

    ['cuffing:uncuff'] = {
        title = "Uncuff",
        icon = "#cuffs-uncuff",
        enableMenu = function()
            local Data = ESX.GetPlayerData()
            return (not isDead and Data.job ~= nil and Data.job.name ~= "ambulance" and Data.job.name ~= "police" and not IsPedInAnyVehicle(ped, true))
        end,
        functionName = "police:client:UnCuffPlayer",
    },

    ['policedog'] = {
        title = "Police dog",
        icon = "#police-bill",
        functionName = "esx_policedog:openMenu"
    },

    ['CancelNpc'] = {
        title = "Remove Sign",
        icon = "#deleteblipz",
        functionName = "qb-tow:ToggleNpc"
    },

    ['ToggleNpc'] = {
        title = "Search Vehicles",
        icon = "#tow2",
        functionName = "qb-tow:ToggleNpc"
    },

    ['TowVehicle'] = {
        title = "Tow Vehicle",
        icon = "#tow1",
        functionName = "qb-tow:client:TowVehicle"
    },

    ['taxi:bill'] = {
        title = "Invoice",
        icon = "#police-bill",
        functionName = "mechanic:bill"
    },

    ['taxi:taksimetre'] = {
        title = "Open Taximeter",
        icon = "#taxi",
        functionName = "taksimetre"
    },

    ['taxi:taksimetrekapat'] = {
        title = "Close Taximeter",
        icon = "#deleteblipz",
        functionName = "taksimetre"
    },

    ['takehostage'] = {
        title = "Take Hostage",
        icon = "#rehinal",
        functionName = "takehostage"
    },

    ['steal'] = {
        title = "Steal",
        icon = "#police-ara",
        functionName = "inventory:client:search"
    },

    ['carry:omzundatasi'] = {
        title = "Move on Shoulder",
        icon = "#general-escort",
        functionName = "CarryPeople"
    },

    ['carry:kucagindatasi'] = {
        title = "Carry on Lap",
        icon = "#police-action-frisk",
        functionName = "lift"
    },

    ['blips:gasstations'] = {
        title = "Fuel station",
        icon = "#blips-gasstations",
        functionName = "ygx:togglegas"
    },    
    ['blips:garages'] = {
        title = "Garage",
        icon = "#blips-garages",
        functionName = "Garages:ToggleGarageBlip"
    },
    ['fk:deleteblip'] = {
        title = "Remove Sign",
        icon = "#deleteblipz",
        functionName = "fk:deleteblip"
    }, 
    ['blips:barbershop'] = {
        title = "Barber Shop",
        icon = "#blips-barbershop",
        functionName = "ygx:togglebarber"
    }, 
    ['fk:karakol'] = {
        title = "Department",
        icon = "#police",
        functionName = "fk:karakol"
    },
    ['fk:hastane'] = {
        title = "Hospital",
        icon = "#ems-ambulance",
        functionName = "fk:hastane"
    },
    ['fk:galeri'] = {
        title = "Vehicle Shop",
        icon = "#blips-garages",
        functionName = "fk:galeri"
    },  
    ['fk:motel'] = {
        title = "Motel",
        icon = "#blips-motel",
        functionName = "fk:motel"
    },  
    ['blips:tattooshop'] = {
        title = "Tattoo Shop",
        icon = "#blips-tattooshop",
        functionName = "ygx:toggletattos"
    },  

    --------------------------------------
    ['animations:brave'] = {
        title = "Brave",
        icon = "#animation-brave",
        functionName = "AnimSet:Brave"
    },

    ['animations:hurry'] = {
        title = "Hurry",
        icon = "#animation-hurry",
        functionName = "AnimSet:Hurry"
    },

    ['animations:business'] = {
        title = "Business",
        icon = "#animation-business",
        functionName = "AnimSet:Business"
    },

    ['animations:tipsy'] = {
        title = "Tipsy",
        icon = "#animation-tipsy",
        functionName = "AnimSet:Tipsy"
    },

    ['animations:injured'] = {
        title = "Injured",
        icon = "#animation-injured",
        functionName = "AnimSet:Injured"
    },

    ['animations:tough'] = {
        title = "Tough",
        icon = "#animation-tough",
        functionName = "AnimSet:ToughGuy"
    },

    ['animations:sassy'] = {
        title = "Sassy",
        icon = "#animation-sassy",
        functionName = "AnimSet:Sassy"
    },

    ['animations:sad'] = {
        title = "Sad",
        icon = "#animation-sad",
        functionName = "AnimSet:Sad"
    },

    ['animations:posh'] = {
        title = "Posh",
        icon = "#animation-posh",
        functionName = "AnimSet:Posh"
    },

    ['animations:alien'] = {
        title = "Alien",
        icon = "#animation-alien",
        functionName = "AnimSet:Alien"
    },

    ['animations:nonchalant'] = {
        title = "Nonchalant",
        icon = "#animation-nonchalant",
        functionName = "AnimSet:NonChalant"
    },

    ['animations:hobo'] = {
        title = "Hobo",
        icon = "#animation-hobo",
        functionName = "AnimSet:Hobo"
    },

    ['animations:money'] = {
        title = "Money",
        icon = "#animation-money",
        functionName = "AnimSet:Money"
    },

    ['animations:swagger'] = {
        title = "Swagger",
        icon = "#animation-swagger",
        functionName = "AnimSet:Swagger"
    },

    ['animations:shady'] = {
        title = "Shady",
        icon = "#animation-shady",
        functionName = "AnimSet:Shady"
    },

    ['animations:maneater'] = {
        title = "Maneater",
        icon = "#animation-maneater",
        functionName = "AnimSet:ManEater"
    },

    ['animations:chichi'] = {
        title = "Chichi",
        icon = "#animation-chichi",
        functionName = "AnimSet:ChiChi"
    },

    ['animations:default'] = {
        title = "Default",
        icon = "#animation-default",
        functionName = "AnimSet:default"
    },

    ["expressions:angry"] = {
        title="Angry",
        icon="#expressions-angry",
        functionName = "expressions",
        functionParameters =  { "mood_angry_1" }
    },

    ["expressions:drunk"] = {
        title="Drunk",
        icon="#expressions-drunk",
        functionName = "expressions",
        functionParameters =  { "mood_drunk_1" }
    },

    ["expressions:dumb"] = {
        title="Dumb",
        icon="#expressions-dumb",
        functionName = "expressions",
        functionParameters =  { "pose_injured_1" }
    },

    ["expressions:electrocuted"] = {
        title="Electrocuted",
        icon="#expressions-electrocuted",
        functionName = "expressions",
        functionParameters =  { "electrocuted_1" }
    },

    ["expressions:grumpy"] = {
        title="Grumpy",
        icon="#expressions-grumpy",
        functionName = "expressions", 
        functionParameters =  { "mood_drivefast_1" }
    },

    ["expressions:happy"] = {
        title="Happy",
        icon="#expressions-happy",
        functionName = "expressions",
        functionParameters =  { "mood_happy_1" }
    },

    ["expressions:injured"] = {
        title="Injured",
        icon="#expressions-injured",
        functionName = "expressions",
        functionParameters =  { "mood_injured_1" }
    },

    ["expressions:joyful"] = {
        title="Joyful",
        icon="#expressions-joyful",
        functionName = "expressions",
        functionParameters =  { "mood_dancing_low_1" }
    },

    ["expressions:mouthbreather"] = {
        title="Mouthbreather",
        icon="#expressions-mouthbreather",
        functionName = "expressions",
        functionParameters = { "smoking_hold_1" }
    },

    ["expressions:normal"]  = {
        title="Normal",
        icon="#expressions-normal",
        functionName = "expressions:clear"
    },

    ["expressions:oneeye"]  = {
        title="Oneeye",
        icon="#expressions-oneeye",
        functionName = "expressions",
        functionParameters = { "pose_aiming_1" }
    },

    ["expressions:shocked"]  = {
        title="Shocked",
        icon="#expressions-shocked",
        functionName = "expressions",
        functionParameters = { "shocked_1" }
    },

    ["expressions:sleeping"]  = {
        title="Sleeping",
        icon="#expressions-sleeping",
        functionName = "expressions",
        functionParameters = { "dead_1" }
    },

    ["expressions:smug"]  = {
        title="Smug",
        icon="#expressions-smug",
        functionName = "expressions",
        functionParameters = { "mood_smug_1" }
    },

    ["expressions:speculative"]  = {
        title="Speculative",
        icon="#expressions-speculative",
        functionName = "expressions",
        functionParameters = { "mood_aiming_1" }
    },

    ["expressions:stressed"]  = {
        title="Stressed",
        icon="#expressions-stressed",
        functionName = "expressions",
        functionParameters = { "mood_stressed_1" }
    },

    ["expressions:sulking"]  = {
        title="Sulking",
        icon="#expressions-sulking",
        functionName = "expressions",
        functionParameters = { "mood_sulk_1" },
    },

    ["expressions:weird"]  = {
        title="Weird",
        icon="#expressions-weird",
        functionName = "expressions",
        functionParameters = { "effort_2" }
    },

    ["expressions:weird2"]  = {
        title="Weird-2",
        icon="#expressions-weird2",
        functionName = "expressions",
        functionParameters = { "effort_3" }
     },    


    --------------------------------------
    ["emotes:smoke"] = {
        title = "Smoke",
        icon = "#emotes-smoke",
        functionName = 'menu:dpemotes:cmd',
        functionParameters =  { "emote" ,"smoke" }
    },

    ["emotes:lean"] = {
        title = "Lean",
        icon = "#emotes-lean",
        functionName = 'menu:dpemotes:cmd',
        functionParameters =  { "emote" ,"lean" }
    },

    ["emotes:sitchair"] = {
        title = "Sitchair",
        icon = "#emotes-sitchair",
        functionName = 'menu:dpemotes:cmd',
        functionParameters =  { "emote" ,"sitchair" }
    },

    ["emotes:dance"] = {
        title = "Dance",
        icon = "#emotes-dance",
        functionName = 'menu:dpemotes:cmd',
        functionParameters =  { "dance" ,"dance" }
    },
   
    ["emotes:surr"] = {
        title = "Surr",
        icon = "#emotes-surr",
        functionName = 'menu:dpemotes:cmd',
        functionParameters =  { "emote" , "surrender" }
    },

    --------------------------------------

    ['vehicle:callMechanic'] = {
        title = "Call Mech",
        icon = "#vehicle-callmec",
        functionName = "menu:general:callmechanic"
    },

    ['vehicle:engine'] = {
        title = "Engine",
        icon = "#vehicle-engine",
        functionName = "menu:hotwire:openOwner"
    },

    ['vehicle:search'] = {
        title = "Search",
        icon = "#vehicle-search",
        enableMenu = function()
            local Data = ESX.GetPlayerData()
            return (not isDead and Data.job ~= nil and Data.job.name ~= "ambulance" and Data.job.name ~= "police")
        end,
        functionName = "menu:hotwire",
        functionParameters =  { "search" }
    },

    ['vehicle:hotwire'] = {
        title = "Hotwire",
        icon = "#vehicle-hotw",
        enableMenu = function()
            local Data = ESX.GetPlayerData()
            return (not isDead and Data.job ~= nil and Data.job.name ~= "ambulance" and Data.job.name ~= "police")
        end,
        functionName = "menu:hotwire",
        functionParameters =  { "hotw" }
    },

    --------------------------------------
    
    ['police:cone'] = {
        title = "Cone",
        icon = "#object-cone",
        functionName = "police:client:spawnCone",
    },
    
    ['police:barier'] = {
        title = "Barier",
        icon = "#police",
        functionName = 'police:client:spawnBarier',
    },
    
    ['police:light'] = {
        title = "Light",
        icon = "#object-light",
        functionName = "police:client:spawnLight",
    },
        
    ['police:deleteObject'] = {
        title = "Delete",
        icon = "#object-delete",
        functionName = "police:client:deleteObject",
    },

    ['police:search'] = {
        title = "Search",
        icon = "#police-search",
        functionName = "YM:policerob",
    },
    ['police:checkbank'] = {
        title = "Check Bank",
        icon = "#police-check-bank",
        functionName = "police:client:checkBank"
    },
    ['police:impound'] = {
        title = "Impound",
        icon = "#police-jail",
        functionName = "impound"
    },

    ['police:bill'] = {
        title = "Bills",
        icon = "#ems-bill",
        functionName = "police:client:fineMenu",
    },

    ['police:bills'] = {
        title = "Bills",
        icon = "#police-bills",
        functionName = "police:client:finesMenu",
    },

    ['police:cuff'] = {
        title = "Cuff",
        icon = "#police-cuff",
        functionName = "police:client:CuffPlayerSoft"
    },

    ['police:uncuff'] = {
        title = "Uncuff",
        icon = "#police-uncuff",
        functionName = "police:client:UnCuffPlayer"
    },

    ['police:mdt'] = {
        title = "Tablet",
        icon = "#police-mdt",
        functionName = "mdt:Open"
    },

    ['police:putinvehicle'] = {
        title = "In Vehicle",
        icon = "#general-put-in-veh",
        functionName = "police:client:PutPlayerInVehicle",
    },

    ['police:outofvehicle'] = {
        title = "Out Vehicle",
        icon = "#general-unseat-nearest",
        functionName = "police:client:SetPlayerOutVehicle",
    },

    ['police:drag'] = {
        title = "Drag",
        icon = "#police-drag",
        functionName = "police:client:EscortPlayer",
    },

    --------------------------------------

    ['ems:bill'] = {
        title = "Bills",
        icon = "#ems-bill",
        functionName = "mechanic:bill",
    },

    ['ems:revive'] = {
        title = "Revive",
        icon = "#ems-revive",
        functionName = "menu:ems",
        functionParameters =  { "revive" }
    },

    ['ems:heal'] = {
        title = "Heal",
        icon = "#ems-heal",
        functionName = "menu:ems",
        functionParameters =  { "heal" }
    },

    ['ems:drag'] = {
        title = "Drag",
        icon = "#ems-drag",
        functionName = "Carry:Event"
    },

    ['ems:med'] = {
        title = "Med",
        icon = "#ems-heal",
        functionName = "menu:ems",
        functionParameters =  { "medsystem" }
    },

    ['ems:putinvehicle'] = {
        title = "In Vehicle",
        icon = "#ems-putinveh",
        functionName = "menu:ems",
        functionParameters =  { "piv" }
    },

    --------------------------------------
	['news:boom'] = {
        title = "Boom",
        icon = "#news-boom",
        functionName = "Mic:ToggleBMic"
    },

    ['news:cam'] = {
        title = "Cam",
        icon = "#news-cam",
        functionName = "Cam:ToggleCam"
    },

    ['news:mic'] = {
        title = "Mic",
        icon = "#news-mic",
        functionName = "Mic:ToggleMic"
    },


    --------------------------------------
    ["mechanic:bill"] = {
        title = "Bill",
        icon = "#ems-bill",
        functionName = "mechanic:bill"
    },

    ["mechanic:lookupvehicle"] = {
        title = "Look Vehicle",
        icon = "#general-search",
        functionName = "menu:police:lookupvehicle"
    },

    ["mechanic:hijack"] = {
        title = "Hijack",
        icon = "#mechanic-hijack",
        functionName = "mechanic:onHijack",
    },

    ["mechanic:repair"] = {
        title = "Repair",
        icon = "#mechanic-repair",
        functionName = "mechanic:repair"
    },

    ["mechanic:wash"] = {
        title = "Wash",
        icon = "#mechanic-wash",
        functionName = "mechanic:clean"
    },

    ["mechanic:impound"] = {
        title = "Impound",
        icon = "#mechanic-impound",
        functionName = "menu:impound"
    },

    ["mechanic:flatbed"] = {
        title = "Flatbed",
        icon = "#mechanic-flatbed",
        functionName = "mechanic:towuntow"
    },

    --------------------------------------
    ["accessories:mask"] = {
        title = "Mask",
        icon = "#accessories-mask",
        functionName = 'esx_accessories:SetUnsetAccessory',
        functionParameters =  { "Mask" }
    },

    ["accessories:glasses"] = {
        title = "Glasses",
        icon = "#accessories-glasses",
        functionName = 'esx_accessories:SetUnsetAccessory',
        functionParameters =  { "Glasses" }
    },

    ["accessories:helmet"] = {
        title = "Helmet",
        icon = "#accessories-helmet",
        functionName = 'esx_accessories:SetUnsetAccessory',
        functionParameters =  { "Helmet" }
    },

    ["accessories:ears"] = {
        title = "Ears",
        icon = "#accessories-ears",
        functionName = 'esx_accessories:SetUnsetAccessory',
        functionParameters =  { "Ears" }
    },
    ["giyim:kask"] = {
        title="Helmet",
        icon="#giyim-kask",
        functionName = "kask"
        },
    ["giyim:maske"] = {
        title="Mask",
        icon="#giyim-maske",
        functionName = "maske",
    },
    ["giyim:canta"] = {
        title="Bag",
        icon="#giyim-canta",
        functionName = "canta"
        },
    ["giyim:pantolon"] = {
        title="Pants",
        icon="#giyim-pantolon",
        functionName = "pantolon",
    },
    ["giyim:ayakkabı"] = {
        title="Sneakers",
        icon="#giyim-ayakkabı",
        functionName = "ayakkabı"
        },
    ["giyim:giyin"] = {
        title="Get dressed",
        icon="#giyin-happy",
        functionName = "giyin"
        },

    ["giyim:normal"]  = {
        title="T-shirt",
        icon="#giyim-tshirt",
        functionName = "tshirt"
    }
}


function GetPlayers()
    local players = {}

    for i = 0, 32 do
        if NetworkIsPlayerActive(i) then
            players[#players+1]= i
        end
    end

    return players
end

function GetClosestPlayer()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local closestPed = -1
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply, 0)
    if not IsPedInAnyVehicle(PlayerPedId(), false) then
        for index,value in ipairs(players) do
            local target = GetPlayerPed(value)
            if(target ~= ply) then
                local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
                local distance = #(vector3(targetCoords["x"], targetCoords["y"], targetCoords["z"]) - vector3(plyCoords["x"], plyCoords["y"], plyCoords["z"]))
                if(closestDistance == -1 or closestDistance > distance) and not IsPedInAnyVehicle(target, false) then
                    closestPlayer = value
                    closestPed = target
                    closestDistance = distance
                end
            end
        end
        return closestPlayer, closestDistance, closestPed
    end
end

RegisterNetEvent('tshirt')
AddEventHandler('tshirt', function()  
    TriggerEvent('skinchanger:getSkin', function(skin)
        local playerPed = GetPlayerPed(-1)

        RequestAnimDict('clothingshirt')
        while not HasAnimDictLoaded('clothingshirt') do
            Citizen.Wait(1)
        end

        TaskPlayAnim(playerPed, "clothingshirt", "check_out_b", 3.5, -8, -1, 49, 0, 0, 0, 0) 
        Citizen.Wait(3500)
        ClearPedTasks(playerPed)


        local clothesSkin = {
        ['tshirt_1'] = 15, ['tshirt_2'] = 0,
        ['torso_1'] = 15, ['torso_2'] = 0,
        ['arms'] = 15, ['arms_2'] = 0
        }
        TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
    end)
end)


    Citizen.CreateThread(function(job, name)
        while true do
    
            Citizen.Wait(0)

    if isMedic and job ~= "ems" then isMedic = false end
    if isPolice and ESX.PlayerData.job and ESX.PlayerData.job.name ~= 'police' then isPolice = false end
    if isTaksi and ESX.PlayerData.job and ESX.PlayerData.job.name ~= 'taxi' then isTaksi = false end
    if isMechanic and ESX.PlayerData.job and ESX.PlayerData.job.name ~= 'mechanic' then isMechanic = false end

    if isDoctor and job ~= "doctor" then isDoctor = false end
    if isNews and job ~= "news" then isNews = false end
    if  ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then isPolice = true end
    if  ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'ambulance' then isMedic = true end
    if  ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'taxi' then isTaksi = true end
    if  ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'mechanic' then isMechanic = true end

    if job == "news" then isNews = true end
    if  ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'ambulance' then isDoctor = true end
        end
end)

RegisterNetEvent('pd:deathcheck')
AddEventHandler('pd:deathcheck', function()
    if not isDead then
        isDead = true
    else
        isDead = false
    end
end)



function GetPlayers()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            players[#players+1]= i
        end
    end

    return players
end


RegisterNetEvent('mask')
AddEventHandler('mask', function()
    local playerPed = GetPlayerPed(-1)

    RequestAnimDict('misscommon@std_take_off_masks')
    while not HasAnimDictLoaded('misscommon@std_take_off_masks') do
        Citizen.Wait(1)
    end

    RequestAnimDict('mp_masks@on_foot')
    while not HasAnimDictLoaded('mp_masks@on_foot') do
        Citizen.Wait(1)
    end

    if not mask then
    mask = true
    MaskDrawable, MaskTexture, MaskPalette = GetPedDrawableVariation(playerPed, 1), GetPedTextureVariation(playerPed, 1), GetPedPaletteVariation(playerPed, 1)
    TaskPlayAnim(playerPed, "misscommon@std_take_off_masks", "take_off_mask_rps", 3.5, -8, -1, 49, 0, 0, 0, 0)
    Citizen.Wait(1000)
    SetPedComponentVariation(playerPed, 1, 0, 0, MaskPalette)
    ClearPedTasks(playerPed)
end
end)



RegisterNetEvent('helmet')
AddEventHandler('helmet', function() 
       local playerPed = GetPlayerPed(-1)

    RequestAnimDict('veh@common@fp_helmet@')
    while not HasAnimDictLoaded('veh@common@fp_helmet@') do
        Citizen.Wait(1)
    end

    RequestAnimDict('missheistdockssetup1hardhat@')
    while not HasAnimDictLoaded('missheistdockssetup1hardhat@') do
        Citizen.Wait(1)
    end

    if not hat then 
    hat = true
    HatDrawable, HatTexture = GetPedPropIndex(playerPed, 0), GetPedPropTextureIndex(playerPed, 0)
    TaskPlayAnim(playerPed, "veh@common@fp_helmet@", "take_off_helmet_stand", 3.5, -8, -1, 49, 0, 0, 0, 0)
    Citizen.Wait(800)
    ClearPedProp(playerPed, 0)
    Citizen.Wait(400)
    ClearPedTasks(playerPed)
end
end)

RegisterNetEvent('canta')
AddEventHandler('canta', function()  
    local playerPed = GetPlayerPed(-1)

    RequestAnimDict('missclothing')
    while not HasAnimDictLoaded('missclothing') do
        Citizen.Wait(1)
    end

    if not ryg then
    ryg = true
    rygDrawable, rygTexture, rygPalette = GetPedDrawableVariation(playerPed, 5), GetPedTextureVariation(playerPed, 5), GetPedPaletteVariation(playerPed, 5)
    TaskPlayAnim(playerPed, "missclothing", "wait_choice_a_storeclerk", 3.5, -8, -1, 49, 0, 0, 0, 0)
    Citizen.Wait(3000)
    SetPedComponentVariation(playerPed, 5, 0, 0, rygPalette)
    ClearPedTasks(playerPed)
else 
    ryg = false
    TaskPlayAnim(playerPed, "missclothing", "wait_choice_a_storeclerk", 3.5, -8, -1, 49, 0, 0, 0, 0) 
    Citizen.Wait(3000)
    SetPedComponentVariation(playerPed, 5, rygDrawable, rygTexture, rygPalette)
    ClearPedTasks(playerPed)
end
end)


    RegisterNetEvent('tshirt')
AddEventHandler('tshirt', function()  
    TriggerEvent('skinchanger:getSkin', function(skin)
        local playerPed = GetPlayerPed(-1)

        RequestAnimDict('clothingshirt')
        while not HasAnimDictLoaded('clothingshirt') do
            Citizen.Wait(1)
        end

        TaskPlayAnim(playerPed, "clothingshirt", "check_out_b", 3.5, -8, -1, 49, 0, 0, 0, 0) 
        Citizen.Wait(3500)
        ClearPedTasks(playerPed)


        local clothesSkin = {
        ['tshirt_1'] = 15, ['tshirt_2'] = 0,
        ['torso_1'] = 15, ['torso_2'] = 0,
        ['arms'] = 15, ['arms_2'] = 0
        }
        TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
    end)
end)


RegisterNetEvent('AracBagla')
AddEventHandler('AracBagla', function()
    local playerPed = PlayerPedId()
    local vehicle   = ESX.Game.GetVehicleInDirection()
    
    TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)

     Citizen.Wait(10000)
     TriggerEvent('pogressBar:drawBar', 10000, 'Aracı bağlıyorsun.')

     ClearPedTasksImmediately(playerPed)

    if IsPedInAnyVehicle(playerPed, true) then
        vehicle = GetVehiclePedIsIn(playerPed, false)
    end

    if DoesEntityExist(vehicle) then
        ESX.Game.DeleteVehicle(vehicle)
        Citizen.Wait(10000)
    end
end)



RegisterNetEvent('pantolon')
AddEventHandler('pantolon', function() 
        TriggerEvent('skinchanger:getSkin', function(skin)
    
        local playerPed = GetPlayerPed(-1)

        RequestAnimDict('clothingtrousers')
        while not HasAnimDictLoaded('clothingtrousers') do
            Citizen.Wait(1)
        end
        TaskPlayAnim(playerPed, "clothingtrousers", "try_trousers_negative_a", 3.5, -8, -1, 49, 0, 0, 0, 0) 
        Citizen.Wait(3000)
        ClearPedTasks(playerPed)
        local clothesSkin = {
        ['pants_1'] = 21, ['pants_2'] = 0
        }
        TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
    end)
end)

RegisterNetEvent('ayakkabı')
AddEventHandler('ayakkabı', function() 
    TriggerEvent('skinchanger:getSkin', function(skin)
        local playerPed = GetPlayerPed(-1)

        RequestAnimDict('clothingshoes')
        while not HasAnimDictLoaded('clothingshoes') do
            Citizen.Wait(1)
        end
        TaskPlayAnim(playerPed, "clothingshoes", "check_out_a", 3.5, -8, -1, 49, 0, 0, 0, 0) 
        Citizen.Wait(2500)
        ClearPedTasks(playerPed)    

        local clothesSkin = {
        ['shoes_1'] = 34, ['shoes_2'] = 0
        }
        TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
    end)
end)


RegisterNetEvent('giyin')
AddEventHandler('giyin', function() 
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
        TriggerEvent('skinchanger:loadSkin', skin)
        end)

end)

function AracKilit()
    local playerPed = PlayerPedId()

    local coords  = GetEntityCoords(playerPed)
  local  vehicle = ESX.Game.GetVehicleInDirection()

if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.0) then
    TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)
    Citizen.Wait(20000)
    TriggerEvent('pogressBar:drawBar', 20000, 'Araç kilidini açıyorsun.')

    ClearPedTasksImmediately(playerPed)

    SetVehicleDoorsLocked(vehicle, 1)
    SetVehicleDoorsLockedForAllPlayers(vehicle, false)
    ESX.ShowNotification("Araç Açıldı")
end
end

RegisterNetEvent('AracKilit')
AddEventHandler('AracKilit', function()
AracKilit()

end)
