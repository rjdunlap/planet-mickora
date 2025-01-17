local mickora_grass_base=table.deepcopy(data.raw["tile"]["grass-1"])

local color= {66, 35, 80}


for i = 1,2,1 do
    local mickora_grass=table.deepcopy(mickora_grass_base)
    mickora_grass.name="mickora_grass-"..tostring(i)
    mickora_grass.autoplace = {probability_expression = 'expression_in_range_base(0.45, -10, 0.55, 0.35) + 0.25*noise_layer_noise('..tostring(i)..')'}
    mickora_grass.localised_name={"tile-name.mickora_grass",tostring(i)}
    mickora_grass.variants = tile_variations_template(
    "__alien-biomes-graphics__/graphics/terrain/vegetation-purple-grass-"..tostring(i)..".png", "__base__/graphics/terrain/masks/transition-1.png",
    {
   
      max_size = 4,
      [1] = { weights = {0.085, 0.085, 0.085, 0.085, 0.087, 0.085, 0.065, 0.085, 0.045, 0.045, 0.045, 0.045, 0.005, 0.025, 0.045, 0.045 } },
      [2] = { probability = 1, weights = {0.070, 0.070, 0.025, 0.070, 0.070, 0.070, 0.007, 0.025, 0.070, 0.050, 0.015, 0.026, 0.030, 0.005, 0.070, 0.027 }, },
      [4] = { probability = 1.00, weights = {0.070, 0.070, 0.070, 0.070, 0.070, 0.070, 0.015, 0.070, 0.070, 0.070, 0.015, 0.050, 0.070, 0.070, 0.065, 0.070 }, },
      --[8] = { probability = 1.00, weights = {0.090, 0.125, 0.125, 0.125, 0.125, 0.125, 0.125, 0.025, 0.125, 0.005, 0.010, 0.100, 0.100, 0.010, 0.020, 0.020} }
    }
    
   
    
  )
  mickora_grass.absorptions_per_second={  }
  mickora_grass.layer=26+i
  mickora_grass.map_color=color
  data:extend{mickora_grass}
end





