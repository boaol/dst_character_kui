local MakePlayerCharacter = require "prefabs/player_common"

local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua")
}
local prefabs = {}

local start_inv = {}

local function onbecamehuman(inst)
    inst.components.locomotor:SetExternalSpeedMultiplier(inst, "kuijiang_speed_mod", 1.2)
end
local function onbecameghost(inst)
    inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "kuijiang_speed_mod")
end

-- get called when reload game or a player respawn
local function onload(inst)
    inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman)
    inst:ListenForEvent("ms_becameghost", onbecameghost)

    if inst:HasTag("playerghost") then
        onbecameghost(inst)
    else
        onbecamehuman(inst)
    end
end

local common_postinit = function(inst)
    -- Minimap icon
    inst:AddTag("kuijiang")
    inst.MiniMapEntity:SetIcon("kuijiang.tex")
end

local master_postinit = function(inst)
    -- soundsname
    inst.soundsname = "wendy"

    inst.components.health:SetMaxHealth(TUNING.KUIJIANG_HEALTH)
    inst.components.hunger:SetMax(TUNING.KUIJIANG_SANITY)
    inst.components.sanity:SetMax(TUNING.KUIJIANG_HUNGER)

    -- damagemultiplier
    inst.components.combat.damagemultiplier = 1.1

    -- hungerrate
    inst.components.hunger.hungerrate = 1 * TUNING.WILSON_HUNGER_RATE

    inst.OnLoad = onload
    inst.OnNewSpawn = onload

end

return MakePlayerCharacter("kuijiang", prefabs, assets, common_postinit, master_postinit, start_inv)
