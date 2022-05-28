ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterCommand('cash', 'user', function(xPlayer, args)
	TriggerClientEvent("hud:client:ShowMoney",source)
end, false, {help = "add thêm garage nhà", validate = true, arguments = {

}})