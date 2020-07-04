-- MOD Name
name = "[DST]葵酱 Balanced local"

-- Mod Authors
author = "boaol"

-- MOD Version
version = "1.10"

-- MOD Description
description = "\n Balanced version of Kuijiang"

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

local function option(description, data)
    return {
        description = description,
        data = data
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
        description = "关闭",
        data = false
    },
    {
        description = "开启",
        data = true
    }
}

configuration_options = {

    Breaker("武器设置"),
    AddConfig("Weapon_Damage", "武器伤害", "设置你的武器伤害，默认50。", {
        option(20, 20),
        option(50, 50),
        option(70, 70),
        option(100, 100)
    }, 50),
    AddConfig("Weapon_Range", "攻击距离", "设置你的武器攻击距离，默认范围2点。", {
        option(1, 1),
        option(2, 2),
        option(3, 3),
        option(4, 4),
        option(5, 5)
    }, 2),
    AddConfig("Weapon_speed", "移动速度", "携带武器时的移动系数，默认系数1.2。", {
        option(1, 1),
        option(1.2, 1.2),
        option(1.5, 1.5),
        option(2, 2)
    }, 1.2),
    AddConfig("Backpack_armor", "背包护甲", "设置你的背包护甲，默认20%", {
        option('0%', 0),
        option('20%', 0.2),
        option('40%', 0.4),
        option('60%', 0.6),
        option('80%', 0.8)
    }, 0.2),
    Breaker("其他设置"),
    AddConfig("Backpack_fridge", "背包保鲜", "是否为保鲜背包", Switch, false),
    AddConfig("Weapon_hammer", "锤子锤子", "可以当成锤子来使用吗？(不适用于一级武器)", Switch,
              false),
    AddConfig("Weapon_shovel", "铲子铲子", "可以当成铲子来使用吗？(不适用于一级武器)", Switch,
              false),
    AddConfig("Allsharing", "装备共享", "设置其他角色是否能使用葵酱的道具。", Switch, false)
}
