RegisterNetEvent("raid_clothes:outfits")
AddEventHandler("raid_clothes:outfits", function(pAction, pId, pName)
    TriggerEvent("attachedItems:block", true)

    Wait(50)

    if pAction == 1 then
        TriggerServerEvent("raid_clothes:set_outfit", pId, pName, GetCurrentPed())
    elseif pAction == 2 then
        TriggerServerEvent("raid_clothes:remove_outfit", pId)
    elseif pAction == 3 then
        TriggerEvent("item:deleteClothesDna")
        TriggerEvent("InteractSound_CL:PlayOnOne","Clothes1", 0.6)
        TriggerServerEvent("raid_clothes:get_outfit", pId)
        Wait(500)
        TriggerEvent("attachedItems:block", false)
    else
        TriggerServerEvent("raid_clothes:list_outfits")
    end
end)

RegisterNetEvent("raid_clothes:ListOutfits")
AddEventHandler("raid_clothes:ListOutfits", function(outfits)
    local menuData = {}

    for i,v in ipairs(outfits) do
        menuData[#menuData + 1] = {
            title = v["slot"] .. " | " .. v["name"],
            description = "",
            children = {
                { title = "Thay bộ này", action = "raid_clothes:callbackOutfits", key = { type = 3, slot = v["slot"] } },
                { title = "Xóa bộ này", action = "raid_clothes:callbackOutfits", key = { type = 2, slot = v["slot"] } },
            },
        }
    end

    menuData[#menuData + 1] = {
        title = "Lưu bộ hiện tại",
        description = "",
        action = "raid_clothes:callbackOutfits",
        key = { type = 1, slot = 0 },
    }

    exports["pw-context"]:showContextMenu(menuData)
end)

AddEventHandler("raid_clothes:callbackOutfits", function(params)
    local type = params["type"]
    local slot = params["slot"]

    if type == 1 then
        local input = exports["pw-input"]:showInput({
            {
                icon = "hashtag",
                label = "Slot",
                name = "slot",
            },
            {
                icon = "tshirt",
                label = "Tên",
                name = "name",
            },
        })

        if input["slot"] and input["name"] then
            local slot = tonumber(input["slot"])
            local name = input["name"]

            if not slot or slot < 1 or slot > 10 then
                TriggerEvent("DoLongHudText", "Slot phải 1-10", 2)
                return
            end

            if not name or name == "" then
                TriggerEvent("DoLongHudText", "Phải đặt tên", 2)
                return
            end

            TriggerServerEvent("raid_clothes:set_outfit", slot, name, GetCurrentPed())
        end
    elseif type == 2 then
        TriggerServerEvent("raid_clothes:remove_outfit", slot)
    elseif type == 3 then
        TriggerEvent("item:deleteClothesDna")
        TriggerEvent("InteractSound_CL:PlayOnOne","Clothes1", 0.6)
        TriggerServerEvent("raid_clothes:get_outfit", slot)
    end
end)