GLOBAL.setmetatable(env, {
    __index = function(t, k)
        return GLOBAL.rawget(GLOBAL, k)
    end
})

local Widget = require("widgets/widget")

-- prefab 
modimport "main/kuijiang_assets.lua"
-- recipes 
modimport "main/kuijiang_recipes.lua"
-- Any containers setting 
modimport "main/kuijiang_containers.lua"
-- Mod Setting
modimport "main/kuijiang_setting.lua"

GLOBAL.PREFAB_SKINS["kuijiang"] =
    "kuijiang_none"
}

-- The character select screen lines  
STRINGS.CHARACTER_TITLES.kuijiang = "葵酱"
STRINGS.CHARACTER_NAMES.kuijiang = "葵酱"
STRINGS.CHARACTER_DESCRIPTIONS.kuijiang = "*简单\n*粗暴\n*漂亮"
STRINGS.CHARACTER_QUOTES.kuijiang = "我才是最可爱的！"

-- Custom speech strings  
STRINGS.CHARACTERS.kuijiang = require "speech_wendy"

-- The character's name as appears in-game  
STRINGS.NAMES.kuijiang = "葵酱"
STRINGS.SKIN_NAMES.kuijiang_none = "葵酱" 

AddModCharacter("kuijiang", "FEMALE")

-- Weapon
STRINGS.NAMES.KUIJIANG_WEAPON_A = "葵酱の小花"
-- Name
STRINGS.RECIPE_DESC.KUIJIANG_WEAPON_A = ""
-- recipes weapon_a describing
STRINGS.CHARACTERS.GENERIC.DESCRIBE.KUIJIANG_WEAPON_A = "是小甜留给我的吗？"
-- check item_a

STRINGS.NAMES.KUIJIANG_WEAPON_B = "葵酱の冰花"
-- Name
STRINGS.RECIPE_DESC.KUIJIANG_WEAPON_B = ""
-- recipes weapon_b describing
STRINGS.CHARACTERS.GENERIC.DESCRIBE.KUIJIANG_WEAPON_B = "可乐必须要加冰的。"
-- check item_b

STRINGS.NAMES.KUIJIANG_WEAPON_C = "葵酱の毁天灭地"
-- Name
STRINGS.RECIPE_DESC.KUIJIANG_WEAPON_C = ""
-- recipes weapon_c describing
STRINGS.CHARACTERS.GENERIC.DESCRIBE.KUIJIANG_WEAPON_C = "肯定是‘一知半解’留下来的。"
-- check item_c

-- hat
STRINGS.NAMES.KUIJIANG_HAT = "葵酱の小萌物"
-- Name
STRINGS.RECIPE_DESC.KUIJIANG_HAT = ""
-- recipes hat describing
STRINGS.CHARACTERS.GENERIC.DESCRIBE.KUIJIANG_HAT = "也有可能是‘星辰’留下的。"
-- check hat

-- armor
STRINGS.NAMES.KUIJIANG_ARMOR = "葵酱の小袋袋"
-- Name
STRINGS.RECIPE_DESC.KUIJIANG_ARMOR = ""
-- recipes armmor describing
STRINGS.CHARACTERS.GENERIC.DESCRIBE.KUIJIANG_ARMOR = "这是葵酱的最爱。"
-- check armmor

TUNING.KUIJIANG_HEALTH = 150
TUNING.KUIJIANG_SANITY = 200
TUNING.KUIJIANG_HUNGER = 150

STRINGS.CHARACTER_SURVIVABILITY.kuijiang = "Happy everyday！/开心游戏每一天！"
