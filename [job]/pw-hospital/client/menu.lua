RegisterNetEvent('pw-brandcard:MainMenu', function()
    TriggerEvent('pw-context:sendMenu', {
        {
            id = 1,
            header = "Nằm lên",
            txt = "",
            params = {
                event = "pw-brandcard:client:namlen",
            }
        },
        {
            id = 2,
            header = "Ngồi lên",
            txt = "",
            params = {
                event = "pw-brandcard:client:ngoitren",
            }
        },
		
		{
            id = 3,
            header = "Ngồi lên trái",
            txt = "",
            params = {
                event = "pw-brandcard:client:ngoitrai",
            }
        },
		
		{
            id = 4,
            header = "Ngồi lên phải",
            txt = "",
            params = {
                event = "pw-brandcard:client:ngoiphai",
            }
        },
		
		{
            id = 4,
            header = "Rời khỏi",
            txt = "",
            params = {
                event = "pw-brandcard:client:roikhoi",
            }
        },
    })
end)

RegisterNetEvent('pw-brandcard:AmbulanceMenu', function()
    TriggerEvent('pw-context:sendMenu', {
        {
            id = 1,
            header = "Bật/Tắt Bảng đen",
            txt = "",
            params = {
                event = "pw-brandcard:client:blackboard",
            }
        },
        {
            id = 2,
            header = "Bật/Tắt Túi sơ cứu",
            txt = "",
            params = {
                event = "pw-brandcard:client:lifepack",
            }
        },
		
		{
            id = 3,
            header = "Bật/Tắt Túi ",
            txt = "",
            params = {
                event = "pw-brandcard:client:bag",
            }
        },
		
		{
            id = 4,
            header = "Bật/Tắt Balo",
            txt = "",
            params = {
                event = "pw-brandcard:client:backpack",
            }
        },
		
		{
            id = 5,
            header = "Bật/Tắt Ghế dựa",
            txt = "",
            params = {
                event = "pw-brandcard:client:seat",
            }
        },
    })
end)





