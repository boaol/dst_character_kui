
local assets=
{
	Asset("ANIM", "anim/kuijiang_hat.zip"),  --动画文件
	Asset("IMAGE", "images/inventoryimages/kuijiang_hat.tex"), --物品栏贴图
	Asset("ATLAS", "images/inventoryimages/kuijiang_hat.xml"),
}

--要求防御80%，无限耐久，可回复精神200点。

local prefabs =
{
}

local function onequiphat(inst, owner) --装备的函数
if inst.kuijiang_Allshared then
if owner.prefab == "kuijiang" then
    owner.AnimState:OverrideSymbol("swap_hat", "maozi", "swap_hat")--替换的动画部件 使用的动画  第三个和第一个一样
    owner.AnimState:Show("HAT")
    owner.AnimState:Show("HAT_HAIR")
    owner.AnimState:Hide("HAIR_NOHAT")
    owner.AnimState:Hide("HAIR")
        
    if owner:HasTag("player") then --隐藏头发或者显示头发
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
		talker:Say("我不能使用它")
	end
		end)
end
else
	owner.AnimState:OverrideSymbol("swap_hat", "maozi", "swap_hat")--替换的动画部件 使用的动画  第三个和第一个一样
    owner.AnimState:Show("HAT")
    owner.AnimState:Show("HAT_HAIR")
    owner.AnimState:Hide("HAIR_NOHAT")
    owner.AnimState:Hide("HAIR")
        
    if owner:HasTag("player") then --隐藏头发或者显示头发
            owner.AnimState:Hide("HEAD")
            owner.AnimState:Show("HEAD_HAT")
    end
end
end

local function onunequiphat(inst, owner) --解除帽子
    owner.AnimState:Hide("HAT")
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

    inst.AnimState:SetBank("maozi")  --地上动画
    inst.AnimState:SetBuild("maozi")
    inst.AnimState:PlayAnimation("anim")

	inst:AddTag("hat")
	inst:AddTag("hide")
	-- inst:AddTag("waterproofer") --想防水把这个加上
    	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
    inst:AddComponent("inspectable")
	-- inst:AddComponent("waterproofer")--如果你想防水把这个加上
		
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/kuijiang_hat.xml"
	
	inst:AddComponent("equippable")
	inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
	inst.components.equippable:SetOnEquip( onequiphat )
    inst.components.equippable:SetOnUnequip( onunequiphat )
	inst.components.equippable.dapperness = 200
    
    inst:AddComponent("tradable")
	
	MakeHauntableLaunchAndPerish(inst)
    return inst
end 
    
return Prefab( "kuijiang_hat", fn, assets, prefabs) 