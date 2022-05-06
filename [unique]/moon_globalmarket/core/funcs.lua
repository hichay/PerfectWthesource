script_name = GetCurrentResourceName()
GetName = function(a)
    return script_name .. a
end
RegisEvent = function(b, a, c)
    if b then
        RegisterNetEvent(a)
    end
    AddEventHandler(a, c)
end
pr = function(d)
    print(("^2[%s]^7 %s"):format(script_name, d))
end
Events = {}
Events.SV = {}
Events.SV.Verify_Request = GetName(":SV:Verify:Request:2020")
Events.SV.TSC_Request = GetName(":SV:TSC:Request")
Events.SV.Accounts_Request = GetName(":SV:Accounts:Request")
Events.SV.Market_Items_Selling_Request_CB = GetName(":SV:Market_Items_Selling:Request:CB")
Events.SV.Market_Items_Selling_Request = GetName(":SV:Market_Items_Selling:Request")
Events.SV.Market_Items_Selling_Cancel_Request_CB = GetName(":SV:Market_Items_Selling_Cancel:Request:CB")
Events.SV.Market_Items_Selling_Remove_Request_CB = GetName(":SV:Market_Items_Selling_Remove:Request:CB")
Events.SV.Market_Buy_Item_Request_CB = GetName(":SV:Market_Buy_Item:Reqeust:CB")
Events.SV.Market_Sell_Item_Reqeust_CB = GetName(":SV:Market_Sell_Item:Reqeust:CB")
Events.SV.Player_InventoryItem_Request = GetName(":SV:Player_InventoryItem:Request")
Events.SV.MPlayer_DATA_Request = GetName(":SV:MPlayer_DATA:Request")
Events.SV.MPlayer_Items_Sell_History_Reqeust = GetName(":SV:MPlayer_Items_Sell_History:Reqeust")
Events.SV.Withdraw_Money_Request = GetName(":SV:Withdraw_Money:Request")
Events.SV.Market_Buy_Item_Success = GetName(":SV:Market_Buy_Item_Success")
Events.SV.Market_Sell_Item_Success = GetName(":SV:Market_Sell_Item_Success")
Events.SV.Market_Items_Selling_Success = GetName(":SV:Market_Items_Selling_Success")
Events.CL = {}
Events.CL.Verify_Receive = GetName(":CL:Verify:Receive:2020")
Events.CL.TSC_Receive = GetName(":CL:TSC:Receive")
Events.CL.UI_SET_IS_SHOW = GetName(":CL:UI:SET_IS_SHOW")
Events.CL.UI_ON_IS_SHOW = GetName(":CL:UI:ON_IS_SHOW")
Events.CL.UI_Market_Show_Request = GetName(":CL:UI_Market_Show:Request")
Events.CL.ABP_Reqeust = GetName(":CL:ABP:Request")
Events.CL.Accounts_Receive = GetName(":CL:Accounts:Receive")
Events.CL.Market_Items_Selling_Request = GetName(":CL:Market_Items_Selling:Request")
Events.CL.Market_Items_Selling_Receive = GetName(":CL:Market_Items_Selling:Receive")
Events.CL.Player_InventoryItem_Receive = GetName(":CL:Player_InventoryItem:Receive")
Events.CL.MPlayer_DATA_Request = GetName(":CL:MPlayer_DATA:Request")
Events.CL.MPlayer_DATA_Receive = GetName(":CL:MPlayer_DATA:Receive")
Events.CL.MPlayer_Items_Sell_History_Receive = GetName(":CL:MPlayer_Items_Sell_History:Receive")
Events.CL.Pos_IsIn_Enter = GetName(":CL:Pos_IsIn_Enter")
Events.CL.Pos_IsIn_Exit = GetName(":CL:Pos_IsIn_Exit")
Events.CL.UI_Notify = GetName(":CL:UI_Notify")
Events.NUI = {}
Events.NUI.Close = "Close"
Events.NUI.Market_Items_Selling_Request = "Market_Items_Selling:Request"
Events.NUI.Market_Items_Selling_Cancel_Request = "Market_Items_Selling_Cancel:Request"
Events.NUI.Market_Items_Selling_Remove_Request = "Market_Items_Selling_Remove:Request"
Events.NUI.Market_Buy_Item_Request = "Market_Buy_Item:Request"
Events.NUI.Market_Sell_Item_Request = "Market_Sell_Item:Request"
Events.NUI.MPlayer_Items_Sell_History_Request = "MPlayer_Items_Sell_History:Request"
Events.NUI.Withdraw_Money_Request = "Withdraw_Money:Request"
C = {}
C.CFG_Market = function(e, f)
    local self = {}
    self.Vaild = false
    self.index = f
    self.name = e
    self.CFG = nil
    self.Get = function(e)
        return self.CFG[e] or nil
    end
    self.IS_Vaild = function()
        self.Vaild = self.CFG_Get() and true or false
        return self.Vaild
    end
    self.CFG_Get = function()
        local g = Config.Markets[self.index] or nil
        if not g or g.name ~= self.name then
            return nil
        end
        self.CFG = g
        return self.CFG
    end
    self.Categorys_Find = function(e)
        local h = Config.Market_Categorys and #Config.Market_Categorys or 0
        if h > 0 then
            for i = 1, h do
                if Config.Market_Categorys[i].name == e then
                    return Config.Market_Categorys[i]
                end
            end
        end
        return nil
    end
    self.Categorys_Get = function()
        local j = Config.Market_Categorys and #Config.Market_Categorys or 0
        local k = self.CFG.categorys and #self.CFG.categorys or 0
        if j > 0 and k > 0 then
            local l = {}
            local m = 0
            for i = 1, k do
                local n = self.Categorys_Find(self.CFG.categorys[i])
                if n then
                    m = m + 1
                    l[m] = n
                end
            end
            return l
        elseif j > 0 and k <= 0 then
            return Config.Market_Categorys
        end
        return nil
    end
    self.VAT_Get = function()
        return {after = self.CFG.vat_after or 0, before = self.CFG.vat_before or 0}
    end
    self.Price_Type_EB = function()
        return {money = self.CFG.price_money, black_money = self.CFG.price_black_money}
    end
    self.Pos = function()
        return self.CFG.pos or {}
    end
    self.Blip_Show = function()
        return self.CFG.blip and self.CFG.blip.show or false
    end
    self.DarwText_Show = function()
        return self.CFG.drawtext and self.CFG.drawtext.show or false
    end
    self.Marker_Show = function()
        return self.CFG.marker and self.CFG.marker.show or false
    end
    self.Object_Show = function()
        return self.CFG.object and self.CFG.object.show or false
    end
    self.Job_Require = function(o, p)
        local q = self.Get("job_" .. p .. "_require") or {}
        local r = Funcs.array_IsInOne(q, o)
        if r ~= nil and not r then
            return false
        end
        return true
    end
    self.Items_Sell_BL = function(s)
        local t = self.Get("items_sell_bl") or {}
        local r = Funcs.array_IsInOne(t, s)
        if r ~= nil and r then
            return false
        end
        return true
    end
    self.Items_Sell_Only = function(s)
        local t = self.Get("items_sell_only") or {}
        local r = Funcs.array_IsInOne(t, s)
        if r ~= nil and not r then
            return false
        end
        return true
    end
    return self
end
Funcs = {}
Funcs.array_IsInOne = function(u, v)
    local h = u and #u or 0
    if h > 0 then
        for i = 1, h do
            if u[i]:lower() == v:lower() then
                return true
            end
        end
        return false
    end
    return nil
end
Funcs.Item_Type_Vaild_DATA = function(w)
    if w ~= "item_standard" and w ~= "item_weapon" then
        return false
    end
    return true
end
Funcs.Price_Type_Vaild_DATA = function(x)
    if x ~= "money" and x ~= "black_money" then
        return false
    end
    return true
end
Funcs.Market_Sell_Item_Vaild_DATA = function(y)
    if y then
        for z, A in ipairs({"item_name", "item_type", "price", "price_type", "count"}) do
            if y[A] == nil then
                return false
            end
        end
        if type(y.price) ~= "number" and type(y.count) ~= "number" then
            return false
        end
        if not Funcs.Price_Type_Vaild_DATA(y.price_type) then
            return false
        end
        if not Funcs.Item_Type_Vaild_DATA(y.item_type) then
            return false
        end
        return true
    end
    return false
end
Funcs.Market_Buy_Item_Vaild_DATA = function(y)
    if y then
        for z, A in ipairs(
            {"index", "id_key", "market_name", "owner_iden", "item_name", "price", "price_type", "count", "item_type"}
        ) do
            if y[A] == nil then
                return false
            end
        end
        for z, A in ipairs("index", "price", "count") do
            if type(y[A]) ~= "number" then
                return false
            end
        end
        if not Funcs.Price_Type_Vaild_DATA(y.price_type) then
            return false
        end
        if not Funcs.Item_Type_Vaild_DATA(y.item_type) then
            return false
        end
        return true
    end
    return false
end
Funcs.Market_Items_Selling_Vaild_DATA = function(y)
    if y then
        for z, A in ipairs({"index", "id_key", "market_name", "item_name", "item_type"}) do
            if y[A] == nil then
                return false
            end
        end
        if not Funcs.Item_Type_Vaild_DATA(y.item_type) then
            return false
        end
        return true
    end
    return false
end
Funcs.Market_Items_Sell_BL = function(s)
    local r = Funcs.array_IsInOne(Config.Market_Items_Sell_BL, s)
    if r ~= nil and r then
        return false
    end
    return true
end
Funcs.Market_Items_Control = function(s)
    local B = Config.Market_Items_Control_Default
    local D = {}
    D.price_min = B.price_min
    D.price_max = B.price_max
    D.count_min = B.count_min
    D.count_max = B.count_max
    D.price_money = true
    D.price_black_money = true
    D.jobs = nil
    local E = Config.Market_Items_Control_Custom
    local F = E[s] or nil
    if F then
        for z, A in ipairs(
            {"price_min", "price_max", "count_min", "count_max", "price_money", "price_black_money", "jobs"}
        ) do
            if F[A] ~= nil then
                D[A] = F[A]
            end
        end
    end
    return D
end
secondsToTime = function(G, H)
    local I = math.floor(G / 86400)
    local J = math.floor(math.fmod(G, 86400) / 3600)
    local K = math.floor(math.fmod(G, 3600) / 60)
    local L = math.floor(math.fmod(G, 60))
    if H ~= nil and H then
        return ("%s%s%s%s"):format(
            I > 0 and I .. "วัน" or "",
            J > 0 and J .. "ชม. " or "",
            K > 0 and K .. "นาที " or "",
            L > 0 and L .. "วินาที" or ""
        )
    end
    return {days = I, hours = J, minutes = K, seconds = L}
end
_Admin = {}
_Admin.IsVaild = function(M)
    local r = Funcs.array_IsInOne(Config.AdminList, M)
    return r ~= nil and r or false
end
