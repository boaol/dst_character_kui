local require = GLOBAL.require
local containers = require("containers")

local function newcontainer()
local params = {}
params.kuijiang_armor =
{
        widget =
        {
            slotpos = {},
            animbank = "ui_kuijiang",
            animbuild = "ui_kuijiang",
            pos = GLOBAL.Vector3(-5, -70, 0),
            side_align_tip = 160,
        },
		 issidewidget = true,
			type = "kuijiang_armor",
    }
for y = -0.5, 7.5 do
    table.insert(params.kuijiang_armor.widget.slotpos, GLOBAL.Vector3(-162, -75 * y + 170, 0))
    table.insert(params.kuijiang_armor.widget.slotpos, GLOBAL.Vector3(-162 + 75, -75 * y + 170, 0))
end
--注册
local containers = require "containers"
for k, v in pairs(params) do
    containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, v.widget.slotpos ~= nil and #v.widget.slotpos or 0)
end
local oldwidgetsetup = containers.widgetsetup
	function containers.widgetsetup(container, prefab, data,...)
		local pref = prefab or container.inst.prefab
		if pref == "kuijiang_armor" then
			local t = params[pref]
			if t ~= nil then
				for k, v in pairs(t) do
					container[k] = v
				end
			container:SetNumSlots(container.widget.slotpos ~= nil and #container.widget.slotpos or 0)
			end
		else
		return oldwidgetsetup(container, prefab, data,...)
		end
	end
end
newcontainer()