local trackingActive = false
local cooldownActive = false

RegisterServerEvent('dart:startTracking')
AddEventHandler('dart:startTracking', function()
    local source = source
    local playerPed = GetPlayerPed(source)
    local vehicle = GetVehiclePedIsIn(playerPed, false)

    if not IsVehicleAnEmergencyVehicle(vehicle) then
        TriggerClientEvent('chat:addMessage', source, { args = { '^1[DART]', 'You must be inside an emergency vehicle to track another vehicle.' } })
        return
    end

    if trackingActive then
        TriggerClientEvent('chat:addMessage', source, { args = { '^1[DART]', 'You are already tracking a vehicle.' } })
        return
    end

    local closestVehicle = GetClosestVehicle(GetEntityCoords(playerPed), 10.0, 0, 70)

    if not DoesEntityExist(closestVehicle) then
        TriggerClientEvent('chat:addMessage', source, { args = { '^1[DART]', 'No vehicles nearby to track.' } })
        return
    end

    trackingActive = true

    TriggerClientEvent('dart:activateBlip', -1, closestVehicle)

    SetTimeout(Config.TrackingDuration * 1000, function()
        trackingActive = false
        TriggerClientEvent('dart:deactivateBlip', -1)
    end)

    TriggerClientEvent('chat:addMessage', -1, { args = { '^1[DART]', 'A vehicle is being tracked.' } })
end)

RegisterServerEvent('dart:checkCooldown')
AddEventHandler('dart:checkCooldown', function()
    local source = source

    if cooldownActive then
        TriggerClientEvent('chat:addMessage', source, { args = { '^1[DART]', 'You must wait before tracking another vehicle.' } })
    else
        TriggerEvent('dart:startTracking')
        cooldownActive = true

        SetTimeout(Config.CooldownDuration * 1000, function()
            cooldownActive = false
        end)
    end
end)

-- Exports
exports('StartTracking', function()
    TriggerEvent('dart:startTracking')
end)

exports('CheckCooldown', function()
    TriggerEvent('dart:checkCooldown')
end)
