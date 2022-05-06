ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


AddEventHandler('esx:playerLoaded',function(playerId, xPlayer)
    local sourcePlayer = playerId
    local identifier = xPlayer.getIdentifier()

    getOrGeneratePhoneNumber(identifier, function(myPhoneNumber)
    end)

    getOrGenerateIBAN(identifier, function(iban)
    end)
end)


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

-- Code

local Phone = {}
local Tweets = {}
local AppAlerts = {}
local MentionedTweets = {}
local Hashtags = {}
local Calls = {}
local Adverts = {}
local GeneratedPlates = {}

RegisterServerEvent('pepe-phone:server:AddAdvert')
AddEventHandler('pepe-phone:server:AddAdvert', function(msg)
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    local CitizenId = Player.identifier
	local character = GetCharacter(src)

    if Adverts[CitizenId] ~= nil then
        Adverts[CitizenId].message = msg
        Adverts[CitizenId].name = "@"..character.firstname..""..character.firstname
        Adverts[CitizenId].number = character.phone
    else
        Adverts[CitizenId] = {
            message = msg,
            name = "@"..character.firstname..""..character.lastname,
            number = character.phone,
        }
    end

    TriggerClientEvent('pepe-phone:client:UpdateAdverts', -1, Adverts, "@"..character.firstname..""..character.lastname)
end)

function GetOnlineStatus(number)
    local Target = GetPlayerFromPhone(number)
    local retval = false
    if Target ~= nil then retval = true end
    return retval
end

ESX.RegisterServerCallback('pepe-phone:server:GetCharacterData', function(source, cb,id)
    local src = source or id
    local xPlayer = ESX.GetPlayerFromId(source)
    
    cb(GetCharacter(src))
end)

ESX.RegisterServerCallback('pepe-phone:server:GetPhoneData', function(source, cb)
    local src = source
    local Player = ESX.GetPlayerFromId(src)
	local character = GetCharacter(src)
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
            Cars = {},
            Adverts = {},
            CryptoTransactions = {},
            Tweets = {}
        }

        PhoneData.Adverts = Adverts
		PhoneData.charinfo = GetCharacter(src)
		
		ExecuteSql(false, "SELECT * FROM twitter_tweets", function(result)
			if result[1] ~= nil then
				PhoneData.Tweets = result
			else
				PhoneData.Tweets = nil
			end
		end)	
        ExecuteSql(false, "SELECT * FROM player_contacts WHERE `identifier` = '"..Player.identifier.."' ORDER BY `name` ASC", function(result)
            local Contacts = {}
            if result[1] ~= nil then
                for k, v in pairs(result) do
                    v.status = GetOnlineStatus(v.number)
                end
                
                PhoneData.PlayerContacts = result
            end

            -- ExecuteSql(false, "SELECT * FROM billing WHERE `receiver_identifier` = '"..Player.identifier.."'", function(invoices)
                -- if invoices[1] ~= nil then
                    -- for k, v in pairs(invoices) do
                        -- local Ply = ESX.GetPlayerFromIdentifier(v.sender)
                        -- if Ply ~= nil then
                            -- v.number = GetCharacter(Ply.source).phone
                        -- else
                            -- ExecuteSql(true, "SELECT * FROM `users` WHERE `identifier` = '"..v.sender.."'", function(res)
                                -- if res[1] ~= nil then
                                    -- res[1].charinfo = json.decode(res[1].charinfo)
                                    -- v.number = res[1].charinfo.phone
                                -- else
                                    -- v.number = nil
                                -- end
                            -- end)
                        -- end
                    -- end
                    -- PhoneData.Invoices = invoices
                -- end

                ExecuteSql(false, "SELECT * FROM owned_vehicles WHERE forSale = '1'", function(cars)
                    if cars ~= nil then
                        local CarsData = {}
                        for k,v in pairs(cars) do
                            cars = {
                                citizenid = v.owner,
                                vehicle = v.model,
                                plate = v.plate,
                                salePrice = v.salePrice,
                            }
                            table.insert(CarsData, cars)
                        end
                        PhoneData.Cars = CarsData
                    end

                    ExecuteSql(false, "SELECT * FROM owned_vehicles WHERE `owner` = '"..Player.identifier.."'", function(garageresult)
                        if garageresult[1] ~= nil then
                            PhoneData.Garage = garageresult
                        end
                    
                            ExecuteSql(false, "SELECT * FROM phone_messages WHERE `identifier` = '"..Player.identifier.."'", function(messages)
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

                                if Tweets ~= nil and next(Tweets) ~= nil then
                                    PhoneData.Tweets = Tweets
                                end

                                ExecuteSql(false, 'SELECT * FROM `player_mails` WHERE `identifier` = "'..Player.identifier..'" ORDER BY `date` ASC', function(mails)
                                    if mails[1] ~= nil then
                                        for k, v in pairs(mails) do
                                            if mails[k].button ~= nil then
                                                mails[k].button = json.decode(mails[k].button)
                                            end
                                        end
                                        PhoneData.Mails = mails
                                    end

                                cb(PhoneData)
                            end)
                        end)
                    end)
                end)
			--end)
        end)
    end
end)

ESX.RegisterServerCallback('pepe-phone:server:GetCallState', function(source, cb, ContactData)
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

RegisterServerEvent('pepe-phone:server:SetCallState')
AddEventHandler('pepe-phone:server:SetCallState', function(bool)
    local src = source
    local Ply = ESX.GetPlayerFromId(src)

    if Calls[Ply.identifier] ~= nil then
        Calls[Ply.identifier].inCall = bool
    else
        Calls[Ply.identifier] = {}
        Calls[Ply.identifier].inCall = bool
    end
end)

RegisterServerEvent('pepe-phone:server:RemoveMail')
AddEventHandler('pepe-phone:server:RemoveMail', function(MailId)
    local src = source
    local Player = ESX.GetPlayerFromId(src)

    ExecuteSql(false, 'DELETE FROM `player_mails` WHERE `mailid` = "'..MailId..'" AND `identifier` = "'..Player.identifier..'"')
    SetTimeout(100, function()
        ExecuteSql(false, 'SELECT * FROM `player_mails` WHERE `identifier` = "'..Player.identifier..'" ORDER BY `date` ASC', function(mails)
            if mails[1] ~= nil then
                for k, v in pairs(mails) do
                    if mails[k].button ~= nil then
                        mails[k].button = json.decode(mails[k].button)
                    end
                end
            end
    
            TriggerClientEvent('pepe-phone:client:UpdateMails', src, mails)
        end)
    end)
end)

function GenerateMailId()
    return math.random(111111, 999999)
end

RegisterServerEvent('pepe-phone:server:sendNewMail')
AddEventHandler('pepe-phone:server:sendNewMail', function(mailData)
    local src = source
    local Player = ESX.GetPlayerFromId(src)

    if mailData.button == nil then
        ExecuteSql(false, "INSERT INTO `player_mails` (`identifier`, `sender`, `subject`, `message`, `mailid`, `read`) VALUES ('"..Player.identifier.."', '"..mailData.sender.."', '"..mailData.subject.."', '"..mailData.message.."', '"..GenerateMailId().."', '0')")
    else
        ExecuteSql(false, "INSERT INTO `player_mails` (`identifier`, `sender`, `subject`, `message`, `mailid`, `read`, `button`) VALUES ('"..Player.identifier.."', '"..mailData.sender.."', '"..mailData.subject.."', '"..mailData.message.."', '"..GenerateMailId().."', '0', '"..json.encode(mailData.button).."')")
    end
    TriggerClientEvent('pepe-phone:client:NewMailNotify', src, mailData)
    SetTimeout(200, function()
        ExecuteSql(false, 'SELECT * FROM `player_mails` WHERE `identifier` = "'..Player.identifier..'" ORDER BY `date` DESC', function(mails)
            if mails[1] ~= nil then
                for k, v in pairs(mails) do
                    if mails[k].button ~= nil then
                        mails[k].button = json.decode(mails[k].button)
                    end
                end
            end
    
            TriggerClientEvent('pepe-phone:client:UpdateMails', src, mails)
        end)
    end)
end)

RegisterServerEvent('pepe-phone:server:sendNewMailToOffline')
AddEventHandler('pepe-phone:server:sendNewMailToOffline', function(steam, mailData)
    local Player = ESX.GetPlayerFromIdentifier(steam)

    if Player ~= nil then
        local src = Player.source

        if mailData.button == nil then
            ExecuteSql(false, "INSERT INTO `player_mails` (`identifier`, `sender`, `subject`, `message`, `mailid`, `read`) VALUES ('"..Player.identifier.."', '"..mailData.sender.."', '"..mailData.subject.."', '"..mailData.message.."', '"..GenerateMailId().."', '0')")
            TriggerClientEvent('pepe-phone:client:NewMailNotify', src, mailData)
        else
            ExecuteSql(false, "INSERT INTO `player_mails` (`identifier`, `sender`, `subject`, `message`, `mailid`, `read`, `button`) VALUES ('"..Player.identifier.."', '"..mailData.sender.."', '"..mailData.subject.."', '"..mailData.message.."', '"..GenerateMailId().."', '0', '"..json.encode(mailData.button).."')")
            TriggerClientEvent('pepe-phone:client:NewMailNotify', src, mailData)
        end

        SetTimeout(200, function()
            ExecuteSql(false, 'SELECT * FROM `player_mails` WHERE `identifier` = "'..Player.identifier..'" ORDER BY `date` DESC', function(mails)
                if mails[1] ~= nil then
                    for k, v in pairs(mails) do
                        if mails[k].button ~= nil then
                            mails[k].button = json.decode(mails[k].button)
                        end
                    end
                end
        
                TriggerClientEvent('pepe-phone:client:UpdateMails', src, mails)
            end)
        end)
    else
        if mailData.button == nil then
            ExecuteSql(false, "INSERT INTO `player_mails` (`identifier`, `sender`, `subject`, `message`, `mailid`, `read`) VALUES ('"..steam.."', '"..mailData.sender.."', '"..mailData.subject.."', '"..mailData.message.."', '"..GenerateMailId().."', '0')")
        else
            ExecuteSql(false, "INSERT INTO `player_mails` (`identifier`, `sender`, `subject`, `message`, `mailid`, `read`, `button`) VALUES ('"..steam.."', '"..mailData.sender.."', '"..mailData.subject.."', '"..mailData.message.."', '"..GenerateMailId().."', '0', '"..json.encode(mailData.button).."')")
        end
    end
end)

RegisterServerEvent('pepe-phone:server:sendNewEventMail')
AddEventHandler('pepe-phone:server:sendNewEventMail', function(steam, mailData)
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    local MailedPlayer = ESX.GetPlayerFromIdentifier(steam)
    if mailData.button == nil then
        ExecuteSql(false, "INSERT INTO `player_mails` (`identifier`, `sender`, `subject`, `message`, `mailid`, `read`) VALUES ('"..steam.."', '"..mailData.sender.."', '"..mailData.subject.."', '"..mailData.message.."', '"..GenerateMailId().."', '0')")
    else
        ExecuteSql(false, "INSERT INTO `player_mails` (`identifier`, `sender`, `subject`, `message`, `mailid`, `read`, `button`) VALUES ('"..steam.."', '"..mailData.sender.."', '"..mailData.subject.."', '"..mailData.message.."', '"..GenerateMailId().."', '0', '"..json.encode(mailData.button).."')")
    end
    if MailedPlayer ~= nil then
    SetTimeout(200, function()
        ExecuteSql(false, 'SELECT * FROM `player_mails` WHERE `identifier` = "'..Player.identifier..'" ORDER BY `date` DESC', function(mails)
            if mails[1] ~= nil then
                for k, v in pairs(mails) do
                    if mails[k].button ~= nil then
                        mails[k].button = json.decode(mails[k].button)
                    end
                end
            end
    
            TriggerClientEvent('pepe-phone:client:UpdateMails', src, mails)
        end)
    end)
    end
end)

RegisterServerEvent('pepe-phone:server:sellVehicle')
AddEventHandler('pepe-phone:server:sellVehicle', function(plate, price)
    local Player = ESX.GetPlayerFromId(source)
	
    ExecuteSql(false, "UPDATE owned_vehicles SET `forSale` = '1', `salePrice` = '" .. price .. "' WHERE  `plate` = '" .. plate .. "' AND `owner` = '" .. Player.identifier .. "'")
	TriggerClientEvent("ESX:Notify",source,"Đã đăng bán thành công","success")
	
	local MailData = {
		sender = "autoscout",
		subject = "Your advertisement",
		message = "Xe với biến số "..plate.." đã được đăng bán trên chợ",
		button = {}
	 }
                 TriggerEvent("pepe-phone:server:sendNewEventMail", source, MailData)
end)

RegisterServerEvent('pepe-phone:server:buy:chosen:vehicle')
AddEventHandler('pepe-phone:server:buy:chosen:vehicle', function(VehiclePlate, CitizenId, SellPrice)
    local src = source
    local GarageData = 'impound'
    local Player = ESX.GetPlayerFromId(src)
    if Player.getAccount('bank').money >= SellPrice then
        local TargetPlayer = ESX.GetPlayerFromIdentifier(CitizenId)
        if TargetPlayer ~= nil then
           TargetPlayer.addAccountMoney('bank', SellPrice)
           Player.removeAccountMoney('bank', SellPrice)	
           ExecuteSql(false, "UPDATE owned_vehicles SET `owner` = '" .. Player.identifier .. "', `state` = '"..GarageData.."', `state` = '"..GarageData.."', `forSale` = '0', `salePrice` = '0' WHERE `plate` = '" ..VehiclePlate.. "'")
           TriggerClientEvent('pepe-phone:client:send:email:bought:vehicle', src, VehiclePlate) 
           TriggerClientEvent('pepe-phone:client:send:email:sold:vehicle', TargetPlayer.source, SellPrice, VehiclePlate) 
           --TriggerClientEvent('ESX:Notify', src, "Vehicle with number plate '" .. VehiclePlate .. "' bought for $'" .. SellPrice .. "'", "success")
        else
            ExecuteSql(false, 'SELECT `accounts` FROM users WHERE identifier ="'..CitizenId..'"',function(result)
                if result ~= nil then
                 local NewMoneyTable = {}
                 local NewBankBalance = nil
				 
				 TriggerClientEvent("table",result[1])
                 local MoneyTable = result[1]
				 
                 for k,v in pairs(MoneyTable) do 
                     if k == 'bank' then
                        NewBankBalance = v + SellPrice
                     end
                  NewMoneyTable = {['bank'] = NewBankBalance, ['money'] = MoneyTable['money'], ['black_money'] = MoneyTable['black_money']}          
                 end
                 local MailData = {
                    sender = "autoscout",
                    subject = "Your advertisement",
                    message = "Dear reader,<br/><br/>You will receive an email of your recent ad.<br><br>License Plate: <strong>" ..VehiclePlate.. "</strong> <br>Selling price: <strong>$"..SellPrice.. '</strong><br><br>Your vehicle has been sold successfully and the amount has been credited to your bank.<br><br>Kind regards,<br>autoscout',
                    button = {}
                 }
                 TriggerEvent("pepe-phone:server:sendNewEventMail", CitizenId, MailData)
                 Player.removeAccountMoney('bank', SellPrice)
                 ExecuteSql(false, "UPDATE owned_vehicles SET `owner` = '" .. Player.identifier .. "', `state` = '"..GarageData.."', `forSale` = '0', `salePrice` = '0' WHERE `plate` = '" ..VehiclePlate.. "'")
				ExecuteSql(false, "UPDATE users SET `accounts` = '" ..json.encode(NewMoneyTable).. "' WHERE `identifier` = '" ..CitizenId.. "'")
                 TriggerClientEvent('pepe-phone:client:send:email:bought:vehicle', src, VehiclePlate)
                 --TriggerClientEvent('ESX:Notify', src, "Vehicle with number plate '" .. VehiclePlate .. "' bought for $'" .. SellPrice .. "'", "success")
                end
            end)
        end
    else
        --TriggerClientEvent('ESX:Notify', src, "You don't have enough money on your bank account...", "error")
    end
end)



ESX.RegisterServerCallback('pepe-phone:server:load:autoscout', function(source, cb)
 ExecuteSql(false, "SELECT * FROM owned_vehicles WHERE forSale = '1'", function(cars)
     if cars ~= nil then
         local CarsData = {}
         for k,v in pairs(cars) do
             cars = {
                 citizenid = v.owner,
                 vehicle = v.model,
                 plate = v.plate,
                 salePrice = v.salePrice,
             }
             table.insert(CarsData, cars)
         end
          cb(CarsData)
     end
    end)
end)

RegisterServerEvent('pepe-phone:server:ClearButtonData')
AddEventHandler('pepe-phone:server:ClearButtonData', function(mailId)
    local src = source
    local Player = ESX.GetPlayerFromId(src)

    ExecuteSql(false, 'UPDATE `player_mails` SET `button` = "" WHERE `mailid` = "'..mailId..'" AND `identifier` = "'..Player.identifier..'"')
    SetTimeout(200, function()
        ExecuteSql(false, 'SELECT * FROM `player_mails` WHERE `identifier` = "'..Player.identifier..'" ORDER BY `date` DESC', function(mails)
            if mails[1] ~= nil then
                for k, v in pairs(mails) do
                    if mails[k].button ~= nil then
                        mails[k].button = json.decode(mails[k].button)
                    end
                end
            end
    
            TriggerClientEvent('pepe-phone:client:UpdateMails', src, mails)
        end)
    end)
end)

RegisterServerEvent('pepe-phone:server:MentionedPlayer')
AddEventHandler('pepe-phone:server:MentionedPlayer', function(firstName, lastName, TweetMessage)
    for k, v in pairs(ESX.GetPlayers()) do
        local Player = ESX.GetPlayerFromId(v)
		local character = GetCharacter(v)
        if Player ~= nil then
            if (character.firstname == firstName and character.lastname == lastName) then
                Phone.SetPhoneAlerts(Player.identifier, "twitter")
                Phone.AddMentionedTweet(Player.identifier, TweetMessage)
                TriggerClientEvent('pepe-phone:client:GetMentioned', Player.source, TweetMessage, AppAlerts[Player.identifier]["twitter"])
            else
                ExecuteSql(false, "SELECT * FROM `users` WHERE `firstname`='"..firstName.."' AND `lastname`='"..lastName.."'", function(result)
                    if result[1] ~= nil then
                        local MentionedTarget = result[1].identifier
                        Phone.SetPhoneAlerts(MentionedTarget, "twitter")
                        Phone.AddMentionedTweet(MentionedTarget, TweetMessage)
                    end
                end)
            end
        end
	end
end)

RegisterServerEvent('pepe-phone:server:CallContact')
AddEventHandler('pepe-phone:server:CallContact', function(TargetData, CallId, AnonymousCall)
    local src = source
    local Ply = ESX.GetPlayerFromId(src)
    local Target = GetPlayerFromPhone(TargetData.number)
    local character = GetCharacter(src)
    
    if Target ~= nil then
        TriggerClientEvent('pepe-phone:client:GetCalled', Target.source, character.phone, CallId, AnonymousCall)
    end
end)

ESX.RegisterServerCallback('pepe-phone:server:PayInvoice', function(source, cb, sender, amount, invoiceId)
    local src = source
    local Ply = ESX.GetPlayerFromId(src)
        if Ply.PlayerData.money.bank >= amount then
            Ply.Functions.RemoveMoney('bank', amount, "paid-invoice")
            ExecuteSql(true, "DELETE FROM `characters_bills` WHERE `invoiceid` = '"..invoiceId.."'")
            cb(true)
        else
            cb(false)
        end
end)

ESX.RegisterServerCallback('pepe-phone:server:DeclineInvoice', function(source, cb, sender, amount, invoiceId)
    local src = source
    local Ply = ESX.GetPlayerFromId(src)
    local Trgt = ESX.GetPlayerFromIdentifier(sender)
    local Invoices = {}

    ExecuteSql(true, "DELETE FROM `characters_bills` WHERE `invoiceid` = '"..invoiceId.."'")
    ExecuteSql(false, "SELECT * FROM `characters_bills` WHERE `citizenid` = '"..Ply.PlayerData.citizenid.."'", function(invoices)
        if invoices[1] ~= nil then
            for k, v in pairs(invoices) do
                local Target = ESX.GetPlayerFromIdentifier(v.sender)
                if Target ~= nil then
                    v.number = Target.PlayerData.charinfo.phone
                else
                    ExecuteSql(true, "SELECT * FROM `players` WHERE `citizenid` = '"..v.sender.."'", function(res)
                        if res[1] ~= nil then
                            res[1].charinfo = json.decode(res[1].charinfo)
                            v.number = res[1].charinfo.phone
                        else
                            v.number = nil
                        end
                    end)
                end
            end
            Invoices = invoices
        end
        cb(true, invoices)
    end)
end)

RegisterServerEvent('pepe-phone:server:UpdateHashtags')
AddEventHandler('pepe-phone:server:UpdateHashtags', function(Handle, messageData)
    if Hashtags[Handle] ~= nil and next(Hashtags[Handle]) ~= nil then
        table.insert(Hashtags[Handle].messages, messageData)
    else
        Hashtags[Handle] = {
            hashtag = Handle,
            messages = {}
        }
        table.insert(Hashtags[Handle].messages, messageData)
    end
    TriggerClientEvent('pepe-phone:client:UpdateHashtags', -1, Handle, messageData)
end)

Phone.AddMentionedTweet = function(identifier, TweetData)
    if MentionedTweets[identifier] == nil then MentionedTweets[identifier] = {} end
    table.insert(MentionedTweets[identifier], TweetData)
end

Phone.SetPhoneAlerts = function(identifier, app, alerts)
    if identifier ~= nil and app ~= nil then
        if AppAlerts[identifier] == nil then
            AppAlerts[identifier] = {}
            if AppAlerts[identifier][app] == nil then
                if alerts == nil then
                    AppAlerts[identifier][app] = 1
                else
                    AppAlerts[identifier][app] = alerts
                end
            end
        else
            if AppAlerts[identifier][app] == nil then
                if alerts == nil then
                    AppAlerts[identifier][app] = 1
                else
                    AppAlerts[identifier][app] = 0
                end
            else
                if alerts == nil then
                    AppAlerts[identifier][app] = AppAlerts[identifier][app] + 1
                else
                    AppAlerts[identifier][app] = AppAlerts[identifier][app] + 0
                end
            end
        end
    end
end

ESX.RegisterServerCallback('pepe-phone:server:GetContactPictures', function(source, cb, Chats)
    for k, v in pairs(Chats) do
        local Player = ESX.GetPlayerFromIdentifier(v.number)
        
        ExecuteSql(false, "SELECT * FROM `users` WHERE `phone`='"..v.number.."'", function(result)
            if result[1] ~= nil then
                if result[1].profilepicture ~= nil then
                    v.picture = result[1].profilepicture
                else
                    v.picture = "default"
                end
            end
        end)
    end
    SetTimeout(100, function()
        cb(Chats)
    end)
end)

ESX.RegisterServerCallback('pepe-phone:server:GetContactPicture', function(source, cb, Chat)
    ExecuteSql(false, "SELECT * FROM `users` WHERE `phone`='" .. Chat.number .. "'", function(result)
        if result[1] and result[1].background then
            Chat.picture = result[1].background
        else
            Chat.picture = "default"
        end
    end)
    SetTimeout(100, function()
        cb(Chat)
    end)
end)

ESX.RegisterServerCallback('pepe-phone:server:GetPicture', function(source, cb, number)
    local Player = GetPlayerFromPhone(number)
    local Picture = nil

    ExecuteSql(false, "SELECT * FROM `users` WHERE `phone`='"..number.."'", function(result)
        if result[1] ~= nil then
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
end)

RegisterServerEvent('pepe-phone:server:SetPhoneAlerts')
AddEventHandler('pepe-phone:server:SetPhoneAlerts', function(app, alerts)
    local src = source
    local Identifier = ESX.GetPlayerFromId(src).identifier
    Phone.SetPhoneAlerts(Identifier, app, alerts)
end)

RegisterServerEvent('pepe-phone:server:UpdateTweets')
AddEventHandler('pepe-phone:server:UpdateTweets', function(NewTweets, TweetData, Type)
    Tweets = NewTweets
    local TwtData = TweetData
    local src = source
    TriggerClientEvent('pepe-phone:client:UpdateTweets', -1, src, Tweets, TwtData, Type)
end)

RegisterServerEvent('pepe-phone:server:TransferMoney')
AddEventHandler('pepe-phone:server:TransferMoney', function(iban, amount)
    local src = source
    local sender = ESX.GetPlayerFromId(src)

    ExecuteSql(false, "SELECT * FROM `users` WHERE `iban`='"..iban.."'", function(result)
        if result[1] ~= nil then
            local recieverSteam = ESX.GetPlayerFromIdentifier(result[1].identifier)

            if recieverSteam ~= nil then
                --local PhoneItem = recieverSteam.Functions.GetItemByName("phone")
                recieverSteam.addAccountMoney('bank', amount)
                sender.removeAccountMoney('bank', amount)
				local infobank = recieverSteam.getAccount('bank').money

                if true then
                    TriggerClientEvent('pepe-phone:client:TransferMoney', recieverSteam.source, amount, infobank)
					local text = 'Bạn vừa nhận được: $' .. amount .. ', IBAN người gửi: ' .. result[1].iban ..''
					TriggerClientEvent("pepe-phone:client:BankNotify",text)
					TriggerClientEvent("ESX:Notify",sender.source,"Chuyển tiền thành công","success")
					--TriggerClientEvent("ESX:Notify",recieverSteam.source,text,"info")
                end
            else
                ExecuteSql(false, "UPDATE `users` SET `bank` = '"..result[1].bank + amount.."' WHERE `identifier` = '"..result[1].identifier.."'")
                sender.removeAccountMoney('bank', amount)
            end
        else
            TriggerClientEvent('ESX:Notify', src, "This account number does not exist!", "error")
        end
    end)
end)

RegisterServerEvent('pepe-phone:server:EditContact')
AddEventHandler('pepe-phone:server:EditContact', function(newName, newNumber, newIban, oldName, oldNumber, oldIban)
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    ExecuteSql(false, "UPDATE `player_contacts` SET `name` = '"..newName.."', `number` = '"..newNumber.."', `iban` = '"..newIban.."' WHERE `identifier` = '"..Player.identifier.."' AND `name` = '"..oldName.."' AND `number` = '"..oldNumber.."'")
end)

RegisterServerEvent('pepe-phone:server:RemoveContact')
AddEventHandler('pepe-phone:server:RemoveContact', function(Name, Number)
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    
    ExecuteSql(false, "DELETE FROM `player_contacts` WHERE `name` = '"..Name.."' AND `number` = '"..Number.."' AND `identifier` = '"..Player.identifier.."'")
end)

RegisterServerEvent('pepe-phone:server:AddNewContact')
AddEventHandler('pepe-phone:server:AddNewContact', function(name, number, iban)
    local src = source
    local Player = ESX.GetPlayerFromId(src)

    ExecuteSql(false, "INSERT INTO `player_contacts` (`identifier`, `name`, `number`, `iban`) VALUES ('"..Player.identifier.."', '"..tostring(name).."', '"..tostring(number).."', '"..tostring(iban).."')")
end)

RegisterServerEvent('pepe-phone:server:UpdateMessages')
AddEventHandler('pepe-phone:server:UpdateMessages', function(ChatMessages, ChatNumber, New)
    local src = source
    local SenderData = ESX.GetPlayerFromId(src)
	local SenderCharacter = GetCharacter(src)

    ExecuteSql(false, "SELECT * FROM `users` WHERE `phone`='"..ChatNumber.."'", function(Player)
        if Player[1] ~= nil then
            local TargetData = ESX.GetPlayerFromIdentifier(Player[1].identifier)

            if TargetData ~= nil then
                ExecuteSql(false, "SELECT * FROM `phone_messages` WHERE `identifier` = '"..SenderData.identifier.."' AND `number` = '"..ChatNumber.."'", function(Chat)
                    if Chat[1] ~= nil then
                        -- Update for target
                        ExecuteSql(false, "UPDATE `phone_messages` SET `messages` = '"..json.encode(ChatMessages).."' WHERE `identifier` = '"..TargetData.identifier.."' AND `number` = '"..SenderCharacter.phone.."'")
                                
                        -- Update for sender
                        ExecuteSql(false, "UPDATE `phone_messages` SET `messages` = '"..json.encode(ChatMessages).."' WHERE `identifier` = '"..SenderData.identifier.."' AND `number` = '"..SenderCharacter.phone.."'")
                    
                        -- Send notification & Update messages for target
                        TriggerClientEvent('pepe-phone:client:UpdateMessages', TargetData.source, ChatMessages, SenderCharacter.phone, false)
                    else
                        -- Insert for target
                        ExecuteSql(false, "INSERT INTO `phone_messages` (`identifier`, `number`, `messages`) VALUES ('"..TargetData.identifier.."', '"..SenderCharacter.phone.."', '"..json.encode(ChatMessages).."')")
                                            
                        -- Insert for sender
                        ExecuteSql(false, "INSERT INTO `phone_messages` (`identifier`, `number`, `messages`) VALUES ('"..SenderData.identifier.."', '"..SenderCharacter.phone.."', '"..json.encode(ChatMessages).."')")

                        -- Send notification & Update messages for target
                        TriggerClientEvent('pepe-phone:client:UpdateMessages', TargetData.source, ChatMessages, SenderCharacter.phone, true)
                    end
                end)
            else
                ExecuteSql(false, "SELECT * FROM `phone_messages` WHERE `identifier` = '"..SenderData.identifier.."' AND `number` = '"..ChatNumber.."'", function(Chat)
                    if Chat[1] ~= nil then
                        -- Update for target
                        ExecuteSql(false, "UPDATE `phone_messages` SET `messages` = '"..json.encode(ChatMessages).."' WHERE `identifier` = '"..Player[1].identifier.."' AND `number` = '"..SenderCharacter.phone.."'")
                                
                        -- Update for sender
                        ExecuteSql(false, "UPDATE `phone_messages` SET `messages` = '"..json.encode(ChatMessages).."' WHERE `identifier` = '"..SenderData.identifier.."' AND `number` = '"..Player[1].phone.."'")
                    else
                        -- Insert for target
                        ExecuteSql(false, "INSERT INTO `phone_messages` (`identifier`, `number`, `messages`) VALUES ('"..Player[1].identifier.."', '"..SenderCharacter.phone.."', '"..json.encode(ChatMessages).."')")
                        
                        -- Insert for sender
                        ExecuteSql(false, "INSERT INTO `phone_messages` (`identifier`, `number`, `messages`) VALUES ('"..SenderData.identifier.."', '"..Player[1].phone.."', '"..json.encode(ChatMessages).."')")
                    end
                end)
            end
        end
    end)
end)

RegisterServerEvent('pepe-phone:server:AddRecentCall')
AddEventHandler('pepe-phone:server:AddRecentCall', function(type, data)
    local src = source
    local Ply = ESX.GetPlayerFromId(src)
	local character = GetCharacter(src)

    local Hour = os.date("%H")
    local Minute = os.date("%M")
    local label = Hour..":"..Minute

    TriggerClientEvent('pepe-phone:client:AddRecentCall', src, data, label, type)

    local Trgt = GetPlayerFromPhone(data.number)
    if Trgt ~= nil then
        TriggerClientEvent('pepe-phone:client:AddRecentCall', Trgt.source, {
            name = character.firstname .. " " ..character.lastname,
            number = character.phone,
            anonymous = anonymous
        }, label, "outgoing")
    end
end)

RegisterServerEvent('pepe-phone:server:CancelCall')
AddEventHandler('pepe-phone:server:CancelCall', function(ContactData)
    local Ply = GetPlayerFromPhone(ContactData.TargetData.number)

    if Ply ~= nil then
        TriggerClientEvent('pepe-phone:client:CancelCall', Ply.source)
    end
end)

RegisterServerEvent('pepe-phone:server:AnswerCall')
AddEventHandler('pepe-phone:server:AnswerCall', function(CallData)
    local Ply = GetPlayerFromPhone(CallData.TargetData.number)

    if Ply ~= nil then
        TriggerClientEvent('pepe-phone:client:AnswerCall', Ply.source)
    end
end)

RegisterServerEvent('pepe-phone:server:SaveMetaData')
AddEventHandler('pepe-phone:server:SaveMetaData', function(column,data)
    local src = source
    local Player = ESX.GetPlayerFromId(src)

    if data and column then
        if type(data) == 'table' then
            ExecuteSql(false, "UPDATE `users` SET `" .. column .. "` = '".. json.encode(data) .."' WHERE `identifier` = '"..Player.identifier.."'")
        else
            ExecuteSql(false, "UPDATE `users` SET `" .. column .. "` = '".. data .."' WHERE `identifier` = '"..Player.identifier.."'")
        end
    end
end)

function escape_sqli(source)
    local replacements = { ['"'] = '\\"', ["'"] = "\\'" }
    return source:gsub( "['\"]", replacements )
end

ESX.RegisterServerCallback('pepe-phone:server:FetchResult', function(source, cb, search)
    local src = source
    local search = escape_sqli(search)
    local searchData = {}
    local ApaData = {}
    local character = GetCharacter(src)
    
    ExecuteSql(false, "SELECT * FROM `users` WHERE firstname LIKE '%"..search.."%'", function(result)
        if result[1] ~= nil then
            for k, v in pairs(result) do
                local driverlicense = false
                local weaponlicense = false
                local doingSomething = true
                table.insert(searchData, {
                    identifier = v.identifier,
                    firstname = character.firstname,
                    lastname = character.lastname,
                    birthdate = character.dateofbirth,
                    phone = character.phone,
                    gender = character.sex,
                    weaponlicense = weaponlicense,
                    driverlicense = driverlicense,
					job = character.job,
                })
              
            end
            cb(searchData)
        else
            cb(nil)
        end
    end)
end)

ESX.RegisterServerCallback('pepe-phone:server:GetVehicleSearchResults', function(source, cb, search)
    local src = source
    local search = escape_sqli(search)
    local searchData = {}
    local character = GetCharacter(src)
    ExecuteSql(false, 'SELECT * FROM `owned_vehicles` WHERE `plate` LIKE "%'..search..'%" OR `owner` = "'..search..'"', function(result)
        if result[1] ~= nil then
            for k, v in pairs(result) do
                ExecuteSql(true, 'SELECT * FROM `users` WHERE `identifier` = "'..result[k].owner..'"', function(player)
                    if player[1] ~= nil then 
                        local charinfo = json.decode(player[1].charinfo)
						local vehicleInfo = { ['name'] = json.decode(result[k].props).model }
                            if vehicleInfo ~= nil then 
                            table.insert(searchData, {
                                plate = result[k].plate,
                                state = result[k].state,
                                owner = character.firstname .. " " .. character.lastname,
                                identifier = result[k].identifier,
                                label = result[k].model
                            })
                        else
                            table.insert(searchData, {
                                plate = result[k].plate,
                                state = result[k].state,
                                owner = character.firstname .. " " .. character.lastname,
                                identifier = result[k].identifier,
                                label = "Name not found"
                            })
                        end
                    end
                end)
            end
        else
            if GeneratedPlates[search] ~= nil then
                table.insert(searchData, {
                    plate = GeneratedPlates[search].plate,
                    status = GeneratedPlates[search].status,
                    owner = GeneratedPlates[search].owner,
                    citizenid = GeneratedPlates[search].identifier,
                    label = "Brand unknown.."
                })
            else
                local ownerInfo = GenerateOwnerName()
                GeneratedPlates[search] = {
                    plate = search,
                    status = true,
                    owner = ownerInfo.name,
                    citizenid = ownerInfo.identifier,
                }
                table.insert(searchData, {
                    plate = search,
                    status = true,
                    owner = ownerInfo.name,
                    citizenid = ownerInfo.identifier,
                    label = "Brand unknown.."
                })
            end
        end
        cb(searchData)
    end)
end)

ESX.RegisterServerCallback('pepe-phone:server:ScanPlate', function(source, cb, plate)
    local src = source
    local vehicleData = {}
    if plate ~= nil then 
                ExecuteSql(false, 'SELECT * FROM `owned_vehicles` WHERE `plate` = "'..plate..'"', function(result)
            if result[1] ~= nil then
                ExecuteSql(true, 'SELECT * FROM `users` WHERE `identifier` = "'..result[1].identifier..'"', function(player)
                    local charinfo = json.decode(player[1].charinfo)
                    vehicleData = {
                        plate = plate,
                        status = true,
                        owner = character.firstname .. " " .. character.lastname,
                        citizenid = result[1].identifier,
                    }
                end)
            elseif GeneratedPlates ~= nil and GeneratedPlates[plate] ~= nil then 
                vehicleData = GeneratedPlates[plate]
            else
                local ownerInfo = GenerateOwnerName()
                GeneratedPlates[plate] = {
                    plate = plate,
                    status = true,
                    owner = ownerInfo.name,
                    citizenid = ownerInfo.identifier,
                }
                vehicleData = {
                    plate = plate,
                    status = true,
                    owner = ownerInfo.name,
                    citizenid = ownerInfo.identifier,
                }
            end
            cb(vehicleData)
        end)
    else
        --TriggerClientEvent('ESX:Notify', src, "No vehicle nearby..", "error")
        cb(nil)
    end
end)

function GenerateOwnerName()
    local names = {
        [1] = { name = "Jan Bloksteen", citizenid = "DSH091G93" },
        [2] = { name = "Jan Bakker", citizenid = "AVH09M193" },
        [3] = { name = "Ben Klaariskees", citizenid = "DVH091T93" },
        [4] = { name = "Karel Bakker", citizenid = "GZP091G93" },
        [5] = { name = "Klaas Adriaan", citizenid = "DRH09Z193" },
        [6] = { name = "Nico Wolters", citizenid = "KGV091J93" },
        [7] = { name = "Mark Hendrickx", citizenid = "ODF09S193" },
        [8] = { name = "Bert Johannes", citizenid = "KSD0919H3" },
        [9] = { name = "Karel de Grote", citizenid = "NDX091D93" },
        [10] = { name = "Jan Pieter", citizenid = "ZAL0919X3" },
        [11] = { name = "Huig Roelink", citizenid = "ZAK09D193" },
        [12] = { name = "Corneel Boerselman", citizenid = "POL09F193" },
        [13] = { name = "Hermen Klein Overmeen", citizenid = "TEW0J9193" },
        [14] = { name = "Bart Rielink", citizenid = "YOO09H193" },
        [15] = { name = "Antoon Henselijn", citizenid = "QBC091H93" },
        [16] = { name = "Aad Keizer", citizenid = "YDN091H93" },
        [17] = { name = "Thijn Kiel", citizenid = "PJD09D193" },
        [18] = { name = "Henkie Krikhaar", citizenid = "RND091D93" },
        [19] = { name = "Teun Blaauwkamp", citizenid = "QWE091A93" },
        [20] = { name = "Dries Stielstra", citizenid = "KJH0919M3" },
        [21] = { name = "Karlijn Hensbergen", citizenid = "ZXC09D193" },
        [22] = { name = "Aafke van Daalen", citizenid = "XYZ0919C3" },
        [23] = { name = "Door Leeferds", citizenid = "ZYX0919F3" },
        [24] = { name = "Nelleke Broedersen", citizenid = "IOP091O93" },
        [25] = { name = "Renske de Raaf", citizenid = "PIO091R93" },
        [26] = { name = "Krisje Moltman", citizenid = "LEK091X93" },
        [27] = { name = "Mirre Steevens", citizenid = "ALG091Y93" },
        [28] = { name = "Joosje Kalvenhaar", citizenid = "YUR09E193" },
        [29] = { name = "Mirte Ellenbroek", citizenid = "SOM091W93" },
        [30] = { name = "Marlieke Meilink", citizenid = "KAS09193" },
    }
    return names[math.random(1, #names)]
end

ESX.RegisterServerCallback('pepe-phone:server:GetGarageVehicles', function(source, cb)
    local Player = ESX.GetPlayerFromId(source)
    local Vehicles = {}

    ExecuteSql(false, "SELECT * FROM `owned_vehicles` WHERE `owner` = '"..Player.identifier.."'", function(result)
        if result[1] ~= nil then
            for k, v in pairs(result) do
                if v.state == 'impound' then
		   VehicleState = 'Bị giam'
		elseif v.state == 'garage' then
	           VehicleState = 'Trong Garage'
	        elseif v.state == 'unkown'then
                   VehicleState = 'Không rõ'
                end
		
		
		
                local vehdata = {}
			
                vehdata = {
                    model = result[k].model,
                    plate = v.plate,
					
                    garage = json.decode(result[k].parking),
                    state = VehicleState,
                    fuel = json.decode(result[k].stats).fuel,
                    engine = json.decode(result[k].stats).engine_damage,
                    body = json.decode(result[k].stats).body_damage,
                }

                table.insert(Vehicles, vehdata)
            end
            cb(Vehicles)
        else
            cb(nil)
        end
    end)
end)

RegisterServerEvent('pepe-phone:server:updateidForEveryone')
AddEventHandler('pepe-phone:server:updateidForEveryone', function()
    TriggerClientEvent('pepe-phone:updateidForEveryone', -1)
end)

RegisterServerEvent('pepe-phone:saveTwitterToDatabase')
AddEventHandler('pepe-phone:saveTwitterToDatabase', function(firstName, lastname, message, url, time, picture)
    local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('INSERT INTO twitter_tweets (firstname, lastname, message, url, time, picture, owner) VALUES (@firstname, @lastname, @message, @url, @time, @picture, @owner)',
	{
		['@firstname']   	= firstName,
		['@lastname']   	= lastname,
		['@message'] 	= message,
        ['@url']       = url,
		['@time']  = time,
        ['@picture'] 		= picture,
        ['@owner'] 		= xPlayer.identifier,

	})
end)

-- ESX.RegisterServerCallback('pepe-phone:server:GetGarageVehicles', function(source, cb)
--     local Player = Framework.Functions.GetPlayer(source)
--     local Vehicles = {}

--     ExecuteSql(false, "SELECT * FROM `characters_vehicles` WHERE `citizenid` = '"..Player.identifier.."'", function(result)
--         if result[1] ~= nil then
--             for k, v in pairs(result) do
--                 --local VehicleData = Framework.Shared.Vehicles[v.vehicle]

--                 local VehicleMeta = {}
--                 if v.metadata ~= nil then
--                     VehicleMeta = json.decode(v.metadata)
--                 end

--                 local VehicleState = "In"
--                 if v.state == 'out' then
--                     VehicleState = "Uit"
--                 elseif v.state == 'impound' then
--                     VehicleState = "In Beslag"
--                 end

--                 local vehdata = {}
--                 if v.vehicle ~= nil then
--                     vehdata = {
--                         fullname = Framework.Shared.Vehicles[v.vehicle]['name'],
--                         model = Framework.Shared.Vehicles[v.vehicle]['name'],
--                         plate = v.plate,
--                         garage = v.garage,
--                         state = VehicleState,
--                         fuel = VehicleMeta.Fuel,
--                         engine = VehicleMeta.Engine,
--                         body =  VehicleMeta.Body,
--                     }
--                 else
--                     vehdata = {
--                         fullname = Framework.Shared.Vehicles[v.vehicle]['name'],
--                         model = Framework.Shared.Vehicles[v.vehicle]['name'],
--                         plate = v.plate,
--                         garage = v.garage,
--                         state = VehicleState,
--                         fuel = VehicleMeta.Fuel,
--                         engine = VehicleMeta.Engine,
--                         body =  VehicleMeta.Body,
--                     }
--                 end

--                 table.insert(Vehicles, vehdata)
--             end
--             cb(Vehicles)
--         else
--             cb(nil)
--         end
--     end)
-- end)


ESX.RegisterServerCallback('pepe-phone:server:GetInvoiceData', function(source, cb)
    local Player = ESX.GetPlayerFromId(source)
    local InvoiceData = {}
    ExecuteSql(false, "SELECT * FROM billing WHERE `receiver_identifier` = '"..Player.identifier.."'", function(invoices)
        if invoices[1] ~= nil then
            for k, v in pairs(invoices) do
                local Ply = ESX.GetPlayerFromIdentifier(v.sender)
                if Ply ~= nil then
                    v.number = GetCharacter(Ply).phone
                else
                    ExecuteSql(true, "SELECT * FROM `users` WHERE `identifier` = '"..v.sender.."'", function(res)
                        if res[1] ~= nil then
                            res[1].charinfo = json.decode(res[1].charinfo)
                            v.number = res[1].charinfo.phone
                        else
                            v.number = nil
                        end
                    end)
                end
            end
            InvoiceData = invoices
        end
        cb(InvoiceData)
    end)
end)


RegisterServerEvent('pepe-phone:server:add:invoice')
AddEventHandler('pepe-phone:server:add:invoice', function(TargetPlayer, Amount, Sender, Type)
    local PhoneData = {}
    local invoiceserie = math.random(111,999)..'-MIL-'..math.random(111,999)
    ExecuteSql(false, "INSERT INTO `characters_bills` (`citizenid`, `amount`, `invoiceid`, `sender`, `type`) VALUES ('"..TargetPlayer.."', '"..Amount.."', '"..invoiceserie.."', '"..Sender.."', '"..Type.."')")
end)

ESX.RegisterServerCallback('pepe-phone:server:HasPhone', function(source, cb)
    -- local Player = Framework.Functions.GetPlayer(source)
    -- if Player ~= nil then
        -- local HasPhone = Player.Functions.GetItemByName("phone")
        -- local retval = false
        -- if HasPhone ~= nil then
            -- cb(true)
        -- else
            -- cb(false)
        -- end
    -- end
end)

RegisterServerEvent('pepe-phone:server:GiveContactDetails')
AddEventHandler('pepe-phone:server:GiveContactDetails', function(PlayerId)
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
    TriggerClientEvent('pepe-phone:client:AddNewSuggestion', PlayerId, SuggestionData)
end)

ESX.RegisterServerCallback('pepe-phone:server:GetCurrentLawyers', function(source, cb)
    local Lawyers = {}
    for k, v in pairs(ESX.GetPlayers()) do
        local Player = ESX.GetPlayerFromId(v)
		local character = GetCharacter(v)
        if Player ~= nil then
            if Player.job.name == "lawyer" or Player.job.name == "realestate" or Player.job.name == "cardealer" then
                table.insert(Lawyers, {
                    name = character.firstname .. " " .. Pcharacter.lastname,
                    phone = character.phone,
                    typejob = character.job,
                })
            end
        end
    end
    cb(Lawyers)
end)
-- ESX(V1_Final) Fix
function GetCharacter(source)
    local xPlayer = ESX.GetPlayerFromId(source)

	local result = MySQL.Sync.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	})

    return result[1]
end
-- Framework.Commands.Add("notify", "Test the notification system", {}, false, function(source, args)
    -- TriggerClientEvent('pepe-phone:client:voertuigready', source)
-- end, "user")


ESX.RegisterServerCallback('pepe-phone:server:GetBankData', function(source, cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local character = GetCharacter(src)

    cb({bank = xPlayer.getAccount('bank').money,money = xPlayer.getAccount('money').money, iban = character.iban})
end)

function ExecuteSql(wait, query, cb)
	local rtndata = {}
	local waiting = true
	MySQL.Async.fetchAll(query, {}, function(data)
		if cb ~= nil and wait == false then
			cb(data)
		end
		rtndata = data
		waiting = false
	end)
	if wait then
		while waiting do
			Citizen.Wait(5)
		end
		if cb ~= nil and wait == true then
			cb(rtndata)
		end
    end
    
	return rtndata
end

function GetPlayerFromPhone(phone)
    local result = MySQL.Sync.fetchAll('SELECT * FROM users WHERE phone = @phone', {
		['@phone'] = phone
    })
    
    if result[1] and result[1].identifier then
        return ESX.GetPlayerFromIdentifier(result[1].identifier)
    end

    return nil
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