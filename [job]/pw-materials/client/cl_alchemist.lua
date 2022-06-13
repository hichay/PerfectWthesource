local isMealtingProcessing = false
local isMealtingProcessingFinished = false
local SmelterStart = false
Citizen.CreateThread(function()
	exports["pw-polytarget"]:AddCircleZone("alchemist_station", vector3(1111.1364, -2008.842, 31.095638), 0.4, {
		useZ=true,
	})

    exports["pw-polytarget"]:AddCircleZone("start_alchemistloc", vector3(1075.5101, -1979.284, 31.471342), 0.4, {
		useZ=true,
	})
	
    local InteractSmelter = {
        data = {
            {
                id = 'melt_basic',
                label = "Lò Luyện kim thường",
                icon = 'fire-burner',
                event = 'pw-alchemist:Putintosmelter',
                parameters = {basic = true},
            },
            {
                id = 'melt_refined',
                label = "Lò Luyện kim tinh chế",
                icon = 'fire-burner',
                event = 'pw-alchemist:Putintosmelter',
                parameters = {basic = false},
            },
        },
        options = {
            distance = { radius = 2.5 },
            isEnabled = function(pEntity, pContext)
            return not isMealtingProcessing
            end,
        },
    }

    exports['pw-interact']:AddPeekEntryByPolyTarget({'alchemist_station'},InteractSmelter.data,InteractSmelter.options)

    local InteractSmelterFinished = {
        data = {
            {
                id = 'collect_smelter',
                label = "Lấy từ lò thường",
                icon = 'hands',
                event = 'pw-alchemist:Takeitemfromsmelter',
                parameters = {basic = true},
            },
            {
                id = 'collect_smelterrefined',
                label = "Lấy từ lò tinh chế",
                icon = 'hands',
                event = 'pw-alchemist:Takeitemfromsmelter',
                parameters = {basic = false},
            },

        },
        options = {
            distance = { radius = 2.5 },
            isEnabled = function(pEntity, pContext)
            return isMealtingProcessingFinished
            end,
        },
    }

    exports['pw-interact']:AddPeekEntryByPolyTarget({'alchemist_station'},InteractSmelterFinished.data,InteractSmelterFinished.options)

    local InteractSmelter = {
        data = {
            {
                id = 'smelter_action',
                label = "Bật lò nung",
                icon = 'computer',
                event = 'pw-alchemist:startmelt',
                parameters = {},
            },
        },
        options = {
            distance = { radius = 2.5 },
            isEnabled = function(pEntity, pContext)
            return not isMealtingProcessing
            end,
        },
    }

    exports['pw-interact']:AddPeekEntryByPolyTarget({'start_alchemistloc'},InteractSmelter.data,InteractSmelter.options)

    local initialState = RPC.execute('pw-weed:getInitialState')
    
    isMealtingProcessing = initialState.isMealtingProcessing
    isMealtingProcessingFinished = initialState.isMealtingProcessingFinished
end)


RegisterNetEvent('pw-alchemist:Putintosmelter')
AddEventHandler('pw-alchemist:Putintosmelter', function(smelter)
    if smelter.basic then 
        local hasEnoughWeeds = exports['pw-inventory']:hasEnoughOfItem('coal', 50, false, true)
        if not hasEnoughWeeds and not SmelterStart then
            TriggerEvent('DoLongHudText', 'Không đủ than để bắt đầu nung lò', 2)
            return
        end
        if isMealtingProcessing then
            TriggerEvent('DoLongHudText', 'Ai đó đã đốt lò vàng đang nung nguyên liệu,Hãy quay lại sau', 2)
            return
        end
        SmelterStart = true
        TriggerEvent("inventory:removeItem","coal",50)
        local finished = exports['pw-taskbar']:taskBar(15000, 'Chuẩn bị lò nung thường', false, true, false, false, nil, 5.0, PlayerPedId())
        if finished == 100 then
            TriggerEvent("server-inventory-open", "1", ("smelter-%s"):format('basic'))
        end
    else
        local hasEnoughWeeds = exports['pw-inventory']:hasEnoughOfItem('coal', 100, false, true)
        if not hasEnoughWeeds and not SmelterStart then
            TriggerEvent('DoLongHudText', 'Không đủ than để bắt đầu nung lò', 2)
            return
        end
        if isMealtingProcessing then
            TriggerEvent('DoLongHudText', 'Ai đó đã đốt lò vàng đang nung nguyên liệu,Hãy quay lại sau', 2)
            return
        end
        SmelterStart = true
        TriggerEvent("inventory:removeItem","coal",100)
        local finished = exports['pw-taskbar']:taskBar(30000, 'Chuẩn bị lò nung tinh chế', false, true, false, false, nil, 5.0, PlayerPedId())
        if finished == 100 then
            TriggerEvent("server-inventory-open", "1", ("smelter-%s"):format('refined'))
        end
    end
end)

RegisterNetEvent('pw-alchemist:Takeitemfromsmelter')
AddEventHandler('pw-alchemist:Takeitemfromsmelter', function(smelter)
    isMealtingProcessingFinished = false
    isMealtingProcessing = false
    if smelter.basic then 
        TriggerEvent("server-inventory-open", "1", ("smelter-%s"):format('basic'))
    else
        TriggerEvent("server-inventory-open", "1", ("smelter-%s"):format('refined'))
    end
end)

--[[ RegisterCommand("whats", function(source, args, rawCommand)
    SmelterStart = false
    TriggerServerEvent('pw-pawnshop:sell')
end, false) ]]

RegisterNetEvent('pw-alchemist:startmelt')
AddEventHandler('pw-alchemist:startmelt', function()

    local data = {
        {
            icon = 'toggle-off',
            title = 'Bật lò thường',
            action = 'pw-alchemist:startingthemelt',
            key = {basic = true},
        },

        {
            icon = 'toggle-on',
            title = 'Bật lò tinh chế',
            action = 'pw-alchemist:startingthemelt',
            key = {basic = false},
        }
    }
    
    exports["pw-context"]:showContextMenu(data)
end)

RegisterNetEvent('pw-alchemist:startingthemelt')
AddEventHandler('pw-alchemist:startingthemelt', function(data)
    SmelterStart = false
    if data.basic then 
        TriggerServerEvent('pw-alchemist:SmelterStared',true)
    else
        TriggerServerEvent('pw-alchemist:SmelterStared',false)
    end
end)

RegisterNetEvent('pw-alchemist:SmelterProcessing')
AddEventHandler('pw-alchemist:SmelterProcessing', function(pState)
    isMealtingProcessing = pState
end)


RegisterNetEvent('pw-alchemist:SmelterReady')
AddEventHandler('pw-alchemist:SmelterReady', function(pState)
    isMealtingProcessingFinished = pState
end)