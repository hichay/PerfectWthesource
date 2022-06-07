Citizen.CreateThread(function()
    local data = {
        id = "material_exchange",
        position = {coords = vector3(992.9129, -3099.256, -39.99584), heading = 243.12},
        pedType = 4,
        model = "s_m_y_uscg_01",
        networked = false,
        distance = 25.0,
        settings = {{ mode = 'invincible', active = true }, { mode = 'ignore', active = true }, { mode = 'freeze', active = true }},
        flags = { ["isNPC"] = true, },
        scenario = "WORLD_HUMAN_CLIPBOARD_FACILITY",
    }
    local npc = exports["pw-npcs"]:RegisterNPC(data, "material_exchangename")

    local Interact = {
      data = {
        {
          id = 'material_exchangemaking',
          label = 'Trao đổi',
          icon = 'jedi',
          event = 'pw-npcs:ped:craft',
          parameters = {'141'},
        },
      },
      options = {
        distance = { radius = 2.5 },
        npcIds = { 'material_exchange' },
        --[[ isEnabled = function(pEntity, pContext)
          return isOnDeliveryTask()
        end, ]]
      },
    }
    
    exports["pw-interact"]:AddPeekEntryByFlag({'isNPC'}, Interact.data, Interact.options)
end)

