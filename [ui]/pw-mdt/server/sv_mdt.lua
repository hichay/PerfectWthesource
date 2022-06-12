ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local usersRadios = {}
local penalCode = {}
local penalCodeCategorys = {}



function getJob(src)
    local xPlayer = ESX.GetPlayerFromId(src)

    if xPlayer.getJob().name == 'police' then
        return "police"
    elseif xPlayer.getJob().name == 'ambulance' then
        return "ems"
    elseif xPlayer.getJob().name == 'doc' then
        return "doj"
    elseif xPlayer.getJob().name == 'sheriff' then
        return "sheriff"
    end

    return "unemployed"
end

local CallSigns = {}
function GetCallsign(id)
    local result = MySQL.query.await([[SELECT callsign FROM users WHERE id = ?]], { id })
    if result[1] ~= nil and result[1].callsign ~= nil then
         return result[1].callsign
    else
        return 0
    end
end

RPC.register("pw-mdt:dashboardBulletin", function(src)
    local job = getJob(src)

    local result = MySQL.query.await([[
        SELECT b.id, b.title, b.description, b.time, CONCAT(c.firstname," ",c.lastname) AS author
        FROM mdt_bulletins b
        LEFT JOIN users c ON c.id = b.cid
        WHERE b.job = ?
    ]],
    { job })

    return result
end)

RegisterServerEvent("pw-mdt:newBulletin")
AddEventHandler("pw-mdt:newBulletin", function(title, info, time)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local cid = xPlayer.id
    local name = xPlayer.getName()
    local job = getJob(src)

	local insertId = MySQL.insert.await([[
        INSERT INTO mdt_bulletins (cid, title, description, job, time)
        VALUES (?, ?, ?, ?, ?)
    ]],
    { cid, title, info, job, time })

    if not insertId or insertId < 1 then return end

    local bulletin = {
        id = insertId,
        title = title,
        info = info,
        time = time,
        author = name
    }

    TriggerClientEvent("pw-mdt:newBulletin", -1, src, bulletin, job)
    TriggerEvent("pw-mdt:newLog", name .. " Opened a new Bulletin: Title " .. title .. ", Info " .. info, job, time)
end)

RegisterServerEvent("pw-mdt:deleteBulletin")
AddEventHandler("pw-mdt:deleteBulletin", function(id)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local name = xPlayer.getName()
    local job = getJob(src)

    local title = MySQL.scalar.await([[
        SELECT title
        FROM mdt_bulletins
        WHERE id = ?
    ]],
    { id })

    MySQL.update.await([[
        DELETE FROM mdt_bulletins
        WHERE id = ?
    ]],
    { id })

    TriggerClientEvent("pw-mdt:deleteBulletin", -1, src, id, job)
    TriggerEvent("pw-mdt:newLog", "A bulletin was deleted by " .. name .. " with the title: " .. title .. "!", job)
end)

--[[

    Messages

]]

RPC.register("pw-mdt:dashboardMessages", function(src)
    local job = getJob(src)

    local result = MySQL.query.await([[
        SELECT m.message, m.time, CONCAT(c.firstname," ",c.lastname) AS author, c.sex, p.image
        FROM mdt_messages m
        LEFT JOIN users c ON c.id = m.cid
        LEFT JOIN mdt_profiles p ON p.cid = m.cid
        WHERE m.job = ?
        ORDER BY m.id DESC
        LIMIT 50
    ]],
    { job })

    for i, v in ipairs(result) do
        result[i].image = profilePic(v.sex, v.image)
    end

    return result
end)

RegisterServerEvent("pw-mdt:refreshDispatchMsgs")
AddEventHandler("pw-mdt:refreshDispatchMsgs", function()
    local src = source

    local job = getJob(src)

    local result = MySQL.query.await([[
        SELECT message, time, CONCAT(c.firstname," ",c.lastname) AS name, c.sex, p.image
        FROM mdt_messages m
        LEFT JOIN users c ON c.id = m.cid
        LEFT JOIN mdt_profiles p ON p.cid = m.cid
        WHERE m.job = ?
        ORDER BY m.id DESC
        LIMIT 50
    ]],
    { job })

    for i, v in ipairs(result) do
        result[i].image = profilePic(v.sex, v.image)
    end

    TriggerClientEvent("pw-mdt:dashboardMessages", src, ReverseTable(result))
end)

RegisterServerEvent("pw-mdt:sendMessage")
AddEventHandler("pw-mdt:sendMessage", function(message, time)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local cid = xPlayer.id
    local name = xPlayer.getName()
    local job = getJob(src)
    local sex = MySQL.Sync.fetchScalar("SELECT `sex` FROM `users` WHERE `id` = '" .. cid .. "'")
    MySQL.insert.await([[
        INSERT INTO mdt_messages (cid, message, job, time)
        VALUES (?, ?, ?, ?)
    ]],
    { cid, message, job, time })

    local image = MySQL.scalar.await([[
        SELECT image
        FROM mdt_profiles
        WHERE cid = ?
    ]],
    { cid })

    local lastMsg = {
        name = name,
        image = profilePic(sex, image),
        message = message,
        time = time,
    }

    TriggerClientEvent("pw-mdt:dashboardMessage", -1, lastMsg, job)
end)

--[[

    Units

]]

RPC.register("pw-mdt:getActiveUnits", function(src)
    local police, sheriff, state_police, park_ranger, ems, doj = {}, {}, {}, {}, {}, {}
    local PoliceList = ESX.GetExtendedPlayers("job","police")
    local EMSList = ESX.GetExtendedPlayers("job","ambulance")
    for k,v in pairs(PoliceList) do 
        local xPlayer = ESX.GetPlayerFromId(tonumber(k))
        if xPlayer then 
            local name = xPlayer.getName()
            local callSign = GetCallsign(xPlayer.id)
            police[#police + 1] = {
                duty = 1,
                cid = xPlayer.id,
                radio = usersRadios[xPlayer.id] or nil,
                callsign = callSign,
                name = name,
            }
        end
    end
    for k,v in pairs(EMSList) do 
        local xPlayer = ESX.GetPlayerFromId(tonumber(k))
        if xPlayer then 
            local name = xPlayer.getName()
            local callSign = GetCallsign(xPlayer.id)
            ems[#ems + 1] = {
                duty = 1,
                cid = xPlayer.id,
                radio = usersRadios[xPlayer.id] or nil,
                callsign = callSign,
                name = name,
            }
        end
    end

    return police, sheriff, state_police, park_ranger, ems, doj
end)

RegisterServerEvent("pw-mdt:setWaypoint:unit")
AddEventHandler("pw-mdt:setWaypoint:unit", function(cid)
    local src = source
    local player = ESX.GetPlayerFromIdCard(cid)
    if player == 0 then return end

    local coords = GetEntityCoords(GetPlayerPed(src))

    TriggerClientEvent("pw-mdt:setWaypoint:unit", src, coords)
end)

RegisterServerEvent("pw-mdt:setRadio")
AddEventHandler("pw-mdt:setRadio", function(radio)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local cid = xPlayer.id

    usersRadios[cid] = radio
end)

RegisterServerEvent("pw-mdt:setRadioTo")
AddEventHandler("pw-mdt:setRadioTo", function(cid, radio)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local target = ESX.GetPlayerFromIdCard(cid)
    if target == 0 then return end

    local name = xPlayer.getName()
    local nameTarget = target.getName()

    TriggerClientEvent("DoLongHudText", src, "A frequência de " .. nameTarget .. " foi setada para " .. radio)
    TriggerClientEvent("pw-mdt:setRadio", target, tonumber(radio), name)
end)

RegisterServerEvent("pw-mdt:setCallsign")
AddEventHandler("pw-mdt:setCallsign", function(cid, callsign)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local job = xPlayer.getJob().name

    exports["pw-jobs"]:setCallsign(cid, job, callsign)
end)

RegisterNetEvent("pw-mdt:toggleDuty")
AddEventHandler("pw-mdt:toggleDuty", function(cid, status)

end)

--[[

    Calls

]]

RPC.register("pw-mdt:getCalls", function(src, pCallId)
    local src = source

    local calls = exports["pw-dispatch"]:getCalls()

    return calls
end)

RegisterNetEvent("pw-mdt:removeCall", function(pCallId)
    local src = source

    local removed = exports["pw-dispatch"]:removeCall(pCallId)
    if removed then
        TriggerClientEvent("pw-mdt:removeCall", -1, pCallId)
    end
end)

RegisterServerEvent("pw-mdt:callAttach")
AddEventHandler("pw-mdt:callAttach", function(callid)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local units = exports["pw-dispatch"]:addUnit(xPlayer.id, callid)

    TriggerClientEvent("pw-mdt:callAttach", -1, callid, units)
end)

RegisterServerEvent("pw-mdt:callDetach")
AddEventHandler("pw-mdt:callDetach", function(callid)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local units = exports["pw-dispatch"]:removeUnit(xPlayer.id, callid)

    TriggerClientEvent("pw-mdt:callDetach", -1, callid, units)
end)

RPC.register("pw-mdt:attachedUnits", function(src, pCallId)
    local src = source

    local units = exports["pw-dispatch"]:getUnits(pCallId)

    return units
end)

RegisterServerEvent("pw-mdt:callDragAttach")
AddEventHandler("pw-mdt:callDragAttach", function(callid, cid)
    local src = source
    local player = ESX.GetPlayerFromIdCard(cid)
    if player == 0 then return end

    local units = exports["pw-dispatch"]:addUnit(cid, callid)

    TriggerClientEvent("pw-mdt:callAttach", -1, callid, units)
end)

RegisterServerEvent("pw-mdt:callDispatchDetach")
AddEventHandler("pw-mdt:callDispatchDetach", function(callid, cid)
    local src = source
    local player = ESX.GetPlayerFromId(cid)
    if player == 0 then return end

    local units = exports["pw-dispatch"]:removeUnit(cid, callid)

    TriggerClientEvent("pw-mdt:callDetach", -1, callid, units)
end)

RegisterServerEvent("pw-mdt:setDispatchWaypoint")
AddEventHandler("pw-mdt:setDispatchWaypoint", function(callid, cid)
    local src = source
    local player = ESX.GetPlayerFromId(cid)
    if player == 0 then return end

    local coords = GetEntityCoords(GetPlayerPed(src))

    TriggerClientEvent("pw-mdt:setWaypoint:unit", src, coords)
end)

RegisterServerEvent("pw-mdt:getCallResponses")
AddEventHandler("pw-mdt:getCallResponses", function(callid)
    local src = source

    local responses = exports["pw-dispatch"]:getCallReponses(callid)

    TriggerClientEvent("pw-mdt:getCallResponses", src, responses, callid)
end)

RegisterServerEvent("pw-mdt:sendCallResponse")
AddEventHandler("pw-mdt:sendCallResponse", function(message, time, callid, name)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local name = xPlayer.getName()
    local responded = exports["pw-dispatch"]:sendCallResponse(name, callid, message, time)

    if responded then
        TriggerClientEvent("pw-mdt:sendCallResponse", src, message, time, callid, name)
    end
end)

--[[

    Warrants

]]

RPC.register("pw-mdt:getWarrants", function(src)
    local WarrantData = {}

    local result = MySQL.query.await([[
        SELECT *
        FROM mdt_incidents
    ]])

    for i, v in ipairs(result) do
        for i2, v2 in ipairs(json.decode(v.associated)) do
            if v2.warrant == true then
                local name = MySQL.scalar.await([[
                    SELECT CONCAT(firstname," ",lastname)
                    FROM users
                    WHERE id = ?
                ]],
                { v2.cid })

                table.insert(WarrantData, {
                    cid = v2.cid,
                    linkedincident = v.id,
                    name = name,
                    reporttitle = v.title,
                    time = v.time,
                })
            end
        end
    end

    return WarrantData
end)

--[[

    Profiles

]]

function profilePic(pGender, pImage)
	if pImage and pImage ~= "" then
        return pImage
    end

    if pGender == 1 then
        return "img/female.png"
    else
        return "img/male.png"
    end
end

RPC.register("pw-mdt:searchProfile", function(src, pName)
    local queryData = string.lower("%" .. pName .. "%")
    local result = MySQL.query.await([[
        SELECT c.id, c.firstname, c.lastname, c.sex, c.licenses, p.image, p.description
        FROM users c
        LEFT JOIN mdt_profiles p ON p.cid = c.id
        WHERE LOWER(c.firstname) LIKE ? OR LOWER(c.id) LIKE ? OR LOWER(c.lastname) LIKE ? OR CONCAT(LOWER(c.firstname), " ", LOWER(c.lastname), " ", LOWER(c.id)) LIKE ? OR LOWER(p.dna) LIKE ?
        ORDER BY c.firstname DESC
    ]],
    { queryData, queryData, queryData, queryData, queryData })

	for i, v in ipairs(result) do
        result[i].identifier  = v.id
        result[i].firstname = v.firstname
        result[i].lastname  = v.lastname
        result[i].policemdtinfo = v.description
        result[i].warrant = false
        result[i].convictions = 0
        result[i].cid = v.id

        result[i].pp = profilePic(result[i].sex, result[i].image)

        local licenses = json.decode(v.licenses)

        for k2, v2 in pairs(licenses) do
            if k2 == "weapon" and v2 == 1 then
                result[i].Weapon = true
            end
            if k2 == "driver" and v2 == 1 then
                result[i].Drivers = true
            end
            if k2 == "hunting" and v2 == 1 then
                result[i].Hunting = true
            end
            if k2 == "fishing" and v2 == 1 then
                result[i].Fishing = true
            end
            if k2 == "bar" and v2 == 1 then
                result[i].Bar = true
            end
            if k2 == "business" and v2 == 1 then
                result[i].Business = true
            end
            if k2 == "pilot" and v2 == 1 then
                result[i].Pilot = true
            end
        end
    end

	return result
end)

RPC.register("pw-mdt:getProfileData", function(src, pCid)

    local identifier = MySQL.Sync.fetchScalar("SELECT `identifier` FROM `users` WHERE `id` = '" .. pCid .. "'")
    local result = MySQL.query.await([[
        SELECT c.id, c.firstname, c.lastname, c.dateofbirth, c.phone, c.sex, c.job, c.licenses, p.dna, p.image, p.dna, p.description, p.tags, p.gallery
        FROM users c
        LEFT JOIN mdt_profiles p ON p.cid = c.id
        WHERE c.id = ?
    ]],
    { pCid })

    local vehicles = MySQL.query.await([[
        SELECT plate, model
        FROM owned_vehicles
        WHERE owner = ?
    ]],
    { identifier })

    local houses = MySQL.query.await([[
        SELECT id
        FROM allhousing
        WHERE owner = ?
    ]],
    { identifier })

    for i, v in ipairs(houses) do
        --local houseInfo = exports["pw-housing"]:getHouse(v.hid)
        houses[i] = {
            house_id = v.id
        }
    end

    local weapons = MySQL.query.await([[
        SELECT serial
        FROM mdt_weapons
        WHERE cid = ?
    ]],
    { pCid })

    for i, v in ipairs(weapons) do
        weapons[i] = v.serial
    end

    local incidents = MySQL.query.await([[
        SELECT associated
        FROM mdt_incidents
    ]])

    

    local object = {
        cid = result[1].id,
        firstname = result[1].firstname,
        lastname = result[1].lastname,
        job = result[1].job,
        dateofbirth = result[1]["dateofbirth"],
        phone = result[1]["phone"],
        dna = "Chưa ghi DNa",
        profilepic = profilePic(result[1].sex, result[1].image),
        policemdtinfo = "",
        Weapon = false,
        Drivers = false,
        Hunting = false,
        Fishing = false,
        Bar = false,
        Business = false,
        Pilot = false,
        tags = {},
        weapons = weapons,
        vehicles = vehicles,
        properties = houses,
        gallery = {},
        convictions = {}
    }

    if result[1].dna ~= nil then
        object.dna = result[1].dna
    end

    if result[1].description ~= nil then
        object.policemdtinfo = result[1].description
    end

    if result[1].tags ~= nil then
        object.tags = json.decode(result[1].tags)
    end

    if result[1].gallery ~= nil then
        object.gallery = json.decode(result[1].gallery)
    end

    

    local _charges = {}

    for i, v in ipairs(incidents) do
        for i2, v2 in ipairs(json.decode(v.associated)) do
            if v2.cid == result[1]["id"] then
                for i3, v3 in ipairs(v2.charges) do
                    if _charges[v3] then
                        _charges[v3] = _charges[v3] + 1
                    else
                        _charges[v3] = 1
                    end
                end
            end
        end
    end

    local charges = {}
    for charge, count in pairs(_charges) do
        table.insert(charges, count .. "x " .. charge)
    end

    object.convictions = charges

    local licenses = json.decode(result[1].licenses)
    for k, v in pairs(licenses) do
        if k == "weapon" and v == 1 then
            object.Weapon = true
        end
        if k == "driver" and v == 1 then
            object.Drivers = true
        end
        if k == "hunting" and v == 1 then
            object.Hunting = true
        end
        if k == "fishing" and v == 1 then
            object.Fishing = true
        end
        if k == "bar" and v == 1 then
            object.Bar = true
        end
        if k == "business" and v == 1 then
            object.Business = true
        end
        if k == "pilot" and v == 1 then
            object.Pilot = true
        end
    end
    
    return object
    
end)

RegisterServerEvent("pw-mdt:saveProfile")
AddEventHandler("pw-mdt:saveProfile", function(image, description, cid, fname, lname)
    if not cid then return end

    local src = source

    if not image then image = "" end
    if not description then description = "" end

    local result = MySQL.scalar.await([[
        SELECT id
        FROM mdt_profiles
        WHERE cid = ?
    ]],
    { cid })

	if result then
        MySQL.update.await([[
            UPDATE mdt_profiles
            SET image = ?, description = ?
            WHERE cid = ?
        ]],
        { image, description, cid })
	else
		MySQL.insert.await([[
            INSERT INTO mdt_profiles (cid, image, description, tags, gallery)
            VALUES (?, ?, ?, ?, ?)
        ]],
        { cid, image, description, "{}", "{}" })
	end
end)

RegisterServerEvent("pw-mdt:updateLicense")
AddEventHandler("pw-mdt:updateLicense", function(identifier, type, status)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local name = xPlayer.getName()
    local time = os.date()

    if status == "revoke" then
        action = "Revoked"
        status = 0
    else
        action = "Given"
        status = 1
    end

    TriggerEvent("pw-mdt:newLog", name .. " " .. action .. " licenses type: " .. (type:gsub("^%l", string.upper)) .. " Edited Citizen Id: " .. identifier, time)

    exports["pw-licenses"]:updateLicense(0, type, status, identifier)
end)

RegisterServerEvent("pw-mdt:newTag")
AddEventHandler("pw-mdt:newTag", function(cid, tag)
    local result = MySQL.scalar.await([[
        SELECT tags
        FROM mdt_profiles
        WHERE cid = ?
    ]],
    { cid })

    if result then
        local tags = json.decode(result)

        table.insert(tags, tag)

        MySQL.update.await([[
            UPDATE mdt_profiles
            SET tags = ?
            WHERE cid = ?
        ]],
        { json.encode(tags), cid })
    else
        local tags = {}

        table.insert(tags, tag)

        MySQL.insert.await([[
            INSERT INTO mdt_profiles (cid, image, description, tags, gallery)
            VALUES (?, ?, ?, ?, ?)
        ]],
        { cid, "", "", json.encode(tags), "{}" })
    end
end)

RegisterServerEvent("pw-mdt:removeProfileTag")
AddEventHandler("pw-mdt:removeProfileTag", function(cid, tag)
    local result = MySQL.scalar.await([[
        SELECT tags
        FROM mdt_profiles
        WHERE cid = ?
    ]],
    { cid })

    if result then
        local tags = json.decode(result)

        for i, v in ipairs(tags) do
            if v == tag then
                table.remove(tags, i)
            end
        end

        MySQL.update.await([[
            UPDATE mdt_profiles
            SET tags = ?
            WHERE cid = ?
        ]],
        { json.encode(tags), cid })
    end
end)

RegisterServerEvent("pw-mdt:addGalleryImg")
AddEventHandler("pw-mdt:addGalleryImg", function(cid, url)
    local result = MySQL.scalar.await([[
        SELECT gallery
        FROM mdt_profiles
        WHERE cid = ?
    ]],
    { cid })

    if result then
        local gallery = json.decode(result)

        table.insert(gallery, url)

        MySQL.update.await([[
            UPDATE mdt_profiles
            SET gallery = ?
            WHERE cid = ?
        ]],
        { json.encode(gallery), cid })
    else
        local gallery = {}

        table.insert(gallery, url)

        MySQL.insert.await([[
            INSERT INTO mdt_profiles (cid, image, description, tags, gallery)
            VALUES (?, ?, ?, ?, ?)
        ]],
        { cid, "", "", "{}", json.encode(gallery) })
    end
end)

RegisterServerEvent("pw-mdt:removeGalleryImg")
AddEventHandler("pw-mdt:removeGalleryImg", function(cid, url)
    local result = MySQL.scalar.await([[
        SELECT gallery
        FROM mdt_profiles
        WHERE cid = ?
    ]],
    { cid })

    if result then
        local gallery = json.decode(result)

        for i, v in ipairs(gallery) do
            if v == url then
                table.remove(gallery, i)
            end
        end

        MySQL.update.await([[
            UPDATE mdt_profiles
            SET gallery = ?
            WHERE cid = ?
        ]],
        { json.encode(gallery), cid })
    end
end)

RegisterNetEvent("pw-mdt:dnaEdit", function(cid, dna)
    local result = MySQL.scalar.await([[
        SELECT cid
        FROM mdt_profiles
        WHERE cid = ?
    ]],
    { cid })

    if result then
        MySQL.update.await([[
            UPDATE mdt_profiles
            SET dna = ?
            WHERE cid = ?
        ]],
        { dna, cid })
    else
        MySQL.insert.await([[
            INSERT INTO mdt_profiles (cid, image, description, tags, gallery, dna)
            VALUES (?, ?, ?, ?, ?, ?)
        ]],
        { cid, "", "", "{}", "{}", dna })
    end
end)

--[[

    Incidents

]]

RPC.register("pw-mdt:getAllIncidents", function(src)
    local job = getJob(src)

    local result = MySQL.query.await([[
        SELECT i.id, i.title, i.time, i.job, CONCAT(c.firstname," ",c.lastname) AS author
        FROM mdt_incidents i
        LEFT JOIN users c ON c.id = i.cid
        WHERE i.job = ?
    ]],
    { job })

    return result
end)

RPC.register("pw-mdt:searchIncidents", function(src, pId)
    local job = getJob(src)

    local result = MySQL.query.await([[
        SELECT i.id, i.title, i.time, i.job, CONCAT(c.firstname," ",c.lastname) AS author
        FROM mdt_incidents i
        LEFT JOIN users c ON c.id = i.cid
        WHERE i.id = ? AND i.job = ?
    ]],
    { tonumber(pId), job })

    return result
end)

RPC.register("pw-mdt:getIncidentData", function(src, pId)
    local incident = MySQL.single.await([[
        SELECT *
        FROM mdt_incidents
        WHERE id = ?
    ]],
    { tonumber(pId) })

    incident.tags = json.decode(incident.tags)
    incident.officers = json.decode(incident.officers)
    incident.civilians = json.decode(incident.civilians)
    incident.evidence = json.decode(incident.evidence)
    incident.charges = json.decode(incident.associated.charges)
    incident.associated = json.decode(incident.associated)

    for i, v in ipairs(incident.associated) do
        local name = MySQL.scalar.await([[
            SELECT CONCAT(firstname," ",lastname)
            FROM users
            WHERE id = ?
        ]],
        { v.cid })

        incident.associated[i].name = name
    end

    return incident, incident.associated
end)

RPC.register("pw-mdt:incidentSearchPerson", function(src, pName)
    local queryData = string.lower("%" .. pName .. "%")
    local result = MySQL.query.await([[
        SELECT c.id, c.firstname, c.lastname, c.sex, p.image
        FROM users c
        LEFT JOIN mdt_profiles p ON p.cid = c.id
        WHERE LOWER(c.firstname) LIKE ? OR LOWER(c.id) LIKE ? OR LOWER(c.lastname) LIKE ? OR CONCAT(LOWER(c.firstname), " ", LOWER(c.lastname), " ", LOWER(c.id)) LIKE ?
        ORDER BY c.firstname DESC
    ]],
    { queryData, queryData, queryData, queryData })

    for i, v in pairs(result) do
		result[i].image = profilePic(v.gender, v.image)
	end
    return result
end)

RPC.register("pw-mdt:getPenalCode", function(src)
    local xPlayer = ESX.GetPlayerFromId(src)
    return penalCodeCategorys, penalCode, xPlayer.getJob().name
end)

RegisterServerEvent("pw-mdt:saveIncident")
AddEventHandler("pw-mdt:saveIncident", function(data)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local cid = xPlayer.id

    if data.ID ~= 0 then
        MySQL.update.await([[
            UPDATE mdt_incidents
            SET cid = ?, title = ?, details = ?, tags = ?, officers = ?, civilians = ?, evidence = ?, associated = ?, time = ?
            WHERE id = ?
        ]],
        { cid, data.title, data.information, json.encode(data.tags), json.encode(data.officers), json.encode(data.civilians), json.encode(data.evidence), json.encode(data.associated), data.time, data.ID })
    else
        MySQL.insert.await([[
            INSERT INTO mdt_incidents (cid, title, details, tags, officers, civilians, evidence, associated, time)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
        ]],
        { cid, data.title, data.information, json.encode(data.tags), json.encode(data.officers), json.encode(data.civilians), json.encode(data.evidence), json.encode(data.associated), data.time })
    end
end)

RegisterServerEvent("pw-mdt:removeIncidentCriminal")
AddEventHandler("pw-mdt:removeIncidentCriminal", function(cid, incident)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local name = xPlayer.getName()

    local result = MySQL.scalar.await([[
        SELECT associated
        FROM mdt_incidents
        WHERE id = ?
    ]],
    { incident })

    local criminal_name = ""
    local result = json.decode(result)

    for i, v in ipairs(result) do
        if v.cid == cid then
            criminal_name = MySQL.scalar.await([[
                SELECT CONCAT(firstname," ",lastname)
                FROM users
                WHERE id = ?
            ]],
            { cid })

            table.remove(result, i)
        end
    end

    TriggerEvent("pw-mdt:newLog", name .. ", Removed a criminal from an incident, incident ID: " .. incident .. ", Criminal Citizen Id: " .. cid .. ", Name: " .. criminal_name, "police")
    TriggerEvent("pw-mdt:newLog", name .. ", Removed a criminal from an incident, incident ID: " .. incident .. ", Criminal Citizen Id: " .. cid .. ", Name: " .. criminal_name, "doj")

    MySQL.update.await([[
        UPDATE mdt_incidents
        SET associated = ?
        WHERE id = ?
    ]],
    { json.encode(result), incident })
end)

RegisterServerEvent("pw-mdt:deleteIncident")
AddEventHandler("pw-mdt:deleteIncident", function(pId, pTime)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local name = xPlayer.getName()
    local job = getJob(src)

    MySQL.update.await([[
        DELETE FROM mdt_incidents
        WHERE id = ?
    ]],
    { pId })

    TriggerEvent("pw-mdt:newLog", "A Incident was deleted by " .. name .. " with the ID (" .. pId .. ")", job, pTime)
end)

--[[

    Reports

]]

RPC.register("pw-mdt:searchReports", function(src, pData)
    local job = getJob(src)

    local string = string.lower("%" .. pData .. "%")

    local result = MySQL.query.await([[
        SELECT r.id, r.title, r.type, r.time, CONCAT(c.firstname," ",c.lastname) AS author
        FROM mdt_reports r
        LEFT JOIN users c ON c.id = r.cid
        WHERE (LOWER(r.type) LIKE ? OR LOWER(r.title) LIKE ? OR LOWER(r.id) LIKE ? OR CONCAT(LOWER(r.type), " ", LOWER(r.title), " ", LOWER(r.id)) LIKE ?) AND r.job = ?
    ]],
    { string, string, string, string, job })

    return result
end)

RPC.register("pw-mdt:getReportData", function(src, pId)
    local report = MySQL.single.await([[
        SELECT *
        FROM mdt_reports
        WHERE id = ?
    ]],
    { pId })

    report.tags = json.decode(report.tags)
    report.gallery = json.decode(report.gallery)
    report.officers = json.decode(report.officers)
    report.civilians = json.decode(report.civilians)

    return report
end)

RegisterNetEvent("pw-mdt:newReport", function(pData)
    local src = source

    if pData.title == "" then return end
    local xPlayer = ESX.GetPlayerFromId(source)
    local cid = xPlayer.id
    local name = xPlayer.getName()
    local job = getJob(src)

    if pData.existing then
        MySQL.update.await([[
            UPDATE mdt_reports
            SET cid = ?, title = ?, type = ?, detail = ?, tags = ?, gallery = ?, officers = ?, civilians = ?, time = ?
            WHERE id = ?
        ]],
        { cid, pData.title, pData.type, pData.detail, json.encode(pData.tags), json.encode(pData.gallery), json.encode(pData.officers), json.encode(pData.civilians), pData.time, pData.id })

        TriggerEvent("pw-mdt:newLog", "A report was updated by " .. name .. " with the title (" .. pData.title .. ") and ID (" .. pData.id .. ")", job, pData.time)
    else
        local insertId = MySQL.insert.await([[
            INSERT INTO mdt_reports (cid, title, type, detail, tags, gallery, officers, civilians, job, time)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        ]],
        { cid, pData.title, pData.type, pData.detail, json.encode(pData.tags), json.encode(pData.gallery), json.encode(pData.officers), json.encode(pData.civilians), job, pData.time })

        if insertId and insertId > 0 then
            TriggerClientEvent("pw-mdt:reportComplete", src, insertId)
            TriggerEvent("pw-mdt:newLog", "A new report was created by " .. name .. " with the title (" .. pData.title .. ") and ID (" .. insertId .. ")", job, pData.time)
        end
    end
end)

RegisterNetEvent("pw-mdt:deleteReport", function(pId, pTime)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local name = xPlayer.getName()
    local job = getJob(src)

    MySQL.update.await([[
        DELETE FROM mdt_reports
        WHERE id = ?
    ]],
    { pId })

    TriggerEvent("pw-mdt:newLog", "A Report was deleted by " .. name .. " with the ID (" .. pId .. ")", job, pTime)
end)

--[[

    BOLOs

]]

RPC.register("pw-mdt:searchBolos", function(src, pData)
    local job = getJob(src)

    local string = string.lower("%" .. pData .. "%")

    local result = MySQL.query.await([[
        SELECT b.id, b.title, b.time, CONCAT(c.firstname," ",c.lastname) AS author
        FROM mdt_bolos b
        LEFT JOIN users c ON c.id = b.cid
        WHERE (LOWER(b.plate) LIKE ? OR LOWER(b.title) LIKE ? OR CONCAT(LOWER(b.plate), " ", LOWER(b.title)) LIKE ?) AND b.job = ?
    ]],
    { string, string, string, job })

    return result
end)

RPC.register("pw-mdt:getBoloData", function(src, pId)
    local bolo = MySQL.single.await([[
        SELECT id, title, plate, owner, individual, detail, tags, gallery, officers
        FROM mdt_bolos
        WHERE id = ?
    ]],
    { pId })

    bolo.tags = json.decode(bolo.tags)
    bolo.gallery = json.decode(bolo.gallery)
    bolo.officers = json.decode(bolo.officers)

    return bolo
end)

RegisterServerEvent("pw-mdt:newBolo", function(data)
    local src = source

    if data.title == "" then return end
    local xPlayer = ESX.GetPlayerFromId(source)
    local cid = xPlayer.id
    local name = xPlayer.getName()
    local job = getJob(src)

    if data.id ~= nil and data.id ~= 0 then
        MySQL.update.await([[
            UPDATE mdt_bolos
            SET cid = ?, title = ?, plate = ?, owner = ?, individual = ?, detail = ?, tags = ?, gallery = ?, officers = ?, time = ?
            WHERE id = ?
        ]],
        { cid, data.title, data.plate, data.owner, data.individual, data.detail, json.encode(data.tags), json.encode(data.gallery), json.encode(data.officers), data.time, data.id })

        TriggerEvent("pw-mdt:newLog", "A BOLO was updated by " .. name .. " with the title (" .. data.title .. ") and ID (" .. data.id .. ")", job, data.time)
    else
        local insertId = MySQL.insert.await([[
            INSERT INTO mdt_bolos (cid, title, plate, owner, individual, detail, tags, gallery, officers, job, time)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        ]],
        { cid, data.title, data.plate, data.owner, data.individual, data.detail, json.encode(data.tags), json.encode(data.gallery), json.encode(data.officers), job, data.time})

        if insertId and insertId > 0 then
            TriggerClientEvent("pw-mdt:boloComplete", src, insertId)
            TriggerEvent("pw-mdt:newLog", "A new BOLO was created by " .. name .. " with the title (" .. data.title .. ") and ID (" .. insertId .. ")", job, data.time)
        end
    end
end)

RegisterServerEvent("pw-mdt:deleteBolo", function(id)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local name = xPlayer.getName()
    local job = getJob(src)

    MySQL.update.await([[
        DELETE FROM mdt_bolos
        WHERE id = ?
    ]],
    { id })

    TriggerEvent("pw-mdt:newLog", "A BOLO was deleted by " .. name .. " with the ID (" .. id .. ")", job)
end)

--[[

    DMV

]]

RPC.register("pw-mdt:searchVehicles", function(src, pPlate)
    local plate = string.lower("%" .. pPlate .. "%")

    local result = MySQL.query.await([[
        SELECT k.id, k.owner, k.plate, k.model, k.state, k.vehicle, m.image, m.code5, m.stolen
        FROM owned_vehicles k
        LEFT JOIN mdt_vehicles m ON m.plate = k.plate
        LEFT JOIN users c ON c.id = k.id
        WHERE LOWER(k.plate) LIKE ?
    ]],
    { plate })

    local vehicles = {}
    for i, v in ipairs(result) do
	
		--TriggerClientEvent('table',-1,result)
        --local xPlayer = ESX.GetPlayerFromIdentifier(v.owner)
		local beekep = MySQL.single.await('SELECT firstname, lastname FROM users WHERE identifier = ?', {v.owner})
        local _vehicle = {
            id = v.id,
            dbid = v.id,
            plate = v.plate,
            model = v.model,
            owner = beekep.firstname .." "..beekep.lastname,
            image = "img/not-found.jpg",
            color1 = 0,
            color2 = 0,
            code = false,
            stolen = false,
            bolo = false
        }

        if v.code5 ~= nil and v.code5 == 1 then _vehicle.code5 = true end
        if v.stolen ~= nil and v.stolen == 1 then _vehicle.stolen = true end

        if v.image and v.image ~= nil and v.image ~= "" then
            _vehicle.image = v.image
        end

        if v.vehicle then
            local _modifications = json.decode(v.vehicle)
            if _modifications["color1"] or _modifications["color2"] then
                _vehicle.color1 = _modifications["color1"]
                _vehicle.color2 = _modifications["color2"]
            end
        end

        local bolo = MySQL.scalar.await([[
            SELECT id
            FROM mdt_bolos
            WHERE plate = ?
            LIMIT 1
        ]],
        { v.plate })

        if bolo then
            _vehicle.bolo = true
        end

        --table.insert(vehicles, _vehicle)
		vehicles[#vehicles +1] = _vehicle
		
    end
	
	
	return vehicles

    
end)

RPC.register("pw-mdt:getVehicleData", function(src, pPlate)
    local result = MySQL.query.await([[
        SELECT v.id, v.owner, v.plate, v.model, v.state, v.vehicle, m.notes, m.image, m.code5, m.stolen
        FROM owned_vehicles v
        LEFT JOIN mdt_vehicles m ON m.plate = v.plate
        LEFT JOIN users c ON c.id = v.id
        WHERE v.plate = ?
    ]],
    { pPlate })


    local xPlayer = ESX.GetPlayerFromIdentifier(result[1].owner)
    local vehicle = {
        id = result[1].id,
        dbid = result[1].id,
        plate = result[1].plate,
        model = result[1].model,
        owner = xPlayer.getName(),
        notes = result[1].notes,
        image = "img/not-found.jpg",
        color1 = 0,
        color2 = 0,
        code5 = false,
        stolen = false,
        bolo = false
    }

    if result[1].code5 and result[1].code5 == 1 then vehicle.code5 = true end
    if result[1].stolen and result[1].stolen == 1 then vehicle.stolen = true end

    if result[1].image and result[1].image ~= nil and result[1].image ~= "" then
        vehicle.image = result[1].image
    end

    if result[1].vehicle then
        local _modifications = json.decode(result[1].vehicle)
        if _modifications["color1"] then
            vehicle.color1 = _modifications["color1"]
            vehicle.color2 = _modifications["color2"]
        end
    end

    local bolo = MySQL.scalar.await([[
        SELECT id
        FROM mdt_bolos
        WHERE plate = ?
        LIMIT 1
    ]],
    { result[1].plate })

    if bolo then
        vehicle.bolo = true
    end

    return vehicle
end)

RegisterNetEvent("pw-mdt:saveVehicleInfo", function(dbid, plate, image, notes)
	local src = source

    if dbid == 0 or plate == "" then return end

    if not image or imagev == "" then imageurl = "" end
	if not notes or notes == "" then notes = "" end

    local result = MySQL.scalar.await([[
        SELECT id
        FROM mdt_vehicles
        WHERE plate = ?
    ]],
    { plate })

    if result then
		MySQL.update.await([[
            UPDATE mdt_vehicles
            SET notes = ?, image = ?
            WHERE plate = ?
        ]],
        { notes, image, plate })
	else
		MySQL.insert.await([[
            INSERT INTO mdt_vehicles (plate, notes, image)
            VALUES (?, ?, ?, ?, ?)
        ]],
        { plate, notes, image })
	end
end)

RegisterNetEvent("pw-mdt:knownInformation", function(dbid, type, status, plate)
    local src = source

    local result = MySQL.scalar.await([[
        SELECT id
        FROM mdt_vehicles
        WHERE plate = ?
    ]],
    { plate })

    if result then
		MySQL.update.await([[
            UPDATE mdt_vehicles
            SET ?? = ?
            WHERE plate = ?
        ]],
        { type, status, plate })
	else
        MySQL.insert.await([[
            INSERT INTO mdt_vehicles (plate, notes, image, ??)
            VALUES (?, ?, ?, ?)
        ]],
        { type, plate, "", "", status })
	end
end)

--[[

    Weapons

]]

RPC.register("pw-mdt:searchWeapon", function(src, pData)
    local query = string.lower("%" .. pData .. "%")

    local result = MySQL.query.await([[
        SELECT w.id, w.cid, w.serial, w.image, CONCAT(c.firstname," ",c.lastname) AS owner
        FROM mdt_weapons w
        LEFT JOIN users c ON c.id = w.cid
        WHERE LOWER(w.serial) LIKE ?
    ]],
    { query })

    for i, v in ipairs(result) do
        if v.image == nil or v.image == "" then
            result[i].image = "img/not-found.jpg"
        end
    end

    return result
end)

RPC.register("pw-mdt:getWeaponData", function(src, pSerial)
    local result = MySQL.query.await([[
        SELECT w.id, w.serial, w.brand, w.type, w.notes, w.image, CONCAT(c.firstname," ",c.lastname) AS owner
        FROM mdt_weapons w
        LEFT JOIN users c ON c.id = w.cid
        WHERE w.serial = ?
    ]],
    { pSerial })

    if result[1].brand == nil then
        result[1].brand = ""
    end

    if result[1].type == nil then
        result[1].type = ""
    end

    if result[1].notes == nil then
        result[1].notes = ""
    end

    if result[1].image == nil or result[1].image == "" then
        result[1].image = "img/not-found.jpg"
    end

    return result[1]
end)

RegisterNetEvent("pw-mdt:addWeapon", function(pCid, pSerial)
	local src = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local name = xPlayer.getName()
    local job = getJob(src)

    local insertId = MySQL.insert.await([[
        INSERT INTO mdt_weapons (cid, serial)
        VALUES (?, ?)
    ]],
    { pCid, pSerial })

    if insertId and insertId > 0 then
        TriggerEvent("pw-mdt:newLog", "A new Weapon was created by " .. name .. " with the serial (" .. pSerial .. ") and ID (" .. insertId .. ")", job)
    end
end)

RegisterNetEvent("pw-mdt:saveWeapon", function(pSerial, pImage, pBrand, pType, pNotes)
	local src = source

    local xPlayer = ESX.GetPlayerFromId(source)
    local name = xPlayer.getName()
    local job = getJob(src)

    MySQL.update.await([[
        UPDATE mdt_weapons
        SET brand = ?, type = ?, notes = ?, image = ?
        WHERE serial = ?
    ]],
    { pBrand, pType, pNotes, pImage, pSerial })

    TriggerEvent("pw-mdt:newLog", "A Weapon was updated by " .. name .. " with the serial (" .. pSerial .. ")", job)
end)

--[[

    Missing

]]

RPC.register("pw-mdt:searchMissing", function(src, pData)
    local querry = string.lower("%" .. pData .. "%")

    local result = MySQL.query.await([[
        SELECT m.id, m.cid, m.last_seen, m.image, CONCAT(c.firstname," ",c.lastname) AS name
        FROM mdt_missing m
        LEFT JOIN users c ON c.id = m.cid
        WHERE LOWER(c.firstname) LIKE ? OR LOWER(c.id) LIKE ? OR LOWER(c.lastname) LIKE ? OR CONCAT(LOWER(c.firstname), " ", LOWER(c.lastname), " ", LOWER(c.id)) LIKE ? OR LOWER(m.id) LIKE ?
    ]],
    { querry, querry, querry, querry, querry })

    for i, v in ipairs(result) do
        if v.image == nil or v.image == "" then
            result[i].image = "img/not-found.jpg"
        end

        if v.last_seen == nil or v.last_seen == "" then
            result[i].last_seen = ""
        end
    end

    return result
end)

RPC.register("pw-mdt:getMissingData", function(src, pId)
    local result = MySQL.query.await([[
        SELECT m.id, m.cid, m.last_seen, m.notes, m.image, m.date, CONCAT(c.firstname," ",c.lastname) AS name
        FROM mdt_missing m
        LEFT JOIN users c ON c.id = m.cid
        WHERE m.id = ?
    ]],
    { pId })

    if result[1].last_seen == nil then
        result[1].last_seen = ""
    end

    if result[1].notes == nil then
        result[1].notes = ""
    end

    if result[1].image == nil or result[1].image == "" then
        result[1].image = "img/not-found.jpg"
    end

    return result[1]
end)

RegisterNetEvent("pw-mdt:missingCitizen", function(pCid, pTime)
	local src = source

    local xPlayer = ESX.GetPlayerFromId(source)
    local name = xPlayer.getName()
    local job = getJob(src)

    local insertId = MySQL.insert.await([[
        INSERT INTO mdt_missing (cid, date)
        VALUES (?, ?)
    ]],
    { pCid, pTime })

    if insertId and insertId > 0 then
        TriggerEvent("pw-mdt:newLog", "A new Missing Citizen was created by " .. name .. " with the ID (" .. insertId .. ")", job)
    end
end)

RegisterNetEvent("pw-mdt:saveMissing", function(pId, pLastSeen, pImage, pNotes)
	local src = source

    local xPlayer = ESX.GetPlayerFromId(source)
    local name = xPlayer.getName()
    local job = getJob(src)

    MySQL.update.await([[
        UPDATE mdt_missing
        SET last_seen = ?, image = ?, notes = ?
        WHERE id = ?
    ]],
    { pLastSeen, pImage, pNotes, pId })

    TriggerEvent("pw-mdt:newLog", "A Missing Citizen was updated by " .. name .. " with the ID (" .. pId .. ")", job)
end)

RegisterServerEvent("pw-mdt:deleteMissing", function(pId, pTime)
    local src = source

    local xPlayer = ESX.GetPlayerFromId(source)
    local name = xPlayer.getName()
    local job = getJob(src)

    MySQL.update.await([[
        DELETE FROM mdt_missing
        WHERE id = ?
    ]],
    { pId })

    TriggerEvent("pw-mdt:newLog", "A Missing Citizen was deleted by " .. name .. " with the ID (" .. pId .. ")", job)
end)

--[[

    Logs

]]

RegisterServerEvent("pw-mdt:newLog")
AddEventHandler("pw-mdt:newLog", function(text, job, time)
    if not time then
        time = os.time() * 1000
    end

    MySQL.insert.await([[
        INSERT INTO mdt_logs (text, job, time)
        VALUES (?, ?, ?)
    ]],
    { text, job, time })
end)

RPC.register("pw-mdt:getAllLogs", function(src)
    local job = getJob(src)

    local result = MySQL.query.await([[
        SELECT *
        FROM mdt_logs
        WHERE job = ? OR job IS NULL
        ORDER BY id DESC
        LIMIT 500
    ]],
    { job })

    return result
end)

--[[

    Threads

]]

Citizen.CreateThread(function()
    Citizen.Wait(3000)

    local _categorys = MySQL.query.await([[
        SELECT *
        FROM mdt_penalcode_categorys
    ]])

    for i, v in ipairs(_categorys) do
        penalCode[v.cid] = {}
        penalCodeCategorys[v.cid] = v.category

        local _penalcode = MySQL.query.await([[
            SELECT *
            FROM mdt_penalcode
            WHERE category = ?
            ORDER BY type ASC
        ]],
        { v.cid })

        for i2, v2 in ipairs(_penalcode) do
            local color = "green"
            local class = "Infração"

            if v2.type == 1 then
                color = "orange"
                class = "Contravenção"
            elseif v2.type == 2 then
                color = "red"
                class = "Crime"
            end

            table.insert(penalCode[v.cid], {
                id = v2.id,
                color = color,
                title = v2.label,
                class = class,
                months = v2.sentence,
                fine = v2.fine
            })
        end
    end
end)