-- MOD Name
name = "[DST]葵酱 Balanced"

-- Mod Authors
author = "boaol"

-- MOD Version
version = "1.07"

-- MOD Description
description = ""

-- link

api_version = 10
priority = -100000

-- Engine/DLC Compatibility
-- Don't Starve Together
dst_compatible = true
-- Don't Starve(it‘s to not work)
dont_starve_compatible = false
-- Don't Starve: Shipwrecked
shipwrecked_compatible = false
-- Don't Starve: Reign of Giants
reign_of_giants_compatible = false

-- Mods which add new objects are required by all clients.
all_clients_require_mod = true
-- Client-only mods don't affect other players or the server.
client_only_mod = false
-- Server special
-- server_only_mod = false

server_filter_tags = {
    "kuihua"
}

-- Preview image
icon_atlas = "modicon.xml"
icon = "modicon.tex"

local never = {
    {
        description = "",
        data = false
    }
}
-- Refer to other mod designs 
local function Breaker(title, hover)
    return {
        name = title,
        hover = hover,
        options = never,
        default = false
    }
end

-- 封装MOD设置函数

local function Setparameters_a(a, b, c, d, e, f, h, i, j, k, l, m)
    return {
        {
            description = a,
            data = b
        },
        {
            description = c,
            data = d
        },
        {
            description = e,
            data = f
        },
        {
            description = h,
            data = i
        },
        {
            description = j,
            data = k
        },
        {
            description = l,
            data = m
        }
    }
end

local function Setparameters_b(a, b, c, d, e, f, g, h)
    return {
        {
            description = a,
            data = b
        },
        {
            description = c,
            data = d
        },
        {
            description = e,
            data = f
        },
        {
            description = g,
            data = h
        }
    }
end

-- Add mod setting
local function AddConfig(name, label, hover, options, default)
    return {
        name = name,
        label = label,
        hover = hover or "",
        options = options,
        default = default
    }
end

local Switch = {
    {
        description = "开启",
        data = true
    },
    {
        description = "关闭",
        data = false
    }
}

configuration_options = {

    Breaker("武器设置"),
    AddConfig("Weapon_Damage", "武器伤害", "设置你的武器伤害，默认50。",
              Setparameters_a(20, 20, 50, 50, 70, 70, 100, 100, 150, 150, 200, 200), 50),
    AddConfig("Weapon_Range", "攻击距离", "设置你的武器攻击距离，默认范围2点。",
              Setparameters_a(1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 10, 10), 2),
    AddConfig("Weapon_speed", "移动速度", "携带武器时的移动系数，默认系数1.2。",
              Setparameters_b(1, 1, 1.2, 1.2, 1.5, 1.5, 2, 2), 1.2),
    AddConfig("Weapon_light", "武器发光", "武器是否可以发光？", Switch, true),
    Breaker("其他设置"),
    AddConfig("Update_hat_parameters", "帽子耐久", "帽子是无限耐久的吗？", Switch, true),
    AddConfig("Weapon_hammer", "锤子锤子", "可以当成锤子来使用吗？", Switch, false),
    AddConfig("Weapon_shovel", "铲子铲子", "可以当成铲子来使用吗？", Switch, false),
    AddConfig("Allsharing", "装备共享", "设置其他角色是否能使用葵酱的道具。", Switch, false)
}
