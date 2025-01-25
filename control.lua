script.on_event(defines.events.on_surface_created, function(event)
    local surface = game.surfaces[event.surface_index]
    if surface.name == "mickora" then
        game.surfaces[event.surface_index].daytime = 0.35
        game.surfaces[event.surface_index].freeze_daytime = true        
    end

end)

script.on_event(defines.events.on_player_joined_game, function(event)
    if game.players[event.player_index].surface.name == "mickora" then
        game.players[event.player_index].enable_flashlight()
    end
end)

script.on_event(defines.events.on_player_changed_surface, function(event)
    if not event.surface_index then return end

    local surface = game.surfaces[event.surface_index]
    if surface.name == "mickora" then
        game.players[event.player_index].enable_flashlight()
    end
end)