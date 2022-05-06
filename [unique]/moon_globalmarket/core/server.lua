local a = nil
local b = nil
local c = 10
Citizen.CreateThread(function()
		a = true
		xZero.Init()
        -- local d = json.encode(
            -- {
                -- Server = GetConvar("sv_hostname"),
                -- MaxClients = GetConvar("sv_maxclients"),
                -- CurrentResourceName = script_name,
                -- version_current = version_current
            -- }
        -- )
        -- local e = "http://xzero.in.th/xFiveM/xzero_scripts/xzero_market.php?x=" .. math.random(10000000, 99999999)
        -- local f = 0
        -- b = function()
            -- PerformHttpRequest(
                -- e,
                -- function(g, h, i)
                    -- if g == 200 then
                        -- local j = json.decode(h)
                        -- if j and j.status == "success" then
                            -- a = true
                            -- version_lasted = j.version_lasted
                            -- print(("^2[%s]^7 ^0Verify Success^7"):format(script_name))
                            -- xZero.Init()
                        -- else
                            -- a = false
                            -- print(("^1[%s] Verify Error^7"):format(script_name))
                        -- end
                    -- else
                        -- f = f + 1
                        -- if f > c then
                            -- return
                        -- end
                        -- print(
                            -- ("^1[%s] Verify Error Request TimeOut - %s | AttemptCount ^3%s/%s^7"):format(
                                -- script_name,
                                -- g,
                                -- f,
                                -- c
                            -- )
                        -- )
                        -- Wait(math.random(1000, 3000))
                        -- b()
                    -- end
                -- end,
                -- "POST",
                -- d,
                -- {["Content-Type"] = "application/json"}
            -- )
        -- end
        -- b()
    end)
RegisEvent(
    true,
    Events.SV.Verify_Request,
    function()
        TriggerClientEvent(Events.CL.Verify_Receive, source, a)
    end
)
ESX = nil
MySQL_Init = nil
xZero = {}
xZero.Events = {}
xZero.C = {}
xZero.Funcs = {}
xZero.MPlayers = {}
xZero.MPlayer = {}
xZero.MPlayer.Items_Sell_History_ShowLimit = 50
xZero.MPlayer.Items_Sell_History_ClearDay = 30
xZero.Markets = {}
xZero.Markets_id_key = {}
__Prograss_Id = {}
gcPhone = {}
gcPhone.phoneNumberByIden = {}
xZero.Init = function()
    Wait(500)
    if a then
        while ESX == nil do
            TriggerEvent(
                Config.Base.getSharedObject,
                function(k)
                    ESX = k
                end
            )
            Wait(1)
        end
        MySQL.ready(
            function()
                MySQL_Init = true
            end
        )
        while MySQL_Init == nil do
            Wait(1)
        end
        xZero.Inited()
    end
end
xZero.Inited = function()
    if version_lasted ~= nil and tonumber(version_current) < tonumber(version_lasted) then
        pr(string.format("Inited - version_current:^1%s^7 (version_lasted:^3%s^7)", version_current, version_lasted))
    else
        pr(string.format("Inited - version_current:^3%s^7", version_current))
    end
    xZero.Funcs.MPlayer_Init()
    xZero.Funcs.Markets_Init()
    xZero.Funcs.MPlayer_Items_Sell_History_ClearDay()
    xZero.Events.Init()
end
xZero.Funcs.MPlayer_Init = function()
    xZero.MPlayers = {}
    local l = MySQL.Sync.fetchAll(("SELECT * FROM %s"):format(Config.SQL.Tables.Market_Players))
    local m = l and #l or 0
    if m > 0 then
        for n = 1, m do
            local o = l[n]
            local p = xZero.MPlayer_Get(o.identifier)
            local q = p.Market_Get(o.market_name)
            q["id"] = o.id
            q["MySQL_IsCreated"] = true
            p.Account_Set(o.market_name, "money", o.money)
            p.Account_Set(o.market_name, "black_money", o.black_money)
            p.Account_Total_Set(o.market_name, "money", o.money_total)
            p.Account_Total_Set(o.market_name, "black_money", o.black_money_total)
            p.Items_Sell_Total_Set(o.market_name, o.items_sell_total)
        end
        pr(("MPlayers:Loaded - ^3%s^7"):format(m))
    end
    l = nil
    collectgarbage()
end
xZero.Funcs.MPlayer_Items_Sell_History_ClearDay = function()
    MySQL.Async.execute(
        ([[
        DELETE FROM %s WHERE time_create <= date_sub(now(), interval @day day)
    ]]):format(
            Config.SQL.Tables.Market_Items_Sell_History
        ),
        {["@day"] = xZero.MPlayer.Items_Sell_History_ClearDay},
        function(r)
            pr(("Items Sell History Clear - ^3%s^7"):format(r))
        end
    )
end
xZero.Funcs.Markets_Init = function()
    xZero.Markets = {}
    local s = Config.Markets and #Config.Markets or 0
    if s > 0 then
        for t = 1, s do
            local o = Config.Markets[t]
            if not xZero.Markets[o.name] then
                local q = xZero.C.Market(o.name, t)
                if q.IS_Vaild() then
                    xZero.Markets[o.name] = q
                    pr(("Market:Loaded - ^3%s^7 | items_selling:^3%s^7"):format(q.name, q.Items_Selling_currentIndex))
                end
            end
        end
    end
end
xZero.Events.Init = function()
    RegisEvent(
        true,
        Events.SV.Accounts_Request,
        function()
            local u = source
            local v = ESX.GetPlayerFromId(u)
            if not v then
                return
            end
            local w = xZero.C.PlayerAccounts(v)
            TriggerClientEvent(
                Events.CL.Accounts_Receive,
                u,
                {Accounts = {Money = w.Get("money"), Black_Money = w.Get("black_money")}}
            )
        end
    )
    RSC(
        Events.SV.Market_Items_Selling_Request_CB,
        function(u, x, y)
            local v = ESX.GetPlayerFromId(u)
            local z = v.getIdentifier()
            if not v or not y or not y.Market_Name or not xZero.Markets[y.Market_Name] then
                cb(false)
                return
            end
            local p = xZero.MPlayers[z] or nil
            if not p then
                x(true)
                return
            end
            p.Items_Sell_History_GetFromMySQL(
                y.Market_Name,
                function(j)
                    x(true)
                end
            )
        end
    )
    RegisEvent(
        true,
        Events.SV.Market_Items_Selling_Request,
        function(y)
            if not y or not y.Market_Name or not xZero.Markets[y.Market_Name] then
                return
            end
            local u = source
            TriggerClientEvent(
                Events.CL.Market_Items_Selling_Receive,
                u,
                {ITEMS = xZero.Markets[y.Market_Name].Items_Selling}
            )
        end
    )
    RegisEvent(
        true,
        Events.SV.Player_InventoryItem_Request,
        function()
            local u = source
            local v = ESX.GetPlayerFromId(u)
            if not v then
                return
            end
            TriggerClientEvent(Events.CL.Player_InventoryItem_Receive, u, {WEAPONS = v.getLoadout() or {}})
        end
    )
    RSC(
        Events.SV.Market_Buy_Item_Request_CB,
        function(u, x, y)
            local v = ESX.GetPlayerFromId(u)
            if not v or not Funcs.Market_Buy_Item_Vaild_DATA(y) then
                x(false)
                return
            end
            local z = v.getIdentifier()
            local q = xZero.Markets[y.market_name] or nil
            if not q or q.Prograss_Buy_Item then
                UI_Notify_T(u, "prograss_error", "error")
                x(false)
                return
            end
            q.Prograss_Buy_Item = true
            if not q.Item_Vaild_DATA(y) then
                TriggerClientEvent(Events.CL.ABP_Reqeust, u, q.name)
                UI_Notify_T(u, "item_vaild_error", "info")
                q.Prograss_Buy_Item = false
                x(false)
                return
            end
            local A = q.Items_Selling[y.index]
            local B = y.count * A.price
            local D = q.CFG_Market.CFG.buy_myitem or nil
            if not D and z == A.owner_iden then
                UI_Notify_T(u, "buy_myitem_error", "error")
                q.Prograss_Buy_Item = false
                x(false)
                return
            end
            local p = xZero.MPlayers[A.owner_iden] or nil
            if not p or not p.Market_Get(q.name)["MySQL_IsCreated"] then
                UI_Notify(u, "MPlayer Invaild", "error")
                q.Prograss_Buy_Item = false
                x(false)
                return
            end
            local E = xZero.C.PlayerAccounts(v)
            if E.Get(A.price_type) < B then
                UI_Notify_T(u, "player_account_error", "error")
                q.Prograss_Buy_Item = false
                x(false)
                return
            end
            if not xZero.Funcs.Player_InventoryIsFree(v, A.name, y.count, y.item_type) then
                UI_Notify_T(u, "player_inventory_isfull", "error")
                q.Prograss_Buy_Item = false
                x(false)
                return
            end
            E.Remove(A.price_type, B)
            xZero.Funcs.Player_Item_Market_Add(v, A, y.count, y.item_type)
            xZero.MPlayer_Insert_History(p, q.name, A, y.count, z)
            A.count = A.count - y.count
            if A.count <= 0 then
                q.Items_Selling_Slots = q.Items_Selling_Slots - 1
            end
            q.Items_Selling_Save(A.index)
            local F = q.VAT_Price("after", B)
            local G = B - F
            if A.count <= 0 then
                p.Items_Selling_Remove(q.name, A.index)
            end
            p.Account_Set(q.name, A.price_type, p.Account_Get(q.name, A.price_type) + G)
            p.Account_Total_Set(q.name, A.price_type, p.Account_Total_Get(q.name, A.price_type) + G)
            p.Items_Sell_Total_Set(q.name, p.Items_Sell_Total_Get(q.name) + y.count)
            p.MySQL_Save(q.name)
            UI_Notify_T(u, "buy_success", "success", ("%s [x%s]"):format(y.item_label, y.count))
            TriggerEvent(
                Events.SV.Market_Buy_Item_Success,
                q.name,
                v,
                {
                    owner_iden = A.owner_iden,
                    item_name = y.item_name,
                    item_label = y.item_label,
                    item_type = y.item_type,
                    count = y.count,
                    price = A.price,
                    price_type = A.price_type,
                    price_all = B,
                    vat_price = F
                }
            )
            q.Prograss_Buy_Item = false
            x(true)
        end
    )
    RSC(
        Events.SV.Market_Sell_Item_Reqeust_CB,
        function(u, x, y)
            local v = ESX.GetPlayerFromId(u)
            if not v or not Funcs.Market_Sell_Item_Vaild_DATA(y) then
                x(false)
                return
            end
            local z = v.getIdentifier()
            local q = xZero.Markets[y.market_name] or nil
            if not q or q.Prograss_Sell_Item then
                UI_Notify_T(u, "prograss_error", "error")
                x(false)
                return
            end
            local H = v.getJob()
            if not q.CFG_Market.Job_Require(H.name, "sell") or not q.Items_Require(v, "sell") then
                x(false)
                return
            end
            local I = q.CFG_Market.Price_Type_EB()[y.price_type] or false
            local J = Funcs.Market_Items_Control(y.item_name)
            local K = J["price_" .. y.price_type]
            I = I and not K and false or I
            if
                not I or y.count < J.count_min or J.count_max ~= -1 and y.count > J.count_max or y.price < J.price_min or
                    J.price_max ~= -1 and y.price > J.price_max
             then
                x(false)
                return
            end
            local L = Funcs.array_IsInOne(J.jobs, H.name)
            if L ~= nil and not L then
                UI_Notify_T(u, "job_require_error", "error")
                x(false)
                return
            end
            if not q.CFG_Market.Items_Sell_Only(y.item_name) then
                UI_Notify_T(u, "items_sell_only_error", "error", y.item_label)
                cb(false)
                return
            end
            q.Prograss_Sell_Item = true
            local p = xZero.MPlayer_Get(z)
            p.MySQL_Create(
                q.name,
                function(M)
                    if not M then
                        UI_Notify(u, "MPlayer IsCreated Error", "error")
                        q.Prograss_Sell_Item = false
                        x(false)
                        return
                    end
                    p.Items_Sell_History_GetFromMySQL(q.name)
                    if not q.Sell_Item_Limit_Check(p) then
                        UI_Notify_T(u, "sell_item_limit_error", "error")
                        q.Prograss_Sell_Item = false
                        x(false)
                        return
                    end
                    if not xZero.Funcs.Player_InventoryHas(v, y.item_name, y.count, y.item_type) then
                        q.Prograss_Sell_Item = false
                        x(false)
                        return
                    end
                    local B = y.price * y.count
                    local F = q.VAT_Price("before", B)
                    if F > 0 then
                        local N = xZero.C.PlayerAccounts(v)
                        if N.Get(y.price_type) < F then
                            UI_Notify_T(u, "player_vat_price_error", "error")
                            q.Prograss_Sell_Item = false
                            x(false)
                            return
                        end
                        N.Remove(y.price_type, F)
                    end
                    y.owner_iden = z
                    y.item_Options = xZero.Funcs.Item_Options_Get(v, y.item_name, y.item_type)
                    if y.item_type == "item_standard" then
                        v.removeInventoryItem(y.item_name, y.count)
                    elseif y.item_type == "item_weapon" then
                        v.removeWeapon(y.item_name)
                    end
                    y.id_key = q.Gen_id_key()
                    q.Items_Selling_Insert(
                        y,
                        function(j)
                            if j then
                                UI_Notify_T(u, "sell_success", "success", ("%s [x%s]"):format(y.item_label, y.count))
                                TriggerEvent(
                                    Events.SV.Market_Sell_Item_Success,
                                    q.name,
                                    v,
                                    {
                                        item_name = y.item_name,
                                        item_label = y.item_label,
                                        item_type = y.item_type,
                                        count = y.count,
                                        price = y.price,
                                        price_type = y.price_type,
                                        price_all = B,
                                        vat_price = F
                                    }
                                )
                            else
                                UI_Notify(u, "Items Selling Insert", "error")
                            end
                            y = nil
                            q.Prograss_Sell_Item = false
                            x(j)
                        end
                    )
                end
            )
        end
    )
    RSC(
        Events.SV.Market_Items_Selling_Cancel_Request_CB,
        function(u, x, y)
            local v = ESX.GetPlayerFromId(u)
            if not v or not Funcs.Market_Items_Selling_Vaild_DATA(y) then
                x(false)
                return
            end
            local z = v.getIdentifier()
            local q = xZero.Markets[y.market_name] or nil
            if not q or q.Prograss_Buy_Item then
                UI_Notify_T(u, "prograss_error", "error")
                x(false)
                return
            end
            q.Prograss_Buy_Item = true
            local A = q.Items_Selling[y.index] or nil
            if not A or A.count <= 0 or A.owner_iden ~= z or A.id_key ~= y.id_key then
                TriggerClientEvent(Events.CL.ABP_Reqeust, u, q.name)
                TriggerClientEvent(Events.CL.MPlayer_DATA_Request, u, q.name)
                UI_Notify_T(u, "item_vaild_error", "info")
                q.Prograss_Buy_Item = false
                x(false)
                return
            end
            local p = xZero.MPlayers[A.owner_iden] or nil
            if not p or not p.Market_Get(q.name)["MySQL_IsCreated"] then
                UI_Notify(u, "MPlayer Invaild", "error")
                q.Prograss_Buy_Item = false
                x(false)
                return
            end
            if not q.Items_Sell_Cancel_Vaild(u, A) then
                q.Prograss_Buy_Item = false
                x(false)
                return
            end
            local O = A.count
            if not xZero.Funcs.Player_InventoryIsFree(v, A.name, O, y.item_type) then
                UI_Notify_T(u, "player_inventory_isfull", "error")
                q.Prograss_Buy_Item = false
                x(false)
                return
            end
            xZero.Funcs.Player_Item_Market_Add(v, A, O, y.item_type)
            A.count = 0
            q.Items_Selling_Save(A.index)
            p.Items_Selling_Remove(q.name, A.index)
            UI_Notify_T(u, "items_selling_cancel_success", "success", ("%s [x%s]"):format(y.item_label, O))
            TriggerEvent(
                Events.SV.Market_Items_Selling_Success,
                q.name,
                v,
                {
                    item_name = y.item_name,
                    item_label = y.item_label,
                    item_type = y.item_type,
                    count = O,
                    price = A.price,
                    price_type = A.price_type
                }
            )
            q.Prograss_Buy_Item = false
            x(true)
        end
    )
    RSC(
        Events.SV.Market_Items_Selling_Remove_Request_CB,
        function(u, x, y)
            local v = ESX.GetPlayerFromId(u)
            if not v or not Funcs.Market_Items_Selling_Vaild_DATA(y) then
                x(false)
                return
            end
            local z = v.getIdentifier()
            if not _Admin.IsVaild(z) then
                x(false)
                return
            end
            local q = xZero.Markets[y.market_name] or nil
            if not q or q.Prograss_Buy_Item then
                UI_Notify_T(u, "prograss_error", "error")
                x(false)
                return
            end
            q.Prograss_Buy_Item = true
            local A = q.Items_Selling[y.index] or nil
            local P = 0
            if not A or A.count <= 0 or A.id_key ~= y.id_key then
                TriggerClientEvent(Events.CL.ABP_Reqeust, u, q.name)
                TriggerClientEvent(Events.CL.MPlayer_DATA_Request, u, q.name)
                UI_Notify_T(u, "item_vaild_error", "info")
                q.Prograss_Buy_Item = false
                x(false)
                return
            end
            P = A.count
            A.count = 0
            q.Items_Selling_Save(A.index)
            local p = xZero.MPlayers[A.owner_iden] or nil
            if p then
                p.Items_Selling_Remove(q.name, A.index)
            end
            UI_Notify_T(u, "items_selling_remove_success", "success", ("%s [x%s]"):format(y.item_label, P))
            q.Prograss_Buy_Item = false
            x(true)
        end
    )
    RegisEvent(
        true,
        Events.SV.MPlayer_DATA_Request,
        function(Q)
            local u = source
            local v = ESX.GetPlayerFromId(u)
            local p = xZero.MPlayers[v.getIdentifier()] or nil
            local q = xZero.Markets[Q] or nil
            if not v or not q or not p then
                return
            end
            local R = p.Market_Get(Q)
            local S = {}
            local T = R["items_selling"] or {}
            local U = #T
            if U > 0 then
                for n = 1, U do
                    local t = T[n]
                    S[n] = q.Items_Selling[t]
                end
            end
            TriggerClientEvent(
                Events.CL.MPlayer_DATA_Receive,
                u,
                {
                    money = R.money,
                    black_money = R.black_money,
                    money_total = R.money_total,
                    black_money_total = R.black_money_total,
                    items_sell_total = R.items_sell_total,
                    items_selling = S
                }
            )
        end
    )
    RegisEvent(
        true,
        Events.SV.MPlayer_Items_Sell_History_Reqeust,
        function(Q)
            local u = source
            local v = ESX.GetPlayerFromId(u)
            local p = xZero.MPlayers[v.getIdentifier()] or nil
            if not v or not p then
                return
            end
            local R = p.Market_Get(Q)
            TriggerClientEvent(Events.CL.MPlayer_Items_Sell_History_Receive, u, R["items_sell_history"] or {})
        end
    )
    RegisEvent(
        true,
        Events.SV.Withdraw_Money_Request,
        function(Q)
            local u = source
            local v = ESX.GetPlayerFromId(u)
            local p = xZero.MPlayers[v.getIdentifier()] or nil
            if not p or __Prograss_Id[u] then
                return
            end
            __Prograss_Id[u] = true
            local V = p.Account_Get(Q, "money")
            local W = p.Account_Get(Q, "black_money")
            if V <= 0 and W <= 0 then
                UI_Notify_T(u, "withdraw_player_account_error", "error", "ถอนเงิน")
                __Prograss_Id[u] = nil
                return
            end
            local E = xZero.C.PlayerAccounts(v)
            E.Add("money", V)
            E.Add("black_money", W)
            p.Account_Set(Q, "money", 0)
            p.Account_Set(Q, "black_money", 0)
            p.MySQL_Save(Q)
            TriggerClientEvent(Events.CL.ABP_Reqeust, u, Q)
            TriggerClientEvent(Events.CL.MPlayer_DATA_Request, u, Q)
            UI_Notify_T(u, "withdraw_success", "success", "ถอนเงิน")
            local X = Config.DC.Market_WithDraw_Money or nil
            if X and X.enabled and X.url_webhook then
                DC_Logs(X, Q, X.template.desc:format(v.getIdentifier(), v.getName(), V, W))
            end
            __Prograss_Id[u] = nil
        end
    )
    RegisEvent(
        false,
        Events.SV.Market_Buy_Item_Success,
        function(Y, v, y)
            local X = Config.DC.Market_Buy_Item or nil
            if X and X.enabled and X.url_webhook then
                DC_Logs(
                    X,
                    Y,
                    X.template.desc:format(
                        v.getIdentifier(),
                        v.getName(),
                        y.owner_iden,
                        y.item_name,
                        y.item_label,
                        y.count,
                        y.price,
                        y.price_type,
                        y.price_all,
                        y.vat_price
                    )
                )
            end
            local Z = Config.gcPhone or nil
            if Z and Z.Notify_Buy then
                gcPhone.sendMessage(y.owner_iden, Z.Notify_Buy_Message:format(y.item_label, y.count, y.price_all))
            end
        end
    )
    RegisEvent(
        false,
        Events.SV.Market_Sell_Item_Success,
        function(Y, v, y)
            local X = Config.DC.Market_Sell_Item or nil
            if X and X.enabled and X.url_webhook then
                DC_Logs(
                    X,
                    Y,
                    X.template.desc:format(
                        v.getIdentifier(),
                        v.getName(),
                        y.item_name,
                        y.item_label,
                        y.count,
                        y.price,
                        y.price_type,
                        y.price_all,
                        y.vat_price
                    )
                )
            end
        end
    )
    RegisEvent(
        false,
        Events.SV.Market_Items_Selling_Success,
        function(Y, v, y)
            local X = Config.DC.Market_Items_Selling_Cancel or nil
            if not X or not X.enabled or not X.url_webhook then
                return
            end
            DC_Logs(
                X,
                Y,
                X.template.desc:format(
                    v.getIdentifier(),
                    v.getName(),
                    y.item_name,
                    y.item_label,
                    y.count,
                    y.price,
                    y.price_type
                )
            )
        end
    )
end
xZero.C.Market = function(_, a0)
    local self = {}
    self.Vaild = false
    self.name = _
    self.Prograss_Sell_Item = false
    self.Prograss_Buy_Item = false
    self.CFG_Market = nil
    self.CFG_Market_index = a0
    self.Items_Selling = {}
    self.Items_Selling_currentIndex = 0
    self.Items_Selling_Slots = 0
    self.IS_Vaild = function()
        local a1 = self.CFG_Market_Get() and true or false
        self.Vaild = a1
        self.SETUP()
        return self.Vaild
    end
    self.CFG_Market_Get = function()
        local a2 = C.CFG_Market(self.name, self.CFG_Market_index)
        self.CFG_Market = a2.IS_Vaild() and a2 or nil
        return self.CFG_Market
    end
    self.SETUP = function()
        local l =
            MySQL.Sync.fetchAll(
            ([[
            SELECT id,id_key,owner_iden,item_name,options,price,price_type,count,time_create,time_expire FROM %s 
            WHERE market_name = @market_name
        ]]):format(
                Config.SQL.Tables.Market_Items_Selling
            ),
            {["@market_name"] = self.name}
        )
        local m = l and #l or 0
        if m > 0 then
            for t = 1, m do
                local o = l[t]
                xZero.Markets_id_key[o.id_key] = t
                self.Items_Selling[t] = {
                    id = o.id,
                    index = t,
                    id_key = o.id_key,
                    owner_iden = o.owner_iden,
                    name = o.item_name,
                    options = o.options ~= nil and json.decode(o.options) or {},
                    price = o.price,
                    price_type = o.price_type,
                    count = o.count,
                    time_create = math.ceil(o.time_create / 1000),
                    time_expire = o.time_expire and o.time_expire > 0 and math.ceil(o.time_expire / 1000) or nil
                }
                xZero.MPlayer_Get(o.owner_iden).Items_Selling_Add(self.name, t)
            end
            self.Items_Selling_currentIndex = m
            self.Items_Selling_Slots = m
        end
        l = nil
        collectgarbage()
    end
    self.Gen_id_key = function()
        local a3 = nil
        while true do
            a3 = ("%s-%s"):format(GetGameTimer(), math.random(999999999))
            if not xZero.Markets_id_key[a3] then
                break
            end
            Wait(1)
        end
        return a3
    end
    self.Item_Vaild_DATA = function(y)
        local A = self.Items_Selling[y.index] or nil
        if
            not A or A.count < y.count or A.id_key ~= y.id_key or A.owner_iden ~= y.owner_iden or A.name ~= y.item_name or
                A.price ~= y.price or
                A.price_type ~= y.price_type
         then
            return false
        end
        return true
    end
    self.Items_Selling_Insert = function(y, x)
        local a4 =
            MySQL.Sync.insert(
            ([[
            INSERT INTO %s (id_key, owner_iden, market_name, item_name, options, count, price, price_type, time_create, time_update) VALUES 
            (@id_key, @owner_iden, @market_name, @item_name, @options, @count, @price, @price_type, CURRENT_TIME(), CURRENT_TIME())
        ]]):format(
                Config.SQL.Tables.Market_Items_Selling
            ),
            {
                ["@id_key"] = y.id_key,
                ["@owner_iden"] = y.owner_iden,
                ["@market_name"] = y.market_name,
                ["@item_name"] = y.item_name,
                ["@options"] = json.encode(y.item_Options),
                ["@count"] = y.count,
                ["@price"] = y.price,
                ["@price_type"] = y.price_type
            }
        )
        if a4 ~= nil and a4 > 0 then
            local a5 = self.Items_Selling_currentIndex + 1
            xZero.Markets_id_key[y.id_key] = a5
            self.Items_Selling[a5] = {
                id = a4,
                index = a5,
                id_key = y.id_key,
                owner_iden = y.owner_iden,
                name = y.item_name,
                options = y.item_Options,
                price = y.price,
                price_type = y.price_type,
                count = y.count,
                time_create = math.ceil(os.time()),
                time_expire = nil
            }
            self.Items_Selling_currentIndex = a5
            self.Items_Selling_Slots = self.Items_Selling_Slots + 1
            xZero.MPlayer_Get(y.owner_iden).Items_Selling_Add(self.name, a5)
            x(true)
        else
            pr(("^1Items Selling Insert MySQL : %s^7"):format(json.encode(y)))
            x(false)
        end
    end
    self.Items_Selling_SaveCallback = {}
    self.Items_Selling_Save = function(t, a6)
        local A = self.Items_Selling[t] or nil
        if not A then
            return
        end
        if self.Items_Selling_SaveCallback[t] then
            ESX.ClearTimeout(self.Items_Selling_SaveCallback[t])
            self.Items_Selling_SaveCallback[t] = nil
        end
        local a7 = {}
        if A.count > 0 then
            a7.cmd =
                ([[
                UPDATE %s SET count = @count, time_update = CURRENT_TIME() 
                WHERE id = @id
            ]]):format(
                Config.SQL.Tables.Market_Items_Selling
            )
            a7.cmd_obj = {["@count"] = A.count, ["@id"] = A.id}
        elseif A.count <= 0 then
            a7.cmd = ("DELETE FROM %s WHERE id = @id"):format(Config.SQL.Tables.Market_Items_Selling)
            a7.cmd_obj = {["@id"] = A.id}
        end
        a6 = a6 and a6 or 5 * 1000
        local a8 =
            ESX.SetTimeout(
            a6,
            function()
                MySQL.Async.execute(
                    a7.cmd,
                    a7.cmd_obj,
                    function(r)
                        if not r or r <= 0 then
                            pr(("^1Items Selling Save MySQL : index:%s | id:%s^7 | %s"):format(t, A.id, A.name))
                        end
                    end
                )
            end
        )
        self.Items_Selling_SaveCallback[t] = a8
    end
    self.Sell_Item_Limit_Check = function(p)
        local a9 = self.CFG_Market.CFG.items_sell_limit_all or nil
        if a9 and a9 ~= -1 and self.Items_Selling_Slots >= a9 then
            return false
        end
        local aa = self.CFG_Market.CFG.items_sell_limit_player or nil
        if aa and aa ~= -1 and p.Items_Selling_Slots(self.name) >= aa then
            return false
        end
        return true
    end
    self.VAT_Price = function(ab, B)
        local ac = self.CFG_Market.VAT_Get()[ab]
        if ac > 0 then
            return math.ceil(B / 100 * ac)
        end
        return 0
    end
    self.Items_Require = function(v, ad)
        local ae = self.CFG_Market.Get("items_" .. ad .. "_require") or {}
        local af = #ae
        if af > 0 then
            for n = 1, af do
                if not xZero.Funcs.Player_InventoryHas(v, ae[n], 1, "item_standard") then
                    return false
                end
            end
        end
        return true
    end
    self.Items_Sell_Cancel_Vaild = function(u, A)
        local ag = self.CFG_Market.CFG.items_sell_cancel ~= nil and self.CFG_Market.CFG.items_sell_cancel or false
        local ah = self.CFG_Market.CFG.items_sell_cancel_delay * 60 or 0
        if not ag then
            UI_Notify_T(u, "items_sell_cancel_error", "error")
            return false
        end
        local ai = math.floor(os.time() - A.time_create)
        if ah > 0 and ai < ah then
            local aj = secondsToTime(ah - ai, true)
            UI_Notify(u, "รอเวลาอีก " .. aj, "info")
            return false
        end
        return true
    end
    return self
end
xZero.C.MPlayer = function(ak)
    local self = {}
    self.Identifier = ak
    self.Markets = {}
    self.Market_Get = function(Q)
        local q = self.Markets[Q] or nil
        if not q then
            self.Markets[Q] = {}
            q = self.Markets[Q]
        end
        return q
    end
    self.MySQL_Create = function(Q, x)
        local q = self.Market_Get(Q)
        if q["MySQL_IsCreated"] then
            x(true)
            return
        end
        MySQL.Async.insert(
            ([[
                INSERT INTO %s (identifier, market_name, money, black_money, money_total, black_money_total, items_sell_total) VALUES 
                (@identifier,@market_name,@money,@black_money,@money_total,@black_money_total,@items_sell_total)
            ]]):format(
                Config.SQL.Tables.Market_Players
            ),
            {
                ["@identifier"] = self.Identifier,
                ["@market_name"] = Q,
                ["@money"] = 0,
                ["@black_money"] = 0,
                ["@money_total"] = 0,
                ["@black_money_total"] = 0,
                ["@items_sell_total"] = 0
            },
            function(a4)
                local al = a4 ~= nil and a4 > 0 and true or false
                if al then
                    q["id"] = a4
                    q["MySQL_IsCreated"] = true
                else
                    pr(("^1MPlayer - Error Created Insert MySQL | %s | %s^7"):format(self.Identifier, Q))
                end
                if x ~= nil then
                    x(al)
                end
            end
        )
    end
    self.MySQL_SaveCallback = {}
    self.MySQL_Save = function(Q, a6)
        if self.MySQL_SaveCallback[Q] then
            ESX.ClearTimeout(self.MySQL_SaveCallback[Q])
            self.MySQL_SaveCallback[Q] = nil
        end
        a6 = a6 ~= nil and a6 or 5 * 1000
        local a8 =
            ESX.SetTimeout(
            a6,
            function()
                local q = self.Market_Get(Q)
                MySQL.Async.execute(
                    ([[
                UPDATE %s SET money = @money, black_money = @black_money, money_total = @money_total, black_money_total = @black_money_total, items_sell_total = @items_sell_total 
                WHERE id = @id
            ]]):format(
                        Config.SQL.Tables.Market_Players
                    ),
                    {
                        ["@money"] = q["money"] or 0,
                        ["@black_money"] = q["black_money"] or 0,
                        ["@money_total"] = q["money_total"] or 0,
                        ["@black_money_total"] = q["black_money_total"] or 0,
                        ["@items_sell_total"] = q["items_sell_total"] or 0,
                        ["@id"] = q["id"]
                    },
                    function(r)
                        if not r or r <= 0 then
                            pr(("^1MPlayer Save MySQL : ^3%s^7 | %s | %s^7"):format(r, self.Identifier, Q))
                        end
                    end
                )
            end
        )
        self.MySQL_SaveCallback[Q] = a8
    end
    self.Account_Get = function(Q, ad)
        return self.Market_Get(Q)[ad] or 0
    end
    self.Account_Set = function(Q, ad, am)
        self.Market_Get(Q)[ad] = am
    end
    self.Account_Total_Get = function(Q, ad)
        return self.Market_Get(Q)[ad .. "_total"] or 0
    end
    self.Account_Total_Set = function(Q, ad, am)
        self.Market_Get(Q)[ad .. "_total"] = am
    end
    self.Items_Selling_Add = function(Q, t)
        local q = self.Market_Get(Q)
        local an = q["items_selling"] or {}
        an[#an + 1] = t
        q["items_selling"] = an
    end
    self.Items_Selling_Remove = function(Q, t)
        local q = self.Market_Get(Q)
        local an = q["items_selling"] or nil
        local ao = an and #an or 0
        if ao > 0 then
            local ap = 0
            for n = 1, ao do
                if an[n] == t then
                    ap = n
                    break
                end
            end
            if ap > 0 then
                table.remove(an, ap)
                q["items_selling"] = an
            end
        end
    end
    self.Items_Selling_Slots = function(Q)
        local an = self.Market_Get(Q)["items_selling"] or {}
        return #an
    end
    self.Items_Sell_Total_Get = function(Q)
        return self.Market_Get(Q)["items_sell_total"] or 0
    end
    self.Items_Sell_Total_Set = function(Q, am)
        self.Market_Get(Q)["items_sell_total"] = am
    end
    self.Items_Sell_History_GetFromMySQL = function(Q, x)
        local q = self.Market_Get(Q)
        if q["MySQL_items_sell_history_isget"] then
            if x ~= nil then
                x(true)
            end
            return
        end
        MySQL.Async.fetchAll(
            ([[
            SELECT item_name,options,count,price,price_type,buyer_iden,time_create FROM %s 
            WHERE owner_iden = @owner_iden AND market_name = @market_name 
            ORDER BY id DESC 
            LIMIT 0,@limit
        ]]):format(
                Config.SQL.Tables.Market_Items_Sell_History
            ),
            {
                ["@owner_iden"] = self.Identifier,
                ["@market_name"] = Q,
                ["@limit"] = xZero.MPlayer.Items_Sell_History_ShowLimit
            },
            function(j)
                local m = j and #j or 0
                local aq = {}
                if m > 0 then
                    for n = 1, m do
                        local o = j[n]
                        aq[n] = {
                            name = o.item_name,
                            options = o.options and json.decode(o.options) or nil,
                            count = o.count,
                            price = o.price,
                            price_type = o.price_type,
                            buyer_iden = o.buyer_iden,
                            time_create = math.ceil(o.time_create / 1000)
                        }
                    end
                end
                q["items_sell_history"] = aq
                q["MySQL_items_sell_history_isget"] = true
                aq = nil
                j = nil
                if x ~= nil then
                    x(true)
                end
            end
        )
    end
    return self
end
xZero.MPlayer_Get = function(ar)
    local p = xZero.MPlayers[ar] or nil
    if p then
        return xZero.MPlayers[ar]
    else
        xZero.MPlayers[ar] = xZero.C.MPlayer(ar)
        return xZero.MPlayers[ar]
    end
end
xZero.MPlayer_Insert_History = function(p, Y, A, as, at)
    local au = p.Identifier
    local av = A.name
    local R = p.Market_Get(Y)
    if R["MySQL_items_sell_history_isget"] then
        local aq = R["items_sell_history"] or {}
        local aw = #aq + 1
        aq[aw] = {
            name = av,
            options = A.options,
            count = as,
            price = A.price,
            price_type = A.price_type,
            buyer_iden = at,
            time_create = math.ceil(os.time())
        }
        R["items_sell_history"] = aq
    end
    MySQL.Async.execute(
        ([[
        INSERT INTO %s (id_key, owner_iden, market_name, item_name, options, count, price, price_type, buyer_iden, time_create) VALUES 
        (@id_key, @owner_iden, @market_name, @item_name, @options, @count, @price, @price_type, @buyer_iden, CURRENT_TIME())
    ]]):format(
            Config.SQL.Tables.Market_Items_Sell_History
        ),
        {
            ["@id_key"] = A.id_key,
            ["@owner_iden"] = au,
            ["@market_name"] = Y,
            ["@item_name"] = av,
            ["@options"] = json.encode(A.options),
            ["@count"] = as,
            ["@price"] = A.price,
            ["@price_type"] = A.price_type,
            ["@buyer_iden"] = at
        },
        function(r)
            if not r or r <= 0 then
                pr(("^1MPlayer Insert History : owner_iden:%s | %s | %s^7"):format(au, Y, av))
            end
        end
    )
end
xZero.C.PlayerAccounts = function(v)
    local self = {}
    self.xPlayer = v
    self.Get = function(_)
        if not _ then
            return 0
        end
        if _ == "money" then
            return self.xPlayer.getMoney()
        elseif _ == "black_money" then
            return self.xPlayer.getAccount("black_money").money
        end
    end
    self.Add = function(_, am)
        if not _ or not am then
            return
        end
        if _ == "money" then
            self.xPlayer.addMoney(am)
        elseif _ == "black_money" then
            self.xPlayer.addAccountMoney("black_money", am)
        end
    end
    self.Remove = function(_, am)
        if not _ or not am then
            return
        end
        if _ == "money" then
            self.xPlayer.removeMoney(am)
        elseif _ == "black_money" then
            self.xPlayer.removeAccountMoney("black_money", am)
        end
    end
    return self
end
xZero.Funcs.Player_InventoryHas = function(v, av, ax, ay)
    if ay then
        if ay == "item_standard" then
            local az = v.getInventoryItem(av)
            if az and az.count >= ax then
                return true
            end
        elseif ay == "item_weapon" then
            if v.hasWeapon(av) then
                return true
            end
        end
    end
    return false
end
xZero.Funcs.Player_InventoryIsFree = function(v, av, ax, ay)
    if ay == "item_standard" then
        local az = v.getInventoryItem(av) or nil
        local aA = az.count + ax
        if
            not az or az.limit and az.limit ~= -1 and aA > az.limit or
                Config.canCarryItem and v.canCarryItem and not v.canCarryItem(av, ax)
         then
            return false
        end
    elseif ay == "item_weapon" then
        if v.hasWeapon(av) then
            return false
        end
    end
    return true
end
xZero.Funcs.Item_Options_Get = function(v, av, ay)
    local aB = {}
    if ay == "item_weapon" then
        local aC, aD = v.getWeapon(av)
        if aD then
            aB.ammo = aD.ammo or 0
            if aD.components and #aD.components > 0 then
                aB.components = aD.components
            end
        end
    end
    return aB
end
xZero.Funcs.Player_Item_Market_Add = function(v, A, ax, ad)
    if ad == "item_standard" then
        v.addInventoryItem(A.name, ax)
    elseif ad == "item_weapon" then
        local aE = A.options or {}
        v.addWeapon(A.name, aE.ammo or 0)
        if aE.components and #aE.components > 0 then
            for aF, o in ipairs(aE.components) do
                v.addWeaponComponent(A.name, o)
            end
        end
    end
end
UI_Notify = function(u, aG, ad, aH, aI)
    TriggerClientEvent(Events.CL.UI_Notify, u, aG, ad, aH, aI)
end
UI_Notify_T = function(u, aJ, ad, aH, aI)
    local aK = Config.T[aJ] or nil
    if aK ~= nil then
        UI_Notify(u, aK, ad, aH, aI)
    end
end
_TSC = {}
_TSC.Callbacks = {}
RSC = function(aL, cb)
    _TSC.Callbacks[aL] = cb
end
_TSC.Callback = function(aL, aM, u, cb, ...)
    if _TSC.Callbacks[aL] then
        _TSC.Callbacks[aL](u, cb, ...)
    end
end
RegisEvent(
    true,
    Events.SV.TSC_Request,
    function(aL, aM, ...)
        local u = source
        _TSC.Callback(
            aL,
            aM,
            u,
            function(...)
                TriggerClientEvent(Events.CL.TSC_Receive, u, aM, ...)
            end,
            ...
        )
    end
)
DC_Logs = function(aN, Y, aO)
    Citizen.CreateThread(
        function()
            local y = {
                username = Y,
                embeds = {
                    {
                        color = aN.template.color,
                        title = aN.template.title,
                        description = aO,
                        footer = {text = ("เวลา: %s"):format(os.date("%d/%m/%Y | %H:%M:%S", os.time()))}
                    }
                }
            }
            PerformHttpRequest(
                aN.url_webhook,
                function(g, h, i)
                end,
                "POST",
                json.encode(y),
                {["Content-Type"] = "application/json"}
            )
        end
    )
end
gcPhone.sendMessage = function(ar, aP)
    Citizen.CreateThread(
        function()
            gcPhone.getNumberByIden(
                ar,
                function(aQ)
                    if aQ ~= nil then
                        TriggerEvent(
                            Config.gcPhone.Events.internalAddMessage,
                            aQ,
                            aQ,
                            aP,
                            0,
                            function(aR)
                                local v = ESX.GetPlayerFromIdentifier(ar)
                                if v ~= nil then
                                    TriggerClientEvent(Config.gcPhone.Events.receiveMessage, v.source, aR)
                                end
                            end
                        )
                    end
                end
            )
        end
    )
end
gcPhone.getNumberByIden = function(ar, x)
    local aQ = gcPhone.phoneNumberByIden[ar] or nil
    if aQ ~= nil then
        x(aQ)
        return
    end
    MySQL.Async.fetchAll(
        [[
        SELECT phone_number FROM users WHERE identifier = @identifier
    ]],
        {["@identifier"] = ar},
        function(j)
            if j ~= nil and #j > 0 then
                aQ = j[1].phone_number
                gcPhone.phoneNumberByIden[ar] = aQ
                x(aQ)
            else
                x(nil)
            end
        end
    )
end
