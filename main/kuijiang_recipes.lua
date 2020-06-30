GLOBAL.setmetatable(env, {
    __index = function(t, k)
        return GLOBAL.rawget(GLOBAL, k)
    end
})

GLOBAL.STRINGS.TABS.kuijiang = "kuijiang"
GLOBAL.RECIPETABS["kuijiang"] = {
    str = "kuijiang",
    sort = 12,
    icon = "kuijiang_recipe.tex",
    icon_atlas = "images/kuijiang_recipe.xml",
    owner_tag = "kuijiang"
}

AddRecipe("kuijiang_hat", {
    Ingredient("silk", 6)
}, RECIPETABS.kuijiang, TECH.NONE, nil, nil, nil, nil, "kuijiang", "images/inventoryimages/kuijiang_hat.xml",
          "kuijiang_hat.tex")
AddRecipe("kuijiang_armor", {
    Ingredient("pigskin", 4),
    Ingredient("silk", 6),
    Ingredient("rope", 2)
}, RECIPETABS.kuijiang, TECH.NONE, nil, nil, nil, nil, "kuijiang", "images/inventoryimages/kuijiang_armor.xml",
          "kuijiang_armor.tex")
AddRecipe("kuijiang_weapon_a", {
    Ingredient("rocks", 10),
    Ingredient("goldnugget", 3),
    Ingredient("fireflies", 3)
}, RECIPETABS.kuijiang, TECH.NONE, nil, nil, nil, nil, "kuijiang", "images/inventoryimages/kuijiang_weapon_a.xml",
          "kuijiang_weapon_a.tex")
AddRecipe("kuijiang_weapon_b", {
    Ingredient("kuijiang_weapon_a", 1, "images/inventoryimages/kuijiang_weapon_a.xml"),
    Ingredient("bluegem", 3),
    Ingredient("goldnugget", 10)
}, RECIPETABS.kuijiang, TECH.NONE, nil, nil, nil, nil, "kuijiang", "images/inventoryimages/kuijiang_weapon_b.xml",
          "kuijiang_weapon_b.tex")
AddRecipe("kuijiang_weapon_c", {
    Ingredient("kuijiang_weapon_b", 1, "images/inventoryimages/kuijiang_weapon_b.xml"),
    Ingredient("transistor", 2),
    Ingredient("deerclops_eyeball", 1)
}, RECIPETABS.kuijiang, TECH.NONE, nil, nil, nil, nil, "kuijiang", "images/inventoryimages/kuijiang_weapon_c.xml",
          "kuijiang_weapon_c.tex")
