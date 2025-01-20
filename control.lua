script.on_init(function()
    game.forces.player.set_surface_hidden(game.surfaces.nauvis, true)
  end)

script.on_event(defines.events.on_surface_created, function(event)
    local surface = game.surfaces[event.surface_index]
    if surface.name == "mickora" then

        game.surfaces[event.surface_index].daytime = 0.35
        game.surfaces[event.surface_index].freeze_daytime = true
        
        game.map_settings.enemy_evolution.destroy_factor = 0
        game.map_settings.enemy_evolution.time_factor = game.map_settings.enemy_evolution.time_factor * 2
        game.map_settings.enemy_expansion.min_expansion_cooldown = game.map_settings.enemy_expansion.min_expansion_cooldown / 4
        game.map_settings.enemy_expansion.max_expansion_cooldown = game.map_settings.enemy_expansion.max_expansion_cooldown / 4
    end

end)

script.on_event(defines.events.on_player_joined_game, function(event)

    local surface = game.surfaces["mickora"]
    game.surfaces["mickora"].daytime = 0.35
    game.surfaces["mickora"].freeze_daytime = true
    
    game.players[event.player_index].enable_flashlight()
end)

script.on_event(defines.events.on_player_changed_surface, function(event)
    if not event.surface_index then return end

    local surface = game.surfaces[event.surface_index]

    if surface.name == "mickora" then
        game.players[event.player_index].enable_flashlight()
    end
end)