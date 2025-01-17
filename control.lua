script.on_event(defines.events.on_surface_created, function(event)
    local surface = game.surfaces[event.surface_index]
    if surface.name == "mickora" then
        surface.freeze_daytime = true
        surface.daytime = 0.5
        game.map_settings.enemy_evolution.destroy_factor = 0
        game.map_settings.enemy_evolution.time_factor = game.map_settings.enemy_evolution.time_factor * 2
        game.map_settings.enemy_expansion.min_expansion_cooldown = game.map_settings.enemy_expansion.min_expansion_cooldown / 4
        game.map_settings.enemy_expansion.max_expansion_cooldown = game.map_settings.enemy_expansion.max_expansion_cooldown / 4
    end
end)

