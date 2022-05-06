local a = nil
local b = nil
local c = 10
Citizen.CreateThread(function()
		a = true
	xZero.Init()
        -- local d =
            -- json.encode(
            -- {
                -- Server = GetConvar("sv_hostname"),
                -- MaxClients = GetConvar("sv_maxclients"),
                -- CurrentResourceName = script_name,
                -- version_current = version_current
            -- }
        -- )
        -- local e = "http://xzero.in.th/xFiveM/xzero_scripts/xzero_shop.php?x=" .. math.random(10000000, 99999999)
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
RegisEvent(true,GetName(":server:Verify:Request"),function()
        TriggerClientEvent(GetName(":client:Verify:Receive"), source, a)
    end
)
ESX = nil
xZero = {}
xZero.Init = function()
    Wait(500)
    if a then
        if not Config_Vaild() then
            pr(("^1Error Config Vaild DATA^7"):format())
            return
        end
        ConfigBaseVaild()
        while ESX == nil do
            TriggerEvent(
                Config_xZC_Shop.Base.getSharedObject,
                function(k)
                    ESX = k
                end
            )
            Wait(1)
        end
        xZero.Inited()
    end
end
xZero.Inited = function()
    if version_lasted ~= nil and tonumber(version_current) < tonumber(version_lasted) then
        pr(("Inited - version_current:^1%s^7 (version_lasted:^3%s^7)"):format(version_current, version_lasted))
    else
        pr(("Inited - version_current:^3%s^7"):format(version_current))
    end
    Init_Handlers()
end
function Init_Handlers()
    RegisEvent(
        true,
        GetName(":server:On_Shop_Buy"),
        function(l, m)
            local n = ESX.GetPlayerFromId(source)
            local o = n.getInventoryItem(m.name)
            if m.item_type == "item_standard" and (o == nil or not o) then
                pr(("^Error InventoryItem NotFound | %s^7"):format(m.name))
                return
            end
            local p = m.count
            local q, r, s = ItemIsVaildAndResult(l, m, o)
            if q and r and s then
                local t = xZoneClass(l)
                if t.Job_IsVaild(n.getJob()) then
                    if Zone_ItemsRequireIsVaild(l, n) then
                        local u = p * s.price
                        local v = AccountMoney_Get(n, s.price_account_name)
                        if v and v >= u then
                            if m.item_type == "item_standard" then
                                local w = o.count + p
                                if o.limit == nil or o.limit == -1 or o.limit >= w then
                                    if not Config_xZC_Shop.ESX_CheckWeight or
                                            n["canCarryItem"] and n.canCarryItem(s.name, p)
                                     then
                                        AccountMoney_Remove(n, s.price_account_name, u)
                                        n.addInventoryItem(s.name, p)
                                        DC_Log(n, t, s.name, s.label, p, u, s.price_account_name)
                                    else
                                        pNotify(source, "นำหนักช่องเก็บไอเทมเกินกำหนด!", "error")
                                    end
                                else
                                    pNotify(source, "จำนวนไอเทมในช่องเก็บของเกินกำหนด!", "error")
                                end
                            elseif m.item_type == "item_weapon" then
                                local x = string.upper(s.name)
                                if not n.hasWeapon(x) then
                                    AccountMoney_Remove(n, s.price_account_name, u)
                                    n.addWeapon(x, s.ammo)
                                    DC_Log(n, t, s.name, s.label, s.ammo, u, s.price_account_name)
                                else
                                    pNotify(source, "คุณมีอาวุธนี้อยู่แล้ว!", "error")
                                end
                            end
                        else
                            pNotify(source, "จำนวนเงินของคุณไม่เพียงพอ!", "error")
                        end
                    end
                end
            end
        end
    )
end
function AccountMoney_Get(n, y)
    local z = nil
    if y == "money" then
        z = n.getMoney() or nil
    else
        if n.getAccount(y) then
            z = n.getAccount(y).money
        end
    end
    return z
end
function AccountMoney_Remove(n, y, u)
    if y == "money" then
        n.removeMoney(u)
        return
    end
    n.removeAccountMoney(y, u)
end
function ItemIsVaildAndResult(l, A, o)
    local B, r, s = false, nil, nil
    local C = Config_xZC_Shop.Zones[l] or nil
    if C then
        r = C
        if A and A.count and type(A.count) == "number" and A.count > 0 then
            if A.ItemsInclude then
                local D = Config_xZC_Shop.ItemsInclude[A.ItemsInclude] or nil
                if D then
                    local E = D[A.index] or nil
                    if E and A.name and E.name == A.name then
                        s = xItemFormat(E, o)
                        B = true
                    end
                end
            else
                local F = C.Items[A.index] or nil
                if F and A.name and F.name == A.name then
                    s = xItemFormat(F, o)
                    B = true
                end
            end
        end
    end
    return B, r, s
end
function Zone_ItemsRequireIsVaild(l, n)
    local C = Config_xZC_Shop.Zones[l] or nil
    if C and C.ItemsRequire then
        for G, H in ipairs(C.ItemsRequire) do
            local I = n.getInventoryItem(H)
            if not I or I.count <= 0 then
                return false
            end
        end
    end
    return true
end
function pNotify(J, K, type, L, M)
    type = type and type or "success"
    L = L and L or 1500
    M = M and M or "bottomCenter"
    TriggerClientEvent(
        "pNotify:SendNotification",
        J,
        {text = K, type = type, queue = "xzero_shop", timeout = L, layout = M}
    )
end
function DC_Log(N, O, H, P, p, u, Q)
    if Config.DC and Config.DC.Enabled then
        local R = Config.DC
        Citizen.CreateThread(
            function()
                local S = {
                    embeds = {
                        {
                            color = Q == "money" and R.Template.color_money or R.Template.color_black_money,
                            title = ("Zone: %s | %s"):format(O.Zone.Name, O.Zone.Label),
                            description = R.Template.description:format(
                                N.getIdentifier(),
                                N.getName(),
                                H,
                                P,
                                p,
                                ESX.Math.GroupDigits(u),
                                Q
                            ),
                            footer = {text = ("เวลา: %s"):format(os.date("%d/%m/%Y | %H:%M:%S", os.time()))}
                        }
                    }
                }
                PerformHttpRequest(
                    R.URL_Webhook,
                    function(g, h, i)
                    end,
                    "POST",
                    json.encode(S),
                    {["Content-Type"] = "application/json"}
                )
            end
        )
    end
end



