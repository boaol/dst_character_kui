local assets = {
    Asset("ANIM", "anim/kuijiang_hat.zip"),
    Asset("IMAGE", "images/inventoryimages/kuijiang_hat.tex"),
    Asset("ATLAS", "images/inventoryimages/kuijiang_hat.xml")
}

local prefabs = {}

local function kuijiang_hat_light()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
    inst.entity:AddNetwork()

    inst:AddTag("FX")

    inst.Light:SetIntensity(0.9)
    inst.Light:SetRadius(5)
    inst.Light:SetFalloff(1)
    inst.Light:SetColour(80 / 128, 240 / 255, 180 / 128, 1)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false

    return inst
end

local function hat_lighton(inst, owner)
    if not inst.components.fueled:IsEmpty() then
        if inst._light == nil or not inst._light:IsValid() then
            inst._light = SpawnPrefab("kuijiang_hat_light")
        end
        if owner ~= nil then
            inst._light.entity:SetParent(owner.entity)
        end
        inst.components.fueled:StartConsuming()
    elseif owner ~= nil then
        onequiphat(inst, owner)
    end
end

local function hat_lightoff(inst)
    inst.components.fueled:StopConsuming()
    if inst._light ~= nil then
        if inst._light:IsValid() then
            inst._light:Remove()
        end
        inst._light = nil
    end

end

local function hat_perish(inst)
    local equippable = inst.components.equippable
    if equippable ~= nil and equippable:IsEquipped() then
        local owner = inst.components.inventoryitem ~= nil and inst.components.inventoryitem.owner or nil
        if owner ~= nil then
            local data = {
                prefab = inst.prefab,
                equipslot = equippable.equipslot
            }
            hat_lightoff(inst)
            owner:PushEvent("torchranout", data)
            return
        end
    end
    hat_lightoff(inst)
end

local function hat_takefuel(inst)
    local owner = inst.components.inventoryitem ~= nil and inst.components.inventoryitem.owner or nil
    if inst.components.equippable ~= nil and inst.components.equippable:IsEquipped() then
        hat_lighton(inst, owner)
    end
end

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
            hat_lighton(inst, owner)
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
        hat_lighton(inst, owner)
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
    hat_lightoff(inst)
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

    inst:AddComponent("fueled")
    inst.components.fueled.fueltype = FUELTYPE.CAVE
    inst.components.fueled:InitializeFuelLevel(TUNING.MINERHAT_LIGHTTIME)
    inst.components.fueled:SetDepletedFn(hat_perish)
    inst.components.fueled:SetTakeFuelFn(hat_takefuel)
    inst.components.fueled:SetFirstPeriod(TUNING.TURNON_FUELED_CONSUMPTION, TUNING.TURNON_FULL_FUELED_CONSUMPTION)
    inst.components.fueled.accepting = true

    inst:AddComponent("inspectable")
    inst:AddComponent("waterproofer")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/kuijiang_hat.xml"

    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
    inst.components.equippable:SetOnEquip(onequiphat)
    inst.components.equippable:SetOnUnequip(onunequiphat)
    inst.components.equippable.dapperness = TUNING.DAPPERNESS_LARGE

    inst:AddComponent("tradable")

    MakeHauntableLaunchAndPerish(inst)
    return inst
end

return Prefab("kuijiang_hat", fn, assets, prefabs), Prefab("kuijiang_hat_light", kuijiang_hat_light)

