local assets = {
    Asset("ANIM", "anim/kuijiang_weapon.zip"),
    Asset("ANIM", "anim/swap_kuijiang_weapon.zip"),

    Asset("IMAGE", "images/inventoryimages/kuijiang_weapon_a.tex"),
    Asset("ATLAS", "images/inventoryimages/kuijiang_weapon_a.xml"),

    Asset("IMAGE", "images/inventoryimages/kuijiang_weapon_b.tex"),
    Asset("ATLAS", "images/inventoryimages/kuijiang_weapon_b.xml"),

    Asset("IMAGE", "images/inventoryimages/kuijiang_weapon_c.tex"),
    Asset("ATLAS", "images/inventoryimages/kuijiang_weapon_c.xml")
}

local function onequip(inst, owner)
    if inst.kuijiang_Allshared then
        if owner.prefab == "kuijiang" then
            owner.AnimState:OverrideSymbol("swap_object", "swap_wuqi", "swap_wuqi")
            owner.AnimState:Show("ARM_carry")
            owner.AnimState:Hide("ARM_normal")
        else
            owner:DoTaskInTime(0, function()
                local inventory = owner.components.inventory
                if inventory then
                    inventory:DropItem(inst)
                end
                local talker = owner.components.talker
                if talker then
                    talker:Say("I can not use it")
                end
            end)
        end
    else
        owner.AnimState:OverrideSymbol("swap_object", "swap_wuqi", "swap_wuqi")
        owner.AnimState:Show("ARM_carry")
        owner.AnimState:Hide("ARM_normal")
    end
end

local function onunequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
end

local function SpawnIceFx(inst, target)
    if not inst then
        return
    end
    if not target then
        return
    end

    inst.SoundEmitter:PlaySound("dontstarve/creatures/deerclops/swipe")

    local numFX = math.random(15, 20)
    local pos = inst:GetPosition()
    local targetPos = target:GetPosition()
    local vec = targetPos - pos
    vec = vec:Normalize()
    local dist = pos:Dist(targetPos)
    local angle = inst:GetAngleToPoint(targetPos:Get())

    for i = 1, numFX do
        inst:DoTaskInTime(math.random() * 0.25, function(inst)
            local prefab = "icespike_fx_" .. math.random(1, 4)
            local fx = SpawnPrefab(prefab)
            if fx then
                local x = GetRandomWithVariance(0, 2)
                local z = GetRandomWithVariance(0, 2)
                local offset = (vec * math.random(dist * 0.25, dist)) + Vector3(x, 0, z)
                fx.Transform:SetPosition((offset + pos):Get())
                local x, y, z = fx.Transform:GetWorldPosition()
                local r = 1.5
                local dmg = math.random() * 50 * 1
                local ents = TheSim:FindEntities(x, y, z, r)
                for k, v in pairs(ents) do
                    if v and v.components.health and not v.components.health:IsDead() and v.components.combat and v ~=
                        inst and not (v.components.follower and v.components.follower.leader == inst) and
                        (TheNet:GetPVPEnabled() or not v:HasTag("player")) then
                        v.components.combat:GetAttacked(inst, dmg)
                        if v.components.freezable then
                            v.components.freezable:AddColdness(2)
                            v.components.freezable:SpawnShatterFX()
                        end
                    end
                end
            end
        end)
    end
end

local function onattack(weapon, attacker, target)
    if attacker and target.components.freezable then
        target.components.freezable:AddColdness(2)
        SpawnIceFx(attacker, target)
        if attacker.components.hunger then
            attacker.components.hunger:DoDelta(-2)
        end
    end
end

local function onattack_old(weapon, attacker, target)
    if attacker and target.components.freezable then
        target.components.freezable:AddColdness(1)
        if attacker.components.hunger then
            attacker.components.hunger:DoDelta(-1)
        end
    end
end

local function createWeapon(maxUses, mineEffectiveness, chopEffectiveness, atlasname, attackFn)
    return function()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()

        MakeInventoryPhysics(inst)

        inst.AnimState:SetBank("wuqi")
        inst.AnimState:SetBuild("wuqi")
        inst.AnimState:PlayAnimation("idle")

        inst:AddTag("sharp")
        inst:AddTag("pointy")

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst:AddComponent("weapon")
        inst.components.weapon:SetDamage(TUNING.kuijiangWeaponDamage)
        inst.components.weapon:SetRange(TUNING.kuijiangWeaponRange, TUNING.kuijiangWeaponRange)
        if attackFn then
            inst.components.weapon:SetOnAttack(attackFn)
        end

        inst:AddComponent("finiteuses")
        inst.components.finiteuses:SetMaxUses(maxUses)
        inst.components.finiteuses:SetUses(maxUses)
        inst.components.finiteuses:SetOnFinished(inst.Remove)

        inst:AddComponent("tool")
        inst.components.tool:SetAction(ACTIONS.MINE, mineEffectiveness)
        inst.components.tool:SetAction(ACTIONS.CHOP, chopEffectiveness)

        inst:AddComponent("inspectable")

        inst:AddComponent("inventoryitem")
        inst.components.inventoryitem.atlasname = atlasname

        inst:AddComponent("equippable")
        inst.components.equippable:SetOnEquip(onequip)
        inst.components.equippable:SetOnUnequip(onunequip)
        inst.components.equippable.walkspeedmult = TUNING.kuijiangWeaponSpeed

        MakeHauntableLaunch(inst)

        return inst
    end
end

return Prefab("kuijiang_weapon_a", createWeapon(180, 1.8, 3, "images/inventoryimages/kuijiang_weapon_a.xml", false),
              assets),
       Prefab("kuijiang_weapon_b",
              createWeapon(230, 2, 4, "images/inventoryimages/kuijiang_weapon_b.xml", onattack_old), assets), Prefab(
           "kuijiang_weapon_c", createWeapon(300, 2, 4, "images/inventoryimages/kuijiang_weapon_c.xml", onattack),
           assets)
