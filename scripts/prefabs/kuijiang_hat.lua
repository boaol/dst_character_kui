local assets = {
    Asset("ANIM", "anim/kuijiang_hat.zip"),
    Asset("IMAGE", "images/inventoryimages/kuijiang_hat.tex"),
    Asset("ATLAS", "images/inventoryimages/kuijiang_hat.xml")
}

local prefabs = {}

local function onequiphat(inst, owner)
    if inst.kuijiang_Allshared then
        if owner.prefab == "kuijiang" then
            owner.AnimState:OverrideSymbol("swap_hat", "maozi", "swap_hat")
            owner.AnimState:Show("HAT")
            owner.AnimState:Show("HAT_HAIR")
            owner.AnimState:Hide("HAIR_NOHAT")
            owner.AnimState:Hide("HAIR")

            if owner:HasTag("player") then
                owner.AnimState:Hide("HEAD")
                owner.AnimState:Show("HEAD_HAT")
            end
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
        owner.AnimState:OverrideSymbol("swap_hat", "maozi", "swap_hat")
        owner.AnimState:Show("HAT")
        owner.AnimState:Show("HAT_HAIR")
        owner.AnimState:Hide("HAIR_NOHAT")
        owner.AnimState:Hide("HAIR")

        if owner:HasTag("player") then
            owner.AnimState:Hide("HEAD")
            owner.AnimState:Show("HEAD_HAT")
        end
    end
end

local function onunequiphat(inst, owner)
    owner.AnimState:Hide("HAT_HAIR")
    owner.AnimState:Show("HAIR_NOHAT")
    owner.AnimState:Show("HAIR")

    if owner:HasTag("player") then
        owner.AnimState:Show("HEAD")
        owner.AnimState:Hide("HEAD_HAT")
    end
end

local function finished(inst)
    inst:Remove()
end

local function fn(Sim)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("maozi")
    inst.AnimState:SetBuild("maozi")
    inst.AnimState:PlayAnimation("anim")

    inst:AddTag("hat")
    inst:AddTag("hide")
    inst:AddTag("waterproofer")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")
    inst:AddComponent("waterproofer")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/kuijiang_hat.xml"

    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
    inst.components.equippable:SetOnEquip(onequiphat)
    inst.components.equippable:SetOnUnequip(onunequiphat)
    inst.components.equippable.dapperness = TUNING.TUNING.DAPPERNESS_LARGE

    inst:AddComponent("tradable")

    MakeHauntableLaunchAndPerish(inst)
    return inst
end

return Prefab("kuijiang_hat", fn, assets, prefabs)
