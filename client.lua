RegisterNetEvent('dart:UpdateBlip')
AddEventHandler('dart:UpdateBlip', function(target, state)
    local playerBlip = GetBlipFromEntity(target)

    if playerBlip then
        if state then
            SetBlipColour(playerBlip, 1)
        else
            SetBlipColour(playerBlip, 0)
        end
    end
end)
