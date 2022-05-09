RegisterServerEvent("raid_clothes:list_outfits")
AddEventHandler("raid_clothes:list_outfits",function()
    local src = source
    local user = ESX.GetPlayerFromId(src)
    local steamid = user.identifier
    local slot = slot
    local name = name

    if not steamid then return end

    MySQL.Async.fetchAll("SELECT slot, name FROM character_outfits WHERE steamid = @steamid", {['steamid'] = steamid}, function(skincheck)
    	TriggerClientEvent("raid_clothes:listOutfits",src, skincheck)
	end)
end)


RegisterServerEvent("raid_clothes:set_outfit")
AddEventHandler("raid_clothes:set_outfit",function(slot, name, data)
    if not slot then return end
    local src = source

    local user = ESX.GetPlayerFromId(src)
    local characterId = user.identifier

    if not characterId then return end

    MySQL.Async.fetchAll("SELECT slot FROM character_outfits WHERE steamid = @steamid and slot = @slot", {
        ['steamid'] = characterId,
        ['slot'] = slot
    }, function(result)
        if result and result[1] then
            local values = {
                ["steamid"] = characterId,
                ["slot"] = slot,
                ["name"] = name,
                ["model"] = json.encode(data.model),
                ["drawables"] = json.encode(data.drawables),
                ["props"] = json.encode(data.props),
                ["drawtextures"] = json.encode(data.drawtextures),
                ["proptextures"] = json.encode(data.proptextures),
                ["hairColor"] = json.encode(data.hairColor),
            }

            local set = "model = @model,name = @name,drawables = @drawables,props = @props,drawtextures = @drawtextures,proptextures = @proptextures,hairColor = @hairColor"
            MySQL.Async.execute("UPDATE character_outfits SET "..set.." WHERE steamid = @steamid and slot = @slot",values)
        else
            local cols = "steamid, model, name, slot, drawables, props, drawtextures, proptextures, hairColor"
            local vals = "@steamid, @model, @name, @slot, @drawables, @props, @drawtextures, @proptextures, @hairColor"

            local values = {
                ["steamid"] = characterId,
                ["name"] = name,
                ["slot"] = slot,
                ["model"] = data.model,
                ["drawables"] = json.encode(data.drawables),
                ["props"] = json.encode(data.props),
                ["drawtextures"] = json.encode(data.drawtextures),
                ["proptextures"] = json.encode(data.proptextures),
                ["hairColor"] = json.encode(data.hairColor)
            }

            MySQL.Async.execute("INSERT INTO character_outfits ("..cols..") VALUES ("..vals..")", values, function()
                TriggerClientEvent('DoLongHudText', src,  name .. " isimli kıyafetiniz artık " .. slot.. ". slotta bulunuyor.", 1)
            end)
        end
	end)
end)


RegisterServerEvent("raid_clothes:remove_outfit")
AddEventHandler("raid_clothes:remove_outfit",function(slot)

    local src = source
    local user = ESX.GetPlayerFromId(src)
    local steamid = user.identifier
    local slot = slot

    if not steamid then return end

    MySQL.Async.execute( "DELETE FROM character_outfits WHERE steamid = @steamid AND slot = @slot", { ['steamid'] = steamid,  ["slot"] = slot } )
    TriggerClientEvent('DoLongHudText', src, "" .. slot .. ". slottaki kıyafet silindi.", 1)
end)

RegisterServerEvent("raid_clothes:get_outfit")
AddEventHandler("raid_clothes:get_outfit",function(slot)
    if not slot then return end
    local src = source

    local user = ESX.GetPlayerFromId(src)
    local characterId = user.identifier

    if not characterId then return end

    MySQL.Async.fetchAll("SELECT * FROM character_outfits WHERE steamid = @steamid and slot = @slot", {
        ['steamid'] = characterId,
        ['slot'] = slot
    }, function(result)
        if result and result[1] then
            if result[1].model == nil then
                TriggerClientEvent('DoLongHudText', src, "Kullanılamıyor!", 2)
                return
            end

            local data = {
                model = result[1].model,
                drawables = json.decode(result[1].drawables),
                props = json.decode(result[1].props),
                drawtextures = json.decode(result[1].drawtextures),
                proptextures = json.decode(result[1].proptextures),
                hairColor = json.decode(result[1].hairColor)
            }

            TriggerClientEvent("raid_clothes:setclothes", src, data,0)

            local values = {
                ["identifier"] = characterId,
                ["model"] = data.model,
                ["drawables"] = json.encode(data.drawables),
                ["props"] = json.encode(data.props),
                ["drawtextures"] = json.encode(data.drawtextures),
                ["proptextures"] = json.encode(data.proptextures),
            }

            local set = "model = @model, drawables = @drawables, props = @props,drawtextures = @drawtextures,proptextures = @proptextures"
            MySQL.Async.execute("UPDATE users SET "..set.." WHERE identifier = @identifier",values)
        else
            TriggerClientEvent('DoLongHudText', src, "Bu slotta kıyafetiniz yok. Slot:" .. slot, 1)
            return
        end
	end)
end)
