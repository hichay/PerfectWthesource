return function()
    local callWaiting = false
    local callAccepted = false
    local callRejected = false
    local phoneOpen = false
    local originalSendNUIMessage = _G.SendNUIMessage

    _G.SendNUIMessage = function(data)
        if (data.show ~= nil) then
            phoneOpen = data.show == true
        end

        originalSendNUIMessage(data)
    end

    AddEventHandler('cs-video-call:videoOn', function()
        PhonePlayIn()
    end)

    AddEventHandler('cs-video-call:videoOff', function()
        if (phoneOpen) then
            if (callRejected) then
                PhonePlayCall()
                PhonePlayText()
            else
                PhonePlayText()
                PhonePlayCall()
            end
        else
            PhonePlayText()
            PhonePlayOut()
        end
    end)

    local waitingCallFn = function(data, initiator)
        if (callWaiting) then
            return
        end

        callWaiting = true
        callAccepted = false
        callRejected = false

        CS_VIDEO_CALL.SetCallState(initiator)
    end

    local acceptCallFn = function(data, initiator)
        if (callAccepted) then
            return
        end

        callAccepted = true
        callWaiting = false
        callRejected = false
        
        if (initiator) then
            CS_VIDEO_CALL.SetCallee(data.receiver_src)
        else
            CS_VIDEO_CALL.SetCallee(data.transmitter_src)
        end

        CS_VIDEO_CALL.SetCallState(true)
    end

    local rejectCallFn = function(data, initiator)
        if (callRejected) then
            return
        end

        callRejected = true
        callAccepted = false
        callWaiting = false

        CS_VIDEO_CALL.ClearCallee()
        CS_VIDEO_CALL.SetCallState(false)
    end

    RegisterNetEvent('gcPhone:waitingCall')
    AddEventHandler('gcPhone:waitingCall', waitingCallFn)

    RegisterNetEvent('gcPhone:acceptCall')
    AddEventHandler('gcPhone:acceptCall', acceptCallFn)

    RegisterNetEvent('gcPhone:rejectCall')
    AddEventHandler('gcPhone:rejectCall', rejectCallFn)

    RegisterNetEvent('gcphone:233223waitingCall')
    AddEventHandler('gcphone:233223waitingCall', waitingCallFn)

    RegisterNetEvent('gcphone:233223233223acceptCall')
    AddEventHandler('gcphone:233223233223acceptCall', acceptCallFn)

    RegisterNetEvent('gcphone:233223233223rejectCall')
    AddEventHandler('gcphone:233223233223rejectCall', rejectCallFn)
end
