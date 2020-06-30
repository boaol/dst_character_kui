-- perfab
PrefabFiles = {
    "kuijiang",
    "kuijiang_hat",
    "kuijiang_armor",
    "kuijiang_weapon"
}

-- assets
Assets = {

    -- ANIM

    Asset("ANIM", "anim/kuijiang.zip"),
    Asset("ANIM", "anim/ghost_kuijiang_build.zip"),

    Asset("ANIM", "anim/kuijiang_hat.zip"),

    Asset("ANIM", "anim/kuijiang_armor.zip"),

    Asset("ANIM", "anim/kuijiang_weapon.zip"),
    Asset("ANIM", "anim/swap_kuijiang_weapon.zip"),

    Asset("ANIM", "anim/ui_kuijiang.zip"),

    -- IMAGE

    Asset("IMAGE", "bigportraits/kuijiang.tex"),
    Asset("ATLAS", "bigportraits/kuijiang.xml"),

    Asset("IMAGE", "bigportraits/kuijiang_none.tex"),
    Asset("ATLAS", "bigportraits/kuijiang_none.xml"),

    Asset("IMAGE", "bigportraits/kuijiang_none_oval.tex"),
    Asset("ATLAS", "bigportraits/kuijiang_none_oval.xml"),

    Asset("IMAGE", "images/avatars/avatar_kuijiang.tex"),
    Asset("ATLAS", "images/avatars/avatar_kuijiang.xml"),

    Asset("IMAGE", "images/avatars/avatar_ghost_kuijiang.tex"),
    Asset("ATLAS", "images/avatars/avatar_ghost_kuijiang.xml"),

    Asset("IMAGE", "images/map_icons/kuijiang.tex"),
    Asset("ATLAS", "images/map_icons/kuijiang.xml"),

    Asset("IMAGE", "images/avatars/self_inspect_kuijiang.tex"),
    Asset("ATLAS", "images/avatars/self_inspect_kuijiang.xml"),

    Asset("IMAGE", "images/names_kuijiang.tex"),
    Asset("ATLAS", "images/names_kuijiang.xml"),

    Asset("IMAGE", "images/saveslot_portraits/kuijiang.tex"),
    Asset("ATLAS", "images/saveslot_portraits/kuijiang.xml"),

    Asset("IMAGE", "images/kuijiang_recipe.tex"),
    Asset("ATLAS", "images/kuijiang_recipe.xml"),

    -- item

    Asset("IMAGE", "images/inventoryimages/kuijiang_hat.tex"),
    Asset("ATLAS", "images/inventoryimages/kuijiang_hat.xml"),

    Asset("IMAGE", "images/inventoryimages/kuijiang_armor.tex"),
    Asset("ATLAS", "images/inventoryimages/kuijiang_armor.xml"),

    Asset("IMAGE", "images/inventoryimages/kuijiang_weapon_a.tex"),
    Asset("ATLAS", "images/inventoryimages/kuijiang_weapon_a.xml"),

    Asset("IMAGE", "images/inventoryimages/kuijiang_weapon_b.tex"),
    Asset("ATLAS", "images/inventoryimages/kuijiang_weapon_b.xml"),

    Asset("IMAGE", "images/inventoryimages/kuijiang_weapon_c.tex"),
    Asset("ATLAS", "images/inventoryimages/kuijiang_weapon_c.xml")

}

local Loading = {}

local RegisterPrefabs = GLOBAL.RegisterPrefabs
GLOBAL.RegisterPrefabs = function(prefab, ...)
    for i, asset in ipairs(prefab.assets) do
        if Loading[asset.file] then
            asset.file = Loading[asset.file]
        end
    end
    RegisterPrefabs(prefab, ...)
end

AddMinimapAtlas("images/map_icons/kuijiang.xml")
