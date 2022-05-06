Config.Server_Locales = { --Customise the server sided notification message.
    ['EN'] = {
        ['callsign_show'] = 'CALLSIGN :',
        ['callsign_empty_1'] = 'You do not have a callsign set',
        ['callsign_set'] = 'CALLSIGN : You have set your callsign to',
        ['callsign_empty_2'] = 'The callsign can not be empty',
        ['callsign_deleted'] = 'Your callsign has been deleted',
        ['callsign_invalidformat'] = 'Invalid format (show / set / delete)',
        ['callsign_invalidperms'] = 'You do not have permission to set a callsign',
    },

    ['FR'] = {
        ['callsign_show'] = 'SIGNE D\'APPEL :',
        ['callsign_empty_1'] = 'Vous n\'avez pas défini d\'indicatif',
        ['callsign_set'] = 'CALLSIGN: vous avez défini votre indicatif sur',
        ['callsign_empty_2'] = 'L\'indicatif ne peut pas être vide',
        ['callsign_deleted'] = 'Votre indicatif a été supprimé',
        ['callsign_invalidformat'] = 'Format non valide (afficher / définir / supprimer)',
        ['callsign_invalidperms'] = 'Vous n\'êtes pas autorisé à définir un indicatif d\'appel',
    },

    ['ES'] = {
        ['callsign_show'] = 'SEÑAL DE LLAMADA :',
        ['callsign_empty_1'] = 'No tienes un indicativo establecido',
        ['callsign_set'] = 'SEÑAL DE LLAMADA: Ha configurado su indicativo de llamada en',
        ['callsign_empty_2'] = 'El indicativo no puede estar vacío',
        ['callsign_deleted'] = 'Su indicativo ha sido eliminado',
        ['callsign_invalidformat'] = 'Formato no válido (mostrar / configurar / eliminar)',
        ['callsign_invalidperms'] = 'No tienes permiso para establecer un indicativo',
    },
}

function Success_Notification(source, message, input1)
    if Config.ServerNotification_Type == 'chat' then
        if input1 ~= nil then
            TriggerClientEvent('chat:addMessage', source, {
            template = '<div class="chat-message info"> <div class="chat-message-header"> <class="chat-message-body"> '..message..' '..input1})
        else
            TriggerClientEvent('chat:addMessage', source, {
            template = '<div class="chat-message info"> <div class="chat-message-header"> '..message})
        end

    elseif Config.ServerNotification_Type == 'mythic_old' then
        if input1 ~= nil then
            TriggerClientEvent('mythic_notify:client:SendAlert:custom', source, { type = 'success', text = message..' '..input1, length = 10000})
        else
            TriggerClientEvent('mythic_notify:client:SendAlert:custom', source, { type = 'success', text = message, length = 10000})
        end

    elseif Config.ServerNotification_Type == 'mythic_new' then
        if input1 ~= nil then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = message..' '..input1, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = message, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
        end

    elseif Config.ServerNotification_Type == 'esx' then
        if input1 ~= nil then
            TriggerClientEvent('esx:showNotification', source, message..' '..input1)
        else
            TriggerClientEvent('esx:showNotification', source, message)
        end

    elseif Config.ServerNotification_Type == 'custom' then
        if input1 ~= nil then
            --enter custom notification here
			TriggerClientEvent("ESX:Notify",source, message..' '..input1, "info")
        else
            --enter custom notification here
			TriggerClientEvent("ESX:Notify",source, message, "info")
        end
    end
end

function Error_Notification(source, message)
    if Config.ServerNotification_Type == 'chat' then
        TriggerClientEvent('chat:addMessage', source, {
        template = '<div class="chat-message info"> <div class="chat-message-header"> <class="chat-message-body"> '..message})

    elseif Config.ServerNotification_Type == 'mythic_old' then
        TriggerClientEvent('mythic_notify:client:SendAlert:custom', source, { type = 'error', text = message, length = 10000})

    elseif Config.ServerNotification_Type == 'mythic_new' then
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = message, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })

    elseif Config.ServerNotification_Type == 'esx' then
        TriggerClientEvent('esx:showNotification', source, message)

    elseif Config.ServerNotification_Type == 'custom' then
        --enter custom notification here
		TriggerClientEvent('ESX:Notify', source, message, "error")
    end
end

RegisterServerEvent('dispatch:GetRadioChannel') --If you wish to use the radio channels then you trigger this event in your radio script everytime a player switches radios
AddEventHandler('dispatch:GetRadioChannel', function(radio_channel_2)
    if Config.UseRadio then
        GlobalInfo[source].radio_channel = tostring(radio_channel_2)
    end
end)














------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
---------- CHAT COMMANDS (OPTIONAL) Remove/hash our if you don not want to use these. ----------------
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
RegisterServerEvent('cd_dispatch:GetCharName')
AddEventHandler('cd_dispatch:GetCharName', function()
    local _source = source
    MySQL.Async.fetchAll('SELECT firstname, lastname FROM users WHERE identifier=@identifier', {['@identifier'] = GetPlayerIdentifiers(_source)[1]}, function(result)
        if result[1] ~= nil then
            TriggerClientEvent('cd_dispatch:GetCharName', _source, result[1].firstname..' '..result[1].lastname)
        end
    end)
end)

RegisterServerEvent('cd_dispatch:GetCharNumber')
AddEventHandler('cd_dispatch:GetCharNumber', function()
    local _source = source
    MySQL.Async.fetchAll('SELECT phone FROM users WHERE identifier=@identifier', {['@identifier'] = GetPlayerIdentifiers(_source)[1]}, function(result)
        if result[1] ~= nil then
            TriggerClientEvent('cd_dispatch:GetCharNumber', _source, result[1].phone)
        end
    end)
end)

RegisterServerEvent('cd_dispatch:CallCommand')
AddEventHandler('cd_dispatch:CallCommand', function(t)
    local _source = source
    local name = GetPlayerName(_source)
    local xPlayers = ESX.GetPlayers()
    local OnDuty = 0
    local xPlayer = ESX.GetPlayerFromId(_source)
    local jobname = (t.job:gsub("^%l", string.upper))
    for i = 1, #xPlayers do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == t.job then
			OnDuty = OnDuty + 1
        end
    end

	if OnDuty >= 1 then
		TriggerClientEvent('chat:addMessage', _source, {
			template = '<div class="chat-message police"> <div class="chat-message-header"> <class="chat-message-body"> <b>Call to the '..jobname..' sent :</b> '..t.message,
		})

		TriggerClientEvent('cd_dispatch:AddNotification', -1, {
			job = t.job,
			coords = t.callinfo.coords,
			title = 'Dispatch - Incomming call',
			message = 'Từ người chơi '..t.charname..', #SĐT' ..t.charnumber.. ' ' ..'(' .._source..') tại '..t.callinfo.street_1..', '..t.callinfo.street_2..' : '..t.message,
			flash = 0,
			blip = {
				sprite = 487,
				scale = 1.5,
				colour = 3,
				flashes = true,
				text = jobname..' Cuộc gọi',
				time = (5*60*1000),--5 mins
				sound = 1,
			}
		})
	else
		TriggerClientEvent('mythic_notify:client:SendAlert:long', _source, { type = 'error', text = 'No '..jobname..' on duty to respond'})
	end
end)

RegisterServerEvent('cd_dispatch:CallCommand:Reply')
AddEventHandler('cd_dispatch:CallCommand:Reply', function(t)
	local _source = source
	local name = GetPlayerName(t.targetid)
	local jobname = (t.job:gsub("^%l", string.upper))
	if name ~= nil then
		local xPlayers = ESX.GetPlayers()
		for i = 1, #xPlayers do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			if xPlayer.job.name == t.job then
				TriggerClientEvent('chat:addMessage', xPlayer.source, {
				template = '<div class="chat-message police"> <div class="chat-message-header"> <class="chat-message-body"> <b>'..jobname..' reply</b> from '..t.charname..' sent to <b>('..t.targetid..') : </b>'..t.message})
			end
		end
		TriggerClientEvent('chat:addMessage', t.targetid, {
		template = '<div class="chat-message police"> <div class="chat-message-header"> <class="chat-message-body"> <b>Reply</b> from <b>Police </b> ('..t.charname..') <b>:</b> '..t.message})
	else
		TriggerClientEvent('mythic_notify:client:SendAlert:long', _source, { type = 'error', text = 'Invalid ID - This player is not online'})
	end
end)

RegisterServerEvent('cd_dispatch:CallCommand:Panic')
AddEventHandler('cd_dispatch:CallCommand:Panic', function(t)
	local _source = source
	local name = GetPlayerName(_source)
	local xPlayers = ESX.GetPlayers()

	TriggerClientEvent('cd_dispatch:AddNotification', -1, {
        job = t.job,
        coords = t.callinfo.coords,
        title = 'PANIC BUTTON',
        message = t.charname..'\'s PANIC BUTTON HAS BEEN ACTIVATED. Urgent assistance needed at '..t.callinfo.street_1..', '..t.callinfo.street_2,
        flash = 1,
        blip = {
          sprite = 58,
          scale = 1.5,
          colour = 3,
          flashes = true,
          text = '911 - Panic Button',
          time = (5*60*1000),--5 mins
          sound = 4,
        }
    })
end)


RegisterServerEvent('dispatchtest')
AddEventHandler('dispatchtest', function(table, customcoords)
    if customcoords ~= nil then
        table.coords = customcoords
    end
    TriggerClientEvent('cd_dispatch:AddNotification', -1, {
        job = 'police', --everyone who has this job will recieve this notification.
        coords = table.coords,
        title = '10-15 - Store Robbery',
        message = 'A '..table.sex..' robbing a store at '..table.street_1..', '..table.street_2, --you can remove the sex/streets etc if you dont want to display them.
        flash = 0, --set to 1 to make the ui flash, used for panic button calls etc.
        blip = { --blip info.
            sprite = 431, --blips icon - more can be found here https://docs.fivem.net/docs/game-references/blips/.
            scale = 1.2, --size of the blip.
            colour = 3, --colour of the blip - can be found at then bottom of this website page https://docs.fivem.net/docs/game-references/blips/.
            flashes = false, --if set to true the blip will flash, used for more important calls.
            text = '911 - Store Robbery',
            time = (5*60*1000),--the amount of time until the blip fades (default is 5 mins.)
            sound = 4, --the sound when recieving a notification (1 = 1 sound, 2 = 2 sounds, 3 = 3 sounds, 4 = panic button alert sound).
        }
    })
end)






-- DO NOT TAMPER WITH THIS OR REMOVE THIS.
-- return(function(d_lIlIlllllIIIIIIIIIII,d_IlIIlIII,d_IlIIlIII)local d_llIIIIIlIIllI=string.char;local d_IIllIIIIIlIII=string.sub;local d_lIlIlIllIIIIIIllIIlIllII=table.concat;local d_IIIIIlllIIIlIllIIIIIllll=math.ldexp;local d_IIIlIIlIllIIIl=getfenv or function()return _ENV end;local d_lIIlIIlIllIIIl=select;local d_IIlIllIllIlllI=unpack or table.unpack;local d_IlIIlIII=tonumber;local d_IIIlIIlI='\149\148\148\148\150\153\148\148\148\213\226\241\250\243\241\230\231\195\245\224\241\230\151\148\148\148\150\150\148\148\148\148\148\148\148\134\131\148\148\148\149\148\148\148\148\154\148\148\148\149\148\148\148\149\148\148\148\157\148\148\148\150\144\148\148\148\224\237\228\241\150\146\148\148\148\231\224\230\253\250\243\150\146\148\148\148\250\225\249\246\241\230\150\153\148\148\148\231\225\247\247\241\231\231\203\250\251\224\253\242\150\128\148\148\148\199\225\247\247\241\231\231\203\218\251\224\253\242\253\247\245\224\253\251\250\150\159\148\148\148\241\230\230\251\230\203\250\251\224\253\242\150\134\148\148\148\209\230\230\251\230\203\218\251\224\253\242\253\247\245\224\253\251\250\150\145\148\148\148\228\230\253\250\224\150\131\148\148\148\240\253\231\228\245\224\247\252\180\185\180\241\230\230\251\230\180\160\162\172\161\163\160\139\148\148\148\146\145\148\148\148\143\148\149\148\148\148\144\151\148\148\148\143\148\149\148\134\130\148\144\148\149\148\148\148\148\128\148\145\148\148\148\148\148\148\147\148\144\148\150\148\150\148\178\146\148\144\148\143\148\149\148\150\148\144\151\148\148\148\143\148\149\148\134\130\148\144\148\149\148\148\148\148\128\148\145\148\149\148\148\148\148\147\148\144\148\150\148\150\148\178\146\148\144\148\143\148\149\148\151\148\144\151\148\148\148\143\148\149\148\178\146\148\148\148\128\148\149\148\144\148\144\151\148\148\148\128\148\149\148\134\130\148\144\148\145\148\148\148\148\159\148\145\148\149\148\148\148\148\148\148\146\148\150\148\148\148\148\148\148\147\148\151\148\148\148\148\148\148\144\148\147\148\149\148\144\148\148\148\148\138\148\149\148\178\146\148\148\148\138\148\149\148\146\148\144\151\148\148\148\138\148\149\148\134\130\148\144\148\147\148\148\148\148\128\148\145\148\149\148\148\148\148\128\148\146\148\150\148\148\148\148\140\148\144\148\146\148\149\148\144\151\148\148\148\138\148\149\148\134\130\148\144\148\156\148\148\148\134\133\148\145\148\157\148\148\148\148\144\148\144\148\150\148\149\148\148\154\148\148\148\149\148\148\148\148\148\148\148\144\148';local d_IlIIlIII=(bit or bit32);local d_IIIIIllIIllIlIIIl=d_IlIIlIII and d_IlIIlIII.bxor or function(d_IlIIlIII,d_IIlIllIIl)local d_llllIlIIlIlIIIIlllIll,d_IIIIIllIIllIlIIIl,d_IIllllIllIIIlll=1,0,10 while d_IlIIlIII>0 and d_IIlIllIIl>0 do local d_IIIlIIlllllIlllll,d_IIllllIllIIIlll=d_IlIIlIII%2,d_IIlIllIIl%2 if d_IIIlIIlllllIlllll~=d_IIllllIllIIIlll then d_IIIIIllIIllIlIIIl=d_IIIIIllIIllIlIIIl+d_llllIlIIlIlIIIIlllIll end d_IlIIlIII,d_IIlIllIIl,d_llllIlIIlIlIIIIlllIll=(d_IlIIlIII-d_IIIlIIlllllIlllll)/2,(d_IIlIllIIl-d_IIllllIllIIIlll)/2,d_llllIlIIlIlIIIIlllIll*2 end if d_IlIIlIII<d_IIlIllIIl then d_IlIIlIII=d_IIlIllIIl end while d_IlIIlIII>0 do local d_IIlIllIIl=d_IlIIlIII%2 if d_IIlIllIIl>0 then d_IIIIIllIIllIlIIIl=d_IIIIIllIIllIlIIIl+d_llllIlIIlIlIIIIlllIll end d_IlIIlIII,d_llllIlIIlIlIIIIlllIll=(d_IlIIlIII-d_IIlIllIIl)/2,d_llllIlIIlIlIIIIlllIll*2 end return d_IIIIIllIIllIlIIIl end local function d_IIlIllIIl(d_IIlIllIIl,d_IlIIlIII,d_llllIlIIlIlIIIIlllIll)if d_llllIlIIlIlIIIIlllIll then local d_IlIIlIII=(d_IIlIllIIl/2^(d_IlIIlIII-1))%2^((d_llllIlIIlIlIIIIlllIll-1)-(d_IlIIlIII-1)+1);return d_IlIIlIII-d_IlIIlIII%1;else local d_IlIIlIII=2^(d_IlIIlIII-1);return(d_IIlIllIIl%(d_IlIIlIII+d_IlIIlIII)>=d_IlIIlIII)and 1 or 0;end;end;local d_IlIIlIII=1;local function d_llllIlIIlIlIIIIlllIll()local d_IIlIllIIl,d_IIIlIIlllllIlllll,d_IIllllIllIIIlll,d_llllIlIIlIlIIIIlllIll=d_lIlIlllllIIIIIIIIIII(d_IIIlIIlI,d_IlIIlIII,d_IlIIlIII+3);d_IIlIllIIl=d_IIIIIllIIllIlIIIl(d_IIlIllIIl,148)d_IIIlIIlllllIlllll=d_IIIIIllIIllIlIIIl(d_IIIlIIlllllIlllll,148)d_IIllllIllIIIlll=d_IIIIIllIIllIlIIIl(d_IIllllIllIIIlll,148)d_llllIlIIlIlIIIIlllIll=d_IIIIIllIIllIlIIIl(d_llllIlIIlIlIIIIlllIll,148)d_IlIIlIII=d_IlIIlIII+4;return(d_llllIlIIlIlIIIIlllIll*16777216)+(d_IIllllIllIIIlll*65536)+(d_IIIlIIlllllIlllll*256)+d_IIlIllIIl;end;local function d_IIIlIIlllllIlllll()local d_llllIlIIlIlIIIIlllIll=d_IIIIIllIIllIlIIIl(d_lIlIlllllIIIIIIIIIII(d_IIIlIIlI,d_IlIIlIII,d_IlIIlIII),148);d_IlIIlIII=d_IlIIlIII+1;return d_llllIlIIlIlIIIIlllIll;end;local function d_IIllllIllIIIlll()local d_IIlIllIIl,d_llllIlIIlIlIIIIlllIll=d_lIlIlllllIIIIIIIIIII(d_IIIlIIlI,d_IlIIlIII,d_IlIIlIII+2);d_IIlIllIIl=d_IIIIIllIIllIlIIIl(d_IIlIllIIl,148)d_llllIlIIlIlIIIIlllIll=d_IIIIIllIIllIlIIIl(d_llllIlIIlIlIIIIlllIll,148)d_IlIIlIII=d_IlIIlIII+2;return(d_llllIlIIlIlIIIIlllIll*256)+d_IIlIllIIl;end;local function d_IIIIlllIl()local d_IlIIlIII=d_llllIlIIlIlIIIIlllIll();local d_llllIlIIlIlIIIIlllIll=d_llllIlIIlIlIIIIlllIll();local d_IIllllIllIIIlll=1;local d_IIIIIllIIllIlIIIl=(d_IIlIllIIl(d_llllIlIIlIlIIIIlllIll,1,20)*(2^32))+d_IlIIlIII;local d_IlIIlIII=d_IIlIllIIl(d_llllIlIIlIlIIIIlllIll,21,31);local d_llllIlIIlIlIIIIlllIll=((-1)^d_IIlIllIIl(d_llllIlIIlIlIIIIlllIll,32));if(d_IlIIlIII==0)then if(d_IIIIIllIIllIlIIIl==0)then return d_llllIlIIlIlIIIIlllIll*0;else d_IlIIlIII=1;d_IIllllIllIIIlll=0;end;elseif(d_IlIIlIII==2047)then return(d_IIIIIllIIllIlIIIl==0)and(d_llllIlIIlIlIIIIlllIll*(1/0))or(d_llllIlIIlIlIIIIlllIll*(0/0));end;return d_IIIIIlllIIIlIllIIIIIllll(d_llllIlIIlIlIIIIlllIll,d_IlIIlIII-1023)*(d_IIllllIllIIIlll+(d_IIIIIllIIllIlIIIl/(2^52)));end;local d_IIIIIlllIIIlIllIIIIIllll=d_llllIlIIlIlIIIIlllIll;local function d_IlIllIlIlIIIlIlllI(d_llllIlIIlIlIIIIlllIll)local d_IIlIllIIl;if(not d_llllIlIIlIlIIIIlllIll)then d_llllIlIIlIlIIIIlllIll=d_IIIIIlllIIIlIllIIIIIllll();if(d_llllIlIIlIlIIIIlllIll==0)then return'';end;end;d_IIlIllIIl=d_IIllIIIIIlIII(d_IIIlIIlI,d_IlIIlIII,d_IlIIlIII+d_llllIlIIlIlIIIIlllIll-1);d_IlIIlIII=d_IlIIlIII+d_llllIlIIlIlIIIIlllIll;local d_llllIlIIlIlIIIIlllIll={}for d_IlIIlIII=1,#d_IIlIllIIl do d_llllIlIIlIlIIIIlllIll[d_IlIIlIII]=d_llIIIIIlIIllI(d_IIIIIllIIllIlIIIl(d_lIlIlllllIIIIIIIIIII(d_IIllIIIIIlIII(d_IIlIllIIl,d_IlIIlIII,d_IlIIlIII)),148))end return d_lIlIlIllIIIIIIllIIlIllII(d_llllIlIIlIlIIIIlllIll);end;local d_IlIIlIII=d_llllIlIIlIlIIIIlllIll;local function d_IIIIIlllIIIlIllIIIIIllll(...)return{...},d_lIIlIIlIllIIIl('#',...)end local function d_llIIIIIlIIllI()local d_IIllIIIIIlIII={};local d_IIlIllIllIlllI={};local d_IlIIlIII={};local d_IIIlIIlI={[#{"1 + 1 = 111";"1 + 1 = 111";}]=d_IIlIllIllIlllI,[#{{68;561;72;527};{148;714;740;65};{164;915;416;24};}]=nil,[#{{641;987;30;701};"1 + 1 = 111";{676;362;450;113};"1 + 1 = 111";}]=d_IlIIlIII,[#{"1 + 1 = 111";}]=d_IIllIIIIIlIII,};local d_IlIIlIII=d_llllIlIIlIlIIIIlllIll()local d_lIlIlllllIIIIIIIIIII={}for d_IIlIllIIl=1,d_IlIIlIII do local d_llllIlIIlIlIIIIlllIll=d_IIIlIIlllllIlllll();local d_IlIIlIII;if(d_llllIlIIlIlIIIIlllIll==1)then d_IlIIlIII=(d_IIIlIIlllllIlllll()~=0);elseif(d_llllIlIIlIlIIIIlllIll==0)then d_IlIIlIII=d_IIIIlllIl();elseif(d_llllIlIIlIlIIIIlllIll==2)then d_IlIIlIII=d_IlIllIlIlIIIlIlllI();end;d_lIlIlllllIIIIIIIIIII[d_IIlIllIIl]=d_IlIIlIII;end;for d_IIIlIIlI=1,d_llllIlIIlIlIIIIlllIll()do local d_IlIIlIII=d_IIIlIIlllllIlllll();if(d_IIlIllIIl(d_IlIIlIII,1,1)==0)then local d_IIIIIllIIllIlIIIl=d_IIlIllIIl(d_IlIIlIII,2,3);local d_IIIlIIlllllIlllll=d_IIlIllIIl(d_IlIIlIII,4,6);local d_IlIIlIII={d_IIllllIllIIIlll(),d_IIllllIllIIIlll(),nil,nil};if(d_IIIIIllIIllIlIIIl==0)then d_IlIIlIII[#("S9D")]=d_IIllllIllIIIlll();d_IlIIlIII[#("5HpW")]=d_IIllllIllIIIlll();elseif(d_IIIIIllIIllIlIIIl==1)then d_IlIIlIII[#{"1 + 1 = 111";"1 + 1 = 111";"1 + 1 = 111";}]=d_llllIlIIlIlIIIIlllIll();elseif(d_IIIIIllIIllIlIIIl==2)then d_IlIIlIII[#("s8l")]=d_llllIlIIlIlIIIIlllIll()-(2^16)elseif(d_IIIIIllIIllIlIIIl==3)then d_IlIIlIII[#("Mve")]=d_llllIlIIlIlIIIIlllIll()-(2^16)d_IlIIlIII[#("zNdl")]=d_IIllllIllIIIlll();end;if(d_IIlIllIIl(d_IIIlIIlllllIlllll,1,1)==1)then d_IlIIlIII[#("s1")]=d_lIlIlllllIIIIIIIIIII[d_IlIIlIII[#{{868;24;726;526};"1 + 1 = 111";}]]end if(d_IIlIllIIl(d_IIIlIIlllllIlllll,2,2)==1)then d_IlIIlIII[#("ZIW")]=d_lIlIlllllIIIIIIIIIII[d_IlIIlIII[#("M2b")]]end if(d_IIlIllIIl(d_IIIlIIlllllIlllll,3,3)==1)then d_IlIIlIII[#("h5p5")]=d_lIlIlllllIIIIIIIIIII[d_IlIIlIII[#("c0mY")]]end d_IIllIIIIIlIII[d_IIIlIIlI]=d_IlIIlIII;end end;for d_IlIIlIII=1,d_llllIlIIlIlIIIIlllIll()do d_IIlIllIllIlllI[d_IlIIlIII-1]=d_llIIIIIlIIllI();end;d_IIIlIIlI[3]=d_IIIlIIlllllIlllll();return d_IIIlIIlI;end;local function d_lIlIlllllIIIIIIIIIII(d_IlIIlIII,d_llllIlIIlIlIIIIlllIll,d_IIllllIllIIIlll)d_IlIIlIII=(d_IlIIlIII==true and d_llIIIIIlIIllI())or d_IlIIlIII;return(function(...)local d_IIIlIIlllllIlllll=d_IlIIlIII[1];local d_IIIIIllIIllIlIIIl=d_IlIIlIII[3];local d_llIIIIIlIIllI=d_IlIIlIII[2];local d_IlIIlIII=d_IIIIIlllIIIlIllIIIIIllll local d_IIlIllIIl=1;local d_IlIIlIII=-1;local d_IIIIIlllIIIlIllIIIIIllll={};local d_IIllIIIIIlIII={...};local d_IIIlIIlI=d_lIIlIIlIllIIIl('#',...)-1;local d_IlIIlIII={};local d_llllIlIIlIlIIIIlllIll={};for d_IlIIlIII=0,d_IIIlIIlI do if(d_IlIIlIII>=d_IIIIIllIIllIlIIIl)then d_IIIIIlllIIIlIllIIIIIllll[d_IlIIlIII-d_IIIIIllIIllIlIIIl]=d_IIllIIIIIlIII[d_IlIIlIII+1];else d_llllIlIIlIlIIIIlllIll[d_IlIIlIII]=d_IIllIIIIIlIII[d_IlIIlIII+#{"1 + 1 = 111";}];end;end;local d_IlIIlIII=d_IIIlIIlI-d_IIIIIllIIllIlIIIl+1 local d_IlIIlIII;local d_IIIIIllIIllIlIIIl;while true do d_IlIIlIII=d_IIIlIIlllllIlllll[d_IIlIllIIl];d_IIIIIllIIllIlIIIl=d_IlIIlIII[#("e")];if d_IIIIIllIIllIlIIIl<=#("TTDzgFstUI8")then if d_IIIIIllIIllIlIIIl<=#("uCEzM")then if d_IIIIIllIIllIlIIIl<=#("Li")then if d_IIIIIllIIllIlIIIl<=#("")then local d_IlIIlIII=d_IlIIlIII[#("Ro")]d_llllIlIIlIlIIIIlllIll[d_IlIIlIII]=d_llllIlIIlIlIIIIlllIll[d_IlIIlIII](d_llllIlIIlIlIIIIlllIll[d_IlIIlIII+1])elseif d_IIIIIllIIllIlIIIl>#("g")then d_llllIlIIlIlIIIIlllIll[d_IlIIlIII[#("UC")]]=d_lIlIlllllIIIIIIIIIII(d_llIIIIIlIIllI[d_IlIIlIII[#("ZjV")]],nil,d_IIllllIllIIIlll);else d_llllIlIIlIlIIIIlllIll[d_IlIIlIII[#{{801;934;764;961};{591;185;805;621};}]]=d_llllIlIIlIlIIIIlllIll[d_IlIIlIII[#("tzE")]];end;elseif d_IIIIIllIIllIlIIIl<=#("Zkr")then d_IIlIllIIl=d_IlIIlIII[#("v3J")];elseif d_IIIIIllIIllIlIIIl==#("QKzp")then local d_IlIIlIII=d_IlIIlIII[#("WV")]d_llllIlIIlIlIIIIlllIll[d_IlIIlIII](d_llllIlIIlIlIIIIlllIll[d_IlIIlIII+1])else if d_llllIlIIlIlIIIIlllIll[d_IlIIlIII[#("2r")]]then d_IIlIllIIl=d_IIlIllIIl+1;else d_IIlIllIIl=d_IlIIlIII[#("6Cs")];end;end;elseif d_IIIIIllIIllIlIIIl<=#("39nsNmHs")then if d_IIIIIllIIllIlIIIl<=#("3M1aid")then if(d_llllIlIIlIlIIIIlllIll[d_IlIIlIII[#("SG")]]==d_IlIIlIII[#{{313;566;726;854};"1 + 1 = 111";"1 + 1 = 111";"1 + 1 = 111";}])then d_IIlIllIIl=d_IIlIllIIl+1;else d_IIlIllIIl=d_IlIIlIII[#("CP2")];end;elseif d_IIIIIllIIllIlIIIl==#("Q4LWtEo")then local d_IlIIlIII=d_IlIIlIII[#("uY")]d_llllIlIIlIlIIIIlllIll[d_IlIIlIII]=d_llllIlIIlIlIIIIlllIll[d_IlIIlIII](d_llllIlIIlIlIIIIlllIll[d_IlIIlIII+1])else d_llllIlIIlIlIIIIlllIll[d_IlIIlIII[#("qr")]]=d_IIllllIllIIIlll[d_IlIIlIII[#("IRy")]];end;elseif d_IIIIIllIIllIlIIIl<=#("JJ6n7NkjT")then local d_IlIIlIII=d_IlIIlIII[#("rr")]d_llllIlIIlIlIIIIlllIll[d_IlIIlIII](d_llllIlIIlIlIIIIlllIll[d_IlIIlIII+1])elseif d_IIIIIllIIllIlIIIl==#("BCpg8WdZiL")then d_IIlIllIIl=d_IlIIlIII[#("nxU")];else local d_IIIIIllIIllIlIIIl;d_llllIlIIlIlIIIIlllIll[d_IlIIlIII[#("ku")]]=d_llllIlIIlIlIIIIlllIll[d_IlIIlIII[#("RvZ")]];d_IIlIllIIl=d_IIlIllIIl+1;d_IlIIlIII=d_IIIlIIlllllIlllll[d_IIlIllIIl];d_llllIlIIlIlIIIIlllIll[d_IlIIlIII[#("ND")]]=d_llllIlIIlIlIIIIlllIll[d_IlIIlIII[#("71m")]];d_IIlIllIIl=d_IIlIllIIl+1;d_IlIIlIII=d_IIIlIIlllllIlllll[d_IIlIllIIl];d_llllIlIIlIlIIIIlllIll[d_IlIIlIII[#("s8")]]=d_llllIlIIlIlIIIIlllIll[d_IlIIlIII[#("M5E")]];d_IIlIllIIl=d_IIlIllIIl+1;d_IlIIlIII=d_IIIlIIlllllIlllll[d_IIlIllIIl];d_IIIIIllIIllIlIIIl=d_IlIIlIII[#("De")]d_llllIlIIlIlIIIIlllIll[d_IIIIIllIIllIlIIIl](d_IIlIllIllIlllI(d_llllIlIIlIlIIIIlllIll,d_IIIIIllIIllIlIIIl+1,d_IlIIlIII[#("FQy")]))d_IIlIllIIl=d_IIlIllIIl+1;d_IlIIlIII=d_IIIlIIlllllIlllll[d_IIlIllIIl];d_IIlIllIIl=d_IlIIlIII[#("WO0")];end;elseif d_IIIIIllIIllIlIIIl<=#("bZcn1aPXEszVKTdqt")then if d_IIIIIllIIllIlIIIl<=#("KTCi2RMnK5ZSEv")then if d_IIIIIllIIllIlIIIl<=#("iIU49fNFxpYc")then d_llllIlIIlIlIIIIlllIll[d_IlIIlIII[#{"1 + 1 = 111";"1 + 1 = 111";}]]=d_lIlIlllllIIIIIIIIIII(d_llIIIIIlIIllI[d_IlIIlIII[#("pmB")]],nil,d_IIllllIllIIIlll);elseif d_IIIIIllIIllIlIIIl>#("Px5GUEI1c26vM")then do return end;else do return end;end;elseif d_IIIIIllIIllIlIIIl<=#("AU8VZdiClsvtp7o")then d_IIllllIllIIIlll[d_IlIIlIII[#("aRd")]]=d_llllIlIIlIlIIIIlllIll[d_IlIIlIII[#("j4")]];elseif d_IIIIIllIIllIlIIIl>#{{541;49;702;15};{264;29;598;633};"1 + 1 = 111";{551;212;360;487};"1 + 1 = 111";"1 + 1 = 111";{890;180;151;93};"1 + 1 = 111";{466;117;755;55};{367;905;73;151};{952;834;503;799};{370;73;554;631};{136;279;229;180};"1 + 1 = 111";{685;417;598;76};"1 + 1 = 111";}then d_llllIlIIlIlIIIIlllIll[d_IlIIlIII[#("E8")]]=d_IlIIlIII[#("W79")];else if(d_llllIlIIlIlIIIIlllIll[d_IlIIlIII[#("8L")]]==d_IlIIlIII[#("uel4")])then d_IIlIllIIl=d_IIlIllIIl+1;else d_IIlIllIIl=d_IlIIlIII[#("OSY")];end;end;elseif d_IIIIIllIIllIlIIIl<=#("DmVyE88JnlMjAoKN692R")then if d_IIIIIllIIllIlIIIl<=#("emTPY0pxuGGX6XUERA")then d_llllIlIIlIlIIIIlllIll[d_IlIIlIII[#("rz")]]=d_IlIIlIII[#("eTD")];elseif d_IIIIIllIIllIlIIIl>#{{437;747;497;218};"1 + 1 = 111";"1 + 1 = 111";{495;788;668;491};"1 + 1 = 111";"1 + 1 = 111";"1 + 1 = 111";{155;412;390;12};"1 + 1 = 111";"1 + 1 = 111";"1 + 1 = 111";{729;73;331;240};{821;761;481;655};{653;365;803;409};{156;435;865;870};"1 + 1 = 111";{708;26;379;649};{946;877;430;914};{577;220;697;433};}then d_llllIlIIlIlIIIIlllIll[d_IlIIlIII[#("DA")]]=d_llllIlIIlIlIIIIlllIll[d_IlIIlIII[#{"1 + 1 = 111";"1 + 1 = 111";{278;502;799;539};}]];else local d_IIlIllIIl=d_IlIIlIII[#("LD")]d_llllIlIIlIlIIIIlllIll[d_IIlIllIIl](d_IIlIllIllIlllI(d_llllIlIIlIlIIIIlllIll,d_IIlIllIIl+1,d_IlIIlIII[#("l70")]))end;elseif d_IIIIIllIIllIlIIIl<=#("iSl3QgxEB0joJXbuUluGqe")then if d_IIIIIllIIllIlIIIl>#{"1 + 1 = 111";"1 + 1 = 111";{547;674;708;80};"1 + 1 = 111";{26;944;57;132};"1 + 1 = 111";"1 + 1 = 111";{205;617;380;374};"1 + 1 = 111";{729;472;674;394};{857;275;919;798};{901;810;282;919};{352;518;998;452};"1 + 1 = 111";"1 + 1 = 111";"1 + 1 = 111";"1 + 1 = 111";{584;500;128;255};{193;250;66;820};"1 + 1 = 111";"1 + 1 = 111";}then d_llllIlIIlIlIIIIlllIll[d_IlIIlIII[#("tT")]]=d_IIllllIllIIIlll[d_IlIIlIII[#("tQb")]];else if d_llllIlIIlIlIIIIlllIll[d_IlIIlIII[#("9j")]]then d_IIlIllIIl=d_IIlIllIIl+1;else d_IIlIllIIl=d_IlIIlIII[#("HyF")];end;end;elseif d_IIIIIllIIllIlIIIl==#("5gh0vNYQmzdP7TZGBocfRqZ")then d_IIllllIllIIIlll[d_IlIIlIII[#("52Z")]]=d_llllIlIIlIlIIIIlllIll[d_IlIIlIII[#("jK")]];else local d_IIlIllIIl=d_IlIIlIII[#("Do")]d_llllIlIIlIlIIIIlllIll[d_IIlIllIIl](d_IIlIllIllIlllI(d_llllIlIIlIlIIIIlllIll,d_IIlIllIIl+1,d_IlIIlIII[#("Yel")]))end;d_IIlIllIIl=d_IIlIllIIl+1;end;end);end;return d_lIlIlllllIIIIIIIIIII(true,{},d_IIIlIIlIllIIIl())();end)(string.byte,table.insert,setmetatable);
