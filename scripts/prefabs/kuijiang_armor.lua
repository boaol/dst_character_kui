local assets = {
    Asset("ANIM", "anim/kuijiang_armor.zip"),
    Asset("ANIM", "anim/ui_kuijiang.zip"),
    Asset("ATLAS", "images/inventoryimages/kuijiang_armor.xml"),
    Asset("IMAGE", "images/inventoryimages/kuijiang_armor.tex")
}

local function OnBlocked(owner, data)
    owner.SoundEmitter:PlaySound("dontstarve/wilson/hit_armour")
end

local function onequip(inst, owner)
    if inst.kuijiang_Allshared then
        if owner.prefab == "kuijiang" then
            local skin_build = inst:GetSkinBuild()
            if skin_build ~= nil then
                owner:PushEvent("equipskinneditem", inst:GetSkinName())
                owner.AnimState:OverrideItemSkinSymbol("swap_body", skin_build, "swap_body", inst.GUID, "cloak_ice")
            else
                owner.AnimState:OverrideSymbol("swap_body", "kuijiang_armor", "swap_body")
            end
            if inst.components.container ~= nil then
                inst.components.container:Open(owner)
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
        local skin_build = inst:GetSkinBuild()

        owner.AnimState:OverrideSymbol("swap_body", "kuijiang_armor", "swap_body")

        if inst.components.container ~= nil then
            inst.components.container:Open(owner)
        end
    end
end

local function onopen(inst, owner)
    if inst.components.container ~= nil then
        inst.components.container:Open(owner)
    end
end

local function onclose(inst, owner)
    if inst.components.container ~= nil then
        inst.components.container:Close(owner)
    end
end

local function onunequip(inst, owner)
    owner.AnimState:ClearOverrideSymbol("swap_body")
    inst:RemoveEventCallback("blocked", OnBlocked, owner)
    if inst.components.container ~= nil then
        inst.components.container:Close(owner)
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("cloak_ice")
    inst.AnimState:SetBuild("kuijiang_armor")
    inst.AnimState:PlayAnimation("anim")

    inst:AddTag("backpack")
    -- inst:AddTag("fridge")
    -- inst.MiniMapEntity:SetIcon("backpack.png")
    inst.foleysound = "dontstarve/movement/foley/backpack"

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.cangoincontainer = false
    inst.components.inventoryitem.atlasname = "images/inventoryimages/kuijiang_armor.xml"

    inst:AddComponent("container")
    inst.components.container:WidgetSetup("kuijiang_armor")
    inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = onclose

    inst:AddComponent("armor")
    inst.components.armor:InitIndestructible(0.2)

    if TUNING.kuijiangBackpackArmor > 0 then
        inst:AddComponent("armor")
        inst.components.armor:InitIndestructible(TUNING.kuijiangBackpackArmor)
        inst:AddTag("hide_percentage")
    end

    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BACK or EQUIPSLOTS.BODY
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("kuijiang_armor", fn, assets)
