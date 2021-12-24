ESX = nil 

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('azk:super')
AddEventHandler('azk:super', function(Label)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getMoney() >= Label.prix then 
        xPlayer.removeMoney(Label.prix)
        xPlayer.addInventoryItem(Label.Label, 1)
        TriggerClientEvent('esx:showNotification', source, "Vous avez acheter ~y~ "..Label.Nom.." ~s~pour "..Label.Prix.."$")
    else
        TriggerClientEvent('esx:showNotification', source, "Paiment ~r~ refusé")
    end
end)