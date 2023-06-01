local blipActive = false

RegisterNetEvent('dart:activateBlip')
AddEventHandler('dart:activateBlip', function(vehicle)
    if not blipActive then
        local blip = AddBlipForEntity(vehicle)
        SetBlipSprite(blip, Config.BlipSprite)
        SetBlipColour(blip, Config.BlipColor)
        SetBlipDisplay(blip, Config.BlipDisplay)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Tracked Vehicle")
        EndTextCommandSetBlipName(blip)
        blipActive = true
    end
end)

RegisterNetEvent('dart:deactivateBlip')
AddEventHandler('dart:deactivateBlip', function()
    if blipActive then
        RemoveBlip(blip)
        blipActive = false
    end
end)

RegisterCommand('dart', function(source, args)
    TriggerServerEvent('dart:checkCooldown')
end)
