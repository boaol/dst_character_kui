-- MOD Name
name = "[DST]葵酱 Balanced local"

-- Mod Authors
author = "boaol"

-- MOD Version
version = "1.08"

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
        description = "true",
        data = true
    },
    {
        description = "false",
        data = false
    }
}

configuration_options = {

    Breaker("weapon_setting"),
    AddConfig("Weapon_Damage", "Weapon Damage", "Set your weapon damage to 50 by default.", {
        option(20, 20),
        option(50, 50),
        option(70, 70),
        option(100, 100)
    }, 50),
    AddConfig("Weapon_Range", "Weapon Range", "Set your weapon attack range to 2 by default.", {
        option(1, 1),
        option(2, 2),
        option(3, 3),
        option(4, 4),
        option(5, 5),
        option(10, 10)
    }, 2),
    AddConfig("Weapon_speed", "Weapon speed", "Movement coefficient while carrying a weapon, default coefficient 1.2.",
              {
        option(1, 1),
        option(1.2, 1.2),
        option(1.5, 1.5),
        option(2, 2),
        option(5, 5)
    }, 1.2),
    AddConfig("Backpack_armor", "Backpack armor", "Set your backpack armor to 20% by default", {
        option('0%', 0),
        option('20%', 0.2),
        option('40%', 0.4),
        option('60%', 0.6),
        option('80%', 0.8)
    }, 0.2),
    Breaker("other_setting"),
    AddConfig("Weapon_hammer", "hammer", "Can you use it as a hammer?(Not applicable to level-1 weapon)", Switch, false),
    AddConfig("Weapon_shovel", "shovel", "Can you use it as a shovel?(Not applicable to level-1 weapon)", Switch, false),
    AddConfig("Allsharing", "Equipment sharing", "Sets whether other characters can use the kuemei items.", Switch,
              false)
}
