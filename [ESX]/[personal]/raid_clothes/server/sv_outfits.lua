RegisterServerEvent("raid_clothes:list_outfits")
AddEventHandler("raid_clothes:list_outfits",function()

    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local steamid = xPlayer.getIdentifier()
    local slot = slot
    local name = name

    if not steamid then return end

    MySQL.query("SELECT slot, name FROM character_outfits WHERE steamid = @steamid", {['steamid'] = steamid}, function(skincheck)
    	TriggerClientEvent("raid_clothes:ListOutfits",src, skincheck)
	end)
end)


RegisterServerEvent("raid_clothes:set_outfit")
AddEventHandler("raid_clothes:set_outfit",function(slot, name, data)
    if not slot then return end
    local src = source

    local user = ESX.GetPlayerFromId(src)
    local characterId = user.getIdentifier()

    if not characterId then return end

    MySQL.query("SELECT slot FROM character_outfits WHERE steamid = @steamid and slot = @slot", {
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
            MySQL.query("UPDATE character_outfits SET "..set.." WHERE steamid = @steamid and slot = @slot",values)
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

            MySQL.query("INSERT INTO character_outfits ("..cols..") VALUES ("..vals..")", values, function()
                TriggerClientEvent('DoLongHudText', src,  name .. " isimli kıyafetiniz artık " .. slot.. ". slotta bulunuyor.", 1)
            end)
        end
	end)
end)


RegisterServerEvent("raid_clothes:remove_outfit")
AddEventHandler("raid_clothes:remove_outfit",function(slot)

    local src = source
    local user = ESX.GetPlayerFromId(src)
    local steamid = user.getIdentifier()
    local slot = slot

    if not steamid then return end

    MySQL.query( "DELETE FROM character_outfits WHERE steamid = @steamid AND slot = @slot", { ['steamid'] = steamid,  ["slot"] = slot } )
    TriggerClientEvent('DoLongHudText', src, "" .. slot .. ". slottaki kıyafet silindi.", 1)
end)

RegisterServerEvent("raid_clothes:get_outfit")
AddEventHandler("raid_clothes:get_outfit",function(slot)
    if not slot then return end
    local src = source

    local user = ESX.GetPlayerFromId(src)
    local characterId = user.getIdentifier()

    if not characterId then return end

    MySQL.query("SELECT * FROM character_outfits WHERE steamid = @steamid and slot = @slot", {
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
                hairColor = json.decode(result[1].hairColor),
				fadeStyle = json.decode(result[1].fadeStyle),
				headBlend = json.decode(result[1].headBlend),
				headStructure = json.decode(result[1].headStructure),
				headOverlay = json.decode(result[1].headOverlay),

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
            MySQL.query("UPDATE users SET "..set.." WHERE identifier = @identifier",values)
        else
            TriggerClientEvent('DoLongHudText', src, "No outfit on slot :" .. slot, 1)
            return
        end
	end)
end)
