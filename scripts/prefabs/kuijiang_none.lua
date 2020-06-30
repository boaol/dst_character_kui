local assets = {
    Asset("ANIM", "anim/kuijiang.zip"),
    Asset("ANIM", "anim/ghost_kuijiang_build.zip")
}

local skins = {
    normal_skin = "kuijiang",
    ghost_skin = "ghost_kuijiang_build"
}

local base_prefab = "kuijiang"

local tags = {
    "BASE",
    "kuijiang",
    "CHARACTER"
}

return CreatePrefabSkin("kuijiang_none", {
    base_prefab = base_prefab,
    skins = skins,
    assets = assets,
    skin_tags = tags,

    build_name_override = "kuijiang",
    rarity = "Character"
})
