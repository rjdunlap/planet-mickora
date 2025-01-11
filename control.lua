script.on_event(defines.events.on_surface_created, function(event)
    local surface = game.surfaces[event.surface_index]
    if surface.name == "mickora" then
        surface.freeze_daytime = true
        surface.daytime = 0.5
    end
end)