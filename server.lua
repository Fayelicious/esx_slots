-- This resource was made by plesalex100#7387
-- Please respect it, don't repost it without my permission
-- This Resource started from: https://codepen.io/AdrianSandu/pen/MyBQYz
-- ESX Version: saNhje & wUNDER
-- Modifed by Pheenx

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("esx_slots:BetsAndMoney")
AddEventHandler("esx_slots:BetsAndMoney", function(bets)
    local _source   = source
    local xPlayer   = ESX.GetPlayerFromId(_source)
    if xPlayer then
        if bets % 50 == 0 and bets >= 50 then
           if xPlayer.getInventoryItem('cchip').count >= bets then
                xPlayer.removeInventoryItem("cchip",bets)
                TriggerClientEvent("esx_slots:UpdateSlots", _source, bets)
            else
                TriggerClientEvent('esx:showNotification', _source, "Not enought Jetons")
            end
        else
            TriggerClientEvent('esx:showNotification', _source, "You have to insert a multiple of 50. ex: 100, 350, 2500")
        end

    end
end)

RegisterServerEvent("esx_slots:PayOutRewards")
AddEventHandler("esx_slots:PayOutRewards", function(amount)
    local _source   = source
    local xPlayer   = ESX.GetPlayerFromId(_source)
    if xPlayer then
        amount = tonumber(amount)
        if amount > 0 then
            xPlayer.addInventoryItem("cchip", amount)
            TriggerClientEvent('esx:showNotification', _source, "Slots: You won $"..amount.." not bad at all!")
        else
            TriggerClientEvent('esx:showNotification', _source, "Slots: Unfortunately you've lost all the money, maybe next time.")
        end
    end
end)

RegisterServerEvent('esx_slots:setWinning')
AddEventHandler('esx_slots:setWinning', function ()
	local _source = source
	
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)',
	{
		['@owner']   = xPlayer.identifier,
	
		['@vehicle'] = divo
	}, function (rowsChanged)
		TriggerClientEvent('esx:showNotification', _source, _U('vehicle_belongs', vehicleProps.plate))
	end)
end)