return function()
    RegisterNetEvent('cs-video-call:custom:setCallee')
    AddEventHandler('cs-video-call:custom:setCallee', function(target)
        CS_VIDEO_CALL.SetCallState(true)
        CS_VIDEO_CALL.SetCallee(target)
    end)

    RegisterNetEvent('cs-video-call:custom:clearCallee')
    AddEventHandler('cs-video-call:custom:clearCallee', function(target)
        CS_VIDEO_CALL.SetCallState(false)
        CS_VIDEO_CALL.ClearCallee()
    end)
end
