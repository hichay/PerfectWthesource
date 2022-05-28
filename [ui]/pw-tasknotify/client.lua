--1 basic notification
--2 error msg
--3 System Msg / Admin shit

-- same color notification
--4 Seat Belt
--5 Police vehicle actions
--6 Body Stress
--7 housing related
--8 purchase item
--9 engine toggle
--10 phone noticiations
--11 cruise actived
--12 fish winner
--14 race countdown
--15 Gang Update notification
HudStage = 1
RegisterNetEvent("disableHUD")
AddEventHandler("disableHUD", function(passedinfo)
  HudStage = passedinfo
  if HudStage > 2 then
    TriggerEvent("chat:clear")
  end
end)


RegisterNetEvent('DoLongHudText')
AddEventHandler('DoLongHudText', function(text,color,length)
    if HudStage > 2 then return end
    if not color then color = 1 end
    if not length then length = 12000 end
    TriggerEvent("tasknotify:guiupdate",color, text, 12000)
end)

RegisterNetEvent('DoShortHudText')
AddEventHandler('DoShortHudText', function(text,color,length)
    if not color then color = 1 end
    if not length then length = 10000 end
    if HudStage > 2 then return end
    TriggerEvent("tasknotify:guiupdate",color, text, 10000)
end)


function openGui(clr,msg,time)
    guiEnabled = true
    SendNUIMessage({runProgress = true, colorsent = clr, textsent = msg, fadesent = time})
end

function closeGui()
    guiEnabled = false
    SendNUIMessage({closeProgress = true})
end

RegisterNetEvent("tasknotify:guiupdate")
AddEventHandler("tasknotify:guiupdate", function(color,message,time)
    openGui(color,message,time)
end)

RegisterNetEvent("tasknotify:guiclose")
AddEventHandler("tasknotify:guiclose", function()
    closeGui()
end)