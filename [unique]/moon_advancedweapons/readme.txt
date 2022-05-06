1: Go to your ESX folder (es_extended) path common/functions.lua then add this

ESX.GetWeaponComponentByHash = function(weaponName, weaponComponentHash)
	weaponName = string.upper(weaponName)
	local weapons = ESX.GetWeaponList()

	for i=1, #weapons, 1 do
		if weapons[i].name == weaponName then
			for j=1, #weapons[i].components, 1 do
				if weapons[i].components[j].hash == weaponComponentHash then
					return weapons[i].components[j]
				end
			end
		end
	end
end



Event to trigger Open:
moon_advancedweapons:showEquipment