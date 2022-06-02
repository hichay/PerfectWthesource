RegisterNetEvent('pw-gardener:WorkMenu', function()
    local data = {
        {
            icon = "check",
            title = "Tìm kiếm khách hàng",
            description = "",
            action = "pw-gardener:findclient",
            
        },
        {
            icon = "check",
            title = "Hủy cuộc gặp khách hàng",
            description = "",
            action = "pw-gardener:findclient",
            
        },
    
    }
    
    exports["pw-context"]:showContextMenu(data)
end)


RegisterNetEvent('pw-gardener:GarageMenu', function()
    local data = {
        {
            icon = "check",
            title = "Vị trí 1",
            description = "",
            action = "pw-gardener:Parking1",
            
        },
        {
            icon = "check",
            title = "Vị trí 2",
            description = "",
            action = "pw-gardener:Parking2",
            
        },
    
    }
    
    exports["pw-context"]:showContextMenu(data)
end)

RegisterNetEvent('pw-gardener:MenuTakeWorkItem', function()
    local data = {
        {
            icon = "check",
            title = "Máy thổi lá",
            description = "",
            action = "pw-gardener:takeleaftblower",
            
        },
        {
            icon = "check",
            title = "Bình tưới cây",
            description = "",
            action = "pw-gardener:takebackpack",
            
        },
        {
            icon = "check",
            title = "Kéo tỉa",
            description = "",
            action = "pw-gardener:taketrimmer",
            
        },
        {
            icon = "check",
            title = "Máy cắt cỏ",
            description = "",
            action = "pw-gardener:takelawnmower",
            
        },
        {
            icon = "check",
            title = "<<< Đóng cửa",
            description = "",
            action = "pw-gardener:closedoor",
            
        },
    
    }
    
    exports["pw-context"]:showContextMenu(data)
end)




