ESX = nil

local inmenu,currentw,cam,weapon = false,nil,0,0

local oldwep = nil

local isat = 0



Citizen.CreateThread(function()

	while ESX == nil do

		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

		Citizen.Wait(0)

    end

end)



WarMenu.CreateMenu("main",Config.menu.main.title)

WarMenu.SetSubTitle("main", Config.menu.main.subtitle)

WarMenu.SetTitleColor("main", table.unpack(Config.menu.main.titlecolor))

WarMenu.SetTitleBackgroundColor("main",table.unpack(Config.menu.main.backcolor))

WarMenu.SetMenuY("main", Config.menu.main.y)

WarMenu.SetMenuX("main", Config.menu.main.x)



WarMenu.CreateMenu("weapon",Config.menu.weapon.title:format(""))

WarMenu.SetSubTitle("weapon",Config.menu.weapon.subtitle:format(""))

WarMenu.SetTitleColor("weapon", table.unpack(Config.menu.weapon.titlecolor))

WarMenu.SetTitleBackgroundColor("weapon",table.unpack(Config.menu.weapon.backcolor))

WarMenu.SetMenuY("weapon", Config.menu.weapon.y)

WarMenu.SetMenuX("weapon", Config.menu.weapon.x)



Citizen.CreateThread(function()

    while true do

        Citizen.Wait(0)

        if WarMenu.IsAnyMenuOpened() then

            if not DoesCamExist(cam) then

                cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)

                SetEntityVisible(GetPlayerPed(-1),false)

                FreezeEntityPosition(GetPlayerPed(-1), true)

                SetEntityCollision(GetPlayerPed(-1),false,false)

                SetCamCoord(cam, Config.cam_coords[isat])

                SetCamActive(cam, true)

                RenderScriptCams(true, false, 0, true, true)

                PointCamAtCoord(cam, Config.cam_point_coords[isat])

                oldwep = GetSelectedPedWeapon(GetPlayerPed(-1))

            end

            if DoesEntityExist(weapon) then SetEntityHeading(weapon,GetEntityHeading(weapon)+0.2) end

            HideHudAndRadarThisFrame()

        elseif not WarMenu.IsAnyMenuOpened() and DoesCamExist(cam) then

            SetCamActive(cam,false)

            RenderScriptCams(false,false,0,true,true)

            DestroyCam(cam, false)

            SetCurrentPedWeapon(GetPlayerPed(-1), oldwep~=nil and oldwep or GetSelectedPedWeapon(GetPlayerPed(-1)), true)

            SetEntityVisible(GetPlayerPed(-1),true)

            SetEntityCollision(GetPlayerPed(-1), true, true)

            ActivatePhysics(GetPlayerPed(-1))

            FreezeEntityPosition(GetPlayerPed(-1), false)

            if DoesEntityExist(weapon) then DeleteEntity(weapon) end

        end

    end

end)



Citizen.CreateThread(function()

    while true do

        Citizen.Wait(0)

        local ped = GetPlayerPed(-1)

        for i=1, #Config.marker.locations, 1 do

            if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.marker.locations[i], false)<30.0 and not WarMenu.IsAnyMenuOpened() then

                DrawMarker(1, Config.marker.locations[i].x, Config.marker.locations[i].y, Config.marker.locations[i].z, 0, 0, 0, 0, 0, 0, Config.marker.size.x, Config.marker.size.y, Config.marker.size.z, Config.marker.color.r, Config.marker.color.g, Config.marker.color.b, Config.marker.color.a, 0, 0, 0, false)

                if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.marker.locations[i], false)<Config.marker.size.x then

                    --ESX.ShowFloatingHelpNotification(Config.lang.marker_text)
					ESX.ShowHelpNotification(Config.lang.marker_text)

                    -- if IsControlJustPressed(0, 51) then 

                                -- ESX.TriggerServerCallback('esx_license:checkLicense', function(hasWeaponLicense)

                                    -- if hasWeaponLicense then

                                        -- isat = i

                                        -- WarMenu.OpenMenu("main")

                                    -- else

                                        -- ESX.ShowNotification('Bạn phải có bằng sử dụng súng, có thể đăng ký từ Công An')

                                    -- end

                                -- end, GetPlayerServerId(PlayerId()), 'weapon')
                   
             

                    -- end
					
					if IsControlJustPressed(0, 51) then 
						if true then

                                        isat = i

                                        WarMenu.OpenMenu("main")
						end
					end

                end

            end

        end

        -- if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.marker.pos, false)<30.0 and not WarMenu.IsAnyMenuOpened() then

        --     DrawMarker(1, Config.marker.pos.x, Config.marker.pos.y, Config.marker.pos.z, 0, 0, 0, 0, 0, 0, Config.marker.size.x, Config.marker.size.y, Config.marker.size.z, Config.marker.color.r, Config.marker.color.g, Config.marker.color.b, Config.marker.color.a, 0, 0, 0, false)

        --     if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.marker.pos, false)<Config.marker.size.x then

        --         ESX.ShowHelpNotification(Config.lang.marker_text)

        --         if IsControlJustPressed(0, 51) then WarMenu.OpenMenu("main") end

        --     end

        -- end

        if WarMenu.IsMenuOpened('main') then

            for _,w in ipairs(Config.weapons) do

                if not HasPedGotWeapon(ped, GetHashKey(w.weapon), 0) and w.allowed then

                    if WarMenu.Button(w.label,Config.price_format:format(w.price)) then

                        ESX.TriggerServerCallback("fn_weaponshop:buyWeapon",function(can)

                            if can then 

                                DisplayBoughtScaleform('weapon',w.weapon, Config.price_format:format(w.price))

                               

                            else

                                 ESX.ShowNotification(Config.lang.not_enough_money)
                                

                            end

                        end, w.weapon)

                    end

                else

                    if HasPedGotWeapon(ped, GetHashKey(w.weapon), 0) then

                        if WarMenu.MenuButton(w.label,"weapon",Config.lang.owned) then

                            currentw = w

                            WarMenu.SetTitle("weapon",Config.menu.weapon.title:format(w.label))

                            WarMenu.SetSubTitle("weapon",Config.menu.weapon.subtitle:format(w.label))

                            if DoesEntityExist(weapon) then DeleteEntity(weapon) end

                            local weaponAsset = GetHashKey(w.weapon)

                            RequestWeaponAsset(weaponAsset, 31, 0)

                            while not HasWeaponAssetLoaded(weaponAsset) do

                                Wait(0)

                            end

                            if w.upgrades~=nil and #w.upgrades>0 then

                                local hadbefore = {}

                                for k,v in ipairs(w.upgrades) do hadbefore[k]=HasPedGotWeaponComponent(ped,weaponAsset,GetHashKey(v.hash)) end

                                for k,v in ipairs(w.upgrades) do

                                    if not hadbefore[k] then GiveWeaponComponentToPed(ped,weaponAsset,GetHashKey(v.hash)); RemoveWeaponComponentFromPed(ped, weaponAsset, GetHashKey(v.hash)) end

                                end

                                for k,v in ipairs(w.upgrades) do if hadbefore[k] and not HasPedGotWeaponComponent(ped,weaponAsset,GetHashKey(v.hash)) then GiveWeaponComponentToPed(ped,weaponAsset,GetHashKey(v.hash)) end end -- fucking magazines :)

                            end -- my cheeky way of loading components into memory >:)

                            SetCurrentPedWeapon(ped, weaponAsset, true)

                            weapon = CreateWeaponObject(weaponAsset, 0, Config.weapon_coords[isat], true, 0, 0)

                        end

                    end

                end

            end

            WarMenu.Display()

        elseif WarMenu.IsMenuOpened("weapon") then

            local weaponhash = GetHashKey(currentw.weapon)

            if currentw.can_buy_ammo and currentw.ammo_count and currentw.ammo_price then

                if WarMenu.Button(Config.lang.ammo:format(currentw.ammo_count),Config.price_format:format(currentw.ammo_price)) then
					
					--TriggerServerEvent('fn_weaponshop:buyAmmo', weaponhash , currentw.ammo_count)
                    ESX.TriggerServerCallback("fn_weaponshop:buyAmmo",function(can)

                        if can then

                            ESX.ShowNotification(Config.lang.buy_success)
							AddAmmoToPed(ped, weaponhash, currentw.ammo_count)
                        else

                             ESX.ShowNotification(Config.lang.not_enough_money)
                        
                        end

                    end, currentw.weapon, currentw.ammo_count)

                end

            end

            if currentw.upgrades and #currentw.upgrades>0 then

                for _,upgrade in ipairs(currentw.upgrades) do

                    -- if not upgrade.hash:match("_CLIP_") then

                        local upgradehash = GetHashKey(upgrade.hash)

                        if not HasModelLoaded(upgradehash) then RequestModel(upgradehash) end

                        if HasPedGotWeaponComponent(ped,weaponhash,upgradehash) and not HasWeaponGotWeaponComponent(weapon, upgradehash) then GiveWeaponComponentToWeaponObject(weapon, upgradehash) elseif not HasPedGotWeaponComponent(ped, weaponhash, upgradehash) and HasWeaponGotWeaponComponent(weapon, upgradehash) then RemoveWeaponComponentFromWeaponObject(weapon, upgradehash) end

                        if WarMenu.GetSelected()==(currentw.can_buy_ammo and 1 or 0)+_ then if not HasWeaponGotWeaponComponent(weapon, upgradehash) then GiveWeaponComponentToWeaponObject(weapon,upgradehash) elseif not HasPedGotWeaponComponent(ped,weaponhash,upgradehash) then RemoveWeaponComponentFromWeaponObject(weapon, upgradehash) end end

                        if WarMenu.Button(upgrade.label,HasPedGotWeaponComponent(ped, weaponhash, upgradehash) and Config.lang.equipped or (upgrade.price<=0 and Config.lang.free or Config.price_format:format(upgrade.price))) then

                            if not HasPedGotWeaponComponent(ped, weaponhash, upgradehash) then

                                ESX.TriggerServerCallback("fn_weaponshop:buyWeaponComponent",function(can)

                                    if can then

                                        GiveWeaponComponentToPed(ped, weaponhash, upgradehash)
										ESX.ShowNotification(Config.lang.buy_success)
									
                                    else

                                         ESX.ShowNotification(Config.lang.not_enough_money)

                                     
                                    end

                                end, currentw.weapon, upgrade.hash)

                            end

                        end

                    -- end

                end

            end

            if currentw.tints and #currentw.tints>0 then

                for _,tint in ipairs(currentw.tints) do

                    if WarMenu.GetSelected()==(currentw.upgrades~=nil and #currentw.upgrades or 0)+_+(currentw.can_buy_ammo and 1 or 0) and GetWeaponObjectTintIndex(weapon)~=tint.index then 
					SetWeaponObjectTintIndex(weapon,tint.index) 
					end

                    if WarMenu.Button(tint.label,GetPedWeaponTintIndex(GetPlayerPed(-1),GetHashKey(currentw.weapon))==tint.index and Config.lang.equipped or (tint.price<=0 and Config.lang.free or Config.price_format:format(tint.price))) then

                        ESX.TriggerServerCallback("fn_weaponshop:buyWeaponTint",function(can)

                            if can then
								ESX.ShowNotification(Config.lang.buy_success)
                                SetPedWeaponTintIndex(ped, weaponhash, tint.index)

                            else

                                 ESX.ShowNotification(Config.lang.not_enough_money)
                            

                            end

                        end, currentw.weapon, tint.index)

                    end

                end

            end

            if (WarMenu.GetSelected()<=(currentw.upgrades~=nil and #currentw.upgrades or 0)+(currentw.can_buy_ammo and 1 or 0) or WarMenu.GetSelected()>(currentw.upgrades~=nil and #currentw.upgrades or 0)+(currentw.tints~=nil and #currentw.tints or 0)+(currentw.can_buy_ammo and 1 or 0)) and GetWeaponObjectTintIndex(weapon)~=GetPedWeaponTintIndex(ped, weaponhash) then SetWeaponObjectTintIndex(weapon,GetPedWeaponTintIndex(ped, weaponhash)) end

            if WarMenu.MenuButton("Back","main") then DeleteEntity(weapon) end

            WarMenu.Display()

        end

    end

end)



Citizen.CreateThread(function()

    for i = 1, #Config.marker.locations, 1 do

        local blip = AddBlipForCoord(Config.marker.locations[i])



        SetBlipSprite (blip, 110)

        SetBlipDisplay(blip, 4)

        SetBlipScale  (blip, 1.0)

        SetBlipColour (blip, 81)

        SetBlipAsShortRange(blip, true)



        BeginTextCommandSetBlipName("CUSTOM_TEXT")

        AddTextComponentSubstringPlayerName('[Đảo] - Vũ khí')

        EndTextCommandSetBlipName(blip)

    end

end)



function DisplayBoughtScaleform(type, item, price)

    local scaleform = ESX.Scaleform.Utils.RequestScaleformMovie('MP_BIG_MESSAGE_FREEMODE')

    local sec = 4

    if type == 'component' then

        text = "<FONT FACE='Oswald'>Bạn đã mua ~y~</FONT>".. item .."~s~ <FONT FACE='Oswald'>với giá ~r~</FONT>"..ESX.Math.GroupDigits(price).."~s~"

        text2 = nil

        text3 = nil

    elseif type == 'weapon' then

        text2 = ESX.GetWeaponLabel(item)

        text = "<FONT FACE='Oswald'>Bạn đã mua ~y~</FONT>".. text2 .."~s~ <FONT FACE='Oswald'>với giá ~r~</FONT>"..ESX.Math.GroupDigits(price).."~s~"

        text3 = GetHashKey(item)

    elseif type == 'ammo' then

        text = "<FONT FACE='Oswald'>Bạn đã mua ~y~Đạn~s~ với giá ~r~</FONT>"..ESX.Math.GroupDigits(price)..'~s~'

        text2 = nil

        text3 = nil

    end





    BeginScaleformMovieMethod(scaleform, 'SHOW_WEAPON_PURCHASED')



    PushScaleformMovieMethodParameterString(text)

    if text2~= nil then

    PushScaleformMovieMethodParameterString(text2)

    end

    if text3 ~= nil then

        PushScaleformMovieMethodParameterInt(text3)

    end

    PushScaleformMovieMethodParameterString('')

    PushScaleformMovieMethodParameterInt(100)



    EndScaleformMovieMethod()



    PlaySoundFrontend(-1, 'WEAPON_PURCHASE', 'HUD_AMMO_SHOP_SOUNDSET', false)



    Citizen.CreateThread(function()

        while sec > 0 do

            Citizen.Wait(0)

            sec = sec - 0.01

    

            DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)

        end

    end)

end

RegisterFontFile("font")
fontId = RegisterFontId("Oswald")