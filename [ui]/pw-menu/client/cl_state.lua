CurrentJob = nil
isJudge = false
isDoctor = false
isNews = false
isInstructorMode = false
myJob = "unemployed"
isHandcuffed = false
isHandcuffedAndWalking = false
isEscorting = false
hasOxygenTankOn = false
IN_SERVER_FARM = false
cuffStates = {}
ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
	CurrentJob = ESX.PlayerData.job.name
	job = ESX.PlayerData.job.name
	if isMedic and job ~= "ambulance" then isMedic = false end
    if isPolice and job ~= "police" then isPolice = false end
    if isDoc and job ~= "ambulance" then isDoc = false end
    if isDoctor and job ~= "doctor" then isDoctor = false end
    if isNews and job ~= "news" then isNews = false end
    if isMayor and job ~= "mayor" then isMayor = false end
    if isCountyClerk and job ~= "county_clerk" then isCountyClerk = false end
    if job == "police" then isPolice = true end
    if job == "ambulance" then isMedic = true end
    if job == "news" then isNews = true end
    if job == "ambulance" then isDoctor = true end
    if job == "ambulance" then isDoc = true end
    if job == "mayor" then isMayor = true end
    if job == "county_clerk" then isCountyClerk = true end
end)

polyChecks = {
    vanillaUnicorn = { isInside = false, data = nil },
    gasStation = { isInside = false, data = nil },
    bennys = { isInside = false, data = nil },
    townhallCourtGavel = { isInside = false, data = nil },
    prison = { isInside = false, data = nil },
    police = { isInside = false, data = nil },
}

isDoc = false
isPolice = false
isMedic = false
isMayor = false
isCountyClerk = false
isDead = false
isPrisoner = false
isInfected = false
isOutbreakRunning = false

function IsDisabled()
    return isDead or isHandcuffed or isHandcuffedAndWalking
end

function GetBoneDistance(pEntity, pType, pBone)
    local bone

    if pType == 1 then
        bone = GetPedBoneIndex(pEntity, pBone)
    else
        bone = GetEntityBoneIndexByName(pEntity, pBone)
    end

    local boneCoords = GetWorldPositionOfEntityBone(pEntity, bone)
    local playerCoords = GetEntityCoords(PlayerPedId())

    return #(boneCoords - playerCoords)
end

exports("GetBoneDistance", GetBoneDistance)

function HasWeaponEquipped(pWeaponHash)
    return GetSelectedPedWeapon(PlayerPedId()) == pWeaponHash
end

RegisterNetEvent("menu:setCuffState")
AddEventHandler("menu:setCuffState", function(pTargetId, pState)
    cuffStates[pTargetId] = pState
end)

RegisterNetEvent("isJudge")
AddEventHandler("isJudge", function()
    isJudge = true
end)

RegisterNetEvent("isJudgeOff")
AddEventHandler("isJudgeOff", function()
    isJudge = false
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(jobn)
	local job = jobn.name
    if isMedic and job ~= "ambulance" then isMedic = false end
    if isPolice and job ~= "police" then isPolice = false end
    if isDoc and job ~= "ambulance" then isDoc = false end
    if isDoctor and job ~= "ambulance" then isDoctor = false end
    if isNews and job ~= "news" then isNews = false end
    if isMayor and job ~= "mayor" then isMayor = false end
    if isCountyClerk and job ~= "county_clerk" then isCountyClerk = false end
    if job == "police" then isPolice = true end
    if job == "ambulance" then isMedic = true end
    if job == "news" then isNews = true end
    if job == "ambulance" then isDoctor = true end
    if job == "ambulance" then isDoc = true end
    if job == "mayor" then isMayor = true end
    if job == "county_clerk" then isCountyClerk = true end
    myJob = job.name
end)


-- RegisterNetEvent('pd:deathcheck')
-- AddEventHandler('pd:deathcheck', function()
    -- if not isDead then
        -- isDead = true
    -- else
        -- isDead = false
    -- end
-- end)

RegisterNetEvent("drivingInstructor:instructorToggle")
AddEventHandler("drivingInstructor:instructorToggle", function(mode)
    isInstructorMode = mode
end)

RegisterNetEvent("np-police:cuffs:state")
AddEventHandler("np-police:cuffs:state", function(pIsHandcuffed, pIsHandcuffedAndWalking)
    isHandcuffedAndWalking = pIsHandcuffedAndWalking
    isHandcuffed = pIsHandcuffed
end)

RegisterNetEvent("menu:hasOxygenTank")
AddEventHandler("menu:hasOxygenTank", function(pHasOxygenTank)
    hasOxygenTankOn = pHasOxygenTank
end)

RegisterNetEvent('pw-police:escort')
AddEventHandler('pw-police:escort', function()
    isEscorting = true
end)

RegisterNetEvent('pw-police:unescort')
AddEventHandler('pw-police:unescort', function()
    isEscorting = false
end)

AddEventHandler("pw-polyzone:enter", function(zone, data)
    if zone == "np-jobs:impound:dropOff" then IsImpoundDropOff = true end
    if zone == "vanilla_unicorn_stage" then polyChecks.vanillaUnicorn = { isInside = true, polyData = data } end
    if zone == "gas_station" then polyChecks.gasStation = { isInside = true, polyData = data } end
	if zone == "scrap_yard" then polyChecks.scrapYard = { isInside = true, polyData = data } end
    if zone == "bennys" then
        local plyPed = PlayerPedId()

        if data and data.type == "boats" and not (IsPedInAnyBoat(plyPed) or IsPedInAnySub(plyPed)) then
            return
        end
        if data and data.type == "planes" and not (IsPedInAnyPlane(plyPed) or IsPedInAnyHeli(plyPed)) then
            return
        end

        polyChecks.bennys = { isInside = true, polyData = data }
    end
    if zone == "townhall_court_gavel" then polyChecks.townhallCourtGavel = { isInside = true, polyData = nil } end
    if zone == "np-jail:prison" then polyChecks.prison = { isInside = true, polyData = nil } end
    if zone == "police_station" then polyChecks.police = { isInside = true, polyData = nil } end
end)

AddEventHandler("pw-polyzone:exit", function(zone)
    if zone == "vanilla_unicorn_stage" then polyChecks.vanillaUnicorn = { isInside = false, polyData = nil } end
    if zone == "gas_station" then polyChecks.gasStation = { isInside = false, polyData = nil } end
	if zone == "scrap_yard" then polyChecks.scrapYard = { isInside = false, polyData = data } end
    if zone == "bennys" then polyChecks.bennys = { isInside = false, polyData = nil } end
    if zone == "townhall_court_gavel" then polyChecks.townhallCourtGavel = { isInside = false, polyData = nil } end
    if zone == "np-jail:prison" then polyChecks.prison = { isInside = false, polyData = nil } end
    if zone == "police_station" then polyChecks.police = { isInside = false, polyData = nil } end
end)

AddEventHandler("np-jail:playerJailed", function()
    isPrisoner = true
end)

AddEventHandler("np-jail:playerUnjailed", function()
    isPrisoner = false
end)

AddEventHandler("np-outbreak:setTurnedStatus", function (pStatus)
    isInfected = pStatus
end)

AddEventHandler("pw-menu:setOutbreakState", function (pState)
    isOutbreakRunning = pState
end)
