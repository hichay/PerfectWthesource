ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
databaseFormat = {
    "model",
    "drawables",
    "props",
    "drawtextures",
    "proptextures",
    "hairColor",
    "fadeStyle",
    "headBlend",
    "headStructure",
    "headOverlay",
}
local function checkExistenceClothes(cid, cb)
   -- MySQL.Async.fetchall("SELECT cid FROM character_current WHERE cid = @cid LIMIT 1;", {["cid"] = cid}, function(result)
        MySQL.Async.fetchAll('SELECT cid FROM character_current WHERE cid = @cid LIMIT 1', {['@cid'] = cid}, function(result)
        local exists = result and result[1] and true or false
        cb(exists)
    end)
end



local function checkExistenceFace(cid, cb)
	MySQL.Async.fetchAll('SELECT identifier FROM users WHERE identifier = @identifier LIMIT 1', {['@identifier'] = cid}, function(result)
		local exists = result and result[1] and true or false
        cb(exists)
    end)
end

ESX.RegisterServerCallback('raid_clothes:getSex', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {["identifier"] = xPlayer.getIdentifier()}, function(result)
        cb(result[1].sex)
    end)
end)


RegisterServerEvent("SpawnEventsServer")
AddEventHandler("SpawnEventsServer", function()
    local src = source

    TriggerEvent("pw-clothes:getClothes", src)
end)

RegisterServerEvent("raid_clothes:insert_character_current")
AddEventHandler("raid_clothes:insert_character_current",function(data)
    if not data then return end
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local characterId = xPlayer.getIdentifier()
    if not characterId then return end
    checkExistenceClothes(characterId, function(exists)
        local values = {
            ["identifier"] = characterId,
            ["model"] = json.encode(data.model),
            ["drawables"] = json.encode(data.drawables),
            ["props"] = json.encode(data.props),
            ["drawtextures"] = json.encode(data.drawtextures),
            ["proptextures"] = json.encode(data.proptextures),
        }

        if not exists then
            local cols = "identifier, model, drawables, props, drawtextures, proptextures"
            local vals = "@identifier, @model, @drawables, @props, @drawtextures, @proptextures"
            local set = "model = @model,drawables = @drawables,props = @props,drawtextures = @drawtextures,proptextures = @proptextures"
            MySQL.Async.execute("UPDATE users SET "..set.." WHERE identifier = @identifier", values, function()
            end)
            return
        end
		
        local set = "model = @model,drawables = @drawables,props = @props,drawtextures = @drawtextures,proptextures = @proptextures"
        MySQL.Async.execute("UPDATE users SET "..set.." WHERE identifier = @identifier", values)
    end)
end)

RegisterServerEvent("raid_clothes:insert_character_skin")
AddEventHandler("raid_clothes:insert_character_skin",function(data)
    if not data then return end
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local characterId = xPlayer.getIdentifier()
    if not characterId then return end
    checkExistenceClothes(characterId, function(exists)

        MySQL.Async.execute('UPDATE users SET skin = @skin WHERE identifier = @identifier', {
            ['@skin'] = json.encode(data.drawables)..json.encode(data.props)..json.encode(data.drawtextures)..json.encode(data.proptextures),
            ['@identifier'] =characterId
        })

    end)
end)

RegisterServerEvent("clothing:checkIfNew")
AddEventHandler("clothing:checkIfNew", function()
    local src = source
    local user = ESX.GetPlayerFromId(src)
    local steamid = user.identifier

    MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier LIMIT 1", {
        ['identifier'] = steamid
    }, function(result)
        local isService = false;
        if user.job.name == "police" or user.job.name == "ambulance" then isService = true end

        if result[1] == nil then
            MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {["identifier"] = steamid}, function(result)
                if result[1].skin then
                    TriggerClientEvent('raid_clothes:setclothes',src,{},json.decode(result[1].skin))
                else
                    TriggerClientEvent('raid_clothes:setclothes',src,{},nil)
                end
                return
            end)
        else
            TriggerEvent("raid_clothes:get_character_current", src)
        end
        TriggerClientEvent("raid_clothes:inService",src,isService)
    end)
end)

RegisterServerEvent("raid_clothes:insert_character_face")
AddEventHandler("raid_clothes:insert_character_face",function(data)
    if not data then return end
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local characterId = xPlayer.getIdentifier()
    if not characterId then return end
    checkExistenceFace(characterId, function(exists)
        local values = {
            ["identifier"] = characterId,
            ["hairColor"] = json.encode(data.hairColor),
            ["headBlend"] = json.encode(data.headBlend),
            ["headOverlay"] = json.encode(data.headOverlay),
            ["headStructure"] = json.encode(data.headStructure),
      
        }

        if not exists then
            local cols = "identifier, hairColor, headBlend, headOverlay, headStructure"
            local vals = "@identifier, @hairColor, @headBlend, @headOverlay, @headStructure"
            local set = "hairColor = @hairColor,headBlend = @headBlend,headOverlay = @headOverlay,headStructure = @headStructure"
            MySQL.Async.execute("UPDATE users SET "..set.." WHERE identifier = @identifier", values, function()
            end)
            return
        end

        local set = "hairColor = @hairColor,headBlend = @headBlend,headOverlay = @headOverlay,headStructure = @headStructure"
        MySQL.Async.execute("UPDATE users SET "..set.." WHERE identifier = @identifier", values)
    end)
end)


RegisterServerEvent("raid_clothes:get_character_face")
AddEventHandler("raid_clothes:get_character_face",function(pSrc)
    local src = (not pSrc and source or pSrc)
    local xPlayer = ESX.GetPlayerFromId(src)
    local characterId = xPlayer.getIdentifier()

    if not characterId then return end
    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {['@identifier'] = characterId}, function(result)
        local temp_data = {
            hairColor = json.decode(result[1].hairColor),
            headBlend = json.decode(result[1].headBlend),
            headOverlay = json.decode(result[1].headOverlay),
            headStructure = json.decode(result[1].headStructure),
            drawables = json.decode(result[1].drawables),
            props = json.decode(result[1].props),
            drawtextures = json.decode(result[1].drawtextures),
            proptextures = json.decode(result[1].proptextures),
            sex = result[1].sex,
        }
        local model = tonumber(result[1].model)
        if model == 1885233650 or model == -1667301416 then
            TriggerClientEvent("raid_clothes:setpedfeatures", src, temp_data)
        end
       
	end)
    --MySQL.Async.fetchall("SELECT cc.model, cf.hairColor, cf.headBlend, cf.headOverlay, cf.headStructure FROM character_face cf INNER JOIN users cc on cc.identifier = cf.identifier WHERE cf.identifier = @identifier", {['identifier'] = characterId}, function(result)
       
end)


RegisterServerEvent("raid_clothes:get_character_current")
AddEventHandler("raid_clothes:get_character_current",function(pSrc)
    local src = (not pSrc and source or pSrc)
    local xPlayer = ESX.GetPlayerFromId(src)
    local characterId = xPlayer.getIdentifier()

    if not characterId then return end

    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {['@identifier'] = characterId}, function(result)
        local temp_data = {
            model = result[1].model,
            drawables = json.decode(result[1].drawables),
            props = json.decode(result[1].props),
            drawtextures = json.decode(result[1].drawtextures),
            proptextures = json.decode(result[1].proptextures),
        }
        TriggerClientEvent("raid_clothes:setclothes", src, temp_data,0)
	end)
end)


RegisterNetEvent("raid_clothes:retrieve_tats")
AddEventHandler("raid_clothes:retrieve_tats", function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local playerId = xPlayer.getIdentifier()
	MySQL.Async.fetchAll("SELECT * FROM playerstattoos WHERE identifier = @identifier", {['@identifier'] = playerId}, function(result)
        if result and result[1] ~= nil then
			TriggerClientEvent("raid_clothes:settattoos", src, json.decode(result[1].tattoos))
		else
			local tattooValue = "{}"
			MySQL.Async.execute("INSERT INTO playerstattoos (identifier, tattoos) VALUES (@identifier, @tattoo)", {['@identifier'] = playerId, ['@tattoo'] = tattooValue})
			TriggerClientEvent("raid_clothes:settattoos", src, {})
		end
	end)
end)


RegisterNetEvent("raid_clothes:set_tats")
AddEventHandler("raid_clothes:set_tats", function(tattoosList)
	local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local playerId = xPlayer.getIdentifier()
	MySQL.Async.execute("UPDATE playerstattoos SET tattoos = @tattoos WHERE identifier = @identifier", {['@tattoos'] = json.encode(tattoosList), ['@identifier'] = playerId})
end)



-- RegisterServerEvent("pw-clothes:getClothes")
-- AddEventHandler("pw-clothes:getClothes", function(_src)
    -- local src = (not _src and source or _src)

    -- local cid = exports["pw-base"]:getChar(src, "id")
    -- if not cid then return end

    -- local clothes = MySQL.single.await([[
        -- SELECT *
        -- FROM characters_clothes
        -- WHERE cid = ?
    -- ]],
    -- { cid })

    -- if clothes then
        -- local data = {
            -- model = clothes.model,
            -- drawables = json.decode(clothes.drawables),
            -- props = json.decode(clothes.props),
            -- drawtextures = json.decode(clothes.drawtextures),
            -- proptextures = json.decode(clothes.proptextures),
            -- hairColor = json.decode(clothes.hairColor),
            -- fadeStyle = clothes.fadeStyle,
            -- headBlend = json.decode(clothes.headBlend),
            -- headStructure = json.decode(clothes.headStructure),
            -- headOverlay = json.decode(clothes.headOverlay),
            -- tattoos = json.decode(clothes.tattoos),
        -- }

        -- TriggerClientEvent("pw-clothes:setClothes", src, data)
    -- end
-- end)

-- RegisterServerEvent("pw-clothes:updateClothes")
-- AddEventHandler("pw-clothes:updateClothes",function(data, tats)
    -- if not data then return end
    -- local src = source

    -- local cid = exports["pw-base"]:getChar(src, "id")
    -- if not cid then return end

    -- for i, v in ipairs(databaseFormat) do
        -- if v == "model" then
            -- data[v] = tostring(data[v])
        -- elseif v == "fadeStyle" then
            -- data[v] = tonumber(data[v])
        -- else
            -- if data[v] then
                -- data[v] = json.encode(data[v])
            -- else
                -- data[v] = json.encode({})
            -- end
        -- end
    -- end

    -- if type(tats) ~= "table" then tats = {} end
    -- local tattoos = json.encode(tats)

    -- local exist = MySQL.scalar.await([[
        -- SELECT cid
        -- FROM characters_clothes
        -- WHERE cid = ?
    -- ]],
    -- { cid })

    -- if exist then
        -- MySQL.update([[
            -- UPDATE characters_clothes
            -- SET model = ?, drawables = ?, props = ?, drawtextures = ?, proptextures = ?, hairColor = ?, fadeStyle = ?, headBlend = ?, headStructure = ?, headOverlay = ?, tattoos = ?
            -- WHERE cid = ?
        -- ]],
        -- { data.model, data.drawables, data.props, data.drawtextures, data.proptextures, data.hairColor, data.fadeStyle, data.headBlend, data.headStructure, data.headOverlay, tattoos, cid })
    -- else
        -- MySQL.insert([[
            -- INSERT INTO characters_clothes (cid, model, drawables, props, drawtextures, proptextures, hairColor, fadeStyle, headBlend, headStructure, headOverlay, tattoos)
            -- VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        -- ]],
        -- { cid, data.model, data.drawables, data.props, data.drawtextures, data.proptextures, data.hairColor, data.fadeStyle, data.headBlend, data.headStructure, data.headOverlay, tattoos })
    -- end
-- end)

-- RegisterServerEvent("pw-clothes:getTattoos")
-- AddEventHandler("pw-clothes:getTattoos", function(_src)
    -- local src = (not _src and source or _src)

    -- local cid = exports["pw-base"]:getChar(src, "id")

    -- local tattoos = MySQL.scalar.await([[
        -- SELECT tattoos
        -- FROM characters_clothes
        -- WHERE cid = ?
    -- ]],
    -- { cid })

    -- if tattoos then
        -- TriggerClientEvent("raid_clothes:settattoos", src, json.decode(tattoos))
    -- else
        -- TriggerClientEvent("raid_clothes:settattoos", src, {})
    -- end
-- end)


RPC.register("clothing:purchase", function(src, price, tax, paymentType)
	local xPlayer = ESX.GetPlayerFromId(source)
    
    if not xPlayer then return false end

    if paymentType == "cash" then
		local cash = xPlayer.getAccount('money').money

        if price > cash then
            return false
        else 
			xPlayer.removeAccountMoney('money', price)
			return true
		end

       

        exports["pw-balance"]:addTax("Services", tax)
    else

        local bank = xPlayer.getAccount('bank').money

        if price > bank then
            return false
        else
			xPlayer.removeAccountMoney('bank', price)
			return true
		end

		
        exports["pw-balance"]:addTax("Services", tax)
    end

    return true
end)