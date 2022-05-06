RegisterNetEvent('pw-motel:client:OpenElevatorMenu', function(key, nt)
    local data = {}
    if MX[key].elevators then
        for i = 1, #MX[key].elevators do
            if i ~= nt then
                data.kat = i
                data.coords = MX[key].elevators[i].coords
                TriggerEvent('pw-context:sendMenu', {
					{
						id = i,
						header = "Tầng".._U['elevator_rooms']:format(i) ,
						txt = "Dịch chuyển",
						params = {
							event = "pw-motel:client:TeleportElevator",
							 args = {
								name = data
							}
						}
					},

				})
                   
            end
        end
    end   
end)


RegisterNetEvent('pw-motel:client:RequestMenu', function(method, data)
    if method == 'buy' then
        if data then
            --TriggerServerEvent('pw-motelsbusiness:BuyMotel', data.src, data.target, data.motel, data.motelid, data.time, data.expense)

            TriggerEvent('pw-context:sendMenu', {
                {
                    id = 1,
                    header = _U['motel_requestDesc']:format(data.firstname..' '..data.lastname, data.motelid, GetFirstTimer(data.time), data.expense) ,
                    txt = "",
                    --[[ params = {
                        event = "pw-motelsbusiness:client:BuyMotel",
                         args = {
                           table = data
                        }
                    } ]]
                },

                {
                    id = 2,
                    header = "Đồng ý" ,
                    txt = "",
                    params = {
                        event = "pw-motelsbusiness:client:BuyMotel",
                         args = {
                           table = data
                        }
                    }
                },

                {
                    id = 3,
                    header = "Từ chối" ,
                    txt = "",
                    params = {
                        event = "pw-motelsbusiness:client:ReqReject",
                         args = {
                            table = data
                        }
                    }
                },

            })
        else
            Notification(_U['society_notData'])
        end
    elseif method == 'takeemployee' then
        if data then
            TriggerEvent('pw-context:sendMenu', {
                {
                    id = 1,
                    header = _U['motel_employeeReqDesc']:format(data.firstname..' '..data.lastname, data.motel, data.salary) ,
                    txt = "",
                    --[[ params = {
                        event = "pw-motelsbusiness:client:TakeEmployee",
                         args = {
                            table = data
                        }
                    } ]]
                },

                {
                    id = 2,
                    header = "Đồng ý" ,
                    txt = "",
                    params = {
                        event = "pw-motelsbusiness:client:TakeEmployee",
                         args = {
                            table = data
                        }
                    }
                },

                {
                    id = 3,
                    header = "Từ chối" ,
                    txt = "",
                    params = {
                        event = "pw-motelsbusiness:client:ReqReject",
                         args = {
                            table = data
                        }
                    }
                },

            })
        else
            Notification(_U['society_notData'])
        end
    end
end)

RegisterNetEvent('pw-motelsbusiness:client:TakeEmployee', function(data)
    local db = data.table
    TriggerServerEvent('pw-motelsbusiness:TakeEmployee', db.src, db.target, db.motel, db.salary)
end)

RegisterNetEvent('pw-motelsbusiness:client:BuyMotel', function(data)
    local db = data.table
    TriggerServerEvent('pw-motelsbusiness:BuyMotel', db.src, db.target, db.motel, db.motelid, db.time, db.expense)
end)

RegisterNetEvent('pw-motelsbusiness:client:ReqReject', function(data)
    local db = data.table 

    TriggerServerEvent('pw-motelsbusiness:ReqReject', db)

end)

RegisterNetEvent('pw-motel:client:TeleportElevator', function(data)
    local data1 = data.name
    Notification(_U['elevator_msg']:format(data1.kat))
    DoScreenFadeOut(200)
    Citizen.Wait(450)
    SetEntityCoordsNoOffset(PlayerPedId(), data1.coords.x , data1.coords.y, data1.coords.z, false, false, false, true)
    DoScreenFadeIn(500)
end)

