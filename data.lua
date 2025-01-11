--data.lua
local asteroid_util = require("__space-age__.prototypes.planet.asteroid-spawn-definitions")


--START MAP GEN
function MapGen_Mickora()
    -- Nauvis-based generation
    local map_gen_setting = table.deepcopy(data.raw.planet.nauvis.map_gen_settings)

    --map_gen_setting.terrain_segmentation = "very-high"

    map_gen_setting.autoplace_controls = {
        
        ["enemy-base"] = { frequency = 2, size = 1, richness = 1},
        ["stone"] = { frequency = 0.5, size = 2, richness = 2},
        ["iron-ore"] = { frequency = 0.5, size = 2, richness = 2},
        ["coal"] = { frequency = 0.5, size = 2, richness = 2},
        ["copper-ore"] = { frequency = 0.5, size = 2, richness = 2},
        ["crude-oil"] = { frequency = 0.5, size = 2, richness = 2},
        ["trees"] = { frequency = 1, size = 1, richness = 1 },
        ["rocks"] = { frequency = 1, size = 1, richness = 1},
        ["water"] = { frequency = 1, size = 1, richness = 1 },
        ["uranium-ore"] = { frequency = 0, size = 0, richness = 0 },
    }
    return map_gen_setting
end
-- increse stone patch size in start area
-- data.raw["resource"]["stone"]["autoplace"]["starting_area_size"] = 5500 * (0.005 / 3)

--END MAP GEN

local nauvis = data.raw["planet"]["nauvis"]
local planet_lib = require("__PlanetsLib__.lib.planet")

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
    map_gen_settings = MapGen_Mickora()
}

mickora.orbit = {
    parent = {
        type = "space-location",
        name = "star",
    },
    distance = 2,
    orientation = 0.8
}

local mickora_connection = {
    type = "space-connection",
    name = "nauvis-mickora",
    from = "nauvis",
    to = "mickora",
    subgroup = data.raw["space-connection"]["nauvis-vulcanus"].subgroup,
    length = 15000,
    asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_gleba),
  }

PlanetsLib:extend({mickora})

data:extend{mickora_connection}

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