---------------------------------------------------------------------------
-- -- -- ADD INTERMEDIATE
---------------------------------------------------------------------------
data:extend({
  -- -- ITEM
  {
    type = "item",
    name = "im-intermediate-module-1",
    localised_name = "Module frame",
    icon = "__intermediate-module__/graphics/icons/im-intermediate-module-1.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "intermediate-product",
    order = "h[alternative-recipe]-im[intermediate-module-1]",
    stack_size = 50
  },
  {
    type = "item",
    name = "im-intermediate-module-2",
    localised_name = "Module frame 2",
    icon = "__intermediate-module__/graphics/icons/im-intermediate-module-2.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "intermediate-product",
    order = "h[alternative-recipe]-im[intermediate-module-2]",
    stack_size = 50
  },
  {
    type = "item",
    name = "im-intermediate-module-3",
    localised_name = "Module frame 3",
    icon = "__intermediate-module__/graphics/icons/im-intermediate-module-3.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "intermediate-product",
    order = "h[alternative-recipe]-im[intermediate-module-3]",
    stack_size = 50
  },
  -- -- RECIPE
  {
    type = "recipe",
    name = "im-intermediate-module-1",
    energy_required = 15,
    ingredients =
    {
      {"electronic-circuit", 5},
      {"advanced-circuit", 5}
    },
    result = "im-intermediate-module-1",
    enabled = false
  },
  {
    type = "recipe",
    name = "im-intermediate-module-2",
    energy_required = 30,
    ingredients =
    {
      {"im-intermediate-module-1", 4}
    },
    result = "im-intermediate-module-2",
    enabled = false
  },
  {
    type = "recipe",
    name = "im-intermediate-module-3",
    energy_required = 60,
    ingredients =
    {
      {"im-intermediate-module-2", 5}
    },
    result = "im-intermediate-module-3",
    enabled = false
  }
})
---------------------------------------------------------------------------
-- -- -- VANILLA CHANGES
---------------------------------------------------------------------------

-- -- PRODCTIVITY LIMITATIONS
-- item productivity is whitelisted
for _, module_name in pairs({"productivity-module", "productivity-module-2", "productivity-module-3"}) do
  for _, tier in pairs({"-1", "-2", "-3"}) do
    table.insert(data.raw.module[module_name].limitation, "im-intermediate-module" .. tier)
  end
end

-- -- RECIPES
-- adapt vanilla recipes to accept tier frames intermediate instead
local ingredients = {
  ["T1"] = {{"im-intermediate-module-1", 1}},
  ["T2"] = {{"im-intermediate-module-2", 1}, {"advanced-circuit", 5}, {"processing-unit", 5}},
  ["T3"] = {{"im-intermediate-module-3", 1}, {"advanced-circuit", 5}, {"processing-unit", 5}},
}

for _, module_name in pairs({"effectivity-module", "productivity-module", "speed-module"}) do
  -- substitute previous modules with module frames
  data.raw.recipe[module_name        ].ingredients = ingredients.T1
  data.raw.recipe[module_name .. "-2"].ingredients = ingredients.T2
  data.raw.recipe[module_name .. "-3"].ingredients = ingredients.T3

  -- crafting time 15, 30 and 60 is maintaned in modues frames recipe,
  -- so this recipe time can be reduce to ~ processing unit time
  data.raw.recipe[module_name        ].energy_required = 10
  data.raw.recipe[module_name .. "-2"].energy_required = 12
  data.raw.recipe[module_name .. "-3"].energy_required = 15
end

-- -- TECHNOLOGY
-- module frames are unlocked by "Modules" tech which is the common ancestor
data.raw.technology["modules"].effects =
{
  {
    type = "unlock-recipe",
    recipe = "im-intermediate-module-1"
  },
  {
    type = "unlock-recipe",
    recipe = "im-intermediate-module-2"
  },
  {
    type = "unlock-recipe",
    recipe = "im-intermediate-module-3"
  }
}

---------------------------------------------------------------------------
