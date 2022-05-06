local a = {
    server = LoadResourceFile(GetCurrentResourceName(), "server/hooks/" .. config.phoneHook .. "/server.lua"),
    client = LoadResourceFile(GetCurrentResourceName(), "client/hooks/" .. config.phoneHook .. "/client.lua"),
    dom = LoadResourceFile(GetCurrentResourceName(), "client/hooks/" .. config.phoneHook .. "/dom.js"),
    style = LoadResourceFile(GetCurrentResourceName(), "client/hooks/" .. config.phoneHook .. "/style.css")
}
local b = CS_AUTH_TOKEN or "00000000-0000-0000-0000-000000000000"
local c = {}
function GetActiveSocket(source)
    return c[tostring(source)]
end
function IsProxyIpAllowed(d)
    if d == config.proxyIpAddress then
        return true
    end
    for e = 1, #config.internalProxyIpAddresses do
        if d == config.internalProxyIpAddresses[e] then
            return true
        end
    end
    return false
end
RegisterServerEvent("cs-video-call:initialize")
AddEventHandler(
    "cs-video-call:initialize",
    function()
        local source = source
        TriggerClientEvent(
            "cs-video-call:initialize",
            source,
            b,
            {
                mobilePhoneType = config.mobilePhoneType,
                swapTransmissionControl = config.swapTransmissionControl,
                swapCameraControl = config.swapCameraControl,
                swapFilterControl = config.swapFilterControl,
                proxyIpAddress = config.proxyIpAddress,
                proxyPort = config.proxyPort
            },
            a
        )
    end
)
RegisterServerEvent("cs-video-call:socketConnected")
AddEventHandler(
    "cs-video-call:socketConnected",
    function(f)
        local source = tostring(source)
        c[source] = f
        TriggerClientEvent("cs-video-call:socketReady", source)
    end
)
RegisterServerEvent("cs-video-call:socketDisconnected")
AddEventHandler(
    "cs-video-call:socketDisconnected",
    function()
        local source = tostring(source)
        if c[source] then
            c[source] = nil
        end
    end
)
RegisterNetEvent("cs-video-call:setCallee")
AddEventHandler(
    "cs-video-call:setCallee",
    function(g)
        local source = source
        TriggerClientEvent("cs-video-call:setCalleeSocketId", source, g and GetActiveSocket(g) or nil)
    end
)
AddEventHandler(
    "cs-video-call:acquire",
    function()
        TriggerEvent("cs-video-call:hook", a.server)
    end
)
AddEventHandler(
    "playerDropped",
    function(h)
        local source = tostring(source)
        if c[source] then
            c[source] = nil
        end
    end
)
CreateThread(
    function()
        TriggerClientEvent(
            "cs-video-call:initialize",
            -1,
            b,
            {
                mobilePhoneType = config.mobilePhoneType,
                swapTransmissionControl = config.swapTransmissionControl,
                swapCameraControl = config.swapCameraControl,
                swapFilterControl = config.swapFilterControl,
                proxyIpAddress = config.proxyIpAddress,
                proxyPort = config.proxyPort
            },
            a
        )
        TriggerEvent("cs-video-call:hook", a.server)
    end
)
if config.proxyIsExternal then
    SetHttpHandler(
        function(i, j)
            if i.method == "POST" and i.path == "/verify" then
                local k = {}
                for l in string.gmatch(i.address, "([^:]+)") do
                    table.insert(k, l)
                end
                local m = k[1]
                if IsProxyIpAllowed(m) then
                    i.setDataHandler(
                        function(n)
                            local o = json.decode(n)
                            if b == o.token then
                                if o.source and o.id == c[tostring(o.source)] then
                                    if config.logging then
                                        print("Verify Succeeded", o.id, o.source)
                                    end
                                    j.writeHead(200)
                                    j.send()
                                    return
                                else
                                    if config.logging then
                                        print("Verify Failed (ID)", o.id, o.source, o.source and c[tostring(o.source)])
                                    end
                                    j.writeHead(400)
                                    j.send()
                                    return
                                end
                            else
                                if config.logging then
                                    print("Verify Failed (Token)", b, o.token)
                                end
                                j.writeHead(400)
                                j.send()
                                return
                            end
                        end
                    )
                else
                    if config.logging then
                        print("Verify Failed (IP Address)", m, config.proxyIpAddress)
                    end
                    j.writeHead(400)
                    j.send()
                    return
                end
            else
                j.writeHead(400)
                j.send()
                return
            end
        end
    )
    if config.logging then
        print("External Proxy HTTP Handler Initialized")
    end
else
    TriggerEvent("cs-video-call:runIntegratedProxy", config)
end
AddEventHandler(
    "cs-video-call:requestPeerVerification",
    function(f, p, source, q)
        if not config.proxyIsExternal then
            if f == c[tostring(source)] then
                if p == b then
                    TriggerEvent("cs-video-call:verifyPeer", f, p, source, q)
                elseif config.logging then
                    print("Verify Failed (Token)", p, b)
                end
            elseif config.logging then
                print("Verify Failed (ID)", f, source, source and c[tostring(source)])
            end
        end
    end
)
AddEventHandler(
    "cs-video-call:integratedProxyReady",
    function()
        if not config.proxyIsExternal then
            TriggerEvent("cs-video-call:runIntegratedProxy", config)
        end
    end
)
