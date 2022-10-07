PLATFORM = {}
PLATFORM.__index = PLATFORM

local playerPed = PlayerPedId()
local playerCoords = GetEntityCoords(playerPed)
local timeOnline = 0
local expskill = 0
isWorking = false
blipCreated = false

Citizen.CreateThread(function()
    while true do 
        Wait(100)
        playerPed = PlayerPedId()
        playerCoords = GetEntityCoords(playerPed)
    end
end)



function PLATFORM:Init(index, data)
    local o = data
    setmetatable(o, PLATFORM)
    o.coords = vector3(data.Position.X, data.Position.Y, data.Position.Z)
    o.index = index
    o:MainThread()
    o:NUIHandler()
    o:CreateBlip()
    return o
end 



function PLATFORM:CreateBlip()

        self.blip = AddBlipForCoord(self.coords.x, self.coords.y, self.coords.z)
        SetBlipSprite(self.blip, 648)
        SetBlipColour(self.blip, 2)
        SetBlipAsShortRange(self.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Mỏ Đào")
        EndTextCommandSetBlipName(self.blip)
        SetBlipScale(self.blip, 1.0)
end

function PLATFORM:NUIHandler()
    RegisterNUICallback("Close", function()
        if self.active then 
            self:Close()
        end
    end)
    RegisterNUICallback('Drill', function(data, cb)
        if self.active then 
            TriggerServerEvent('pw-oil:server:Drill', self.index, data.product)
        end
        
    end)
end

function PLATFORM:MainThread()
    Citizen.CreateThread(function()
        while true do 
            Wait(0)
            local distance = #(self.coords - playerCoords)
            if distance < 20.0 and not self.active then 
                if distance <= 5.0 and not IsPedInAnyVehicle(playerPed, false) then 
                    ESX.ShowHelpNotification("Nhấn [E] để mở mỏ dầu")
					
                    if IsControlJustReleased(0, 38)  then
                        local obj = GetClosestObjectOfType(self.coords.x, self.coords.y, self.coords.z, 5.0, self.Name, true, 1, 1)
                        if DoesEntityExist(obj) then
                            self:CreateCam()
                            self:Open()
                        end
                        self:CreateCam()
                        self:Open()
                    end
                    
                end
            else
                Wait(5000)
            end
        end
    end)
end

function PLATFORM:CreateCam()
    self:DestroyCam()
    local obj = GetClosestObjectOfType(self.coords.x, self.coords.y, self.coords.z, 5.0, GetHashKey(self.Name), false, 1, 1)
    local objCoords = GetEntityCoords(obj)
    local coords = GetOffsetFromEntityInWorldCoords(obj, 10.0, -10.0, 0.0)
    local pointCoords = GetOffsetFromEntityInWorldCoords(obj, 0.0, -7.0, 0.0)
    self.cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", coords.x, coords.y, coords.z + 8.0, 0.0, 0.0, 0.0, 65.00, false, false)
    SetCamActive(self.cam, true)
    PointCamAtCoord(self.cam, pointCoords.x, pointCoords.y, pointCoords.z + 7.0)
    RenderScriptCams(true, true, 2000, true, true) 
    Wait(2000)
end

function PLATFORM:DestroyCam()
    SetCamActive(self.cam,  false)
    DestroyAllCams(true)
    RenderScriptCams(false,  true,  2000,  true,  true)
end



function PLATFORM:Open()
    

    if not self.active then
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            return 
        end
		
        --local data = ESX.TriggerServerCallback('pw-oil:callback:getPlatformData', self.index)
		ESX.TriggerServerCallback('pw-oil:callback:getPlatformData', function(data)
			for k, v in pairs(data) do 
				self[k] = v
			end
		end, self.index)

       
        self.skill = RPC.execute("pw-oil:testrpc")
        if self.skill then 
            SendNUIMessage({
                event = "setSkill",
                data = self.skill
            })
        end

        SendNUIMessage({
            event = 'setTimeOnline',
            data = timeOnline
        })
        SendNUIMessage({
            event = "setData",
            data = self
        })
        SendNUIMessage({
            event = "setShow",
            data = true
        })
        SetNuiFocus(true, true)
        self.active = true
        --CORE.ToggleUI(false, true)
    end
end

function PLATFORM:Close()
    SendNUIMessage({
        event = "setShow",
        data = false
    })
    SetNuiFocus(false, false)
    self.active = false
    --CORE.ToggleUI(true, true)
    self:DestroyCam()
    TriggerServerEvent('pw-oil:server:leavePlatform', self.index)
    self.skill = RPC.execute("pw-oil:testrpc")
    if self.skill then 
        SendNUIMessage({
            event = "setSkill",
            data = self.skill
        })
    end
end

function PLATFORM:Sync(data)
    for k, v in pairs(data) do 
        self[k] = v
    end
    SendNUIMessage({
        event = "setData",
        data = self
    })
end

MAIN = {}
function MAIN:Init()
    local o = {}
    setmetatable(o, {__index = MAIN})
    o.Platforms = {}
    

   --[[  ESX.TriggerServerCallback('pw-oil:getPleyerExpOil', function(skill)
        
        if skill then 
            SendNUIMessage({
                event = "setSkill",
                data = skill
            })
        end
        self.skill = skill
    end)     
     ]]

    -- o.skill = PLAYER.get('skill')
    -- if o.skill and o.skill['oil'] then 
        -- SendNUIMessage({
            -- event = "setSkill",
            -- data = o.skill
        -- })
    -- end
    --o:CreateNPC()
    o:PlatformInit()
    o:EventHander()
    --Wait(10000)
    --[[ o.skill = RPC.execute("pw-oil:testrpc")
    if o.skill then 
        SendNUIMessage({
            event = "setSkill",
            data = o.skill
        })
    end ]]
    return o
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	Citizen.Wait(10000)
	playerskill = RPC.execute("pw-oil:testrpc")
        if playerskill then 
            SendNUIMessage({
                event = "setSkill",
                data = playerskill
            })
        end
        ESX.TriggerServerCallback('id_playtimereward:getHour', function(hours)
            timeOnline = hours * 3600
        end)    
end)


-- function MAIN:CreateNPC()
    -- self.blip = BLIP:Init(Config.Seller.coords, 642, 2, 1.0, 10, true, "Thu mua dầu mỏ")
    -- self.npc = NPC:Init(Config.Seller.model, Config.Seller.coords, Config.Seller.heading, "Người thu mua dầu mỏ", "Xin chào! Tôi có thể giúp gì cho bạn?", {
        -- {label = "Tôi có vài thứ muốn bán", value = 1},
        -- {label = "Rời khỏi", value = 2}
    -- }, function(data, menu)
        -- if data.value == 1 then 
            -- local elements = {
                -- {label = ('Xăng [%s $]'):format(GlobalState.gasoline or 0), value = 'gasoline'},
                -- {label = ('Khí Đốt [%s $]'):format(GlobalState.solar or 0), value = 'solar'},
                -- {label = ('Dầu Hỏa [%s $]'):format(GlobalState.kerosene or 0), value = 'kerosene'},
                -- {label = ('Đồng [%s $]'):format(GlobalState.copper or 0), value = 'copper'},
                -- {label = ('Ngọc lục bảo [%s $]'):format(GlobalState.emerald or 0), value = 'emerald'},
                -- {label = ('Ngọc ruby [%s $]'):format(GlobalState.ruby or 0), value = 'ruby'},
                -- {label = ('Kim Cương [%s $]'):format(GlobalState.diamond or 0), value = 'diamond'},
                -- {label = ('Tiền giả [%s $]'):format(GlobalState.fake_money or 0), value = 'fake_money'},
            -- }
            -- DEFAULTMENU:Init("Chọn tài nguyên muốn bán", elements, function(data2, menu2)
                -- local choosedItem = data2.value
                -- local itemCount = PLAYER.GetItemCount(choosedItem)
                -- CORE.CreateInputMenu('Bạn muốn bán bao nhiêu?', ('Nhập số lượng muốn bán [0 - %s]'):format(itemCount), function(value)
                    -- value = tonumber(value)
                    -- if value > 0 and value <= itemCount then 
                        -- TriggerServerEvent('pw-oil:server:sellResource', choosedItem, value)
                    -- else
                        -- CORE.ShowNotification("Số lượng không hợp lệ")
                    -- end
                -- end)
                -- menu2.close()
            -- end)
        -- elseif data.value == 2 then 
            -- menu.addMessage({msg = "Tạm biệt bạn!", from = "npc"})
            -- Wait(2000)
            -- menu.close()
        -- end
    -- end)
-- end

function MAIN:PlatformInit()
    for k, v in ipairs(Config.Platforms) do 
        self.Platforms[k] = PLATFORM:Init(k, v)
    end
end



function MAIN:EventHander()
    RegisterNetEvent('pw-oil:client:syncPlatform', function(platformData)
        self.Platforms[platformData.index]:Sync(platformData)
    end)
    -- RegisterNetEvent('lr-core:client:sync', function(data)
        -- for k, v in pairs(data) do 
            -- if k == 'skill' then 
                -- self.skill = v
                -- SendNUIMessage({
                    -- event = "setSkill",
                    -- data = self.skill
                -- })
                -- break
            -- end
        -- end
    -- end)

    --[[ local skill = RPC.execute("pw-oil:testrpc")
    if skill then 
        SendNUIMessage({
            event = "setSkill",
            data = skill
        })
    end  ]]

    --[[ ESX.TriggerServerCallback('pw-oil:getPleyerExpOil', function(skill)
        if skill then 
            SendNUIMessage({
                event = "setSkill",
                data = skill
            })
        end
        self.skill = skill
    end)  ]]

end
ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
    MAIN:Init()
       
    -- timeOnline = TriggerServerCallback('lr-core:callback:getOnlineTime')
    Citizen.CreateThread(function()
        while true do 
            Wait(1000)
            timeOnline = timeOnline + 1
        end
    end)
end)

