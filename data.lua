require("tiles")
--data.lua
local asteroid_util = require("__space-age__.prototypes.planet.asteroid-spawn-definitions")


--START MAP GEN
function MapGen_Mickora()
    -- Nauvis-based generation
    local map_gen_setting = table.deepcopy(data.raw.planet.nauvis.map_gen_settings)

    map_gen_setting.property_expression_names.cliffiness = "cliffiness_basic"
    map_gen_setting.property_expression_names.cliff_elevation = "cliff_elevation_from_elevation"
    
    map_gen_setting.cliff_settings =
    {
      name = "cliff",
      control = "nauvis_cliff",
      cliff_smoothing = 0
    }

    map_gen_setting.autoplace_controls = {
        
        ["enemy-base"] = { frequency = 4, size = 1, richness = 1},
        ["stone"] = { frequency = 0.5, size = 2, richness = 2},
        ["iron-ore"] = { frequency = 0.5, size = 2, richness = 2},
        ["coal"] = { frequency = 0.5, size = 2, richness = 2},
        ["copper-ore"] = { frequency = 0.5, size = 2, richness = 2},
        ["crude-oil"] = { frequency = 1, size = 1, richness = 2},
        ["trees"] = { frequency = 0.5, size = 0.5, richness = 1 },
        ["rocks"] = { frequency = 2, size = 1, richness = 1},
        ["water"] = { frequency = 1, size = 1, richness = 1 },
        ["uranium-ore"] = { frequency = 1, size = 1, richness = 1 },
        ["nauvis_cliff"] = { frequency = 2, size = 1, richness = 1},
    }

    map_gen_setting.autoplace_settings["tile"] =
    {
        settings =
        {
            ["mickora_grass-1"] = {},
            ["mickora_grass-2"] = {},
            ["dry-dirt"] = {},
            ["dirt-1"] = {},
            ["dirt-2"] = {},
            ["dirt-3"] = {},
            ["dirt-4"] = {},
            ["dirt-5"] = {},
            ["dirt-6"] = {},
            ["dirt-7"] = {},
            ["sand-1"] = {},
            ["sand-2"] = {},
            ["sand-3"] = {},
            ["red-desert-0"] = {},
            ["red-desert-1"] = {},
            ["red-desert-2"] = {},
            ["red-desert-3"] = {},
            ["water"] = {},
            ["deepwater"] = {},

          --volcanic tiles
          ["volcanic-soil-light"] = {},
          ["volcanic-ash-light"] = {},
        }
    }
    return map_gen_setting
end
-- increse stone patch size in start area
-- data.raw["resource"]["stone"]["autoplace"]["starting_area_size"] = 5500 * (0.005 / 3)

--END MAP GEN

local nauvis = data.raw["planet"]["nauvis"]
local planet_lib = require("__PlanetsLib__.lib.planet")
local start_astroid_spawn_rate =
{
  probability_on_range_chunk =
  {
    {position = 0.1, probability = asteroid_util.nauvis_chunks, angle_when_stopped = asteroid_util.chunk_angle},
    {position = 0.9, probability = asteroid_util.fulgora_chunks, angle_when_stopped = asteroid_util.chunk_angle}
  },
  type_ratios =
  {
    {position = 0.1, ratios = asteroid_util.aquilo_ratio},
    {position = 0.9, ratios = asteroid_util.fulgora_ratio},
  }
}
local start_astroid_spawn = asteroid_util.spawn_definitions(start_astroid_spawn_rate, 0.1)


local mickora= 
{
    type = "planet",
    name = "mickora", 
    solar_power_in_space = nauvis.solar_power_in_space,
    icon = "__planet-mickora__/graphics/planet-mickora.png",
    icon_size = 512,
    label_orientation = 0.55,
    starmap_icon = "__planet-mickora__/graphics/planet-mickora.png",
    starmap_icon_size = 512,
    magnitude = nauvis.magnitude,
    surface_properties = {
        ["solar-power"] = 0,
        ["pressure"] = nauvis.surface_properties["pressure"],
        ["magnetic-field"] = nauvis.surface_properties["magnetic-field"],
        ["day-night-cycle"] = nauvis.surface_properties["day-night-cycle"],
    },
    surface_render_parameters =
    {
        day_night_cycle_color_lookup = {
            {0.0, "__core__/graphics/color_luts/night.png"},
            {0.5, "__core__/graphics/color_luts/night.png"},
        }
    },
    map_gen_settings = MapGen_Mickora(),
    asteroid_spawn_influence = 1,
    asteroid_spawn_definitions = start_astroid_spawn
}

mickora.orbit = {
    parent = {
        type = "space-location",
        name = "star",
    },
    distance = 20,
    orientation = 0.35
}

--local mickora_connection = {
--    type = "space-connection",
--    name = "fulgora-mickora",
--    from = "fulgora",
--    to = "mickora",
--    subgroup = data.raw["space-connection"]["nauvis-fulgora"].subgroup,
--    length = 7000,
--    asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_fulgora),
--  }

PlanetsLib:extend({mickora})

--data:extend{mickora_connection}

data:extend {{
    type = "technology",
    name = "planet-discovery-mickora",
    icons = util.technology_icon_constant_planet("__planet-mickora__/graphics/planet-mickora.png"),
    icon_size = 256,
    essential = true,
    localised_description = {"space-location-description.mickora"},
    effects = {
        {
            type = "unlock-space-location",
            space_location = "mickora",
            use_icon_overlay_constant = true
        },
    },
    prerequisites = {
        "space-science-pack",
    },
    unit = {
        count = 200,
        ingredients = {
            {"automation-science-pack",      1},
            {"logistic-science-pack",        1},
            {"chemical-science-pack",        1},
            {"space-science-pack",           1}
        },
        time = 60,
    },
    order = "ea[mickora]",
}}

APS.add_planet{name = "mickora", filename = "__planet-mickora__/mickora.lua", technology = "planet-discovery-mickora"}