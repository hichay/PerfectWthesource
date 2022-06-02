

local removing = false
local antispam = 0

local items = {
    "hat",
    "mask",
    "googles",
    "chain",
    "vest",
    "jacket",
    "shirt",
    "backpack",
    "pants",
    "shoes",
    "watch",
    "braclets",
    "earrings",
}


function GetSkinSex(pEntity)
    for i, v in ipairs(frm_skins) do
        if (GetHashKey(v) == GetEntityModel(pEntity)) then
            return "male"
        end
    end
    for i, v in ipairs(fr_skins) do
        if (GetHashKey(v) == GetEntityModel(pEntity)) then
            return "female"
        end
    end
    return "male"
end

function toggleFaceWear(pType, pRemove, pInfo, pSteal)
    local AnimSet = "clothingtie"
    local Animation = "try_tie_neutral_c"
    local PropIndex = 0
    local Wait = 1000
    local ItemHandler = false
    local ItemMeta = {}
    local IsMale = GetSkinSex(PlayerPedId()) == "male"

    if not pRemove then
        if pInfo.gender == "male" and not IsMale then
            TriggerEvent("DoLongHudText", "Trang phục này chỉ hợp với người khác giới. ", 2)
            return
        end
    end

    removing = true

    if pType == "hat" then
        PropIndex = 0
        AnimSet = "mp_masks@on_foot"
        Animation = "put_on_mask"
    elseif pType == "googles" then
        PropIndex = 1
        AnimSet = "clothingspecs"
        Animation = "take_off"
        Wait = 1200
    elseif pType == "chain" then
        PropIndex = 7
        AnimSet = "clothingspecs"
        Animation = "take_off"
        Wait = 1200
    elseif pType == "mask" then
        PropIndex = 1
        AnimSet = "mp_masks@on_foot"
        Animation = "put_on_mask"
    elseif pType == "vest" then
        PropIndex = 9
    elseif pType == "jacket" then
        PropIndex = 11
    elseif pType == "shirt" then
        PropIndex = 8
    elseif pType == "backpack" then
        PropIndex = 5
    elseif pType == "pants" then
        PropIndex = 4
    elseif pType == "watch" then
        PropIndex = 6
    elseif pType == "braclets" then
        PropIndex = 7
    elseif pType == "earrings" then
        PropIndex = 2
        AnimSet = "clothingspecs"
        Animation = "take_off"
        Wait = 1200
    elseif pType == "shoes" then
        PropIndex = 6
        AnimSet = "random@domestic"
        Animation = "pickup_low"
    elseif pType == "stolenshoes" then
        PropIndex = 6
    end

    if pSteal == false then
        loadAnimDict(AnimSet)
        TaskPlayAnim(PlayerPedId(), AnimSet, Animation, 4.0, 3.0, -1, 49, 1.0, 0, 0, 0)
    else
        Wait = 500
    end

    local currentDrawable = GetPedDrawableVariation(PlayerPedId(), PropIndex) or -1
    local currentProp = GetPedPropIndex(PlayerPedId(), PropIndex) or -1

    Citizen.Wait(Wait)

    if pType == "hat" or pType == "googles" or pType == "watch" or pType == "braclets" or pType == "earrings" then
        local texture = GetPedPropTextureIndex(PlayerPedId(), PropIndex) or 0

        if pRemove then
            if currentProp ~= -1 then
                ClearPedProp(PlayerPedId(), PropIndex)

                ItemHandler = true
                ItemMeta = { prop = currentProp, txd = texture }
            end
        else
            if currentProp ~= -1 then
                local _itemMeta = {
                    _hideKeys = { "_remove_id" },
                    _remove_id = math.random(10000000, 999999999),
                    prop = currentProp,
                    txd = texture
                }
                TriggerEvent("player:receiveItem", pType, 1, false, _itemMeta)
            end

            SetPedPropIndex(PlayerPedId(), PropIndex, pInfo.prop, pInfo.txd, true)

            ItemHandler = true
        end
    elseif pType == "mask" or pType == "vest" or pType == "backpack" or pType == "chain" then
        local texture = GetPedTextureVariation(PlayerPedId(), PropIndex) or 0
        local pal = GetPedPaletteVariation(PlayerPedId(), PropIndex) or -1

        if pRemove then
            if currentDrawable ~= -1 then
                SetPedComponentVariation(PlayerPedId(), PropIndex, -1, -1, -1)

                ItemHandler = true
                ItemMeta = { prop = currentDrawable, txd = texture, palette = pal }
            end
        else
            if currentDrawable ~= -1 then
                local _itemMeta = {
                    _hideKeys = { "_remove_id" },
                    _remove_id = math.random(10000000, 999999999),
                    prop = currentDrawable,
                    txd = texture,
                    palette = pal
                }
                TriggerEvent("player:receiveItem", pType, 1, false, _itemMeta)
            end

            SetPedComponentVariation(PlayerPedId(), PropIndex, pInfo.prop,  pInfo.txd,  pInfo.pallete)

            ItemHandler = true
        end
    elseif pType == "jacket" then
        local texture = GetPedTextureVariation(PlayerPedId(), PropIndex) or 0
        local pal = GetPedPaletteVariation(PlayerPedId(), PropIndex) or -1
        local arm = GetPedDrawableVariation(PlayerPedId(), 3) or 0

        local bareTorsoIndex = 15
        local bareArmsIndex = 15

        if not IsMale then
            bareTorsoIndex = 18
        end

        if pRemove then
            if currentDrawable ~= -1 and currentDrawable ~= bareTorsoIndex then
                SetPedComponentVariation(PlayerPedId(), PropIndex, bareTorsoIndex, 0, -1)
                SetPedComponentVariation(PlayerPedId(), 3, bareArmsIndex, 0, -1)

                ItemHandler = true
                ItemMeta = {
                    _hideKeys = { "_remove_id", "arms" },
                    _remove_id = math.random(10000000, 999999999),
                    prop = currentDrawable,
                    txd = texture,
                    palette = pal,
                    arms = arm
                }
            end
        else
            if currentDrawable ~= -1 and currentDrawable ~= bareTorsoIndex then
                local _itemMeta = {
                    _hideKeys = { "_remove_id", "arms" },
                    _remove_id = math.random(10000000, 999999999),
                    prop = currentDrawable,
                    txd = texture,
                    palette = pal,
                    arms = arm
                }
                TriggerEvent("player:receiveItem", pType, 1, false, _itemMeta)
            end

            SetPedComponentVariation(PlayerPedId(), PropIndex, pInfo.prop, pInfo.txd, pInfo.palette)
            SetPedComponentVariation(PlayerPedId(), 3, pInfo.arms, 0, -1)

            ItemHandler = true
        end
    elseif pType == "shirt" then
        local texture = GetPedTextureVariation(PlayerPedId(), PropIndex) or 0
        local pal = GetPedPaletteVariation(PlayerPedId(), PropIndex) or -1

        local bareTorsoIndex = 15

        if not IsMale then
            bareTorsoIndex = 18
        end

        if pRemove then
            if currentDrawable ~= -1 and currentDrawable ~= bareTorsoIndex then
                SetPedComponentVariation(PlayerPedId(), PropIndex, bareTorsoIndex, 0, -1)

                ItemHandler = true
                ItemMeta = {
                    _hideKeys = { "_remove_id" },
                    _remove_id = math.random(10000000, 999999999),
                    prop = currentDrawable,
                    txd = texture,
                    palette = pal
                }
            end
        else
            if currentDrawable ~= -1 and currentDrawable ~= bareTorsoIndex then
                local _itemMeta = {
                    _hideKeys = { "_remove_id" },
                    _remove_id = math.random(10000000, 999999999),
                    prop = currentDrawable,
                    txd = texture,
                    palette = pal
                }
                TriggerEvent("player:receiveItem", pType, 1, false, _itemMeta)
            end

            SetPedComponentVariation(PlayerPedId(), PropIndex, pInfo.prop, pInfo.txd, pInfo.palette)
            SetPedComponentVariation(PlayerPedId(), 3, pInfo.arms, 0, -1)

            ItemHandler = true
        end
    elseif pType == "pants" then
        local texture = GetPedTextureVariation(PlayerPedId(), PropIndex) or 0
        local pal = GetPedPaletteVariation(PlayerPedId(), PropIndex) or -1

        local bareLegsIndex = 61

        if not IsMale then
            bareLegsIndex = 17
        end

        if pRemove then
            if currentDrawable ~= -1 and currentDrawable ~= bareLegsIndex then
                SetPedComponentVariation(PlayerPedId(), PropIndex, bareLegsIndex, 0, -1)

                ItemHandler = true
                ItemMeta = {
                    _hideKeys = { "_remove_id" },
                    _remove_id = math.random(10000000, 999999999),
                    prop = currentDrawable,
                    txd = texture,
                    palette = pal
                }
            end
        else
            if currentDrawable ~= -1 and currentDrawable ~= bareLegsIndex then
                local _itemMeta = {
                    _hideKeys = { "_remove_id" },
                    _remove_id = math.random(10000000, 999999999),
                    prop = currentDrawable,
                    txd = texture,
                    palette = pal
                }
                TriggerEvent("player:receiveItem", pType, 1, false, _itemMeta)
            end

            SetPedComponentVariation(PlayerPedId(), PropIndex, pInfo.prop, pInfo.txd, pInfo.palette)

            ItemHandler = true
        end
    elseif pType == "shoes" then
        local texture = GetPedTextureVariation(PlayerPedId(), PropIndex) or 0
        local pal = GetPedPaletteVariation(PlayerPedId(), PropIndex) or -1

        local bareFootIndex = 34

        if not IsMale then
            bareFootIndex = 35
        end

        if pRemove then
            if currentDrawable ~= -1 and currentDrawable ~= bareFootIndex then
                SetPedComponentVariation(PlayerPedId(), PropIndex, bareFootIndex, 0, -1)

                ItemHandler = true
                ItemMeta = {
                    _hideKeys = { "_remove_id" },
                    _remove_id = math.random(10000000, 999999999),
                    prop = currentDrawable,
                    txd = texture,
                    palette = pal
                }
            end
        else
            if currentDrawable ~= -1 and currentDrawable ~= bareFootIndex then
                local _itemMeta = {
                    _hideKeys = { "_remove_id" },
                    _remove_id = math.random(10000000, 999999999),
                    prop = currentDrawable,
                    txd = texture,
                    palette = pal
                }
                TriggerEvent("player:receiveItem", pType, 1, false, _itemMeta)
            end

            SetPedComponentVariation(PlayerPedId(), PropIndex, pInfo.prop, pInfo.txd, pInfo.palette)

            ItemHandler = true
        end
    elseif pType == "stolenshoes" then
        local bareFootIndex = 34

        if not IsMale then
            bareFootIndex = 35
        end

        if currentDrawable ~= -1 and currentDrawable ~= bareFootIndex then
            SetPedComponentVariation(PlayerPedId(), PropIndex, bareFootIndex, 0, -1)
            TriggerServerEvent("pw-clothes:facewearSendItem", pSteal, pType, ItemMeta)
        end
    end

    if ItemHandler then
        ItemMeta.gender = IsMale and "male" or "female"

        if pSteal ~= false then
            TriggerServerEvent("pw-clothes:facewearSendItem", pSteal, pType, ItemMeta)
        else
            if pRemove then
                TriggerEvent("player:receiveItem", pType, 1, false, ItemMeta)
            else
                TriggerEvent("inventory:removeItemByMetaKV", pType, 1, "_remove_id", pInfo._remove_id)
            end
        end
    end

    if pSteal == false then
        ClearPedTasks(PlayerPedId())
    end

    TriggerEvent("pw-clothes:saveCurrentClothes")

    Citizen.Wait(250)

    removing = false
end


AddEventHandler("pw-inventory:itemUsed", function(item, info)
    if has_value(items, item) == -1 then return end

    if removing then
        TriggerEvent("DoLongHudText", "Mais devagar ok?", 2)
        return
    end

    if antispam >= GetCloudTimeAsInt() then
        TriggerEvent("DoLongHudText", "Mais devagar ok?", 2)
        return
    end

    antispam = GetCloudTimeAsInt() + 1

    local info = json.decode(info)

    toggleFaceWear(item, false, info, false)
end)

RegisterNetEvent("facewear:adjust")
AddEventHandler("facewear:adjust",function(pType, pRemove, pIsSteal)
    if type(pType) == "table" then
        for _, wearType in pairs(pType) do
            toggleFaceWear(wearType.id, wearType.shouldRemove, wearType.info, wearType.isSteal)
        end
    else
        toggleFaceWear(pType, pRemove, {}, pIsSteal)
    end
end)

AddEventHandler("pw-facewear:steal", function(pArgs)
    loadAnimDict("random@domestic")
  	TaskTurnPedToFaceEntity(PlayerPedId(), pArgs.entity, -1)
  	TaskPlayAnim(PlayerPedId(),"random@domestic", "pickup_low",5.0, 1.0, 1.0, 48, 0.0, 0, 0, 0)
  	Citizen.Wait(1600)
  	ClearPedTasks(PlayerPedId())
  	TriggerServerEvent("facewear:adjust", GetPlayerServerId(NetworkGetPlayerIndexFromPed(pArgs.entity)), pArgs.type, true, true)
end)

AddEventHandler("pw-facewear:radial", function(data)
    
	if antispam >= GetCloudTimeAsInt() then
        TriggerEvent("DoLongHudText", "Thao tác chơm hơn!", 2)
        return
    end

    antispam = GetCloudTimeAsInt() + 1

    toggleFaceWear(data.type, true, {}, false)
end)

AddEventHandler("pw-facewear:clothesMenu", function(pArgs, pEntity)
    local context = {}
    local text = "Tháo"
    local event = "pw-facewear:radial"

    if pArgs == "steal" then
        text = "Lấy trộm"
        event = "pw-facewear:steal"
    else
        pEntity = PlayerPedId()
    end

    local sex = GetSkinSex(pEntity)

    -- Hat
    local currentProp = GetPedPropIndex(pEntity, 0) or -1
    local disabled = currentProp == -1

    context[#context+1] = {
        title = text .. " Mũ",
        action = event,
        key = {
            type = "hat",
            entity = pEntity,
        },
        disabled = disabled,
    }

    -- Googles
    local currentProp = GetPedPropIndex(pEntity, 1) or -1
    local disabled = currentProp == -1

    context[#context+1] = {
        title = text .. " Kính",
        action = event,
        key = {
            type = "googles",
            entity = pEntity,
        },
        disabled = disabled,
    }

    -- Mask
    local currentDrawable = GetPedDrawableVariation(pEntity, 1) or -1
    local disabled = currentDrawable == -1

    context[#context+1] = {
        title = text .. " Mặt nạ",
        action = event,
        key = {
            type = "mask",
            entity = pEntity,
        },
        disabled = disabled,
    }

    -- Chain
    local currentDrawable = GetPedDrawableVariation(pEntity, 7) or -1
    local disabled = currentDrawable == -1

    context[#context+1] = {
        title = text .. " Dây chuyền",
        action = event,
        key = {
            type = "chain",
            entity = pEntity,
        },
        disabled = disabled,
    }

    -- Jacket
    local currentDrawable = GetPedDrawableVariation(pEntity, 11) or -1
    local arm = GetPedDrawableVariation(pEntity, 3) or 0

    local bareTorsoIndex = 15
    local bareArmsIndex = 15

    if sex == "female" then
        bareTorsoIndex = 18
    end

    local disabled = currentDrawable == -1 or currentDrawable == bareTorsoIndex

    context[#context+1] = {
        title = text .. " Áo khoác",
        action = event,
        key = {
            type = "jacket",
            entity = pEntity,
        },
        disabled = disabled,
    }

    -- Shirt
    local currentDrawable = GetPedDrawableVariation(pEntity, 8) or -1

    local bareTorsoIndex = 15

    if sex == "female" then
        bareTorsoIndex = 18
    end

    local disabled = currentDrawable == -1 or currentDrawable == bareTorsoIndex

    context[#context+1] = {
        title = text .. " Áo thun",
        action = event,
        key = {
            type = "shirt",
            entity = pEntity,
        },
        disabled = disabled,
    }

    -- Vest
    local currentDrawable = GetPedDrawableVariation(pEntity, 9) or -1
    local disabled = currentDrawable == -1

    context[#context+1] = {
        title = text .. " Áo vest",
        action = event,
        key = {
            type = "vest",
            entity = pEntity,
        },
        disabled = disabled,
    }

    -- Backpack
    local currentDrawable = GetPedDrawableVariation(pEntity, 5) or -1
    local disabled = currentDrawable == -1

    context[#context+1] = {
        title = text .. " Balo",
        action = event,
        key = {
            type = "backpack",
            entity = pEntity,
        },
        disabled = disabled,
    }

    -- Pants
    local currentDrawable = GetPedDrawableVariation(pEntity, 4) or -1

    local bareLegsIndex = 61

    if sex == "female" then
        bareLegsIndex = 17
    end

    local disabled = currentDrawable == -1 or currentDrawable == bareLegsIndex

    context[#context+1] = {
        title = text .. " Quần",
        action = event,
        key = {
            type = "pants",
            entity = pEntity,
        },
        disabled = disabled,
    }

    -- Shoes
    local currentDrawable = GetPedDrawableVariation(pEntity, 6) or -1

    local bareFootIndex = 34

    if sex == "female" then
        bareFootIndex = 35
    end

    local disabled = currentDrawable == -1 or currentDrawable == bareFootIndex

    context[#context+1] = {
        title = text .. " Giày",
        action = event,
        key = {
            type = "shoes",
            entity = pEntity,
        },
        disabled = disabled,
    }

    -- Watch
    local currentProp = GetPedPropIndex(pEntity, 6) or -1
    local disabled = currentProp == -1

    context[#context+1] = {
        title = text .. " Đồng hồ",
        action = event,
        key = {
            type = "watch",
            entity = pEntity,
        },
        disabled = disabled,
    }

    -- Braclets
    local currentProp = GetPedPropIndex(pEntity, 7) or -1
    local disabled = currentProp == -1

    context[#context+1] = {
        title = text .. " Vòng đeo tay",
        action = event,
        key = {
            type = "braclets",
            entity = pEntity,
        },
        disabled = disabled,
    }

    -- Braclets
    local currentProp = GetPedPropIndex(pEntity, 2) or -1
    local disabled = currentProp == -1

    context[#context+1] = {
        title = text .. " Hoa tai",
        action = event,
        key = {
            type = "earrings",
            entity = pEntity,
        },
        disabled = disabled,
    }

    exports["pw-context"]:showContextMenu(context)
end)



Citizen.CreateThread(function()
    local group = { 1 }

    local data = {
        {
            id = "steal_shoes",
            label = "Roubar Roupas",
            icon = "tshirt",
            event = "pw-facewear:clothesMenu",
            parameters = "steal"
        },
    }

    local options = {
        distance = { radius = 1.5 },
        isEnabled = function(pEntity, pContext)
            return not IsDisabled() and pContext.flags["isPlayer"] and (pContext.flags["isCuffed"] or pContext.flags["isDead"] or isPersonBeingHeldUp(pEntity))
        end
    }

    exports["pw-interact"]:AddPeekEntryByEntityType(group, data, options)
end)