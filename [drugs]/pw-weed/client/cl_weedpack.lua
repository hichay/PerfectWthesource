
local IsWeedProcessing = false
local IsWeedProcessingFinished = false


local InteractCollect = {
    data = {
      {
        id = 'crim_taco_collect',
        label = "Thu gói",
        icon = 'box',
        event = 'np-weed:collect_package',
        parameters = {},
      },
    },
    options = {
      npcIds = { 'tacoshop' },
      distance = { radius = 2.5 },
      isEnabled = function(pEntity, pContext)
        return IsWeedProcessingFinished
      end,
    },
}
  
local InteractPackage = {
    data = {
        {
        id = 'crim_taco_package',
        label = "Đóng gói",
        icon = 'box',
        event = 'pw-weed:package_goods',
        parameters = {},
        },
    },
    options = {
        npcIds = { 'tacoshop' },
        distance = { radius = 2.5 },
        isEnabled = function(pEntity, pContext)
        return not IsWeedProcessing
        end,
    },
}



Citizen.CreateThread(function()

    local data = {
        id = "tacoshop",
        position = {coords = vector3(1307.7767, 3148.8852, 40.399955), heading = 141.0},
        pedType = 4,
        model = "a_m_o_tramp_01",
        networked = false,
        distance = 50.0,
        settings = {{ mode = 'invincible', active = true }, { mode = 'ignore', active = true }, { mode = 'freeze', active = true }},
        flags = { ["isNPC"] = true, },
        blip = { color = 10, sprite = 10, scale = 0.8, text = 'thuwr', short = true },
        scenario = "WORLD_HUMAN_CLIPBOARD_FACILITY",
    }
    local npc = exports["pw-npcs"]:RegisterNPC(data, "taco_the_npc")

    local initialState = RPC.execute('pw-weed:getInitialState')
    
    IsWeedProcessing = initialState.IsWeedProcessing
    IsWeedProcessingFinished = initialState.IsWeedProcessingFinished
    exports['pw-interact']:AddPeekEntryByFlag({ 'isNPC' }, InteractCollect.data, InteractCollect.options)
    exports['pw-interact']:AddPeekEntryByFlag({ 'isNPC' }, InteractPackage.data, InteractPackage.options)
end)



RegisterNetEvent('np-weed:collect_package')
AddEventHandler('np-weed:collect_package', function()
  local hasPackage = exports['pw-inventory']:hasEnoughOfItem('weedpackage', 1, false)

  if hasPackage then
    return
  end

  local success = RPC.execute('np-weed:collectpackage')

  if not success then
    TriggerEvent('DoLongHudText', '[ERR]: Could not get package.')
    return
  end
end)


RegisterNetEvent('pw-weed:package_goods')
AddEventHandler('pw-weed:package_goods', function()
  -- Check if they have enough weeds M8
  print('trigger')
  local hasEnoughWeeds = exports['pw-inventory']:hasEnoughOfItem('smallbud', 1, false, true)
  if not hasEnoughWeeds then
    TriggerEvent('DoLongHudText', 'You don\'t have enough green mate', 2)
    return
  end
  if IsWeedProcessing then
    TriggerEvent('DoLongHudText', 'Someone is already preparing a package', 2)
    return
  end
  local finished = exports['pw-taskbar']:taskBar(100, 'Preparing', false, true, false, false, nil, 5.0, PlayerPedId())
  if finished == 100 then
    local success = RPC.execute('pw-weed:processWeed')
    if success then
      TriggerEvent('DoLongHudText', 'Stay nearby for a few minutes while I package this')
    end
  end
end)



RegisterNetEvent('np-weed:weedProcessing')
AddEventHandler('np-weed:weedProcessing', function(pState)
  IsWeedProcessing = pState
end)


RegisterNetEvent('np-weed:weedReady')
AddEventHandler('np-weed:weedReady', function(pState)
    print(pState)
  IsWeedProcessingFinished = pState
end)