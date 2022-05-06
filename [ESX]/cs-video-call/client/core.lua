
local a = true
exports(
    "SetCanTransmitVideo",
    function(b)
        a = b
        TriggerEvent("cs-video-call:onCanTransmitVideoChanged", a)
    end
)
