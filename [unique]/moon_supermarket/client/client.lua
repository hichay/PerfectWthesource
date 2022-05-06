local a = nil
RegisEvent(true,GetName(":client:Verify:Receive"),function(b)
        a = b
    end
)
Citizen.CreateThread(
    function()
        local c = GetGameTimer()
        while a == nil and GetGameTimer() - c <= 30 * 1000 do
            TriggerServerEvent(GetName(":server:Verify:Request"))
            Wait(300)
        end
        xZero.Init()
    end
)
xZero = {}
ESX = nil
_InventoryItem = {}
_IsKeyPress_Prograss = false
ShopOpen_Status = false
Shop_CurrentActions = {}
Shop_CurrentActions.hasEnterMarker = false
Shop_CurrentActions.Zone_Index = nil
Shop_CurrentActions.Zone = nil
Shop_CurrentActions.Zone_Pos = nil
Shop_Zones_JobNotAllow = {}
BlipList = {}
posIsInDistanceList = {}
xZero.Init = function()
    Wait(500)
    if a then
        if not Config_Vaild() then
            print(("^1[%s] Error Config Vaild DATA^7"):format(script_name))
            return
        end
        ConfigBaseVaild()
        while ESX == nil do
            TriggerEvent(
                Config_xZC_Shop.Base.getSharedObject,
                function(d)
                    ESX = d
                end
            )
            Wait(1)
        end
        while true do
            if ESX.GetPlayerData() and ESX.GetPlayerData().inventory and #ESX.GetPlayerData().inventory > 0 then
                Wait(100)
                break
            end
            Wait(1)
        end
        for e, f in ipairs(ESX.GetPlayerData().inventory) do
            _InventoryItem[f.name] = f
        end
        xZero.Inited()
    else
        print("^1Verify:ERROR^7")
    end
end
xZero.Inited = function()
    print(("Inited - version_current:^3%s^7"):format(version_current))
    SendNUIMessage({action = "config_settings", URL_Images = Config_xZC_Shop.URL_Images})
    xZero.Init_Handlers()
end
xZero.Init_Handlers = function()
    Blip_Reloaded()
    Citizen.CreateThread(
        function()
            while true do
                Wait(7)
                if Config_xZC_Shop.Zones and not ShopOpen_Status then
                    local g = posIsInDistanceList and #posIsInDistanceList or 0
                    if g > 0 then
                        for h = 1, g do
                            local i = posIsInDistanceList[h]
                            if i then
                                local j = i.pos
                                local k = Config_xZC_Shop.Zones[i.zoneIndex]
                                if
                                    (not Shop_Zones_JobNotAllow or not Shop_Zones_JobNotAllow[i.zoneIndex]) and
                                        k.Marker.Show
                                 then
                                    local l = k.Marker.Type and k.Marker.Type or Config_xZC_Shop.Default.Marker.Type
                                    local m = k.Marker.Size and k.Marker.Size or Config_xZC_Shop.Default.Marker.Size
                                    local n = k.Marker.Color and k.Marker.Color or Config_xZC_Shop.Default.Marker.Color
                                    local o = j.z
                                    o = k.Marker.Pos_Z_up and o + k.Marker.Pos_Z_up or o
                                    o = k.Marker.Pos_Z_down and o - k.Marker.Pos_Z_down or o
                                    DrawMarker(
                                        l,
                                        j.x,
                                        j.y,
                                        o,
                                        0.0,
                                        0.0,
                                        0.0,
                                        0,
                                        0.0,
                                        0.0,
                                        m.x,
                                        m.y,
                                        m.z,
                                        n.r,
                                        n.g,
                                        n.b,
                                        100,
                                        false,
                                        true,
                                        2,
                                        true,
                                        false,
                                        false,
                                        false
                                    )
                                end
                            end
                        end
                    else
                        Wait(500)
                    end
                else
                    Wait(1000)
                end
            end
        end
    )
    Citizen.CreateThread(
        function()
            while true do
                Wait(500)
                local p = false
                local q = nil
                local r = nil
                local s = nil
                local t = {}
                if Config_xZC_Shop.Zones then
                    for u, v in ipairs(Config_xZC_Shop.Zones) do
                        if v.Pos then
                            for w, j in ipairs(v.Pos) do
                                Wait(1)
                                local x = #(GetEntityCoords(PlayerPedId()) - vector3(j.x, j.y, j.z))
                                local m =
                                    v.Marker and v.Marker.Size and v.Marker.Size or Config_xZC_Shop.Default.Marker.Size
                                if x <= Config_xZC_Shop.Default.Marker.Distance then
                                    t[#t + 1] = {zoneIndex = u, pos = j}
                                end
                                if x < m.x then
                                    p = true
                                    q = u
                                    r = v
                                    s = j
                                end
                            end
                        end
                    end
                    posIsInDistanceList = t
                end
                if p and not Shop_CurrentActions.hasEnterMarker then
                    Shop_CurrentActions.hasEnterMarker = true
                    TriggerEvent(GetName(":client:On_EnterMarker"), q, r)
                end
                if not p and Shop_CurrentActions.hasEnterMarker then
                    Shop_CurrentActions.hasEnterMarker = false
                    TriggerEvent(GetName(":client:On_ExitMarker"))
                end
            end
        end
    )
    Citizen.CreateThread(
        function()
            while true do
                Wait(7)
                if Shop_CurrentActions.Zone_Index and Shop_CurrentActions.Zone and not ShopOpen_Status then
                    if not Shop_Zones_JobNotAllow or not Shop_Zones_JobNotAllow[Shop_CurrentActions.Zone_Index] then
                        DisplayHelpText("Press ~INPUT_CONTEXT~ Enter ~y~Shop~s~")
                        if IsControlJustPressed(0, 38) and not ShopOpen_Status and not _IsKeyPress_Prograss then
                            _IsKeyPress_Prograss = true
                            if Zone_ItemsRequireIsVaild(Shop_CurrentActions.Zone_Index) then
                                TriggerEvent(
                                    GetName(":client:Shop_ItemsList_Setup"),
                                    function(y)
                                        if y then
                                            TriggerEvent(GetName(":client:Shop_Open"))
                                        else
                                        end
                                        _IsKeyPress_Prograss = false
                                    end,
                                    Shop_CurrentActions.Zone_Index
                                )
                            else
                                pNotify("คุณไม่มีไอเทมที่กำหนด!", "error")
                                Wait(2000)
                                _IsKeyPress_Prograss = false
                            end
                        end
                    else
                        Wait(1000)
                    end
                else
                    Wait(500)
                end
            end
        end
    )
    RegisEvent(
        false,
        GetName(":client:On_EnterMarker"),
        function(z, A)
            Shop_CurrentActions.Zone_Index = z
            Shop_CurrentActions.Zone = A
        end
    )
    RegisEvent(
        false,
        GetName(":client:On_ExitMarker"),
        function()
            Shop_CurrentActions.Zone_Index = nil
            Shop_CurrentActions.Zone = nil
            TriggerEvent(GetName(":client:Shop_Close"))
        end
    )
    RegisEvent(
        false,
        GetName(":client:Shop_ItemsList_Setup"),
        function(B, z)
            if Config_xZC_Shop.Zones and Config_xZC_Shop.Zones[z] then
                local v = Config_xZC_Shop.Zones[z]
                local C = {}
                C.action = "itemslist_setup"
                C.Zone_Index = z
                C.Zone_Name = v.Name
                C.Zone_Label = v.Label
                C.ItemsList = {}
                if v.Items and #v.Items > 0 then
                    for D, E in ipairs(v.Items) do
                        local F = _InventoryItem[E.name]
                        if F or E.item_type == "item_standard" or E.item_type and E.item_type == "item_weapon" then
                            local G = xItemFormat(E, F)
                            table.insert(
                                C.ItemsList,
                                {
                                    index = D,
                                    name = G.name,
                                    label = G.label,
                                    limit = G.limit,
                                    item_type = G.item_type,
                                    price_account_name = G.price_account_name,
                                    price = G.price,
                                    count = 1
                                }
                            )
                        else
                            print(("^1Error InvItem NotFound | %s^1 | %s^7"):format(E.name, E.item_type))
                        end
                    end
                end
                if v.ItemsInclude and #v.ItemsInclude > 0 and Config_xZC_Shop.ItemsInclude then
                    for e, H in ipairs(v.ItemsInclude) do
                        local I = Config_xZC_Shop.ItemsInclude[H] or nil
                        if I and #I > 0 then
                            for D, E in ipairs(I) do
                                local F = _InventoryItem[E.name]
                                if F or E.item_type and E.item_type == "item_weapon" then
                                    local G = xItemFormat(E, F)
                                    table.insert(
                                        C.ItemsList,
                                        {
                                            index = D,
                                            name = G.name,
                                            label = G.label,
                                            limit = G.limit,
                                            item_type = G.item_type,
                                            price_account_name = G.price_account_name,
                                            price = G.price,
                                            count = 1,
                                            ItemsInclude = H
                                        }
                                    )
                                else
                                    print(("^1Error InvItem NotFound | %s | %s^7"):format(E.name, E.item_type))
                                end
                            end
                        end
                    end
                end
                SendNUIMessage(C)
                B(true)
            else
                B(nil)
            end
        end
    )
    RegisEvent(
        false,
        GetName(":client:Shop_SetShow"),
        function(y)
            SendNUIMessage({action = "shop_open", status = y})
            ShopOpen_Status = y
            if ShopOpen_Status then
                Wait(100)
            end
            SetNuiFocus(ShopOpen_Status, ShopOpen_Status)
        end
    )
    RegisEvent(
        false,
        GetName(":client:Shop_Open"),
        function()
            TriggerEvent(GetName(":client:Shop_SetShow"), true)
        end
    )
    RegisEvent(
        false,
        GetName(":client:Shop_Close"),
        function()
            TriggerEvent(GetName(":client:Shop_SetShow"), false)
        end
    )
    RegisterNUICallback(
        "Close",
        function(C, B)
            TriggerEvent(GetName(":client:Shop_Close"))
            B(true)
        end
    )
    RegisterNUICallback(
        "On_Buy",
        function(C, B)
            local J = {}
            J.status = "error"
            local K = math.random(100, 500)
            Wait(K)
            local z = C.Zone_Index
            local L = C.Item
            if ItemIsVaild(z, L) then
                J.status = "success"
                TriggerServerEvent(GetName(":server:On_Shop_Buy"), z, L)
            end
            B(J)
        end
    )
    RegisEvent(
        true,
        Config_xZC_Shop.Base.setJob,
        function(M)
            Wait(1000)
            Blip_Reloaded()
        end
    )
    RegisterCommand(
        "closeshop",
        function(N, O)
            TriggerEvent(GetName(":client:Shop_SetShow"), false)
        end,
        false
    )
end
function ItemIsVaild(z, P)
    local v = Config_xZC_Shop.Zones[z] or nil
    if v then
        if P and P.count and type(P.count) == "number" and P.count > 0 then
            if P.ItemsInclude then
                local Q = Config_xZC_Shop.ItemsInclude[P.ItemsInclude] or nil
                if Q then
                    local R = Q[P.index] or nil
                    if R and P.name and R.name == P.name then
                        return true
                    end
                end
            else
                local E = v.Items[P.index] or nil
                if E and P.name and E.name == P.name then
                    return true
                end
            end
        end
    end
    return false
end
function Blip_Reloaded()
    Citizen.CreateThread(
        function()
            if Config_xZC_Shop.Zones and #Config_xZC_Shop.Zones > 0 then
                if BlipList and #BlipList > 0 then
                    for e, f in ipairs(BlipList) do
                        RemoveBlip(f)
                    end
                end
                BlipList = {}
                for u, v in ipairs(Config_xZC_Shop.Zones) do
                    local S = xZoneClass(u)
                    local T = ESX.GetPlayerData().job
                    if S.Job_IsVaild(T) then
                        Shop_Zones_JobNotAllow[u] = nil
                        if v.Blip and v.Blip.Show and (v.Pos and #v.Pos > 0) then
                            for w, j in ipairs(v.Pos) do
                                local U = v.Blip.Name and v.Blip.Name or v.Name
                                local V = v.Blip.Sprite and v.Blip.Sprite or Config_xZC_Shop.Default.Blip.Sprite
                                local W = v.Blip.Colour and v.Blip.Colour or Config_xZC_Shop.Default.Blip.Colour
                                local X = v.Blip.Scale and v.Blip.Scale or Config_xZC_Shop.Default.Blip.Scale
                                local Y = AddBlipForCoord(j.x, j.y, j.z)
                                SetBlipSprite(Y, V)
                                SetBlipColour(Y, W)
                                SetBlipScale(Y, X)
                                SetBlipAsShortRange(Y, true)
                                BeginTextCommandSetBlipName("STRING")
                                AddTextComponentString(U)
                                EndTextCommandSetBlipName(Y)
                                table.insert(BlipList, Y)
                            end
                        end
                    else
                        Shop_Zones_JobNotAllow[u] = true
                    end
                end
            end
        end
    )
end
function Zone_ItemsRequireIsVaild(z)
    local v = Config_xZC_Shop.Zones[z] or nil
    if v and v.ItemsRequire then
        for e, Z in ipairs(v.ItemsRequire) do
            if not InventoryFindItem(Z) then
                return false
            end
        end
    end
    return true
end
function InventoryFindItem(Z)
    local _ = ESX.GetPlayerData()
    if _ and _.inventory then
        local a0 = false
        for e, f in ipairs(_.inventory) do
            if f.name == Z and f.count > 0 then
                a0 = true
                break
            end
        end
        return a0
    end
    return false
end
function pNotify(a1, type, a2, a3)
    type = type and type or "info"
    a2 = a2 and a2 or 3000
    a3 = a3 and a3 or "bottomCenter"
    TriggerEvent("pNotify:SendNotification", {text = a1, type = type, queue = "xzero_shop", timeout = a2, layout = a3})
end
