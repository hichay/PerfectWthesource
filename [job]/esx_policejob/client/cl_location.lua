local listening = false
local currentPrompt = nil

local EVENTS = {
    LOCKERS = 1,
    CLOTHING = 2,
    EVIDENCE = 3,
    TRASH = 4,
    ARMORY = 5,
}


local zoneData = {
    mrpd_clothing_lockers = {
        promptText = "[E] Tủ quần áo & Tủ Đồ",
        menuData = {
            {
                title = "Tủ cá nhân",
                description = "",
                action = "pw-police:handler",
                key = EVENTS.LOCKERS
            },
            {
                title = "Tủ đồ",
                description = "",
                action = "pw-police:handler",
                key = EVENTS.CLOTHING
            }
        }
    },
    mrpd_armory = {
        promptText = "[E] Kho trang bị"
    },
    mrpd_evidence = {
        promptText = "[E] Kho vật chứng"
    },
    mrpd_trash = {
        promptText = "[E] Kho rác"
    },
    mrpd_bossaction = {
        promptText = "[E] để mở bossmenu"
    },
    vbpd_armory_evidence = {
        promptText = "[E] Arsenal & Evidencias",
        menuData = {
            {
                title = "Arsenal",
                description = "AED - Armas, Equipamentos, Diversão!",
                action = "pw-police:handler",
                key = EVENTS.ARMORY
            },
            {
                title = "Evidencias",
                description = "Armario de evidências",
                action = "pw-police:handler",
                key = EVENTS.EVIDENCE
            },
            {
                title = "Lixo",
                description = 'Onde o "Spaghetti Code" remanesce',
                action = "pw-police:handler",
                key = EVENTS.TRASH
            },
        }
    },
    vbpd_lockers_clothing = {
        promptText = "[E] Armário & Roupas",
        menuData = {
            {
                title = "Armário",
                description = "Acessar armário pessoal",
                action = "pw-police:handler",
                key = EVENTS.LOCKERS
            },
            {
                title = "Roupas",
                description = "Trocar de roupa",
                action = "pw-police:handler",
                key = EVENTS.CLOTHING
            },

        }
    },

    doc_lockers = {
        promptText = "[E] Armário & Roupas",
        menuData = {
            {
                title = "Armário",
                description = "Acesse seu armário pessoal",
                action = "pw-police:handler",
                key = EVENTS.LOCKERS
            },
            {
                title = "Roupas",
                description = "Escolha sua roupa",
                action = "pw-police:handler",
                key = EVENTS.CLOTHING
            },
        }
    },
    doc_armory = {
        promptText = "[E] Arsenal"
    },
    doc_trash = {
        promptText = "[E] Lixo"
    },
}

local currentClassRoomBoardUrl = "https://cdn.discordapp.com/attachments/929484136572387339/936710819910156408/unknown.png"
local currentMeetingRoomBoardUrl = "https://cdn.discordapp.com/attachments/929484136572387339/936710819910156408/unknown.png"
local inClassRoom, inMeetingRoom = false, false


local function listenForKeypress(pZone, pAction)
    listening = true

    Citizen.CreateThread(function()
        while listening do
            if IsControlJustReleased(0, 38) then
                if pAction == "context" then
                    exports["pw-context"]:showContextMenu(zoneData[pZone].menuData)
                elseif pAction == "armory"  then
                    TriggerEvent("server-inventory-open", "10", "Shop")
                elseif pAction == "trash" then
                    TriggerEvent("server-inventory-open", "1", pZone)
                elseif pAction == "evidence" then
                    TriggerEvent("server-inventory-open", "1", pZone)
                    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 3.0, "LockerOpen", 0.4)
                elseif pAction == "bossmenu"  then
                    TriggerServerEvent("pw-bossmenu:server:openMenu")
                end
            end

            Citizen.Wait(1)
        end
    end)
end


AddEventHandler("pw-polyzone:enter", function(pZoneName, pZoneData)
    if pZoneName == "pw-police:zone" then
        if ESX.GetPlayerData().job.name == pZoneData.job then
            currentPrompt = pZoneData.zone
            exports["pw-interaction"]:showInteraction(zoneData[pZoneData.zone].promptText)
            listenForKeypress(pZoneData.zone, pZoneData.action)
        end
    elseif pZoneName == 'pw-police:bossaction' then 
        if ESX.GetPlayerData().job.name == pZoneData.job and ESX.GetPlayerData().job.grade >= 10 then
            currentPrompt = pZoneData.zone
            exports["pw-interaction"]:showInteraction(zoneData[pZoneData.zone].promptText)
            listenForKeypress(pZoneData.zone, pZoneData.action)
        end
    elseif pZoneName == "mrpd_classroom" then
        if not dui then
            dui = exports["pw-lib"]:getDui(currentClassRoomBoardUrl)
            AddReplaceTexture("prop_planning_b1", "prop_base_white_01b", dui.dictionary, dui.texture)
        else
            exports["pw-lib"]:changeDuiUrl(dui.id, currentClassRoomBoardUrl)
        end
        inClassRoom = true
    elseif zone == "mrpd_meetingroom" then
        if not dui then
          dui = exports["pw-lib"]:getDui(currentMeetingRoomBoardUrl)
          AddReplaceTexture("prop_planning_b1", "prop_base_white_01b", dui.dictionary, dui.texture)
        else
          exports["pw-lib"]:changeDuiUrl(dui.id, currentMeetingRoomBoardUrl)
        end
        inMeetingRoom = true
    end
end)

AddEventHandler("pw-polyzone:exit", function(pZoneName, pZoneData)
    if pZoneName == "pw-police:zone" then
        exports["pw-interaction"]:hideInteraction()
        listening = false
        currentPrompt = nil
    elseif pZoneName == "mrpd_classroom" then
        RemoveReplaceTexture("prop_planning_b1", "prop_base_white_01b")
        if dui ~= nil then
            exports["pw-lib"]:releaseDui(dui.id)
            dui = nil
        end
        inClassRoom = false
    elseif zone == "mrpd_meetingroom" then
        RemoveReplaceTexture("prop_planning_b1", "prop_base_white_01b")
        if dui ~= nil then
            exports["pw-lib"]:releaseDui(dui.id)
            dui = nil
        end
        inMeetingRoom = false
    end
end)
RegisterUICallback('pw-police:handler', function (data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    local eventData = data.key
    local job = ESX.GetPlayerData().job.name

    local location = currentPrompt ~= nil and string.match(currentPrompt, "(.-)_") or ""

    if eventData == EVENTS.LOCKERS and job == 'police' then
        local cid = ESX.GetPlayerData().id
        TriggerEvent("server-inventory-open", "1", ("personalStorage-%s-%s"):format(location, cid))
        TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 3.0, "LockerOpen", 0.4)
    elseif eventData == EVENTS.CLOTHING then
        exports["pw-interaction"]:hideInteraction()
        Wait(500)
        TriggerEvent("raid_clothes:openClothing", true, true)
    elseif eventData == EVENTS.EVIDENCE and job == 'police' then
        if job == "cid" then
            local input = exports["pw-input"]:showInput({
                {
                    icon = "hashtag",
                    label = "ID do Caso",
                    name = "id",
                },
            })

            if input["id"] then
                TriggerEvent("server-inventory-open", "1", ("%s_evidence"):format(input["id"]))
            end
        else
            TriggerEvent("server-inventory-open", "1", ("%s_evidence"):format(location))
        end
    elseif eventData == EVENTS.TRASH and ESX.GetPlayerData().job.name == 'police' then
        TriggerEvent("server-inventory-open", "1", ("%s_trash"):format(location))
    elseif eventData == EVENTS.ARMORY and ESX.GetPlayerData().job.name == 'police' then
        if job == "cid" then
            TriggerEvent("server-inventory-open", "11", "Shop")
        else
            TriggerEvent("server-inventory-open", "10", "Shop")
        end
    end
end)
 
AddEventHandler("pw-police:handler", function(eventData)
    local job = ESX.GetPlayerData().job.name

    local location = currentPrompt ~= nil and string.match(currentPrompt, "(.-)_") or ""

    if eventData == EVENTS.LOCKERS and job == 'police' then
        local cid = ESX.GetPlayerData().id
        TriggerEvent("server-inventory-open", "1", ("personalStorage-%s-%s"):format(location, cid))
        TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 3.0, "LockerOpen", 0.4)
    elseif eventData == EVENTS.CLOTHING then
        exports["pw-interaction"]:hideInteraction()
        Wait(500)
        TriggerEvent("raid_clothes:openClothing", true, true)
    elseif eventData == EVENTS.EVIDENCE and job == 'police' then
        if job == "cid" then
            local input = exports["pw-input"]:showInput({
                {
                    icon = "hashtag",
                    label = "ID do Caso",
                    name = "id",
                },
            })

            if input["id"] then
                TriggerEvent("server-inventory-open", "1", ("%s_evidence"):format(input["id"]))
            end
        else
            TriggerEvent("server-inventory-open", "1", ("%s_evidence"):format(location))
        end
    elseif eventData == EVENTS.TRASH and ESX.GetPlayerData().job.name == 'police' then
        TriggerEvent("server-inventory-open", "1", ("%s_trash"):format(location))
    elseif eventData == EVENTS.ARMORY and ESX.GetPlayerData().job.name == 'police' then
        if job == "cid" then
            TriggerEvent("server-inventory-open", "11", "Shop")
        else
            TriggerEvent("server-inventory-open", "10", "Shop")
        end
    end
end)

AddEventHandler("pw-polce:changewhiteboardurl", function(pParams)
    
    exports['np-ui']:openApplication('textbox', {
        callbackUrl = 'np-ui:policechangeurl',
        key = 1,
        items = {
          {
            icon = "circle",
            label = "URL",
            name = "url",
          },
        },
        hiddenItems = {
          room = pParams.room
        },
        show = true,
      })
end)

RegisterUICallback("np-ui:policechangeurl", function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    exports['np-ui']:closeApplication('textbox')
    TriggerServerEvent("police:changewhiteboard", data.values.url, data.hiddenItems.room)
end)

RegisterNetEvent("police:changewhiteboardcli")
AddEventHandler("police:changewhiteboardcli", function(pUrl, pRoom)
    if pRoom == "classroom" then
        currentClassRoomBoardUrl = pUrl

        if inClassRoom and dui then
            exports["pw-lib"]:changeDuiUrl(dui.id, currentClassRoomBoardUrl)
        end
    elseif pRoom == "meetingroom" and inMeetingRoom and dui then
        currentMeetingRoomBoardUrl = pUrl

        if inMeetingRoom and dui then
            exports["pw-lib"]:changeDuiUrl(dui.id, currentMeetingRoomBoardUrl)
        end
    end
end)


Citizen.CreateThread(function()
    -- MRPD Classroom
    exports["pw-polyzone"]:AddPolyZone("mrpd_classroom", {
        vector2(448.41372680664, -990.47613525391),
        vector2(439.50704956055, -990.55731201172),
        vector2(439.43478393555, -981.08758544922),
        vector2(448.419921875, -981.26306152344),
        vector2(450.23190307617, -983.00885009766),
        vector2(450.25042724609, -988.77667236328)
    }, {
        gridDivisions = 25,
        minZ = 34.04,
        maxZ = 37.69,
    })

    exports["pw-polyzone"]:AddBoxZone("mrpd_meetingroom", vector3(474.07, -995.08, 30.69), 10.2, 5.2, {
        heading=0,
        minZ=29.64,
        maxZ=32.84
    })

    -- MRPD Lockers
    exports["pw-polyzone"]:AddBoxZone("pw-police:zone", vector3(461.81, -997.79, 30.69), 4.4, 4.8, {
        heading = 0,
        minZ = 29.64,
        maxZ = 32.84,
        data = {
            job = "police",
            action = "context",
            zone = "mrpd_clothing_lockers",
        },
    })

    -- MRPD Armory
    exports["pw-polyzone"]:AddBoxZone("pw-police:zone", vector3(481.59, -995.35, 30.69), 3.2, 4.8, {
        heading = 90,
        minZ = 29.69,
        maxZ = 32.49,
        data = {
            job = "police",
            action = "armory",
            zone = "mrpd_armory",
        },
    })

    -- MRPD BossRoom
    exports["pw-polyzone"]:AddBoxZone("pw-police:bossaction", vector3(460.73141, -985.5544, 30.728082), 3.2, 4.8, {
        heading = 90,
        minZ = 29.69,
        maxZ = 32.49,
        data = {
            job = "police",
            action = "bossmenu",
            zone = "mrpd_bossaction",
        },
    })

    -- MRPD Evidence
    exports["pw-polyzone"]:AddBoxZone("pw-police:zone", vector3(474.84, -996.26, 26.27), 1.2, 3.0, {
        heading = 90,
        minZ = 25.27,
        maxZ = 27.87,
        data = {
            job = "police",
            action = "evidence",
            zone = "mrpd_evidence",
        },
    })

    -- MRPD Trash
    exports["pw-polyzone"]:AddBoxZone("pw-police:zone", vector3(472.88, -996.28, 26.27), 1.2, 3.0, {
        heading = 90,
        minZ = 25.27,
        maxZ = 27.87,
        data = {
            job = "police",
            action = "trash",
            zone = "mrpd_trash",
        },
    })


    -- VBPD Armory & Evidence
    exports["pw-polyzone"]:AddBoxZone("pw-police:zone", vector3(-1076.71, -828.81, 19.3), 6.6, 4.6, {
        heading=38,
        minZ=18.3,
        maxZ=21.5,
        data = {
            job = "cid",
            action = "context",
            zone = "vbpd_armory_evidence",
        },
    })

    -- VBPD Lockers & Clothing
    exports["pw-polyzone"]:AddBoxZone("pw-police:zone", vector3(-1086.98, -831.58, 19.3), 9.2, 5.4, {
        heading=38,
		minZ=18.3,
		maxZ=21.7,
        data = {
            job = "cid",
            action = "context",
            zone = "vbpd_lockers_clothing",
        },
    })

    -- DOC Lockers
    exports["pw-polyzone"]:AddBoxZone("pw-police:zone", vector3(1770.14, 2517.32, 45.83), 4.15, 0.75, {
        heading = 30,
        minZ = 44.83,
        maxZ = 47.43,
        data = {
            job = "doc",
            action = "context",
            zone = "doc_lockers",
        },
    })

    -- DOC Armory
    exports["pw-polyzone"]:AddBoxZone("pw-police:zone", vector3(1771.97, 2514.02, 45.83), 1.0, 0.65, {
        heading = 30,
        minZ = 44.83,
        maxZ = 47.43,
        data = {
            job = "doc",
            action = "armory",
            zone = "doc_armory",
        },
    })

    -- DOC Trash
    exports["pw-polyzone"]:AddCircleZone("pw-police:zone", vector3(1771.26, 2497.24, 50.43), 0.4, {
        useZ = true,
        data = {
            job = "doc",
            action = "trash",
            zone = "doc_trash",
        },
    })

    -- MRPD Screen
    exports["pw-polytarget"]:AddBoxZone("mrdp_change_picture", vector3(439.44, -985.89, 34.97), 1.0, 0.4, {
        heading=0,
        minZ=35.37,
        maxZ=36.17
    })

    exports["pw-polytarget"]:AddBoxZone("mrpd_meetingroom_screen", vector3(474.02, -1000.06, 30.69), 0.05, 2.6, {
        heading=0,
        minZ=30.54,
        maxZ=32.49
    })

    exports["pw-interact"]:AddPeekEntryByPolyTarget("mrdp_change_picture", {{
        event = "pw-polce:changewhiteboardurl",
        id = "polcechangewhiteboardurlc",
        icon = "circle",
        label = "Change URL",
        parameters = {
            room = "classroom"
        }
    }}, { distance = { radius = 2.5 } })

    exports["pw-interact"]:AddPeekEntryByPolyTarget("mrpd_meetingroom_screen", {{
        event = "pw-polce:changewhiteboardurl",
        id = "polcechangewhiteboardurlm",
        icon = "circle",
        label = "Change URL",
        parameters = {
            room = "meetingroom"
        }
    }}, { distance = { radius = 2.5 } })
end)