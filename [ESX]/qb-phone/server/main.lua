ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local QBPhone = {}
local Tweets = {}
local AppAlerts = {}
local MentionedTweets = {}
local Hashtags = {}
local Calls = {}
local Adverts = {}
local GeneratedPlates = {}
local WebHook = "https://discord.com/api/webhooks/871842880799510578/B9ua40_BMwQ1wSZ2gMRUDTx8DgZKWY5_zE2pYNWkfXB2KElaLQatB70nmMdYAxIcnuI6"
local bannedCharacters = {'%','$',';'}

AddEventHandler('esx:playerLoaded',function(playerId, xPlayer)
    local sourcePlayer = playerId
    local identifier = xPlayer.getIdentifier()

    getOrGeneratePhoneNumber(identifier, function(myPhoneNumber)
    end)

    getOrGenerateIBAN(identifier, function(iban)
    end)
end)

function GetPlayerFromPhone(phone)
    local result = MySQL.Sync.fetchAll('SELECT * FROM users WHERE phone = @phone', {
		['@phone'] = phone
    })
    
    if result[1] and result[1].identifier then
        return ESX.GetPlayerFromIdentifier(result[1].identifier)
    end

    return nil
end

function GetCharacter(source)
    local xPlayer = ESX.GetPlayerFromId(source)

	local result = MySQL.Sync.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	})

    return result[1]
end

function GetTargetCharacter(identifier)

	local result = MySQL.Sync.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
		['@identifier'] = identifier
	})

    return result[1]
end

function getPlayerFromIBAN(iban)
    local result = MySQL.Sync.fetchAll('SELECT * FROM users WHERE iban = @iban', {
		['@iban'] = iban
    })
    
    if result[1] and result[1].identifier then
        return ESX.GetPlayerFromIdentifier(result[1].identifier)
    end

    return nil
end

-- Number and IBAN Generate Stuff 
function getPhoneRandomNumber()
    local numBase0 = 0
    local numBase1 = 6
    local numBase2 = math.random(11111111, 99999999)
    local num = string.format(numBase0 .. "" .. numBase1 .. "" .. numBase2 .. "")
    return num
end

function generateIBAN()
    local numBase0 = math.random(10, 99999)
    local num = string.format('PW'..numBase0)

	return num
end

function getNumberPhone(identifier)
    local result = MySQL.Sync.fetchAll("SELECT users.phone FROM users WHERE users.identifier = @identifier", {
        ['@identifier'] = identifier
    })
    if result[1] ~= nil then
        return result[1].phone
    end
    return nil
end

function getIBAN(identifier)
    local result = MySQL.Sync.fetchAll("SELECT users.iban FROM users WHERE users.identifier = @identifier", {
        ['@identifier'] = identifier
    })
    if result[1] ~= nil then
        return result[1].iban
    end
    return nil
end

local function GetOnlineStatus(number)
    local Target = GetPlayerFromPhone(number)
    local retval = false
    if Target ~= nil then
        retval = true
    end
    return retval
end

function getOrGenerateIBAN(identifier, cb)
    local identifier = identifier
    local myIBAN = getIBAN(identifier)

    if myIBAN == '0' or myIBAN == nil then
        repeat
            myIBAN = generateIBAN()
            local id = getPlayerFromIBAN(myIBAN)

        until id == nil

        MySQL.Async.insert("UPDATE users SET iban = @myIBAN WHERE identifier = @identifier", { 
            ['@myIBAN'] = myIBAN,
            ['@identifier'] = identifier

        }, function()
            cb(myIBAN)
        end)
    else
        cb(myIBAN)
    end
end

function getOrGeneratePhoneNumber(identifier, cb)
    local identifier = identifier
    local myPhoneNumber = getNumberPhone(identifier)

    if myPhoneNumber == '0' or myPhoneNumber == nil then
        repeat
            myPhoneNumber = getPhoneRandomNumber()
            local id = GetPlayerFromPhone(myPhoneNumber)

        until id == nil

        MySQL.Async.insert("UPDATE users SET phone = @myPhoneNumber WHERE identifier = @identifier", { 
            ['@myPhoneNumber'] = myPhoneNumber,
            ['@identifier'] = identifier

        }, function()
            cb(myPhoneNumber)
        end)
    else
        cb(myPhoneNumber)
    end
end

local function GenerateMailId()
    return math.random(111111, 999999)
end

local function escape_sqli(source)
    local replacements = {
        ['"'] = '\\"',
        ["'"] = "\\'"
    }
    return source:gsub("['\"]", replacements)
end

local function round(num, numDecimalPlaces)
    if numDecimalPlaces and numDecimalPlaces > 0 then
        local mult = 10 ^ numDecimalPlaces
        return math.floor(num * mult + 0.5) / mult
    end
    return math.floor(num + 0.5)
end

function QBPhone.AddMentionedTweet(citizenid, TweetData)
    if MentionedTweets[citizenid] == nil then
        MentionedTweets[citizenid] = {}
    end
    MentionedTweets[citizenid][#MentionedTweets[citizenid]+1] = TweetData
end

function QBPhone.SetPhoneAlerts(citizenid, app, alerts)
    if citizenid ~= nil and app ~= nil then
        if AppAlerts[citizenid] == nil then
            AppAlerts[citizenid] = {}
            if AppAlerts[citizenid][app] == nil then
                if alerts == nil then
                    AppAlerts[citizenid][app] = 1
                else
                    AppAlerts[citizenid][app] = alerts
                end
            end
        else
            if AppAlerts[citizenid][app] == nil then
                if alerts == nil then
                    AppAlerts[citizenid][app] = 1
                else
                    AppAlerts[citizenid][app] = 0
                end
            else
                if alerts == nil then
                    AppAlerts[citizenid][app] = AppAlerts[citizenid][app] + 1
                else
                    AppAlerts[citizenid][app] = AppAlerts[citizenid][app] + 0
                end
            end
        end
    end
end

local function SplitStringToArray(string)
    local retval = {}
    for i in string.gmatch(string, "%S+") do
        retval[#retval+1] = i
    end
    return retval
end

local function GenerateOwnerName()
    local names = {
        [1] = { name = "Bailey Sykes",          citizenid = "DSH091G93" },
        [2] = { name = "Aroush Goodwin",        citizenid = "AVH09M193" },
        [3] = { name = "Tom Warren",            citizenid = "DVH091T93" },
        [4] = { name = "Abdallah Friedman",     citizenid = "GZP091G93" },
        [5] = { name = "Lavinia Powell",        citizenid = "DRH09Z193" },
        [6] = { name = "Andrew Delarosa",       citizenid = "KGV091J93" },
        [7] = { name = "Skye Cardenas",         citizenid = "ODF09S193" },
        [8] = { name = "Amelia-Mae Walter",     citizenid = "KSD0919H3" },
        [9] = { name = "Elisha Cote",           citizenid = "NDX091D93" },
        [10] = { name = "Janice Rhodes",        citizenid = "ZAL0919X3" },
        [11] = { name = "Justin Harris",        citizenid = "ZAK09D193" },
        [12] = { name = "Montel Graves",        citizenid = "POL09F193" },
        [13] = { name = "Benjamin Zavala",      citizenid = "TEW0J9193" },
        [14] = { name = "Mia Willis",           citizenid = "YOO09H193" },
        [15] = { name = "Jacques Schmitt",      citizenid = "QBC091H93" },
        [16] = { name = "Mert Simmonds",        citizenid = "YDN091H93" },
        [17] = { name = "Rickie Browne",        citizenid = "PJD09D193" },
        [18] = { name = "Deacon Stanley",       citizenid = "RND091D93" },
        [19] = { name = "Daisy Fraser",         citizenid = "QWE091A93" },
        [20] = { name = "Kitty Walters",        citizenid = "KJH0919M3" },
        [21] = { name = "Jareth Fernandez",     citizenid = "ZXC09D193" },
        [22] = { name = "Meredith Calhoun",     citizenid = "XYZ0919C3" },
        [23] = { name = "Teagan Mckay",         citizenid = "ZYX0919F3" },
        [24] = { name = "Kurt Bain",            citizenid = "IOP091O93" },
        [25] = { name = "Burt Kain",            citizenid = "PIO091R93" },
        [26] = { name = "Joanna Huff",          citizenid = "LEK091X93" },
        [27] = { name = "Carrie-Ann Pineda",    citizenid = "ALG091Y93" },
        [28] = { name = "Gracie-Mai Mcghee",    citizenid = "YUR09E193" },
        [29] = { name = "Robyn Boone",          citizenid = "SOM091W93" },
        [30] = { name = "Aliya William",        citizenid = "KAS009193" },
        [31] = { name = "Rohit West",           citizenid = "SOK091093" },
        [32] = { name = "Skylar Archer",        citizenid = "LOK091093" },
        [33] = { name = "Jake Kumar",           citizenid = "AKA420609" },
    }
    return names[math.random(1, #names)]
end

-- Callbacks

ESX.RegisterServerCallback('qb-phone:server:GetCallState', function(source, cb, ContactData)
    local Target = GetPlayerFromPhone(ContactData.number)
    if Target ~= nil then
        if Calls[Target.identifier] ~= nil then
            if Calls[Target.identifier].inCall then
                cb(false, true)
            else
                cb(true, true)
            end
        else
            cb(true, true)
        end
    else
        cb(false, false)
    end
end)
ESX.RegisterServerCallback('qb-phone:server:GetCharacterData', function(source, cb,id)
    local src = source or id
    local xPlayer = ESX.GetPlayerFromId(source)
    
    cb(GetCharacter(src))
end)

ESX.RegisterServerCallback('qb-phone:server:GetPhoneData', function(source, cb)
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    if Player ~= nil then
        local PhoneData = {
            Applications = {},
            PlayerContacts = {},
            MentionedTweets = {},
            Chats = {},
            Hashtags = {},
            Invoices = {},
            Garage = {},
            Mails = {},
            Adverts = {},
            CryptoTransactions = {},
            Tweets = {},
            Images = {}
        }
        PhoneData.Adverts = Adverts

        local result = MySQL.Sync.fetchAll('SELECT * FROM player_contacts WHERE citizenid = ? ORDER BY name ASC', {Player.identifier})
        local Contacts = {}
        if result[1] ~= nil then
            for k, v in pairs(result) do
                v.status = GetOnlineStatus(v.number)
            end

            PhoneData.PlayerContacts = result
        end

        local invoices = MySQL.Sync.fetchAll('SELECT * FROM phone_invoices WHERE citizenid = ?', {Player.identifier})
        if invoices[1] ~= nil then
            for k, v in pairs(invoices) do
                local Ply = QBCore.Functions.GetPlayerByCitizenId(v.sender)
                if Ply ~= nil then
                    v.number = Ply.PlayerData.charinfo.phone
                else
                    local res = MySQL.Sync.fetchAll('SELECT * FROM players WHERE citizenid = ?', {v.sender})
                    if res[1] ~= nil then
                        res[1].charinfo = json.decode(res[1].charinfo)
                        v.number = res[1].charinfo.phone
                    else
                        v.number = nil
                    end
                end
            end
            PhoneData.Invoices = invoices
        end

        local garageresult = MySQL.Sync.fetchAll('SELECT * FROM owned_vehicles WHERE owner = ?', {Player.identifier})
        if garageresult[1] ~= nil then
            -- for k, v in pairs(garageresult) do
                -- local vehicleModel = v.vehicle
                -- if (QBCore.Shared.Vehicles[vehicleModel] ~= nil) and (Garages[v.garage] ~= nil) then
                    -- v.garage = Garages[v.garage].label
                    -- v.vehicle = QBCore.Shared.Vehicles[vehicleModel].name
                    -- v.brand = QBCore.Shared.Vehicles[vehicleModel].brand
                -- end

            -- end
            PhoneData.Garage = garageresult
        end

        local messages = MySQL.Sync.fetchAll('SELECT * FROM phone_messages WHERE citizenid = ?', {Player.identifier})
        if messages ~= nil and next(messages) ~= nil then
            PhoneData.Chats = messages
        end

        if AppAlerts[Player.identifier] ~= nil then
            PhoneData.Applications = AppAlerts[Player.identifier]
        end

        if MentionedTweets[Player.identifier] ~= nil then
            PhoneData.MentionedTweets = MentionedTweets[Player.identifier]
        end

        if Hashtags ~= nil and next(Hashtags) ~= nil then
            PhoneData.Hashtags = Hashtags
        end

        local Tweets = MySQL.Sync.fetchAll('SELECT * FROM phone_tweets WHERE `date` > NOW() - INTERVAL ? hour', {Config.TweetDuration})

        if Tweets ~= nil and next(Tweets) ~= nil then
            PhoneData.Tweets = Tweets
            TWData = Tweets
        end

        local mails = MySQL.Sync.fetchAll('SELECT * FROM player_mails WHERE citizenid = ? ORDER BY `date` ASC', {Player.identifier})
        if mails[1] ~= nil then
            for k, v in pairs(mails) do
                if mails[k].button ~= nil then
                    mails[k].button = json.decode(mails[k].button)
                end
            end
            PhoneData.Mails = mails
        end

        -- local transactions = MySQL.Sync.fetchAll('SELECT * FROM crypto_transactions WHERE citizenid = ? ORDER BY `date` ASC', {Player.identifier})
        -- if transactions[1] ~= nil then
            -- for _, v in pairs(transactions) do
                -- PhoneData.CryptoTransactions[#PhoneData.CryptoTransactions+1] = {
                    -- TransactionTitle = v.title,
                    -- TransactionMessage = v.message
                -- }
            -- end
        -- end
        local images = MySQL.Sync.fetchAll('SELECT * FROM phone_gallery WHERE citizenid = ? ORDER BY `date` DESC',{Player.identifier})
        if images ~= nil and next(images) ~= nil then
            PhoneData.Images = images
        end
        cb(PhoneData)
    end
end)

ESX.RegisterServerCallback('qb-phone:server:PayInvoice', function(source, cb, society, amount, invoiceId, sendercitizenid)
    local Invoices = {}
    local Ply = ESX.GetPlayerFromId(source)
    local SenderPly = ESX.GetPlayerFromId(sendercitizenid)
    local invoiceMailData = {}
    if SenderPly and Config.BillingCommissions[society] then
        local commission = round(amount * Config.BillingCommissions[society])
        SenderPly.Functions.AddMoney('bank', commission)
        invoiceMailData = {
            sender = 'Billing Department',
            subject = 'Commission Received',
            message = string.format('You received a commission check of $%s when %s %s paid a bill of $%s.', commission, Ply.PlayerData.charinfo.firstname, Ply.PlayerData.charinfo.lastname, amount)
        }
    elseif not SenderPly and Config.BillingCommissions[society] then
        invoiceMailData = {
            sender = 'Billing Department',
            subject = 'Bill Paid',
            message = string.format('%s %s paid a bill of $%s', Ply.PlayerData.charinfo.firstname, Ply.PlayerData.charinfo.lastname, amount)
        }
    end
    Ply.Functions.RemoveMoney('bank', amount, "paid-invoice")
    TriggerEvent('qb-phone:server:sendNewMailToOffline', sendercitizenid, invoiceMailData)
	--exports['qb-management']:AddMoney(society, amount)
    MySQL.Async.execute('DELETE FROM phone_invoices WHERE id = ?', {invoiceId})
    local invoices = MySQL.Sync.fetchAll('SELECT * FROM phone_invoices WHERE citizenid = ?', {Ply.PlayerData.citizenid})
    if invoices[1] ~= nil then
        Invoices = invoices
    end
    cb(true, Invoices)
end)

ESX.RegisterServerCallback('qb-phone:server:DeclineInvoice', function(source, cb, sender, amount, invoiceId)
    local Invoices = {}
    local Ply = ESX.GetPlayerFromId(source)
    MySQL.Async.execute('DELETE FROM phone_invoices WHERE id = ?', {invoiceId})
    local invoices = MySQL.Sync.fetchAll('SELECT * FROM phone_invoices WHERE citizenid = ?', {Ply.identifier})
    if invoices[1] ~= nil then
        Invoices = invoices
    end
    cb(true, Invoices)
end)

ESX.RegisterServerCallback('qb-phone:server:GetContactPictures', function(source, cb, Chats)
    for k, v in pairs(Chats) do
        local Player = ESX.GetPlayerFromIdentifier(v.number)

        local query = '%' .. v.number .. '%'
        local result = MySQL.Sync.fetchAll('SELECT * FROM users WHERE phone LIKE ?', {query})
        if result[1] ~= nil then
            -- local MetaData = json.decode(result[1].metadata)

            -- if MetaData.phone.profilepicture ~= nil then
                -- v.picture = MetaData.phone.profilepicture
            -- else
                -- v.picture = "default"
            -- end
			if result[1] ~= nil then
                if result[1].profilepicture ~= nil then
                    v.picture = result[1].profilepicture
                else
                    v.picture = "default"
                end
            end
        end
    end
    SetTimeout(100, function()
        cb(Chats)
    end)
end)

ESX.RegisterServerCallback('qb-phone:server:GetContactPicture', function(source, cb, Chat)
    local query = '%' .. Chat.number .. '%'
    local result = MySQL.Sync.fetchAll('SELECT * FROM users WHERE phone LIKE ?', {query})
    --local MetaData = json.decode(result[1].metadata)
    -- if MetaData.phone.profilepicture ~= nil then
        -- Chat.picture = MetaData.phone.profilepicture
    -- else
        -- Chat.picture = "default"
    -- end
	if result[1] ~= nil then
            Chat.picture = result[1].profilepicture
        else
            Chat.picture = "default"
        end
    SetTimeout(100, function()
        cb(Chat)
    end)
end)

ESX.RegisterServerCallback('qb-phone:server:GetPicture', function(source, cb, number)
    local Picture = nil
    local query = '%' .. number .. '%'
    local result = MySQL.Sync.fetchAll('SELECT * FROM users WHERE phone LIKE ?', {query})
    if result[1] ~= nil then
        --local MetaData = json.decode(result[1].metadata)
        -- if MetaData.phone.profilepicture ~= nil then
            -- Picture = MetaData.phone.profilepicture
        -- else
            -- Picture = "default"
        -- end
		if result[1].profilepicture ~= nil then
			Picture = result[1].profilepicture
		else
			Picture = "default"
		end
        cb(Picture)
    else
        cb(nil)
    end
end)

ESX.RegisterServerCallback('qb-phone:server:FetchResult', function(source, cb, search)
    local search = escape_sqli(search)
    local searchData = {}
    local ApaData = {}
	local character = GetCharacter(source)
	
	MySQL.Sync.fetchAll("SELECT * FROM `users` WHERE firstname LIKE '%"..search.."%'", function(result)
        if result[1] ~= nil then
            for k, v in pairs(result) do
                local driverlicense = false
                local weaponlicense = false
                local doingSomething = true
                searchData[#searchData + 1]= {
                    citizenid = v.identifier,
                    firstname = character.firstname,
                    lastname = character.lastname,
                    birthdate = character.dateofbirth,
                    phone = character.phone,
                    gender = character.sex,
                    weaponlicense = weaponlicense,
                    driverlicense = driverlicense,
					job = character.job,
                }
              
            end
            cb(searchData)
        else
            cb(nil)
        end
    end)
	
    -- local result = MySQL.Sync.fetchAll(query)
    -- if result[1] ~= nil then
        -- for k, v in pairs(result) do
            -- local charinfo = json.decode(v.charinfo)
            -- local metadata = json.decode(v.metadata)
            -- local appiepappie = {}
            -- if ApaData[v.citizenid] ~= nil and next(ApaData[v.citizenid]) ~= nil then
                -- appiepappie = ApaData[v.citizenid]
            -- end
            -- searchData[#searchData+1] = {
                -- citizenid = v.citizenid,
                -- firstname = charinfo.firstname,
                -- lastname = charinfo.lastname,
                -- birthdate = charinfo.birthdate,
                -- phone = charinfo.phone,
                -- nationality = charinfo.nationality,
                -- gender = charinfo.gender,
                -- warrant = false,
                -- driverlicense = metadata["licences"]["driver"],
                -- appartmentdata = appiepappie
            -- }
        -- end
        -- cb(searchData)
    -- else
        -- cb(nil)
    -- end
end)

ESX.RegisterServerCallback('qb-phone:server:GetVehicleSearchResults', function(source, cb, search)
    local search = escape_sqli(search)
    local searchData = {}
    local query = '%' .. search .. '%'
    local result = MySQL.Sync.fetchAll('SELECT * FROM player_vehicles WHERE plate LIKE ? OR citizenid = ?',
        {query, search})
    if result[1] ~= nil then
        for k, v in pairs(result) do
            local player = MySQL.Sync.fetchAll('SELECT * FROM players WHERE citizenid = ?', {result[k].citizenid})
            if player[1] ~= nil then
                local charinfo = json.decode(player[1].charinfo)
                local vehicleInfo = QBCore.Shared.Vehicles[result[k].vehicle]
                if vehicleInfo ~= nil then
                    searchData[#searchData+1] = {
                        plate = result[k].plate,
                        status = true,
                        owner = charinfo.firstname .. " " .. charinfo.lastname,
                        citizenid = result[k].citizenid,
                        label = vehicleInfo["name"]
                    }
                else
                    searchData[#searchData+1] = {
                        plate = result[k].plate,
                        status = true,
                        owner = charinfo.firstname .. " " .. charinfo.lastname,
                        citizenid = result[k].citizenid,
                        label = "Name not found.."
                    }
                end
            end
        end
    else
        if GeneratedPlates[search] ~= nil then
            searchData[#searchData+1] = {
                plate = GeneratedPlates[search].plate,
                status = GeneratedPlates[search].status,
                owner = GeneratedPlates[search].owner,
                citizenid = GeneratedPlates[search].citizenid,
                label = "Brand unknown.."
            }
        else
            local ownerInfo = GenerateOwnerName()
            GeneratedPlates[search] = {
                plate = search,
                status = true,
                owner = ownerInfo.name,
                citizenid = ownerInfo.citizenid
            }
            searchData[#searchData+1] = {
                plate = search,
                status = true,
                owner = ownerInfo.name,
                citizenid = ownerInfo.citizenid,
                label = "Brand unknown.."
            }
        end
    end
    cb(searchData)
end)

ESX.RegisterServerCallback('qb-phone:server:ScanPlate', function(source, cb, plate)
    local src = source
    local vehicleData = {}
    if plate ~= nil then
        local result = MySQL.Sync.fetchAll('SELECT * FROM player_vehicles WHERE plate = ?', {plate})
        if result[1] ~= nil then
            local player = MySQL.Sync.fetchAll('SELECT * FROM players WHERE citizenid = ?', {result[1].citizenid})
            local charinfo = json.decode(player[1].charinfo)
            vehicleData = {
                plate = plate,
                status = true,
                owner = charinfo.firstname .. " " .. charinfo.lastname,
                citizenid = result[1].citizenid
            }
        elseif GeneratedPlates ~= nil and GeneratedPlates[plate] ~= nil then
            vehicleData = GeneratedPlates[plate]
        else
            local ownerInfo = GenerateOwnerName()
            GeneratedPlates[plate] = {
                plate = plate,
                status = true,
                owner = ownerInfo.name,
                citizenid = ownerInfo.citizenid
            }
            vehicleData = {
                plate = plate,
                status = true,
                owner = ownerInfo.name,
                citizenid = ownerInfo.citizenid
            }
        end
        cb(vehicleData)
    else
        TriggerClientEvent('QBCore:Notify', src, 'No Vehicle Nearby', 'error')
        cb(nil)
    end
end)

-- ESX.RegisterServerCallback('qb-phone:server:HasPhone', function(source, cb)
    -- local Player = QBCore.Functions.GetPlayer(source)
    -- if Player ~= nil then
        -- local HasPhone = Player.Functions.GetItemByName("phone")
        -- if HasPhone ~= nil then
            -- cb(true)
        -- else
            -- cb(false)
        -- end
    -- end
-- end)

ESX.RegisterServerCallback('qb-phone:server:CanTransferMoney', function(source, cb, amount, iban)
    -- strip bad characters from bank transfers
    local newAmount = tostring(amount)
    local newiban = tostring(iban)
    for k, v in pairs(bannedCharacters) do
        newAmount = string.gsub(newAmount, '%' .. v, '')
        newiban = string.gsub(newiban, '%' .. v, '')
    end
    iban = newiban
    amount = tonumber(newAmount)

    local Player = ESX.GetPlayerFromId(source)
    if (Player.getAccounts('bank').money - amount) >= 0 then
        local query = ''..iban
        local result = MySQL.Sync.fetchAll('SELECT * FROM users WHERE iban LIKE ?', {query})
        if result[1] ~= nil then
            local Reciever = ESX.GetPlayerFromIdentifier(result[1].identifier)
            Player.removeAccountMoney('bank', amount)
            if Reciever ~= nil then
                Reciever.addAccountMoney('bank', amount)
            else
                local RecieverMoney = json.decode(result[1].accounts)
                RecieverMoney.bank = (RecieverMoney.bank + amount)
                MySQL.Async.execute('UPDATE players SET accounts = ? WHERE identifier = ?', {json.encode(RecieverMoney), result[1].identifier})
            end
            cb(true)
        else
            cb(false)
        end
    end
	
end)

ESX.RegisterServerCallback('qb-phone:server:GetCurrentLawyers', function(source, cb)
    local Lawyers = {}
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then
            if (Player.PlayerData.job.name == "lawyer" or Player.PlayerData.job.name == "realestate" or
                Player.PlayerData.job.name == "mechanic" or Player.PlayerData.job.name == "taxi" or
                Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "ambulance") and
                Player.PlayerData.job.onduty then
                Lawyers[#Lawyers+1] = {
                    name = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname,
                    phone = Player.PlayerData.charinfo.phone,
                    typejob = Player.PlayerData.job.name
                }
            end
        end
    end
    cb(Lawyers)
end)

ESX.RegisterServerCallback("qb-phone:server:GetWebhook",function(source,cb)
	if WebHook ~= "" then
		cb(WebHook)
	else
		print('Set your webhook to ensure that your camera will work!!!!!! Set this on line 10 of the server sided script!!!!!')
		cb(nil)
	end
end)

-- Events

RegisterNetEvent('qb-phone:server:AddAdvert', function(msg, url)
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    local CitizenId = Player.identifier
	local character = GetCharacter(src)
    if Adverts[CitizenId] ~= nil then
        Adverts[CitizenId].message = msg
        Adverts[CitizenId].name = "@" .. character.firstname .. "" .. character.lastname
        Adverts[CitizenId].number = character.phone
        Adverts[CitizenId].url = url
    else
        Adverts[CitizenId] = {
            message = msg,
            name = "@" .. character.firstname .. "" .. character.lastname,
            number = character.phone,
            url = url
        }
    end
    TriggerClientEvent('qb-phone:client:UpdateAdverts', -1, Adverts, "@" .. character.firstname .. "" .. character.lastname)
end)

RegisterNetEvent('qb-phone:server:DeleteAdvert', function()
    local Player = ESX.GetPlayerFromId(source)
    local citizenid = Player.identifier
    Adverts[citizenid] = nil
    TriggerClientEvent('qb-phone:client:UpdateAdvertsDel', -1, Adverts)
end)

RegisterNetEvent('qb-phone:server:SetCallState', function(bool)
    local src = source
    local Ply = ESX.GetPlayerFromId(src)
    if Calls[Ply.identifier] ~= nil then
        Calls[Ply.identifier].inCall = bool
    else
        Calls[Ply.identifier] = {}
        Calls[Ply.identifier].inCall = bool
    end
end)

RegisterNetEvent('qb-phone:server:RemoveMail', function(MailId)
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    MySQL.Async.execute('DELETE FROM player_mails WHERE mailid = ? AND citizenid = ?', {MailId, Player.identifier})
    SetTimeout(100, function()
        local mails = MySQL.Sync.fetchAll('SELECT * FROM player_mails WHERE citizenid = ? ORDER BY `date` ASC', {Player.identifier})
        if mails[1] ~= nil then
            for k, v in pairs(mails) do
                if mails[k].button ~= nil then
                    mails[k].button = json.decode(mails[k].button)
                end
            end
        end
        TriggerClientEvent('qb-phone:client:UpdateMails', src, mails)
    end)
end)

RegisterNetEvent('qb-phone:server:sendNewMail', function(mailData)
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    if mailData.button == nil then
        MySQL.Async.insert('INSERT INTO player_mails (`citizenid`, `sender`, `subject`, `message`, `mailid`, `read`) VALUES (?, ?, ?, ?, ?, ?)', {Player.identifier, mailData.sender, mailData.subject, mailData.message, GenerateMailId(), 0})
    else
        MySQL.Async.insert('INSERT INTO player_mails (`citizenid`, `sender`, `subject`, `message`, `mailid`, `read`, `button`) VALUES (?, ?, ?, ?, ?, ?, ?)', {Player.identifier, mailData.sender, mailData.subject, mailData.message, GenerateMailId(), 0, json.encode(mailData.button)})
    end
    TriggerClientEvent('qb-phone:client:NewMailNotify', src, mailData)
    SetTimeout(200, function()
        local mails = MySQL.Sync.fetchAll('SELECT * FROM player_mails WHERE citizenid = ? ORDER BY `date` DESC',
            {Player.identifier})
        if mails[1] ~= nil then
            for k, v in pairs(mails) do
                if mails[k].button ~= nil then
                    mails[k].button = json.decode(mails[k].button)
                end
            end
        end

        TriggerClientEvent('qb-phone:client:UpdateMails', src, mails)
    end)
end)

RegisterNetEvent('qb-phone:server:sendNewMailToOffline', function(citizenid, mailData)
    local Player = ESX.GetPlayerFromIdentifier(citizenid)
    if Player then
        local src = Player.PlayerData.source
        if mailData.button == nil then
            MySQL.Async.insert('INSERT INTO player_mails (`citizenid`, `sender`, `subject`, `message`, `mailid`, `read`) VALUES (?, ?, ?, ?, ?, ?)', {Player.identifier, mailData.sender, mailData.subject, mailData.message, GenerateMailId(), 0})
            TriggerClientEvent('qb-phone:client:NewMailNotify', src, mailData)
        else
            MySQL.Async.insert('INSERT INTO player_mails (`citizenid`, `sender`, `subject`, `message`, `mailid`, `read`, `button`) VALUES (?, ?, ?, ?, ?, ?, ?)', {Player.identifier, mailData.sender, mailData.subject, mailData.message, GenerateMailId(), 0, json.encode(mailData.button)})
            TriggerClientEvent('qb-phone:client:NewMailNotify', src, mailData)
        end
        SetTimeout(200, function()
            local mails = MySQL.Sync.fetchAll(
                'SELECT * FROM player_mails WHERE citizenid = ? ORDER BY `date` ASC', {Player.identifier})
            if mails[1] ~= nil then
                for k, v in pairs(mails) do
                    if mails[k].button ~= nil then
                        mails[k].button = json.decode(mails[k].button)
                    end
                end
            end

            TriggerClientEvent('qb-phone:client:UpdateMails', src, mails)
        end)
    else
        if mailData.button == nil then
            MySQL.Async.insert('INSERT INTO player_mails (`citizenid`, `sender`, `subject`, `message`, `mailid`, `read`) VALUES (?, ?, ?, ?, ?, ?)', {citizenid, mailData.sender, mailData.subject, mailData.message, GenerateMailId(), 0})
        else
            MySQL.Async.insert('INSERT INTO player_mails (`citizenid`, `sender`, `subject`, `message`, `mailid`, `read`, `button`) VALUES (?, ?, ?, ?, ?, ?, ?)', {citizenid, mailData.sender, mailData.subject, mailData.message, GenerateMailId(), 0, json.encode(mailData.button)})
        end
    end
end)

RegisterNetEvent('qb-phone:server:sendNewEventMail', function(citizenid, mailData)
    local Player = ESX.GetPlayerFromId(citizenid)
    if mailData.button == nil then
        MySQL.Async.insert('INSERT INTO player_mails (`citizenid`, `sender`, `subject`, `message`, `mailid`, `read`) VALUES (?, ?, ?, ?, ?, ?)', {citizenid, mailData.sender, mailData.subject, mailData.message, GenerateMailId(), 0})
    else
        MySQL.Async.insert('INSERT INTO player_mails (`citizenid`, `sender`, `subject`, `message`, `mailid`, `read`, `button`) VALUES (?, ?, ?, ?, ?, ?, ?)', {citizenid, mailData.sender, mailData.subject, mailData.message, GenerateMailId(), 0, json.encode(mailData.button)})
    end
    SetTimeout(200, function()
        local mails = MySQL.Sync.fetchAll('SELECT * FROM player_mails WHERE citizenid = ? ORDER BY `date` ASC', {citizenid})
        if mails[1] ~= nil then
            for k, v in pairs(mails) do
                if mails[k].button ~= nil then
                    mails[k].button = json.decode(mails[k].button)
                end
            end
        end
        TriggerClientEvent('qb-phone:client:UpdateMails', source, mails)
    end)
end)

RegisterNetEvent('qb-phone:server:ClearButtonData', function(mailId)
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    MySQL.Async.execute('UPDATE player_mails SET button = ? WHERE mailid = ? AND citizenid = ?', {'', mailId, Player.identifier})
    SetTimeout(200, function()
        local mails = MySQL.Sync.fetchAll('SELECT * FROM player_mails WHERE citizenid = ? ORDER BY `date` ASC', {Player.identifier})
        if mails[1] ~= nil then
            for k, v in pairs(mails) do
                if mails[k].button ~= nil then
                    mails[k].button = json.decode(mails[k].button)
                end
            end
        end
        TriggerClientEvent('qb-phone:client:UpdateMails', src, mails)
    end)
end)

RegisterNetEvent('qb-phone:server:MentionedPlayer', function(firstName, lastName, TweetMessage)
    for k, v in pairs(ESX.GetPlayers()) do
        local Player = ESX.GetPlayerFromId(v)
		local character = GetCharacter(v)
        if Player ~= nil then
            if (character.firstname == firstName and character.lastname == lastName) then
                QBPhone.SetPhoneAlerts(Player.identifier, "twitter")
                QBPhone.AddMentionedTweet(Player.identifier, TweetMessage)
                TriggerClientEvent('qb-phone:client:GetMentioned', Player.source, TweetMessage, AppAlerts[Player.identifier]["twitter"])
            else
                local query1 = '%' .. firstName .. '%'
                local query2 = '%' .. lastName .. '%'
                local result = MySQL.Sync.fetchAll('SELECT * FROM users WHERE firstname LIKE ? AND lastname LIKE ?', {query1, query2})
                if result[1] ~= nil then
                    local MentionedTarget = result[1].identifier
                    QBPhone.SetPhoneAlerts(MentionedTarget, "twitter")
                    QBPhone.AddMentionedTweet(MentionedTarget, TweetMessage)
                end
            end
        end
    end
end)

RegisterNetEvent('qb-phone:server:CallContact', function(TargetData, CallId, AnonymousCall)
    local src = source
    local Ply = ESX.GetPlayerFromId(src)
    local Target = GetPlayerFromPhone(TargetData.number)
	local character = GetCharacter(src)
    if Target ~= nil then
        TriggerClientEvent('qb-phone:client:GetCalled', Target.source, character.phone, CallId, AnonymousCall)
    end
end)

RegisterNetEvent('qb-phone:server:BillingEmail', function(data, paid)
    for k, v in pairs(ESX.GetPlayers()) do
        local target = ESX.GetPlayerFromId(v)
		local character = GetCharacter(source)
        if target.getJob().name == data.society then
            if paid then
                local name = '' .. character.firstname .. ' ' .. character.lastname .. ''
                TriggerClientEvent('qb-phone:client:BillingEmail', target.source, data, true, name)
            else
                local name = '' .. character.firstname .. ' ' .. character.lastname .. ''
                TriggerClientEvent('qb-phone:client:BillingEmail', target.source, data, false, name)
            end
        end
    end
end)

RegisterNetEvent('qb-phone:server:UpdateHashtags', function(Handle, messageData)
    if Hashtags[Handle] ~= nil and next(Hashtags[Handle]) ~= nil then
        Hashtags[Handle].messages[#Hashtags[Handle].messages+1] = messageData
    else
        Hashtags[Handle] = {
            hashtag = Handle,
            messages = {}
        }
        Hashtags[Handle].messages[#Hashtags[Handle].messages+1] = messageData
    end
    TriggerClientEvent('qb-phone:client:UpdateHashtags', -1, Handle, messageData)
end)

RegisterNetEvent('qb-phone:server:SetPhoneAlerts', function(app, alerts)
    local src = source
    local CitizenId = ESX.GetPlayerFromId(src).identifier
    QBPhone.SetPhoneAlerts(CitizenId, app, alerts)
end)

RegisterNetEvent('qb-phone:server:DeleteTweet', function(tweetId)
    local Player = ESX.GetPlayerFromId(source)
    local delete = false
    local TID = tweetId
    local Data = MySQL.Sync.fetchScalar('SELECT citizenid FROM phone_tweets WHERE tweetId = ?', {id})
    if Data == Player.identifier then
        local Data2 = MySQL.Sync.fetchAll('DELETE FROM phone_tweets WHERE tweetId = ?', {TID})
        delete = true
    end

    if delete then
        delete = not delete
        for k, v in pairs(TWData) do
            if TWData[k].tweetId == TID then
                TWData = nil
            end
        end
        TriggerClientEvent('qb-phone:client:UpdateTweets', -1, TWData)
    end
end)

RegisterNetEvent('qb-phone:server:UpdateTweets', function(NewTweets, TweetData)
    local src = source
    if Config.Linux then
        local InsertTweet = MySQL.Async.insert('INSERT INTO phone_tweets (citizenid, firstName, lastName, message, date, url, picture, tweetid) VALUES (?, ?, ?, ?, ?, ?, ?, ?)', {
            TweetData.citizenid,
            TweetData.firstName,
            TweetData.lastName,
            TweetData.message,
            TweetData.date,
            TweetData.url:gsub("[%<>\"()\' $]",""),
            TweetData.picture,
            TweetData.tweetId
        })
        TriggerClientEvent('qb-phone:client:UpdateTweets', -1, src, NewTweets, TweetData, false)
    else
        local InsertTweet = MySQL.Async.insert('INSERT INTO phone_tweets (citizenid, firstName, lastName, message, date, url, picture, tweetid) VALUES (?, ?, ?, ?, ?, ?, ?, ?)', {
            TweetData.citizenid,
            TweetData.firstName,
            TweetData.lastName,
            TweetData.message,
            TweetData.time,
            TweetData.url:gsub("[%<>\"()\' $]",""),
            TweetData.picture,
            TweetData.tweetId
        })
        TriggerClientEvent('qb-phone:client:UpdateTweets', -1, src, NewTweets, TweetData, false)
    end
end)

RegisterNetEvent('qb-phone:server:TransferMoney', function(iban, amount)
    local src = source
    local sender = ESX.GetPlayerFromId(src)

    local query = '%' .. iban .. '%'
    local result = MySQL.Sync.fetchAll('SELECT * FROM users WHERE iban LIKE ?', {query})
    if result[1] ~= nil then
        local reciever = ESX.GetPlayerFromIdentifier(result[1].identifier)

        if reciever ~= nil then
            --local PhoneItem = reciever.Functions.GetItemByName("phone")
			reciever.addAccountMoney('bank', amount)
            sender.removeAccountMoney('bank', amount)

            -- if PhoneItem ~= nil then
                -- TriggerClientEvent('qb-phone:client:TransferMoney', reciever.PlayerData.source, amount,
                    -- reciever.PlayerData.money.bank)
            -- end
        else
            local moneyInfo = json.decode(result[1].accounts)
            moneyInfo.bank = round((moneyInfo.bank + amount))
            MySQL.Async.execute('UPDATE users SET accounts = ? WHERE identifier = ?',
                {json.encode(moneyInfo), result[1].identifier})
            sender.removeAccountMoney('bank', amount)
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "This account number doesn't exist!", "error")
    end
end)

RegisterNetEvent('qb-phone:server:EditContact', function(newName, newNumber, newIban, oldName, oldNumber, oldIban)
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    MySQL.Async.execute(
        'UPDATE player_contacts SET name = ?, number = ?, iban = ? WHERE citizenid = ? AND name = ? AND number = ?',
        {newName, newNumber, newIban, Player.identifier, oldName, oldNumber})
end)

RegisterNetEvent('qb-phone:server:RemoveContact', function(Name, Number)
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    MySQL.Async.execute('DELETE FROM player_contacts WHERE name = ? AND number = ? AND citizenid = ?',
        {Name, Number, Player.identifier})
end)

RegisterNetEvent('qb-phone:server:AddNewContact', function(name, number, iban)
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    MySQL.Async.insert('INSERT INTO player_contacts (citizenid, name, number, iban) VALUES (?, ?, ?, ?)', {Player.identifier, tostring(name), tostring(number), tostring(iban)})
end)

RegisterNetEvent('qb-phone:server:UpdateMessages', function(ChatMessages, ChatNumber, New)
    local src = source
    local SenderData = ESX.GetPlayerFromId(src)
	local SenderCharacter = GetCharacter(src)
    local query = '%' .. ChatNumber .. '%'
    local Player = MySQL.Sync.fetchAll('SELECT * FROM users WHERE phone LIKE ?', {query})
    if Player[1] ~= nil then
        local TargetData = ESX.GetPlayerFromIdentifier(Player[1].identifier)
		local TargetCharacter = GetTargetCharacter(Player[1].identifier)
        if TargetData ~= nil then
            local Chat = MySQL.Sync.fetchAll('SELECT * FROM phone_messages WHERE citizenid = ? AND number = ?', {SenderData.identifier, ChatNumber})
            if Chat[1] ~= nil then
                -- Update for target
                MySQL.Async.execute('UPDATE phone_messages SET messages = ? WHERE citizenid = ? AND number = ?', {json.encode(ChatMessages), TargetData.identifier, SenderCharacter.phone})
                -- Update for sender
                MySQL.Async.execute('UPDATE phone_messages SET messages = ? WHERE citizenid = ? AND number = ?', {json.encode(ChatMessages), SenderData.identifier, TargetCharacter.phone})
                -- Send notification & Update messages for target
                TriggerClientEvent('qb-phone:client:UpdateMessages', TargetData.PlayerData.source, ChatMessages, SenderCharacter.phone, false)
            else
                -- Insert for target
                MySQL.Async.insert('INSERT INTO phone_messages (citizenid, number, messages) VALUES (?, ?, ?)', {TargetData.identifier, SenderCharacter.phone, json.encode(ChatMessages)})
                -- Insert for sender
                MySQL.Async.insert('INSERT INTO phone_messages (citizenid, number, messages) VALUES (?, ?, ?)', {SenderData.identifier, TargetCharacter.phone, json.encode(ChatMessages)})
                -- Send notification & Update messages for target
                TriggerClientEvent('qb-phone:client:UpdateMessages', TargetData.PlayerData.source, ChatMessages, SenderCharacter.phone, true)
            end
        else
            local Chat = MySQL.Sync.fetchAll('SELECT * FROM phone_messages WHERE citizenid = ? AND number = ?', {SenderData.identifier, ChatNumber})
            if Chat[1] ~= nil then
                -- Update for target
                MySQL.Async.execute('UPDATE phone_messages SET messages = ? WHERE citizenid = ? AND number = ?', {json.encode(ChatMessages), Player[1].citizenid, SenderCharacter.phone})
                -- Update for sender
                Player[1].charinfo = json.decode(Player[1].charinfo)
                MySQL.Async.execute('UPDATE phone_messages SET messages = ? WHERE citizenid = ? AND number = ?', {json.encode(ChatMessages), SenderData.identifier, Player[1].charinfo.phone})
            else
                -- Insert for target
                MySQL.Async.insert('INSERT INTO phone_messages (citizenid, number, messages) VALUES (?, ?, ?)', {Player[1].citizenid, SenderCharacter.phone, json.encode(ChatMessages)})
                -- Insert for sender
                Player[1].charinfo = json.decode(Player[1].charinfo)
                MySQL.Async.insert('INSERT INTO phone_messages (citizenid, number, messages) VALUES (?, ?, ?)', {SenderData.identifier, Player[1].charinfo.phone, json.encode(ChatMessages)})
            end
        end
    end
end)

RegisterNetEvent('qb-phone:server:AddRecentCall', function(type, data)
    local src = source
    local Ply = ESX.GetPlayerFromId(src)
	local character = GetCharacter(src)
    local Hour = os.date("%H")
    local Minute = os.date("%M")
    local label = Hour .. ":" .. Minute
    TriggerClientEvent('qb-phone:client:AddRecentCall', src, data, label, type)
    local Trgt = GetPlayerFromPhone(data.number)
    if Trgt ~= nil then
        TriggerClientEvent('qb-phone:client:AddRecentCall', Trgt.source, {
            name = character.firstname .. " " .. character.lastname,
            number = character.phone,
            anonymous = data.anonymous
        }, label, "outgoing")
    end
end)

RegisterNetEvent('qb-phone:server:CancelCall', function(ContactData)
    local Ply = GetPlayerFromPhone(ContactData.TargetData.number)
    if Ply ~= nil then
        TriggerClientEvent('qb-phone:client:CancelCall', Ply.source)
    end
end)

RegisterNetEvent('qb-phone:server:AnswerCall', function(CallData)
    local Ply = GetPlayerFromPhone(CallData.TargetData.number)
    if Ply ~= nil then
        TriggerClientEvent('qb-phone:client:AnswerCall', Ply.source)
    end
end)

RegisterNetEvent('qb-phone:server:SaveMetaData', function(column, data)
    local src = source
    local Player = ESX.GetPlayerFromId(src)

    if data and column then
        if type(data) == 'table' then
            MySQL.Async.execute("UPDATE `users` SET `" .. column .. "` = '".. json.encode(data) .."' WHERE `identifier` = '"..Player.identifier.."'")
        else
            MySQL.Async.execute("UPDATE `users` SET `" .. column .. "` = '".. data .."' WHERE `identifier` = '"..Player.identifier.."'")
        end
    end
end)


RegisterNetEvent('qb-phone:server:GiveContactDetails', function(PlayerId)
    local src = source
    local Player = ESX.GetPlayerFromId(src)
	local character = GetCharacter(src)
    local SuggestionData = {
        name = {
            [1] = character.firstname,
            [2] = character.lastname
        },
        number = character.phone,
        bank = getIBAN(Player.getIdentifier())
    }

    TriggerClientEvent('qb-phone:client:AddNewSuggestion', PlayerId, SuggestionData)
end)

RegisterNetEvent('qb-phone:server:AddTransaction', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    MySQL.Async.insert('INSERT INTO crypto_transactions (citizenid, title, message) VALUES (?, ?, ?)', {
        Player.PlayerData.citizenid,
        data.TransactionTitle,
        data.TransactionMessage
    })
end)

RegisterNetEvent('qb-phone:server:InstallApplication', function(ApplicationData)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.PlayerData.metadata["phonedata"].InstalledApps[ApplicationData.app] = ApplicationData
    Player.Functions.SetMetaData("phonedata", Player.PlayerData.metadata["phonedata"])

    -- TriggerClientEvent('qb-phone:RefreshPhone', src)
end)

RegisterNetEvent('qb-phone:server:RemoveInstallation', function(App)
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    Player.PlayerData.metadata["phonedata"].InstalledApps[App] = nil
    Player.Functions.SetMetaData("phonedata", Player.PlayerData.metadata["phonedata"])

    -- TriggerClientEvent('qb-phone:RefreshPhone', src)
end)

RegisterNetEvent('qb-phone:server:addImageToGallery', function(image)
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    MySQL.Async.insert('INSERT INTO phone_gallery (`citizenid`, `image`) VALUES (?, ?)',{Player.identifier,image})
end)

RegisterNetEvent('qb-phone:server:getImageFromGallery', function()
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    local images = MySQL.Sync.fetchAll('SELECT * FROM phone_gallery WHERE citizenid = ? ORDER BY `date` DESC',{Player.identifier})
    TriggerClientEvent('qb-phone:refreshImages', src, images)
end)

RegisterNetEvent('qb-phone:server:RemoveImageFromGallery', function(data)
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    local image = data.image
    MySQL.Async.execute('DELETE FROM phone_gallery WHERE citizenid = ? AND image = ?',{Player.identifier,image})
end)

RegisterNetEvent('qb-phone:server:sendPing', function(data)
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    print(src, data)
    if src ~= data then

    else
        TriggerClientEvent("QBCore:Notify", src, "You cannot ping yourself", "error")
    end
end)

ESX.RegisterServerCallback('qb-phone:server:GetBankData', function(source, cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local character = GetCharacter(src)

    cb({bank = xPlayer.getAccount('bank').money,money = xPlayer.getAccount('money').money, iban = character.iban})
end)

-- Command

-- QBCore.Commands.Add("setmetadata", "Set Player Metadata (God Only)", {}, false, function(source, args)
    -- local Player = QBCore.Functions.GetPlayer(source)
    -- if args[1] then
        -- if args[1] == "trucker" then
            -- if args[2] then
                -- local newrep = Player.PlayerData.metadata["jobrep"]
                -- newrep.trucker = tonumber(args[2])
                -- Player.Functions.SetMetaData("jobrep", newrep)
            -- end
        -- end
    -- end
-- end, "god")

-- QBCore.Commands.Add('bill', 'Bill A Player', {{name = 'id', help = 'Player ID'}, {name = 'amount', help = 'Fine Amount'}}, false, function(source, args)
    -- local biller = QBCore.Functions.GetPlayer(source)
    -- local billed = QBCore.Functions.GetPlayer(tonumber(args[1]))
    -- local amount = tonumber(args[2])
    -- if biller.PlayerData.job.name == "police" or biller.PlayerData.job.name == 'ambulance' or biller.PlayerData.job.name == 'mechanic' then
        -- if billed ~= nil then
            -- if biller.PlayerData.citizenid ~= billed.PlayerData.citizenid then
                -- if amount and amount > 0 then
                    -- MySQL.Async.insert(
                        -- 'INSERT INTO phone_invoices (citizenid, amount, society, sender, sendercitizenid) VALUES (?, ?, ?, ?, ?)',
                        -- {billed.PlayerData.citizenid, amount, biller.PlayerData.job.name,
                         -- biller.PlayerData.charinfo.firstname, biller.PlayerData.citizenid})
                    -- TriggerClientEvent('qb-phone:RefreshPhone', billed.PlayerData.source)
                    -- TriggerClientEvent('QBCore:Notify', source, 'Invoice Successfully Sent', 'success')
                    -- TriggerClientEvent('QBCore:Notify', billed.PlayerData.source, 'New Invoice Received')
                -- else
                    -- TriggerClientEvent('QBCore:Notify', source, 'Must Be A Valid Amount Above 0', 'error')
                -- end
            -- else
                -- TriggerClientEvent('QBCore:Notify', source, 'You Cannot Bill Yourself', 'error')
            -- end
        -- else
            -- TriggerClientEvent('QBCore:Notify', source, 'Player Not Online', 'error')
        -- end
    -- else
        -- TriggerClientEvent('QBCore:Notify', source, 'No Access', 'error')
    -- end
-- end)
