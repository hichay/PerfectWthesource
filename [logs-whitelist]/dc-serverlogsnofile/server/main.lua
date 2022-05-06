if Config == nil then 
    print(script_name .. ": Config is nil") 
	return 
end 
do 
	local function html_safe(str) 
		local output, t = str:gsub("[^%w]", function(chr) 
			return string.format("%%%X", string.byte(chr)) 
		end) 
		return 
		output 
	end 

	local  function build_param(url, tbl) 
		local param = "?"
		for k, v in pairs(tbl) do 
			param = param..k.."="..html_safe(v).."&"
		end 
		param = string.sub(param, 0, #param - 1) 
		return 
		(url..param) 
	end

	local script_name = GetCurrentResourceName()
	local script_active = false 
	local MoonAcceptLoadScript

	if GetCurrentResourceName()  ~= script_name then 
		print("Moon's: Unauthorized resource name changed. Please change to "..script_name.." for the best performance.") 
		return 
	end 
	
	if Config["license_key"] == nil or Config["license_key"] == "" then 
    print("Failed to load "..script_name.." because of license key is empty") return 
	end

	local run_connect 

	Citizen.CreateThread(function() 
		if Config == nil then print("Failed to load "..script_name.." because of the config is nil") 
			return 
		end 
		Citizen.Wait(4000) 

		local hostname = GetConvar("sv_hostname", "Unknown")
		--local auth_date = os.date("%d%m%Y")
		local url = build_param("https://gamexua.tv/ls/", {request = Config["license_key"], script_name = script_name, client_name = hostname}) 
		local sc = "\x1b[42m\x1b[30m"..script_name.."\x1b[0m"
		local attempt = 1 
		run_connect = function() 
			PerformHttpRequest(url, function(err, text, headers) 
				local st = json.decode(text or "") 
				if st then 
					local col = "\x1b[32m"
					if st.status ~= 200 then 
						col = "\x1b[31m"
					end 
					print(col.."[Moon's]\x1b[0m "..sc.." - "..(st.desc or "Unknown State")) 
					if st.status == 200 then 
						MoonAcceptLoadScript(st) 
						TriggerClientEvent("moon_template:client:failsafe_"..script_name, -1) 
					end 
					run_connect = nil
				else 
						print("\x1b[32m[Moon's]\x1b[0m "..sc.." - couldn't connect to server. Contact to: discord.gg/Hcj8uGwKkg, \x1b[31mAttempt "..attempt..".\x1b[0m") if attempt >= 5 then 
						print("\x1b[32m[Moon's]\x1b[0m "..sc.." - failed to connect license server after "..attempt.." attempts. ")
							
						run_connect = nil
						Citizen.Wait(10000)
						StopResource(script_name)
						return 
					end 
					attempt = attempt + 1 
					Citizen.Wait(5000) 
					run_connect() 
				end 
			end, 'GET', '', {["Content-Type"] = 'application/json'}) 
		end 
		run_connect() 
	end) 

	RegisterServerEvent("moon_template:server:license_"..script_name) 
	AddEventHandler("moon_template:server:license_"..script_name, function() 
		TriggerClientEvent("moon_template:client:license_"..script_name, source, script_active) 
	end) 

	MoonAcceptLoadScript = function(st) 
		if st == nil or st.auth == nil then 
			print("\x1b[33m["..script_name.."]\x1b[0m ".."couldn't load script.") 
			return
		end 

		local function bxor(a, b)
			local r, m, s = 0, 2 ^ 52 
			repeat 
				s, a, b = a + b + m, a % m, b % m 
				r, m = r + m * 3 % (s - a - b), m / 2 
			until m < 1
			return r 
		end 

		local valid = (st.auth_date.."."..script_name)
		local de = ""
		for l in string.gmatch(st.auth, "...") do
			local n = tonumber(l) or 0
			local bxo = bxor(n, 0x11)
			de = de..string.char(bxo)
		end
		if valid ~= de then 
			print("\x1b[33m["..script_name.."]\x1b[0m ".."authentication failed! (SCRIPT BYPASS DETECTED)") 
			return 
		end 
		script_active = true 
		print("\x1b[33m["..script_name.."]\x1b[0m ".."initiating splinter sequence.") 

		-- ///////////////////////////////////////////////////////////////// --
        --  ##########            Add detail Script below         ########## --
        --  ##########            Add detail Script below         ########## --
        --  ##########            Add detail Script below         ########## --
        --  ##########            Add detail Script below         ########## --
        --  ##########            Add detail Script below         ########## --
        --  ##########            Add detail Script below         ########## --
        -- ///////////////////////////////////////////////////////////////// --


ESX = nil
TriggerEvent(Config["esx_routers"]["server_shared_obj"],function(obj)
        ESX = obj
    end
)
	
AddEventHandler(Config["esx_routers"]["server_player_load"],function(source)
        Citizen.Wait(5000)
        local playerId = source
        local xPlayer = ESX.GetPlayerFromId(playerId)
		local message
        if xPlayer then
			if Config.roleplayname then 
				message = string.format(Config["translate"]["login"],xPlayer.name)
			else
				message = string.format(Config["translate"]["login"],GetPlayerName(source))
			end	
            TriggerEvent("moon_discordlogs:sendToDiscord", "Login", message, playerId, "^2")
        end
    end
)
AddEventHandler("playerDropped",function(reason)
        local playerId = source
        local xPlayer = ESX.GetPlayerFromId(playerId)
        local color = "^8"
		local message
        if string.match(reason, "Kicked") or string.match(reason, "Banned") then
            color = "^9"
        end
        if xPlayer then
			if Config.roleplayname then 
				message = string.format(Config["translate"]["logout"],xPlayer.name,reason)
			else
				message = string.format(Config["translate"]["logout"],GetPlayerName(source),reason)
			end
            TriggerEvent("moon_discordlogs:sendToDiscord", "Logout", message, playerId, color)
        end
    end
)
AddEventHandler("chatMessage",function(source, name, message)
        local playerId = source
        if playerId and message then
            if string.match(message, "@everyone") then
                message = message:gsub("@everyone", "`@everyone`")
            end
            if string.match(message, "@here") then
                message = message:gsub("@here", "`@here`")
            end
            TriggerEvent("moon_discordlogs:sendChatToDiscord", "Chat", message, playerId, "^7")
        end
    end
)
RegisterNetEvent("moon_discordlogs:sendDeathCause")
AddEventHandler("moon_discordlogs:sendDeathCause",function(type, source, target, event)
        local playerId = source
        local sourceXPlayer = ESX.GetPlayerFromId(playerId)
		local sourcename
		local targetname
        if target then
            local targetXPlayer = ESX.GetPlayerFromId(target)
			if Config.roleplayname then
			   sourcename = sourceXPlayer.name
			   targetname = targetXPlayer.name
			else
			   sourcename = GetPlayerName(playerId)
			   targetname = GetPlayerName(target)
			end
            if type == "Melee" and event then
                local message = string.format(Config["translate"]["kill"],sourcename,targetname,event)
                TriggerEvent("moon_discordlogs:sendToDiscord", "Dead", message, sourceXPlayer.source, "^1")
                Citizen.Wait(100)
                local message = string.format(Config["translate"]["kill"],sourcename,targetname,event)
                TriggerEvent("moon_discordlogs:sendToDiscord", "Dead", message, targetXPlayer.source, "^3")
            elseif type == "Bullet" and event then
                local message = string.format(Config["translate"]["kill"],sourcename,targetname,event)
                TriggerEvent("moon_discordlogs:sendToDiscord", "Dead", message, sourceXPlayer.source, "^1")
                Citizen.Wait(100)
                local message = string.format(Config["translate"]["kill"],sourcename,targetname,event)
                TriggerEvent("moon_discordlogs:sendToDiscord", "Dead", message, targetXPlayer.source, "^3")
            elseif type == "Car" and event then
                local message = string.format(Config["translate"]["kill"],sourcename,targetname,event)
                TriggerEvent("moon_discordlogs:sendToDiscord", "Dead", message, sourceXPlayer.source, "^1")
                Citizen.Wait(100)
                local message = string.format(Config["translate"]["kill"],sourcename,targetname,event)
                TriggerEvent("moon_discordlogs:sendToDiscord", "Dead", message, targetXPlayer.source, "^3")
            elseif type == "Explosion" and event then
                local message = string.format(Config["translate"]["kill"],sourcename,targetname,event) .." (Explosion)"
                TriggerEvent("moon_discordlogs:sendToDiscord", "Dead", message, sourceXPlayer.source, "^1")
                Citizen.Wait(100)
                local message = string.format(Config["translate"]["kill"],sourcename,targetname,event) .." (Explosion)"
                TriggerEvent("moon_discordlogs:sendToDiscord", "Dead", message, targetXPlayer.source, "^3")
            elseif type == "Gas" and event then
                local message = string.format(Config["translate"]["kill"],sourcename,targetname,event) .." (Gas)"
                TriggerEvent("moon_discordlogs:sendToDiscord", "Dead", message, sourceXPlayer.source, "^1")
                Citizen.Wait(100)
                local message = string.format(Config["translate"]["kill"],sourcename,targetname,event) .." (Gas)"
                TriggerEvent("moon_discordlogs:sendToDiscord", "Dead", message, targetXPlayer.source, "^3")
            elseif type == "Burn" and event then
                local message = string.format(Config["translate"]["kill"],sourcename,targetname,event) .." (Burn)"
                TriggerEvent("moon_discordlogs:sendToDiscord", "Dead", message, sourceXPlayer.source, "^1")
                Citizen.Wait(100)
                local message = string.format(Config["translate"]["kill"],sourcename,targetname,event) .." (Burn)"
                TriggerEvent("moon_discordlogs:sendToDiscord", "Dead", message, targetXPlayer.source, "^3")
            end
        else
            if type == "Melee" and event then
		local message = string.format(Config["translate"]["kill2"],sourcename,event.." (NPC)")
                TriggerEvent("moon_discordlogs:sendToDiscord", "Dead", message, sourceXPlayer.source, "^6")
            elseif type == "Bullet" and event then
		local message = string.format(Config["translate"]["kill2"],sourcename,event.." (NPC)")
                TriggerEvent("moon_discordlogs:sendToDiscord", "Dead", message, sourceXPlayer.source, "^6")
            elseif type == "Car" and event then
		local message = string.format(Config["translate"]["kill2"],sourcename,event.." (NPC or Car Crashing)")
           
                TriggerEvent("moon_discordlogs:sendToDiscord", "Dead", message, sourceXPlayer.source, "^6")
            elseif type == "Explosion" and event then
		local message = string.format(Config["translate"]["kill2"],sourcename,event.." (Explosion)")
                TriggerEvent("moon_discordlogs:sendToDiscord", "Dead", message, sourceXPlayer.source, "^5")
            elseif type == "Gas" and event then
		local message = string.format(Config["translate"]["kill2"],sourcename,event.." (GAS)")
                TriggerEvent("moon_discordlogs:sendToDiscord", "Dead", message, sourceXPlayer.source, "^5")
            elseif type == "Burn" and event then
		local message = string.format(Config["translate"]["kill2"],sourcename,event.." (BURN)")
                TriggerEvent("moon_discordlogs:sendToDiscord", "Dead", message, sourceXPlayer.source, "^5")
            elseif type == "Animal" and event then
		local message = string.format(Config["translate"]["kill2"],sourcename,event.." (Animal)")
                TriggerEvent("moon_discordlogs:sendToDiscord", "Dead", message, sourceXPlayer.source, "^2")
            elseif type == "FallDamage" and event then
		local message = string.format(Config["translate"]["kill2"],sourcename,event.." (Falling)")
                TriggerEvent("moon_discordlogs:sendToDiscord", "Dead", message, sourceXPlayer.source, "^5")
            elseif type == "Drown" and event then
		local message = string.format(Config["translate"]["kill2"],sourcename,event.." (Drown)")
                TriggerEvent("moon_discordlogs:sendToDiscord", "Dead", message, sourceXPlayer.source, "^5")
            elseif type == "Unknown" then
		local message = string.format(Config["translate"]["kill2"],sourcename,event.." (Unkown)")
                TriggerEvent("moon_discordlogs:sendToDiscord", "Dead", message, sourceXPlayer.source, "^7")
            end
        end
    end
)
RegisterNetEvent("moon_discordlogs:sendToDiscord")
AddEventHandler("moon_discordlogs:sendToDiscord",function(webhook, message, source, color)
        if webhook == nil or webhook == "" or message == nil or message == "" or source == nil or source == "" or color == nil or color == "" then
            return false
        end
        local playerId = source
        local xPlayer = ESX.GetPlayerFromId(playerId)
        if xPlayer == nil then
            return false
        end
        local discordId = GetDiscordID(playerId)
        local playerIp = GetPlayerEndpoint(playerId)
        local webhookUrl = Config["webhook"][webhook]
        if not discordId then
            discordId = "N/A"
            discordName = "N/A"
        else
            discordId = string.gsub(discordId, "discord:", "")
            discordName = "<@" .. discordId .. ">"
        end
        if not playerIp then
            playerIp = "N/A"
        end
        if webhookUrl then
            local setAccount =
			    
                Config["discordtemplate"]["name"] ..
                xPlayer.name ..
                    Config["discordtemplate"]["identifier"] ..
                        xPlayer.identifier ..
                            Config["discordtemplate"]["discord"] ..
                                discordName ..
                                    Config["discordtemplate"]["discordid"] .. discordId .. Config["discordtemplate"]["ipaddress"] .. playerIp .. "**"
            sendToDiscord(webhookUrl, message, setAccount, Config["color"][color])
        else
            print(PRE_ERROR .. " Not found discord webhook url for (" .. webhook .. ") please checking config.")
        end
    end
)
RegisterNetEvent("moon_discordlogs:sendChatToDiscord")
AddEventHandler("moon_discordlogs:sendChatToDiscord",function(webhook, message, source, color)
        if webhook == nil or webhook == "" or message == nil or message == "" or source == nil or source == "" or color == nil or color == "" then
            return false
        end
        local playerId = source
        local xPlayer = ESX.GetPlayerFromId(playerId)
        if xPlayer == nil then
            return false
        end
        local discordId = GetDiscordID(playerId)
        local playerIp = GetPlayerEndpoint(playerId)
        local webhookUrl = Config["webhook"][webhook]
        if not discordId then
            discordId = "N/A"
            discordName = "N/A"
        else
            discordId = string.gsub(discordId, "discord:", "")
            discordName = "<@" .. discordId .. ">"
        end
        if not playerIp then
            playerIp = "N/A"
        end
        if webhookUrl then
            local setAccount =
                Config["discordtemplate"]["name"] ..
                xPlayer.name ..
                    Config["discordtemplate"]["identifier"] ..
                        xPlayer.identifier ..
                            Config["discordtemplate"]["discord"] ..
                                discordName ..
                                    Config["discordtemplate"]["discordid"] .. discordId .. Config["discordtemplate"]["ipaddress"] .. playerIp .. "**"
            sendChatToDiscord(webhookUrl, message, xPlayer.name, setAccount, Config["color"][color], playerId)
        else
            print(PRE_ERROR .. " Not found discord webhook url for (" .. webhook .. ") please checking config.")
        end
    end
)
function sendToDiscord(webhook, message, account, color)
    local discord_image = Config["webhook_image"]
    local connect = {
        {
            ["color"] = color,
            ["title"] = message,
            ["description"] = account,
            ["footer"] = {["text"] = Config["discordtemplate"]["date"] .. os.date("%d/%m/%Y - %X")}
        }
    }
    if message == nil or message == "" or account == nil or account == "" then
        return false
    end
    if true then
        PerformHttpRequest(
            webhook,
            function(err, text, headers)
            end,
            "POST",
            json.encode({username = name, embeds = connect, avatar_url = discord_image}),
            {["Content-Type"] = "application/json"}
        )
    end
end
function sendChatToDiscord(webhook, message, name, account, color, source)
    local playerId = source
    local connect = {
        {
            ["color"] = color,
            ["title"] = message,
            ["description"] = account,
            ["footer"] = {["text"] = Config["discordtemplate"]["date"] .. os.date("%d/%m/%Y - %X")}
        }
    }
    if message == nil or message == "" or account == nil or account == "" then
        return false
    end
    if true then
        local discord_image = Config["webhook_image"]
        PerformHttpRequest(
            webhook,
            function(err, text, headers)
            end,
            "POST",
            json.encode(
                {username = name .. " [" .. playerId .. "]", embeds = connect, avatar_url = discord_image, tts = false}
            ),
            {["Content-Type"] = "application/json"}
        )
    end
end
function GetDiscordID(src)
    local discordId = nil
    for k, v in ipairs(GetPlayerIdentifiers(src)) do
        if string.sub(v, 1, string.len("discord:")) == "discord:" then
            discordId = v
            break
        end
    end
    if discordId == nil or discordId:sub(1, 8) ~= "discord:" then
        return false
    end
    return discordId
end

end
end