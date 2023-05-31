local dartBlips = {}
local dartCooldowns = {}
local dartCooldownDuration = 300 -- Cooldown duration in seconds
local dartDistanceLimit = 500 -- Distance limit in meters

function StartDart(source, target)
    local sourcePlayer = source

    if not dartBlips[sourcePlayer] then
        if not dartCooldowns[sourcePlayer] or (os.time() - dartCooldowns[sourcePlayer]) > dartCooldownDuration then
            local dartBlip = AddBlipForEntity(target)
            SetBlipSprite(dartBlip, 1)
            SetBlipColour(dartBlip, 3)
            SetBlipAsShortRange(dartBlip, true)
            dartBlips[sourcePlayer] = dartBlip

            TriggerClientEvent('chat:addMessage', sourcePlayer, {args = {'^1[DART]', 'Tracking dart fired successfully!'}})
            TriggerClientEvent('chat:addMessage', target, {args = {'^1[DART]', 'You have been hit with a tracking dart!'}})
            TriggerClientEvent('dart:UpdateBlip', -1, target, true)

            SetTimeout(1800000, function() -- 30 minutes
                dartCooldowns[sourcePlayer] = nil -- Remove the cooldown
                StopDart(sourcePlayer, target)
            end)

            dartCooldowns[sourcePlayer] = os.time() -- Start cooldown
        else
            local remainingCooldown = dartCooldownDuration - (os.time() - dartCooldowns[sourcePlayer])
            TriggerClientEvent('chat:addMessage', sourcePlayer, {args = {'^1[DART]', 'You must wait '..remainingCooldown..' seconds before firing another dart!'}})
        end
    else
        TriggerClientEvent('chat:addMessage', sourcePlayer, {args = {'^1[DART]', 'You already fired a tracking dart!'}})
    end
end

function StopDart(source, target)
    local sourcePlayer = source

    if dartBlips[sourcePlayer] then
        RemoveBlip(dartBlips[sourcePlayer])
        dartBlips[sourcePlayer] = nil
        TriggerClientEvent('chat:addMessage', sourcePlayer, {args = {'^1[DART]', 'Tracking dart stopped.'}})
        TriggerClientEvent('chat:addMessage', target, {args = {'^1[DART]', 'The tracking dart has been removed from you.'}})
        TriggerClientEvent('dart:UpdateBlip', -1, target, false)
    else
        TriggerClientEvent('chat:addMessage', sourcePlayer, {args = {'^1[DART]', 'You have not fired a tracking dart yet!'}})
    end
end

RegisterCommand('dart', function(source, args, rawCommand)
    local sourcePlayer = source

    if IsPlayerAceAllowed(sourcePlayer, 'darttracker.leo') then
        local playerPed = GetPlayerPed(sourcePlayer)
        local emergencyVehicle = GetVehiclePedIsIn(playerPed, false)

        if emergencyVehicle ~= 0 then
            local targetPlayer = tonumber(args[1])

            if targetPlayer and GetPlayerPed(targetPlayer) ~= 0 then
                local targetPed = GetPlayerPed(targetPlayer)
                local distance = GetDistanceBetweenCoords(GetEntityCoords(playerPed), GetEntityCoords(targetPed), true)

                if distance <= dartDistanceLimit then
                    StartDart(sourcePlayer, targetPed)
                else
                    TriggerClientEvent('chat:addMessage', sourcePlayer, {args = {'^1[DART]', 'Target is too far away!'}})
                end
            else
                TriggerClientEvent('chat:addMessage', sourcePlayer, {args = {'^1[DART]', 'Invalid player ID!'}})
            end
        else
            TriggerClientEvent('chat:addMessage', sourcePlayer, {args = {'^1[DART]', 'You are not in an emergency vehicle!'}})
        end
    else
        TriggerClientEvent('chat:addMessage', sourcePlayer, {args = {'^1[DART]', 'You do not have permission to use this command!'}})
    end
end)

-- Function to get the nearest player vehicle
function GetNearestPlayerVehicle(playerPed)
    local playerCoords = GetEntityCoords(playerPed)
    local vehicles = GetGamePool('CVehicle')
    local closestDistance = -1
    local closestVehicle = nil

    for i = 1, #vehicles do
        local vehicle = vehicles[i]
        local driver = GetPedInVehicleSeat(vehicle, -1)

        if driver ~= 0 and driver ~= playerPed then
            local distance = GetDistanceBetweenCoords(playerCoords, GetEntityCoords(vehicle), true)

            if closestDistance == -1 or distance < closestDistance then
                closestDistance = distance
                closestVehicle = vehicle
            end
        end
    end

    return closestVehicle
end

-- Exports for external resource usage
exports('StartDart', StartDart)
