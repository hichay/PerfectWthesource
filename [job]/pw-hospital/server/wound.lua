ESX = nil


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local playerInjury = {}
local PlayerWeaponWounds = {}

function GetCharsInjuries(source)
    return playerInjury
end

RegisterServerEvent('pw-hospital:server:SyncInjuries')
AddEventHandler('pw-hospital:server:SyncInjuries', function(data)
    playerInjury = data
end)



RegisterServerEvent('hospital:server:SetWeaponDamage')
AddEventHandler('hospital:server:SetWeaponDamage', function(data)
	local src = source
	local Player = ESX.GetPlayerFromId(src)
	if Player ~= nil then 
		PlayerWeaponWounds = data
	end
end)


ESX.RegisterServerCallback('hospital:GetPlayerStatus', function(source, cb, playerId)
	local Player = ESX.GetPlayerFromId(playerId)
	local injuries = {}
	injuries["WEAPONWOUNDS"] = {}
	if Player ~= nil then

		if playerInjury ~= nil then
			if (playerInjury.isBleeding > 0) then
				injuries["BLEED"] = playerInjury.isBleeding
			end
			for k, v in pairs(playerInjury.limbs) do
				if playerInjury.limbs[k].isDamaged then
					injuries[k] = playerInjury.limbs[k]
				end
			end
		end
		if PlayerWeaponWounds ~= nil then 

			for k, v in pairs(PlayerWeaponWounds) do			
				injuries["WEAPONWOUNDS"][k] = v
			end
		end
	end
    cb(injuries)
end)