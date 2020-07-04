TUNING.kuijiangWeaponDamage = GetModConfigData("Weapon_Damage")
TUNING.kuijiangWeaponRange = GetModConfigData("Weapon_Range")
TUNING.kuijiangWeaponSpeed = GetModConfigData("Weapon_speed")
TUNING.kuijiangBackpackArmor = GetModConfigData("Backpack_armor")

local kuijiang_fridge = GetModConfigData("Backpack_fridge")
if kuijiang_fridge then
    local function backpack_fridge(inst)
        inst:AddTag("fridge")
    end
    AddPrefabPostInit("kuijiang_armor", backpack_fridge)
end

local kuijiang_hammer = GetModConfigData("Weapon_hammer")
if kuijiang_hammer then
    local function weapon_hammer(inst)
        if inst.components.tool then
            inst.components.tool:SetAction(ACTIONS.HAMMER)
        end
    end
    AddPrefabPostInit("kuijiang_weapon_b", weapon_hammer)
    AddPrefabPostInit("kuijiang_weapon_c", weapon_hammer)
end

local kuijiang_shovel = GetModConfigData("Weapon_shovel")
if kuijiang_shovel then
    local function weapon_shovel(inst)
        if inst.components.tool then
            inst.components.tool:SetAction(ACTIONS.DIG)
        end
    end
    AddPrefabPostInit("kuijiang_weapon_b", weapon_shovel)
    AddPrefabPostInit("kuijiang_weapon_c", weapon_shovel)
end

local kuijiang_shared = GetModConfigData("Allsharing")

local function UpdateShared(inst)
    inst.kuijiang_Allshared = true
end

if not kuijiang_shared then
    AddPrefabPostInit("kuijiang_hat", UpdateShared)
    AddPrefabPostInit("kuijiang_armor", UpdateShared)
    AddPrefabPostInit("kuijiang_weapon_a", UpdateShared)
    AddPrefabPostInit("kuijiang_weapon_b", UpdateShared)
    AddPrefabPostInit("kuijiang_weapon_c", UpdateShared)
else
    AddPrefabPostInit("kuijiang_hat", UpdateShared)
    AddPrefabPostInit("kuijiang_weapon_c", UpdateShared)
end
