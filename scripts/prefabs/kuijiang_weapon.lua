local assets =
{
    Asset("ANIM", "anim/kuijiang_weapon.zip"),  --地上的动画
    Asset("ANIM", "anim/swap_kuijiang_weapon.zip"), --手里的动画

	Asset("IMAGE", "images/inventoryimages/kuijiang_weapon_a.tex"),
	Asset("ATLAS", "images/inventoryimages/kuijiang_weapon_a.xml"),
	
	Asset("IMAGE", "images/inventoryimages/kuijiang_weapon_b.tex"),
	Asset("ATLAS", "images/inventoryimages/kuijiang_weapon_b.xml"),
	
	Asset("IMAGE", "images/inventoryimages/kuijiang_weapon_c.tex"),
	Asset("ATLAS", "images/inventoryimages/kuijiang_weapon_c.xml")
}

local function kuijiang_weapon_light()
    local inst = CreateEntity()	

    inst.entity:AddTransform()	
    inst.entity:AddLight()		
    inst.entity:AddNetwork()	

    inst:AddTag("FX")

    inst.Light:SetIntensity(0.9)
    inst.Light:SetRadius(5)
    inst.Light:SetFalloff(1)
    inst.Light:SetColour(80/128, 240/255, 180/128,1)		--设置发光颜色

    inst.entity:SetPristine()	--设置原始

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false	--我忘了这是干啥的

    return inst
end

local function weapon_lighton(inst, owner)
    if inst._light == nil or not inst._light:IsValid() then
        inst._light = SpawnPrefab("kuijiang_weapon_light")
    end
    if owner ~= nil then
        inst._light.entity:SetParent(owner.entity)
    end
end


local function weapon_lightoff(inst)
    if inst._light ~= nil then
            if inst._light:IsValid() then
                inst._light:Remove()
            end
            inst._light = nil
        end
end

local function onequip(inst, owner) --装备
if inst.kuijiang_Allshared then
	if owner.prefab == "kuijiang" then
    owner.AnimState:OverrideSymbol("swap_object", "swap_wuqi", "swap_wuqi")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
	if inst.kuijiang_weaponlight then
	weapon_lighton(inst, owner)
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
	owner.AnimState:OverrideSymbol("swap_object", "swap_wuqi", "swap_wuqi")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
	if inst.kuijiang_weaponlight then
	weapon_lighton(inst, owner)
	end
	end
end

local function onunequip(inst, owner) --解除装备
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
	if inst.kuijiang_weaponlight then
	weapon_lightoff(inst, owner)
	end
end

local function SpawnIceFx(inst, target)
    if not inst then return end
    if not target then return end
	
    inst.SoundEmitter:PlaySound("dontstarve/creatures/deerclops/swipe")
    
    local numFX = math.random(15,20)
    local pos = inst:GetPosition()
    local targetPos = target:GetPosition()
    local vec = targetPos - pos
    vec = vec:Normalize()
    local dist = pos:Dist(targetPos)
    local angle = inst:GetAngleToPoint(targetPos:Get())

    for i = 1, numFX do
        inst:DoTaskInTime(math.random() * 0.25, function(inst)
            local prefab = "icespike_fx_"..math.random(1,4)
            local fx = SpawnPrefab(prefab)
            if fx then
                local x = GetRandomWithVariance(0, 2)
                local z = GetRandomWithVariance(0, 2)
                local offset = (vec * math.random(dist * 0.25, dist)) + Vector3(x,0,z)
                fx.Transform:SetPosition((offset+pos):Get())
                local x,y,z = fx.Transform:GetWorldPosition()
                local r = 1.5
                local dmg = math.random() * 50 * 1
                local ents = TheSim:FindEntities(x,y,z,r)
                for k, v in pairs(ents) do
				if v and v.components.health and not v.components.health:IsDead() and v.components.combat and
					v ~= inst and
                not (v.components.follower and v.components.follower.leader == inst) and 
                (TheNet:GetPVPEnabled() or not v:HasTag("player"))
                then
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
		SpawnIceFx(attacker, target)--发动范围技能
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

local function kuijiang_weapon_a()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("wuqi")  --地上动画
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
	
	inst:AddComponent("tool")
    inst.components.tool:SetAction(ACTIONS.MINE, 2)
    inst.components.tool:SetAction(ACTIONS.CHOP, 4)

    inst:AddComponent("inspectable") --可检查组件

    inst:AddComponent("inventoryitem") --物品组件
	inst.components.inventoryitem.atlasname = "images/inventoryimages/kuijiang_weapon_a.xml" --物品贴图
	
    inst:AddComponent("equippable") --可装备组件
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
	inst.components.equippable.walkspeedmult = TUNING.kuijiangWeaponSpeed

    MakeHauntableLaunch(inst)

    return inst
end

local function kuijiang_weapon_b()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("wuqi")  --地上动画
    inst.AnimState:SetBuild("wuqi")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("sharp")
    inst:AddTag("pointy")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	-- inst.components.weapon:SetOnAttack(onattack)
	
	inst:AddComponent("tool")
    inst.components.tool:SetAction(ACTIONS.MINE, 2)
    inst.components.tool:SetAction(ACTIONS.CHOP, 4)
	
	inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(TUNING.kuijiangWeaponDamage)
	inst.components.weapon:SetRange(TUNING.kuijiangWeaponRange, TUNING.kuijiangWeaponRange)
	inst.components.weapon:SetOnAttack(onattack_old)

    inst:AddComponent("inspectable") --可检查组件

    inst:AddComponent("inventoryitem") --物品组件
	inst.components.inventoryitem.atlasname = "images/inventoryimages/kuijiang_weapon_b.xml" --物品贴图
	
    inst:AddComponent("equippable") --可装备组件
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
	inst.components.equippable.walkspeedmult = TUNING.kuijiangWeaponSpeed

    MakeHauntableLaunch(inst)

    return inst
end

local function kuijiang_weapon_c()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("wuqi")  --地上动画
    inst.AnimState:SetBuild("wuqi")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("sharp")
    inst:AddTag("pointy")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	-- inst.components.weapon:SetOnAttack(onattack)
	
	inst:AddComponent("tool")
    inst.components.tool:SetAction(ACTIONS.MINE, 2)
    inst.components.tool:SetAction(ACTIONS.CHOP, 4)
	
	inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(TUNING.kuijiangWeaponDamage)
	inst.components.weapon:SetRange(TUNING.kuijiangWeaponRange, TUNING.kuijiangWeaponRange)
	inst.components.weapon:SetOnAttack(onattack)

    inst:AddComponent("inspectable") --可检查组件

    inst:AddComponent("inventoryitem") --物品组件
	inst.components.inventoryitem.atlasname = "images/inventoryimages/kuijiang_weapon_c.xml" --物品贴图
	
    inst:AddComponent("equippable") --可装备组件
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
	inst.components.equippable.walkspeedmult = TUNING.kuijiangWeaponSpeed

    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("kuijiang_weapon_a", kuijiang_weapon_a, assets),
	   Prefab("kuijiang_weapon_b", kuijiang_weapon_b, assets),
	   Prefab("kuijiang_weapon_c", kuijiang_weapon_c, assets),
	   Prefab("kuijiang_weapon_light",kuijiang_weapon_light)