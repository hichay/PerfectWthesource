local a = nil
CS_VIDEO_CALL = {ACTIVE = false, SetCallState = function(b)
        SendNUIMessage({type = "cs-video-call:call-state", active = b})
    end, SetCallee = function(c)
        a = c
        TriggerServerEvent("cs-video-call:setCallee", c)
    end, ClearCallee = function()
        a = nil
        TriggerServerEvent("cs-video-call:setCallee")
    end}
local d = {config = {}, backCam = false, videoMode = false, clientReady = false, jsReady = false, canTransmit = true}
AddEventHandler(
    "cs-video-call:onCanTransmitVideoChanged",
    function(e)
        d.canTransmit = e
        if d.jsReady then
            SendNUIMessage({type = "cs-video-call:can-transmit", state = e})
        end
    end
)
RegisterNetEvent("cs-video-call:initialize")
AddEventHandler(
    "cs-video-call:initialize",
    function(f, g, h)
        if d.clientReady or not d.jsReady then
            return
        end
        d.clientReady = true
        d.config = g
        local i, j = load(h.client)
        if i then
            local k, l = pcall(i)
            if k then
                l()
            else
                print("Hook Function Execution Failed")
            end
        else
            print("Hook Function Compilation Failed", j)
        end
        RegisterNUICallback(
            "cs-video-call:videoOn",
            function(m, n)
                if d.videoMode then
                    return
                end
                CS_VIDEO_CALL.ACTIVE = true
                d.videoMode = true
                d.backCam = false
                TriggerEvent("cs-video-call:onVideoOn")
                DestroyMobilePhone()
                CellCamActivate(true, true)
                Citizen.InvokeNative(0x2491A93618B7D838, true)
                CreateMobilePhone(d.config.mobilePhoneType)
                SendNUIMessage({type = "cs-video-call:back-camera", active = d.backCam})
                n(true)
            end
        )
        RegisterNUICallback(
            "cs-video-call:videoOff",
            function(m, n)
                if not d.videoMode then
                    return
                end
                CS_VIDEO_CALL.ACTIVE = false
                d.videoMode = false
                TriggerEvent("cs-video-call:onVideoOff")
                DestroyMobilePhone()
                CellCamActivate(false, false)
                n(true)
            end
        )
        RegisterNUICallback(
            "cs-video-call:swapCamera",
            function(m, n)
                d.backCam = not d.backCam
                Citizen.InvokeNative(0x2491A93618B7D838, not d.backCam)
                SendNUIMessage({type = "cs-video-call:back-camera", active = d.backCam})
                n(true)
            end
        )
        RegisterNUICallback(
            "cs-video-call:transmissionRejectedFromExhaustion",
            function(m, n)
                TriggerEvent("cs-video-call:onTransmissionRejectedFromExhaustion")
                n(true)
            end
        )
        RegisterNUICallback(
            "cs-video-call:transmissionRejectedFromExport",
            function(m, n)
                TriggerEvent("cs-video-call:onTransmissionRejectedFromExport")
                n(true)
            end
        )
        RegisterNUICallback(
            "cs-video-call:socketConnected",
            function(m, n)
                TriggerServerEvent("cs-video-call:socketConnected", m.id)
                n(true)
            end
        )
        RegisterNUICallback(
            "cs-video-call:socketDisconnected",
            function(m, n)
                TriggerServerEvent("cs-video-call:socketDisconnected")
                n(true)
            end
        )
        RegisterNetEvent("cs-video-call:socketReady")
        AddEventHandler(
            "cs-video-call:socketReady",
            function(o)
                SendNUIMessage({type = "cs-video-call:socket-ready"})
                Wait(2500)
                if a then
                    CS_VIDEO_CALL.SetCallee(a)
                end
            end
        )
        RegisterNetEvent("cs-video-call:setCalleeSocketId")
        AddEventHandler(
            "cs-video-call:setCalleeSocketId",
            function(o)
                SendNUIMessage({type = "cs-video-call:set-callee-socket", socketId = o})
            end
        )
        if d.config.swapTransmissionControl or d.config.swapFilterControl or d.config.swapCameraControl then
            CreateThread(
                function()
                    while true do
                        if
                            d.config.swapTransmissionControl and
                                IsDisabledControlJustReleased(0, d.config.swapTransmissionControl)
                         then
                            SendNUIMessage({type = "cs-video-call:swap-transmission"})
                        end
                        if
                            d.videoMode and d.config.swapFilterControl and
                                IsDisabledControlJustReleased(0, d.config.swapFilterControl)
                         then
                            SendNUIMessage({type = "cs-video-call:swap-filter"})
                        end
                        if
                            d.videoMode and d.config.swapCameraControl and
                                IsDisabledControlJustReleased(0, d.config.swapCameraControl)
                         then
                            SendNUIMessage({type = "cs-video-call:swap-camera"})
                        end
                        Wait(0)
                    end
                end
            )
        end
        SendNUIMessage(
            {
                type = "cs-video-call:initialize",
                token = f,
                serverEndpoint = GetCurrentServerEndpoint(),
                proxyIpAddress = d.config.proxyIpAddress,
                proxyPort = d.config.proxyPort,
                canTransmit = d.canTransmit,
                hookFiles = {dom = h.dom, style = h.style},
                playerSource = GetPlayerServerId(PlayerId())
            }
        )
    end
)
RegisterNUICallback(
    "cs-video-call:jsReady",
    function(m, n)
        if d.jsReady then
            return
        end
        d.jsReady = true
        TriggerServerEvent("cs-video-call:initialize")
        n(true)
    end
)
