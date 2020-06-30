--MOD Name
name = "[DST]葵酱"

-- Mod Authors
author = "qiaoqiao0429,Ciel,勿心十"

--MOD Version
version = "1.06"

--MOD Description
description = "Added new version of interface support."

--link

--MOD priority 优先级设置，需要调整优先级请到这里更改Priority信息
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
--Server special
--server_only_mod = false

server_filter_tags = {"kuihua"}

-- Preview image
icon_atlas = "modicon.xml"
icon = "modicon.tex"

local never = {{description = "", data = false}}
--Refer to other mod designs 增加标题。
local function Breaker(title, hover)
	return {
		name = title,
		hover = hover,
		options = never,
		default = false
	}
end

--封装MOD设置函数

local function Setparameters_a(a,b,c,d,e,f,h,i,j,k,l,m)
    return {
	{description = a, data = b},{description = c, data = d},{description = e, data = f},{description = h, data = i},{description = j, data = k},{description = l, data = m}
	}
end

local function Setparameters_b(a,b,c,d,e,f,g,h)
    return {
	{description = a, data = b},{description = c, data = d},{description = e, data = f},{description = g, data = h}
	}
end

--Add mod setting
local function AddConfig(name, label, hover, options, default)
    return {name = name, label = label, hover = hover or "", options = options, default = default}
end

local Switch = {{description = "true", data = true},{description = "false", data = false}}

configuration_options = {
    
	Breaker("weapon_setting"),
    AddConfig("Weapon_Damage","Weapon Damage","Set your weapon damage to 50 by default.",Setparameters_a(20,20,50,50,70,70,100,100,150,150,200,200),50),
	AddConfig("Weapon_Range","Weapon Range","Set your weapon attack range to 2 by default.",Setparameters_a(1,1,2,2,3,3,4,4,5,5,10,10),2),
	AddConfig("Weapon_speed","Weapon speed","Movement coefficient while carrying a weapon, default coefficient 1.2.",Setparameters_b(1,1,1.2,1.2,1.5,1.5,2,2),1.2),
	AddConfig("Weapon_light","Weapon light","Can the weapon light up?",Switch,true),
	Breaker("other_setting"),
	AddConfig("Update_hat_parameters","Hat durability","Are hats infinitely durable?",Switch,true),
	AddConfig("Weapon_hammer","hammer","Can you use it as a hammer?",Switch,false),
	AddConfig("Weapon_shovel","shovel","Can you use it as a shovel?",Switch,false),
	AddConfig("Allsharing","Equipment sharing","Sets whether other characters can use the kuemei items.",Switch,false)
}
