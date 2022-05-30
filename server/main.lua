local QBCore = exports['qb-core']:GetCoreObject()
local ResetTimer = 2700 * 1000  --<< timer every how many missions you can do, default is 600 seconds
local ActiveMission = 0

function OdpalTimer()
	ActiveMission = 1
	Wait(ResetTimer)
	ActiveMission = 0
	TriggerClientEvent('qb-truckrobbery:CleanUp', -1)
end

RegisterServerEvent('qb-truckrobbery:server:activateMission', function()
	local copsOnDuty = 0
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)
	local accountMoney = xPlayer.PlayerData.money["bank"]
	if ActiveMission == 0 then
		if accountMoney < Config.ActivationCost then
		TriggerClientEvent('QBCore:Notify', _source, "You need $"..Config.ActivationCost.." in the bank to accept the mission")
		else
			for _, v in pairs(QBCore.Functions.GetPlayers()) do
				local Player = QBCore.Functions.GetPlayer(v)
				if Player ~= nil then
					if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
						copsOnDuty = copsOnDuty + 1
					end
				end
			end
			if copsOnDuty >= Config.ActivePolice then
				TriggerClientEvent("qb-truckrobbery:letsBegin", _source)
				xPlayer.Functions.RemoveMoney('bank', Config.ActivationCost, "armored-truck")

				OdpalTimer()
			else
				TriggerClientEvent('QBCore:Notify', _source, 'Need at least '..Config.ActivePolice.. ' SASP to activate the mission.')
			end
		end
	else
		TriggerClientEvent('QBCore:Notify', _source, 'Someone is already carrying out this mission')
	end
end)

RegisterServerEvent('qb-armoredtruckheist:server:callCops', function(streetLabel, coords)
    TriggerClientEvent("qb-armoredtruckheist:client:robberyCall", -1, streetLabel, coords)
end)

RegisterServerEvent('qb-truckrobbery:zawiadompsy', function(x ,y, z)
    TriggerClientEvent('qb-truckrobbery:InfoForLspd', -1, x, y, z)
end)

RegisterServerEvent('qb-truckrobbery:server:lootReward', function()
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)
	local bags = math.random(1,3)
	local info = {
		worth = math.random(Config.CashA, Config.CashB)
	}
	xPlayer.Functions.AddItem('markedbills', bags, false, info)
	TriggerClientEvent('inventory:client:ItemBox', _source, QBCore.Shared.Items['markedbills'], "add")

	local chance = math.random(1, 100)
	TriggerClientEvent('QBCore:Notify', _source, 'You took '..bags..' bags of cash from the van')

	if chance >= 95 then
		xPlayer.Functions.AddItem('security_card_01', 1)
		TriggerClientEvent('inventory:client:ItemBox', _source, QBCore.Shared.Items['security_card_01'], "add")
	elseif chance <= 5 then
		xPlayer.Functions.AddItem('usb_green', 1)
		TriggerClientEvent('inventory:client:ItemBox', _source, QBCore.Shared.Items['usb_green'], "add")
	end
	Wait(2500)
end)
