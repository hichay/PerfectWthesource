-- - - - - - - - - - - - - -
-- Script Variables:
-- - - - - - - - - - - - - -
local isTorsoOn = true
local isPantsOn = true
local isShoesOn = true
local isHelmetOn = true
local isVestOn = true
local isChainOn = true
local isMaskOn = true
local isGlassesOn = true
local isBagOn = true
local isEarOn = true

-- - - - - - - - - - - - - -
-- ESX Init:
-- - - - - - - - - - - - - -
local ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	Citizen.Wait(100)
	end
end)

-- - - - - - - - - - - - - -
-- Functions:
-- - - - - - - - - - - - - -
function checkIfIsMale()
	local plySkin
	TriggerEvent('skinchanger:getSkin', function(skin)
		plySkin = skin
	end)

	if plySkin.sex == 0 then
		return true
	else
		return false
	end
end

-- Torso:
RegisterNetEvent('esx_clothes_lgrp:Torso')
AddEventHandler('esx_clothes_lgrp:Torso', function()
	local maleSkin = {
		['tshirt_1'] = 15, ['tshirt_2'] = 0,
		['torso_1'] = 15, ['torso_2'] = 0,
		['arms'] = 15
	}
	local notSoMaleSkin = {
		['tshirt_1'] = 14, ['tshirt_2'] = 0,
		['torso_1'] = 15, ['torso_2'] = 0,
		['arms'] = 15
	}

	if checkIfIsMale() == true then
		if isTorsoOn == true then
			TriggerEvent('skinchanger:getSkin', function(skin)
				TriggerEvent('skinchanger:loadClothes', skin, maleSkin)
			end)
			isTorsoOn = false
		else
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', {
					sex = 0,
					tshirt_1 = skin.tshirt_1, tshirt_2 = skin.tshirt_2,
					torso_1 = skin.torso_1, torso_2 = skin.torso_2,
					arms = skin.arms
				})
			end)
			isTorsoOn = true
		end
	else
		if isTorsoOn == true then
			TriggerEvent('skinchanger:getSkin', function(skin)
				TriggerEvent('skinchanger:loadClothes', skin, notSoMaleSkin)
			end)
			isTorsoOn = false
		else
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', {
					sex = 1,
					tshirt_1 = skin.tshirt_1, tshirt_2 = skin.tshirt_2,
					torso_1 = skin.torso_1, torso_2 = skin.torso_2,
					arms = skin.arms
				})
			end)
			isTorsoOn = true
		end
	end

end)

-- Pants:
RegisterNetEvent('esx_clothes_lgrp:Pants')
AddEventHandler('esx_clothes_lgrp:Pants', function()
	local maleSkin = {
		['pants_1'] = 21, ['pants_2'] = 0
	}
	local notSoMaleSkin = {
		['pants_1'] = 15, ['pants_2'] = 0
	}

	if checkIfIsMale() == true then
		if isPantsOn == true then
			TriggerEvent('skinchanger:getSkin', function(skin)
				TriggerEvent('skinchanger:loadClothes', skin, maleSkin)
			end)
			isPantsOn = false
		else
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', {
					sex = 0,
					pants_1 = skin.pants_1, pants_2 = skin.pants_2
				})
			end)
			isPantsOn = true
		end
	else
		if isPantsOn == true then
			TriggerEvent('skinchanger:getSkin', function(skin)
				TriggerEvent('skinchanger:loadClothes', skin, notSoMaleSkin)
			end)
			isPantsOn = false
		else
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', {
					sex = 1,
					pants_1 = skin.pants_1, pants_2 = skin.pants_2
				})
			end)
			isPantsOn = true
		end
	end

end)

-- Shoes
RegisterNetEvent('esx_clothes_lgrp:Shoes')
AddEventHandler('esx_clothes_lgrp:Shoes', function()
	local maleSkin = {
		['shoes_1'] = 34, ['shoes_2'] = 0
	}
	local notSoMaleSkin = {
		['shoes_1'] = 35, ['shoes_2'] = 0
	}

	if checkIfIsMale() == true then
		if isShoesOn == true then
			TriggerEvent('skinchanger:getSkin', function(skin)
				TriggerEvent('skinchanger:loadClothes', skin, maleSkin)
			end)
			isShoesOn = false
		else
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', {
					sex = 0,
					shoes_1 = skin.shoes_1, shoes_2 = skin.shoes_2
				})
			end)
			isShoesOn = true
		end
	else
		if isShoesOn == true then
			TriggerEvent('skinchanger:getSkin', function(skin)
				TriggerEvent('skinchanger:loadClothes', skin, notSoMaleSkin)
			end)
			isShoesOn = false
		else
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', {
					sex = 1,
					shoes_1 = skin.shoes_1, shoes_2 = skin.shoes_2
				})
			end)
			isShoesOn = true
		end
	end

end)

-- Helmet
RegisterNetEvent('esx_clothes_lgrp:Helmet')
AddEventHandler('esx_clothes_lgrp:Helmet', function()
	local maleSkin = {
		['helmet_1'] = -1, ['helmet_2'] = 0
	}
	local notSoMaleSkin = {
		['helmet_1'] = -1, ['helmet_2'] = 0
	}

	if checkIfIsMale() == true then
		if isHelmetOn == true then
			TriggerEvent('skinchanger:getSkin', function(skin)
				TriggerEvent('skinchanger:loadClothes', skin, maleSkin)
			end)
			isHelmetOn = false
		else
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', {
					sex = 0,
					helmet_1 = skin.helmet_1, helmet_2 = skin.helmet_2
				})
			end)
			isHelmetOn = true
		end
	else
		if isHelmetOn == true then
			TriggerEvent('skinchanger:getSkin', function(skin)
				TriggerEvent('skinchanger:loadClothes', skin, notSoMaleSkin)
			end)
			isHelmetOn = false
		else
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', {
					sex = 1,
					helmet_1 = skin.helmet_1, helmet_2 = skin.helmet_2
				})
			end)
			isHelmetOn = true
		end
	end

end)

-- Vest
RegisterNetEvent('esx_clothes_lgrp:Vest')
AddEventHandler('esx_clothes_lgrp:Vest', function()
	local maleSkin = {
		['bproof_1'] = 0, ['bproof_2'] = 0
	}
	local notSoMaleSkin = {
		['bproof_1'] = 0, ['bproof_2'] = 0
	}

	if checkIfIsMale() == true then
		if isVestOn == true then
			TriggerEvent('skinchanger:getSkin', function(skin)
				TriggerEvent('skinchanger:loadClothes', skin, maleSkin)
			end)
			isVestOn = false
		else
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', {
					sex = 0,
					bproof_1 = skin.bproof_1, bproof_2 = skin.bproof_2
				})
			end)
			isVestOn = true
		end
	else
		if isVestOn == true then
			TriggerEvent('skinchanger:getSkin', function(skin)
				TriggerEvent('skinchanger:loadClothes', skin, notSoMaleSkin)
			end)
			isVestOn = false
		else
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', {
					sex = 1,
					bproof_1 = skin.bproof_1, bproof_2 = skin.bproof_2
				})
			end)
			isVestOn = true
		end
	end

end)

-- Chain
RegisterNetEvent('esx_clothes_lgrp:Chain')
AddEventHandler('esx_clothes_lgrp:Chain', function()
	local maleSkin = {
		['chain_1'] = 0, ['chain_2'] = 0
	}
	local notSoMaleSkin = {
		['chain_1'] = 0, ['chain_2'] = 0
	}

	if checkIfIsMale() == true then
		if isChainOn == true then
			TriggerEvent('skinchanger:getSkin', function(skin)
				TriggerEvent('skinchanger:loadClothes', skin, maleSkin)
			end)
			isChainOn = false
		else
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', {
					sex = 0,
					chain_1 = skin.chain_1, chain_2 = skin.chain_2
				})
			end)
			isChainOn = true
		end
	else
		if isChainOn == true then
			TriggerEvent('skinchanger:getSkin', function(skin)
				TriggerEvent('skinchanger:loadClothes', skin, notSoMaleSkin)
			end)
			isChainOn = false
		else
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', {
					sex = 1,
					chain_1 = skin.chain_1, chain_2 = skin.chain_2
				})
			end)
			isChainOn = true
		end
	end

end)

-- Mask
RegisterNetEvent('esx_clothes_lgrp:Mask')
AddEventHandler('esx_clothes_lgrp:Mask', function()
	local maleSkin = {
		['mask_1'] = 0, ['mask_2'] = 0
	}
	local notSoMaleSkin = {
		['mask_1'] = 0, ['mask_2'] = 0
	}

	if checkIfIsMale() == true then
		if isMaskOn == true then
			TriggerEvent('skinchanger:getSkin', function(skin)
				TriggerEvent('skinchanger:loadClothes', skin, maleSkin)
			end)
			isMaskOn = false
		else
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', {
					sex = 0,
					mask_1 = skin.mask_1, mask_2 = skin.mask_2
				})
			end)
			isMaskOn = true
		end
	else
		if isMaskOn == true then
			TriggerEvent('skinchanger:getSkin', function(skin)
				TriggerEvent('skinchanger:loadClothes', skin, notSoMaleSkin)
			end)
			isMaskOn = false
		else
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', {
					sex = 1,
					mask_1 = skin.mask_1, mask_2 = skin.mask_2
				})
			end)
			isMaskOn = true
		end
	end

end)

-- Glasses
RegisterNetEvent('esx_clothes_lgrp:Glasses')
AddEventHandler('esx_clothes_lgrp:Glasses', function()
	local maleSkin = {
		['glasses_1'] = 0, ['glasses_2'] = 0
	}
	local notSoMaleSkin = {
		['glasses_1'] = 5, ['glasses_2'] = 0
	}

	if checkIfIsMale() == true then
		if isGlassesOn == true then
			TriggerEvent('skinchanger:getSkin', function(skin)
				TriggerEvent('skinchanger:loadClothes', skin, maleSkin)
			end)
			isGlassesOn = false
		else
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', {
					sex = 0,
					glasses_1 = skin.glasses_1, glasses_2 = skin.glasses_2
				})
			end)
			isGlassesOn = true
		end
	else
		if isGlassesOn == true then
			TriggerEvent('skinchanger:getSkin', function(skin)
				TriggerEvent('skinchanger:loadClothes', skin, notSoMaleSkin)
			end)
			isGlassesOn = false
		else
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', {
					sex = 1,
					glasses_1 = skin.glasses_1, glasses_2 = skin.glasses_2
				})
			end)
			isGlassesOn = true
		end
	end

end)

-- Bag
RegisterNetEvent('esx_clothes_lgrp:Bag')
AddEventHandler('esx_clothes_lgrp:Bag', function()
	local maleSkin = {
		['bags_1'] = 0, ['bags_2'] = 0
	}
	local notSoMaleSkin = {
		['bags_1'] = 0, ['bags_2'] = 0
	}

	if checkIfIsMale() == true then
		if isBagOn == true then
			TriggerEvent('skinchanger:getSkin', function(skin)
				TriggerEvent('skinchanger:loadClothes', skin, maleSkin)
			end)
			isBagOn = false
		else
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', {
					sex = 0,
					bags_1 = skin.bags_1, bags_2 = skin.bags_2
				})
			end)
			isBagOn = true
		end
	else
		if isBagOn == true then
			TriggerEvent('skinchanger:getSkin', function(skin)
				TriggerEvent('skinchanger:loadClothes', skin, notSoMaleSkin)
			end)
			isBagOn = false
		else
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', {
					sex = 1,
					bags_1 = skin.bags_1, bags_2 = skin.bags_2
				})
			end)
			isBagOn = true
		end
	end

end)

-- Ear
RegisterNetEvent('esx_clothes_lgrp:Ear')
AddEventHandler('esx_clothes_lgrp:Ear', function()
	local maleSkin = {
		['ears_1'] = -1, ['ears_2'] = 0
	}
	local notSoMaleSkin = {
		['ears_1'] = -1, ['ears_2'] = 0
	}

	if checkIfIsMale() == true then
		if isEarOn == true then
			TriggerEvent('skinchanger:getSkin', function(skin)
				TriggerEvent('skinchanger:loadClothes', skin, maleSkin)
			end)
			isEarOn = false
		else
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', {
					sex = 0,
					ears_1 = skin.ears_1, ears_2 = skin.ears_2
				})
			end)
			isEarOn = true
		end
	else
		if isEarOn == true then
			TriggerEvent('skinchanger:getSkin', function(skin)
				TriggerEvent('skinchanger:loadClothes', skin, notSoMaleSkin)
			end)
			isEarOn = false
		else
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', {
					sex = 1,
					ears_1 = skin.ears_1, ears_2 = skin.ears_2
				})
			end)
			isEarOn = true
		end
	end

end)
-- - - - - - - - - - - - - -
-- ESX Menu:
-- - - - - - - - - - - - - -
function OpenESXMenu(target)
	local elements = {
		{ label = _U('glasses'), value = 'glasses'},
		{ label = _U('torso'), value = 'torso'},
		{ label = _U('pants'), value = 'pants'},
		{ label = _U('shoes'), value = 'shoes'},
		{ label = _U('mask'), value = 'mask'},
		{ label = _U('helmet'), value = 'helmet'},
		{ label = _U('bag'), value = 'bag'},
		{ label = _U('ear'), value = 'ear'},
		{ label = _U('chain'), value = 'chain'},
		{ label = _U('vest'), value = 'vest'}
	}


	-- Menu:
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'action_menu',
		{
			title	 = _U('menu'),
			align	 = 'right',
			elements = elements
		}, function(data, menu)
			if data.current.value == 'torso' then
				TriggerEvent('esx_clothes_lgrp:Torso')
				ESX.UI.Menu.CloseAll()
			elseif data.current.value == 'pants' then
				TriggerEvent('esx_clothes_lgrp:Pants')
				ESX.UI.Menu.CloseAll()
			elseif data.current.value == 'shoes' then
				TriggerEvent('esx_clothes_lgrp:Shoes')
				ESX.UI.Menu.CloseAll()
			elseif data.current.value == 'helmet' then
				TriggerEvent('esx_clothes_lgrp:Helmet')
				ESX.UI.Menu.CloseAll()
			elseif data.current.value == 'vest' then
				TriggerEvent('esx_clothes_lgrp:Vest')
				ESX.UI.Menu.CloseAll()
			elseif data.current.value == 'chain' then
				TriggerEvent('esx_clothes_lgrp:Chain')
				ESX.UI.Menu.CloseAll()
			elseif data.current.value == 'mask' then
				TriggerEvent('esx_clothes_lgrp:Mask')
				ESX.UI.Menu.CloseAll()
			elseif data.current.value == 'glasses' then
				TriggerEvent('esx_clothes_lgrp:Glasses')
				ESX.UI.Menu.CloseAll()
			elseif data.current.value == 'bag' then
				TriggerEvent('esx_clothes_lgrp:Bag')
				ESX.UI.Menu.CloseAll()
			elseif data.current.value == 'ear' then
				TriggerEvent('esx_clothes_lgrp:Ear')
				ESX.UI.Menu.CloseAll()
			end
        end, function(data, menu)
        menu.close()
    end)
end


Citizen.CreateThread(function()
  while true do
  Citizen.Wait(0)

	  if IsControlJustReleased(0, Config.Key) then
	    OpenESXMenu()
	  	ClearPedTasks(GetPlayerPed(-1))
	  end

  end
end)
