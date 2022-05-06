local wlk_acws = false

local w1msbbbbb='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
function b64enc(data)
	return ((data:gsub('.', function(x) 
		local r, w1msbbbbb = '', x:byte()
		for i = 8, 1, -1 do r = r .. (w1msbbbbb % 2 ^ i - w1msbbbbb % 2 ^ ( i - 1 ) > 0 and '1' or '0') end
		return r;
	end) .. '0000' ):gsub('%d%d%d?%d?%d?%d?', function(x)
	if (#x < 6) then
		return ''
	end
	local c = 0
	for i = 1, 6 do c = c + ( x:sub(i, i) == '1' and 2 ^ ( 6 - i ) or 0 ) end
	return w1msbbbbb:sub( c + 1, c + 1 )
end)..({ '', '==', '=' })[#data % 3 + 1 ])
end
function b64dec(data)
	data = string.gsub(data, '[^'..w1msbbbbb..'=]', '')
	return (data:gsub('.', function(x)
		if (x == '=') then
			return ''
		end
		local r, f= '', ( w1msbbbbb:find( x ) - 1 )
		for i = 6, 1, -1 do r = r .. ( f % 2 ^ i - f % 2 ^ ( i - 1 ) > 0 and '1' or '0') end
		return r;
	end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
	if (#x ~= 8) then
		return ''
	end
	local c = 0
	for i = 1, 8 do c = c + ( x:sub( i, i ) == '1' and 2 ^ ( 8 - i ) or 0) end
	return string.char(c)
end))
end

function encodeURI(str)
	if (str) then
		str = string.gsub (str, "\n", "\r\n")
		str = string.gsub (str, "([^%w ])",
			function (c) return string.format ("%%%02X", string.byte(c)) end)
		str = string.gsub (str, " ", "+")
	end
	return str
end


function wtime()
	return os.date('%H:%M:%S', os.time())
end

if not Config then
	Config = {}
end

local checked = 0

function werror()
	os.exit()
	StopResource(GetCurrentResourceName())
end


function License_Checker(ennc, resourceName, tran1, tran2, licenseR)

	checked = checked + 1

	if checked <= 4 then

		PerformHttpRequest(ennc, function(Status, Request, Header)

			if Status == 200 then

				local data = json.decode(tostring(b64dec(b64dec(b64dec(Request)))))

				local rran1 = tostring(b64dec(b64dec(b64dec(data.rf))))
				local rran2 = tostring(b64dec(b64dec(b64dec(data.rs))))

				local wstatus = tostring(b64dec(data.status))

				if rran1 == tran1 and rran2 == tran2 then


					if wstatus == "W1MSSUCESSWLK" then

						local name   = tostring(data.un)
						local cur    = tostring(data.cur)
						local new    = tostring(data.new)
						local update = tonumber(data.update)
						local dm     = tostring(data.domain)

						print('\27[32m['..wtime()..'] \27[33m['..resourceName..']\27[0m \27[35m[WLK]\27[0m - \27[32mCheck Success!\27[0m')
						print('\27[32m['..wtime()..'] \27[33m['..resourceName..']\27[0m \27[35m[WLK]\27[0m - \27[0mThank You \27[44m '..name..' \27[0m for purchase this script\27[0m')
						if update == 1 then
							print('\27[32m['..wtime()..'] \27[33m['..resourceName..']\27[0m \27[35m[WLK]\27[0m - \27[36mThere is a new version update. \27[0m'..dm)
							print('\27[32m['..wtime()..'] \27[33m['..resourceName..']\27[0m \27[35m[WLK]\27[0m - New Version     : \27[32m'..new..'\27[0m')
							print('\27[32m['..wtime()..'] \27[33m['..resourceName..']\27[0m \27[35m[WLK]\27[0m - Current version : \27[34m'..cur..'\27[0m')
						end
						TriggerEvent(GetCurrentResourceName()..':wat', true)


					elseif wstatus == "W1MSIPADDRESS" then

						print('\27[32m['..wtime()..'] \27[33m['..resourceName..']\27[0m \27[35m[WLK]\27[0m - \27[31mCheck Error!\27[0m')
						print('\27[32m['..wtime()..'] \27[33m['..resourceName..']\27[0m \27[35m[WLK]\27[0m - \27[36mIP address does not match\27[0m')
						local second = 10
						for i=1,10 do
							Citizen.Wait(1000)
							print('\27[32m['..wtime()..'] \27[33m['..resourceName..']\27[0m \27[35m[WLK]\27[0m - Your Server will shut down in \27[31m'..second..' seconds ...\27[0m')
							second = second - 1
						end
						werror()
					elseif wstatus == "W1MSINVALIDWLK" then

						print('\27[32m['..wtime()..'] \27[33m['..resourceName..']\27[0m \27[35m[WLK]\27[0m - \27[31mCheck Error!\27[0m')
						print('\27[32m['..wtime()..'] \27[33m['..resourceName..']\27[0m \27[35m[WLK]\27[0m - \27[36mThis license key is invalid.\27[0m')
						local second = 10
						for i=1,10 do
							Citizen.Wait(1000)
							print('\27[32m['..wtime()..'] \27[33m['..resourceName..']\27[0m \27[35m[WLK]\27[0m - Your Server will shut down in \27[31m'..second..' seconds ...\27[0m')
							second = second - 1
						end
						werror()
					else

						print('\27[32m['..wtime()..'] \27[33m['..resourceName..']\27[0m \27[35m[WLK]\27[0m - \27[31mCheck Error!\27[0m')
						print('\27[32m['..wtime()..'] \27[33m['..resourceName..']\27[0m \27[35m[WLK]\27[0m - \27[36mThis license key format is invalid.\27[0m')
						local second = 10
						for i=1,10 do
							Citizen.Wait(1000)
							print('\27[32m['..wtime()..'] \27[33m['..resourceName..']\27[0m \27[35m[WLK]\27[0m - Your Server will shut down in \27[31m'..second..' seconds ...\27[0m')
							second = second - 1
						end
						werror()
					end


				else


					print('\27[32m['..wtime()..'] \27[33m['..resourceName..']\27[0m \27[35m[WLK]\27[0m - \27[31mYou Are Cracker?\27[0m')
					print('\27[32m['..wtime()..'] \27[33m['..resourceName..']\27[0m \27[35m[WLK]\27[0m - \27[31mYou Motherfucker\27[0m')
					local second = 10
					for i=1,10 do
						Citizen.Wait(1000)
						print('\27[32m['..wtime()..'] \27[33m['..resourceName..']\27[0m \27[35m[WLK]\27[0m - Your Server will shut down in \27[31m'..second..' seconds ...\27[0m')
						second = second - 1
					end
					werror()
				end


			else

				local second = 3
				print('\27[32m['..wtime()..'] \27[33m['..resourceName..']\27[0m \27[35m[WLK]\27[0m - \27[31mServer Error\27[0m - Bad Request: '..Status)

				if checked ~= 4 then

					for i=1,3 do

						Citizen.Wait(1000)
						print('\27[32m['..wtime()..'] \27[33m['..resourceName..']\27[0m \27[35m[WLK] \27[36m['..checked..']\27[0m - Retry in \27[35m'..second..' seconds ...\27[0m')

						second = second - 1

					end
				else

					local second = 10
					for i=1,10 do
						Citizen.Wait(1000)
						print('\27[32m['..wtime()..'] \27[33m['..resourceName..']\27[0m \27[35m[WLK]\27[0m - Your Server will shut down in \27[31m'..second..' seconds ...\27[0m')
						second = second - 1
					end
					werror()

				end

				License_Checker(ennc, resourceName, eran1, eran2)

			end

		end, 'GET', "", {what = 'this'})

end

end




Citizen.CreateThread(function()

	Citizen.Wait(1000)

	local resourceName = GetCurrentResourceName()

	if Config.UserLicense then

		local ServerUrl = 'https://apix.w1ms.com/api/fivemshop/v2/ch'

		local version = 1.1

		local hostname = b64enc(GetConvar("sv_hostname", "Unknown"))


		key = Config.UserLicense

		local chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
		local length = 1024
		local licenseR = ''

		charTable = {}
		for c in chars:gmatch"." do
			table.insert(charTable, c)
		end

		for i = 1, length do
			licenseR = licenseR .. charTable[math.random(1, #charTable)]
		end


		local ekey     = b64enc(key)

		local ename    = b64enc(resourceName)

		local ever     = b64enc(tostring(version))

		local edate    = b64enc(os.date())

		local tran1    = "AS"..math.random(100000000000, 999999999999).."SA"

		local tran2    = "SA"..math.random(100000000000, 999999999999).."AS"

		local ecom     = b64enc(os.getenv("USERNAME"))

		local eran1    = b64enc(tran1)

		local eran2    = b64enc(tran2)

		local ennc     = eran1.."EVANW1MSE"..ekey.."EVANW1MSE"..ename.."EVANW1MSE"..ever.."EVANW1MSE"..edate.."EVANW1MSE"..eran2.."EVANW1MSE"..ecom.."EVANW1MSE"..licenseR.."EVANW1MSE"..hostname

		local ecode    = encodeURI(ennc)

		local ecodeurl = ServerUrl.."?k="..ecode

		print('')

		License_Checker(ecodeurl, resourceName, tran1, tran2, licenseR)


	else
		print('\27[32m['..wtime()..'] \27[33m['..resourceName..']\27[0m \27[35m[WLK]\27[0m - \27[31mPlease Input License Key\27[0m')
		local second = 10
		for i=1,10 do
			Citizen.Wait(1000)
			print('\27[32m['..wtime()..'] \27[33m['..resourceName..']\27[0m \27[35m[WLK]\27[0m - Your Server will shut down in \27[31m'..second..' seconds ...\27[0m')
			second = second - 1
		end
		werror()
	end
end)


RegisterServerEvent(GetCurrentResourceName()..':wat') 
AddEventHandler(GetCurrentResourceName()..':wat', function(status) 
	wlk_acws = status
	if wlk_acws then
		print('\27[32m['..wtime()..'] \27[33m['..GetCurrentResourceName()..']\27[0m \27[35m[WLK]\27[0m - \27[32mActive \27[0m')
	else
		print('\27[32m['..wtime()..'] \27[33m['..GetCurrentResourceName()..']\27[0m \27[35m[WLK]\27[0m - \27[31mNot Active\27[0m')
	end
end)


local wfprint = function (string)
	print(string)
end

local print = function (string)
	wfprint('\27[32m['..wtime()..'] \27[33m['..GetCurrentResourceName()..'] \27[31m[WAD]\27[0m - Anti Print\27[0m')
end

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterServerCallback('w1ms_redeem-voucher:getwat',function(source, cb)
	cb(wlk_acws)
end)


local resourceName = GetCurrentResourceName()

local admincmd = "adminredeem"
local usercmd = "redeem"

local useadmincmd = false
local useusercmd = false

if Config.OpenAdminUIbyCMD then
	useadmincmd = Config.OpenAdminUIbyCMD
end

if Config.OpenUserUIbyCMD then
	useusercmd = Config.OpenUserUIbyCMD
end

if Config.OpenAdminUICMD then
	admincmd = Config.OpenAdminUICMD
end

if Config.OpenUserUICMD then
	usercmd = Config.OpenUserUICMD
end

function wtime()
	return os.date('%H:%M:%S', os.time())
end

function gen_voucher_code()
	local length = 20
	local firstCode = ""
	if Config.LastCodeLength then
		length = Config.LastCodeLength
	end
	if Config.FirstCode then
		firstCode = Config.FirstCode
	end
	local chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
	local licenseR = ''
	charTable = {}
	for c in chars:gmatch"." do
		table.insert(charTable, c)
	end
	for i = 1, length do
		licenseR = licenseR .. charTable[math.random(1, #charTable)]
	end

	return firstCode..licenseR
end

function discord_message(title)
	local username = 'Voucher'
	local webhook = ''
	if Config.DiscordWebhook then
		webhook = Config.DiscordWebhook
	end
	if Config.DiscordBotName then
		username = Config.DiscordBotName
	end
	local embeds = {
		{
			['title'] = Config.DiscordBotTitle,
			['description'] = title,
			['type'] = 'rich',
			['color'] = 13938487,
			['footer'] = {['text'] = ''}
		}
	}
	Citizen.CreateThread(function()
		Citizen.Wait(1000)
		PerformHttpRequest(webhook, function(err, text, headers)
	end, 'POST', json.encode({username = username, embeds = embeds}), {['Content-Type'] = 'application/json'})
	end)
end

RegisterServerEvent('w1ms_redeem-voucher:deletecode') 
AddEventHandler('w1ms_redeem-voucher:deletecode', function(data) 
	if wlk_acws then
		if type(data) == "table" then
			local id = tonumber(data.id)

			MySQL.Async.execute('DELETE FROM `voucher_code` WHERE `id` = @id', { 

				['@id'] = id

			})

			TriggerClientEvent('w1ms_redeem-voucher:updatecode', source, "codeinfo")

		else
			wfprint('\27[32m['..wtime()..'] \27[33m['..resourceName..']\27[0m - \27[31m Can\'t delete code. Data Type is wrong \27[0m')
		end
	end

end)

RegisterServerEvent('w1ms_redeem-voucher:submit') 
AddEventHandler('w1ms_redeem-voucher:submit', function(data) 
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer and wlk_acws then
		local identifier = xPlayer.identifier
		if type(data) == "table" then
			local code = tostring(data.code)
			local count = 0
			local result = MySQL.Sync.fetchAll('SELECT * FROM `voucher_code` WHERE `code` = @code', {
				['@code'] = code
			})
			if result then
				for i=1, #result, 1 do
					count = count + 1
				end

				if count >= 1 then --[[Found--]]

					if result[1].status == 1 then --[[Not Used --]]

						if result[1].expire == 1 then --[[Check Expire--]]

							if is_expire(code) then --[[Is Expire Status 4--]]

								TriggerClientEvent("pNotify:SendNotification", _source, {
									text =  "โค้ดนี้หมดอายุไปแล้ว",
									type = "error",
									queue = "left",
									timeout = 2000,
									layout = "centerLeft"
								})

								local title = string.format(Config.DiscordMsgError1, xPlayer.name, code)
								discord_message(title)

							else

								if result[1].use == "more" then --[[Check Type--]]

									if check_usedmore(identifier, code) then --[[Is success--]]

										TriggerClientEvent("pNotify:SendNotification", _source, {
											text =  "เติมโค้ดสำเร็จ",
											type = "success",
											queue = "left",
											timeout = 2000,
											layout = "centerLeft"
										})

										MySQL.Async.execute('INSERT INTO `voucher_code_used` (`code`,`identifier`) VALUES (@code, @identifier)', { 

											['@code'] = code,

											['@identifier'] = identifier

										})

										add_items(result[1].items, _source)

										local title = string.format(Config.DiscordMsgSuccess, xPlayer.name, code)
										discord_message(title)

									else

										TriggerClientEvent("pNotify:SendNotification", _source, {
											text =  "คุณใช้โค้ดนี้ไปแล้ว",
											type = "error",
											queue = "left",
											timeout = 2000,
											layout = "centerLeft"
										})

										local title = string.format(Config.DiscordMsgError2, xPlayer.name, code)
										discord_message(title)

									end

								else

									TriggerClientEvent("pNotify:SendNotification", _source, {
										text =  "เติมโค้ดสำเร็จ",
										type = "success",
										queue = "left",
										timeout = 2000,
										layout = "centerLeft"
									})

									MySQL.Async.execute('UPDATE `voucher_code` SET `status` = 0 WHERE `code` = @code', { 

										['@code'] = code

									})

									add_items(result[1].items, _source)

									local title = string.format(Config.DiscordMsgSuccess, xPlayer.name, code)
									discord_message(title)

								end

							end

						else --[[Not Expire--]]

							if result[1].use == "more" then --[[Check Type--]]

								if check_usedmore(identifier, code) then

									TriggerClientEvent("pNotify:SendNotification", _source, {
										text =  "เติมโค้ดสำเร็จ",
										type = "success",
										queue = "left",
										timeout = 2000,
										layout = "centerLeft"
									})

									MySQL.Async.execute('INSERT INTO `voucher_code_used` (`code`,`identifier`) VALUES (@code, @identifier)', { 

										['@code'] = code,

										['@identifier'] = identifier

									})

									add_items(result[1].items, _source)

									local title = string.format(Config.DiscordMsgSuccess, xPlayer.name, code)
									discord_message(title)



								else

									TriggerClientEvent("pNotify:SendNotification", _source, {
										text =  "คุณใช้โค้ดนี้ไปแล้ว",
										type = "error",
										queue = "left",
										timeout = 2000,
										layout = "centerLeft"
									})

									local title = string.format(Config.DiscordMsgError2, xPlayer.name, code)
									discord_message(title)

								end

							else --[[Is Use One Status 1 --]]

								TriggerClientEvent("pNotify:SendNotification", _source, {
									text =  "เติมโค้ดสำเร็จ",
									type = "success",
									queue = "left",
									timeout = 2000,
									layout = "centerLeft"
								})

								MySQL.Async.execute('UPDATE `voucher_code` SET `status` = 0 WHERE `code` = @code', { 

									['@code'] = code

								})

								add_items(result[1].items, _source)

								local title = string.format(Config.DiscordMsgSuccess, xPlayer.name, code)
								discord_message(title)

							end

						end


					else --[[Is Used Status 5--]]

						TriggerClientEvent("pNotify:SendNotification", _source, {
							text =  "โค้ดนี้ถูกใช้งานไปแล้ว",
							type = "success",
							queue = "left",
							timeout = 2000,
							layout = "centerLeft"
						})

						local title = string.format(Config.DiscordMsgError3, xPlayer.name, code)
						discord_message(title)

					end

				else --[[Not Found Status 0--]]

					TriggerClientEvent("pNotify:SendNotification", _source, {
						text =  "โค้ดนี้ไม่ถูกต้อง",
						type = "success",
						queue = "left",
						timeout = 2000,
						layout = "centerLeft"
					})

					local title = string.format(Config.DiscordMsgError4, xPlayer.name, code)
					discord_message(title)

				end
			end

		else	
			wfprint('\27[32m['..wtime()..'] \27[33m['..resourceName..']\27[0m - \27[31m Can\'t delete code. Data Type is wrong \27[0m')
		end

	end
end)


TriggerEvent('es:addGroupCommand', admincmd, 'admin', function(source, args, user)

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer then
		if useadmincmd and wlk_acws then
			TriggerClientEvent('w1ms_redeem-voucher:open-admin', _source)
		end
	end


end, function(source, args, user)
TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = 'Open Admin Redeem Voucher UI'})



TriggerEvent('es:addGroupCommand', usercmd, 'user', function(source, args, user)

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer then
		if useadmincmd and wlk_acws then
			TriggerClientEvent('w1ms_redeem-voucher:open-user', _source)
		end
	end


end, function(source, args, user)
TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = 'Open Redeem Voucher UI'})


function add_items(items, source)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer and wlk_acws then
		local data = json.decode(items)
		local identifier = xPlayer.identifier
		local ammo = 250

		if Config.Ammo then
			ammo = Config.Ammo
		end

		for k,v in pairs(data) do
			if v.type == "item" then
				xPlayer.addInventoryItem(v.name, tonumber(v.amount))
			elseif v.type == "money" then
				xPlayer.addMoney(tonumber(v.amount))
			elseif v.type == "blackmoney" then
				xPlayer.addAccountMoney('black_money', tonumber(v.amount))
			elseif v.type == "car" then	
				add_vehicle(identifier, v.name)
			elseif v.type == "weapon" then
				xPlayer.addWeapon(v.name, tonumber(ammo))
			end
		end
	end

end

function GetRandomLetter(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end

function genPlate()
	local length = 3
	local chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
	local pLate = ''
	charTable = {}
	for c in chars:gmatch"." do
		table.insert(charTable, c)
	end
	for i = 1, length do
		pLate = pLate .. charTable[math.random(1, #charTable)]
	end

	return pLate
end

function add_vehicle(identifier, name)
	if type(name) == 'string' then
		hash = GetHashKey(name)
	end
	local plate = genPlate()..' '..genPlate()
	plate = string.upper(plate)
	local veh = {
		dirtLevel = 5.0,
		model = hash,
		modBrakes = -1,
		color1 = 6,
		modRightFender = -1,
		modExhaust = -1,
		windowTint = -1,
		modAPlate = -1,
		modEngineBlock = -1,
		modBackWheels = -1,
		health = 1000,
		modWindows = -1,
		tyreSmokeColor = {255, 255, 255},
		modRearBumper = -1,
		modAerials = -1,
		modStruts = -1,
		modTrimA = -1,
		modGrille = -1,
		modTransmission = -1,
		extras = {[12] = false, [10] = false},
		modSmokeEnabled = false,
		modHorns = -1,
		modTrunk = -1,
		modArchCover = -1,
		modShifterLeavers = -1,
		pearlescentColor = 111,
		modLivery = -1,
		modSeats = -1,
		modSpeakers = -1,
		modAirFilter = -1,
		modSuspension = -1,
		modFrontBumper = -1,
		modDoorSpeaker = -1,
		wheels = 0,
		modEngine = -1,
		neonColor = {255, 0, 255},
		modSpoilers = -1,
		modFender = -1,
		modDashboard = -1,
		color2 = 0,
		modTurbo = false,
		plate = plate,
		modArmor = -1,
		modTrimB = -1,
		modVanityPlate = -1,
		plateIndex = 0,
		modRoof = -1,
		modSideSkirt = -1,
		modXenon = false,
		modSteeringWheel = -1,
		wheelColor = 156,
		modFrame = -1,
		modOrnaments = -1,
		modTank = -1,
		modHydrolic = -1,
		modHood = -1,
		modFrontWheels = -1,
		modPlateHolder = -1,
		modDial = -1,
		neonEnabled = {false, false, false, false}
	}
	MySQL.Async.execute('INSERT INTO owned_vehicles (`owner`, `plate`, `vehicle`, `stored`) VALUES (@owner, @plate, @vehicle, 1)',{
		['@owner'] = identifier,
		['@plate'] = veh.plate,
		['@vehicle'] = json.encode(veh)
	},function(rowsChanged)

end)
end


RegisterServerEvent('w1ms_redeem-voucher:check') 
AddEventHandler('w1ms_redeem-voucher:check', function(data) 
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer and wlk_acws then

		local identifier = xPlayer.identifier
		if type(data) == "table" then
			local code = tostring(data.code)
			local count = 0
			local result = MySQL.Sync.fetchAll('SELECT * FROM `voucher_code` WHERE `code` = @code', {
				['@code'] = code
			})

			if result then
				for i=1, #result, 1 do
					count = count + 1
				end


				if count >= 1 then --[[Found--]]

					if result[1].status == 1 then --[[Not Used --]]

						if result[1].expire == 1 then --[[Check Expire--]]

							if is_expire(code) then --[[Is Expire Status 4--]]

								TriggerClientEvent('w1ms_redeem-voucher:updateres', _source, {item = result[1].items, status = 2})

								local title = string.format(Config.DiscordMsgError1, xPlayer.name, code)
								discord_message(title)

							else

								if result[1].use == "more" then --[[Check Type--]]

									if check_usedmore(identifier, code) then --[[Is success--]]

										TriggerClientEvent('w1ms_redeem-voucher:updateres', _source, {item = result[1].items, status = 1})

									else

										TriggerClientEvent('w1ms_redeem-voucher:updateres', _source, {item = result[1].items, status = 6})

										local title = string.format(Config.DiscordMsgError2, xPlayer.name, code)
										discord_message(title)

									end

								else
									TriggerClientEvent('w1ms_redeem-voucher:updateres', _source, {item = result[1].items, status = 1})
								end

							end

						else --[[Not Expire--]]

							if result[1].use == "more" then --[[Check Type--]]

								if check_usedmore(identifier, code) then

									TriggerClientEvent('w1ms_redeem-voucher:updateres', _source, {item = result[1].items, status = 1})

								else

									TriggerClientEvent('w1ms_redeem-voucher:updateres', _source, {item = result[1].items, status = 6})

									local title = string.format(Config.DiscordMsgError2, xPlayer.name, code)
									discord_message(title)

								end

							else --[[Is Use One Status 1 --]]

								TriggerClientEvent('w1ms_redeem-voucher:updateres', _source, {item = result[1].items, status = 1})

							end

						end


					else --[[Is Used Status 5--]]

						TriggerClientEvent('w1ms_redeem-voucher:updateres', _source, {status = 3})

						local title = string.format(Config.DiscordMsgError3, xPlayer.name, code)
						discord_message(title)

					end

				else --[[Not Found Status 0--]]

					TriggerClientEvent('w1ms_redeem-voucher:updateres', _source, {status = 0})

					local title = string.format(Config.DiscordMsgError4, xPlayer.name, code)
					discord_message(title)
					
				end
			end


			--TriggerClientEvent('w1ms_redeem-voucher:updatecode', source, "codeinfo")
		else	
			wfprint('\27[32m['..wtime()..'] \27[33m['..resourceName..']\27[0m - \27[31m Can\'t delete code. Data Type is wrong \27[0m')
		end

	end
end)


function check_usedmore(identifier, code)
	local count = 0
	local result = MySQL.Sync.fetchAll('SELECT * FROM `voucher_code_used` WHERE `code` = @code AND identifier = @identifier', {
		['@code'] = code,
		['@identifier'] = identifier
	})
	if result then
		for i=1, #result, 1 do
			count = count + 1
		end
		if count == 0 then
			return true
		else
			return false
		end
	end
end


function is_expire(code)
	local count = 0
	local result = MySQL.Sync.fetchAll('SELECT * FROM `voucher_code` WHERE `code` = @code AND NOW() < expire_date', {
		['@code'] = code
	})
	if result then
		for i=1, #result, 1 do
			count = count + 1
		end
		if count == 0 then
			return true
		else
			return false
		end
	end
end


RegisterServerEvent('w1ms_redeem-voucher:savecode') 
AddEventHandler('w1ms_redeem-voucher:savecode', function(data) 

	if wlk_acws then

		if type(data) == "table" then

			local code = tostring(gen_voucher_code())

			local items = tostring(data.json)

			local use = tostring(data.use)

			local expire = tonumber(data.expire)

			local expiredate = nil

			if expire == 1 then
				expiredate = tostring(data.expiredate)
			else
				expiredate = nil
			end

			MySQL.Async.execute('INSERT INTO `voucher_code` (`code`,`items`,`use`,`expire`,`expire_date`) VALUES (@code, @items, @use, @expire, @expiredate)', { 

				['@code'] = code,

				['@items'] = items, 

				['@use'] = use,

				['@expire'] = expire,

				['@expiredate'] = expiredate

			})

			wfprint('\27[32m['..wtime()..'] \27[33m['..resourceName..']\27[0m -\27[32m Code:\27[35m'..code..'\27[32m Was Created!  \27[0m')
			TriggerClientEvent('w1ms_redeem-voucher:updatecode', source, "home")
		else

			wfprint('\27[32m['..wtime()..'] \27[33m['..resourceName..']\27[0m - \27[31m Can\'t save code. Data Type is wrong \27[0m')
		end
	end

end)

ESX.RegisterServerCallback('w1ms_redeem-voucher:getAlldata',function(source, cb)
	if wlk_acws then
		local voucher_code = MySQL.Sync.fetchAll('SELECT * FROM `voucher_code`')

		--[[voucher_code_used = MySQL.Sync.fetchAll('SELECT * FROM `voucher_code` INNER JOIN `voucher_code_used` ON `voucher_code`.`code` = `voucher_code_used`.`code` ORDER BY `voucher_code_used`.`id` DESC')--]]
		cb(json.encode(voucher_code))
	else
		cb(nil)
	end
end)