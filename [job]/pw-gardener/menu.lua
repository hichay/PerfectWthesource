RegisterNetEvent('pw-gardener:WorkMenu', function()
    TriggerEvent('pw-context:sendMenu', {
        {
            id = 1,
            header = "Tìm kiếm khách hàng",
            txt = "",
            params = {
                event = "pw-gardener:findclient",
            }
        },
        {
            id = 2,
            header = "Hủy cuộc gặp khách hàng",
            txt = "",
            params = {
                event = "pw-gardener:cancelmetting",
            }
        },
    })
end)


RegisterNetEvent('pw-gardener:GarageMenu', function()
    TriggerEvent('pw-context:sendMenu', {
        {
            id = 1,
            header = "Vị trí 1",
            txt = "",
            params = {
                event = "pw-gardener:Parking1",
            }
        },
        {
            id = 2,
            header = "Vị trí 2",
            txt = "",
            params = {
                event = "pw-gardener:Parking2",
            }
        },
    })
end)

RegisterNetEvent('pw-gardener:MenuTakeWorkItem', function()
    TriggerEvent('pw-context:sendMenu', {
        {
            id = 1,
            header = "Máy thổi lá",
            txt = "",
            params = {
                event = "pw-gardener:takeleaftblower",
            }
        },
        {
            id = 2,
            header = "Bình tưới cây",
            txt = "",
            params = {
                event = "pw-gardener:takebackpack",
            }
        },
		 {
            id = 3,
            header = "Kéo tỉa",
            txt = "",
            params = {
                event = "pw-gardener:taketrimmer",
            }
        },
		 {
            id = 4,
            header = "Máy cắt cỏ",
            txt = "",
            params = {
                event = "pw-gardener:takelawnmower",
            }
        },
		{
            id = 5,
            header = "<<< Đóng cửa",
            txt = "",
            params = {
                event = "pw-gardener:closedoor",
            }
        },
    })
end)




