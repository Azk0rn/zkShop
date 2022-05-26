ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent("Azk:ShopAdvance")
AddEventHandler("Azk:ShopAdvance", function(item,price)

    local _src = source 
    local xPlayer = ESX.GetPlayerFromId(source)
    local wallet = xPlayer.getMoney()
    local bankwallet = xPlayer.getAccount('bank').money

    if wallet >= price then 
        xPlayer.removeMoney(price)
        xPlayer.addInventoryItem(item, 1)
        TriggerClientEvent('esx:showNotification', source, "~g~Achats~w~ effectué avec succès !")
        sendToDiscordWithSpecialURL("Superette","Personne : "..xPlayer.getName().."\n _Paniers_ : "..item, 1566263, Superette.WebHook)
    elseif bankwallet >= price then 
        xPlayer.removeAccountMoney('bank', price)
        xPlayer.addInventoryItem(item, 1)
        sendToDiscordWithSpecialURL("Superette","Personne : "..xPlayer.getName().."\n _Paniers_ : "..item, 1566263, Superette.WebHook)
        TriggerClientEvent('esx:showNotification', source, "Un retrait de "..price.."à été fait sur votre compte !")
    else 
        TriggerClientEvent('esx:showNotification', source, "Vous n\'avez pas assez d\'argent")
    end
end)

function sendToDiscordWithSpecialURL(name,message,color,url)
    local DiscordWebHook = url
	local embeds = {
		{
			["title"]=message,
			["type"]="rich",
			["color"] =color,
			["footer"]=  {
			["text"]= "Superette by Azk",
			},
		}
	}
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = "Azk Jobs",embeds = embeds}), { ['Content-Type'] = 'application/json' })
end