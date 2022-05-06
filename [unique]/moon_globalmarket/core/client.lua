local a = nil
RegisEvent(
    true,
    Events.CL.Verify_Receive,
    function(b)
        a = b
    end
)
Citizen.CreateThread(
    function()
        local c = GetGameTimer()
        while a == nil and GetGameTimer() - c <= 30 * 1000 do
            TriggerServerEvent(Events.SV.Verify_Request)
            Wait(300)
        end
        xZero.Init()
    end
)
ESX = nil
_Prograss = false
xZero = {}
xZero.Events = {}
xZero.C = {}
xZero.Funcs = {}
_ItemInfoList = {}
__Identifier = nil
UI_IS_SHOW = false
xZero.Accounts = {}
xZero.Accounts.Money = 0
xZero.Accounts.Black_Money = 0
xZero.Markets = {}
xZero.Player = {}
xZero.Player.InventoryItem = {}
xZero.Player.WeaponsItem = {}
xZero.MPlayer = {}
_current = {}
_current.Market_Name = nil
_current.Market_Items_Selling = {}
_current.Market_Items_Selling_TimeLast = 0
_current.Pos = nil
_last = {}
_last.Market_Name = nil
_Object_List = {}
_fontId = 0
xZero.Init = function()
    Wait(500)
    if a then
        while ESX == nil do
            TriggerEvent(
                Config.Base.getSharedObject,
                function(d)
                    ESX = d
                end
            )
            Wait(1)
        end
        while true do
            if ESX.GetPlayerData() and ESX.GetPlayerData().inventory and #ESX.GetPlayerData().inventory > 0 then
                break
            end
            Wait(1)
        end
        __Identifier = ESX.GetPlayerData().identifier
        xZero.Funcs.ItemInfoList_Get()
        xZero.Inited()
    else
        print("^1Verify:Error^7")
    end
end
xZero.Inited = function()
    print(("Inited - version_current:^3%s^7"):format(version_current))
    SendNUIMessage({type = "CFG_STATIC", STATIC = Config.STATIC})
    SendNUIMessage({type = "SET_PLAYER_GROUP", GROUP = _Admin.IsVaild(__Identifier) and "admin" or "user"})
    xZero.Funcs.Markets_Init()
    xZero.Events.Init()
    RegisterFontFile(Config.DrawText_Font)
    _fontId = RegisterFontId(Config.DrawText_Font)
end
xZero.Funcs.Markets_Init = function()
    xZero.Markets = {}
    local e = Config.Markets and #Config.Markets or 0
    if e > 0 then
        for f = 1, e do
            local g = Config.Markets[f]
            local h = xZero.C.Market(g.name, f)
            if h.IS_Vaild() then
                xZero.Markets[g.name] = h
                print(("^2Market:Loaded^7 - ^3%s^7"):format(g.name))
            end
        end
    end
end
xZero.Events.Init = function()
    RegisEvent(
        false,
        "onResourceStop",
        function(i)
            if i ~= script_name then
                return
            end
            if _Object_List then
                for j, g in pairs(_Object_List) do
                    DeleteEntity(g.Entity)
                end
            end
        end
    )
    Citizen.CreateThread(
        function()
            while true do
                Wait(5)
                if not _Prograss and _current.Market_Name and not UI_IS_SHOW then
                    displayHelpText("Press ~INPUT_CONTEXT~ Enter ~y~Market")
                    if IsControlJustPressed(0, 38) then
                        TriggerEvent(Events.CL.UI_Market_Show_Request, _current.Market_Name)
                        Wait(3000)
                    end
                else
                    Wait(500)
                end
            end
        end
    )
    RegisEvent(
        false,
        Events.CL.UI_Market_Show_Request,
        function(k)
            if _Prograss or not k then
                return
            end
            _Prograss = true
            local h = xZero.Markets[k] or nil
            if not h then
                _Prograss = false
                return
            end
            TSC(
                Events.SV.Market_Items_Selling_Request_CB,
                function(l)
                    if l then
                        if _last.Market_Name == nil or _last.Market_Name ~= k then
                            h.UI_SETUP()
                        end
                        xZero.Funcs.UI_SET_LOADING(true)
                        TriggerEvent(Events.CL.ABP_Reqeust, k)
                        TriggerEvent(Events.CL.MPlayer_DATA_Request, k)
                        Wait(math.random(150, 1000))
                        xZero.Funcs.UI_SET_LOADING(false)
                        _last.Market_Name = k
                        TriggerEvent(Events.CL.UI_SET_IS_SHOW, true)
                    else
                    end
                    _Prograss = false
                end,
                {Market_Name = k}
            )
        end
    )
    RegisEvent(
        false,
        Events.CL.UI_SET_IS_SHOW,
        function(m)
            SendNUIMessage({type = "SET_IS_SHOW", status = m})
            SetNuiFocus(m, m)
            UI_IS_SHOW = m
            TriggerEvent(GetName(":CL:UI:ON_IS_SHOW"), m)
        end
    )
    RegisEvent(
        false,
        Events.CL.UI_ON_IS_SHOW,
        function(m)
            if m then
                TriggerScreenblurFadeIn()
            else
                TriggerScreenblurFadeOut()
            end
            if not m then
                _current.Market_Items_Selling = {}
                xZero.Player.InventoryItem = {}
                xZero.Player.WeaponsItem = {}
                xZero.MPlayer = {}
                collectgarbage()
            end
        end
    )
    RegisEvent(
        true,
        Events.CL.ABP_Reqeust,
        function(k)
            TriggerServerEvent(Events.SV.Accounts_Request)
            TriggerServerEvent(Events.SV.Player_InventoryItem_Request)
            TriggerEvent(Events.CL.Market_Items_Selling_Request, k)
        end
    )
    RegisEvent(
        true,
        Events.CL.Accounts_Receive,
        function(n)
            if n == nil then
                return
            end
            xZero.Accounts = n.Accounts
            SendNUIMessage(
                {
                    type = "SET_PLAYER_ACCOUNTS",
                    Player = {money = xZero.Accounts.Money, black_money = xZero.Accounts.Black_Money}
                }
            )
        end
    )
    xZero.Events.Market_Items_Selling_Request = function(k)
        TriggerServerEvent(Events.SV.Market_Items_Selling_Request, {Market_Name = k})
    end
    RegisEvent(false, Events.CL.Market_Items_Selling_Request, xZero.Events.Market_Items_Selling_Request)
    RegisEvent(
        true,
        Events.CL.Market_Items_Selling_Receive,
        function(n)
            if n == nil then
                return
            end
            _current.Market_Items_Selling = xZero.Funcs.Items_Custom(n.ITEMS)
            _current.Market_Items_Selling_TimeLast = GetGameTimer()
            local o = #_current.Market_Items_Selling
            SendNUIMessage({type = "SET_ITEMS_SELLING", ITEMS = _current.Market_Items_Selling})
            collectgarbage()
        end
    )
    RegisEvent(
        true,
        Events.CL.Player_InventoryItem_Receive,
        function(n)
            if not n then
                return
            end
            xZero.Player.InventoryItem = xZero.Funcs.Player_InventoryItem_Get()
            xZero.Player.WeaponsItem = xZero.Funcs.Player_WeaponsItem_Format(n.WEAPONS) or {}
            local p = {}
            local q = 0
            local r = 0
            r = #xZero.Player.InventoryItem
            if r > 0 then
                for s = 1, r do
                    p[s + q] = xZero.Player.InventoryItem[s]
                end
                q = #p
            end
            r = #xZero.Player.WeaponsItem
            if r > 0 then
                for s = 1, r do
                    p[s + q] = xZero.Player.WeaponsItem[s]
                end
            end
            SendNUIMessage({type = "SET_PLAYER_INV", ITEMS = p})
        end
    )
    RegisEvent(
        true,
        Events.CL.MPlayer_DATA_Request,
        function(t)
            TriggerServerEvent(Events.SV.MPlayer_DATA_Request, t)
        end
    )
    RegisEvent(
        true,
        Events.CL.MPlayer_DATA_Receive,
        function(l)
            xZero.MPlayer = l or {}
            SendNUIMessage(
                {
                    type = "SET_MPLAYER",
                    DATA = {
                        money = xZero.MPlayer.money or 0,
                        black_money = xZero.MPlayer.black_money or 0,
                        money_total = xZero.MPlayer.money_total or 0,
                        black_money_total = xZero.MPlayer.black_money_total or 0,
                        items_sell_total = xZero.MPlayer.items_sell_total or 0,
                        items_selling = xZero.Funcs.Items_Custom(xZero.MPlayer.items_selling)
                    }
                }
            )
        end
    )
    RegisEvent(
        true,
        Events.CL.MPlayer_Items_Sell_History_Receive,
        function(l)
            xZero.MPlayer.Items_Sell_History = xZero.Funcs.Items_Custom(l)
            if xZero.MPlayer.Items_Sell_History and #xZero.MPlayer.Items_Sell_History > 0 then
                table.sort(
                    xZero.MPlayer.Items_Sell_History,
                    function(u, v)
                        return u.time_create > v.time_create
                    end
                )
            end
            SendNUIMessage({type = "SET_MPLAYER_ITEMS_SELL_HISTORY", ITEMS = xZero.MPlayer.Items_Sell_History})
            collectgarbage()
        end
    )
    RegisterNUICallback(
        Events.NUI.Close,
        function(w, x)
            TriggerEvent(Events.CL.UI_SET_IS_SHOW, false)
            x(true)
        end
    )
    RegisterNUICallback(
        Events.NUI.Market_Items_Selling_Request,
        function(w, x)
            if w and w.market_name and _current.Market_Name and _current.Market_Name == w.market_name then
                TriggerEvent(Events.CL.Market_Items_Selling_Request, _current.Market_Name)
            end
            Wait(500)
            x(true)
        end
    )
    RegisterNUICallback(
        Events.NUI.Market_Items_Selling_Cancel_Request,
        function(w, x)
            if _Prograss or not _current.Market_Name then
                x(false)
                return
            end
            _Prograss = true
            local y = math.random(1000)
            Wait(y)
            TSC(
                Events.SV.Market_Items_Selling_Cancel_Request_CB,
                function(z)
                    local A = {}
                    A.status = z and "SUCCESS" or "ERROR"
                    if z then
                        TriggerEvent(Events.CL.ABP_Reqeust, _current.Market_Name)
                        TriggerEvent(Events.CL.MPlayer_DATA_Request, _current.Market_Name)
                    end
                    Wait(250)
                    x(A)
                    _Prograss = false
                end,
                w
            )
        end
    )
    RegisterNUICallback(
        Events.NUI.Market_Items_Selling_Remove_Request,
        function(w, x)
            if _Prograss or not _current.Market_Name then
                x(false)
                return
            end
            _Prograss = true
            TSC(
                Events.SV.Market_Items_Selling_Remove_Request_CB,
                function(z)
                    if z then
                        TriggerEvent(Events.CL.ABP_Reqeust, _current.Market_Name)
                        TriggerEvent(Events.CL.MPlayer_DATA_Request, _current.Market_Name)
                    end
                    x(z)
                    _Prograss = false
                end,
                w
            )
        end
    )
    RegisterNUICallback(
        Events.NUI.Market_Buy_Item_Request,
        function(w, x)
            if _Prograss or not _current.Market_Name or not Funcs.Market_Buy_Item_Vaild_DATA(w) then
                x(false)
                return
            end
            local y = math.random(1000)
            Wait(y)
            local h = xZero.Markets[_current.Market_Name]
            if not h.CFG_Market.Job_Require(ESX.GetPlayerData().job.name, "buy") then
                UI_Notify_T("job_require_error", "error")
                x(false)
                return
            end
            if not h.Items_Require("buy") then
                UI_Notify_T("items_buy_require_error", "error")
                x(false)
                return
            end
            _Prograss = true
            TSC(
                Events.SV.Market_Buy_Item_Request_CB,
                function(z)
                    local A = {}
                    A.status = z and "SUCCESS" or "ERROR"
                    if z then
                        TriggerEvent(Events.CL.ABP_Reqeust, _current.Market_Name)
                        TriggerEvent(Events.CL.MPlayer_DATA_Request, _current.Market_Name)
                    end
                    Wait(250)
                    x(A)
                    _Prograss = false
                end,
                w
            )
        end
    )
    RegisterNUICallback(
        Events.NUI.Market_Sell_Item_Request,
        function(w, x)
            if _Prograss or not _current.Market_Name or not Funcs.Market_Sell_Item_Vaild_DATA(w) then
                x(false)
                return
            end
            local y = math.random(1000)
            Wait(y)
            local h = xZero.Markets[_current.Market_Name]
            if not h.CFG_Market.Job_Require(ESX.GetPlayerData().job.name, "sell") then
                UI_Notify_T("job_require_error", "error")
                x(false)
                return
            end
            if not h.Items_Require("sell") then
                UI_Notify_T("items_sell_require_error", "error")
                x(false)
                return
            end
            if not Funcs.Market_Items_Sell_BL(w.item_name) or not h.CFG_Market.Items_Sell_BL(w.item_name) then
                UI_Notify_T("items_sell_bl_error", "error", w.item_label)
                x(false)
                return
            end
            if not h.CFG_Market.Items_Sell_Only(w.item_name) then
                UI_Notify_T("items_sell_only_error", "error", w.item_label)
                x(false)
                return
            end
            _Prograss = true
            TSC(
                Events.SV.Market_Sell_Item_Reqeust_CB,
                function(z)
                    local A = {}
                    A.status = A and "SUCCESS" or "ERROR"
                    A.item_selected_clear = z
                    if z then
                        TriggerEvent(Events.CL.ABP_Reqeust, _current.Market_Name)
                        TriggerEvent(Events.CL.MPlayer_DATA_Request, _current.Market_Name)
                    end
                    Wait(250)
                    x(A)
                    _Prograss = false
                end,
                {
                    market_name = _current.Market_Name,
                    item_name = w.item_name,
                    item_label = w.item_label,
                    item_type = w.item_type,
                    price = w.price,
                    price_type = w.price_type,
                    count = w.count
                }
            )
        end
    )
    RegisterNUICallback(
        Events.NUI.MPlayer_Items_Sell_History_Request,
        function(w, x)
            if not _current.Market_Name then
                x(false)
                return
            end
            TriggerServerEvent(Events.SV.MPlayer_Items_Sell_History_Reqeust, _current.Market_Name)
            Wait(500)
            x(true)
        end
    )
    RegisterNUICallback(
        Events.NUI.Withdraw_Money_Request,
        function(w, x)
            if _Prograss or not _current.Market_Name then
                x(false)
                return
            end
            _Prograss = true
            local y = math.random(1000)
            Wait(y)
            TriggerServerEvent(Events.SV.Withdraw_Money_Request, _current.Market_Name)
            Wait(300)
            x(true)
            _Prograss = false
        end
    )
    RegisEvent(
        false,
        Events.CL.Pos_IsIn_Enter,
        function(k, B)
            _current.Market_Name = k
            _current.Pos = B
        end
    )
    RegisEvent(
        false,
        Events.CL.Pos_IsIn_Exit,
        function(k)
            _current.Market_Name = nil
            _current.Pos = nil
        end
    )
    RegisterCommand(
        "closemarket",
        function(D, E)
            TriggerEvent(Events.CL.UI_SET_IS_SHOW, false)
        end,
        false
    )
end
xZero.Funcs.ItemInfoList_Get = function()
    local F = ESX.GetPlayerData().inventory and #ESX.GetPlayerData().inventory or 0
    if F > 0 then
        for s = 1, F do
            local g = ESX.GetPlayerData().inventory[s]
            _ItemInfoList[g.name] = {label = g.label, type = "item_standard", limit = g.limit}
        end
    end
    local G = ESX.GetWeaponList()
    local H = G and #G or 0
    if H > 0 then
        for s = 1, H do
            local g = G[s]
            _ItemInfoList[g.name] = {label = g.label, type = "item_weapon"}
        end
        G = nil
    end
    collectgarbage()
end
xZero.Funcs.Player_InventoryItem_Get = function()
    local I = {}
    local J = ESX.GetPlayerData().inventory
    local K = J and #J or 0
    local r = 0
    if K > 0 then
        for s = 1, K do
            local g = J[s]
            if g.count > 0 then
                r = r + 1
                I[r] = {
                    index = r,
                    name = g.name,
                    label = g.label,
                    type = "item_standard",
                    count = g.count,
                    control = Funcs.Market_Items_Control(g.name)
                }
            end
        end
    end
    return I
end
xZero.Funcs.Player_WeaponsItem_Format = function(L)
    local I = nil
    local M = L and #L or 0
    if M > 0 then
        I = {}
        for s = 1, M do
            local g = L[s]
            I[s] = {
                index = s,
                name = g.name,
                label = g.label,
                type = "item_weapon",
                count = 1,
                options = {ammo = g.ammo, components = g.components or nil},
                control = Funcs.Market_Items_Control(g.name)
            }
        end
    end
    return I
end
xZero.Funcs.Player_InventoryHas = function(N, r)
    local J = ESX.GetPlayerData().inventory or {}
    local O = #J
    if O <= 0 then
        return false
    end
    local P = nil
    for s = 1, O do
        local g = J[s]
        if g.name == N then
            P = g
            break
        end
    end
    if not P or P.count < r then
        return false
    end
    return true
end
xZero.Funcs.Items_Custom = function(Q)
    local R = Q and #Q or 0
    if R > 0 then
        for s = 1, R do
            local g = Q[s]
            local S = _ItemInfoList[g.name] or {}
            g.label = S.label or nil
            g.type = S.type or nil
            g.category = Config.Market_Items_Categorys[g.name] or nil
        end
        return Q
    end
    return {}
end
xZero.Funcs.UI_SET_LOADING = function(m)
    SendNUIMessage({type = "SET_LOADING", LOADING = {show = m}})
end
UI_Notify = function(T, U, V, W)
    SendNUIMessage({type = "NOTIFY", Notify = {text = T, type = U, title = V, option = W}})
end
UI_Notify_T = function(X, U, V, W)
    local Y = Config.T[X] or nil
    if Y ~= nil then
        UI_Notify(Y, U, V, W)
    end
end
RegisEvent(true, Events.CL.UI_Notify, UI_Notify)
displayHelpText = function(Z)
    SetTextComponentFormat("STRING")
    AddTextComponentString(Z)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
drawText3D = function(_, Z, a0, a1)
    local a2, a3, a4 = World3dToScreen2d(_.x, _.y, _.z)
    if a2 then
        local a5 = GetGameplayCamCoords()
        local a6 = GetDistanceBetweenCoords(a5.x, a5.y, a5.z, _.x, _.y, _.z, 1)
        local a7 = a0 / a6 * 2
        local a8 = 1 / GetGameplayCamFov() * 100
        a7 = a7 * a8
        SetTextScale(0.0 * a7, 0.55 * a7)
        SetTextFont(a1 or 0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(Z)
        DrawText(a3, a4)
    end
end
xZero.C.Market = function(a9, aa)
    local self = {}
    self.Vaild = false
    self.name = a9
    self.CFG_Market_index = aa
    self.CFG_Market = nil
    self.CFG_Market_Pos_Count = 0
    self.Blip_List = {}
    self.Pos_IsIn = false
    self.Pos_Last = nil
    self.IS_Vaild = function()
        self.Vaild = self.CFG_Market_Get() and true or false
        self.CFG_Market_Pos_Count = #self.CFG_Market.Pos()
        self.Blip_Init()
        self.Pos_IsIn_Init()
        self.DrawText_Init()
        self.Marker_Init()
        self.Object_Init()
        return self.Vaild
    end
    self.CFG_Market_Get = function()
        local ab = C.CFG_Market(self.name, self.CFG_Market_index)
        self.CFG_Market = ab.IS_Vaild() and ab or nil
        return self.CFG_Market
    end
    self.UI_SETUP = function()
        SendNUIMessage(
            {
                type = "CFG_SETUP",
                Market_Name = self.CFG_Market.name,
                Categorys = self.CFG_Market.Categorys_Get(),
                VAT = self.CFG_Market.VAT_Get(),
                Price_Type_EB = self.CFG_Market.Price_Type_EB()
            }
        )
        return true
    end
    self.Blip_Init = function()
        if self.CFG_Market.Blip_Show() and self.CFG_Market_Pos_Count > 0 then
            local ac = self.CFG_Market.CFG.blip
            for s = 1, self.CFG_Market_Pos_Count do
                local ad = self.CFG_Market.CFG.pos[s]
                local ae = AddBlipForCoord(ad.x, ad.y, ad.z)
                SetBlipSprite(ae, ac.sprite)
                SetBlipColour(ae, ac.colour)
                SetBlipScale(ae, ac.scale)
                SetBlipAsShortRange(ae, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(ac.label)
                EndTextCommandSetBlipName(ae)
                table.insert(self.Blip_List, ae)
            end
        end
    end
    self.Pos_IsIn_Init = function()
        if self.CFG_Market_Pos_Count > 0 then
            local af = self.CFG_Market.CFG.press_distance or 1.5
            Citizen.CreateThread(
                function()
                    while true do
                        Wait(100)
                        local ag = false
                        local ah = nil
                        for s = 1, self.CFG_Market_Pos_Count do
                            local ad = self.CFG_Market.CFG.pos[s]
                            local ai = #(GetEntityCoords(PlayerPedId()) - vector3(ad.x, ad.y, ad.z))
                            if ai <= af then
                                ag = true
                                ah = vector3(ad.x, ad.y, ad.z)
                                break
                            end
                            Wait(1)
                        end
                        if ag and not self.Pos_IsIn then
                            self.Pos_IsIn = true
                            self.Pos_Last = ah
                            TriggerEvent(Events.CL.Pos_IsIn_Enter, self.name, self.Pos_Last)
                        end
                        if not ag and self.Pos_IsIn then
                            self.Pos_IsIn = false
                            self.Pos_Last = nil
                            TriggerEvent(Events.CL.Pos_IsIn_Exit, self.name)
                        end
                    end
                end
            )
        end
    end
    self.DrawText_Init = function()
        if self.CFG_Market.DarwText_Show() and self.CFG_Market_Pos_Count > 0 then
            local aj = self.CFG_Market.CFG.drawtext
            Citizen.CreateThread(
                function()
                    while true do
                        Wait(5)
                        if not UI_IS_SHOW then
                            local ag = false
                            for s = 1, self.CFG_Market_Pos_Count do
                                local ad = self.CFG_Market.CFG.pos[s]
                                local ak = vector3(ad.x, ad.y, ad.z)
                                local ai = #(GetEntityCoords(PlayerPedId()) - ak)
                                if ai <= aj.distance then
                                    ag = true
                                    drawText3D(ak + vector3(0, 0, aj.z), aj.label, aj.size, _fontId)
                                end
                            end
                            if not ag then
                                Wait(500)
                            end
                        end
                    end
                end
            )
        end
    end
    self.Marker_Init = function()
        if self.CFG_Market.Marker_Show() and self.CFG_Market_Pos_Count > 0 then
            local al = self.CFG_Market.CFG.marker
            Citizen.CreateThread(
                function()
                    while true do
                        Wait(1)
                        if not UI_IS_SHOW then
                            local ag = false
                            for s = 1, self.CFG_Market_Pos_Count do
                                local ad = self.CFG_Market.CFG.pos[s]
                                local ai = #(GetEntityCoords(PlayerPedId()) - vector3(ad.x, ad.y, ad.z))
                                if ai <= al.distance then
                                    ag = true
                                    DrawMarker(
                                        al.type,
                                        ad.x,
                                        ad.y,
                                        ad.z,
                                        0.0,
                                        0.0,
                                        0.0,
                                        0,
                                        0.0,
                                        0.0,
                                        al.size.x,
                                        al.size.y,
                                        al.size.z,
                                        al.color.r,
                                        al.color.g,
                                        al.color.b,
                                        100,
                                        false,
                                        true,
                                        2,
                                        false,
                                        false,
                                        false,
                                        false
                                    )
                                end
                            end
                            if not ag then
                                Wait(500)
                            end
                        end
                    end
                end
            )
        end
    end
    self.Object_Init = function()
        if self.CFG_Market.Object_Show() and self.CFG_Market_Pos_Count > 0 then
            local am = self.CFG_Market.CFG.object
            for s = 1, self.CFG_Market_Pos_Count do
                local ad = self.CFG_Market.CFG.pos[s]
                local an = ad.h or 0
                __Obj(
                    am.model,
                    ad,
                    an,
                    am.type,
                    function(z)
                        _Object_List[z.Entity] = z
                    end
                ).Create()
            end
        end
    end
    self.Items_Require = function(U)
        local ao = self.CFG_Market.Get("items_" .. U .. "_require") or {}
        local ap = #ao
        if ap > 0 then
            for s = 1, ap do
                if not xZero.Funcs.Player_InventoryHas(ao[s], 1) then
                    return false
                end
            end
        end
        return true
    end
    return self
end
__Obj = function(aq, ad, an, U, ar)
    local self = {}
    self.model = aq
    self.pos = ad
    self.h = an
    self.type = U
    self.CB_Finsh = ar
    self.Entity = nil
    self.Create = function()
        Citizen.CreateThread(
            function()
                RequestModel(self.model)
                while not HasModelLoaded(self.model) do
                    Wait(100)
                end
                self.Entity = CreatePed(4, self.model, self.pos.x, self.pos.y, self.pos.z, self.h, false, true)
                SetEntityHeading(self.Entity, self.h)
                FreezeEntityPosition(self.Entity, true)
                SetEntityInvincible(self.Entity, true)
                SetBlockingOfNonTemporaryEvents(self.Entity, true)
                if self.CB_Finsh ~= nil then
                    self.CB_Finsh(self)
                end
            end
        )
    end
    return self
end
_TSC = {}
_TSC.CurrentReqId = 0
_TSC.Callbacks = {}
TSC = function(as, x, ...)
    _TSC.Callbacks[_TSC.CurrentReqId] = x
    TriggerServerEvent(Events.SV.TSC_Request, as, _TSC.CurrentReqId, ...)
    _TSC.CurrentReqId = _TSC.CurrentReqId + 1
end
RegisEvent(
    true,
    Events.CL.TSC_Receive,
    function(at, ...)
        _TSC.Callbacks[at](...)
        _TSC.Callbacks[at] = nil
    end
)
